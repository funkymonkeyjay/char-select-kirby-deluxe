if incompatibilityCond then return 0 end

ACT_KIRBY_POWERUP = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_STATIONARY | ACT_FLAG_INTANGIBLE)

local origCamY, origFocusY = 0, 0
function act_kirby_powerup(m)
	local TO_BRIGHTNESS_LEVEL = 1200

	if m.actionTimer == 0 then
		play_character_sound(m, CHAR_SOUND_PUNCH_WAH)

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
		m.flags = m.flags & ~MARIO_CAP_IN_HAND
		m.flags = m.flags | MARIO_CAP_ON_HEAD
		
		enable_time_stop_if_alone()
		
		if m.playerIndex == 0 then
			m.actionArg = 45
			m.actionState = 1000
			origCamY, origFocusY = gLakituState.pos.y, gLakituState.focus.y
		end
		
		vec3f_zero(m.vel)
	end
	m.actionTimer = m.actionTimer + 1
	if m.actionTimer == 10 then
		play_kirby_sound(KIRBY_COPY_SOUND, m.pos, 1)
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
			
			set_shader_flag_enabled(SHADER_FLAG_BRIGHTNESS, true)
			
			m.actionState = math.lerp(m.actionState, TO_BRIGHTNESS_LEVEL, 0.4)
			set_shader_flag_value(SHADER_FLAG_BRIGHTNESS, m.actionState / 1000)
		else
			m.actionArg = math.lerp(m.actionArg, 45, 0.8)
			set_override_fov(m.actionArg)
			
			m.actionState = math.lerp(m.actionState, 1000, 0.8)
			set_shader_flag_value(SHADER_FLAG_BRIGHTNESS, m.actionState / 1000)
			if get_current_fov() <= 45 then
				set_override_fov(0)
				set_shader_flag_value(SHADER_FLAG_BRIGHTNESS, 1)
				set_shader_flag_enabled(SHADER_FLAG_BRIGHTNESS, false)
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

ACT_KIRBY_JUMBO_STAR = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_INTANGIBLE)

local function SEQUENCE_ARGS(priority, seqId)
    return ((priority << 8) | seqId)
end

local function jumboStarCameraBeginning(m)
	
end

local function jumboStarCameraFollow(m)
	
end

function act_kirby_jumbo_star(m)
	local jumboStarKeyframesVars = {
		{ s = 20, x = 0,     y = 678,  z = -2916 },	{ s = 30, x = 0,     y = 680,  z = -3500 },	{ s = 40, x = 1000,  y = 700,  z = -4000 },
		{ s = 50, x = 2500,  y = 750,  z = -3500 }, { s = 50, x = 3500,  y = 800,  z = -2000 }, { s = 50, x = 4000,  y = 850,  z = 0     },
		{ s = 50, x = 3500,  y = 900,  z = 2000  },	{ s = 50, x = 2000,  y = 950,  z = 3500  },	{ s = 50, x = 0,     y = 1000, z = 4000  },
		{ s = 50, x = -2000, y = 1050, z = 3500  }, { s = 50, x = -3500, y = 1100, z = 2000  }, { s = 50, x = -4000, y = 1150, z = 0     },
		{ s = 50, x = -3500, y = 1200, z = -2000 }, { s = 50, x = -2000, y = 1250, z = -3500 }, { s = 50, x = 0,     y = 1300, z = -4000 },
		{ s = 50, x = 2000,  y = 1350, z = -3500 }, { s = 50, x = 3500,  y = 1400, z = -2000 }, { s = 50, x = 4000,  y = 1450, z = 0     },
		{ s = 50, x = 3500,  y = 1500, z = 2000  }, { s = 50, x = 2000,  y = 1600, z = 3500  }, { s = 50, x = 0,     y = 1700, z = 4000  },
		{ s = 50, x = -2000, y = 1800, z = 3500  }, { s = 50, x = -3500, y = 1900, z = 2000  }, { s = 30, x = -4000, y = 2000, z = 0     },
		{ s = 0,  x = -3500, y = 2100, z = -2000 }, { s = 0,  x = -2000, y = 2200, z = -3500 }, { s = 0,  x = 0,     y = 2300, z = -4000 },
	}
	m.actionTimer = m.actionTimer + 1

	if m.actionState == 0 then
		local foundFloor = find_floor_height(m.pos.x, m.pos.y, m.pos.z)
		m.marioObj.oPosX, m.marioObj.oPosY, m.marioObj.oPosZ = 0, foundFloor + 200, 0
		obj_update_gfx_pos_and_angle(m.marioObj)
		m.pos.x, m.pos.y, m.pos.z = m.marioObj.oPosX, m.marioObj.oPosY, m.marioObj.oPosZ
		camera_freeze()
		play_cutscene_music(SEQUENCE_ARGS(15, SEQ_EVENT_CUTSCENE_VICTORY))
		gPlayerSyncTable[m.playerIndex].kirbySplineFrame = 1
		vec3f_zero(m.vel)
		m.actionState = m.actionState + 1
	elseif m.actionState == 1 then
		jumboStarCameraBeginning(m)
		if m.actionTimer > 30 * 6.672 then
			m.actionState = m.actionState + 1
		end
	elseif m.actionState == 2 then
		jumboStarCameraFollow(m)
		local currFrame = jumboStarKeyframesVars[gPlayerSyncTable[m.playerIndex].kirbySplineFrame]
		if currFrame then
			local currFramePos = {x = currFrame.x, y = currFrame.y, z = currFrame.z}
			local frameDist = calc_abs_dist(m.pos, currFramePos)
			
			local yaw = atan2s(currFrame.z - m.marioObj.oPosZ, currFrame.x - m.marioObj.oPosX)
			
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
	
	if m.actionTimer >= 540 then
		camera_unfreeze()
	end
	
	if m.actionTimer > 510 then
		level_trigger_warp(m, WARP_OP_CREDITS_START)
	end
end

hook_mario_action(ACT_KIRBY_JUMBO_STAR, act_kirby_jumbo_star)

hook_event(HOOK_UPDATE, function()
	local nearestBowser = obj_get_nearest_object_with_behavior_id(o, id_bhvBowser)
	if nearestBowser then
		nearestBowser.oHealth = 1
	end
end)