if not _G.charSelectExists then return 0 end
local csVersion = _G.charSelect.version_get_full()
if csVersion.major < 16 then return 0 end
if VERSION_NUMBER < 40 then return 0 end

local E_MODEL_KIRBY_STAR = smlua_model_util_get_id("kirby_star_geo")
local E_MODEL_KIRBY_AIR = smlua_model_util_get_id("kirby_air_geo")
local E_MODEL_KIRBY_VORTEX = smlua_model_util_get_id("vortex_geo")
smlua_anim_util_register_animation('ANIM_KIRBY_STAR_LOOP', 0, 0, 0, 1, 40, { 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 65535, 65535, 65535, 
	65535, 65535, 65535, 65535, 65535, 65535, 0, 0, 65535, 
	65535, 65535, 65535, 65535, 65535, 65535, 65535, 0, 0, 
	63845, 62061, 60205, 58303, 56384, 54481, 52625, 50842, 49151, 
	47634, 46041, 44385, 42684, 40959, 39235, 37534, 35878, 34284, 
	32767, 31251, 29657, 28001, 26300, 24576, 22851, 21150, 19494, 
	17901, 16384, 14867, 13273, 11617, 9916, 8192, 6468, 4767, 
	3110, 1517, 0, 

},{ 
	1, 0, 1, 1, 1, 2, 40, 3, 10, 
	43, 40, 53, 

})

smlua_anim_util_register_animation('ANIM_KIRBY_CAP_LOOP', 256, 0, 0, 0, 40, { 
	0, 0, 0, 65535, 65535, 65535, 0, 65535, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 
	65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 
	0, 0, 65535, 0, 0, 0, 0, 0, 65535, 
	65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 
	65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 
	65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 
	65535, 65535, 65535, 65535, 0, 1517, 3110, 4767, 6468, 
	8192, 9916, 11617, 13273, 14867, 16384, 17901, 19494, 21150, 
	22851, 24576, 26300, 28001, 29657, 31251, 32767, 34284, 35878, 
	37534, 39235, 40959, 42684, 44385, 46041, 47634, 49151, 50668, 
	52262, 53918, 55619, 57343, 59067, 60768, 62425, 64018, 0, 
	

},{ 
	1, 0, 1, 1, 1, 2, 41, 3, 41, 
	44, 41, 85, 

});

if _G.charSelect then
	-- CUSTOM OBJECTS --
	
	-- INHALE PARTICLES
	
	local function bhv_kirby_particle_init(o)
		cur_obj_scale(2)
	end
	
	local function bhv_kirby_particle_loop(o)
		local oP = o.parentObj
		local OBJ_SPEED, SCALE_SPEED = 10, 0.25
		
		o.oPosX = approach_f32(o.oPosX, oP.oPosX, OBJ_SPEED, OBJ_SPEED)
		o.oPosY = approach_f32(o.oPosY, oP.oPosY, OBJ_SPEED, OBJ_SPEED)
		o.oPosZ = approach_f32(o.oPosZ, oP.oPosZ, OBJ_SPEED, OBJ_SPEED)
		
		o.header.gfx.scale.x = approach_f32(o.header.gfx.scale.x, 0, SCALE_SPEED, SCALE_SPEED)
		o.header.gfx.scale.y = approach_f32(o.header.gfx.scale.y, 0, SCALE_SPEED, SCALE_SPEED)
		o.header.gfx.scale.z = approach_f32(o.header.gfx.scale.z, 0, SCALE_SPEED, SCALE_SPEED)
		
		obj_update_gfx_pos_and_angle(o)
		
		if o.header.gfx.scale.x <= 0 and o.header.gfx.scale.y <= 0  and o.header.gfx.scale.z <= 0 then
			obj_mark_for_deletion(o)
		end
	end
	
	id_bhvKirbyInhaleParticle_JJJ = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_kirby_particle_init, bhv_kirby_particle_loop, "bhvKirbyInhaleParticle_JJJ")
	
	-- INHALE
	
	local function bhv_kirby_effect_init(o)
		cur_obj_scale(0)
		local m = get_mario_state_from_object(o.parentObj)
		if not m or m.playerIndex ~= 0 then
			obj_mark_for_deletion(o)
		end
	end
	
	local function bhv_kirby_effect_loop(o)
		local m = get_mario_state_from_object(o.parentObj)
		if not m then return end

		o.oPosX, o.oPosY, o.oPosZ = m.pos.x + sins(m.faceAngle.y) * 37.5, m.pos.y + 75, m.pos.z + coss(m.faceAngle.y) * 37.5
		
		local pitch, yaw, roll = o.oTimer * 7500, m.faceAngle.y + degrees_to_sm64(90), degrees_to_sm64(90)
		obj_set_gfx_angle(o, pitch, yaw, roll)
		obj_set_face_angle(o, pitch, yaw, roll)
		
		local horizontalScale = (math.min(4, o.oTimer) / 4) * 0.1875
		
		o.header.gfx.scale.x = horizontalScale
		o.header.gfx.scale.y = (math.min(8, o.oTimer) / 8) * 0.2
		o.header.gfx.scale.z = horizontalScale
		
		local PLAYER_ANGLE_LIMIT = degrees_to_sm64(25)
		local randomLimit = math.random(-PLAYER_ANGLE_LIMIT, PLAYER_ANGLE_LIMIT)
		local angleSpawn = m.faceAngle.y + randomLimit
		if o.oTimer % 6 == 0 and o.header.gfx.scale.y >= 0.2 then
			spawn_non_sync_object(id_bhvKirbyInhaleParticle_JJJ, E_MODEL_WHITE_PARTICLE_SMALL, o.oPosX + sins(angleSpawn) * math.random(30, 175), o.oPosY - 25 + sins(randomLimit) * math.random(0, 100), o.oPosZ + coss(angleSpawn) * math.random(30, 175), function (oP) 
				oP.parentObj = o
				obj_set_billboard(oP)
			end)
		end
		
		obj_update_gfx_pos_and_angle(o)
		
		if m.action ~= ACT_KIRBY_INHALE then
			obj_mark_for_deletion(o)
		end
	end
	
	id_bhvKirbyInhale_JJJ = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_kirby_effect_init, bhv_kirby_effect_loop, "bhvKirbyInhale_JJJ")
	
	-- STAR
	local function bhv_kirby_star_init(o)
		local m = get_mario_state_from_object(o.parentObj)
		if m then
			play_character_sound(m, CHAR_SOUND_PUNCH_YAH)
		end
		
		o.oFaceAngleRoll = 0
		o.oMoveAngleRoll = 0
		o.oBounciness = 0
		o.oDragStrength = 0
		o.oWallHitboxRadius = 60 * o.oBehParams
		
		o.oGravity = 0
		o.oFriction = 1
		o.oBuoyancy = 0
		o.oVelY = 0
		
		obj_set_billboard(o)
		
		local hitbox = get_temp_object_hitbox()
		hitbox.hurtboxRadius = 150 * o.oBehParams
		hitbox.hurtboxHeight = 300 * o.oBehParams
		hitbox.downOffset = 20
		hitbox.radius = 150 * o.oBehParams
		hitbox.height = 250 * o.oBehParams
		hitbox.damageOrCoinValue = 1
		obj_set_billboard(o)
		obj_set_hitbox(o, hitbox)
		
		cur_obj_scale(0)
		
		network_init_object(o, true, nil)
	end
	
	local objectLists = {
		OBJ_LIST_GENACTOR,
		OBJ_LIST_SURFACE,
	}
	
	local function bhv_kirby_star_loop(o)
	
		local SCALE_SIZE, SCALE_SPEED = 0.625 * o.oBehParams, 0.125 * o.oBehParams
		o.header.gfx.scale.x = approach_f32(o.header.gfx.scale.x, SCALE_SIZE, SCALE_SPEED, SCALE_SPEED)
		o.header.gfx.scale.y = approach_f32(o.header.gfx.scale.y, SCALE_SIZE, SCALE_SPEED, SCALE_SPEED)
		o.header.gfx.scale.z = approach_f32(o.header.gfx.scale.z, SCALE_SIZE, SCALE_SPEED, SCALE_SPEED)
		
		if o.oTimer > 4 * o.oBehParams then
			o.oInteractType = INTERACT_DAMAGE
		end
	
		spawn_non_sync_object(id_bhvSparkleSpawn, E_MODEL_NONE, o.oPosX, o.oPosY + 30, o.oPosZ, function (o) end)
		smlua_anim_util_set_animation(o, "ANIM_KIRBY_STAR_LOOP")
	
		o.oPosY = o.oPosY + sins(o.oMoveAnglePitch) * o.oForwardVel
		obj_update_gfx_pos_and_angle(o)
		
		local hasAttacked = obj_attack_collided_from_other_object(o)
		for _, list in ipairs(objectLists) do
			local oHit = obj_get_first(list)
			while oHit do
				if o ~= oHit then
					if oHit.oHeldState == HELD_FREE and obj_check_hitbox_overlap(o, oHit) and (oHit.header.gfx.node.flags & GRAPH_RENDER_INVISIBLE) == 0 and oHit.oIntangibleTimer >= 0 then
						if (oHit.oInteractType == INTERACT_BREAKABLE or oHit.oInteractType == INTERACT_BULLY or oHit.oInteractType == INTERACT_SPINY_WALKING or obj_is_attackable(oHit)) and obj_has_behavior_id(oHit, id_bhvBowser) == 0 then
							hasAttacked = 1
							if oHit.oInteractType == INTERACT_BULLY then
								oHit.oFaceAngleYaw = o.oMoveAngleYaw
								oHit.oMoveAngleYaw = oHit.oFaceAngleYaw
								oHit.oForwardVel = o.oForwardVel * 1.5
								hasAttacked = 2
							elseif obj_has_behavior_id(oHit, id_bhvKlepto) then
								hasAttacked = 2
							end
							oHit.oInteractStatus = oHit.oInteractStatus | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB | ATTACK_PUNCH
							audio_sample_play(KIRBY_HIT_SOUND, o.header.gfx.pos, 0.5)
						end
					end
				end
				oHit = obj_get_next(oHit)
			end
		end
		
		cur_obj_update_floor_and_walls()
		cur_obj_move_standard(-78) -- Added so that the object can move on slopes

		if (o.oMoveFlags & OBJ_MOVE_HIT_WALL) ~= 0 or (o.oBehParams <= 1 and hasAttacked ~= 0) or hasAttacked > 1 then
			audio_sample_play(KIRBY_HIT_SOUND, o.header.gfx.pos, 1)
			spawn_mist_particles()
			spawn_triangle_break_particles(10, 139, 0.2, 3)
			obj_mark_for_deletion(o)
		end
	end
	
	id_bhvKirbyStar_JJJ = hook_behavior(nil, OBJ_LIST_PUSHABLE, true, bhv_kirby_star_init, bhv_kirby_star_loop, "bhvKirbyStar_JJJ")
	
	-- AIR
	local function bhv_kirby_air_init(o)
	
		o.oFaceAngleRoll = 0
		o.oMoveAngleRoll = 0
		o.oBounciness = 0
		o.oDragStrength = 0
		o.oWallHitboxRadius = 60
		
		o.oGravity = 0
		o.oFriction = 1
		o.oBuoyancy = 0
		o.oVelY = 0
		
		local hitbox = get_temp_object_hitbox()
		hitbox.hurtboxRadius = 75
		hitbox.hurtboxHeight = 150
		hitbox.radius = 75
		hitbox.height = 125
		hitbox.damageOrCoinValue = 1
		obj_set_billboard(o)
		obj_set_hitbox(o, hitbox)
		
		cur_obj_scale(2.5)
		
		network_init_object(o, true, nil)
	end
	
	local function bhv_kirby_air_loop(o)
		o.oPosX, o.oPosZ = o.oPosX + sins(o.oMoveAngleYaw) * o.oForwardVel, o.oPosZ + coss(o.oMoveAngleYaw) * o.oForwardVel
		obj_update_gfx_pos_and_angle(o)
		
		o.oForwardVel = approach_f32(o.oForwardVel, 0, 7.5, 7.5)
		
		local hasAttacked = obj_attack_collided_from_other_object(o)
		for _, list in ipairs(objectLists) do
			local oHit = obj_get_first(list)
			while oHit do
				if o ~= oHit then
					if oHit.oHeldState == HELD_FREE and obj_check_hitbox_overlap(o, oHit) then
						if (oHit.oInteractType == INTERACT_BREAKABLE or obj_is_attackable(oHit)) and obj_has_behavior_id(oHit, id_bhvBowser) == 0 then
							oHit.oInteractStatus = oHit.oInteractStatus | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB | ATTACK_PUNCH
							hasAttacked = 1
						end
					end
				end
				oHit = obj_get_next(oHit)
			end
		end
		
		cur_obj_update_floor_and_walls()
		
		if (o.oMoveFlags & OBJ_MOVE_HIT_WALL) ~= 0 or o.oForwardVel <= 0 or hasAttacked ~= 0 then
			spawn_mist_particles_variable(20, -20, 10)
			obj_mark_for_deletion(o)
		else
			if o.oForwardVel > 10 then
				spawn_non_sync_object(id_bhvMistParticleSpawner, E_MODEL_NONE, o.oPosX, o.oPosY - 25, o.oPosZ, function(o)
					o.oForwardVel = 0
				end)
			end
		end
		
	end
	
	id_bhvKirbyAir_JJJ = hook_behavior(nil, OBJ_LIST_PUSHABLE, true, bhv_kirby_air_init, bhv_kirby_air_loop, "bhvKirbyAir_JJJ")
	
	-- ACTUAL KIRBY STUFF --

	for i = 0, (MAX_PLAYERS - 1) do
		gPlayerSyncTable[i].hasAddedHatFromKirby_JJJ = false
		
		gPlayerSyncTable[i].kirbyFallTimer_JJJ = 0
		gPlayerSyncTable[i].kirbyPuffCeiling_JJJ = 0
		gPlayerSyncTable[i].kirbyHasMovedStick_JJJ = false
		gPlayerSyncTable[i].forwardVel = 0
		gPlayerSyncTable[i].velX = 0
		gPlayerSyncTable[i].velY = 0
		gPlayerSyncTable[i].velZ = 0
		gPlayerSyncTable[i].kirbyPuffTimer_JJJ = 0
		gPlayerSyncTable[i].kirbyHasPuffed_JJJ = false
		gPlayerSyncTable[i].dodgeStickX = 0
		gPlayerSyncTable[i].dodgeStickY = 0
		
		gPlayerSyncTable[i].kirbyMouthCounter_JJJ = 0 -- How many objects in Kirby's mouth?
		gPlayerSyncTable[i].kirbyInhaleTimer_JJJ = 0
		
		gPlayerSyncTable[i].kirbyScaleY = 1000
		gPlayerSyncTable[i].kirbyMouthState = 0
	end

	hook_mario_action(ACT_KIRBY_PUFF, {every_frame = act_kirby_puff, gravity = function (m) 
		m.vel.y = m.vel.y - 1
		if m.vel.y < -15 then
			m.vel.y = -15
		end
	end})
	hook_mario_action(ACT_KIRBY_SLIDE, {every_frame = act_kirby_slide, gravity = function (m) 
		m.vel.y = m.vel.y - 4
        if m.vel.y < -75 then
			m.vel.y = -75
		end
	end})
	hook_mario_action(ACT_KIRBY_INHALE, {every_frame = act_kirby_inhale, gravity = function (m)
		m.vel.y = m.vel.y - 4
        if m.vel.y < -75 then
			m.vel.y = -75
		end
	end})
	hook_mario_action(ACT_KIRBY_DODGE, {every_frame = act_kirby_dodge, gravity = function (m)
		m.vel.y = m.vel.y - 5.5
        if m.vel.y < -75 then
			m.vel.y = -75
		end
	end})
	hook_mario_action(ACT_KIRBY_HELLO, act_kirby_hello)
	
	local function action_value_to_string(action)
		for k, v in pairs(_G) do
			if v == action then
				return k
			end
		end
		return tostring(action)
	end
	
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_WARP, function() audio_stream_stop(KIRBY_INHALE_SOUND) end) -- Added to prevent the inhale sound from playing outside a level forever.
	
	local function kirbyBeforeActions(m, incomingAction)
		local idx = m.playerIndex
		local floorObjectVel = (m.floor and m.floor.object and m.floor.object.oForwardVel) or 0
		
		if m.action == ACT_KIRBY_INHALE then
			audio_stream_stop(KIRBY_INHALE_SOUND)
		end
		
		if incomingAction == ACT_JUMP_KICK and m.action == ACT_KIRBY_PUFF then
			if m.playerIndex == 0 then
				spawn_sync_object(id_bhvKirbyAir_JJJ, E_MODEL_KIRBY_AIR, m.pos.x, m.pos.y + 50, m.pos.z, function(o)
					o.oMoveAngleYaw = m.faceAngle.y
					o.oForwardVel = m.forwardVel + floorObjectVel + 64
				end)
			end
			return incomingAction
		end
		
		if incomingAction == ACT_PUTTING_ON_CAP then
			if m.action == ACT_READING_NPC_DIALOG then
				return ACT_IDLE
			end
			audio_sample_play(KIRBY_COPY_SOUND, m.pos, 1)
			m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
			for i = 1, 10 do
				spawn_non_sync_object(id_bhvBreakBoxTriangle, E_MODEL_SPARKLES, m.pos.x, m.pos.y, m.pos.z, function (o) 
					o.oAnimState = 3
					o.oPosY = o.oPosY + 50
					o.oMoveAngleYaw = random_u16()
					o.oFaceAngleYaw = o.oMoveAngleYaw
					o.oFaceAnglePitch = random_u16()
					o.oVelY = random_f32_around_zero(20)
					o.oAngleVelPitch = 0x80 * (random_float() + 50)
					o.oForwardVel = 10
					obj_scale(o, 0.75)
				end)
			end
			m.flags = m.flags | MARIO_CAP_ON_HEAD
			m.faceAngle.y = m.area.camera.yaw
			if m.pos.y ~= m.floorHeight then
				set_mario_action(m, ACT_JUMP, 1)
				m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
				m.vel.x, m.vel.y, m.vel.z = 0, 16, 0
				m.flags = m.flags | MARIO_MARIO_SOUND_PLAYED
				return 1
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
				return ACT_JUMP
			end
		end
		
		if incomingAction == ACT_START_CRAWLING and m.action == ACT_CROUCHING then
			m.vel.y = 32
			if m.forwardVel < 64 then m.forwardVel = 64 end
			gPlayerSyncTable[idx].dodgeStickX = m.controller.stickX
			gPlayerSyncTable[idx].dodgeStickY = m.controller.stickY
			play_character_sound(m, CHAR_SOUND_HAHA_2)
			return ACT_KIRBY_DODGE
		end
		
		if incomingAction ~= ACT_PICKING_UP and (incomingAction == ACT_DIVE or (incomingAction == ACT_PUNCHING and m.action ~= ACT_CROUCHING) or incomingAction == ACT_MOVE_PUNCHING or (incomingAction == ACT_JUMP_KICK and m.action ~= ACT_KIRBY_PUFF)) or incomingAction == ACT_WATER_PUNCH then
			if gPlayerSyncTable[idx].kirbyMouthCounter_JJJ > 0 then
				m.forwardVel = 0
				if m.playerIndex == 0 then
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
				else
					return incomingAction
				end
			elseif incomingAction ~= ACT_WATER_PUNCH then
				if m.pos.y == m.floorHeight then m.vel.y = 0 end
				gPlayerSyncTable[idx].kirbyInhaleTimer_JJJ = 0
				if m.playerIndex == 0 then spawn_non_sync_object(id_bhvKirbyInhale_JJJ, E_MODEL_KIRBY_VORTEX, m.pos.x, m.pos.y + 25, m.pos.z, function(o) o.parentObj = m.marioObj end) end
				return ACT_KIRBY_INHALE
			end
		end

		if ((m.action == ACT_START_CROUCHING or m.action == ACT_CROUCHING or m.action == ACT_STOP_CROUCHING) and incomingAction == ACT_BACKFLIP) or
			incomingAction == ACT_LONG_JUMP or (incomingAction == ACT_FORWARD_ROLLOUT and m.action ~= ACT_KIRBY_DODGE) or incomingAction == ACT_BACKWARD_ROLLOUT or incomingAction == ACT_DOUBLE_JUMP or incomingAction == ACT_TRIPLE_JUMP or incomingAction == ACT_SIDE_FLIP then
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
		
		return incomingAction
	end
	
	local function kirbyActions(m)
		if m.action == ACT_PUNCHING and m.prevAction == ACT_CROUCHING then
			set_mario_action(m, ACT_SLIDE_KICK, 0)
			return
		end
		if m.action == ACT_SLIDE_KICK then
			play_character_sound(m, CHAR_SOUND_UH2_2)
			set_mario_action(m, ACT_KIRBY_SLIDE, 0)
			m.vel.y = 0
			if m.forwardVel < 64 then m.forwardVel = 64 end
			return
		end
	end
	
	local function checkFlags(m) -- Same system used for my Splatoon Idols mod.
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
	
	local function kirbyPostUpdate(m)
		-- SCALING
		
		local idx = 0
		if m.playerIndex ~= idx then return end
		
		if checkFlags(m) and (m.controller.buttonPressed & L_TRIG) ~= 0 and m.action ~= ACT_KIRBY_HELLO and m.pos.y == m.floorHeight and m.forwardVel == 0 then
			set_mario_action(m, ACT_KIRBY_HELLO, 0)
		end
		
		if m.action ~= ACT_SQUISHED then
			local toScale = 1000
			if m.action == ACT_JUMP_LAND or m.action == ACT_FREEFALL_LAND then
				toScale = 500
			elseif m.action == ACT_START_CROUCHING or m.action == ACT_START_CROUCHING or m.action == ACT_CROUCHING or m.action == ACT_KIRBY_SLIDE or m.action == ACT_SLIDE_KICK_SLIDE or m.action == ACT_CROUCH_SLIDE or m.action == ACT_JUMP_LAND
				 or (m.action == ACT_EXIT_LAND_SAVE_DIALOG and (m.marioObj.header.gfx.animInfo.animFrame >= 28 and m.marioObj.header.gfx.animInfo.animFrame < 34)) then
				toScale = 750
			elseif m.action == ACT_FORWARD_ROLLOUT then
				toScale = 900
			elseif (m.action == ACT_JUMP and m.vel.y > 0) or (m.action == ACT_KIRBY_PUFF and m.vel.y > 0) then
				toScale = 1100
			elseif m.action == ACT_KIRBY_INHALE or (m.action == ACT_EXIT_LAND_SAVE_DIALOG and (m.marioObj.header.gfx.animInfo.animFrame > 10 and m.marioObj.header.gfx.animInfo.animFrame < 28)) then
				toScale = 1200
			elseif m.action == ACT_JUMP_KICK and m.marioObj.header.gfx.animInfo.animFrame < 2 then
				toScale = 1300
			end
			
			local scaleSpeed = m.pos.y == m.floorHeight and 100 or 25
			gPlayerSyncTable[idx].kirbyScaleY = approach_f32(gPlayerSyncTable[idx].kirbyScaleY, toScale, scaleSpeed, scaleSpeed)
			m.marioObj.header.gfx.scale.y = gPlayerSyncTable[idx].kirbyScaleY / 1000
		else
			gPlayerSyncTable[idx].kirbyScaleY = 50
		end
		
		if ((m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE) or (m.action & ACT_GROUP_MASK) == ACT_GROUP_CUTSCENE) and gPlayerSyncTable[idx].kirbyMouthCounter_JJJ > 0 then -- Eat the contents
			play_character_sound(m, CHAR_SOUND_PUNCH_WAH)
			if not (m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE) then
				m.marioObj.header.gfx.scale.y = 0.75
			end
			gPlayerSyncTable[idx].kirbyMouthCounter_JJJ = 0
		end
	
		if (m.action & ACT_FLAG_INTANGIBLE) ~= 0 or (m.action & ACT_FLAG_INVULNERABLE) ~= 0 then
			return
		end
		
		if m.action == ACT_SLIDE_KICK and m.vel.y < 0 then
			m.vel.y = 0
		end
		
		if m.action ~= ACT_KIRBY_PUFF and ((m.action & ACT_FLAG_SWIMMING) ~= 0 or m.action == ACT_TWIRLING or m.pos.y == m.floorHeight) then
			gPlayerSyncTable[idx].kirbyPuffCeiling_JJJ = m.marioObj.header.gfx.pos.y + 800
		end
		
		if m.pos.y ~= m.floorHeight and gPlayerSyncTable[idx].kirbyMouthCounter_JJJ <= 0 and (m.action & ACT_FLAG_SWIMMING) == 0 and (m.action & ACT_FLAG_METAL_WATER) == 0 
			and m.action ~= ACT_SOFT_BONK and m.action ~= ACT_TOP_OF_POLE_JUMP and m.action ~= ACT_KIRBY_PUFF and m.action ~= ACT_FLYING_TRIPLE_JUMP and m.action ~= ACT_FLYING and m.action ~= ACT_SHOT_FROM_CANNON and m.action ~= ACT_WATER_JUMP 
			and m.action ~= ACT_START_HANGING and m.action ~= ACT_HANGING and m.action ~= ACT_HANG_MOVING and m.action ~= ACT_BUBBLED and m.action ~= ACT_KIRBY_INHALE then
			gPlayerSyncTable[idx].kirbyFallTimer_JJJ = gPlayerSyncTable[idx].kirbyFallTimer_JJJ + 1
			if gPlayerSyncTable[idx].kirbyFallTimer_JJJ > 40 and (m.action == ACT_JUMP or m.action == ACT_FREEFALL or m.action == ACT_JUMP_KICK or m.action == ACT_TOP_OF_POLE_JUMP) and m.vel.y < 0 then
				m.marioObj.header.gfx.animInfo.animID = -1
				set_mario_action(m, ACT_VERTICAL_WIND, 0)
				set_mario_animation(m, MARIO_ANIM_AIRBORNE_ON_STOMACH)
				m.flags = (m.flags | MARIO_MARIO_SOUND_PLAYED) & ~MARIO_KICKING
				m.actionState = 1
			end
			if (m.input & INPUT_A_PRESSED) ~= 0 and gPlayerSyncTable[idx].kirbyFallTimer_JJJ >= 2 then
				if (m.flags & MARIO_WING_CAP) ~= 0 then
					if m.action ~= ACT_GROUND_POUND then
						spawn_mist_particles_variable(20, -20, 10)
						play_sound(SOUND_ACTION_TWIRL, m.marioObj.header.gfx.cameraToObject)
						set_mario_action(m, ACT_FLYING_TRIPLE_JUMP, 0)
						m.angleVel.x = 0
						m.vel.y = 64
					end
				elseif not gPlayerSyncTable[idx].kirbyHasPuffed_JJJ then
					if m.action == ACT_WATER_JUMP then -- Resets camera in case Kirby was in water.
						set_camera_mode(m.area.camera, m.area.camera.defMode, 1)
					end
					play_character_sound(m, CHAR_SOUND_HOOHOO)
					gPlayerSyncTable[idx].kirbyHasMovedStick_JJJ = false
					gPlayerSyncTable[idx].kirbyPuffTimer_JJJ = 0 -- Added just in case Kirby's puffing gets interrupted, be it by attack.
					set_mario_action(m, ACT_KIRBY_PUFF, 0)
					set_mario_animation(m, MARIO_ANIM_DOUBLE_JUMP_RISE)
					m.vel.y = 16
				end
			end
		else
			gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0
			if m.pos.y == m.floorHeight or (m.action & ACT_FLAG_SWIMMING) ~= 0 then
				gPlayerSyncTable[idx].kirbyHasPuffed_JJJ = false
			end
		end
	end
	
	local function kirbyPreUpdate(m)
		local idx = m.playerIndex
		
		if idx ~= 0 then return end
		
		if m.action == ACT_PUTTING_ON_CAP or (m.action == ACT_JUMP and m.actionArg == 1 and m.vel.y > 0 and _G.charSelect.character_get_current_number(0) == kirbyCharID) then
			m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		end
		
		m.peakHeight = m.pos.y -- Disables fall damage.

		if m.action ~= ACT_KIRBY_PUFF and m.action ~= ACT_KIRBY_DODGE then
			gPlayerSyncTable[idx].forwardVel = m.forwardVel
		end
	end
	
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_INTERACT, function(m) 
		local idx = m.playerIndex
		gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0
	end)
	
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_PLAY_SOUND, function (soundBits, pos)
		for i = 0, MAX_PLAYERS - 1 do
			local m = gMarioStates[i]
			local currChar = _G.charSelect.character_get_current_number(m.playerIndex)
			local checkPos = pos.x == m.marioObj.header.gfx.cameraToObject.x and pos.y == m.marioObj.header.gfx.cameraToObject.y and pos.z == m.marioObj.header.gfx.cameraToObject.z -- Shoutouts to "EmilyEmmi" for giving me advice on how to accomplish step sounds!
			if currChar == kirbyCharID and checkPos then
				if soundBits == SOUND_ACTION_TERRAIN_STEP or soundBits == SOUND_ACTION_TERRAIN_STEP + m.terrainSoundAddend or soundBits == SOUND_ACTION_TERRAIN_STEP_TIPTOE or soundBits == SOUND_ACTION_TERRAIN_STEP_TIPTOE + m.terrainSoundAddend then
					audio_sample_play(KIRBY_STEP_SOUND, m.pos, 1)
					return NO_SOUND
				elseif soundBits == SOUND_ACTION_TERRAIN_LANDING or soundBits == SOUND_ACTION_TERRAIN_LANDING + m.terrainSoundAddend or soundBits == SOUND_ACTION_TERRAIN_BODY_HIT_GROUND or soundBits == SOUND_ACTION_TERRAIN_BODY_HIT_GROUND + m.terrainSoundAddend then
					audio_sample_play(KIRBY_LAND_SOUND, m.pos, 1)
					return NO_SOUND
				elseif soundBits == SOUND_ACTION_TERRAIN_JUMP or soundBits == SOUND_ACTION_TERRAIN_JUMP + m.terrainSoundAddend or soundBits == SOUND_ACTION_METAL_JUMP then
					return NO_SOUND
				end
			end
		end
	end)
	
	hook_event(HOOK_MARIO_UPDATE, function (m)
		if m.playerIndex == 0 then
			local currChar = _G.charSelect.character_get_current_number()
			if currChar == kirbyCharID then
				m.cap = m.cap & ~(SAVE_FLAG_CAP_ON_GROUND | SAVE_FLAG_CAP_ON_KLEPTO | SAVE_FLAG_CAP_ON_UKIKI | SAVE_FLAG_CAP_ON_MR_BLIZZARD)
				gPlayerSyncTable[0].hasAddedHatFromKirby_JJJ = false
			elseif (m.flags & MARIO_CAP_ON_HEAD) == 0 then
				if not gPlayerSyncTable[0].hasAddedHatFromKirby_JJJ then
					m.flags = (m.flags | MARIO_CAP_ON_HEAD) & ~MARIO_CAP_IN_HAND
					gPlayerSyncTable[0].hasAddedHatFromKirby_JJJ = true
				end
			end
		end
	end)
	
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_INTERACT, function(m) 
		local idx = m.playerIndex
		gPlayerSyncTable[idx].kirbyFallTimer_JJJ = 0
	end)
	
	hook_event(HOOK_OBJECT_SET_MODEL, function (o, model, extendedModel, charNum) 
		local m = gMarioStates[0]
		local currChar = _G.charSelect.character_get_current_number()
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
	
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_MARIO_UPDATE, kirbyPostUpdate)
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_BEFORE_MARIO_UPDATE, kirbyPreUpdate)
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_ON_SET_MARIO_ACTION, kirbyActions)
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_BEFORE_SET_MARIO_ACTION, kirbyBeforeActions)
	_G.charSelect.character_hook_moveset(kirbyCharID, HOOK_BEFORE_PHYS_STEP, function (m)
		local hScale, vScale = 1.0, 1.0
	
		if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ > 0 then
			if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
				m.pos.y = m.pos.y - 5.5
				if m.vel.y > 0 then
					vScale = vScale * 0.5
				end
				hScale = hScale * 0.6
			else
				if (m.action & ACT_FLAG_MOVING) ~= 0 and m.action ~= ACT_BUBBLED then
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
	
	local function allow_interact(m, o, intType) -- Piece of code I found on "Coop Central" by "@.kristy.", originally from Sonic Rebooted which, before that, was from Pasta Castle.
		if m.action == ACT_KIRBY_INHALE then
			if (intType & (INTERACT_GRABBABLE) ~= 0) and o.oInteractionSubtype & (INT_SUBTYPE_NOT_GRABBABLE) == 0 and not (obj_has_behavior_id(o, id_bhvBobomb) ~= 0 or (obj_has_behavior_id(o, id_bhvUkiki) ~= 0 and o.oBehParams2ndByte == UKIKI_CAP)) then
				m.interactObj = o
				m.input = m.input | INPUT_INTERACT_OBJ_GRABBABLE
				if o.oSyncID ~= 0 then
					network_send_object(o, true)
				end
			end
		end
		
		if m.playerIndex ~= 0 then
			return
		end
		
		local oUpdated = false
		local currChar = _G.charSelect.character_get_current_number()
		
		if currChar == kirbyCharID then
			if get_mario_cap_flag(o) ~= 0 and (obj_has_behavior_id(o, id_bhvWingCap) ~= 0 or obj_has_behavior_id(o, id_bhvMetalCap) ~= 0 or obj_has_behavior_id(o, id_bhvVanishCap) ~= 0) then
				set_mario_action(m, ACT_PUTTING_ON_CAP, 0)
			else
				m.flags = (m.flags | MARIO_CAP_ON_HEAD) & ~MARIO_CAP_IN_HAND
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
	end
	  
	hook_event(HOOK_ALLOW_INTERACT, allow_interact)
	
	local function before_update(m) -- Code by Baconator2558, meant to use one idle animation instead of three.
		if (kirbyCharID == _G.charSelect.character_get_current_number(m.playerIndex)) then
			if (m.action == ACT_IDLE) then
				m.actionState = 0
			end
		end
	end

	hook_event(HOOK_BEFORE_MARIO_UPDATE, before_update)
end