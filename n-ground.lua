if incompatibilityCond then return 0 end

ACT_KIRBY_INHALE = allocate_mario_action(ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT)
ACT_KIRBY_DODGE = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT)
ACT_KIRBY_HELLO = allocate_mario_action(ACT_GROUP_AUTOMATIC | ACT_FLAG_STATIONARY)
ACT_BEING_INHALED = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_INTANGIBLE)

function act_kirby_hello(m)
    if m.actionTimer == 0 then
		if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ == 0 then
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
		--if m.playerIndex == 0 then spawn_non_sync_object(id_bhvKirbyInhale_JJJ, E_MODEL_KIRBY_VORTEX, m.pos.x, m.pos.y + 25, m.pos.z, function(o) o.parentObj = m.marioObj end) end
		return set_mario_action(m, ACT_KIRBY_INHALE, 0)
	end

	if m.actionTimer == 0 then
		set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
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
	{id = id_bhvBobomb,             canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvBreakableBoxSmall,  canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvEnemyLakitu,        canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvFlyGuy,             canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvGoomba,             canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvHeaveHo,            canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvKoopa,              canRotate = true,  canEat = true,                                                     allowSuckFunc = function (o) return o.oKoopaMovementType < KOOPA_BP_KOOPA_THE_QUICK_BASE end,    deleteOnDetect = false}, 
	{id = id_bhvKoopaShell,         canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvMontyMoleRock,      canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvMrBlizzard,         canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvMrBlizzardSnowball, canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvMrIParticle,        canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvScuttlebug,         canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvSkeeter,            canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvSmallBully,         canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o) 
		if o.parentObj and o.oBullySubtype == BULLY_STYPE_MINION then o.parentObj.oBullyKBTimerAndMinionKOCounter = o.parentObj.oBullyKBTimerAndMinionKOCounter + 1 end
	end}, 
	{id = id_bhvSmallChillBully,    canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o) 
		if o.parentObj and o.oBullySubtype == BULLY_STYPE_MINION then o.parentObj.oBullyKBTimerAndMinionKOCounter = o.parentObj.oBullyKBTimerAndMinionKOCounter + 1 end
	end},  
	{id = id_bhvSpindrift,          canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvSpiny,              canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvSwoop,              canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false},
	{id = id_bhvWaterBomb,          canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvWaterBombShadow,    canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = true }, 
	{id = id_bhvSmallPenguin,       canRotate = true,  canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvJumpingBox,         canRotate = true,  canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvWingCap,            canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvMetalCap,           canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvVanishCap,          canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvUkiki,              canRotate = true,  canEat = function (o) return o.oBehParams2ndByte == UKIKI_CAP end, allowSuckFunc = function (o) return o.oAction ~= UKIKI_ACT_GO_TO_CAGE end,                       deleteOnDetect = false}, 
	{id = id_bhvMips,               canRotate = true,  canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvSnufitBalls,        canRotate = false, canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false}, 
	{id = id_bhvMoneybag,           canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o) 
		o.oNumLootCoins = 5
		obj_spawn_loot_yellow_coins(o, o.oNumLootCoins, 5)
	end},  
	{id = id_bhvMoneybagHidden,     canRotate = true,  canEat = true,                                                     allowSuckFunc = function (o) return o.oAction == FAKE_MONEYBAG_COIN_ACT_TRANSFORM end,           deleteOnDetect = true }, 
	{id = id_bhvToadMessage,        canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o, m)
		local dialogId = o.oToadMessageDialogId; local starInfo = {[gBehaviorValues.dialogs.ToadStar1Dialog] = 0, [gBehaviorValues.dialogs.ToadStar2Dialog] = 1, [gBehaviorValues.dialogs.ToadStar3Dialog] = 2}; if starInfo[dialogId] then bhv_spawn_star_no_level_exit(m.marioObj, starInfo[dialogId], 1) end
	end, isNPC = true, onLetGoFunc = function (o, m) local localFloor = find_floor_height(o.oPosX, o.oPosY, o.oPosZ); o.oPosY = localFloor end, onEatStart = function (o)
		local toadChar = gCharacters[CT_TOAD]; play_sound_with_freq_scale(toadChar.sounds[CHAR_SOUND_OOOF], o.header.gfx.cameraToObject, toadChar.soundFreqScale); o.oOpacity = 255; o.oToadMessageState = 1
	end}, 
	{id = id_bhv1Up,                canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true}, 
	{id = id_bhv1upRunningAway,     canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true}, 
	{id = id_bhv1upSliding,         canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true}, 
	{id = id_bhv1upWalking,         canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true}, 
	{id = id_bhv1upJumpOnApproach,  canRotate = false, canEat = false,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true}, 
	{id = id_bhvBobombBuddy,        canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true,
	onLetGoFunc = function (o, m) local localFloor = find_floor_height(o.oPosX, o.oPosY, o.oPosZ); o.oPosY = localFloor end}, 
	{id = id_bhvBobombBuddyOpensCannon,canRotate = true,canEat = true,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true, onEatFunc = function (o)
		local cannonClosed = cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvCannonClosed))
		if cannonClosed then cannonClosed.oAction = 2; save_file_set_cannon_unlocked() end
	end, onLetGoFunc = function (o, m)
		local localFloor = find_floor_height(o.oPosX, o.oPosY, o.oPosZ); o.oPosY = localFloor end
	}, 
	{id = id_bhvBoo,                canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o) o.oBooDeathStatus = 1 end},  
	{id = id_bhvGhostHuntBoo,       canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o)
		o.oBooDeathStatus = 1
		if o.oBooParentBigBoo then
			o.oBooParentBigBoo.oBigBooNumMinionBoosKilled = o.oBooParentBigBoo.oBigBooNumMinionBoosKilled + 1
			obj_mark_for_deletion(o) -- Done to make the puzzle jingle work.
			local dialogId = cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvGhostHuntBoo)) and DIALOG_107 or DIALOG_108
			if true then --if cur_obj_update_dialog(MARIO_DIALOG_LOOK_UP, DIALOG_FLAG_TEXT_DEFAULT, dialogId, 0) ~= 0 then -- TODO: need to wait until the newest update adds this function.
				--create_sound_spawner(SOUND_OBJ_DYING_ENEMY1)
				if dialogId == DIALOG_108 then play_puzzle_jingle() end
			end
		end
	end, onEatStart = function (o)
		create_sound_spawner(SOUND_OBJ_DYING_ENEMY1)
	end},  
	{id = id_bhvMerryGoRoundBoo,    canRotate = true,  canEat = true,                                                     allowSuckFunc = true,                                                                            deleteOnDetect = false, onEatFunc = function (o)
		o.oBooDeathStatus = 1
		if o.oBooParentBigBoo then o.oBooParentBigBoo.oBigBooNumMinionBoosKilled = o.oBooParentBigBoo.oBigBooNumMinionBoosKilled + 1 end
	end}, 
	{id = id_bhvCoinInsideBoo,      canRotate = false,  canEat = false,                                                   allowSuckFunc = function (o) return o.oAction > 0 end,                                           deleteOnDetect = false, isNPC = true}, 
	{id = id_bhvHauntedChair,       canRotate = true,   canEat = true,                                                    allowSuckFunc = function (o) return o.oAction > 0 and o.oHauntedChairUnkF4 == 0 end,             deleteOnDetect = false}, 
	{id = id_bhvFlyingBookend,      canRotate = true,   canEat = true,                                                    allowSuckFunc = function (o) return o.oAction > 0 end,                                           deleteOnDetect = false}, 
	{id = id_bhvHoot,               canRotate = true,   canEat = true,                                                    allowSuckFunc = function (o) return (o.header.gfx.node.flags & GRAPH_RENDER_INVISIBLE) == 0 end, deleteOnDetect = false, isNPC = true, ability = "wing"}, 
	{id = id_bhvYoshi,              canRotate = true,   canEat = true,                                                    allowSuckFunc = true,                                                                            deleteOnDetect = false, isNPC = true, onEatFunc = function (o, m)
		play_sound(SOUND_GENERAL_COLLECT_1UP, gGlobalSoundSource); m.specialTripleJump = true; m.numLives = 100
	end, onEatStart = function (o)
		play_sound(SOUND_GENERAL_YOSHI_TALK, gGlobalSoundSource)
	end}, 
}

_G.kirbyInhaleHookBehavior = function (id, canRotate, canEat, allowSuckFunc, deleteOnDetect, onEatFunc, isNPC) -- Allows the modder to hook a custom behavior for Kirby to inhale.
	if not id then return end
	local trueCanRotate, trueCanEat, trueAllowSuckFunc, trueDeleteOnDetect, trueOnEatFunc = true, true, true, false, nil
	if canRotate ~= nil then trueCanRotate = canRotate end
	if canEat ~= nil then trueCanEat = canEat end
	if allowSuckFunc ~= nil then trueAllowSuckFunc = allowSuckFunc end
	if deleteOnDetect ~= nil then trueDeleteOnDetect = deleteOnDetect end
	if onEatFunc ~= nil then trueOnEatFunc = onEatFunc end
	if isNPC ~= nil then trueIsNPC = isNPC end
	return table.insert(allowedBehaviors, {
		id = id,                             -- Behavior ID of the object to inhale.
		canRotate = trueCanRotate,           -- Check to see if an object can rotate as its being inhaled.
		canEat = trueCanEat,                 -- Check to see if an object can be removed once it reaches Kirby's mouth.
		allowSuckFunc = trueAllowSuckFunc,   -- Special checks for special objects (I.E. Koopa the Quick)
		deleteOnDetect = trueDeleteOnDetect, -- Deletes an object if it's within Kirby's inhale range.
		onEatFunc = trueOnEatFunc,           -- Special function that activates once the object's been deleted (I.E. add to Big Bully #2's condition once a bully has been eaten)
		isNPC = trueIsNPC                    -- Adds to "Unusual Objects" check.
	})
end

_G.kirbyInhaleEditBehavior = function (id, canRotate, canEat, allowSuckFunc, deleteOnDetect, onEatFunc, isNPC) -- Allows the modder to edit an existing behavior for Kirby to inhale.
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
		if allowSuckFunc ~= nil then returnBeh.allowSuckFunc = allowSuckFunc end
		if deleteOnDetect ~= nil then returnBeh.deleteOnDetect = deleteOnDetect end
		if onEatFunc ~= nil then returnBeh.onEatFunc = onEatFunc end
		if isNPC ~= nil then returnBeh.isNPC = isNPC end
	end
end

if not _G.betterCoins then -- Prevents coins messing up with Squishy's "Better Coins".
	_G.kirbyInhaleHookBehavior(id_bhvBlueCoinJumping,     false, false, true,                                   false, nil, true)
	_G.kirbyInhaleHookBehavior(id_bhvYellowCoin,          false, false, true,                                   false, nil, true)
	_G.kirbyInhaleHookBehavior(id_bhvMovingYellowCoin,    false, false, true,                                   false, nil, true)
	_G.kirbyInhaleHookBehavior(id_bhvTemporaryYellowCoin, false, false, true,                                   false, nil, true)
	_G.kirbyInhaleHookBehavior(id_bhvRedCoin,             false, false, true,                                   false, nil, true)
	_G.kirbyInhaleHookBehavior(id_bhvBlueCoinSliding,     false, false, true,                                   false, nil, true)
	_G.kirbyInhaleHookBehavior(id_bhvHiddenBlueCoin,      false, false, function (o) return o.oAction == 2 end, false, nil, true)
end

--_G.kirbyInhaleEditBehavior(id_bhvGoomba, false, false)
--_G.kirbyInhaleHookBehavior(id_bhvSnufitBalls, false, false, nil, true)

local function run_func_or_get_var(x, ...) if type(x) == "function" then return x(...) else return x end end
local ENEMY_SPEED = 72.5
local PLAYER_ANGLE_LIMIT = 35
local TURN_SPEED = 0x750
local SUCK_SPEED = 0x800
local TURN_ANGLE_SPEED = 10
local PLAYER_LAUNCH_RADIUS = 100
local ACCEPTABLE_DIST = 700
local EAT_DIST = 215

local OBJ_ACTION_INHALE = -1992

function act_being_inhaled(m)
	if m.actionTimer == 0 then
		play_character_sound(m, CHAR_SOUND_WHOA)
	end
	m.actionTimer = 1

	local mOther = gMarioStates[network_local_index_from_global(m.marioObj.oKirbySuckPlayer)] -- Original player that started the inhale.
	local o = m.marioObj
	
	local waterCond = (mOther.waterLevel and mOther.pos.y < (mOther.waterLevel - 30)) or (mOther.action == ACT_CROUCHING or mOther.action == ACT_CROUCH_SLIDE)
	or ((mOther.action & ACT_GROUP_MASK) == ACT_GROUP_CUTSCENE and not (mOther.action == ACT_PULLING_DOOR or mOther.action == ACT_PUSHING_DOOR)) or (mOther.action & ACT_GROUP_MASK) == ACT_FLAG_INTANGIBLE or (mOther.action & ACT_GROUP_MASK) == ACT_FLAG_INVULNERABLE
	or (mOther.marioObj.header.gfx.node.flags & GRAPH_RENDER_ACTIVE) == 0
	
	--local waterCond = mOther.waterLevel and mOther.pos.y < (mOther.waterLevel - 30)
	if mOther.action == ACT_JUMP_KICK or waterCond then
		o.oPosX = mOther.pos.x + sins(mOther.faceAngle.y) * PLAYER_LAUNCH_RADIUS
		o.oPosY = mOther.pos.y + 25
		o.oPosZ = mOther.pos.z + coss(mOther.faceAngle.y) * PLAYER_LAUNCH_RADIUS
		obj_update_gfx_pos_and_angle(o)
		m.pos.x, m.pos.y, m.pos.z = o.oPosX, o.oPosY, o.oPosZ
	
		m.faceAngle.x = mOther.faceAngle.x
		m.faceAngle.y = mOther.faceAngle.y
		m.faceAngle.z = mOther.faceAngle.z
		
		m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags | GRAPH_RENDER_ACTIVE
		set_mario_action(m, ACT_GRABBED, 0)
		m.marioObj.oInteractStatus = m.marioObj.oInteractStatus | (INT_STATUS_MARIO_UNK2 + INT_STATUS_MARIO_UNK6)
		local floorObjectVel = (mOther.floor and mOther.floor.object and mOther.floor.object.oForwardVel) or 0
		m.forwardVel = mOther.forwardVel + floorObjectVel + 64
        m.vel.y = 10
		
		if waterCond then
			gPlayerSyncTable[mOther.playerIndex].kirbyMouthCounter_JJJ = 0
			play_character_sound(mOther, CHAR_SOUND_PUNCH_HOO)
			play_character_sound(m, CHAR_SOUND_OOOF)
		end
		return
	end
	
	local angle = mario_obj_angle_to_object(mOther, m.marioObj)
	local angleDiff = (sm64_to_degrees(mOther.faceAngle.y) - sm64_to_degrees(angle) + 180 + 360) % 360 - 180
	
	local distToKirby = calc_abs_dist({x = m.pos.x, y = m.pos.y, z = m.pos.z}, {x = mOther.pos.x, y = mOther.pos.y, z = mOther.pos.z})
	
	set_mario_animation(m, CHAR_ANIM_BACKWARD_AIR_KB)
	if (m.marioObj.header.gfx.node.flags & GRAPH_RENDER_ACTIVE) ~= 0 then
		if mOther.action ~= ACT_KIRBY_INHALE or not (angleDiff <= PLAYER_ANGLE_LIMIT and angleDiff >= -PLAYER_ANGLE_LIMIT) or mOther.action == ACT_BEING_INHALED then
			return set_mario_action(m, ACT_FREEFALL, 0)
		end
		
		local turnAngle = get_area_update_counter() * 840 * TURN_ANGLE_SPEED
		obj_set_move_angle(o, approach_s32(o.oMoveAnglePitch, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oMoveAngleYaw, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oMoveAngleRoll, turnAngle, TURN_SPEED, TURN_SPEED))
		obj_set_gfx_angle(o, approach_s32(o.header.gfx.angle.x, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.header.gfx.angle.y, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.header.gfx.angle.z, turnAngle, TURN_SPEED, TURN_SPEED))
		obj_set_face_angle(o, approach_s32(o.oFaceAnglePitch, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oFaceAngleYaw, turnAngle, TURN_SPEED, TURN_SPEED), approach_s32(o.oFaceAngleRoll, turnAngle, TURN_SPEED, TURN_SPEED))
	
		o.oPosX = approach_f32(o.oPosX, o.oPosX - (sins(angle) * ENEMY_SPEED), SUCK_SPEED, SUCK_SPEED)
		o.oPosY = approach_f32(o.oPosY, mOther.pos.y, ENEMY_SPEED / 4, ENEMY_SPEED / 4)
		o.oPosZ = approach_f32(o.oPosZ, o.oPosZ - (coss(angle) * ENEMY_SPEED), SUCK_SPEED, SUCK_SPEED)
		if distToKirby < EAT_DIST then
			m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
			
			mOther.vel.y, mOther.forwardVel = 7, 0
			play_kirby_sound(KIRBY_OBJECT_SOUND, mOther.pos, 1)
			
			gPlayerSyncTable[mOther.playerIndex].kirbyMouthCounter_JJJ = -1
		end
	else
		o.oPosX, o.oPosY, o.oPosZ = mOther.pos.x, mOther.pos.y, mOther.pos.z
	end
	obj_update_gfx_pos_and_angle(o)
	m.pos.x, m.pos.y, m.pos.z = o.oPosX, o.oPosY, o.oPosZ
end

hook_event(HOOK_MARIO_UPDATE, function (m)
	local idx = m.playerIndex
	--if idx ~= 0 then return end
	
	local isInhaling = idx == 0 and m.action == ACT_KIRBY_INHALE
	
	for i = 0, (MAX_PLAYERS - 1) do
		if i ~= m.playerIndex and m.action ~= ACT_KIRBY_INHALE and m.action ~= ACT_BEING_INHALED then
			local mOther = gMarioStates[i]
			
			if is_player_active(mOther) ~= 0 then
				local angle = mario_obj_angle_to_object(mOther, m.marioObj)
				local angleDiff = (sm64_to_degrees(mOther.faceAngle.y) - sm64_to_degrees(angle) + 180 + 360) % 360 - 180
				local distToKirby = calc_abs_dist({x = m.pos.x, y = m.pos.y, z = m.pos.z}, {x = mOther.pos.x, y = mOther.pos.y, z = mOther.pos.z})
				local distCheck = distToKirby < ACCEPTABLE_DIST and (angleDiff <= PLAYER_ANGLE_LIMIT and angleDiff >= -PLAYER_ANGLE_LIMIT) and mOther.action == ACT_KIRBY_INHALE
				
				if distCheck then
					m.marioObj.oKirbySuckPlayer = network_global_index_from_local(mOther.playerIndex)
					set_mario_action(m, ACT_BEING_INHALED, 0)
				end
			end
		end
	end
	
	for i = 1, #allowedBehaviors do
		local currentBehavior = allowedBehaviors[i]
		local o = obj_get_first_with_behavior_id(currentBehavior.id)
		while o do
			local angle = mario_obj_angle_to_object(m, o)
			local angleDiff = (sm64_to_degrees(m.faceAngle.y) - sm64_to_degrees(angle) + 180 + 360) % 360 - 180
			local distToKirby = calc_abs_dist({x = o.oPosX, y = o.oPosY, z = o.oPosZ}, {x = m.pos.x, y = m.pos.y, z = m.pos.z})
			local distCheck = distToKirby < ACCEPTABLE_DIST and (angleDiff <= PLAYER_ANGLE_LIMIT and angleDiff >= -PLAYER_ANGLE_LIMIT) and isInhaling
			
			if (o.oKirbySuckPlayer == 0 or idx + 1 == o.oKirbySuckPlayer) and run_func_or_get_var(currentBehavior.allowSuckFunc, o) then
				if distCheck then
					if o.oHasKirbySucked == 0 then
						network_init_object(o, false, nil)
						if currentBehavior.onEatStart then
							currentBehavior.onEatStart(o, m)
						end
					end
					if currentBehavior.deleteOnDetect then obj_mark_for_deletion(o); break end
					
					local canRotate = run_func_or_get_var(currentBehavior.canRotate, o)
					local canEat = run_func_or_get_var(currentBehavior.canEat, o)
						
					o.oHasKirbySucked = 1
					o.oKirbySuckPlayer = network_global_index_from_local(idx) + 1
					
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
					
					if distToKirby < EAT_DIST then
						if currentBehavior.onEatFunc then currentBehavior.onEatFunc(o, m) end
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

							o.activeFlags = ACTIVE_FLAG_DEACTIVATED
							o.oInteractStatus = 0
							
							m.vel.y, m.forwardVel = 7, 0
							play_kirby_sound(KIRBY_OBJECT_SOUND, m.pos, 1)
							if gPlayerSyncTable[idx].kirbyMouthCounter_JJJ >= 0 then
								gPlayerSyncTable[idx].kirbyMouthCounter_JJJ = gPlayerSyncTable[idx].kirbyMouthCounter_JJJ + 1
							end
						else
							obj_set_move_angle(o, 0, 0, 0)
							obj_set_gfx_angle(o, 0, 0, 0)
							obj_set_face_angle(o, 0, 0, 0)
							o.oHasKirbySucked = 0
							o.oKirbySuckPlayer = 0
							goto continue
						end
					end
				elseif o.oHasKirbySucked == 1 then -- Reset enemy.
					if currentBehavior.onLetGoFunc then currentBehavior.onLetGoFunc(o, m) end
					obj_set_move_angle(o, 0, 0, 0)
					obj_set_gfx_angle(o, 0, 0, 0)
					obj_set_face_angle(o, 0, 0, 0)
					o.oHasKirbySucked = 0
					o.oKirbySuckPlayer = 0
					goto continue
				end
			end
			
			if o.oHasKirbySucked == 1 then
				network_send_object(o, true)
			end
			
			::continue::
			o = obj_get_next_with_same_behavior_id(o)
		end
	end
end)

function act_kirby_inhale(m)
	local SUCK_TIMER = 75
	
	local idx = m.playerIndex
	
	local startPos = {x = 0, y = 0, z = 0}
	local startYaw = m.faceAngle.y
	
	mario_drop_held_object(m)
	
	if m.actionTimer == 0 and m.playerIndex == 0 then
		play_kirby_sound(KIRBY_INHALE_SOUND, m.pos, 1)
	end
	
	m.actionTimer = m.actionTimer + 1
	local kirbyIsTired = m.actionTimer > SUCK_TIMER
	
	local steepFloorCond = m.pos.y == m.floorHeight and (mario_floor_is_steep(m) == 1 or should_begin_sliding(m) == 1)
	local letGoButtonCond = (m.controller.buttonDown & B_BUTTON) == 0 or kirbyIsTired
	
	if mario_check_object_grab(m) ~= 0 then
		set_mario_animation(m, CHAR_ANIM_FIRST_PUNCH)
		m.marioObj.header.gfx.animInfo.animFrame = 4
        return 1
    end
	
	if letGoButtonCond then
		if kirbyIsTired then play_kirby_sound(KIRBY_LAND_SOUND, m.pos, 1) end
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