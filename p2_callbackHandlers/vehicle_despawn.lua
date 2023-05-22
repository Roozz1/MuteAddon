---------------------------------------
------------- Vehicle Despawn
---------------------------------------

dont_refund = {}
recognisedDespawns = {}

-- Despawn (recognise, refund, etc)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleDespawn:connect(function(vehicle)
    -- Check
    if vehicle.properties.addon_spawned then
        return
    end

    if recognisedDespawns[vehicle.properties.vehicle_id] then
        return
    end

    -- Get variables
    local player = vehicle.properties.owner
    local name = player.properties.name

    -- Announce
    local formattedName = vehicleLibrary.getFormattedName(vehicle)
    cuhFramework.utilities.delay.create(0.11, function() -- prevent despawn message appearing before spawn message
        chatAnnounce(formattedName.." owned by "..name.." has been despawned.")
    end)

    -- Untrack
    vehicleLibrary.untrack_vehicle_by_vehicle_id(vehicle.properties.vehicle_id)

    -- Refund
    if not dont_refund[vehicle.properties.vehicle_id] then
        -- refund
        local refund_amount = miscellaneousLibrary.percentageOfNumber(vehicle.properties.cost, config.vehicles.refund_percentage)
        moneyLibrary.add(player, refund_amount)

        -- and announce the refund
        announceLibrary.status.success("You have been refunded "..moneyLibrary.format(refund_amount).." out of "..moneyLibrary.format(vehicle.properties.cost)..".", player)

        -- also, remove saved vehicle cost since player has been refunded
        databaseLibrary.subtract(
            databaseLibrary.field_name("totalVehCost", vehicle.properties.owner),
            vehicle.properties.cost
        )
    end

    -- Set recognised
    recognisedDespawns[vehicle.properties.vehicle_id] = true
end)