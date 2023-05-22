---------------------------------------
------------- Command - Toggle UI
---------------------------------------

------------- ?ui
local ui_ids = {
    10000,
    11000,
    12000,
    14000
}

cuhFramework.commands.create("ui", { "u", "hud" }, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Main
    if playerStatesLibrary.hasState(player, "ui_toggle") then
        -- Show UI
        playerStatesLibrary.removeState(player, "ui_toggle")

        for i, v in pairs(ui_ids) do
            local ui = cuhFramework.ui.screen.get(peer_id + v)

            if ui then
                ui:setVisibility(true)
            end
        end

        -- Show mission UI
        local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
        if mission then
            for i, v in pairs(mission.properties.storage.storage) do
                if v.edit and v.refresh and v.properties and v.remove and v.setVisibility then -- probably a physical popup
                    v:setVisibility(true)
                end
            end
        end

        -- Announce
        announceLibrary.status.success("Most UI elements have now been shown.", player)
    else
        -- Hide UI
        playerStatesLibrary.setState(player, "ui_toggle")

        for i, v in pairs(ui_ids) do
            local ui = cuhFramework.ui.screen.get(peer_id + v)

            if ui then
                ui:setVisibility(false)
            end
        end

        -- Hide mission UI
        local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
        if mission then
            for i, v in pairs(mission.properties.storage.storage) do
                if v.edit and v.refresh and v.properties and v.remove and v.setVisibility then -- probably a physical popup
                    v:setVisibility(false)
                end
            end
        end

        -- Announce
        announceLibrary.status.success("Most UI elements have now been hidden.", player)
    end
end, "Toggles most UI elements.")