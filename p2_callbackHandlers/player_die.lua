---------------------------------------
------------- Player Die
---------------------------------------

cuhFramework.callbacks.onPlayerDie:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Announce
    chatAnnounce(player.properties.name.." has died.")

    -- Get thy money
    moneyLibrary.get(player, function(money)
        -- lose thy money
        local toTake = miscellaneousLibrary.percentageOfNumber(money, config.game.moneyLossOnDeathPercentage)
        moneyLibrary.subtract(player, toTake)

        -- and announce thy money subtraction
        announceLibrary.status.warning(
            "You have lost "..math.floor(config.game.moneyLossOnDeathPercentage).."% of your money because you died.\n"..
            moneyLibrary.compare(money, money - toTake, "Before:", "After:"),
            player
        )
    end)
end)