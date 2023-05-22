---------------------------------------
------------- Command - Shows your position in chat [Admin]
---------------------------------------

------------- ?pos
cuhFramework.commands.create("pos", {"p"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check if admin
    if not admin then
        return
    end

    -- Print pos in chat
    chatAnnounce(miscellaneousLibrary.matrixFormatted(player:get_position()))
end, "")