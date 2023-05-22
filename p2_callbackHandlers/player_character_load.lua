---------------------------------------
------------- Player Character Load
---------------------------------------

cuhFramework.callbacks.onObjectLoad:connect(function(object_id)
    -- Get variables
    local player = cuhFramework.players.getPlayerByObjectId(object_id)

    if not player then
        return
    end

    if player.properties.disconnecting then
        return
    end
    -- Give starter inventory
    eventsLibrary.get("giveInventory"):fire(player, inventoryLibrary.inventories.get("Starter"))
end)