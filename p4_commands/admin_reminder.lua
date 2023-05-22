---------------------------------------
------------- Command - Reminder [Admin]
---------------------------------------

------------- ?reminder
cuhFramework.commands.create("reminder", {"rem"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local reminder = remindersLibrary.reminder.getRandom()

    if not reminder then
        return announceLibrary.status.failure("no reminder oops", player)
    end

    reminder:announce()
end)