---------------------------------------
------------- Command - Set level [Admin]
---------------------------------------

------------- ?level_set
cuhFramework.commands.create("level_set", {"ls"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local args = {...}
    if args[1] and args[2] then
        local player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[2], false)
        if player then
            levelsLibrary.set(player, tonumber(args[1]))
        end
    end
end)