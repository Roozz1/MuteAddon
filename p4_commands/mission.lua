---------------------------------------
------------- Command - Starts/Cancels a mission
---------------------------------------

------------- ?start
cuhFramework.commands.create("start", {"s"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Get mission
    local mission = missionLibrary.miscellaneous.getMissionByPosition(player:get_position())

    -- Quick checks
    if missionLibrary.miscellaneous.isPlayerPartakingInAMission(player) then
        return announceLibrary.status.failure("You are already partaking in a mission. Type '?cancel' to cancel it.", player)
    end

    if not mission then
        return announceLibrary.status.failure("You are not in a mission activation zone. Check the map to find missions to start.", player)
    end

    if not mission.properties.available then
        return announceLibrary.status.failure("This mission is not available at the moment.", player)
    end

    if debounceLibrary.debounce(player.properties.peer_id.."_missioncommand1", 3) then
        return announceLibrary.status.failure("This command is on cooldown.", player)
    end

    -- Main stuffs
    levelsLibrary.get(player, function(level)
        -- Check if level is high enough
        if level < mission.properties.minimumLevel then
            return announceLibrary.status.failure("Your level is not high enough.\nYour Level: "..levelsLibrary.format(level).."\nLevel Needed: "..levelsLibrary.format(mission.properties.minimumLevel).."+", player)
        end

        -- Start mission
        mission:start(player)
    end)
end, "Starts a mission.")

------------- ?cancel
cuhFramework.commands.create("cancel", {"ca"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Get mission
    local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)

    -- Quick check
    if not mission then
        return announceLibrary.status.failure("You haven't started a mission. Check the map to find missions to start.", player)
    end

    if debounceLibrary.debounce(player.properties.peer_id.."_missioncommand2", 3) then
        return announceLibrary.status.failure("This command is on cooldown.", player)
    end

    -- Cancel
    mission:cancel(player)
end, "Cancels your mission.")

------------- ?details
cuhFramework.commands.create("details", {"det"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Checks
    if not args[1] then
        return announceLibrary.status.failure("Please provide the name of the mission you would like to get information about. The name can be partial, just like when you search something with Google.\nExample: \"?details bob's_la\" - Shows information on the \"Bob's Laptop Delivery\" mission.", player)
    end

    -- Get mission
    local mission = missionLibrary.miscellaneous.getMissionBySearch(args[1]:gsub("_", " "))

    -- Quick check
    if not mission then
        return announceLibrary.status.failure("This mission doesn't exist.", player)
    end

    -- Show details
    announceLibrary.status.success("Check chat to see information about \""..mission.properties.name.."\" (Mission).")
    chatAnnounce(missionLibrary.miscellaneous.formatMissionDetailsIntoString(mission), player)
end, "Shows mission information.")