---------------------------------------
------------- Mission
---------------------------------------

---@param player player
---@param mission mission
function bothCancelAndCompletion(player, mission)
    if not player then
        return
    end

    -- hide ui
    local ui = cuhFramework.ui.screen.get(player.properties.peer_id + 13000)
    if ui then
        ui:setVisibility(false)
    end

    -- hide mission destination popup
    local destinationUI = easyPopupsLibrary.physical.get(player.properties.peer_id + 15000)

    if destinationUI then
        destinationUI:setVisibility(false)
    end
end

cuhFramework.utilities.delay.create(0.01, function()
    ------------- onStart
    ---@param player player
    ---@param mission mission
    eventsLibrary.get("mission_globalOnStart"):connect(function(player, mission)
        -- debug
        df.print(mission.properties.name.." starting for "..player.properties.name)

        -- announce
        miscellaneousLibrary.groupCall({chatAnnounce, notificationAnnounce}, "[!] You have started a mission.\n"..missionLibrary.miscellaneous.formatMissionBasicsIntoString(mission, 5)..cuhFramework.utilities.miscellaneous.switchbox("", "\nBe careful! This mission becomes temporarily unavailable upon completion.", mission.properties.cancelsOnCompletion), player)

        chatAnnounce(player.properties.name.." has started a mission.\n\\__"..mission.properties.name)
        announceLibrary.discordAnnounce("has started a mission.\n"..mission.properties.name, player.properties.name, ":factory_worker: :white_check_mark: ")

        -- show ui
        local ui = cuhFramework.ui.screen.get(player.properties.peer_id + 13000)
        if ui then
            ui:setVisibility(true)
        end

        -- show mission destination popup
        local destinationUI = easyPopupsLibrary.physical.get(player.properties.peer_id + 15000)
        if destinationUI then
            destinationUI:edit("[Destination]", mission.properties.completionPosition)
            destinationUI:setVisibility(true)
        end
    end)

    ------------- onCompletion
    ---@param player player
    ---@param mission mission
    eventsLibrary.get("mission_globalOnCompletion"):connect(function(player, mission)
        -- debug
        df.print(mission.properties.name.." completed by "..player.properties.name..")")

        -- give money
        moneyLibrary.add(player, mission.properties.reward)

        -- give level
        levelsLibrary.increase(player, mission.properties.levelToGiveOnCompletion)

        -- announce
        local formatted = moneyLibrary.format(mission.properties.reward)
        miscellaneousLibrary.groupCall({chatAnnounce, notificationAnnounce}, "[!] You have completed your mission.\n   +"..formatted.."\n   +"..levelsLibrary.format(mission.properties.levelToGiveOnCompletion, true), player)

        chatAnnounce(player.properties.name.." has completed a mission.\n\\__"..mission.properties.name)
        announceLibrary.discordAnnounce("has completed a mission.\n"..mission.properties.name.."\n+"..formatted, player.properties.name, ":factory_worker: :money_with_wings: ")

        -- stuffs
        bothCancelAndCompletion(player, mission)
    end)

    ------------- onCancellation
    ---@param player player
    ---@param mission mission
    eventsLibrary.get("mission_globalOnCancellation"):connect(function(player, mission)
        -- debug
        df.print(mission.properties.name.." cancelled for "..player.properties.name)

        -- announce
       miscellaneousLibrary.groupCall({chatAnnounce, notificationAnnounce}, "[!] Your mission, "..mission.properties.name..", was cancelled.", player)

       chatAnnounce(player.properties.name.." has cancelled a mission.\n\\__"..mission.properties.name)
       announceLibrary.discordAnnounce("has cancelled a mission.\n"..mission.properties.name, player.properties.name, ":factory_worker: :x: ")

       -- stuffs
       bothCancelAndCompletion(player, mission)
    end)

    ------------- availabilityChanged
    ---@param mission mission
    eventsLibrary.get("mission_globalAvailabilityChanged"):connect(function(mission, available)
        -- debug
        df.print(mission.properties.name.." availability set to "..tostring(available))

        -- announce
        if available then
            chatAnnounce(mission.properties.name.." (Mission) is now available.")
            announceLibrary.discordAnnounce(mission.properties.name.." (Mission) is now available.", nil, ":desktop:")
        else
            chatAnnounce(mission.properties.name.." (Mission) is no longer available.")
            announceLibrary.discordAnnounce(mission.properties.name.." (Mission) is no longer available.", nil, ":desktop:")
        end
    end)

    ------------- onRemoval
    ---@param mission mission
    eventsLibrary.get("mission_globalOnRemoval"):connect(function(mission, available)
        -- debug
        df.print(mission.properties.name.." was removed")

        -- announce
        chatAnnounce(mission.properties.name.." (Mission) has been removed.")
        announceLibrary.discordAnnounce(mission.properties.name.." (Mission) has been moved.", nil, ":desktop::x:")
    end)
end)