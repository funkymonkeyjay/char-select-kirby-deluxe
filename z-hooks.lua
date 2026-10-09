if incompatibilityCond then return 0 end

-- KIRBY VARS --
for i = 0, (MAX_PLAYERS - 1) do
	gPlayerSyncTable[i].hasAddedHatFromKirby_JJJ = false
	
	gPlayerSyncTable[i].kirbyFallTimer_JJJ = 0
	gPlayerSyncTable[i].kirbyPuffCeiling_JJJ = 0
	gPlayerSyncTable[i].kirbyHasMovedStick_JJJ = false
	gPlayerSyncTable[i].kirbyForwardVel = 0
	gPlayerSyncTable[i].kirbyVelX = 0
	gPlayerSyncTable[i].kirbyVelY = 0
	gPlayerSyncTable[i].kirbyVelZ = 0
	gPlayerSyncTable[i].kirbyPuffTimer_JJJ = 0
	gPlayerSyncTable[i].kirbyHasPuffed_JJJ = false
	gPlayerSyncTable[i].kirbyDodgeStick = false
	gPlayerSyncTable[i].kirbyDodgeX = 0
	gPlayerSyncTable[i].kirbyDodgeY = 0
	
	gPlayerSyncTable[i].kirbyMouthCounter_JJJ = 0 -- How many objects in Kirby's mouth?
	
	gPlayerSyncTable[i].kirbyScaleY = 1000
	gPlayerSyncTable[i].kirbyMouthState = 0
	gPlayerSyncTable[i].kirbySplineFrame = 0
end

if charSelect then
	
	hook_event(HOOK_BEFORE_SET_MARIO_ACTION, function (m, incomingAction)
		if m.action == ACT_BEING_INHALED and incomingAction ~= ACT_GRABBED and (m.marioObj.header.gfx.node.flags & GRAPH_RENDER_ACTIVE) == 0 then -- Fix to prevent inhaled player from being unvisible when preforming other actions while in the inhaled action.
			m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags | GRAPH_RENDER_ACTIVE
			local mOther = gMarioStates[network_local_index_from_global(m.marioObj.oKirbySuckPlayer)]
			gPlayerSyncTable[mOther.playerIndex].kirbyMouthCounter_JJJ = 0
			play_character_sound(mOther, CHAR_SOUND_PUNCH_HOO)
		end

		-- Global scaling stuff, meant to work even without movesets.
		local idx = m.playerIndex
		local currChar = charSelect.character_get_current_number(idx)
		if (currChar == kirbyCharID or currChar == dededeCharID) then
			local dededeMult = currChar == dededeCharID and 0.75 or 1
			if incomingAction == ACT_JUMP or incomingAction == ACT_DOUBLE_JUMP or incomingAction == ACT_TRIPLE_JUMP then gPlayerSyncTable[idx].kirbyScaleY = 1000; m.marioObj.header.gfx.scale.y = 1 end
			if incomingAction == ACT_START_CROUCHING or incomingAction == ACT_CROUCH_SLIDE then gPlayerSyncTable[idx].kirbyScaleY = 2500 * dededeMult; m.marioObj.header.gfx.scale.y = 2.5 * dededeMult end
		end
	end)
	
	local function kirbyBeforeActions(m, incomingAction)
		local idx = m.playerIndex
		local floorObjectVel = (m.floor and m.floor.object and m.floor.object.oForwardVel) or 0

		local currChar = charSelect.character_get_current_number(idx)
		if currChar ~= dededeCharID then
			local hR = call_kirby_copy_hook(m.playerIndex, HOOK_BEFORE_SET_MARIO_ACTION, m, incomingAction)
			if hR ~= nil then
				return hR
			end
		end

		if incomingAction == ACT_JUMBO_STAR_CUTSCENE then return ACT_KIRBY_JUMBO_STAR end
		if (incomingAction == ACT_CROUCHING or incomingAction == ACT_CROUCH_SLIDE or incomingAction == ACT_PULLING_DOOR or incomingAction == ACT_PUSHING_DOOR) and gPlayerSyncTable[idx].kirbyMouthCounter_JJJ < 0 then
			return 1
		end
		
		--local dededeMult = currChar == dededeCharID and 0.75 or 1
		--if incomingAction == ACT_JUMP or incomingAction == ACT_KIRBY_PUFF or incomingAction == ACT_KIRBY_DODGE then gPlayerSyncTable[idx].kirbyScaleY = 1000; m.marioObj.header.gfx.scale.y = 1 end
		--if incomingAction == ACT_START_CROUCHING or incomingAction == ACT_CROUCH_SLIDE then gPlayerSyncTable[idx].kirbyScaleY = 2500 * dededeMult; m.marioObj.header.gfx.scale.y = 2.5 * dededeMult end
		
		if incomingAction == ACT_AIR_HIT_WALL or incomingAction == ACT_SOFT_BONK then
			mario_set_forward_vel(m, 0.0)
			if m.action == ACT_LONG_JUMP then
				play_character_sound(m, CHAR_SOUND_UH)
				play_kirby_sound(KIRBY_LAND_SOUND, m.pos, 1)
				mario_set_forward_vel(m, -20)
				m.vel.y = 20
				return ACT_FREEFALL
			else
				return 1
			end
		end
		
		if m.action == ACT_KIRBY_INHALE then
			audio_sample_stop(KIRBY_INHALE_SOUND)
		end
		
		if incomingAction == ACT_JUMP_KICK and m.action == ACT_KIRBY_PUFF then
			if m.playerIndex == 0 then
				spawn_sync_object(id_bhvKirbyAir_JJJ, E_MODEL_KIRBY_AIR, m.pos.x, m.pos.y + 50, m.pos.z, function(o)
					o.oMoveAngleYaw = m.faceAngle.y
					o.oForwardVel = m.forwardVel + floorObjectVel + 64
				end)
			end
		end
		
		if incomingAction == ACT_PUTTING_ON_CAP then
			if m.action == ACT_READING_NPC_DIALOG then
				return ACT_IDLE
			else
				m.marioObj.header.gfx.angle.y = m.area.camera.yaw
				m.faceAngle.y = m.marioObj.header.gfx.angle.y
				return ACT_KIRBY_POWERUP
			end
		end
		
		if incomingAction == ACT_BACKWARD_GROUND_KB and m.action == ACT_SLIDE_KICK_SLIDE then
			return ACT_FORWARD_ROLLOUT
		end
		
		if incomingAction == ACT_LEDGE_GRAB or incomingAction == ACT_LEDGE_CLIMB_DOWN then
			if incomingAction == ACT_LEDGE_CLIMB_DOWN then 
				m.faceAngle.y = m.faceAngle.y + degrees_to_sm64(180) 
				m.vel.y = 0
				return ACT_FREEFALL
			else
				m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
				m.forwardVel = 0
				return ACT_FORWARD_ROLLOUT
			end
		end
		
		if incomingAction == ACT_WALL_KICK_AIR then
			if (m.action & ACT_FLAG_ON_POLE) == 0 then
				m.faceAngle.y = m.faceAngle.y + degrees_to_sm64(180)
				return 1
			else
				m.forwardVel = 32
				gPlayerSyncTable[idx].kirbyScaleY = 1000; m.marioObj.header.gfx.scale.y = 1
				return ACT_JUMP
			end
		end

		if incomingAction == ACT_START_CRAWLING and m.action == ACT_CROUCHING then
			if not gPlayerSyncTable[idx].kirbyDodgeStick then
				m.vel.y = 32
				if m.forwardVel < 64 then m.forwardVel = 64 end
				gPlayerSyncTable[idx].kirbyDodgeStick = true
				play_character_sound(m, CHAR_SOUND_HAHA_2)
				return ACT_KIRBY_DODGE
			else
				return 1
			end
		end
		
		if incomingAction ~= ACT_PICKING_UP and (incomingAction == ACT_DIVE or (incomingAction == ACT_PUNCHING and m.action ~= ACT_CROUCHING) or incomingAction == ACT_MOVE_PUNCHING or (incomingAction == ACT_JUMP_KICK and m.action ~= ACT_KIRBY_PUFF)) or incomingAction == ACT_WATER_PUNCH then
			if gPlayerSyncTable[idx].kirbyMouthCounter_JJJ ~= 0	then
				m.forwardVel = 0
				if m.playerIndex == 0 and gPlayerSyncTable[idx].kirbyMouthCounter_JJJ > 0 then
					local pitch = (m.action & ACT_FLAG_SWIMMING) ~= 0 and m.faceAngle.x or 0
					spawn_sync_object(id_bhvKirbyStar_JJJ, E_MODEL_KIRBY_STAR, m.pos.x, m.pos.y, m.pos.z, function(o)
						o.oMoveAnglePitch = pitch
						o.oMoveAngleYaw = m.faceAngle.y
						o.oBehParams = math.min(gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ, 4)
						o.oForwardVel = m.forwardVel + floorObjectVel + 48
						o.parentObj = m.marioObj
					end)
				end
				gPlayerSyncTable[idx].kirbyMouthCounter_JJJ = 0
				if incomingAction ~= ACT_WATER_PUNCH then
					m.vel.y = 24
					return ACT_JUMP_KICK
				end
			elseif incomingAction ~= ACT_WATER_PUNCH then
				if m.pos.y == m.floorHeight then m.vel.y = 0 end
				--if m.playerIndex == 0 then spawn_non_sync_object(id_bhvKirbyInhale_JJJ, E_MODEL_KIRBY_VORTEX, m.pos.x, m.pos.y + 25, m.pos.z, function(o) o.parentObj = m.marioObj end) end
				return ACT_KIRBY_INHALE
			end
		end

		if ((m.action == ACT_START_CROUCHING or m.action == ACT_CROUCHING or m.action == ACT_STOP_CROUCHING) and incomingAction == ACT_BACKFLIP) or
			incomingAction == ACT_LONG_JUMP or (incomingAction == ACT_FORWARD_ROLLOUT and m.action ~= ACT_KIRBY_DODGE) or incomingAction == ACT_BACKWARD_ROLLOUT or incomingAction == ACT_DOUBLE_JUMP or incomingAction == ACT_TRIPLE_JUMP or incomingAction == ACT_SIDE_FLIP then
			--(incomingAction == ACT_FORWARD_ROLLOUT and m.action ~= ACT_KIRBY_DODGE) or incomingAction == ACT_BACKWARD_ROLLOUT or incomingAction == ACT_DOUBLE_JUMP or incomingAction == ACT_TRIPLE_JUMP or incomingAction == ACT_SIDE_FLIP then
			gPlayerSyncTable[idx].kirbyScaleY = 1000; m.marioObj.header.gfx.scale.y = 1
			return ACT_JUMP
		end

		if gPlayerSyncTable[idx].kirbyFallTimer_JJJ > 40 and m.action == ACT_VERTICAL_WIND and incomingAction == ACT_DIVE_SLIDE then
			for i = 1, 3 do
				spawn_non_sync_object(id_bhvPoundTinyStarParticle, E_MODEL_CARTOON_STAR, m.pos.x, m.pos.y, m.pos.z, function (o) 
					o.oMoveAngleYaw = (i * 65536) / 3;
				end)
			end
			gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0
			return ACT_FORWARD_ROLLOUT
		end
	end
	
	local function kirbyActions(m)
		if m.action == ACT_PUNCHING and m.prevAction == ACT_CROUCHING then
			set_mario_action(m, ACT_SLIDE_KICK, 0)
			return
		end
		if m.action == ACT_SLIDE_KICK then
			play_kirby_sound(KIRBY_SLIDE_SOUND, m.pos, 1)
			set_mario_action(m, ACT_KIRBY_SLIDE, 0)
			m.vel.y = 0
			if m.forwardVel < 64 then m.forwardVel = 64 end
			return
		end
	end
	
	local function checkFlags(m)
		local prohibitedFlags = {
			ACT_FLAG_SWIMMING, 
			ACT_FLAG_METAL_WATER, 
			ACT_FLAG_INTANGIBLE, 
			ACT_FLAG_INVULNERABLE, 
			ACT_FLAG_ON_POLE, 
			ACT_FLAG_WATER_OR_TEXT, 
			ACT_FLAG_BUTT_OR_STOMACH_SLIDE, 
			ACT_FLAG_HANGING, 
		}
		for i = 1, #prohibitedFlags do
			if (m.action & prohibitedFlags[i]) ~= 0 then
				return false
			end
		end
		return true
	end
	
	local prevPowerup = 0
	local function kirbyPostUpdate(m)
		local idx = m.playerIndex
		
		if m.playerIndex ~= 0 then return end

		local currChar = charSelect.character_get_current_number(idx)
		if currChar ~= dededeCharID then
			-- Debug Api
			if m.controller.buttonPressed & D_JPAD ~= 0 then
				gPlayerSyncTable[0].kirbyCopyAbility_JJJ = 4
			end

			if prevPowerup ~= gPlayerSyncTable[0].kirbyCopyAbility_JJJ then
				if gPlayerSyncTable[0].kirbyCopyAbility_JJJ ~= 0 then
					set_mario_action(m, ACT_PUTTING_ON_CAP, 0)
				end
				prevPowerup = gPlayerSyncTable[0].kirbyCopyAbility_JJJ
			end

			m.capTimer = 0
			m.flags = m.flags & ~(MARIO_WING_CAP | MARIO_METAL_CAP | MARIO_VANISH_CAP)
			local hR = call_kirby_copy_hook(idx, HOOK_MARIO_UPDATE, m)
			if hR ~= nil then
				return hR
			end
			
			if checkFlags(m) and (m.controller.buttonPressed & L_TRIG) ~= 0 and m.action ~= ACT_KIRBY_HELLO and m.pos.y == m.floorHeight and m.forwardVel == 0 then
				set_mario_action(m, ACT_KIRBY_HELLO, 0)
			end

			if (m.controller.buttonPressed & X_BUTTON) ~= 0 and gPlayerSyncTable[0].kirbyCopyAbility_JJJ ~= 0 then -- Alternative/Traditional way of getting rid of a copy ability.
				-- TODO: Spawn Copy Ability Essence
				gPlayerSyncTable[m.playerIndex].kirbyCopyAbility_JJJ = 0
			end
		end

		if (m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE) and (m.controller.stickX == 0 and m.controller.stickY == 0) then
			gPlayerSyncTable[idx].kirbyDodgeStick = false
		end
		
		if ((m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE) or (m.action & ACT_GROUP_MASK) == ACT_GROUP_CUTSCENE) and gPlayerSyncTable[idx].kirbyMouthCounter_JJJ > 0 then -- Eat the contents
			play_character_sound(m, CHAR_SOUND_PUNCH_WAH)
			if not (m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE) then
				m.marioObj.header.gfx.scale.y = 0.75
			end
			gPlayerSyncTable[idx].kirbyMouthCounter_JJJ = 0
		end
	
		if (m.action & ACT_FLAG_INTANGIBLE) ~= 0 or (m.action & ACT_FLAG_INVULNERABLE) ~= 0 then
			gPlayerSyncTable[idx].kirbyHasPuffed_JJJ = false -- Added just in case Kirby's puffing gets interrupted, be it by attack.
			gPlayerSyncTable[idx].kirbyPuffTimer_JJJ = 0
			return
		end
		
		if m.action == ACT_SLIDE_KICK and m.vel.y < 0 then
			m.vel.y = 0
		end
		
		if m.action ~= ACT_KIRBY_PUFF and ((m.action & ACT_FLAG_SWIMMING) ~= 0 or m.action == ACT_TWIRLING or m.pos.y == m.floorHeight) then
			gPlayerSyncTable[idx].kirbyPuffCeiling_JJJ = m.marioObj.header.gfx.pos.y + 1100
		end
		
		if m.pos.y ~= m.floorHeight and gPlayerSyncTable[idx].kirbyMouthCounter_JJJ == 0 and (m.action & ACT_FLAG_SWIMMING) == 0 and (m.action & ACT_FLAG_METAL_WATER) == 0 
			and m.action ~= ACT_SOFT_BONK and m.action ~= ACT_TOP_OF_POLE_JUMP and m.action ~= ACT_KIRBY_PUFF and m.action ~= ACT_FLYING_TRIPLE_JUMP and m.action ~= ACT_FLYING and m.action ~= ACT_SHOT_FROM_CANNON and m.action ~= ACT_WATER_JUMP 
			and m.action ~= ACT_START_HANGING and m.action ~= ACT_HANGING and m.action ~= ACT_HANG_MOVING and m.action ~= ACT_BUBBLED and m.action ~= ACT_KIRBY_INHALE and not (m.action == ACT_LONG_JUMP and m.forwardVel < 0) and m.heldObj == nil then
			gPlayerSyncTable[idx].kirbyFallTimer_JJJ = gPlayerSyncTable[idx].kirbyFallTimer_JJJ + 1
			if gPlayerSyncTable[idx].kirbyFallTimer_JJJ > 40 and (m.action == ACT_JUMP or m.action == ACT_FREEFALL or m.action == ACT_JUMP_KICK or m.action == ACT_TOP_OF_POLE_JUMP) and m.vel.y < 0 then
				m.marioObj.header.gfx.animInfo.animID = -1
				set_mario_action(m, ACT_VERTICAL_WIND, 0)
				set_mario_animation(m, MARIO_ANIM_AIRBORNE_ON_STOMACH)
				m.flags = (m.flags | MARIO_MARIO_SOUND_PLAYED) & ~MARIO_KICKING
				m.actionState = 1
			end
			if gPlayerSyncTable[idx].kirbyHasPuffed_JJJ and gPlayerSyncTable[idx].kirbyFallTimer_JJJ >= 10 and m.pos.y < gPlayerSyncTable[idx].kirbyPuffCeiling_JJJ and gPlayerSyncTable[idx].kirbyPuffTimer_JJJ < PUFF_TIMER_LIMIT then
				gPlayerSyncTable[idx].kirbyHasPuffed_JJJ = false
			end
			if (m.input & INPUT_A_PRESSED) ~= 0 and gPlayerSyncTable[idx].kirbyFallTimer_JJJ >= 2 then
				--if gPlayerSyncTable[idx].kirbyCopyAbility_JJJ == KIRBY_COPY_ANGEL then -- hard code because i'm lazy
					--if m.action ~= ACT_GROUND_POUND then
						--spawn_mist_particles_variable(20, -20, 10)
						--play_sound(SOUND_ACTION_TWIRL, m.marioObj.header.gfx.cameraToObject)
						--set_mario_action(m, ACT_FLYING_TRIPLE_JUMP, 0)
						--m.angleVel.x = 0
						--m.vel.y = 64
					--end
				if not gPlayerSyncTable[idx].kirbyHasPuffed_JJJ then
					play_character_sound(m, CHAR_SOUND_HOOHOO)
					gPlayerSyncTable[idx].kirbyHasMovedStick_JJJ = false
					m.vel.y = 16
					set_mario_action(m, ACT_KIRBY_PUFF, 0)
					set_mario_animation(m, CHAR_ANIM_KIRBY_PUFF_RISE)
				end
			end
		else
			gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0
			if m.pos.y == m.floorHeight or (m.action & ACT_FLAG_SWIMMING) ~= 0 then
				gPlayerSyncTable[idx].kirbyHasPuffed_JJJ = false
				gPlayerSyncTable[idx].kirbyPuffTimer_JJJ = 0
			end
		end
		
		if m.action == ACT_JUMP or (m.action == ACT_JUMP_KICK and m.marioObj.header.gfx.animInfo.animFrame >= 8) or m.action == ACT_FREEFALL then -- Air turning!
			m.faceAngle.y = approach_s16_symmetric(m.faceAngle.y, m.intendedYaw, gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ ~= 0 and 1000 or 1750)
		
			m.vel.x = m.forwardVel * sins(m.faceAngle.y)
			m.vel.z = m.forwardVel * coss(m.faceAngle.y)
		end
	end
	
	local function kirbyPreUpdate(m)
		local idx = m.playerIndex
		
		if idx ~= 0 then return end
		
		if m.action == ACT_CROUCH_SLIDE and (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
			if m.prevAction == ACT_WALKING and m.actionArg == 0 then
				m.actionArg = 1
				gPlayerSyncTable[idx].kirbyDodgeStick = true
			elseif not gPlayerSyncTable[idx].kirbyDodgeStick then
				m.vel.y = 32
				if m.forwardVel < 64 then m.forwardVel = 64 end
				gPlayerSyncTable[idx].kirbyDodgeStick = true
				play_character_sound(m, CHAR_SOUND_HAHA_2)
				set_mario_action(m, ACT_KIRBY_DODGE, 0)
			end
		end
		
		if m.action == ACT_PUTTING_ON_CAP or (m.action == ACT_JUMP and m.actionArg == 1 and m.vel.y > 0 and charSelect.character_get_current_number(0) == kirbyCharID) then
			m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		end
		
		m.peakHeight = m.pos.y -- Disables fall damage.

		if m.action ~= ACT_KIRBY_PUFF and m.action ~= ACT_KIRBY_DODGE then
			gPlayerSyncTable[idx].kirbyForwardVel = m.forwardVel
		end
		
		gPlayerSyncTable[idx].kirbyVelX = m.vel.x
		gPlayerSyncTable[idx].kirbyVelY = m.vel.y
		gPlayerSyncTable[idx].kirbyVelZ = m.vel.z
	end
	
	charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_INTERACT, function(m) local idx = m.playerIndex; gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0 end)
	charSelect.character_hook_moveset(dededeCharID, HOOK_ON_INTERACT, function(m) local idx = m.playerIndex; gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0 end)
	
	hook_event(HOOK_ON_PLAY_SOUND, function (soundBits, pos)
		for i = 0, MAX_PLAYERS - 1 do
			local m = gMarioStates[i]
			local currChar = charSelect.character_get_current_number(m.playerIndex)
			local checkPos = pos.x == m.marioObj.header.gfx.cameraToObject.x and pos.y == m.marioObj.header.gfx.cameraToObject.y and pos.z == m.marioObj.header.gfx.cameraToObject.z -- Shoutouts to "EmilyEmmi" for giving me advice on how to accomplish step sounds!
			if checkPos and (currChar == kirbyCharID or currChar == dededeCharID) then
				if soundBits == SOUND_ACTION_BONK and m.action ~= ACT_SLIDE_KICK_SLIDE then -- Avoid sounds during bonk cancellation.
					return NO_SOUND
				elseif soundBits == SOUND_ACTION_TERRAIN_STEP or soundBits == SOUND_ACTION_TERRAIN_STEP + m.terrainSoundAddend or soundBits == SOUND_ACTION_TERRAIN_STEP_TIPTOE or soundBits == SOUND_ACTION_TERRAIN_STEP_TIPTOE + m.terrainSoundAddend then
					play_kirby_sound(KIRBY_STEP_SOUND, m.pos, 1)
					return NO_SOUND
				elseif soundBits == SOUND_ACTION_TERRAIN_LANDING or soundBits == SOUND_ACTION_TERRAIN_LANDING + m.terrainSoundAddend or soundBits == SOUND_ACTION_TERRAIN_BODY_HIT_GROUND or soundBits == SOUND_ACTION_TERRAIN_BODY_HIT_GROUND + m.terrainSoundAddend then
					play_kirby_sound(KIRBY_LAND_SOUND, m.pos, 1)
					return NO_SOUND
				elseif soundBits == SOUND_ACTION_TERRAIN_JUMP or soundBits == SOUND_ACTION_TERRAIN_JUMP + m.terrainSoundAddend or soundBits == SOUND_ACTION_METAL_JUMP then
					return NO_SOUND
				end
			end
		end
	end)
	
	hook_event(HOOK_MARIO_UPDATE, function (m)
		if m.playerIndex ~= 0 then return end
		
		local currChar = charSelect.character_get_current_number()
		if currChar == kirbyCharID then
			if gPlayerSyncTable[0].hasAddedHatFromKirby_JJJ and (m.flags & MARIO_CAP_ON_HEAD) == 0 then
				m.flags = MARIO_CAP_ON_HEAD | MARIO_NORMAL_CAP
				m.cap = MARIO_CAP_ON_HEAD
				gPlayerSyncTable[0].hasAddedHatFromKirby_JJJ = false
			end
		else
			gPlayerSyncTable[0].hasAddedHatFromKirby_JJJ = true
		end
	end)

	charSelect.character_hook_moveset(kirbyCharID, HOOK_CHARACTER_SOUND, function (m, sound)
		if sound == CHAR_SOUND_HERE_WE_GO and not (m.action == ACT_STAR_DANCE_EXIT or m.action == ACT_STAR_DANCE_NO_EXIT or m.action == ACT_STAR_DANCE_WATER) then
			if m.action == ACT_HOLDING_BOWSER then
				return CHAR_SOUND_SO_LONGA_BOWSER
			else
				return 0
			end
		end
	end)
	
	charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_INTERACT, function(m) local idx = m.playerIndex; gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0 end)
	charSelect.character_hook_moveset(dededeCharID, HOOK_ON_INTERACT, function(m) local idx = m.playerIndex; gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0 end)
	
	hook_event(HOOK_OBJECT_SET_MODEL, function (o, model, extendedModel, charNum) 
		local m = gMarioStates[0]
		local currChar = charSelect.character_get_current_number()
		if currChar == kirbyCharID then
			if obj_has_behavior_id(o, id_bhvNormalCap) ~= 0 and m.character.capModelId == model then
				obj_mark_for_deletion(o) -- DELETE NORMAL CAP!
				return
			elseif obj_has_behavior_id(o, id_bhvWingCap) ~= 0 or obj_has_behavior_id(o, id_bhvMetalCap) ~= 0 or obj_has_behavior_id(o, id_bhvVanishCap) ~= 0 then
				smlua_anim_util_set_animation(o, "ANIM_KIRBY_CAP_LOOP")
				obj_set_billboard(o)
			end
		end
	end)
	
	hook_event(HOOK_MARIO_UPDATE, function (m)
		local idx = m.playerIndex

		if m.action == ACT_KIRBY_INHALE and m.actionTimer <= 1 then
			spawn_sync_object(id_bhvKirbyInhale_JJJ, E_MODEL_KIRBY_VORTEX, m.pos.x, m.pos.y + 25, m.pos.z, function(o) o.parentObj = m.marioObj end)
		end

		local modelId = charSelect.character_get_current_number(idx)
		if modelId == kirbyCharID or modelId == dededeCharID then -- TODO: Is it possible to know whether or not a player has movesets disabled based on their m.playerIndex?
		
			if m.action ~= ACT_SQUISHED and m.action ~= ACT_BBH_ENTER_SPIN and m.squishTimer == 0 and ((m.marioObj.header.gfx.scale.x == 1 and m.marioObj.header.gfx.scale.z == 1) or (m.action == ACT_CROUCHING or m.action == ACT_START_CROUCHING or m.action == ACT_CROUCH_SLIDE)) then
				local currChar = charSelect.character_get_current_number(idx)
				local toScale = 1000

				if m.action == ACT_JUMP_LAND or m.action == ACT_FREEFALL_LAND then
					toScale = 500
				elseif m.action == ACT_START_CROUCHING or m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE or m.action == ACT_KIRBY_SLIDE or m.action == ACT_SLIDE_KICK_SLIDE or m.action == ACT_CROUCH_SLIDE or m.action == ACT_JUMP_LAND
					 or (m.action == ACT_EXIT_LAND_SAVE_DIALOG and (m.marioObj.header.gfx.animInfo.animFrame >= 28 and m.marioObj.header.gfx.animInfo.animFrame < 34)) or m.action == ACT_LONG_JUMP_LAND then
					toScale = 625
				elseif m.action == ACT_FORWARD_ROLLOUT then
					toScale = 900
				elseif (m.action == ACT_JUMP and m.vel.y > 0) or (m.action == ACT_KIRBY_PUFF and m.vel.y > 0) or m.action == ACT_KIRBY_DODGE then
					toScale = 1100 - (currChar == dededeCharID and 50 or 0)
				elseif m.action == ACT_KIRBY_INHALE or (m.action == ACT_EXIT_LAND_SAVE_DIALOG and m.marioObj.header.gfx.animInfo.animID ~= CHAR_ANIM_THROW_CATCH_KEY and (m.marioObj.header.gfx.animInfo.animFrame > 10 and m.marioObj.header.gfx.animInfo.animFrame < 28)) then
					toScale = 1200 - (currChar == dededeCharID and 100 or 0)
				elseif m.action == ACT_JUMP_KICK and m.marioObj.header.gfx.animInfo.animFrame < 2 then
					toScale = 1300 - (currChar == dededeCharID and 100 or 0)
				end
				
				local scaleSpeed = ((m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE) and 0.85) or ((m.pos.y == m.floorHeight or (m.action == ACT_KIRBY_DODGE and m.vel.y > 0)) and 0.4) or 0.05
				gPlayerSyncTable[idx].kirbyScaleY = math.lerp(gPlayerSyncTable[idx].kirbyScaleY, toScale, scaleSpeed)
				m.marioObj.header.gfx.scale.y = gPlayerSyncTable[idx].kirbyScaleY / 1000
				
				if m.action == ACT_START_CROUCHING then
					m.marioObj.header.gfx.scale.x = 0.75
					m.marioObj.header.gfx.scale.z = 0.75
				elseif m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE then
					m.marioObj.header.gfx.scale.x = math.lerp(m.marioObj.header.gfx.scale.x, 1.5, 0.85)
					m.marioObj.header.gfx.scale.z = math.lerp(m.marioObj.header.gfx.scale.z, 1.5, 0.85)
				end
			else
				gPlayerSyncTable[idx].kirbyScaleY = 1000
			end
		end
	end)

	charSelect.character_hook_moveset(kirbyCharID, HOOK_MARIO_UPDATE, kirbyPostUpdate)
	charSelect.character_hook_moveset(kirbyCharID, HOOK_BEFORE_MARIO_UPDATE, kirbyPreUpdate)
	charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_SET_MARIO_ACTION, kirbyActions)
	charSelect.character_hook_moveset(kirbyCharID, HOOK_BEFORE_SET_MARIO_ACTION, kirbyBeforeActions)

	charSelect.character_hook_moveset(dededeCharID, HOOK_MARIO_UPDATE, kirbyPostUpdate)
	charSelect.character_hook_moveset(dededeCharID, HOOK_BEFORE_MARIO_UPDATE, kirbyPreUpdate)
	charSelect.character_hook_moveset(dededeCharID, HOOK_ON_SET_MARIO_ACTION, kirbyActions)
	charSelect.character_hook_moveset(dededeCharID, HOOK_BEFORE_SET_MARIO_ACTION, kirbyBeforeActions)

	charSelect.character_hook_moveset(kirbyCharID, HOOK_BEFORE_PHYS_STEP, function (m, stepType)
		if m.action == ACT_WATER_JUMP or m.action == ACT_LONG_JUMP or m.action == ACT_BUBBLED or (m.action & ACT_FLAG_INVULNERABLE) ~= 0 or (m.action & ACT_FLAG_INTANGIBLE) ~= 0 then return end
	
		local hR = call_kirby_copy_hook(m.playerIndex, HOOK_BEFORE_PHYS_STEP, m, HOOK_BEFORE_PHYS_STEP)
		if hR ~= nil then
			return hR
		end

		--local hScale, vScale = (m.action & ACT_FLAG_MOVING) ~= 0 and 1.2 or 1.0, 1.0 -- Make Kirby 20% faster.
		local hScale, vScale = 1.0, 1.0
		
		if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ ~= 0 then
			if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
				m.pos.y = m.pos.y - 5.5
				if m.vel.y > 0 then
					vScale = vScale * 0.5
				end
				hScale = hScale * 0.6
			else
				if (m.action & ACT_FLAG_MOVING) ~= 0 then
					hScale = hScale * 0.75
				elseif m.action & ACT_FLAG_AIR ~= 0 and m.vel.y > 0 then
					vScale = vScale * 0.9375
				end
			end
		end
		
		m.vel.x = m.vel.x * hScale
		m.vel.y = m.vel.y * vScale
		m.vel.z = m.vel.z * hScale

	end)
	
	hook_event(HOOK_ALLOW_INTERACT, function (m, o, intType) -- Piece of code I found on "Coop Central" by "@.kristy.", originally from Sonic Rebooted which, before that, was from Pasta Castle.
		local p = gPlayerSyncTable[m.playerIndex]
		if m.action == ACT_KIRBY_INHALE then
			if (intType & (INTERACT_GRABBABLE) ~= 0) and o.oInteractionSubtype & (INT_SUBTYPE_NOT_GRABBABLE) == 0 and not (obj_has_behavior_id(o, id_bhvBobomb) ~= 0 or (obj_has_behavior_id(o, id_bhvUkiki) ~= 0 and o.oBehParams2ndByte == UKIKI_CAP)) then
				m.interactObj = o
				m.input = m.input | INPUT_INTERACT_OBJ_GRABBABLE
				if o.oSyncID ~= 0 then
					network_send_object(o, true)
				end
			end
		end

		if (m.action == ACT_KIRBY_GHOST) then
			if obj_has_behavior_id(o, id_bhvDoorWarp) ~= 0 then
				set_mario_action(m, ACT_DECELERATING, 0)
				interact_warp_door(m, 0, o)
			elseif obj_has_behavior_id(o, id_bhvDoor) ~= 0 or obj_has_behavior_id(o, id_bhvStarDoor) ~= 0 then
				set_mario_action(m, ACT_DECELERATING, 0)
				interact_door(m, 0, o)
			elseif obj_has_behavior_id(o, id_bhvWarp) ~= 0 then
				set_mario_action(m, ACT_DECELERATING, 0)
				interact_warp(m, 0, o)
			end
		end
		
		if m.playerIndex ~= 0 then
			return
		end
		
		local oUpdated = false
		local currChar = charSelect.character_get_current_number()
		
		if currChar == kirbyCharID then
			if not isMovesetOff() and get_mario_cap_flag(o) ~= 0 and (obj_has_behavior_id(o, id_bhvWingCap) ~= 0 or obj_has_behavior_id(o, id_bhvMetalCap) ~= 0 or obj_has_behavior_id(o, id_bhvVanishCap) ~= 0) then
				if obj_has_behavior_id(o, id_bhvWingCap) ~= 0 then
					p.kirbyCopyAbility_JJJ = KIRBY_COPY_ANGEL
					--m.flags = m.flags | MARIO_WING_CAP
				elseif obj_has_behavior_id(o, id_bhvMetalCap) ~= 0 then
					p.kirbyCopyAbility_JJJ = KIRBY_COPY_STEEL
					--m.flags = m.flags | MARIO_METAL_CAP
				elseif obj_has_behavior_id(o, id_bhvVanishCap) ~= 0 then
					p.kirbyCopyAbility_JJJ = KIRBY_COPY_GHOST
					--m.flags = m.flags | MARIO_VANISH_CAP
				end
				obj_mark_for_deletion(o)
				return false
			--else
				--m.flags = (m.flags | MARIO_CAP_ON_HEAD) & ~MARIO_CAP_IN_HAND
			end
		
			if (obj_has_behavior_id(o,id_bhvKlepto) ~= 0) and (m.cap == SAVE_FLAG_CAP_ON_KLEPTO) then
				m.cap = MARIO_CAP_ON_HEAD
				o.oAnimState = KLEPTO_ANIM_STATE_HOLDING_NOTHING
				o.oAction = KLEPTO_ACT_WAIT_FOR_MARIO
				oUpdated = true
			end
		end
		
		if oUpdated then
			network_send_object(o, true)
		end
	end)
	  	
	local function before_update(m) -- Code by Baconator2558, meant to use one idle animation instead of three.
		local currChar = charSelect.character_get_current_number(m.playerIndex)
		if currChar == kirbyCharID or currChar == dededeCharID then if (m.action == ACT_IDLE) then m.actionState = 0 end end
	end

	hook_event(HOOK_BEFORE_MARIO_UPDATE, before_update)
	
	hook_event(HOOK_ON_WARP, function (type, levelNum, areaIdx, nodeId, arg)	
		gPlayerSyncTable[0].kirbyFallTimer_JJJ = 0
		gPlayerSyncTable[0].kirbyPuffCeiling_JJJ = 0
		gPlayerSyncTable[0].kirbyHasMovedStick_JJJ = false
		gPlayerSyncTable[0].kirbyForwardVel = 0
		gPlayerSyncTable[0].kirbyVelX = 0
		gPlayerSyncTable[0].kirbyVelY = 0
		gPlayerSyncTable[0].kirbyVelZ = 0
		gPlayerSyncTable[0].kirbyPuffTimer_JJJ = 0
		gPlayerSyncTable[0].kirbyHasPuffed_JJJ = false
		gPlayerSyncTable[0].kirbyDodgeStick = false
		gPlayerSyncTable[0].kirbyDodgeX = 0
		gPlayerSyncTable[0].kirbyDodgeY = 0
		gPlayerSyncTable[0].kirbyMouthCounter_JJJ = 0
		gPlayerSyncTable[0].kirbyScaleY = 1000
		gPlayerSyncTable[0].kirbyMouthState = 0
		audio_sample_stop(KIRBY_INHALE_SOUND) -- Added to prevent the inhale sound from playing outside a level forever.
	end)
end

