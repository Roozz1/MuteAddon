---------------------------------------
------------- Command - Reset data
---------------------------------------

------------- ?reset
cuhFramework.commands.create("reset", {"re"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Cooldown check
    if debounceLibrary.debounce(player.properties.peer_id.."_resetcommand", 3) then
        return announceLibrary.status.failure("This command is on cooldown.", player)
    end

    -- Main
    if playerStatesLibrary.hasState(player, "reset_data") then
        -- confirmed
        playerStatesLibrary.removeState(player, "reset_data")
        announceLibrary.status.success("Your money and levels have been reset. This cannot be undone.", player)

        -- despawn vehicles
        vehicleLibrary.despawnAllVehiclesOwnedByPlayer(player)

        -- cancel mission if in one
        local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
        if mission then
            mission:cancel(player)
        end

        -- actually reset
        moneyLibrary.remove(player)
        databaseLibrary.remove(databaseLibrary.field_name("level", player))

        -- now teleport
        player:teleport(config.game.spawn)
    else
        -- confirming
        playerStatesLibrary.setState(player, "reset_data")

        announceLibrary.status.warning("Type this command again to confirm that you want to reset your money and levels to the starting value.\n*This CANNOT be undone.*", player)
        chatAnnounce("Type the command again to reset your money and level.\nThis cannot be undone.", player)

        -- timeout
        cuhFramework.utilities.delay.create(15, function()
            playerStatesLibrary.removeState(player, "reset_data")
        end)
    end
end, "Resets your data (money, etc).")
