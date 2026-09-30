ACT_KIRBY_GHOST = allocate_mario_action(ACT_FLAG_INVULNERABLE | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_KIRBY_GHOST_DASH = allocate_mario_action(ACT_FLAG_INVULNERABLE | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_ATTACKING | ACT_FLAG_METAL_WATER)

hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, function(m, isWater) if m.action == ACT_KIRBY_GHOST or m.action == ACT_KIRBY_GHOST_DASH then return false end end)

local toApplyVel = 0
local intendedYaw = 0
function act_kirby_ghost(m)
    if (m.flags & MARIO_VANISH_CAP) == 0 then
        m.vel.y = 0
        --set_camera_mode(m.area.camera, m.area.camera.defMode, 1)
        --gLakituState.mode = gLakituState.defMode
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    --set_camera_mode(m.area.camera, CAMERA_MODE_BEHIND_MARIO, 1)
    --gLakituState.mode = CAMERA_MODE_BEHIND_MARIO

    if m.actionTimer == 0 then   
        intendedYaw = m.intendedYaw 
        toApplyVel = m.vel.y
        m.actionTimer = 1
    end

    local verticalDir = 0
    if (m.controller.buttonDown & A_BUTTON) ~= 0 then
        verticalDir = 24
    elseif (m.controller.buttonDown & Z_TRIG) ~= 0 then
        verticalDir = -24
    end
    toApplyVel = math.lerp(toApplyVel, verticalDir, 0.1)
    m.vel.y = toApplyVel

    if m.pos.y == m.floorHeight and m.vel.y <= 0 then
        perform_ground_step(m)
    else
        perform_air_step(m, 0)
    end

    if not (m.controller.stickX == 0 and m.controller.stickY == 0) then
        intendedYaw = m.intendedYaw
    end

    local toSpeed = m.intendedMag/32 * 32

    if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
        --m.actionState = 1
        --m.actionTimer = 1
        return set_mario_action(m, ACT_KIRBY_GHOST_DASH, 0)
    end

    --local WAIT_TIMER = 5
    --if m.actionState == 1 and m.actionTimer < WAIT_TIMER then
        --m.forwardVel = 0
        --m.actionTimer = m.actionTimer + 1
        --if m.actionTimer >= WAIT_TIMER then
            --play_sound(SOUND_ACTION_FLYING_FAST, m.marioObj.header.gfx.cameraToObject)
            --m.forwardVel = 128
            
        --end
    --else
        --if m.forwardVel <= 50 then
            --if m.actionState ~= 0 then
                --set_mario_animation(m, CHAR_ANIM_SWIM_PART2)
            --elseif is_anim_at_end(m) ~= 0 then
            if is_anim_at_end(m) ~= 0 then
                set_mario_animation(m, CHAR_ANIM_WATER_IDLE)
            end
            --m.actionState = 0
        --else
            --set_mario_animation(m, CHAR_ANIM_SWIM_PART1)
            --set_mario_particle_flags(m, PARTICLE_DUST, 0)
            --m.action = m.action | ACT_FLAG_ATTACKING -- TODO: gonna have to make a new action...
        --end
    --end

    m.forwardVel = math.lerp(m.forwardVel, toSpeed, 0.05)

    m.vel.x = math.lerp(m.vel.x, m.forwardVel * sins(intendedYaw), 0.1)
    m.vel.z = math.lerp(m.vel.z, m.forwardVel * coss(intendedYaw), 0.1)

    local dirAngle = atan2s(m.vel.z, m.vel.x)
    m.faceAngle.y = approach_s16_symmetric(m.faceAngle.y, dirAngle, 1000)
    m.marioObj.header.gfx.angle.x = math.lerp(m.marioObj.header.gfx.angle.x, m.vel.y * 2400, 0.1)
    m.faceAngle.x = m.marioObj.header.gfx.angle.x
end

function act_kirby_ghost_dash(m)
    m.vel.y = 0

    if m.actionTimer == 0 then
        --m.marioObj.header.gfx.angle.x = m.actionArg
    end

    if (m.flags & MARIO_VANISH_CAP) == 0 then    
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    if m.pos.y == m.floorHeight and m.vel.y <= 0 then
        perform_ground_step(m)
    else
        perform_air_step(m, 0)
    end

    local toSpeed = m.intendedMag/32 * 32

    local WAIT_TIMER = 5
    if m.actionTimer < WAIT_TIMER then
        m.forwardVel = -64
        m.actionTimer = m.actionTimer + 1
        if m.actionTimer >= WAIT_TIMER then
            play_sound(SOUND_ACTION_FLYING_FAST, m.marioObj.header.gfx.cameraToObject)
            m.forwardVel = 128
        end
    else
        m.forwardVel = math.lerp(m.forwardVel, 0, 0.05)
        if m.forwardVel <= 50 then
            set_mario_animation(m, CHAR_ANIM_SWIM_PART2)
            set_mario_action(m, ACT_KIRBY_GHOST, 0)
        else
            set_mario_animation(m, CHAR_ANIM_SWIM_PART1)
            set_mario_particle_flags(m, PARTICLE_DUST, 0)
        end
    end

    --m.forwardVel = math.lerp(m.forwardVel, toSpeed, 0.05)

    m.vel.x = math.lerp(m.vel.x, m.forwardVel * sins(m.faceAngle.y), 0.1)
    m.vel.z = math.lerp(m.vel.z, m.forwardVel * coss(m.faceAngle.y), 0.1)

    --m.marioObj.header.gfx.angle.x = approach_f32_symmetric(m.marioObj.header.gfx.angle.x, 0, 500)
    --m.faceAngle.x = m.marioObj.header.gfx.angle.x
end

hook_mario_action(ACT_KIRBY_GHOST, act_kirby_ghost)
hook_mario_action(ACT_KIRBY_GHOST_DASH, act_kirby_ghost_dash)