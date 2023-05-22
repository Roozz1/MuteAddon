---------------------------------------
------------- Player Join
---------------------------------------

cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- debug
    df.print(name.." joined the server")

    -- Announce
    chatAnnounce(player.properties.name.." has joined the server.")

    -- Auth
    player:set_auth(true)

    -- Refund if server restarted and this player lost money from vehicle spawning n stuff
    local field_name = databaseLibrary.field_name("totalVehCost", player)
    databaseLibrary.get(field_name, function(amount)
        -- quick check
        if not databaseLibrary.basicChecks(player, amount) or amount == "None" then
            return
        end

        -- refund
        moneyLibrary.add(player, tonumber(amount))

        -- and reset
        databaseLibrary.remove(field_name)
    end)

    -- Add
    table.insert(players_unfiltered, player)
end)