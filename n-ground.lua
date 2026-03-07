if not _G.charSelectExists then return 0 end
local csVersion = _G.charSelect.version_get_full()
if csVersion.major < 16 then return 0 end
if VERSION_NUMBER < 40 then return 0 end

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
		if m.playerIndex == 0 then spawn_non_sync_object(id_bhvKirbyInhale_JJJ, E_MODEL_KIRBY_VORTEX, m.pos.x, m.pos.y + 25, m.pos.z, function(o) o.parentObj = m.marioObj end) end
		return set_mario_action(m, ACT_KIRBY_INHALE, 0)
	end

	if m.actionTimer == 0 then
		set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING) -- X
	elseif m.marioObj.header.gfx.animInfo.animFrame == 0 then
		play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
	end

	m.actionTimer = m.actionTimer + 1
	if m.actionState < 1 and m.actionTimer < 20 then
		local intendedYaw
		if not (m.controller.stickX == 0 and m.controller.stickY == 0) then
			gPlayerSyncTable[idx].kirbyDodgeX = m.controller.stickX
			gPlayerSyncTable[idx].kirbyDodgeY = m.controller.stickY
			intendedYaw = atan2s(-m.controller.stickY, m.controller.stickX) + m.area.camera.yaw
		else
			intendedYaw = atan2s(-gPlayerSyncTable[idx].kirbyDodgeY, gPlayerSyncTable[idx].kirbyDodgeX) + m.area.camera.yaw
		end

		m.vel.x = approach_s32(m.vel.x, m.forwardVel * sins(intendedYaw), 0x10, 0x10)
		m.vel.z = approach_s32(m.vel.z, m.forwardVel * coss(intendedYaw), 0x10, 0x10)
	end

	m.vel.x = clamp(m.vel.x, -64 / (m.actionState + 1), 64 / (m.actionState + 1))
	m.vel.z = clamp(m.vel.z, -64 / (m.actionState + 1), 64 / (m.actionState + 1))

	local stepCase = perform_air_step(m, 0)

	if stepCase == AIR_STEP_LANDED then
		play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
		if m.actionState < 1 then
			m.vel.y = 16
			m.actionState = 1
			local velAbs = math.sqrt(m.vel.x^2 + m.vel.z^2)
			if velAbs > 10 then
				m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
			end
		else
			m.forwardVel = 0
			set_mario_animation(m, MARIO_ANIM_CROUCHING)
			set_mario_action(m, ACT_START_CROUCHING, 0)
		end
		
	elseif stepCase == AIR_STEP_HIT_LAVA_WALL then
		lava_boost_on_wall(m)
	end

	return 0
end

local allowedBehaviors = {
	{id = id_bhvBobomb,             canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvBreakableBoxSmall,  canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvEnemyLakitu,        canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvFlyGuy,             canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvGoomba,             canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvHeaveHo,            canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvKoopa,              canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = function (o) return o.oKoopaMovementType < KOOPA_BP_KOOPA_THE_QUICK_BASE end, deleteOnDetect = false}, 
	{id = id_bhvKoopaShell,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMontyMoleRock,      canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMrBlizzard,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMrBlizzardSnowball, canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMrIParticle,        canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvScuttlebug,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvSkeeter,            canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvSmallBully,         canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false, onEatFunc = function (o) 
		if o.parentObj and o.oBullySubtype == BULLY_STYPE_MINION then o.parentObj.oBullyKBTimerAndMinionKOCounter = o.parentObj.oBullyKBTimerAndMinionKOCounter + 1 end
	end}, 
	{id = id_bhvSmallChillBully,    canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false, onEatFunc = function (o) 
		if o.parentObj and o.oBullySubtype == BULLY_STYPE_MINION then o.parentObj.oBullyKBTimerAndMinionKOCounter = o.parentObj.oBullyKBTimerAndMinionKOCounter + 1 end
	end},  
	{id = id_bhvSpindrift,          canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvSpiny,              canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvSwoop,              canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false},
	{id = id_bhvWaterBomb,          canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvWaterBombShadow,    canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = true }, 
	{id = id_bhvSmallPenguin,       canRotate = true,  canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvJumpingBox,         canRotate = true,  canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvBlueCoinJumping,    canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvWingCap,            canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMetalCap,           canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvVanishCap,          canRotate = false, canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvUkiki,              canRotate = true,  canEat = function (o) return o.oBehParams2ndByte ~= UKIKI_CAP end, ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMips,               canRotate = true,  canEat = false,                                                    ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvSnufitBalls,        canRotate = false, canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false}, 
	{id = id_bhvMoneybag,           canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = true,                                                                         deleteOnDetect = false, onEatFunc = function (o) 
		o.oNumLootCoins = 5
		obj_spawn_loot_yellow_coins(o, o.oNumLootCoins, 5)
	end},  
	{id = id_bhvMoneybagHidden,     canRotate = true,  canEat = true,                                                     ignoreOnFuncOrCond = function (o) return o.oAction == FAKE_MONEYBAG_COIN_ACT_TRANSFORM end,        deleteOnDetect = true }, 
}

_G.kirbyInhaleHookBehavior = function (id, canRotate, canEat, ignoreOnFuncOrCond, deleteOnDetect, onEatFunc) -- Allows the modder to hook a custom behavior for Kirby to inhale.
	if not id then return end
	local trueCanRotate, trueCanEat, trueIgnoreOnFuncOrCond, trueDeleteOnDetect, trueOnEatFunc = true, true, true, false, nil
	if canRotate ~= nil then trueCanRotate = canRotate end
	if canEat ~= nil then trueCanEat = canEat end
	if ignoreOnFuncOrCond ~= nil then trueIgnoreOnFuncOrCond = ignoreOnFuncOrCond end
	if deleteOnDetect ~= nil then trueDeleteOnDetect = deleteOnDetect end
	if onEatFunc ~= nil then trueOnEatFunc = onEatFunc end
	return table.insert(allowedBehaviors, {
		id = id,                                     -- Behavior ID of the object to inhale.
		canRotate = trueCanRotate,                   -- Check to see if an object can rotate as its being inhaled.
		canEat = trueCanEat,                         -- Check to see if an object can be removed once it reaches Kirby's mouth.
		ignoreOnFuncOrCond = trueIgnoreOnFuncOrCond, -- Special checks for special objects (I.E. Koopa the Quick)
		deleteOnDetect = trueDeleteOnDetect,         -- Deletes an object if it's within Kirby's inhale range.
		onEatFunc = trueOnEatFunc                    -- Special function that activates once the object's been deleted (I.E. add to Big Bully #2's condition once a bully has been eaten)
	})
end

_G.kirbyInhaleEditBehavior = function (id, canRotate, canEat, ignoreOnFuncOrCond, deleteOnDetect, onEatFunc) -- Allows the modder to edit an existing behavior for Kirby to inhale.
	if not id then return end
	local returnBeh
	for i = 1, #allowedBehaviors do
		if allowedBehaviors[i].id == id then
			returnBeh = allowedBehaviors[i]
			break
		end
	end
	if returnBeh then
		if canRotate ~= nil then returnBeh.canRotate = canRotate end
		if canEat ~= nil then returnBeh.canEat = canEat end
		if ignoreOnFuncOrCond ~= nil then returnBeh.ignoreOnFuncOrCond = ignoreOnFuncOrCond end
		if deleteOnDetect ~= nil then returnBeh.deleteOnDetect = deleteOnDetect end
		if returnBeh.onEatFunc and onEatFunc ~= nil then returnBeh.onEatFunc = onEatFunc end
	end
end

--_G.kirbyInhaleEditBehavior(id_bhvGoomba, false, false)
--_G.kirbyInhaleHookBehavior(id_bhvSnufitBalls, false, false, nil, true)

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
	for i = 1, #allowedBehaviors do
		local currentBehavior = allowedBehaviors[i]
		local o = obj_get_first_with_behavior_id(currentBehavior.id)
		while o do
			if o and (o.oKirbySuckPlayer == 0 or idx + 1 == o.oKirbySuckPlayer) and run_func_or_get_var(currentBehavior.ignoreOnFuncOrCond, o) then
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
			o = obj_get_next_with_same_behavior_id(o)
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