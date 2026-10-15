if incompatibilityCond then return 0 end

ACT_KIRBY_POWERUP = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_STATIONARY | ACT_FLAG_INTANGIBLE)

local origCamY, origFocusY = 0, 0
local light1, light2 = 0, 0
function act_kirby_powerup(m)
	local TO_BRIGHTNESS_LEVEL = 1200

	if m.actionTimer == 0 then
		play_character_sound(m, CHAR_SOUND_PUNCH_WAH)

		m.flags = m.flags & ~MARIO_CAP_IN_HAND
		m.flags = m.flags | MARIO_CAP_ON_HEAD
		
		enable_time_stop_if_alone()
		
		if m.playerIndex == 0 then
			m.actionArg = 45

			le_set_mode(LE_MODE_AFFECT_ALL_SHADED_AND_COLORED)
			set_skybox_color(0, 128); set_skybox_color(1, 128); set_skybox_color(2, 128)
			set_fog_color(0, 128); set_fog_color(1, 128); set_fog_color(2, 128)

			le_set_ambient_color(128, 128, 128)
			light1 = le_add_light(m.pos.x, m.pos.y + 400, m.pos.z, 255, 255, 255, 600, 100)
			light2 = le_add_light(m.pos.x + sins(m.faceAngle.y) * 400, m.pos.y, m.pos.z + coss(m.faceAngle.y) * 400, 255, 255, 255, 1000, 100)

			origCamY, origFocusY = gLakituState.pos.y, gLakituState.focus.y
		end
		
		vec3f_zero(m.vel)
	end
	m.actionTimer = m.actionTimer + 1
	if m.actionTimer == 10 then
		play_kirby_sound(KIRBY_COPY_SOUND, m.pos, 1)
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
	end
	
	set_mario_animation(m, MARIO_ANIM_PUT_CAP_ON)
	
	if m.playerIndex == 0 then
		camera_freeze()

		local kirbyPos = m.marioObj.header.gfx.pos.y + 125
		if m.actionTimer < 21 then
			gLakituState.pos.y = math.lerp(gLakituState.pos.y, kirbyPos, 0.125)
			gLakituState.focus.y = math.lerp(gLakituState.focus.y, kirbyPos, 0.125)
		else
			gLakituState.pos.y = math.lerp(gLakituState.pos.y, origCamY, 0.375)
			gLakituState.focus.y = math.lerp(gLakituState.focus.y, origFocusY, 0.375)
		end
		
		if m.actionTimer < 21 then
			m.actionArg = math.lerp(m.actionArg, 30, 0.4)
			set_override_fov(m.actionArg)
		else
			m.actionArg = math.lerp(m.actionArg, 45, 0.8)
			set_override_fov(m.actionArg)
			
			if get_current_fov() <= 45 then
				set_override_fov(0)
				
				le_set_mode(LE_MODE_AFFECT_ONLY_GEOMETRY_MODE)
				set_skybox_color(0, 255); set_skybox_color(1, 255); set_skybox_color(2, 255)
				set_fog_color(0, 255); set_fog_color(1, 255); set_fog_color(2, 255)
				le_set_ambient_color(255, 255, 255)
				le_remove_light(light1); le_remove_light(light2)
			end
		end
	end
	
	if is_anim_at_end(m) == 1 then
		if m.playerIndex == 0 then camera_unfreeze() end
		set_mario_action(m, m.pos.y == m.floorHeight and ACT_IDLE or ACT_FREEFALL, 0)
		disable_time_stop()
	end
end

hook_mario_action(ACT_KIRBY_POWERUP, act_kirby_powerup)

-- GRAND STAR ENDING CUTSCENE
ACT_KIRBY_JUMBO_STAR = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_INTANGIBLE)

local function SEQUENCE_ARGS(priority, seqId)
    return ((priority << 8) | seqId)
end

local function jumboStarCameraBeginning(m)
	if m.playerIndex ~= 0 then return end

	local toX, toY, toZ = m.pos.x + 600, m.pos.y + 75, m.pos.z - 600
	local toFocusX, toFocusY, toFocusZ = m.pos.x, m.pos.y + 75, m.pos.z
	
	gLakituState.pos.x = math.lerp(gLakituState.pos.x, toX, 0.05)
	gLakituState.pos.y = math.lerp(gLakituState.pos.y, toY, 0.05)
	gLakituState.pos.z = math.lerp(gLakituState.pos.z, toZ, 0.05)
	
	gLakituState.focus.x = math.lerp(gLakituState.focus.x, toFocusX, 0.1)
	gLakituState.focus.y = math.lerp(gLakituState.focus.y, toFocusY, 0.1)
	gLakituState.focus.z = math.lerp(gLakituState.focus.z, toFocusZ, 0.1)
end

local function jumboStarCameraFollow(m)
	if m.playerIndex ~= 0 then return end
	
	local trueTimer = ((m.actionTimer - 210) / 330)
	local timerAngle = degrees_to_sm64(trueTimer * math.pi * 0.5)

	gLakituState.pos.x = math.lerp(gLakituState.pos.x, m.pos.x + sins(timerAngle) * 500, 0.05)
	gLakituState.pos.y = math.lerp(gLakituState.pos.y, m.pos.y, 0.05)
	gLakituState.pos.z = math.lerp(gLakituState.pos.z, m.pos.z + coss(timerAngle) * 500, 0.05)
	
	gLakituState.focus.x = math.lerp(gLakituState.focus.x, m.pos.x, 0.25)
	gLakituState.focus.y = math.lerp(gLakituState.focus.y, m.pos.y + (trueTimer * 1750), 0.01)
	gLakituState.focus.z = math.lerp(gLakituState.focus.z, m.pos.z, 0.25)
end

local function lerpAngle(a, b, t)
	local aConvert, bConvert = sm64_to_radians(a), sm64_to_radians(b)
    local delta = (bConvert - aConvert + math.pi) % (2 * math.pi) - math.pi
    return radians_to_sm64((aConvert + delta * t) % (2 * math.pi))
end

function act_kirby_jumbo_star(m)
	local jumboStarKeyframesVars = {
		{ x = 0,     y = 678,  z = -2916 },	{ x = 0,     y = 680,  z = -3500 },	{ x = 1000,  y = 700,  z = -4000 },
		{ x = 2500,  y = 750,  z = -3500 }, { x = 3500,  y = 800,  z = -2000 }, { x = 4000,  y = 850,  z = 0     },
		{ x = 3500,  y = 900,  z = 2000  },	{ x = 2000,  y = 950,  z = 3500  },	{ x = 0,     y = 1000, z = 4000  },
		{ x = -2000, y = 1050, z = 3500  }, { x = -3500, y = 1100, z = 2000  }, { x = -4000, y = 1150, z = 0     },
		{ x = -3500, y = 1200, z = -2000 }, { x = -2000, y = 1250, z = -3500 }, { x = 0,     y = 1300, z = -4000 },
		{ x = 2000,  y = 1350, z = -3500 }, { x = 3500,  y = 1400, z = -2000 }, { x = 4000,  y = 1450, z = 0     },
		{ x = 3500,  y = 1500, z = 2000  }, { x = 2000,  y = 1600, z = 3500  }, { x = 0,     y = 1700, z = 4000  },
		{ x = -2000, y = 1800, z = 3500  }, { x = -3500, y = 1900, z = 2000  }, { x = -4000, y = 2000, z = 0     },
		{ x = -3500, y = 2100, z = -2000 }, { x = -2000, y = 2200, z = -3500 }, { x = 0,     y = 2300, z = -4000 },
	}
	m.actionTimer = m.actionTimer + 1
	
	set_mario_animation(m, CHAR_ANIM_KIRBY_ENDING)
	if m.actionTimer == 129 then
		play_character_sound(m, CHAR_SOUND_HERE_WE_GO)
	end

	if m.actionState == 0 then
		local foundFloor = find_floor_height(m.pos.x, m.pos.y, m.pos.z)
		--m.marioObj.oPosX = 100 * m.playerIndex
		m.marioObj.oPosX = 300 * network_global_index_from_local(m.playerIndex)
		m.marioObj.oPosY = foundFloor + 300
		m.marioObj.oPosZ = 0
		
		m.marioObj.oFaceAngleYaw = atan2s(-1, 1) + degrees_to_sm64(180)
		
		obj_update_gfx_pos_and_angle(m.marioObj)
		m.pos.x, m.pos.y, m.pos.z = m.marioObj.oPosX, m.marioObj.oPosY, m.marioObj.oPosZ
		m.faceAngle.y = m.marioObj.oFaceAngleYaw
		
		--spawn_sync_object(id_bhvGrandWarpStar, E_MODEL_STAR, m.pos.x, m.pos.y, m.pos.z, function (o) o.parentObj = m.marioObj end)
		spawn_sync_object(id_bhvGrandWarpStar, E_MODEL_STAR, m.pos.x, m.pos.y, m.pos.z, function (o) o.oKirbySuckPlayer = network_global_index_from_local(m.playerIndex) end)
		
		if m.playerIndex == 0 then
			camera_freeze()
			play_cutscene_music(SEQUENCE_ARGS(15, SEQ_EVENT_CUTSCENE_VICTORY))
		end
		gPlayerSyncTable[m.playerIndex].kirbySplineFrame = 1
		vec3f_zero(m.vel)
		m.actionState = m.actionState + 1
	elseif m.actionState == 1 then
		if m.actionTimer >= 53 and m.actionTimer < 144 then
			if m.actionTimer == 53 and m.playerIndex == 0 then play_sound(SOUND_GENERAL_GRAND_STAR_JUMP, m.marioObj.header.gfx.cameraToObject) end
			
			local yaw = atan2s(-1, 1)
			m.marioObj.oFaceAngleYaw = lerpAngle(m.marioObj.oFaceAngleYaw, yaw, 0.075)
		elseif m.actionTimer >= 144 then
			local currFrame = jumboStarKeyframesVars[gPlayerSyncTable[m.playerIndex].kirbySplineFrame]
			local yaw = atan2s(currFrame.z - m.marioObj.oPosZ, currFrame.x - m.marioObj.oPosX)
			
			if m.actionTimer > 200 then
				if m.playerIndex == 0 then play_sound(SOUND_GENERAL_GRAND_STAR, m.marioObj.header.gfx.cameraToObject) end
				m.marioObj.oFaceAngleYaw = yaw
				m.actionState = m.actionState + 1
			else
				if m.actionTimer == 144 and m.playerIndex == 0 then play_sound(SOUND_GENERAL_GRAND_STAR_JUMP, m.marioObj.header.gfx.cameraToObject) end
				m.marioObj.oFaceAngleYaw = lerpAngle(m.marioObj.oFaceAngleYaw, yaw, 0.1)
			end
		end
		obj_update_gfx_pos_and_angle(m.marioObj)
		m.faceAngle.y = m.marioObj.oFaceAngleYaw
	elseif m.actionState == 2 then
		if m.actionTimer < 473 then
			if m.playerIndex == 0 then
				local movementMagnitude = math.sqrt(m.vel.x^2 + m.vel.y^2 + m.vel.z^2)
				local freqScale = 1 + (movementMagnitude / 200)
				play_sound_with_freq_scale(SOUND_AIR_PEACH_TWINKLE, m.marioObj.header.gfx.cameraToObject, freqScale)
			end
			m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		end
		
		local currFrame = jumboStarKeyframesVars[gPlayerSyncTable[m.playerIndex].kirbySplineFrame]
		if currFrame then
			local currFramePos = {x = currFrame.x, y = currFrame.y, z = currFrame.z}
			local frameDist = calc_abs_dist(m.pos, currFramePos)
			
			local yaw = atan2s(currFrame.z - m.marioObj.oPosZ, currFrame.x - m.marioObj.oPosX)
			
			m.marioObj.oFaceAngleYaw = math.lerp(m.marioObj.oFaceAngleYaw, yaw, 0.05)
			m.marioObj.oFaceAngleRoll = m.marioObj.oFaceAngleRoll + 25
			
			m.vel.x = math.lerp(m.vel.x, sins(yaw) * 100, 0.1)
			m.vel.y = math.lerp(m.vel.y, (currFrame.y - m.pos.y) / 2, 0.1)
			m.vel.z = math.lerp(m.vel.z, coss(yaw) * 100, 0.1)
			
			m.marioObj.oPosX = m.marioObj.oPosX + m.vel.x
			m.marioObj.oPosY = m.marioObj.oPosY + m.vel.y
			m.marioObj.oPosZ = m.marioObj.oPosZ + m.vel.z
			
			obj_update_gfx_pos_and_angle(m.marioObj)
			m.pos.x, m.pos.y, m.pos.z = m.marioObj.oPosX, m.marioObj.oPosY, m.marioObj.oPosZ

			if frameDist <= 3000 then
				gPlayerSyncTable[m.playerIndex].kirbySplineFrame = gPlayerSyncTable[m.playerIndex].kirbySplineFrame + 1
			end
		end
	end
	
	if m.actionTimer < 210 then jumboStarCameraBeginning(m) else jumboStarCameraFollow(m) end
	
	if m.actionTimer >= 540 and m.playerIndex == 0 then camera_unfreeze() end
	if m.actionTimer > 510 then level_trigger_warp(m, WARP_OP_CREDITS_START) end
end

hook_mario_action(ACT_KIRBY_JUMBO_STAR, act_kirby_jumbo_star)

ACT_KIRBY_HURT_FORWARD = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_MOVING | ACT_FLAG_INTANGIBLE | ACT_FLAG_INVULNERABLE | ACT_FLAG_CUSTOM_ACTION | ACT_FLAG_PAUSE_EXIT)
ACT_KIRBY_HURT_BACKWARD = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_MOVING | ACT_FLAG_INTANGIBLE | ACT_FLAG_INVULNERABLE | ACT_FLAG_CUSTOM_ACTION | ACT_FLAG_PAUSE_EXIT)
ACT_KIRBY_HURT_LAVA = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_MOVING | ACT_FLAG_INTANGIBLE | ACT_FLAG_INVULNERABLE | ACT_FLAG_CUSTOM_ACTION | ACT_FLAG_PAUSE_EXIT)
local function act_kirby_hurt(m, arg)
	set_mario_animation(m, arg == 1 and MARIO_ANIM_FORWARD_SPINNING or MARIO_ANIM_BACKWARD_SPINNING)

	if arg == 2 then
		set_mario_particle_flags(m, PARTICLE_FIRE, 0)
	end

	if m.actionTimer == 0 then
		if (m.health >> 8) <= 4 then
			kirbyRemoveAbility(m)
		end
		queue_rumble_data_mario(m, 3, 40)
		play_kirby_sound(KIRBY_HURT_SOUND, m.pos, 1)
		play_character_sound(m, arg == 2 and CHAR_SOUND_ON_FIRE or CHAR_SOUND_ATTACKED)
		m.vel.y = 24
		m.vel.x, m.vel.z = 0, 0
		m.actionTimer = 1
	end

	m.forwardVel = -32 * (arg == 1 and -1 or 1)
	m.vel.x = sins(m.faceAngle.y) * m.forwardVel
	m.vel.z = coss(m.faceAngle.y) * m.forwardVel

	local stepCase = perform_air_step(m, 0)
	if stepCase == AIR_STEP_LANDED then
		m.invincTimer = 60
		return set_mario_action(m, m.intendedMag > 0 and ACT_WALKING or ACT_STOMACH_SLIDE_STOP, 0)
	end

	m.actionTimer = m.actionTimer + 1
	if m.actionTimer > 45 then
		return set_mario_action(m, ACT_FREEFALL, 0)
	end
end

-- Getting m.actionArg to change is a hassle, so I decided to just. do this. I guess!
function act_kirby_hurt_forward(m)
	return act_kirby_hurt(m, 1)
end

function act_kirby_hurt_backward(m)
	return act_kirby_hurt(m, 0)
end

function act_kirby_hurt_lava(m)
	return act_kirby_hurt(m, 2)
end

hook_mario_action(ACT_KIRBY_HURT_FORWARD, {every_frame = act_kirby_hurt_forward, gravity = function (m) m.vel.y = m.vel.y - 4 if m.vel.y < -75 then m.vel.y = -75 end end})
hook_mario_action(ACT_KIRBY_HURT_BACKWARD, {every_frame = act_kirby_hurt_backward, gravity = function (m) m.vel.y = m.vel.y - 4 if m.vel.y < -75 then m.vel.y = -75 end end})
hook_mario_action(ACT_KIRBY_HURT_LAVA, {every_frame = act_kirby_hurt_lava, gravity = function (m) m.vel.y = m.vel.y - 4 if m.vel.y < -75 then m.vel.y = -75 end end})

ACT_KIRBY_DEATH = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_AIR | ACT_FLAG_STATIONARY | ACT_FLAG_INTANGIBLE | ACT_FLAG_INVULNERABLE | ACT_FLAG_CUSTOM_ACTION | ACT_FLAG_PAUSE_EXIT)
function act_kirby_death(m)
	if m.playerIndex == 0 then gPlayerSyncTable[0].hasKirbyDied = true end

	m.faceAngle.y = m.area.camera.yaw
    m.marioObj.header.gfx.angle.y = m.faceAngle.y
	
	if m.actionTimer == 0 then
		m.forwardVel = 0
		queue_rumble_data_mario(m, 5, 80)
		play_kirby_sound(KIRBY_HURT_SOUND, m.pos, 1)
		if m.playerIndex == 0 then set_camera_shake_from_hit(SHAKE_ENV_BOWSER_JUMP) end
		for i = 1, 10 do
			spawn_non_sync_object(id_bhvBreakBoxTriangle, E_MODEL_CARTOON_STAR, m.pos.x, m.pos.y, m.pos.z, function (o) 
				o.oAnimState = 3
				o.oPosY = o.oPosY + 50
				o.oMoveAngleYaw = random_u16()
				o.oFaceAngleYaw = o.oMoveAngleYaw
				o.oFaceAnglePitch = random_u16()
				o.oVelY = random_f32_around_zero(20)
				o.oAngleVelPitch = 0x80 * (random_float() + 50)
				o.oForwardVel = 15
				obj_scale(o, 0.1)
			end)
		end
		camera_freeze()
		enable_time_stop_if_alone()
		if not mario_can_bubble(m) then
			play_music(SEQ_PLAYER_LEVEL, 0, 0)
        end
	end
	m.actionTimer = m.actionTimer + 1

	m.vel.x, m.vel.z = 0, 0

	if m.actionTimer >= 23 then
		m.marioBodyState.eyeState = MARIO_EYES_DEAD

		if m.playerIndex == 0 then
			local toY = m.twirlYaw < 0 and m.pos.y or m.floorHeight

			gLakituState.pos.x = math.lerp(gLakituState.pos.x, m.pos.x + sins(m.faceAngle.y) * 400, 0.0625)
			gLakituState.pos.y = math.lerp(gLakituState.pos.y, toY + 300, 0.0625)
			gLakituState.pos.z = math.lerp(gLakituState.pos.z, m.pos.z + coss(m.faceAngle.y) * 400, 0.0625)

			gLakituState.focus.x = math.lerp(gLakituState.focus.x, m.pos.x - sins(m.faceAngle.y) * 200, 0.03125)
			gLakituState.focus.y = math.lerp(gLakituState.focus.y, toY, 0.03125)
			gLakituState.focus.z = math.lerp(gLakituState.focus.z, m.pos.z - coss(m.faceAngle.y) * 200, 0.03125)
		end

		if m.actionTimer == 23 then
			-- TODO: play death theme!
			play_cutscene_music(SEQUENCE_ARGS(15, SEQ_KIRBY_DEATH))
			set_mario_animation(m, CHAR_ANIM_SINGLE_JUMP) -- TODO: custom anim!
			m.vel.y = 30
		end
		local stepCase = perform_air_step(m, 0)
		if stepCase == AIR_STEP_LANDED then
			if m.actionState == 0 then
				--m.faceAngle.x = 0
				m.vel.y = 10
				m.actionState = m.actionState + 1
			else
				--set_mario_animation(m, CHAR_ANIM_FALL_OVER_BACKWARDS)
				m.actionState = 2
			end
		end
		if m.actionState == 2 then
			common_death_handler(m, CHAR_ANIM_FALL_OVER_BACKWARDS, 40) -- TODO: custom anim!
			-- TODO: how can i reset the camera freeze if a HOOK_ON_DEATH prevents a death? 
		end
	else
		if m.playerIndex == 0 then
			local timeDiff = math.max(13 - m.actionTimer, 0) / 13
			gLakituState.pos.x = gLakituState.pos.x + coss(random_u16()) * timeDiff * 75
			gLakituState.pos.y = gLakituState.pos.y + sins(random_u16()) * timeDiff * 75
			gLakituState.pos.z = gLakituState.pos.z + coss(random_u16()) * timeDiff * 75
		end

		set_mario_animation(m, CHAR_ANIM_BACKWARD_AIR_KB)
		local dist = vec3f_dist(m.pos, {x = m.pos.x, y = m.floorHeight, z = m.pos.z})
		if dist > 500 then
			m.twirlYaw = -1
		else
			m.twirlYaw = 0
		end
	end
end
hook_mario_action(ACT_KIRBY_DEATH, {every_frame = act_kirby_death, gravity = function (m) 
	m.vel.y = m.vel.y - 3
	if m.vel.y < -56.25 then
		m.vel.y = -56.25
	end
end})

-- CUSTOM ENDING "WARP STAR" OBJECT
local function setStarPosAngle(o, m)
	if is_player_active(m) == 0 or (m.marioObj.header.gfx.animInfo.animID ~= CHAR_ANIM_GENERAL_FALL and m.marioObj.header.gfx.animInfo.animID ~= CHAR_ANIM_KIRBY_ENDING) then
		obj_mark_for_deletion(o)
		return
	end
	
	local mO = m.marioObj
	o.oPosX = mO.oPosX
	o.oPosY = mO.oPosY
	o.oPosZ = mO.oPosZ
	
	o.oFaceAngleYaw = mO.oFaceAngleYaw + degrees_to_sm64(180)
	o.oFaceAnglePitch = mO.oFaceAnglePitch
	o.oFaceAngleRoll = -mO.oFaceAngleRoll
	
	obj_update_gfx_pos_and_angle(o)
end

function grand_warp_star_init(o)
	local m = gMarioStates[network_local_index_from_global(o.oKirbySuckPlayer)]
	if not m then obj_mark_for_deletion(o) end
	if network_player_connected_count() <= 1 then -- KILL THE ORIGINAL, RAHHH (but only when the player is alone...)
		local nearestStar = obj_get_nearest_object_with_behavior_id(o, id_bhvGrandStar)
		if nearestStar then obj_mark_for_deletion(nearestStar) end
	end
	cur_obj_scale(2)
	setStarPosAngle(o, m)
	network_init_object(o, true, nil)
end

function grand_warp_star_loop(o)
	local m = gMarioStates[network_local_index_from_global(o.oKirbySuckPlayer)]
	if not m then return end
	setStarPosAngle(o, m)
end

id_bhvGrandWarpStar = hook_behavior(nil, OBJ_LIST_DEFAULT, true, grand_warp_star_init, grand_warp_star_loop, "bhvGrandWarpStar")

-- DEBUG
hook_event(HOOK_UPDATE, function()
	local nearestBowser = obj_get_nearest_object_with_behavior_id(o, id_bhvBowser)
	if nearestBowser then
		nearestBowser.oHealth = 1
	end
end)