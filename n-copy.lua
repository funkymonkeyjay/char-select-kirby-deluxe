gPlayerSyncTable[0].kirbyCopyAbility_JJJ = 0

ACT_KIRBY_GHOST = allocate_mario_action(ACT_FLAG_INVULNERABLE | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_KIRBY_GHOST_DASH = allocate_mario_action(ACT_FLAG_INVULNERABLE | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_ATTACKING | ACT_FLAG_METAL_WATER)

hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, function(m, isWater) if m.action == ACT_KIRBY_GHOST or m.action == ACT_KIRBY_GHOST_DASH then return false end end)

local toApplyVel = 0
local intendedYaw = 0
function act_kirby_ghost(m)
	local p = gPlayerSyncTable[m.playerIndex]
    if p.kirbyCopyAbility_JJJ ~= KIRBY_COPY_GHOST then
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
	local p = gPlayerSyncTable[m.playerIndex]
    m.vel.y = 0

    if m.actionTimer == 0 then
        --m.marioObj.header.gfx.angle.x = m.actionArg
    end

    if p.kirbyCopyAbility_JJJ ~= KIRBY_COPY_GHOST then    
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

-- Copy Ability Handler for Kirby

KIRBY_COPY_NONE = 0
KIRBY_COPY_ANGEL = 1
KIRBY_COPY_STEEL = 2
KIRBY_COPY_GHOST = 3

kirbyAbilityHooks = {
    [KIRBY_COPY_NONE] = {
        model = E_MODEL_KIRBY,
    },
    [KIRBY_COPY_ANGEL] = {
        model = E_MODEL_KIRBY,
        [HOOK_MARIO_UPDATE] = function (m)
            local p = gPlayerSyncTable[m.playerIndex]
            m.flags = m.flags | MARIO_WING_CAP
        end,
    },
    [KIRBY_COPY_STEEL] = {
        model = E_MODEL_KIRBY,
        [HOOK_MARIO_UPDATE] = function (m)
            m.flags = m.flags | MARIO_METAL_CAP

            if m.action == ACT_WALKING then
                m.marioObj.header.gfx.animInfo.animAccel = m.marioObj.header.gfx.animInfo.animAccel * 0.625
            end
        end,
        [HOOK_BEFORE_PHYS_STEP] = function(m, stepType)
            local hScale, vScale = 1.0, 1.0

			if m.action == ACT_KIRBY_PUFF then
				vScale = vScale * (m.vel.y > 0 and 0.7 or 1.2)
			else
				if m.vel.y > 0 then vScale = vScale * 0.9375 end
			end
			if (m.action & ACT_FLAG_AIR) == 0 and m.action ~= ACT_KIRBY_SLIDE then
				hScale = hScale * 0.625
			end

            m.vel.x = m.vel.x * hScale
            m.vel.y = m.vel.y * vScale
            m.vel.z = m.vel.z * hScale
        end,
    },
    [KIRBY_COPY_GHOST] = {
        model = E_MODEL_KIRBY,
        [HOOK_MARIO_UPDATE] = function (m)
            m.capTimer = 0
            m.flags = m.flags | MARIO_VANISH_CAP

            -- Allow ability removal despite never idling
            if m.controller.buttonDown & L_TRIG ~= 0 and m.pos.y < m.floorHeight + 50 then
                return set_mario_action(m, ACT_KIRBY_HELLO, 0)
            end
        end,
        [HOOK_BEFORE_SET_MARIO_ACTION] = function (m, incomingAction)
            if incomingAction ~= ACT_KIRBY_GHOST and incomingAction ~= ACT_KIRBY_HELLO and (incomingAction & ACT_FLAG_INTANGIBLE) == 0 and not (incomingAction == ACT_DECELERATING or incomingAction == ACT_KIRBY_GHOST_DASH) then
                --if incomingAction == ACT_STAR_DANCE_EXIT or incomingAction == ACT_STAR_DANCE_NO_EXIT then
                    --return ACT_STAR_DANCE_WATER
                --end
                return set_mario_action(m, ACT_KIRBY_GHOST, 0)
            end
		end,
    },
}

function call_kirby_copy_hook(index, hook, ...)
    local copyData = kirbyAbilityHooks[gPlayerSyncTable[index].kirbyCopyAbility_JJJ]
    if not copyData or not copyData[hook] then return end
    return copyData[hook](...)
end

-- Creates a new entry in the ability hooks and returns the ID
local function allocate_kirby_copy(modelId)
    modelId = modelId or E_MODEL_KIRBY
    local copyNum = #kirbyAbilityHooks + 1
    kirbyAbilityHooks[copyNum] = {model = modelId}
    return copyNum
end

local function hook_kirby_copy(copyID, hook, func)
    if not kirbyAbilityHooks[copyID] then return end
    kirbyAbilityHooks[copyID][hook] = func
end

_G.kirbyDeluxe = {
    allocate_kirby_copy = allocate_kirby_copy,
    hook_kirby_copy = hook_kirby_copy,
}