---------------------------------------
------------- Command - Set money [Admin]
---------------------------------------

------------- ?money_set
cuhFramework.commands.create("money_set", {"ms"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local args = {...}
    if args[1] and args[2] then
        local player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[2], false)
        if player then
            moneyLibrary.set(player, tonumber(args[1]))
        end
    end
end)