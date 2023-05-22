---------------------------------------
------------- Command - Despawn your vehicles
---------------------------------------

------------- ?clean
cuhFramework.commands.create("clean", {"c", "clear", "despawn", "d"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Despawn
    if args[1] then
        -- Check if ID or name
        local isId = tonumber(args[1])

        -- Get vehicle, by ID or name
        local vehicle

        if isId then
            vehicle = vehicleLibrary.get_vehicle_by_vehicle_id(isId)
        else
            vehicle = vehicleLibrary.get_vehicle_by_name(args[1]:gsub("_", ""))
        end

        -- Main stuffs
        if not vehicle then
            return announceLibrary.status.failure("The vehicle you want to despawn could not be found.", player)
        end

        if vehicle.properties.owner and vehicle.properties.owner ~= player then --ERR: if owner is nil, it might error? tested in lua.org/demo.html, doesnt error i think
            return announceLibrary.status.failure("You do not own this vehicle.", player)
        end

        vehicleLibrary.despawnVehicle(vehicle)
    else
        vehicleLibrary.despawnAllVehiclesOwnedByPlayer(player)
    end

    -- Announce
    announceLibrary.status.success("Successfully despawned your vehicle(s)."..cuhFramework.utilities.miscellaneous.switchbox("\n\nTip: If you want to despawn a specific vehicle, type the name/ID of it.\nIt does not have to be the exact same, a partial name will be fine.\nType '?vehicles' to see your vehicles.\nExample: '?c my_vehicle'. Make sure to use underscores for spaces.", "", args[1]), player)
end, "Despawns your vehicle(s).")