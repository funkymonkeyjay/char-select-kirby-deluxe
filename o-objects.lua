-- This file defines custom objects used in "Kirby Deluxe!"

if incompatibilityCond or not charSelect then return 0 end

E_MODEL_KIRBY_STAR = smlua_model_util_get_id("kirby_star_geo")
E_MODEL_KIRBY_AIR = smlua_model_util_get_id("kirby_air_geo")
E_MODEL_KIRBY_VORTEX = smlua_model_util_get_id("vortex_geo")
smlua_anim_util_register_animation('ANIM_KIRBY_STAR_LOOP',0,0,0,1,40,{ 
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65535,65535,65535,
	65535,65535,65535,65535,65535,65535,0,0,65535,65535,65535,65535,65535,65535,65535,65535,0,0,
	63845,62061,60205,58303,56384,54481,52625,50842,49151,47634,46041,44385,42684,40959,39235,37534,35878,34284,
	32767,31251,29657,28001,26300,24576,22851,21150,19494,17901,16384,14867,13273,11617,9916,8192,6468,4767,3110,1517,0
},{1,0,1,1,1,2,40,3,10,43,40,53})

smlua_anim_util_register_animation('ANIM_KIRBY_CAP_LOOP',256,0,0,0,40,{ 
	0,0,0,65535,65535,65535,0,65535,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65535,65535,65535,65535,65535,65535,65535,
	65535,65535,65535,65535,65535,65535,65535,65535,65535,0,0,65535,0,0,0,0,0,65535,
	65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,
	65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,65535,0,1517,3110,4767,6468,
	8192,9916,11617,13273,14867,16384,17901,19494,21150,22851,24576,26300,28001,29657,31251,32767,34284,35878,
	37534,39235,40959,42684,44385,46041,47634,49151,50668,52262,53918,55619,57343,59067,60768,62425,64018,0
},{1,0,1,1,1,2,41,3,41,44,41,85});

-- INHALE PARTICLES --
local function bhv_kirby_particle_init(o)
    cur_obj_scale(2)
end

local function bhv_kirby_particle_loop(o)
    local oP = o.parentObj
    local OBJ_SPEED, SCALE_SPEED = 10, 0.25
    
    o.oPosX = approach_f32(o.oPosX, oP.oPosX, OBJ_SPEED, OBJ_SPEED)
    o.oPosY = approach_f32(o.oPosY, oP.oPosY, OBJ_SPEED, OBJ_SPEED)
    o.oPosZ = approach_f32(o.oPosZ, oP.oPosZ, OBJ_SPEED, OBJ_SPEED)
    
    o.header.gfx.scale.x = approach_f32(o.header.gfx.scale.x, 0, SCALE_SPEED, SCALE_SPEED)
    o.header.gfx.scale.y = approach_f32(o.header.gfx.scale.y, 0, SCALE_SPEED, SCALE_SPEED)
    o.header.gfx.scale.z = approach_f32(o.header.gfx.scale.z, 0, SCALE_SPEED, SCALE_SPEED)
    
    obj_update_gfx_pos_and_angle(o)
    
    if o.header.gfx.scale.x <= 0 and o.header.gfx.scale.y <= 0  and o.header.gfx.scale.z <= 0 then
        obj_mark_for_deletion(o)
    end
end

id_bhvKirbyInhaleParticle_JJJ = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_kirby_particle_init, bhv_kirby_particle_loop, "bhvKirbyInhaleParticle_JJJ")

-- INHALE --
local function bhv_kirby_effect_init(o)
    cur_obj_scale(0)
    local m = get_mario_state_from_object(o.parentObj)
    if not m then obj_mark_for_deletion(o) end
end

local function bhv_kirby_effect_loop(o)
    local m = get_mario_state_from_object(o.parentObj)
    if not m then return end

    o.oPosX, o.oPosY, o.oPosZ = m.pos.x + sins(m.faceAngle.y) * 37.5, m.pos.y + 75, m.pos.z + coss(m.faceAngle.y) * 37.5
    
    local pitch, yaw, roll = o.oTimer * 7500, m.faceAngle.y + degrees_to_sm64(90), degrees_to_sm64(90)
    obj_set_gfx_angle(o, pitch, yaw, roll)
    obj_set_face_angle(o, pitch, yaw, roll)
    
    local horizontalScale = (math.min(4, o.oTimer) / 4) * 0.1875
    
    o.header.gfx.scale.x = horizontalScale
    o.header.gfx.scale.y = (math.min(8, o.oTimer) / 8) * 0.2
    o.header.gfx.scale.z = horizontalScale
    
    local PLAYER_ANGLE_LIMIT = degrees_to_sm64(25)
    local randomLimit = math.random(-PLAYER_ANGLE_LIMIT, PLAYER_ANGLE_LIMIT)
    local angleSpawn = m.faceAngle.y + randomLimit
    if o.oTimer % 6 == 0 and o.header.gfx.scale.y >= 0.2 then
        spawn_non_sync_object(id_bhvKirbyInhaleParticle_JJJ, E_MODEL_WHITE_PARTICLE_SMALL, o.oPosX + sins(angleSpawn) * math.random(30, 175), o.oPosY - 25 + sins(randomLimit) * math.random(0, 100), o.oPosZ + coss(angleSpawn) * math.random(30, 175), function (oP) 
            oP.parentObj = o
            obj_set_billboard(oP)
        end)
    end
    
    obj_update_gfx_pos_and_angle(o)
    
    if m.action ~= ACT_KIRBY_INHALE then
        obj_mark_for_deletion(o)
    end
end

id_bhvKirbyInhale_JJJ = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_kirby_effect_init, bhv_kirby_effect_loop, "bhvKirbyInhale_JJJ")

-- STAR --
local function bhv_kirby_star_init(o)
    local m = get_mario_state_from_object(o.parentObj)
    if m then
        play_character_sound(m, CHAR_SOUND_PUNCH_YAH)
    end
    
    o.oFaceAngleRoll = 0
    o.oMoveAngleRoll = 0
    o.oBounciness = 0
    o.oDragStrength = 0
    o.oWallHitboxRadius = 60 * o.oBehParams
    
    o.oGravity = 0
    o.oFriction = 1
    o.oBuoyancy = 0
    o.oVelY = 0
    
    obj_set_billboard(o)
    
    local hitbox = get_temp_object_hitbox()
    hitbox.hurtboxRadius = 150 * o.oBehParams
    hitbox.hurtboxHeight = 300 * o.oBehParams
    hitbox.downOffset = 20
    hitbox.radius = 150 * o.oBehParams
    hitbox.height = 250 * o.oBehParams
    hitbox.damageOrCoinValue = 1
    obj_set_billboard(o)
    obj_set_hitbox(o, hitbox)
    
    cur_obj_scale(0)
    
    network_init_object(o, true, nil)
end

local objectLists = {
    OBJ_LIST_GENACTOR,
    OBJ_LIST_SURFACE,
    OBJ_LIST_PUSHABLE, 
    OBJ_LIST_PLAYER, 
}

local function bhv_kirby_star_loop(o)

    local SCALE_SIZE, SCALE_SPEED = 0.625 * o.oBehParams, 0.125 * o.oBehParams
    o.header.gfx.scale.x = approach_f32(o.header.gfx.scale.x, SCALE_SIZE, SCALE_SPEED, SCALE_SPEED)
    o.header.gfx.scale.y = approach_f32(o.header.gfx.scale.y, SCALE_SIZE, SCALE_SPEED, SCALE_SPEED)
    o.header.gfx.scale.z = approach_f32(o.header.gfx.scale.z, SCALE_SIZE, SCALE_SPEED, SCALE_SPEED)

    spawn_non_sync_object(id_bhvSparkleSpawn, E_MODEL_NONE, o.oPosX, o.oPosY + 30, o.oPosZ, function (o) end)
    smlua_anim_util_set_animation(o, "ANIM_KIRBY_STAR_LOOP")

    o.oPosY = o.oPosY + sins(o.oMoveAnglePitch) * o.oForwardVel
    obj_update_gfx_pos_and_angle(o)
    
    local hasAttacked = 0
    
    -- Recreating "obj_attack_collided_from_other_object", but taking intangibility into account.
    local numCollidedObjs = o.numCollidedObjs
    if numCollidedObjs ~= 0 then
        local other = o.collidedObjs[1]
        if other.oIntangibleTimer >= 0 and (other.oInteractType & INTERACT_PLAYER) == 0 then
            other.oInteractStatus = other.oInteractStatus | (ATTACK_PUNCH | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB)
            hasAttacked = 1
        end
    end
    
    for _, list in ipairs(objectLists) do
        local oHit = obj_get_first(list)
        while oHit do
            if o ~= oHit and oHit ~= o.parentObj then
                if obj_check_hitbox_overlap(o, oHit) and (oHit.header.gfx.node.flags & GRAPH_RENDER_INVISIBLE) == 0 then
                    if list == OBJ_LIST_PLAYER and gServerSettings.playerInteractions == PLAYER_INTERACTIONS_PVP then
                        local m = get_mario_state_from_object(oHit)
                        if m and m.playerIndex == 0 then
                            if (m.action & ACT_FLAG_INTANGIBLE) == 0 and (m.action & ACT_FLAG_INVULNERABLE) == 0 and m.invincTimer == 0 and p.kirbyCopyAbility_JJJ ~= KIRBY_COPY_GHOST and p.kirbyCopyAbility_JJJ ~= KIRBY_COPY_STEEL and (o.oInteractionSubtype & INT_SUBTYPE_DELAY_INVINCIBILITY) == 0 then
                                hasAttacked = 1
                                
                                update_mario_sound_and_camera(m)
                                
                                -- Recreating "determine_knockback_action" because the function isn't exposed to LUA for whatever reason.
                                local angleToObject = mario_obj_angle_to_object(m, o)
                                local facingDYaw = angleToObject - m.faceAngle.y
                                
                                m.faceAngle.y = angleToObject
                                
                                if (m.action & (ACT_FLAG_SWIMMING | ACT_FLAG_METAL_WATER)) ~= 0 then
                                    if m.forwardVel < 28 then mario_set_forward_vel(m, 28) end
                                    if m.pos.y >= o.oPosY then
                                        if m.vel.y < 20 then m.vel.y = 20 end
                                    else
                                        if m.vel.y > 0 then m.vel.y = 0 end
                                    end
                                else
                                    if m.forwardVel < 16 then mario_set_forward_vel(m, 16) end
                                end
                                
                                local actionToSet = ACT_BACKWARD_GROUND_KB
                                if -0x4000 <= facingDYaw and facingDYaw <= 0x4000 then
                                    m.forwardVel = -m.forwardVel
                                    if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
                                        actionToSet = ACT_BACKWARD_WATER_KB
                                    elseif (m.action & ACT_FLAG_AIR) ~= 0 then
                                        actionToSet = ACT_BACKWARD_AIR_KB
                                    end
                                else
                                    m.faceAngle.y = m.faceAngle.y + 0x8000
                                    actionToSet = ACT_FORWARD_GROUND_KB
                                    if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
                                        actionToSet = ACT_FORWARD_AIR_KB
                                    elseif (m.action & ACT_FLAG_AIR) ~= 0 then
                                        actionToSet = ACT_FORWARD_WATER_KB
                                    end
                                end

                                hurt_and_set_mario_action(m, actionToSet, 0, 4)
                                play_kirby_sound(KIRBY_HIT_SOUND, o.header.gfx.pos, 0.5)
                            end
                        end
                    elseif obj_has_behavior_id(oHit, id_bhvMrI) == 1 then
                        play_kirby_sound(KIRBY_HIT_SOUND, o.header.gfx.pos, 0.5)
                        oHit.oAction = 3
                        hasAttacked = 1
                        break
                    else
                        if oHit.oHeldState == HELD_FREE and oHit.oIntangibleTimer >= 0 then
                            if (oHit.oInteractType == INTERACT_BREAKABLE or oHit.oInteractType == INTERACT_BULLY or oHit.oInteractType == INTERACT_SPINY_WALKING or obj_is_attackable(oHit))
                                and obj_has_behavior_id(oHit, id_bhvBowser) == 0 then
                                hasAttacked = 1
                                if oHit.oInteractType == INTERACT_BULLY then
                                    oHit.oFaceAngleYaw = o.oMoveAngleYaw
                                    oHit.oMoveAngleYaw = oHit.oFaceAngleYaw
                                    oHit.oForwardVel = o.oForwardVel * 1.5
                                    hasAttacked = 2
                                end
                                oHit.oInteractStatus = oHit.oInteractStatus | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB | ATTACK_PUNCH
                                play_kirby_sound(KIRBY_HIT_SOUND, o.header.gfx.pos, 0.5)
                                if hasAttacked > 1 then break end
                            end
                        end
                    end
                end
            end
            oHit = obj_get_next(oHit)
        end
    end
    
    local pastX, pastZ = o.oPosX, o.oPosZ
    cur_obj_update_floor_and_walls()
    cur_obj_move_standard(78) -- Added so that the object can move on slopes
    
    if (o.oMoveFlags & OBJ_MOVE_HIT_WALL) ~= 0 or (o.oBehParams <= 1 and hasAttacked == 1) or hasAttacked >= 2 or ((pastX == o.oPosX) or (pastZ == o.oPosZ)) then -- Added failsafe for standstill star bullets.
        play_kirby_sound(KIRBY_HIT_SOUND, o.header.gfx.pos, 1)
        spawn_mist_particles()
        spawn_triangle_break_particles(10, 139, 0.2, 3)
        obj_mark_for_deletion(o)
    end
end

id_bhvKirbyStar_JJJ = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_kirby_star_init, bhv_kirby_star_loop, "bhvKirbyStar_JJJ")

-- AIR --
local function bhv_kirby_air_init(o)

    o.oFaceAngleRoll = 0
    o.oMoveAngleRoll = 0
    o.oBounciness = 0
    o.oDragStrength = 0
    o.oWallHitboxRadius = 60
    
    o.oGravity = 0
    o.oFriction = 1
    o.oBuoyancy = 0
    o.oVelY = 0
    
    local hitbox = get_temp_object_hitbox()
    hitbox.hurtboxRadius = 75
    hitbox.hurtboxHeight = 150
    hitbox.radius = 75
    hitbox.height = 125
    hitbox.damageOrCoinValue = 1
    obj_set_billboard(o)
    obj_set_hitbox(o, hitbox)
    
    cur_obj_scale(2.5)
    
    network_init_object(o, true, nil)
end

local function bhv_kirby_air_loop(o)
    o.oPosX, o.oPosZ = o.oPosX + sins(o.oMoveAngleYaw) * o.oForwardVel, o.oPosZ + coss(o.oMoveAngleYaw) * o.oForwardVel
    obj_update_gfx_pos_and_angle(o)
    
    o.oForwardVel = approach_f32(o.oForwardVel, 0, 7.5, 7.5)
    
    local hasAttacked = obj_attack_collided_from_other_object(o)
    for _, list in ipairs(objectLists) do
        local oHit = obj_get_first(list)
        while oHit do
            if o ~= oHit then
                if oHit.oHeldState == HELD_FREE and obj_check_hitbox_overlap(o, oHit) then
                    if (oHit.oInteractType == INTERACT_BREAKABLE or obj_is_attackable(oHit)) and obj_has_behavior_id(oHit, id_bhvBowser) == 0 then
                        oHit.oInteractStatus = oHit.oInteractStatus | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB | ATTACK_PUNCH
                        hasAttacked = 1
                    end
                end
            end
            oHit = obj_get_next(oHit)
        end
    end
    
    cur_obj_update_floor_and_walls()
    
    if (o.oMoveFlags & OBJ_MOVE_HIT_WALL) ~= 0 or o.oForwardVel <= 0 or hasAttacked ~= 0 then
        spawn_mist_particles_variable(20, -20, 10)
        obj_mark_for_deletion(o)
    else
        if o.oForwardVel > 10 then
            spawn_non_sync_object(id_bhvMistParticleSpawner, E_MODEL_NONE, o.oPosX, o.oPosY - 25, o.oPosZ, function(o)
                o.oForwardVel = 0
            end)
        end
    end
    
end

id_bhvKirbyAir_JJJ = hook_behavior(nil, OBJ_LIST_PUSHABLE, true, bhv_kirby_air_init, bhv_kirby_air_loop, "bhvKirbyAir_JJJ")