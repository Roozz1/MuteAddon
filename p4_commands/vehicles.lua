---------------------------------------
------------- Command - See your spawned vehicles
---------------------------------------

------------- ?vehicles
cuhFramework.commands.create("vehicles", {"v", "veh"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local list = vehicleLibrary.getVehicleList(player, true)

    -- Announce
    announceLibrary.status.success("Check chat to see a list of your vehicles.", player)

    -- Show
    if list then
        chatAnnounce("Vehicles ("..(#list).."):\n"..table.concat(list, "\n"), player)
    else
        chatAnnounce("Vehicles (0):\nNo vehicles spawned.", player)
    end
end, "Shows your spawned vehicles.")