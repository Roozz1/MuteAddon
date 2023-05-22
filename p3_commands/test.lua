---------------------------------------
------------- Command - test
---------------------------------------

------------- ?test
cuhFramework.commands.create("test", {"t"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    local s = messageLibrary.messages.getMostRecent()
    if s then
        s:edit("WTF CUH4 WTF WTF")
    end
end, "")