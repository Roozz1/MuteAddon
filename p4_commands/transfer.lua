---------------------------------------
------------- Command - Transfer money to someone
---------------------------------------

------------- ?transfer
cuhFramework.commands.create("transfer", {"give", "t", "g"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Checks
    if not args[1] then
        return announceLibrary.status.failure("Please specify who you would like to transfer money to (player name). For example: ?transfer *bob* 100. You can also do a partial name.", player)
    end

    if not args[2] then
        return announceLibrary.status.failure("Please specify how much you would like to transfer. For example: ?transfer bob *100*.", player)
    end

    -- Get target player
    local target_player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[1], false)

    -- More checks
    if not target_player then
        return announceLibrary.status.failure("The player you searched for doesn't exist. Did you type their name correctly?", player)
    end

    if target_player == player then
        return announceLibrary.status.failure("You cannot transfer money to yourself.", player)
    end

    -- Get amount
    local toTransfer = tonumber(args[2])

    -- More more checks
    if not toTransfer then
        return announceLibrary.status.failure("The amount of money you want to transfer must be a number.", player)
    end

    if toTransfer <= 0 then
        return announceLibrary.status.failure("The amount of money you want to transfer must be above 0.", player)
    end

    -- Transfer
    moneyLibrary.get(player, function(money)
        if money < toTransfer then
            return announceLibrary.status.failure("You don't have enough money.", player)
        end

        -- edit money
        moneyLibrary.add(target_player, toTransfer)
        moneyLibrary.subtract(player, toTransfer)

        -- announce
        announceLibrary.status.success("Succesfully transferred "..moneyLibrary.format(toTransfer).." to "..target_player.properties.name..".", player)
        chatAnnounce(player.properties.name.." transferred "..moneyLibrary.format(toTransfer).." to you.", target_player)
    end)
end, "Privately message someone.")