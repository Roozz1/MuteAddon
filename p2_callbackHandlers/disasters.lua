---------------------------------------
------------- Disasters
---------------------------------------
cuhFramework.utilities.delay.create(0.01, function() -- wait some time for events to be made
    -- handle disaster start
    ---@param disaster disaster
    disasterStart:connect(function(disaster, position)
        -- create map object
        server.addMapObject(-1, 4003, 0, 8, position[13], position[15], 0, 0, 0, 0, "Disaster - "..disaster.name, 500, "A disaster has started in this area.\nBe careful.")

        -- announce
        local message = disaster.name.." [Disaster] has started at "..miscellaneousLibrary.matrixFormatted(position)..". Be careful!"
        chatAnnounce(message)
        announceLibrary.discordAnnounce(message, nil, ":boom:")
    end)

    -- handle disaster stop
    ---@param disaster disaster
    disasterStop:connect(function(disaster, position)
        -- remove map object
        server.removeMapObject(-1, 4003)

        -- announce
        local message = disaster.name.." [Disaster] has ended."
        chatAnnounce(message)
        announceLibrary.discordAnnounce(message, nil, ":boom:")
    end)
end)