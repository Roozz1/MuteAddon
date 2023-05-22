---------------------------------------
------------- Command - Set persistent location [Admin]
---------------------------------------

------------- ?spl
cuhFramework.commands.create("spl", nil, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local pos = player:get_position()
    databaseLibrary.set(databaseLibrary.field_name("persistentLocation", player), pos[13]..","..pos[14]..","..pos[15])
end)