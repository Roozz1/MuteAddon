---------------------------------------
------------- Command - Refresh UI
---------------------------------------

------------- ?refresh_ui
cuhFramework.commands.create("refresh_ui", {"refreshui", "rui", "ru"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Main
    for _, v in pairs(cuhFramework.ui.screen.activeUI) do
        if v.properties.player and v.properties.player.properties.peer_id == player.properties.peer_id then
            v:refresh()
        end
    end

    for _, v in pairs(easyPopupsLibrary.physical.getAll()) do
        if v.properties.player and v.properties.player.properties.peer_id == player.properties.peer_id then
            v:refresh()
        end
    end

    announceLibrary.status.success("Successfully refreshed all UI with you as the target.", player)
end, "Refreshes most UI shown to you.")