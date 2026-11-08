if incompatibilityCond then return 0 end

local MARIO_MOUTH_NORMAL, MARIO_MOUTH_HAPPY, MARIO_MOUTH_SMILE, MARIO_MOUTH_FROWN, MARIO_MOUTH_OPEN, MARIO_MOUTH_EVIL = 0, 1, 2, 3, 4, 5
local MARIO_EYES_SHOCKED, MARIO_EYES_CLOSED_INTENSE, MARIO_EYES_ANGRY, MARIO_EYES_EVIL = 9, 10, 11, 12

CHAR_ANIM_KIRBY_INHALE_IDLE =    CHAR_ANIM_MAX + 19920
CHAR_ANIM_KIRBY_INHALE_MOVE =    CHAR_ANIM_MAX + 19921
CHAR_ANIM_KIRBY_HELLO =          CHAR_ANIM_MAX + 19922
CHAR_ANIM_KIRBY_PUFF_RISE =      CHAR_ANIM_MAX + 19923
CHAR_ANIM_KIRBY_PUFF_FALL =      CHAR_ANIM_MAX + 19924
CHAR_ANIM_KIRBY_ENDING =         CHAR_ANIM_MAX + 19925
CHAR_ANIM_KIRBY_DEATH =          CHAR_ANIM_MAX + 19926
CHAR_ANIM_KIRBY_DEATH_END =      CHAR_ANIM_MAX + 19927
CHAR_ANIM_KIRBY_DODGE_LEFT =     CHAR_ANIM_MAX + 19928
CHAR_ANIM_KIRBY_DODGE_RIGHT =    CHAR_ANIM_MAX + 19929
CHAR_ANIM_KIRBY_DODGE_FRONT =    CHAR_ANIM_MAX + 19930
CHAR_ANIM_KIRBY_DODGE_BACK =     CHAR_ANIM_MAX + 19931
CHAR_ANIM_KIRBY_DODGE_LAND =     CHAR_ANIM_MAX + 19932

CHAR_ANIM_DEDEDE_SPIN =            CHAR_ANIM_MAX + 19933
CHAR_ANIM_DEDEDE_FULL_IDLE =       CHAR_ANIM_MAX + 19934
CHAR_ANIM_DEDEDE_FULL_MOVE_LEFT =  CHAR_ANIM_MAX + 19935
CHAR_ANIM_DEDEDE_FULL_MOVE_RIGHT = CHAR_ANIM_MAX + 19936
CHAR_ANIM_DEDEDE_HAMMER_AIR =      CHAR_ANIM_MAX + 19937
CHAR_ANIM_DEDEDE_JUMP_START =      CHAR_ANIM_MAX + 19938
CHAR_ANIM_DEDEDE_JUMP =            CHAR_ANIM_MAX + 19939
CHAR_ANIM_DEDEDE_JUMP_LAND =       CHAR_ANIM_MAX + 19940
CHAR_ANIM_DEDEDE_DIZZY =           CHAR_ANIM_MAX + 19941
CHAR_ANIM_DEDEDE_HAMMER_UP =       CHAR_ANIM_MAX + 19942
CHAR_ANIM_DEDEDE_HAMMER_DOWN =     CHAR_ANIM_MAX + 19943
CHAR_ANIM_DEDEDE_GORDO =           CHAR_ANIM_MAX + 19944
CHAR_ANIM_DEDEDE_GORDO_FLIP =      CHAR_ANIM_MAX + 19945

local function determineFatAnim(m, name)
	local inbetween = ""
	if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ ~= 0 then inbetween = "FAT_" end
	return "KIRBY_" .. inbetween .. name
end

-- Function to give characters unique angry faces when they're interacting with a boss. (TAKEN FROM SPLATIDOLS 64)
local DIST_LIMIT = 2000
local function checkForBoss(m)
	if m.action ~= ACT_READING_NPC_DIALOG then return false end
	local bossList = {id_bhvKingBobomb,id_bhvWhompKingBoss,id_bhvWigglerHead,id_bhvWigglerBody,id_bhvBowser,id_bhvEyerokHand,id_bhvEyerokBoss} -- Listing boss behavior IDs with text, although Eyerok's dialog gets skipped in Co-op DX for some reason.
	local hasBoss = false
	for i = 1,#bossList do
		local currBoss = bossList[i]
		local o = obj_get_first_with_behavior_id(currBoss)
		while o do
			local distToPlayer = calc_abs_dist({x = o.oPosX,y = o.oPosY,z = o.oPosZ},{x = m.pos.x,y = m.pos.y,z = m.pos.z})
			hasBoss = distToPlayer < DIST_LIMIT
			o = obj_get_next_with_same_behavior_id(o)
		end
	end
	return hasBoss
end

kirbyAnims = {
	mouth = {
		[CHAR_ANIM_IDLE_ON_POLE] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_CREDITS_WAVING] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_CREDITS_TAKE_OFF_CAP] = function (m, frame) if frame > 10 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_FINAL_BOWSER_RAISE_HAND_SPIN] = function (m, frame) if frame > 40 and frame < 62 then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_HAPPY end, 
		[CHAR_ANIM_FINAL_BOWSER_WING_CAP_TAKE_OFF] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_CREDITS_PEACE_SIGN] = function (m, frame) if frame > 97 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_WING_CAP_FLY] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_HANG_ON_OWL] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_LAND_ON_STOMACH] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_THROW_CATCH_KEY] = function (m, frame) if frame > 34 and frame < 60 then return MARIO_MOUTH_HAPPY elseif frame >= 60 then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_TRIPLE_JUMP_GROUND_POUND] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_START_GROUND_POUND] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_GROUND_POUND] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_BOTTOM_STUCK_IN_GROUND] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_RIDING_SHELL] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_WALKING] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_JUMP_RIDING_SHELL] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_BEND_KNESS_RIDING_SHELL] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_FLY_FROM_CANNON] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_PUSHING] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_IDLE_IN_QUICKSAND] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_IDLE_HEAVY_OBJ] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_CROUCHING] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_SUMMON_STAR] = function (m, frame) if frame > 27 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_WATER_STAR_DANCE] = function (m, frame) if frame > 64 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_START_CROUCHING] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_CROUCH_FROM_FAST_LONGJUMP] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_CROUCH_FROM_SLOW_LONGJUMP] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_GRAB_BOWSER] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_RELEASE_BOWSER] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_WALK_WITH_HEAVY_OBJ] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_SLIDEJUMP] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_START_WALLKICK] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_FORWARD_SPINNING_FLIP] = function (m, frame) if frame > 10 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_TRIPLE_JUMP_FLY] = MARIO_MOUTH_SMILE, 
		[charSelect.CS_ANIM_MENU] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_STAR_DANCE] = function (m, frame) if frame > 48 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = function (m, frame) if frame > 30 then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_MISSING_CAP] =          function (m, frame) if frame > 30 then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_KIRBY_HELLO] = function (m, frame) if frame > 8 and frame < 36 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_PUT_CAP_ON] = function (m, frame) if frame > 19 and frame < 32 then return MARIO_MOUTH_HAPPY end return MARIO_MOUTH_SMILE end, 
		[CHAR_ANIM_FIRST_PERSON] = function (m, frame) return checkForBoss(m) and MARIO_MOUTH_FROWN or MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_CREDITS_LOOK_UP] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_IDLE_HEAD_LEFT] = function (m, frame) if gPlayerSyncTable[m.playerIndex].kirbyAltCostume == kirbyRetroCosID then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_IDLE_HEAD_RIGHT] = function (m, frame) if gPlayerSyncTable[m.playerIndex].kirbyAltCostume == kirbyRetroCosID then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_IDLE_HEAD_CENTER] = function (m, frame) if gPlayerSyncTable[m.playerIndex].kirbyAltCostume == kirbyRetroCosID then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_KIRBY_ENDING] = function (m, frame)
			if frame > 21 and frame < 87 then
				return MARIO_MOUTH_OPEN
			elseif (frame > 118 and frame < 129) or frame >= 190 then
				return MARIO_MOUTH_SMILE
			elseif frame >= 129 and frame < 190 then
				return MARIO_MOUTH_HAPPY
			end
			return MARIO_MOUTH_NORMAL
		end, 
		[CHAR_ANIM_WATER_IDLE] = function (m, frame) if m.action == ACT_KIRBY_GHOST_DASH then return MARIO_MOUTH_SMILE end end, 
		[CHAR_ANIM_SWIM_PART1] = function (m, frame) if (m.flags & MARIO_VANISH_CAP) ~= 0 then return MARIO_MOUTH_EVIL end end, 
		[CHAR_ANIM_KIRBY_DEATH_END] = function (m, frame) if frame < 10 then return MARIO_MOUTH_NORMAL end return MARIO_MOUTH_FROWN end, 
		[CHAR_ANIM_KIRBY_DODGE_LEFT] = MARIO_MOUTH_OPEN, 
		[CHAR_ANIM_KIRBY_DODGE_RIGHT] = MARIO_MOUTH_OPEN, 
		[CHAR_ANIM_KIRBY_DODGE_FRONT] = MARIO_MOUTH_OPEN, 
		[CHAR_ANIM_KIRBY_DODGE_BACK] = MARIO_MOUTH_OPEN, 
	}, 
	eyes = {
		[CHAR_ANIM_FINAL_BOWSER_RAISE_HAND_SPIN] = function (m, frame) if frame > 62 and frame < 99 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_FALL_OVER_BACKWARDS] = function (m, frame) if frame < 40 then return MARIO_EYES_SHOCKED end return MARIO_EYES_CLOSED_INTENSE end, 
		[CHAR_ANIM_BACKWARD_AIR_KB] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_A_POSE] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_SKID_ON_GROUND] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_CREDITS_RAISE_HAND] = function (m, frame) if frame > 68 then return MARIO_EYES_SHOCKED end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_CREDITS_LOWER_HAND] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_CREDITS_PEACE_SIGN] = function (m, frame) if frame < 50 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_STAND_UP_FROM_LAVA_BOOST] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_LAND_ON_STOMACH] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_AIR_FORWARD_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_COUGHING] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_THROW_CATCH_KEY] = function (m, frame) if frame > 60 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_HEAD_STUCK_IN_GROUND] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_TRIPLE_JUMP_GROUND_POUND] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_START_GROUND_POUND] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_GROUND_POUND] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_JUMP_RIDING_SHELL] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_LEGS_STUCK_IN_GROUND] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_FIRE_LAVA_BURN] = MARIO_EYES_DEAD, 
		[CHAR_ANIM_BEING_GRABBED] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_GRAB_HEAVY_OBJECT] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_PUSHING] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_SOFT_BACK_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_SOFT_FRONT_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_DYING_IN_QUICKSAND] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_BACKWARD_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_FORWARD_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_IDLE_HEAVY_OBJ] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_GROUND_BONK] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_BACKWARDS_WATER_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_DROWNING_PART1] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_WATER_FORWARD_KB] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_WATER_STAR_DANCE] = function (m, frame) if frame > 18 and frame < 50 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_GRAB_BOWSER] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_SWINGING_BOWSER] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_HOLDING_BOWSER] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_HEAVY_THROW] = function (m, frame) if frame < 10 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_ANGRY end, 
		[CHAR_ANIM_WALK_WITH_HEAVY_OBJ] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_TURNING_PART1] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_TURNING_PART2] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_STAR_DANCE] = function (m, frame) if frame < 5 then return MARIO_EYES_BLINK elseif frame >= 5 and frame < 29 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = function (m, frame) if frame > 5 and frame < 30 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_MISSING_CAP] =          function (m, frame) if frame > 5 and frame < 30 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_KIRBY_INHALE_IDLE] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_PUFF_RISE] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_PUFF_FALL] = function (m, frame) if m.actionTimer > 240 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_SLIDE_KICK] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_RELEASE_BOWSER] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_AIR_KICK] = function (m, frame) if frame < 5 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_CROUCHING] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_START_CROUCHING] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_CROUCH_FROM_FAST_LONGJUMP] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_CROUCH_FROM_SLOW_LONGJUMP] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_SWIM_PART1] = function (m, frame) if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ ~= 0 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_SWIM_PART2] = function (m, frame) if gPlayerSyncTable[m.playerIndex].kirbyMouthCounter_JJJ ~= 0 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end,
		[CHAR_ANIM_SHOCKED] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_KIRBY_ENDING] = function (m, frame) if frame > 153 and frame < 195 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_TIPTOE] = MARIO_EYES_CLOSED, 
		[CHAR_ANIM_WATER_IDLE] = function (m, frame) if m.action == ACT_KIRBY_GHOST_DASH then return MARIO_EYES_ANGRY end end, 
		[CHAR_ANIM_SWIM_PART1] = function (m, frame) if (m.flags & MARIO_VANISH_CAP) ~= 0 then return MARIO_EYES_EVIL end end, 
		[CHAR_ANIM_SWIM_PART2] = function (m, frame) if (m.flags & MARIO_VANISH_CAP) ~= 0 then return MARIO_EYES_ANGRY end end, 
		[CHAR_ANIM_KIRBY_DEATH_END] = function (m, frame) if frame < 10 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_CLOSED end, 
		[CHAR_ANIM_KIRBY_HELLO] = function (m, frame) if frame >= 3 and frame < 8 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_KIRBY_DODGE_LEFT] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_KIRBY_DODGE_RIGHT] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_KIRBY_DODGE_FRONT] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_KIRBY_DODGE_BACK] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_FIRST_PERSON] = function (m, frame) return checkForBoss(m) and MARIO_EYES_ANGRY or MARIO_EYES_BLINK end, 
	}, 
	anims = {
		[CHAR_ANIM_SINGLE_JUMP] = function (m, frame) return determineFatAnim(m, "JUMP") end, 
		[CHAR_ANIM_LAND_FROM_SINGLE_JUMP] = function (m, frame) if m.action == ACT_EXIT_LAND_SAVE_DIALOG then return "KIRBY_EXIT_BOUNCE_2" end return "KIRBY_LAND" end, 
		[CHAR_ANIM_GENERAL_FALL] = function (m, frame) return determineFatAnim(m, "FALL") end, 
		[CHAR_ANIM_GENERAL_LAND] = function (m, frame) if m.action == ACT_EXIT_LAND_SAVE_DIALOG or m.action == ACT_SPAWN_SPIN_LANDING or m.action == ACT_END_PEACH_CUTSCENE then return "KIRBY_EXIT_BOUNCE" end return "KIRBY_LAND" end, 
		[CHAR_ANIM_WALKING] = function (m, frame) return determineFatAnim(m, "WALK") end, 
		[CHAR_ANIM_START_TIPTOE] = function (m, frame) m.actionTimer = 2 end, 
		[CHAR_ANIM_TIPTOE] = function (m, frame) return determineFatAnim(m, "TIPTOE") end, 
		[CHAR_ANIM_CROUCH_FROM_FAST_LONGJUMP] = "KIRBY_CROUCH", 
		[CHAR_ANIM_CROUCH_FROM_SLOW_LONGJUMP] = "KIRBY_CROUCH", 
		[CHAR_ANIM_START_CROUCHING] = "KIRBY_CROUCH", 
		[CHAR_ANIM_CROUCHING] = "KIRBY_CROUCH", 
		[CHAR_ANIM_CROUCH_FROM_SLIDE_KICK] = "KIRBY_SLIDE_TO_CROUCH", 
		[CHAR_ANIM_IDLE_HEAD_LEFT] = function (m, frame) return determineFatAnim(m, "IDLE") end, 
		[CHAR_ANIM_IDLE_HEAD_RIGHT] = function (m, frame) return determineFatAnim(m, "IDLE") end, 
		[CHAR_ANIM_IDLE_HEAD_CENTER] = function (m, frame) return determineFatAnim(m, "IDLE") end, 
		[CHAR_ANIM_STOP_CROUCHING] = "KIRBY_CROUCH", 
		[CHAR_ANIM_KIRBY_INHALE_IDLE] = "KIRBY_INHALE_IDLE", 
		[CHAR_ANIM_KIRBY_INHALE_MOVE] = "KIRBY_INHALE_MOVE", 
		[CHAR_ANIM_AIRBORNE_ON_STOMACH] = function (m, frame) if m.action == ACT_VERTICAL_WIND then return "KIRBY_LONG_FALL" end end, 
		[CHAR_ANIM_KIRBY_PUFF_FALL] = "KIRBY_PUFF_IDLE", 
		[CHAR_ANIM_KIRBY_PUFF_RISE] = "KIRBY_PUFF_UP", 
		[CHAR_ANIM_AIR_KICK] = "KIRBY_PUFF_OUT", 
		[CHAR_ANIM_RUNNING] = function (m, frame) if (m.flags & MARIO_METAL_CAP) ~= 0 and not isMovesetOff() then return determineFatAnim(m, "WALK") else return determineFatAnim(m, "RUN") end end, 
		[CHAR_ANIM_RUNNING_UNUSED] = function (m, frame) if (m.flags & MARIO_METAL_CAP) ~= 0 and not isMovesetOff() then return determineFatAnim(m, "WALK") else return determineFatAnim(m, "RUN") end end, 
		[CHAR_ANIM_SLIDE_KICK] = "KIRBY_SLIDE_KICK", 
		[CHAR_ANIM_FIRST_PERSON] = function (m, frame) return determineFatAnim(m, "IDLE") end, 
		[CHAR_ANIM_PUT_CAP_ON] = "KIRBY_POWER_UP", 
		[charSelect.CS_ANIM_MENU] = "KIRBY_MENU", 
		[CHAR_ANIM_STAR_DANCE] = "KIRBY_CELEBRATION", 
		[CHAR_ANIM_RETURN_FROM_STAR_DANCE] = function (m, frame) return determineFatAnim(m, "IDLE") end, 
		[CHAR_ANIM_MISSING_CAP] = "KIRBY_EXIT_LAND", 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = "KIRBY_EXIT_LAND", 
		[CHAR_ANIM_KIRBY_HELLO] = "KIRBY_HELLO", 
		[CHAR_ANIM_KIRBY_ENDING] = "KIRBY_WARP_STAR_ENDING", 
		[CHAR_ANIM_KIRBY_DEATH] = "KIRBY_DEATH", 
		[CHAR_ANIM_KIRBY_DEATH_END] = "KIRBY_DEATH_END", 
		[CHAR_ANIM_KIRBY_DODGE_LEFT] = "KIRBY_DODGE_LEFT", 
		[CHAR_ANIM_KIRBY_DODGE_RIGHT] = "KIRBY_DODGE_RIGHT", 
		[CHAR_ANIM_KIRBY_DODGE_FRONT] = "KIRBY_DODGE_FRONT", 
		[CHAR_ANIM_KIRBY_DODGE_BACK] = "KIRBY_DODGE_BACK", 
		[CHAR_ANIM_KIRBY_DODGE_LAND] = "KIRBY_DODGE_LAND", 
    	[CHAR_ANIM_SKID_ON_GROUND] = "KIRBY_STOP_START", 
    	[CHAR_ANIM_STOP_SKID] = "KIRBY_STOP", 
		[CHAR_ANIM_TURNING_PART1] = "KIRBY_STOP_START", 
		[CHAR_ANIM_TURNING_PART2] = "KIRBY_STOP_RUN", 
		[CHAR_ANIM_START_GROUND_POUND] = "KIRBY_START_GROUND_POUND", 
		[CHAR_ANIM_TRIPLE_JUMP_GROUND_POUND] = "KIRBY_START_GROUND_POUND", 
		[CHAR_ANIM_GROUND_POUND] = "KIRBY_GROUND_POUND", 
	}, 
}

function action_value_to_string(action)
    for k, v in pairs(_G) do
        if v == action then
            return k
        end
    end
    return tostring(action)
end

dededeAnims = {
	mouth = {
		[charSelect.CS_ANIM_MENU] = function (m, frame) if frame > 116 and frame < 148 then return MARIO_MOUTH_FROWN end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_DEDEDE_SPIN] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_KIRBY_INHALE_IDLE] = MARIO_MOUTH_OPEN, 
		[CHAR_ANIM_KIRBY_INHALE_MOVE] = MARIO_MOUTH_OPEN, 
		[CHAR_ANIM_AIR_KICK] = function (m, frame) if m.action == ACT_JUMP_KICK and frame < 10 then return frame < 5 and MARIO_MOUTH_EVIL or MARIO_MOUTH_OPEN end return MARIO_MOUTH_HAPPY end, 
		[CHAR_ANIM_SINGLE_JUMP] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_GENERAL_FALL] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_RUNNING] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_KIRBY_PUFF_FALL] = MARIO_MOUTH_EVIL, 
		[CHAR_ANIM_KIRBY_PUFF_RISE] = MARIO_MOUTH_EVIL, 
		[CHAR_ANIM_DEDEDE_FULL_IDLE] = MARIO_MOUTH_EVIL, 
		[CHAR_ANIM_DEDEDE_FULL_MOVE_LEFT] = MARIO_MOUTH_EVIL, 
		[CHAR_ANIM_DEDEDE_FULL_MOVE_RIGHT] = MARIO_MOUTH_EVIL, 
		[CHAR_ANIM_DEDEDE_HAMMER_AIR] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_TIPTOE] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_AIRBORNE_ON_STOMACH] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_PUT_CAP_ON] = function (m, frame)
			if (m.flags & MARIO_METAL_CAP) ~= 0 and not isMovesetOff() then return ((frame > 23 and frame < 32) and MARIO_MOUTH_OPEN) or MARIO_MOUTH_FROWN end
			return ((frame > 19 and frame < 32) and MARIO_MOUTH_SMILE) or MARIO_MOUTH_HAPPY
		end, 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = function (m, frame) if frame > 22 and frame < 40 then return MARIO_MOUTH_HAPPY elseif frame >= 40 and frame < 65 then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_MISSING_CAP] = function (m, frame) if frame > 22 and frame < 40 then return MARIO_MOUTH_HAPPY elseif frame >= 40 and frame < 65 then return MARIO_MOUTH_SMILE end return MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_KIRBY_DEATH] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_KIRBY_DEATH_END] = MARIO_MOUTH_OPEN, 
		[CHAR_ANIM_KIRBY_DODGE_LEFT] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_KIRBY_DODGE_RIGHT] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_KIRBY_DODGE_FRONT] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_KIRBY_DODGE_BACK] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_KIRBY_DODGE_LAND] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_KIRBY_ENDING] = function (m, frame)
			if (frame > 13 and frame < 68) or (frame >= 111 and frame < 126) then
				return MARIO_MOUTH_HAPPY
			elseif (frame > 135 and frame < 150) or (frame > 172 and frame < 206) then
				return MARIO_MOUTH_SMILE
			elseif frame >= 206 and frame < 250 then
				return MARIO_MOUTH_FROWN
			end
			return MARIO_MOUTH_NORMAL
		end, 
		[CHAR_ANIM_SKID_ON_GROUND] = MARIO_MOUTH_FROWN, 
    	[CHAR_ANIM_STOP_SKID] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_TURNING_PART1] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_TURNING_PART2] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_FIRST_PERSON] = function (m, frame) return checkForBoss(m) and MARIO_MOUTH_FROWN or MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_STAR_DANCE] = function (m, frame)
			if frame > 7 and frame < 46 then
				return MARIO_MOUTH_SMILE
			end
			return MARIO_MOUTH_NORMAL
		end, 
		[CHAR_ANIM_DEDEDE_JUMP] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_DEDEDE_JUMP_LAND] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_DEDEDE_DIZZY] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_START_GROUND_POUND] = function (m, frame) return frame >= 7 and MARIO_MOUTH_SMILE or MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_TRIPLE_JUMP_GROUND_POUND] = function (m, frame) return frame >= 7 and MARIO_MOUTH_SMILE or MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_GROUND_POUND] = function (m, frame) if isMovesetOff() then return MARIO_MOUTH_SMILE else return frame >= 17 and MARIO_MOUTH_SMILE or MARIO_MOUTH_NORMAL end end, 
		[CHAR_ANIM_DEDEDE_HAMMER_UP] = MARIO_MOUTH_HAPPY, 
		[CHAR_ANIM_DEDEDE_HAMMER_DOWN] = function (m, frame) return frame < 11 and MARIO_MOUTH_SMILE or MARIO_MOUTH_NORMAL end, 
		[CHAR_ANIM_DEDEDE_GORDO] = function (m, frame) return m.actionTimer >= 4.5 * 30 and MARIO_MOUTH_FROWN or MARIO_MOUTH_HAPPY end, 
		[CHAR_ANIM_DEDEDE_GORDO_FLIP] = MARIO_MOUTH_SMILE, 
		[CHAR_ANIM_DIVE] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_SLIDE_DIVE] = MARIO_MOUTH_FROWN, 
		[CHAR_ANIM_SLOW_LAND_FROM_DIVE] = MARIO_MOUTH_FROWN, 
	},
	eyes = {
		[charSelect.CS_ANIM_MENU] = function (m, frame)
			if frame > 116 and frame < 119 then
				return MARIO_EYES_HALF_CLOSED
			elseif frame >= 119 and frame < 122 then
				return MARIO_EYES_CLOSED
			elseif frame >= 122 and frame < 132 then
				return MARIO_EYES_ANGRY
			elseif frame > 138 and frame <= 148 then
				return MARIO_EYES_OPEN
			end
			return MARIO_EYES_LOOK_LEFT
		end, 
		[CHAR_ANIM_DEDEDE_SPIN] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_AIR_KICK] = function (m, frame) if frame < 5 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_KIRBY_INHALE_MOVE] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_PUFF_RISE] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_DEDEDE_FULL_MOVE_LEFT] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_DEDEDE_FULL_MOVE_RIGHT] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_DEDEDE_HAMMER_AIR] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_KIRBY_PUFF_FALL] = function (m, frame) if m.actionTimer > 240 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK end, 
		[CHAR_ANIM_TIPTOE] = MARIO_EYES_LOOK_UP, 
		[CHAR_ANIM_CROUCH_FROM_FAST_LONGJUMP] = MARIO_EYES_HALF_CLOSED, 
		[CHAR_ANIM_CROUCH_FROM_SLOW_LONGJUMP] = MARIO_EYES_HALF_CLOSED, 
		[CHAR_ANIM_START_CROUCHING] = MARIO_EYES_HALF_CLOSED, 
		[CHAR_ANIM_CROUCHING] = MARIO_EYES_HALF_CLOSED, 
		[CHAR_ANIM_STOP_CROUCHING] = MARIO_EYES_HALF_CLOSED, 
		[CHAR_ANIM_PUT_CAP_ON] = function (m, frame)
			if (m.flags & MARIO_METAL_CAP) ~= 0 and not isMovesetOff() then return ((frame > 12 and frame <= 22) and MARIO_EYES_CLOSED_INTENSE) or (frame > 22 and MARIO_EYES_ANGRY) or MARIO_EYES_BLINK end
			return ((frame > 12 and frame <= 22) and MARIO_EYES_CLOSED_INTENSE) or ((frame > 22 and frame < 32) and MARIO_EYES_LOOK_RIGHT) or MARIO_EYES_BLINK
		end, 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = function (m, frame)
			if frame == 22 or frame == 31 then audio_sample_play(KIRBY_LAND_SOUND, m.pos, 1) end
			if frame == 47 then local dededeLaugh = charSelect.character_get_voice(m)[CHAR_SOUND_TWIRL_BOUNCE]; audio_sample_play(dededeLaugh, m.marioObj.header.gfx.cameraToObject, 1) end
			if frame > 12 and frame < 36 then return MARIO_EYES_ANGRY elseif frame >= 36 and frame < 62 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK
		end, 
		[CHAR_ANIM_MISSING_CAP] = function (m, frame)
			if frame == 22 or frame == 31 then audio_sample_play(KIRBY_LAND_SOUND, m.pos, 1) end
			if frame == 47 then local dededeLaugh = charSelect.character_get_voice(m)[CHAR_SOUND_TWIRL_BOUNCE]; audio_sample_play(dededeLaugh, m.marioObj.header.gfx.cameraToObject, 1) end
			if frame > 12 and frame < 36 then return MARIO_EYES_ANGRY elseif frame >= 36 and frame < 62 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_BLINK
		end, 
		[CHAR_ANIM_KIRBY_DEATH_END] = function (m, frame) if frame < 10 then return MARIO_EYES_CLOSED_INTENSE end return MARIO_EYES_DEAD end, 
		[CHAR_ANIM_KIRBY_DODGE_LEFT] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_DODGE_RIGHT] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_DODGE_FRONT] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_DODGE_BACK] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_DEDEDE_JUMP_START] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_DEDEDE_HAMMER_UP] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_DEDEDE_HAMMER_DOWN] = function (m, frame) return frame < 11 and MARIO_EYES_LOOK_DOWN or MARIO_EYES_BLINK end, 
		[CHAR_ANIM_DEDEDE_JUMP_LAND] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_KIRBY_DODGE_LAND] = MARIO_EYES_SHOCKED, 
		[CHAR_ANIM_KIRBY_ENDING] = function (m, frame)
			if (frame > 13 and frame < 83) or (frame >= 246 and frame < 250) then
				return MARIO_EYES_ANGRY
			elseif frame > 126 and frame < 150 then
				return MARIO_EYES_CLOSED
			elseif (frame > 167 and frame < 210) or (frame > 236 and frame < 246) then
				return MARIO_EYES_CLOSED_INTENSE
			elseif (frame >= 210 and frame <= 236) then
				return MARIO_EYES_SHOCKED
			elseif frame >= 111 and frame <= 126 then
				return MARIO_EYES_HALF_CLOSED
			end
			return MARIO_EYES_BLINK
		end, 
		[CHAR_ANIM_SKID_ON_GROUND] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_TURNING_PART1] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_TURNING_PART2] = function (m, frame) return frame < 3 and MARIO_EYES_CLOSED_INTENSE or MARIO_EYES_BLINK end, 
		[CHAR_ANIM_FIRST_PERSON] = function (m, frame) return checkForBoss(m) and MARIO_EYES_HALF_CLOSED or MARIO_EYES_BLINK end, 
		[CHAR_ANIM_STAR_DANCE] = function (m, frame)
			if frame > 7 and frame < 28 then
				return MARIO_EYES_LOOK_UP
			elseif (frame > 2 and frame <= 7) or (frame >= 28 and frame <= 51) then
				return MARIO_EYES_CLOSED_INTENSE
			elseif frame > 51 then
				return MARIO_EYES_LOOK_RIGHT
			end
			return MARIO_EYES_BLINK
		end, 
		[CHAR_ANIM_START_GROUND_POUND] = function (m, frame) return MARIO_EYES_LOOK_DOWN end, 
		[CHAR_ANIM_TRIPLE_JUMP_GROUND_POUND] = function (m, frame) return MARIO_EYES_LOOK_DOWN end, 
		[CHAR_ANIM_GROUND_POUND] = function (m, frame) return MARIO_EYES_LOOK_DOWN end, 
		[CHAR_ANIM_DEDEDE_DIZZY] = function (m, frame) return (frame < 5 or frame > 37) and MARIO_EYES_CLOSED_INTENSE or MARIO_EYES_SHOCKED end, 
		[CHAR_ANIM_DEDEDE_GORDO] = function (m, frame) 
			if m.actionTimer >= 4.5 * 30 then
				return m.actionTimer >= 4.9 * 30 and MARIO_EYES_CLOSED_INTENSE or MARIO_EYES_SHOCKED
			end
			return MARIO_EYES_ANGRY
		end, 
		[CHAR_ANIM_DEDEDE_GORDO_FLIP] = MARIO_EYES_ANGRY, 
		[CHAR_ANIM_DIVE] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_SLIDE_DIVE] = MARIO_EYES_CLOSED_INTENSE, 
		[CHAR_ANIM_SLOW_LAND_FROM_DIVE] = function (m, frame)
			if m.prevAction == ACT_KIRBY_HURT_BACKWARD or m.prevAction == ACT_KIRBY_HURT_FORWARD or m.prevAction == ACT_KIRBY_HURT_LAVA then
				return MARIO_EYES_CLOSED_INTENSE
			else
				return MARIO_EYES_HALF_CLOSED
			end
		end, 
	}, 
	hands = {
		[charSelect.CS_ANIM_MENU] = MARIO_HAND_PEACE_SIGN, 
		[CHAR_ANIM_KIRBY_PUFF_RISE] = MARIO_HAND_OPEN, 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = MARIO_HAND_FISTS, 
		[CHAR_ANIM_MISSING_CAP] = MARIO_HAND_FISTS, 
		[CHAR_ANIM_KIRBY_DEATH_END] = MARIO_HAND_OPEN, 
		[CHAR_ANIM_SKID_ON_GROUND] = MARIO_HAND_OPEN, 
		[CHAR_ANIM_TURNING_PART1] = MARIO_HAND_OPEN, 
		[CHAR_ANIM_TURNING_PART2] = function (m, frame) return frame < 3 and MARIO_HAND_OPEN or MARIO_HAND_FISTS end, 
		[CHAR_ANIM_KIRBY_ENDING] = function (m, frame) if frame > 206 and frame < 243 then return MARIO_HAND_RIGHT_OPEN end return MARIO_HAND_FISTS end, 
		[CHAR_ANIM_STAR_DANCE] = function (m, frame)
			if frame > 7 and frame < 27 then
				return MARIO_HAND_OPEN
			elseif frame >= 27 and frame <= 47 then
				return MARIO_HAND_RIGHT_OPEN
			end
			return MARIO_HAND_FISTS
		end
	}, 
	anims = {
		[charSelect.CS_ANIM_MENU] = "DEDEDE_MENU", 
		[CHAR_ANIM_IDLE_HEAD_LEFT] = "DEDEDE_IDLE", 
		[CHAR_ANIM_IDLE_HEAD_RIGHT] = "DEDEDE_IDLE", 
		[CHAR_ANIM_IDLE_HEAD_CENTER] = "DEDEDE_IDLE", 
		[CHAR_ANIM_FIRST_PERSON] = "DEDEDE_IDLE", 
		[CHAR_ANIM_RETURN_FROM_STAR_DANCE] = "DEDEDE_IDLE", 
		[CHAR_ANIM_DEDEDE_SPIN] = "DEDEDE_SPIN", 
		[CHAR_ANIM_WALKING] = "DEDEDE_WALK", 
		[CHAR_ANIM_START_TIPTOE] = function (m, frame) m.actionTimer = 2 end, 
		[CHAR_ANIM_RUNNING] = "DEDEDE_RUN", 
		[CHAR_ANIM_RUNNING_UNUSED] = "DEDEDE_RUN", 
		[CHAR_ANIM_SINGLE_JUMP] = "DEDEDE_JUMP", 
		[CHAR_ANIM_LAND_FROM_SINGLE_JUMP] = function (m, frame) if m.action == ACT_EXIT_LAND_SAVE_DIALOG then return "DEDEDE_EXIT_BOUNCE_2" end return "DEDEDE_LAND" end, 
		[CHAR_ANIM_GENERAL_FALL] = "DEDEDE_FALL", 
		[CHAR_ANIM_GENERAL_LAND] = function (m, frame) if m.action == ACT_EXIT_LAND_SAVE_DIALOG or m.action == ACT_SPAWN_SPIN_LANDING or m.action == ACT_END_PEACH_CUTSCENE then return "DEDEDE_EXIT_BOUNCE" end return "DEDEDE_LAND" end, 
		[CHAR_ANIM_KIRBY_INHALE_IDLE] = "DEDEDE_INHALE_IDLE", 
		[CHAR_ANIM_KIRBY_INHALE_MOVE] = "DEDEDE_INHALE_MOVE", 
		[CHAR_ANIM_KIRBY_PUFF_FALL] = "DEDEDE_PUFF_IDLE", 
		[CHAR_ANIM_KIRBY_PUFF_RISE] = "DEDEDE_PUFF_UP", 
		[CHAR_ANIM_AIR_KICK] = "DEDEDE_PUFF_OUT", 
		[CHAR_ANIM_DEDEDE_FULL_IDLE] = "DEDEDE_FULL_IDLE", 
		[CHAR_ANIM_DEDEDE_FULL_MOVE_LEFT] = "DEDEDE_FULL_MOVE_LEFT", 
		[CHAR_ANIM_DEDEDE_FULL_MOVE_RIGHT] = "DEDEDE_FULL_MOVE_RIGHT", 
		[CHAR_ANIM_DEDEDE_HAMMER_AIR] = "DEDEDE_HAMMER_AIR", 
		[CHAR_ANIM_TIPTOE] = "DEDEDE_TIPTOE",
		[CHAR_ANIM_CROUCH_FROM_FAST_LONGJUMP] = "DEDEDE_CROUCH", 
		[CHAR_ANIM_CROUCH_FROM_SLOW_LONGJUMP] = "DEDEDE_CROUCH", 
		[CHAR_ANIM_START_CROUCHING] = function (m, frame) if m.action == ACT_CROUCHING then set_mario_animation(m, CHAR_ANIM_CROUCHING) end return "DEDEDE_CROUCH" end, 
		[CHAR_ANIM_CROUCHING] = "DEDEDE_CROUCH_ANIM", 
		[CHAR_ANIM_STOP_CROUCHING] = "DEDEDE_CROUCH", 
		[CHAR_ANIM_PUT_CAP_ON] = function (m, frame) if (m.flags & MARIO_METAL_CAP) ~= 0 and not isMovesetOff() then return "DEDEDE_POWER_UP_MASK" end return "DEDEDE_POWER_UP" end, 
		[CHAR_ANIM_AIRBORNE_ON_STOMACH] = function (m, frame) if m.action == ACT_VERTICAL_WIND then return "DEDEDE_LONG_FALL" end end, 
		[CHAR_ANIM_MISSING_CAP] = "DEDEDE_EXIT_LAND", 
		[CHAR_ANIM_TAKE_CAP_OFF_THEN_ON] = "DEDEDE_EXIT_LAND", 
		[CHAR_ANIM_KIRBY_DEATH] = "DEDEDE_DEATH", 
		[CHAR_ANIM_KIRBY_DEATH_END] = "DEDEDE_DEATH_END", 
		[CHAR_ANIM_KIRBY_DODGE_LEFT] = "DEDEDE_DODGE_LEFT", 
		[CHAR_ANIM_KIRBY_DODGE_RIGHT] = "DEDEDE_DODGE_RIGHT", 
		[CHAR_ANIM_KIRBY_DODGE_FRONT] = "DEDEDE_DODGE_FRONT", 
		[CHAR_ANIM_KIRBY_DODGE_BACK] = "DEDEDE_DODGE_BACK", 
		[CHAR_ANIM_KIRBY_DODGE_LAND] = "DEDEDE_DODGE_LAND", 
		[CHAR_ANIM_KIRBY_ENDING] = "DEDEDE_WARP_STAR_ENDING", 
    	[CHAR_ANIM_SKID_ON_GROUND] = "DEDEDE_STOP_START", 
    	[CHAR_ANIM_STOP_SKID] = "DEDEDE_STOP", 
		[CHAR_ANIM_TURNING_PART1] = "DEDEDE_STOP_START", 
		[CHAR_ANIM_TURNING_PART2] = "DEDEDE_STOP_RUN", 
		[CHAR_ANIM_STAR_DANCE] = "DEDEDE_CELEBRATION", 
		[CHAR_ANIM_START_GROUND_POUND] = "DEDEDE_START_GROUND_POUND", 
		[CHAR_ANIM_TRIPLE_JUMP_GROUND_POUND] = "DEDEDE_START_GROUND_POUND", 
		[CHAR_ANIM_GROUND_POUND] = function (m, frame) return isMovesetOff() and "DEDEDE_START_GROUND_POUND" or "DEDEDE_GROUND_POUND_EXT" end, 
		[CHAR_ANIM_GROUND_POUND_LANDING] = "DEDEDE_GROUND_POUND_LAND", 
		[CHAR_ANIM_DEDEDE_JUMP_START] = "DEDEDE_SUPER_JUMP_START", 
		[CHAR_ANIM_DEDEDE_JUMP] = "DEDEDE_SUPER_JUMP", 
		[CHAR_ANIM_DEDEDE_JUMP_LAND] = "DEDEDE_SUPER_JUMP_LAND", 
		[CHAR_ANIM_DEDEDE_DIZZY] = "DEDEDE_HAMMER_DIZZY", 
		[CHAR_ANIM_DEDEDE_HAMMER_UP] = "DEDEDE_HAMMER_UP", 
		[CHAR_ANIM_DEDEDE_HAMMER_DOWN] = "DEDEDE_HAMMER_DOWN", 
		[CHAR_ANIM_DEDEDE_GORDO] = "DEDEDE_GORDO", 
		[CHAR_ANIM_DEDEDE_GORDO_FLIP] = "DEDEDE_GORDO_FLIP", 
		[CHAR_ANIM_SLOW_LAND_FROM_DIVE] = function (m, frame)
			if not (m.prevAction == ACT_KIRBY_HURT_BACKWARD or m.prevAction == ACT_KIRBY_HURT_FORWARD or m.prevAction == ACT_KIRBY_HURT_LAVA) then
				return "DEDEDE_DIVE_LAND"
			end
		end, 
		[CHAR_ANIM_DIVE] = "DEDEDE_DIVE", 
		[CHAR_ANIM_SLIDE_DIVE] = "DEDEDE_DIVE", 
	},
}