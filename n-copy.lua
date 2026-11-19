gPlayerSyncTable[0].kirbyCopyAbility_JJJ = 0
gPlayerSyncTable[0].kirbyToAbility = 0

gPlayerSyncTable[0].kirbyIsAbilityAction = false

ACT_KIRBY_GHOST = allocate_mario_action(ACT_FLAG_INVULNERABLE | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_KIRBY_GHOST_DASH = allocate_mario_action(ACT_FLAG_INVULNERABLE | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_ATTACKING | ACT_FLAG_METAL_WATER)

hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, function(m, isWater) if m.action == ACT_KIRBY_GHOST or m.action == ACT_KIRBY_GHOST_DASH then return false end end)

local toApplyVel = 0
function act_kirby_ghost(m)
	local p = gPlayerSyncTable[m.playerIndex]
    if p.kirbyCopyAbility_JJJ ~= KIRBY_COPY_GHOST then
        m.vel.y = 0
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    if m.actionTimer == 0 then   
        --intendedYaw = m.faceAngle.y 
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

    local toSpeed = m.intendedMag/32 * 32

    if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
        return set_mario_action(m, ACT_KIRBY_GHOST_DASH, 0)
    end

    if is_anim_at_end(m) ~= 0 then
        set_mario_animation(m, CHAR_ANIM_WATER_IDLE)
    end

    m.forwardVel = math.lerp(m.forwardVel, toSpeed, 0.05)

    m.vel.x = math.lerp(m.vel.x, m.forwardVel * sins(m.intendedYaw), 0.1)
    m.vel.z = math.lerp(m.vel.z, m.forwardVel * coss(m.intendedYaw), 0.1)

    local dirAngle = (m.vel.z == 0 and m.vel.x == 0) and m.faceAngle.y or atan2s(m.vel.z, m.vel.x)
    m.faceAngle.y = approach_s16_symmetric(m.faceAngle.y, dirAngle, 1000)
    m.marioObj.header.gfx.angle.x = math.lerp(m.marioObj.header.gfx.angle.x, m.vel.y * 2400, 0.1)
    m.faceAngle.x = m.marioObj.header.gfx.angle.x
end

function act_kirby_ghost_dash(m)
	local p = gPlayerSyncTable[m.playerIndex]
    m.vel.y = 0

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

    m.vel.x = math.lerp(m.vel.x, m.forwardVel * sins(m.faceAngle.y), 0.1)
    m.vel.z = math.lerp(m.vel.z, m.forwardVel * coss(m.faceAngle.y), 0.1)
end

hook_mario_action(ACT_KIRBY_GHOST, act_kirby_ghost)
hook_mario_action(ACT_KIRBY_GHOST_DASH, act_kirby_ghost_dash)

-- Copy Ability Handler for Kirby

KIRBY_COPY_NONE = 0
KIRBY_COPY_ANGEL = 1
KIRBY_COPY_STEEL = 2
KIRBY_COPY_GHOST = 3

local E_MODEL_KIRBY_GHOST = smlua_model_util_get_id("kirby_ghost_geo")
local E_MODEL_KIRBY_METAL = smlua_model_util_get_id("kirby_metal_geo")

local UvScroll = require("/lib/uv-scroll") -- Library made by @djoslin, used to give Ghost Kirby's lower "bedsheet" torso a sort of animation.
UvScroll.hook_scrolling_function("kirby_ghost_Torso_mesh_layer_5_tri_0", function(input_vtx, original_uv, current_uv) local speed = 50; current_uv[1] = current_uv[1] + speed end)

hook_behavior(id_bhvTreeLeaf, OBJ_LIST_UNIMPORTANT, false, nil, function (o) -- Allows for enemy collision!
    if o.oBehParams == 1 then
        local hasAttacked = obj_attack_collided_from_other_object(o)
        for _, list in ipairs({OBJ_LIST_GENACTOR, OBJ_LIST_SURFACE, OBJ_LIST_PUSHABLE, OBJ_LIST_PLAYER}) do
            local oHit = obj_get_first(list)
            while oHit do
                if o ~= oHit then
                    if oHit.oHeldState == HELD_FREE and obj_check_hitbox_overlap(o, oHit) then
                        if (oHit.oInteractType == INTERACT_BREAKABLE or obj_is_attackable(oHit)) and obj_has_behavior_id(oHit, id_bhvBowser) == 0 then
                            oHit.oInteractStatus = oHit.oInteractStatus | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB | ATTACK_PUNCH
                            play_kirby_sound(KIRBY_HIT_SOUND, o.header.gfx.pos, 0.5)
                            hasAttacked = 1
                        end
                    end
                end
                oHit = obj_get_next(oHit)
            end
        end
        if hasAttacked == 1 then
            obj_mark_for_deletion(o)
        end
    end
end)

kirbyAbilityHooks = {
    [KIRBY_COPY_NONE] = {
        model = E_MODEL_KIRBY,
    },
    [KIRBY_COPY_ANGEL] = {
        model = E_MODEL_KIRBY,
        [HOOK_MARIO_UPDATE] = function (m)
            local p = gPlayerSyncTable[m.playerIndex]
            m.flags = m.flags | MARIO_WING_CAP
            if m.action == ACT_FREEFALL and p.kirbyIsAbilityAction then
                m.forwardVel = math.min(m.forwardVel, 12)
            elseif m.action == ACT_PLACING_DOWN and p.kirbyIsAbilityAction then
                smlua_anim_util_set_animation(m.marioObj, "KIRBY_WING_LEAF")
                m.marioBodyState.eyeState = 11
                if (m.input & INPUT_B_PRESSED) ~= 0 then
                    play_sound(SOUND_GENERAL_SWISH_AIR, m.marioObj.header.gfx.cameraToObject)
                    m.marioObj.header.gfx.animInfo.animID = -1
                    m.marioObj.header.gfx.animInfo.animFrame = 0
                    if m.playerIndex == 0 then
                        spawn_sync_object(id_bhvTreeLeaf, E_MODEL_LEAVES, m.pos.x + sins(m.faceAngle.y) * 50, m.pos.y + 40, m.pos.z + coss(m.faceAngle.y) * 50, function (o)
                            obj_scale_xyz(o, 1.5, 3, 1.5)
                            o.oForwardVel = 43.75
                            local angle = degrees_to_sm64(25)
                            o.oMoveAngleYaw = m.faceAngle.y + ((random_float() * angle * 2) - angle)
                            o.oVelY = random_float() * 30
                            o.oFaceAnglePitch = degrees_to_sm64(90)
                            o.oBehParams = 1
                        end)
                    end
                    -- Spawn leaf object
                end
            elseif smlua_anim_util_get_current_animation_name(m.marioObj) == "KIRBY_WING_FLY_START" then
                set_mario_particle_flags(m, PARTICLE_SPARKLES, 0)
            else
                p.kirbyIsAbilityAction = false
            end
        end,
        [HOOK_BEFORE_SET_MARIO_ACTION] = function (m, incomingAction)
            local p = gPlayerSyncTable[m.playerIndex]
            if incomingAction == ACT_KIRBY_PUFF then
                local ceilingValue = p.kirbyPuffCeiling_JJJ + 750
                local flapPosition = math.max(ceilingValue - m.pos.y, 0)
                local flapPower = flapPosition / 1000
                
                m.vel.y = 35 * math.clamp(flapPower, 0, 1)
                p.kirbyIsAbilityAction = true
                play_sound(SOUND_GENERAL_SWISH_WATER, m.marioObj.header.gfx.cameraToObject)

                return ACT_FREEFALL
            end
            if (incomingAction == ACT_PUNCHING and m.action ~= ACT_CROUCHING) or incomingAction == ACT_MOVE_PUNCHING then
                p.kirbyIsAbilityAction = true
                --play_sound(SOUND_GENERAL_SWISH_AIR, m.marioObj.header.gfx.cameraToObject)
                return ACT_PLACING_DOWN
            end
            if incomingAction == ACT_DIVE or (incomingAction == ACT_JUMP_KICK and m.action ~= ACT_KIRBY_PUFF) then
                m.forwardVel = 75
                m.faceAngle.x, m.faceAngle.z = m.pos.y == m.floorHeight and 1800 or 0, 0
                play_sound(SOUND_ACTION_FLYING_FAST, m.marioObj.header.gfx.cameraToObject)
                set_mario_particle_flags(m, PARTICLE_DUST, 0)
                m.vel.y = 50
                return ACT_FLYING
            end
        end, 
    },
    [KIRBY_COPY_STEEL] = {
        model = E_MODEL_KIRBY_METAL,
        [HOOK_MARIO_UPDATE] = function (m)
            m.flags = m.flags | MARIO_METAL_CAP

            if m.action == ACT_WALKING then
                m.marioObj.header.gfx.animInfo.animAccel = m.marioObj.header.gfx.animInfo.animAccel * 0.625
            end

            local idx = m.playerIndex
            if idx ~= 0 then return end

            if gPlayerSyncTable[0].kirbyIsAbilityAction and (m.action == ACT_BUTT_SLIDE_AIR or m.action == ACT_BUTT_SLIDE or m.action == ACT_BUTT_SLIDE_STOP) then
                if m.action == ACT_BUTT_SLIDE then
                    m.slideVelX = m.slideVelX * 1.0375
                    m.slideVelZ = m.slideVelZ * 1.0375
                end
                gPlayerSyncTable[idx].kirbyScaleY = 1000; m.marioObj.header.gfx.scale.y = 1
                m.marioBodyState.torsoAngle.x, m.marioBodyState.torsoAngle.y, m.marioBodyState.torsoAngle.z = 0, 0, 0
                m.marioObj.header.gfx.animInfo.animAccel = ((math.abs(m.forwardVel) - 4) / 46) * 65536
                if m.action ~= ACT_BUTT_SLIDE_AIR then
                    if (m.input & INPUT_A_DOWN) ~= 0 then
                        set_mario_action(m, ACT_JUMP, 0)
                    end
                    if (m.input & INPUT_B_PRESSED) ~= 0 and find_floor_slope(m, 0) < 6000 then
                        play_character_sound(m, CHAR_SOUND_YAH_WAH_HOO)
                        m.vel.y = 45
                        m.forwardVel = 50
                        set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE, 0)
                        set_mario_action(m, ACT_BUTT_SLIDE_AIR, 0)
                    end
                end
            else
                gPlayerSyncTable[0].kirbyIsAbilityAction = false
            end
        end,
        [HOOK_BEFORE_SET_MARIO_ACTION] = function (m, incomingAction)
            local idx = m.playerIndex
            if idx ~= 0 then return end
            if gPlayerSyncTable[0].kirbyIsAbilityAction and incomingAction == ACT_BUTT_SLIDE_STOP then
                return ACT_JUMP
            end
            if (incomingAction == ACT_PUNCHING and m.action ~= ACT_CROUCHING) or incomingAction == ACT_MOVE_PUNCHING
             or incomingAction == ACT_DIVE or (incomingAction == ACT_JUMP_KICK and m.action ~= ACT_KIRBY_PUFF) then
                play_character_sound(m, CHAR_SOUND_YAH_WAH_HOO)
                m.vel.y = 75
                m.forwardVel = 50
                gPlayerSyncTable[0].kirbyIsAbilityAction = true
                set_mario_particle_flags(m, PARTICLE_DUST, 0)
                play_sound(SOUND_ACTION_METAL_LANDING, m.marioObj.header.gfx.cameraToObject)
                return ACT_BUTT_SLIDE_AIR
            end
        end, 
        [HOOK_BEFORE_PHYS_STEP] = function(m, stepType)
            local hScale, vScale = 1.0, 1.0

			if m.action == ACT_KIRBY_PUFF then
				vScale = vScale * (m.vel.y > 0 and 0.7 or 1.2)
			else
				if m.vel.y > 0 then vScale = vScale * 0.9375 end
			end
			if (m.action & ACT_FLAG_AIR) == 0 and m.action ~= ACT_KIRBY_SLIDE and m.action ~= ACT_BUTT_SLIDE and m.action ~= ACT_BUTT_SLIDE_AIR then
				hScale = hScale * 0.625
			end

            m.vel.x = m.vel.x * hScale
            m.vel.y = m.vel.y * vScale
            m.vel.z = m.vel.z * hScale
        end,
    },
    [KIRBY_COPY_GHOST] = {
        model = E_MODEL_KIRBY_GHOST,
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
        [HOOK_ALLOW_INTERACT] = function (m, o, intType)
            if (m.action == ACT_KIRBY_GHOST) then
                if obj_has_behavior_id(o, id_bhvDoorWarp) ~= 0 then
                    set_mario_action(m, ACT_DECELERATING, 0)
                    interact_warp_door(m, 0, o)
                elseif obj_has_behavior_id(o, id_bhvDoor) ~= 0 or obj_has_behavior_id(o, id_bhvStarDoor) ~= 0 then
                    set_mario_action(m, ACT_DECELERATING, 0)
                    interact_door(m, 0, o)
                elseif obj_has_behavior_id(o, id_bhvWarp) ~= 0 then
                    set_mario_action(m, ACT_DECELERATING, 0)
                    interact_warp(m, 0, o)
                end
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

--_G.kirbyDeluxe = {
kirbyDeluxe.allocate_kirby_copy = allocate_kirby_copy
kirbyDeluxe.hook_kirby_copy = hook_kirby_copy
--}

-- Character Select hook to remove powerups + Dedede hammer on character change.
charSelect.hook_on_character_change(function (currChar, prevChar)
    local p, m = gPlayerSyncTable[0], gMarioStates[0]
    p.kirbyMouthCounter_JJJ = 0
    
    p.dededeIsHammer_JJJ = false
    if currChar == kirbyCharID or currChar == dededeCharID then
        if currChar == kirbyCharID and p.kirbyCopyAbility_JJJ ~= 0 and not isMovesetOff() then
            m.flags = m.flags & ~(MARIO_WING_CAP | MARIO_METAL_CAP | MARIO_VANISH_CAP)
            p.kirbyCopyAbility_JJJ = 0
        end
        p.kirbyToAbility = 0
        m.marioBodyState.punchState = 0 -- Reset punchState for local player.
    end
    
end)