-- This file defines GeoFunctions used in "Kirby Deluxe!"

if incompatibilityCond then return 0 end

function isMovesetOff() -- Global function to check if movesets are off or restricted.
	if charSelect.are_movesets_restricted() then return true end
	if charSelect.get_options_status(charSelect.optionTableRef.localMoveset) == 0 then return true end
	return false
end

function dededeCap_JJJ(node, matStackIndex)
	local switchCase = cast_graph_node(node)
	local o = geo_get_current_object()

	local behValue = get_id_from_behavior(o.behavior)
	if behValue == id_bhvNormalCap then
		switchCase.selectedCase = 1
	else
		switchCase.selectedCase = 0
	end
end

function kirbyWing_JJJ(node, matStackIndex)
	local leftWing = node.next
	local rightWing = node.next.next
	local ringWing = node.next.next.next
	local bodyState = geo_get_body_state()
	local m = geo_get_mario_state()
	
	if not (leftWing and rightWing and ringWing and bodyState and m) or (not isMovesetOff() and m.action == ACT_END_PEACH_CUTSCENE) then return end

	if bodyState.capState & 2 ~= 0 then
		leftWing.flags = leftWing.flags | GRAPH_RENDER_ACTIVE
		rightWing.flags = rightWing.flags | GRAPH_RENDER_ACTIVE
		ringWing.flags = ringWing.flags | GRAPH_RENDER_ACTIVE
	else
		leftWing.flags = leftWing.flags & ~GRAPH_RENDER_ACTIVE
		rightWing.flags = rightWing.flags & ~GRAPH_RENDER_ACTIVE
		ringWing.flags = ringWing.flags & ~GRAPH_RENDER_ACTIVE
	end
end

function dededeHammer_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	local m = geo_get_mario_state()

	local id = m.marioObj.header.gfx.animInfo.animID
	local frame = m.marioObj.header.gfx.animInfo.animFrame
	local isHoldingHammer = gPlayerSyncTable[m.playerIndex].dededeIsHammer_JJJ 
							or (m.action == ACT_DEDEDE_HAMMER_DOWN and frame < 4) -- TODO: set to frame where hammer is discarded
							or m.action == ACT_DEDEDE_HAMMER_SPIN or m.action == ACT_DEDEDE_DIZZY or m.action == ACT_DEDEDE_HAMMER_AIR
							or m.action == ACT_GROUND_POUND or m.action == ACT_GROUND_POUND_LAND
							or (m.action == ACT_KIRBY_POWERUP and frame >= 12 and frame <= 33)
							or ((id == CHAR_ANIM_TAKE_CAP_OFF_THEN_ON or id == CHAR_ANIM_MISSING_CAP) and frame >= 12 and frame < 65)
	local isStoringHammer = m.action == ACT_KIRBY_JUMBO_STAR or (m.action & ACT_FLAG_METAL_WATER) ~= 0
							or (m.action == ACT_KIRBY_POWERUP and frame < 12)
							or ((id == CHAR_ANIM_TAKE_CAP_OFF_THEN_ON or id == CHAR_ANIM_MISSING_CAP) and frame < 12)

	if asSwitchNode.parameter == 1 then -- Hand
		asSwitchNode.selectedCase = isHoldingHammer and 1 or 0
	else -- Back
		local hammer = node.next
		if isStoringHammer then
			hammer.flags = hammer.flags | GRAPH_RENDER_ACTIVE
		else
			hammer.flags = hammer.flags & ~GRAPH_RENDER_ACTIVE
		end
	end
end

function dededePartner_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	local bodyState = geo_get_body_state()

	local m = geo_get_mario_state()
	if not isMovesetOff() and m.action == ACT_END_PEACH_CUTSCENE then return end

	if bodyState.capState & 2 ~= 0 then -- Bronto Burt
		asSwitchNode.selectedCase = 0
	elseif bodyState.modelState >> 8 == 1 or bodyState.modelState >> 8 == 3 then -- Kabu
		asSwitchNode.selectedCase = 1
	else
		asSwitchNode.selectedCase = 2
	end
end

hook_event(HOOK_MARIO_UPDATE, function(m) if m.playerIndex ~= 0 then return end gPlayerSyncTable[m.playerIndex].kirbyAltCostume = charSelect.character_get_current_costume(m.playerIndex) end)

function kirbyClassic_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	local m = geo_get_mario_state()

	asSwitchNode.selectedCase = gPlayerSyncTable[m.playerIndex].kirbyAltCostume - 1
end

function kirbyInhale_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	local m = geo_get_mario_state()
	if not (m and asSwitchNode) then return end
	
	local idx = m.playerIndex
	local toNode = 0
	if m.action == ACT_KIRBY_INHALE or (m.action == ACT_JUMP_KICK and m.marioObj.header.gfx.animInfo.animFrame < 10) or (m.action == ACT_WATER_PUNCH and m.marioObj.header.gfx.animInfo.animFrame < 5) then
		toNode = 1
	elseif gPlayerSyncTable[idx].kirbyMouthCounter_JJJ ~= 0 or m.action == ACT_KIRBY_PUFF then
		toNode = 2
	end
	asSwitchNode.selectedCase = toNode
end

local function run_func_or_get_var(x, ...) if type(x) == "function" then return x(...) else return x end end
function kirbyMouth_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	
	local m = geo_get_mario_state()
	local idx = m.playerIndex
	local modelId = charSelect.character_get_current_number(idx)

	local charTable = modelId == kirbyCharID and kirbyAnims or dededeAnims
	local animInfo = m.marioObj.header.gfx.animInfo
	local setMouthState = 0
	local mouthState = charTable.mouth and run_func_or_get_var(charTable.mouth[animInfo.animID], m, animInfo.animFrame)
	
	if mouthState then
		setMouthState = mouthState
	end

	-- Classic Kirby Check
	if modelId == kirbyCharID and (setMouthState == 2 or setMouthState == 3) and gPlayerSyncTable[m.playerIndex].kirbyAltCostume == 2 then
		setMouthState = setMouthState + 4
	end

	asSwitchNode.selectedCase = setMouthState
end

function kirbyEyes_JJJ(node, matStackIndex)
	local switchCase = cast_graph_node(node)
	local bodyState = geo_get_body_state()
	local m = geo_get_mario_state()
	local marioBlinkAnimation = {1, 2, 1, 0, 1, 2, 1}

	if bodyState.eyeState == 0 then
		local blinkFrame = ((switchCase.parameter * 32 + (get_area_update_counter() + m.playerIndex * 32)) >> 1) & 31
		if blinkFrame <= 7 then
			switchCase.selectedCase = marioBlinkAnimation[blinkFrame] or 0
		else
			switchCase.selectedCase = 0
		end
	else
		switchCase.selectedCase = bodyState.eyeState - 1
	end

	if gPlayerSyncTable[m.playerIndex].kirbyAltCostume == 2 then
		switchCase.selectedCase = switchCase.selectedCase + 12
	end
end