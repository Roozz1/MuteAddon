---------------------------------------
------------- Map Toggle
---------------------------------------

cuhFramework.callbacks.onToggleMap:connect(function(peer_id, opened)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Quick check
    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Check if opened
    if opened then
        -- Refresh all mission UI
        for i, v in pairs(missionLibrary.miscellaneous.getAllMissions()) do
            v:refreshMapUI(player, v.properties.available)
        end
    end
end)