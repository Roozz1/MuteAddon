---------------------------------------
------------- Command - Suicide
---------------------------------------

------------- ?die
cuhFramework.commands.create("die", {"suicide", "su", "kys", "di"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Die
    player:damage(1000)
end, "You have so much to live for.")
