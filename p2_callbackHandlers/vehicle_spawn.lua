---------------------------------------
------------- Vehicle Spawn
---------------------------------------

-- Spawn (addon vehicles - refill battery)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    -- Main stuff
    if vehicle.properties.addon_spawned then
        df.print("is addon spawned - "..vehicle.properties.vehicle_id.. " | addon spawned vehicle | callbackhandler vehicle.lua")
        cuhFramework.utilities.loop.create(0.5, function(id)
            -- Check if spawned still
            local vehicle_check = cuhFramework.vehicles.getVehicleByVehicleId(vehicle.properties.vehicle_id)

            if not vehicle_check then
                cuhFramework.utilities.loop.ongoingLoops[id] = nil
                return
            end

            -- Refill battery
            server.setVehicleBattery(vehicle.properties.vehicle_id, config.game.static_vehicle_battery_name, 100)
        end)
    end
end)

-- Setup (anti-lag, recognise, etc)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    -- Set server money
    server.setCurrency(9999999999, 9999999999)

    -- Set don't refund (turn off when need to refund)
    dont_refund[vehicle.properties.vehicle_id] = true

    -- Checks
    if vehicle.properties.addon_spawned then
        return
    end

    -- Get player
    local player = vehicle.properties.owner

    -- Announce
    local formattedName = vehicleLibrary.getFormattedName(vehicle)
    chatAnnounce(formattedName.." owned by "..player.properties.name.." has been spawned.")

    -- Track
    vehicleLibrary.track_vehicle(vehicle)

    -- Too many vehicles spawned
    local count = vehicleLibrary.getVehicleCountOfPlayer(player)

    if count > config.vehicles.limit then
        announceLibrary.status.failure("You can only have "..config.vehicles.limit.." vehicle spawned.", player)
        return vehicleLibrary.despawnVehicle(vehicle)
    end

    -- Anti-Steal
    vehicle:set_editable(false)

    -- Measure TPS impact
    chatAnnounce("The TPS impact of your vehicle is being measured. If the TPS impact is too high, it will be despawned.\nThis process takes "..math.floor(config.vehicles.antiLag.maxTpsImpactMeasureTime).." seconds.", player)

    local spawnTps = cuhFramework.tps.getTPSData().averageTPS
    cuhFramework.utilities.delay.create(config.vehicles.antiLag.maxTpsImpactMeasureTime, function()
        if not vehicleLibrary.is_vehicle_tracked_by_vehicle_id(vehicle.properties.vehicle_id) then
            return df.print("vehicle spawn - id "..vehicle.properties.vehicle_id.." - owned by nil | tps impact - vehicle no longer tracked")
        end

        -- Get TPS
        local currentTps = cuhFramework.tps.getTPSData().averageTPS

        -- Check if impact is positive/none
        if currentTps >= spawnTps then
            return
        end

        -- Get impact
        local max_impact = vehicleLibrary.getDynamicTPSImpact()
        local impact = math.abs(currentTps - spawnTps)

        -- Too high
        if impact >= max_impact then
            announceLibrary.status.failure("The TPS impact from your vehicle was too high.\nMax Impact: "..cuhFramework.utilities.number.round(max_impact, 1).." TPS \nTPS Impact: "..cuhFramework.utilities.number.round(impact, 1).." TPS", player)
            return vehicleLibrary.despawnVehicle(vehicle)
        end
    end)

    -- Check if player has enough money for the vehicle
    moneyLibrary.get(player, function(money)
        if money < vehicle.properties.cost then
            announceLibrary.status.warning("You do not have enough money to spawn this vehicle.\n"..moneyLibrary.compare(money, vehicle.properties.cost), player)
            return vehicleLibrary.despawnVehicle(vehicle)
        else
            announceLibrary.status.success("You have been charged "..moneyLibrary.format(vehicle.properties.cost).." for your vehicle.", player)
            moneyLibrary.subtract(player, vehicle.properties.cost)
            dont_refund[vehicle.properties.vehicle_id] = false

            -- save vehicle cost in case server restarts/crashes
            databaseLibrary.add(
                databaseLibrary.field_name("totalVehCost", vehicle.properties.owner),
                vehicle.properties.cost
            )
        end
    end)
end)

-- Spawn (tooltip, etc)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    if vehicle.properties.addon_spawned then
        return
    end

    -- Main
    cuhFramework.utilities.delay.create(0.1, function()
        -- Checks
        if not vehicleLibrary.get_vehicle_by_vehicle_id(vehicle.properties.vehicle_id) then
            return
        end

        -- Get player
        local player = vehicle.properties.owner

        -- Set Tooltip
        local formattedName = vehicleLibrary.getFormattedName(vehicle)
        vehicle:set_tooltip(formattedName.."\nOwner: "..player.properties.name)
    end)
end)