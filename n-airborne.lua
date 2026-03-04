if not _G.charSelectExists then return 0 end
local csVersion = _G.charSelect.version_get_full()
if csVersion.major < 16 then return 0 end
if VERSION_NUMBER < 40 then return 0 end

-- CONFIG HOVER MOVE

local modConfigName = "kirbyInfinitePuff_JJJ"
local kirbyInfinitePuff = false
local puffCondExists = mod_storage_exists(modConfigName)
if puffCondExists then
	kirbyInfinitePuff = mod_storage_load_bool(modConfigName)
else
	kirbyInfinitePuff = false
	mod_storage_save_bool(modConfigName, false)
end

local function kirbyInfinitePuffToggle(index, value)
    kirbyInfinitePuff = value
    mod_storage_save_bool(modConfigName, value)
end

hook_mod_menu_checkbox("Infinite Hover (Recommended For ROM hacks)", kirbyInfinitePuff, kirbyInfinitePuffToggle)

-- AIRBORNE ACTS

ACT_KIRBY_SLIDE = allocate_mario_action(0x0AA | ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
ACT_KIRBY_PUFF = allocate_mario_action(0x080 | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT)
ACT_KIRBY_DODGE = allocate_mario_action(0x080 | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_CONTROL_JUMP_HEIGHT)

function act_kirby_slide(m)
	if m.actionState == 0 and m.actionTimer == 0 then
		set_mario_animation(m, MARIO_ANIM_SLIDE_KICK)
	end

	m.actionTimer = m.actionTimer + 1
	if m.actionTimer > 30 and m.pos.y - m.floorHeight > 250.0 then
		return set_mario_action(m, ACT_FREEFALL, 2)
	end

	update_air_without_turn(m)
	
	local stepCase = perform_air_step(m, 0)
	if stepCase == AIR_STEP_NONE then
		if m.actionState == 0 then
			m.marioObj.header.gfx.angle.x = atan2s(m.forwardVel, -m.vel.y)
			if m.marioObj.header.gfx.angle.x > 0x1800 then
				m.marioObj.header.gfx.angle.x = 0x1800
			end
		end
	elseif stepCase == AIR_STEP_LANDED then
		set_mario_action(m, ACT_SLIDE_KICK_SLIDE, 0)
		play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
	elseif stepCase == AIR_STEP_HIT_LAVA_WALL then
		lava_boost_on_wall(m)
	end

	return false
end

function lerpKirbyAngle(a, b, t)
	local aConvert, bConvert = sm64_to_radians(a), sm64_to_radians(b)
    local delta = (bConvert - aConvert + math.pi) % (2 * math.pi) - math.pi
    return radians_to_sm64((aConvert + delta * t) % (2 * math.pi))
end

local function s16(num)
    num = math.floor(num) & 0xFFFF
    if num >= 32768 then return num - 65536 end
    return num
end

function act_kirby_puff(m)
	local idx = m.playerIndex
	local VELOCITY_AMPLITUDE = 20
	local TIMER_LIMIT = 250

	gPlayerSyncTable[idx].kirbyHasPuffed_JJJ = true
	if not kirbyInfinitePuff and idx == 0 then
		gPlayerSyncTable[idx].kirbyPuffTimer_JJJ = gPlayerSyncTable[idx].kirbyPuffTimer_JJJ + 1
	end
	local kirbyIsTired = gPlayerSyncTable[idx].kirbyPuffTimer_JJJ > TIMER_LIMIT
	
	if kirbyIsTired then
		if gPlayerSyncTable[idx].kirbyPuffTimer_JJJ % 13 == 0 then -- Spawns Particles.
			for i = 0, 2 do
				spawn_non_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PARTICLE_SMALL, m.pos.x, m.pos.y + 48, m.pos.z, function(o)
					o.oVelY = 12 + 12 * random_float()
					o.oForwardVel = 12 + 12 * random_float()
					o.oMoveAngleYaw = random_u16()
				end)
			end
		end
	end
	
	if (m.input & INPUT_B_PRESSED) ~= 0 or (kirbyIsTired and (m.pos.y == m.floorHeight or gPlayerSyncTable[idx].kirbyPuffTimer_JJJ > 450)) then
		gPlayerSyncTable[idx].kirbyPuffTimer_JJJ = 0
		set_mario_action(m, ACT_JUMP_KICK, 0)
		m.vel.y = 24
		return
	end
	
	if (m.input & INPUT_Z_PRESSED) ~= 0 then
		gPlayerSyncTable[idx].kirbyPuffTimer_JJJ = 0
		return set_mario_action(m, ACT_GROUND_POUND, 0)
    end

	if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_DOUBLE_JUMP_RISE and is_anim_at_end(m) == 1 then
		set_mario_animation(m, MARIO_ANIM_DOUBLE_JUMP_FALL)
	end

	local pressedButton = (m.input & INPUT_A_PRESSED) ~= 0
	if (m.controller.buttonDown & A_BUTTON) ~= 0 or pressedButton then
		if is_anim_at_end(m) == 1 or pressedButton then
			play_character_sound(m, CHAR_SOUND_HOOHOO)
			set_mario_animation(m, MARIO_ANIM_DOUBLE_JUMP_RISE)
			if not kirbyIsTired then
				local truePuffPower
				if kirbyInfinitePuff and idx == 0 then
					truePuffPower = 1
				else
					local ceilingValue = gPlayerSyncTable[idx].kirbyPuffCeiling_JJJ
					local puffPosition = ceilingValue - m.marioObj.header.gfx.pos.y
					local puffPosMax = math.max(puffPosition, 0)
					
					local puffPower = puffPosMax / 800
					
					local maxClamp = math.max(puffPower, 0)
					truePuffPower = math.min(maxClamp, 1)
				end
				
				m.vel.y = VELOCITY_AMPLITUDE * truePuffPower
			end
		end
	end
	
	if gPlayerSyncTable[idx].kirbyHasMovedStick_JJJ then
		m.forwardVel = approach_s32(m.forwardVel, math.min(m.forwardVel, 16), 0x400, 0x25)
	else
		m.forwardVel = gPlayerSyncTable[idx].forwardVel
		gPlayerSyncTable[idx].kirbyHasMovedStick_JJJ = m.intendedMag ~= 0
	end
	
	update_air_without_turn(m)
	
	local stepCase = perform_air_step(m, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG)
	m.faceAngle.y = m.intendedYaw - approach_s32(s16(m.intendedYaw - m.faceAngle.y), 0, 0x400, 0x400)
	
	if stepCase == AIR_STEP_GRABBED_LEDGE then
        drop_and_set_mario_action(m, ACT_LEDGE_GRAB, 0)
	elseif stepCase == AIR_STEP_GRABBED_CEILING then
        set_mario_action(m, ACT_START_HANGING, 0)
	end
	
	return 0
end