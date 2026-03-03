ACT_KIRBY_INHALE = allocate_mario_action(0x080 | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT | ACT_FLAG_INVULNERABLE) -- Added ACT_FLAG_INVULNERABLE to prevent a "enemy's rotation gets distorted after getting hit by enemy" bug.
ACT_KIRBY_DODGE = allocate_mario_action(0x080 | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT)
ACT_KIRBY_HELLO = allocate_mario_action(ACT_GROUP_AUTOMATIC | ACT_FLAG_STATIONARY)

function act_kirby_hello(m)
    if m.actionTimer == 0 then
		if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ <= 0 then
			play_character_sound(m, CHAR_SOUND_HELLO)
		else
			play_character_sound(m, CHAR_SOUND_HOOHOO)
		end
        set_mario_animation(m, CHAR_ANIM_KIRBY_HELLO)
        mario_set_forward_vel(m, 0.0)
    elseif m.input & (INPUT_NONZERO_ANALOG | INPUT_A_PRESSED | INPUT_B_PRESSED | INPUT_Z_PRESSED) ~= 0 or is_anim_at_end(m) ~= 0 then
		return set_mario_action(m, ACT_IDLE, 0)
    end

    perform_ground_step(m)

    m.actionTimer = m.actionTimer + 1
end

function act_kirby_dodge(m)
	local idx = m.playerIndex

	if (m.controller.buttonDown & B_BUTTON) ~= 0 then
		m.faceAngle.y = m.intendedYaw
		m.vel.y, m.forwardVel = 0, 0
		gPlayerSyncTable[idx].kirbyInhaleTimer_JJJ = 0
		return set_mario_action(m, ACT_KIRBY_INHALE, 0)
	end

	if m.actionState == 0 and m.actionTimer == 0 then
		set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING) -- X
	end
	
	if m.marioObj.header.gfx.animInfo.animFrame == 0 then
        play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
    end

	m.actionTimer = m.actionTimer + 1
	if m.actionTimer > 30 and m.pos.y - m.floorHeight > 250.0 then
		return set_mario_action(m, ACT_FREEFALL, 0)
	end

	m.vel.x = approach_s32(m.vel.x, m.forwardVel * sins(m.intendedYaw), 0x05, 0x05)
	m.vel.z = approach_s32(m.vel.z, m.forwardVel * coss(m.intendedYaw), 0x05, 0x05)

	local stepCase = perform_air_step(m, 0)

	if stepCase == AIR_STEP_LANDED then
		m.forwardVel = 0
		set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
		play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
	elseif stepCase == AIR_STEP_HIT_LAVA_WALL then
		lava_boost_on_wall(m)
	end

	return 0
end

local allowedBehaviors = {
	id_bhvBobomb, 
	id_bhvBoo, 
	id_bhvBreakableBoxSmall, 
	id_bhvEnemyLakitu, 
	id_bhvFlyGuy, 
	id_bhvGoomba, 
	id_bhvHeaveHo, 
	id_bhvKoopa, 
	id_bhvKoopaShell, 
	id_bhvMontyMoleRock, 
	id_bhvMrBlizzard, 
	id_bhvMrBlizzardSnowball, 
	id_bhvMrIParticle, 
	id_bhvScuttlebug, 
	id_bhvSkeeter, 
	id_bhvSmallBully, 
	id_bhvSmallChillBully, 
	id_bhvSnufit, 
	id_bhvSpindrift, 
	id_bhvSpiny, 
	id_bhvSwoop,
	id_bhvWaterBomb, 
	id_bhvWaterBombShadow, 
	id_bhvSmallPenguin, 
	id_bhvJumpingBox, 
	id_bhvBlueCoinJumping, 
	id_bhvWingCap, 
	id_bhvMetalCap, 
	id_bhvVanishCap, 
	id_bhvUkiki, -- I want that monkey DEAD!!!!!! (Not the one that unlocks the cage, he gets to live)
	id_bhvMips, 
}

_G.kirbyDeluxe = {
	allowedBehaviors = {
		{id = id_bhvBobomb,             canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvBoo,                canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvBreakableBoxSmall,  canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvEnemyLakitu,        canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvFlyGuy,             canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvGoomba,             canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvHeaveHo,            canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvKoopa,              canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = function (o) return o.oKoopaMovementType >= KOOPA_BP_KOOPA_THE_QUICK_BASE end, deleteOnDetect = false}, 
		{id = id_bhvKoopaShell,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvMontyMoleRock,      canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvMrBlizzard,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvMrBlizzardSnowball, canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvMrIParticle,        canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvScuttlebug,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvSkeeter,            canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvSmallBully,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false, onEatFunc = function (o) 
			if o.parentObj and o.oBullySubtype == BULLY_STYPE_MINION then o.parentObj.oBullyKBTimerAndMinionKOCounter = o.parentObj.oBullyKBTimerAndMinionKOCounter + 1 end
		end}, 
		{id = id_bhvSmallChillBully,    canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false, onEatFunc = function (o) 
			if o.parentObj and o.oBullySubtype == BULLY_STYPE_MINION then o.parentObj.oBullyKBTimerAndMinionKOCounter = o.parentObj.oBullyKBTimerAndMinionKOCounter + 1 end
		end},  
		{id = id_bhvSpindrift,          canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvSpiny,              canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvSwoop,              canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false},
		{id = id_bhvWaterBomb,          canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvWaterBombShadow,    canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = true }, 
		{id = id_bhvSmallPenguin,       canRotate = true,  canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvJumpingBox,         canRotate = true,  canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvBlueCoinJumping,    canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvWingCap,            canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvMetalCap,           canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvVanishCap,          canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvUkiki,              canRotate = true,  canEat = function (o) return o.oBehParams2ndByte ~= UKIKI_CAP end, ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
		{id = id_bhvMips,               canRotate = true,  canEat = false,                                                    ignoreOnFuncOrCond = false,                                                                         deleteOnDetect = false}, 
	}
}

_G.kirbyDeluxe.hookBehavior = function (id, canRotate, canEat, ignoreOnFuncOrCond, deleteOnDetect, onEatFunc)
	if not id then return end
	return table.insert(_G.kirbyDeluxe.allowedBehaviors, {
		id = id,                                              -- Behavior ID of the object to inhale.
		canRotate = canRotate or true,                        -- Check to see if an object can rotate as its being inhaled.
		canEat = canEat or true,                              -- Check to see if an object can be removed once it reaches Kirby's mouth.
		ignoreOnFuncOrCond = ignoreOnFuncOrCond or false,     -- Special checks for special objects (I.E. Koopa the Quick)
		deleteOnDetect = deleteOnDetect or false,             -- Deletes an object if it's within Kirby's inhale range.
		onEatFunc = onEatFunc                                 -- Special function that activates once the object's been deleted (I.E. add to Big Bully #2's condition once a bully has been eaten)
	})
end

local function run_func_or_get_var(x, ...) if type(x) == "function" then return x(...) else return x end end

function act_kirby_inhale(m)
	local ENEMY_SPEED = 72.5
	local PLAYER_ANGLE_LIMIT = 35
	local TURN_SPEED = 0x750
	local SUCK_SPEED = 0x800
	local TURN_ANGLE_SPEED = 10
	local SUCK_TIMER = 75
	
	local idx = m.playerIndex
	
	local startPos = {x = 0, y = 0, z = 0}
	local startYaw = m.faceAngle.y
	
	mario_drop_held_object(m)
	
	gPlayerSyncTable[idx].kirbyInhaleTimer_JJJ = gPlayerSyncTable[idx].kirbyInhaleTimer_JJJ + 1
	local kirbyIsTired = gPlayerSyncTable[idx].kirbyInhaleTimer_JJJ > SUCK_TIMER
	
	local steepFloorCond = mario_floor_is_steep(m) == 1 or should_begin_sliding(m) == 1
	local letGoButtonCond = (m.controller.buttonDown & B_BUTTON) == 0 or kirbyIsTired
	
	if idx == 0 then
		audio_stream_play(KIRBY_INHALE_SOUND, false, 1)
	end
	
	if mario_check_object_grab(m) ~= 0 then
		mario_grab_used_object(m)
		play_character_sound(m, CHAR_SOUND_UH)
        if m.interactObj.behavior == get_behavior_from_id(id_bhvBowser) then
            m.marioBodyState.grabPos = GRAB_POS_BOWSER
			set_mario_action(m, ACT_PICKING_UP_BOWSER, 0)
        elseif (m.interactObj.oInteractionSubtype & INT_SUBTYPE_GRABS_MARIO) == 0 then
			m.actionState = 1
            m.marioBodyState.grabPos = GRAB_POS_LIGHT_OBJ
			set_mario_animation(m, MARIO_ANIM_PICK_UP_LIGHT_OBJ)
		else
			m.actionState = 1
			m.marioBodyState.grabPos = GRAB_POS_HEAVY_OBJ
			set_mario_animation(m, MARIO_ANIM_GRAB_HEAVY_OBJECT)
        end
		
		return 1
	end
	
	-- SUCK
	for i = 1, #_G.kirbyDeluxe.allowedBehaviors do
		local currentBehavior = _G.kirbyDeluxe.allowedBehaviors[i]
		local o = obj_get_nearest_object_with_behavior_id(m.marioObj, currentBehavior.id)

		if o and (o.oKirbySuckPlayer == 0 or idx + 1 == o.oKirbySuckPlayer) and not run_func_or_get_var(currentBehavior.ignoreOnFuncOrCond, o) then
			local distToKirby = calc_abs_dist({x = o.oPosX, y = o.oPosY, z = o.oPosZ}, {x = m.pos.x, y = m.pos.y, z = m.pos.z})
			
			local angle = mario_obj_angle_to_object(m, o)
			local angleDiff = (sm64_to_degrees(m.faceAngle.y) - sm64_to_degrees(angle) + 180 + 360) % 360 - 180
			
			if distToKirby < 700 and (angleDiff <= PLAYER_ANGLE_LIMIT and angleDiff >= -PLAYER_ANGLE_LIMIT) and not (steepFloorCond or letGoButtonCond) then -- Added "steepFloorCond" to avoid having enemies be stuck after Kirby gets on a slope.
				if currentBehavior.deleteOnDetect then
					obj_mark_for_deletion(o)
					break
				end
				
				local canRotate = run_func_or_get_var(currentBehavior.canRotate, o)
				local canEat = run_func_or_get_var(currentBehavior.canEat, o)
				
				o.oHasKirbySucked = 1
				o.oKirbySuckPlayer = idx + 1
				
				if canRotate then
					local turnAngle = get_area_update_counter() * 840 * TURN_ANGLE_SPEED
					obj_set_move_angle(o, approach_s32(o.oMoveAnglePitch, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oMoveAngleYaw, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oMoveAngleRoll, turnAngle, TURN_SPEED, TURN_SPEED))
					obj_set_gfx_angle(o, approach_s32(o.header.gfx.angle.x, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.header.gfx.angle.y, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.header.gfx.angle.z, turnAngle, TURN_SPEED, TURN_SPEED))
					obj_set_face_angle(o, approach_s32(o.oFaceAnglePitch, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oFaceAngleYaw, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oFaceAngleRoll, turnAngle, TURN_SPEED, TURN_SPEED))
				end
				
				o.oPosX = approach_f32(o.oPosX, o.oPosX - (sins(angle) * ENEMY_SPEED), SUCK_SPEED, SUCK_SPEED)
				o.oPosY = approach_f32(o.oPosY, m.pos.y, ENEMY_SPEED / 4, ENEMY_SPEED / 4)
				o.oPosZ = approach_f32(o.oPosZ, o.oPosZ - (coss(angle) * ENEMY_SPEED), SUCK_SPEED, SUCK_SPEED)
				
				obj_update_gfx_pos_and_angle(o)
				
				if distToKirby < 215 then
					if canEat then
						local coinAmount = math.max(o.oNumLootCoins or 0, o.oDamageOrCoinValue or 0)
						if o.oNumLootCoins < 0 then
							o.oNumLootCoins = math.max(o.oNumLootCoins, 1)
							obj_spawn_loot_blue_coins(o, 1, 1, 0)
						else
							if obj_has_behavior_id(o, id_bhvKoopaShell) == 0 then
								if obj_has_behavior_id(o, id_bhvBobomb) ~= 0 then
									o.oNumLootCoins = 1
								elseif obj_has_behavior_id(o, id_bhvBreakableBoxSmall) ~= 0 then
									o.oNumLootCoins = 3
								end
								obj_spawn_loot_yellow_coins(o, o.oNumLootCoins, 5)
							end
						end
						
						if currentBehavior.onEatFunc then currentBehavior.onEatFunc(o) end

						o.activeFlags = ACTIVE_FLAG_DEACTIVATED
						o.oInteractStatus = 0
						
						m.vel.y, m.forwardVel = 7, 0
						audio_sample_play(KIRBY_OBJECT_SOUND, m.pos, 1)
						gPlayerSyncTable[idx].kirbyMouthCounter_JJJ = gPlayerSyncTable[idx].kirbyMouthCounter_JJJ + 1
					else
						obj_set_move_angle(o, 0, 0, 0)
						obj_set_gfx_angle(o, 0, 0, 0)
						obj_set_face_angle(o, 0, 0, 0)
						o.oHasKirbySucked = 0
						o.oKirbySuckPlayer = 0
						return 0
					end
				end
			elseif o.oHasKirbySucked == 1 then -- Reset enemy.
				obj_set_move_angle(o, 0, 0, 0)
				obj_set_gfx_angle(o, 0, 0, 0)
				obj_set_face_angle(o, 0, 0, 0)
				o.oHasKirbySucked = 0
				o.oKirbySuckPlayer = 0
			end
		end
	end
	
	if letGoButtonCond then
		if kirbyIsTired then audio_sample_play(KIRBY_LAND_SOUND, m.pos, 1) end
		if m.pos.y == m.floorHeight then
			return set_mario_action(m, ACT_IDLE, 0)
		else
			return set_mario_action(m, ACT_FREEFALL, 0)
		end
	end

	if steepFloorCond then
		return set_mario_action(m, ACT_BEGIN_SLIDING, 0)
	end

	m.actionState = 0

	vec3f_copy(startPos, m.pos)
	
	m.forwardVel = approach_s32(m.forwardVel, math.min(m.forwardVel, 25), 0.5, 16)
	if m.intendedMag == 0 or m.pos.y ~= m.floorHeight then
		set_mario_animation(m, CHAR_ANIM_KIRBY_INHALE_IDLE)
	else
		set_mario_anim_with_accel(m, CHAR_ANIM_KIRBY_INHALE_MOVE, m.intendedMag * 2000)
		play_step_sound(m, 13, 26)
	end

	update_air_with_turn(m)
	local stepCase = perform_air_step(m, 0)
	
	return 0
end