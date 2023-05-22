---------------------------------------
------------- Vehicle Load
---------------------------------------

-- Load (voxel limit + anti-steal)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleLoad:connect(function(vehicle)
    -- Checks
    if vehicle.properties.addon_spawned then
        return
    end

    if not vehicleLibrary.is_vehicle_tracked(vehicle) then
        return
    end

    -- Get player
    local player = vehicle.properties.owner

    -- Check
    if vehicle["acknowledged"] then
        return
    end

	vehicle["acknowledged"] = true

    -- Anti-Steal
    vehicle:set_editable(false)

    -- Replenish
    replenishLibrary.vehicle.recharge(vehicle)
    replenishLibrary.vehicle.refillTanks(vehicle)
    replenishLibrary.vehicle.resupplyAmmo(vehicle)

    -- Get Variables
    local voxels = vehicle.properties.loaded_vehicle_data.voxels
    local maxVoxelLimit = vehicleLibrary.getDynamicVoxelLimit()

    -- Too many voxels
    if voxels > maxVoxelLimit then
        announceLibrary.status.failure("This vehicle has too many voxels.\n      Voxel Count: "..math.floor(voxels).."\n      Voxel Limit: "..math.floor(maxVoxelLimit), player)
        return vehicleLibrary.despawnVehicle(vehicle)
    end
end)