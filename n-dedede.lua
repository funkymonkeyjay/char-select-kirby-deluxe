if incompatibilityCond then return 0 end

-- King Dedede specific actions, made for organization purposes.

ACT_DEDEDE_JUMP = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)

function act_dedede_jump(m)
    local idx = m.playerIndex
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
        m.vel.y = 0
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
        queue_rumble_data_mario(m, 5, 80)
        if should_get_stuck_in_ground(m) ~= 0 then
            play_character_sound(m, CHAR_SOUND_OOOF2)
            set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE, 0)
            set_mario_action(m, ACT_BUTT_STUCK_IN_GROUND, 0)
            return
        end

        set_mario_action(m, ACT_DEDEDE_JUMP_LAND, 0)
        --m.actionState = m.actionState + 1
        
        --set_mario_animation(m, CHAR_ANIM_GENERAL_LAND) -- TODO: set anim (grounded)
        --play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_HEAVY_LANDING)
        --set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE, 0)
        --if (idx == 0) then set_camera_shake_from_hit(SHAKE_ENV_BOWSER_JUMP) end
        --play_sound(SOUND_OBJ_BOWSER_WALK, m.marioObj.header.gfx.cameraToObject)
    end
end

hook_mario_action(ACT_DEDEDE_JUMP, {every_frame = act_dedede_jump, gravity = function (m) 
	m.vel.y = m.vel.y - 6
	if m.vel.y < -120 then
		m.vel.y = -120
	end
end})

ACT_DEDEDE_JUMP_LAND = allocate_mario_action(ACT_FLAG_ATTACKING)

function act_dedede_jump_land(m)
    local idx = m.playerIndex
    --if check_common_landing_cancels(m, ACT_JUMP) ~= 0 then return end

    set_mario_animation(m, CHAR_ANIM_GENERAL_LAND)

    if m.actionTimer == 0 then
        gPlayerSyncTable[idx].kirbyScaleY = 250; m.marioObj.header.gfx.scale.y = 0.25
        
        play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_HEAVY_LANDING)
        set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE, 0)
        if (idx == 0) then set_camera_shake_from_hit(SHAKE_ENV_BOWSER_JUMP) end
        m.actionTimer = 1
    end

    m.vel.x, m.vel.z = 0, 0
    m.forwardVel = 0
    if is_anim_at_end(m) == 1 then set_mario_action(m, ACT_IDLE, 0) end
end

hook_mario_action(ACT_DEDEDE_JUMP_LAND, act_dedede_jump_land, INT_GROUND_POUND)

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

    --djui_chat_message_create(tostring(m.intendedMag))
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

ACT_DEDEDE_DIVE_SLIDE = allocate_mario_action(ACT_FLAG_MOVING | ACT_FLAG_DIVING | ACT_FLAG_ATTACKING)

local function act_dedede_dive_slide(m) -- Pretty much the same as ACT_DIVE_SLIDE but without the rollout + some minor tweaks.
    local idx = m.playerIndex
    if not m then return 0 end

    if m.actionTimer == 0 then
        -- TODO: play sound effects and possibly spawn Dropped Stars
        play_mario_landing_sound_once(m, SOUND_ACTION_TERRAIN_STUCK_IN_GROUND)
        if idx == 0 then set_camera_shake_from_hit(SHAKE_SMALL_DAMAGE) end
        m.actionTimer = 1
    end

    if update_sliding(m, 14) ~= 0 and is_anim_at_end(m) ~= 0 then
        mario_set_forward_vel(m, 0)
        set_mario_action(m, ACT_STOMACH_SLIDE_STOP, 0)
    end

    if mario_check_object_grab(m) ~= 0 then
        mario_grab_used_object(m)
        if m.heldObj then
            m.marioBodyState.grabPos = GRAB_POS_LIGHT_OBJ
        end
        return 1
    end

    m.vel.x, m.vel.z = m.vel.x / 2, m.vel.z / 2

    common_slide_action(m, ACT_STOMACH_SLIDE_STOP, ACT_FREEFALL, CHAR_ANIM_DIVE)
    return 0
    --[[
    set_character_animation(m, CHAR_ANIM_DIVE)

    update_air_without_turn(m)

    local stepCase = perform_air_step(m, 0)
    if stepCase == AIR_STEP_NONE then
        if m->vel[1] < 0.0f && m->faceAngle[0] > -0x2AAA then
            m->faceAngle[0] -= 0x200;
            if (m->faceAngle[0] < -0x2AAA) {
                m->faceAngle[0] = -0x2AAA;
            }
        }
        m->marioObj->header.gfx.angle.x = -m.faceAngle.x
    elseif stepCase == AIR_STEP_LANDED then
        if should_get_stuck_in_ground(m) == 1 and m.faceAngle.x == -0x2AAA then
            queue_rumble_data_mario(m, 5, 80)
            play_character_sound(m, CHAR_SOUND_OOOF2)
            set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE, 0)
            drop_and_set_mario_action(m, ACT_HEAD_STUCK_IN_GROUND, 0)
        elseif check_fall_damage(m, ACT_HARD_FORWARD_GROUND_KB) == 0 then
            if not m.heldObj then
                set_mario_action(m, ACT_DIVE_SLIDE, 0)
            else
                set_mario_action(m, ACT_DIVE_PICKING_UP, 0)
            end
        end
    elseif stepCase == AIR_STEP_HIT_WALL then
        local noWallCond = not m.wall and gServerSettings.bouncyLevelBounds ~= BOUNCY_LEVEL_BOUNDS_OFF
        if not noWallCond then
            mario_bonk_reflection(m, 1)
            m.faceAngle.x = 0
            if m.vel.y > 0 then m.vel.y = 0 end

            set_mario_particle_flags(m, PARTICLE_VERTICAL_STAR, 0)
            drop_and_set_mario_action(m, ACT_BACKWARD_AIR_KB, 0)
        end
    elseif stepCase == AIR_STEP_HIT_LAVA_WALL then
        lava_boost_on_wall(m)
    end
    ]]
end

hook_mario_action(ACT_DEDEDE_DIVE_SLIDE, {every_frame = act_dedede_dive_slide, gravity = function (m)
	m.vel.y = m.vel.y - 4
	if m.vel.y < -75 then
		m.vel.y = -75
	end
end}, INT_FAST_ATTACK_OR_SHELL)

ACT_DEDEDE_HAMMER_SPIN = allocate_mario_action(ACT_FLAG_MOVING | ACT_FLAG_ATTACKING)

local intendedYaw = 0
function act_dedede_hammer_spin(m)
    if m.actionTimer == 0 then
        m.twirlYaw = m.marioObj.header.gfx.angle.y
    end

    if m.intendedMag > 0 then
    --if not (m.controller.stickX == 0 and m.controller.stickY == 0) then
        --intendedYaw = atan2s(-m.controller.stickY, m.controller.stickX) + m.area.camera.yaw
        intendedYaw = m.intendedYaw
    end

    m.actionTimer = m.actionTimer + 1
    if m.actionTimer > 110 then
        m.faceAngle.y = intendedYaw
        return set_mario_action(m, ACT_DEDEDE_DIZZY, 0)
    end

    if math.sqrt(m.vel.x^2 + m.vel.z^2) > 48 then
        set_mario_particle_flags(m, PARTICLE_DUST, 0)
    end

    if (m.input & INPUT_A_PRESSED) ~= 0 then
        m.faceAngle.y = intendedYaw
		return set_mario_action(m, ACT_JUMP, 0)
	end
	if (m.controller.buttonPressed & X_BUTTON) ~= 0 then
		m.forwardVel = math.min(m.forwardVel + 12, 100)
	end

    if mario_floor_is_steep(m) ~= 0 or should_begin_sliding(m) ~= 0 then
        m.faceAngle.y = intendedYaw
        m.slideVelX = m.vel.x
        m.slideVelZ = m.vel.z
        return set_mario_action(m, ACT_STOMACH_SLIDE, 0)
    end

    set_mario_animation(m, CHAR_ANIM_TWIRL)

    m.vel.x = math.lerp(m.vel.x, sins(intendedYaw) * m.forwardVel, 0.05)
    m.vel.z = math.lerp(m.vel.z, coss(intendedYaw) * m.forwardVel, 0.05)
    m.forwardVel = m.forwardVel - 1
    if m.forwardVel <= 0 then
        m.faceAngle.y = m.marioObj.header.gfx.angle.y
        return set_mario_action(m, ACT_IDLE, 0)
    end

    local stepCase = perform_ground_step(m)
    if stepCase == GROUND_STEP_LEFT_GROUND then
        m.faceAngle.y = intendedYaw
        set_mario_action(m, ACT_FREEFALL, 0)
        set_character_animation(m, CHAR_ANIM_GENERAL_FALL) -- TODO: could set to custom anim
        return
    elseif stepCase == GROUND_STEP_HIT_WALL then
        m.vel.x = -m.vel.x
        m.vel.z = -m.vel.z
    end

    m.twirlYaw = m.twirlYaw + (8000 * (m.forwardVel / 64))
    m.marioObj.header.gfx.angle.y = m.twirlYaw

    local twirlTimer = math.floor(m.marioObj.header.gfx.angle.y / 32768) % 2
	if twirlTimer == 0 then
        if m.actionState == 0 then 
			play_sound(SOUND_ACTION_TWIRL, m.marioObj.header.gfx.cameraToObject)
			m.actionState = 1
		end
    else
		m.actionState = 0
    end

	return false
end

hook_mario_action(ACT_DEDEDE_HAMMER_SPIN, act_dedede_hammer_spin, INT_FAST_ATTACK_OR_SHELL)

ACT_DEDEDE_DIZZY = allocate_mario_action(ACT_FLAG_MOVING | ACT_FLAG_INVULNERABLE)

function act_dedede_dizzy(m)
    if not m then return 0 end
    common_ground_knockback_action(m, CHAR_ANIM_FORWARD_KB, 20, 1, m.actionArg) -- TODO: custom anim
    return 0
end

hook_mario_action(ACT_DEDEDE_DIZZY, act_dedede_dizzy)