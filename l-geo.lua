-- This file defines GeoFunctions used in "Kirby Deluxe!"

if incompatibilityCond then return 0 end

function isMovesetOff() -- Global function to check if movesets are off or restricted.
	if charSelect.are_movesets_restricted() then return true end
	if charSelect.get_options_status(charSelect.optionTableRef.localMoveset) == 0 then return true end
	return false
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

	if asSwitchNode.parameter == 1 then -- Hand
		asSwitchNode.selectedCase = 0
	else -- Back
		local hammer = node.next
		hammer.flags = hammer.flags & ~GRAPH_RENDER_ACTIVE
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
	
	local animInfo = m.marioObj.header.gfx.animInfo
	local setMouthState = 0
	local mouthState = kirbyAnims.mouth and run_func_or_get_var(kirbyAnims.mouth[animInfo.animID], m, animInfo.animFrame)
	
	if mouthState then
		setMouthState = mouthState
	end

	-- Classic Kirby Check
	if (setMouthState == 2 or setMouthState == 3) and gPlayerSyncTable[m.playerIndex].kirbyAltCostume == 2 then
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