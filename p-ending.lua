if incompatibilityCond then return 0 end

local sKirbyEndCond = false
hook_event(HOOK_UPDATE, function()
    local currLevel = gNetworkPlayers[0].currLevelNum
    local currChar = charSelect.character_get_current_number(0)

    if currLevel == LEVEL_ENDING and (currChar == kirbyCharID or currChar == dededeCharID) then
        if not sKirbyEndCond then
            seq_player_fade_out(SEQ_PLAYER_LEVEL, 2000)
            sKirbyEndCond = true
        end
    else
        sKirbyEndCond = false
    end
end)

local TEX_CAKE = get_texture_info("kirby-cake-ending")

local function renderCakeEnding()
    local currChar = charSelect.character_get_current_number()
    if currChar == kirbyCharID or currChar == dededeCharID then
        local x = djui_hud_get_screen_width() / 2 - TEX_CAKE.width / 2
        local y = djui_hud_get_screen_height() / 2 - TEX_CAKE.height / 2

        if gNetworkPlayers[0].currLevelNum ~= LEVEL_ENDING then
            return
        else
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_render_texture(TEX_CAKE, x, y, 1, 1)
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, function()
    djui_hud_set_resolution(RESOLUTION_N64)
    renderCakeEnding()
end)