---------------------------------------
------------- Player Respawn
---------------------------------------

cuhFramework.callbacks.onPlayerRespawn:connect(function(peer_id)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Give starter inventory
    eventsLibrary.get("giveInventory"):fire(player, inventoryLibrary.inventories.get("Starter"))
end)