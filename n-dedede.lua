-- King Dedede specific actions, made for organization purposes.

ACT_DEDEDE_JUMP = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)

function act_dedede_jump(m)
    idx = m.playerIndex
    if m.vel.y > 0 then
        gPlayerSyncTable[idx].kirbyPuffCeiling_JJJ = m.marioObj.header.gfx.pos.y
    end

    if m.actionState == 0 then -- Startup
        -- TODO: set anim (startup)
        gPlayerSyncTable[idx].kirbyScaleY = 750; m.marioObj.header.gfx.scale.y = 0.75
        set_mario_animation(m, CHAR_ANIM_START_CROUCHING)
        m.actionTimer = m.actionTimer + 1
        if m.actionTimer > 13 then
            m.actionState = m.actionState + 1
            m.actionTimer = 0

            play_mario_sound(m, SOUND_ACTION_TERRAIN_JUMP, CHAR_SOUND_YAH_WAH_HOO)
            m.vel.y = 128
        end
    elseif m.actionState == 1 then
        gPlayerSyncTable[idx].kirbyScaleY = 1250
        -- TODO: set anim (liftoff)
        set_mario_animation(m, CHAR_ANIM_GENERAL_FALL)
        if (m.input & INPUT_Z_PRESSED) ~= 0 then
            return set_mario_action(m, ACT_GROUND_POUND, 0)
        end

        --m.vel.x, m.vel.z = m.vel.x * 1.5, m.vel.z * 1.5
    elseif m.actionState == 2 then
        if m.actionTimer == 0 then
            gPlayerSyncTable[idx].kirbyScaleY = 250; m.marioObj.header.gfx.scale.y = 0.25
            m.actionTimer = 1
        end
        m.vel.x, m.vel.z = 0, 0
        m.forwardVel = 0
        if is_anim_at_end(m) == 1 then set_mario_action(m, ACT_IDLE, 0) end
    end

    local stepCase = perform_air_step(m, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG)
    if stepCase ~= AIR_STEP_LANDED then
        update_air_without_turn(m)
    end

    if m.actionState == 1 and stepCase == AIR_STEP_LANDED then
        m.actionState = m.actionState + 1
        
        queue_rumble_data_mario(m, 5, 80)
        set_mario_animation(m, CHAR_ANIM_GENERAL_LAND) -- TODO: set anim (grounded)
        play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_HEAVY_LANDING)
        set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE, 0)
        if (idx == 0) then set_camera_shake_from_hit(SHAKE_ENV_BOWSER_JUMP) end
        --play_sound(SOUND_OBJ_BOWSER_WALK, m.marioObj.header.gfx.cameraToObject)
    end
end

hook_mario_action(ACT_DEDEDE_JUMP, {every_frame = act_dedede_jump, gravity = function (m) 
	m.vel.y = m.vel.y - 6
	if m.vel.y < -120 then
		m.vel.y = -120
	end
end})

ACT_DEDEDE_FULL_AIM = allocate_mario_action(ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT)

function act_dedede_full_aim(m)
    local steepFloorCond = m.pos.y == m.floorHeight and (mario_floor_is_steep(m) == 1 or should_begin_sliding(m) == 1)
	if steepFloorCond then
		return set_mario_action(m, ACT_BEGIN_SLIDING, 0)
	end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        set_mario_action(m, ACT_JUMP_KICK, 0)
    end

    m.vel.x, m.vel.z = 0, 0
	m.forwardVel = 0

    djui_chat_message_create(tostring(m.intendedMag))
	if (m.faceAngle.y > m.intendedYaw - 1500 and m.faceAngle.y < m.intendedYaw + 1500) or m.pos.y ~= m.floorHeight then
		set_mario_animation(m, CHAR_ANIM_STAND_AGAINST_WALL)
	else
		set_mario_anim_with_accel(m, CHAR_ANIM_PUSHING, m.intendedMag * 2000)
		play_step_sound(m, 13, 26)
	end

    m.faceAngle.y = approach_s16_symmetric(m.faceAngle.y, m.intendedYaw, 750)

	local stepCase = perform_air_step(m, 0)
	
	return 0
end

hook_mario_action(ACT_DEDEDE_FULL_AIM, {every_frame = act_dedede_full_aim, gravity = function (m)
	m.vel.y = m.vel.y - 4
	if m.vel.y < -75 then
		m.vel.y = -75
	end
end})