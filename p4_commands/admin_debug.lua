---------------------------------------
------------- Command - Debug [Admin]
---------------------------------------

------------- ?debug
cuhFramework.commands.create("debug", {"de", "deb"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local args = {...}

    if args[1] then
        config.debugEnabled = not config.debugEnabled
        chatAnnounce("set config.debugEnabled to "..tostring(config.debugEnabled))
    else
        config.debugShouldLog = not config.debugShouldLog
        chatAnnounce("set config.debugShouldLog to "..tostring(config.debugShouldLog))
    end
end)

------------- ?plrs
cuhFramework.commands.create("plrs", {"pl"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local plr = cuhFramework.players.getPlayerByPeerId(peer_id)
    announceLibrary.status.success("check dbgview/chat", plr)

    df.printTbl(cuhFramework.players.connectedPlayers)
end)

------------- ?dinfo
local dinfos = {
    ["missions"] = missionLibrary.miscellaneous.getAllMissions,
    ["types"] = missionLibrary.miscellaneous.getAllMissionTypes,
    ["npcs"] = npcLibrary.getAll,
    ["plrs"] = function() return cuhFramework.players.connectedPlayers end,
    ["events"] = eventsLibrary.getAll,
    ["p_popups"] = easyPopupsLibrary.physical.getAll,
    ["debounces"] = debounceLibrary.getAll,
    ["disasters"] = disastersLibrary.disaster.getAll,
    ["states"] = playerStatesLibrary.getAll,
    ["vehicles"] = vehicleLibrary.getAll
}

cuhFramework.commands.create("dinfo", {"din"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local plr = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    if not args[1] then
        for i, v in pairs(dinfos) do
            chatAnnounce(i, plr)
        end

        return announceLibrary.status.failure("provide desired dinfo", plr)
    end

    local target = dinfos[args[1]]
    if not target then
        return announceLibrary.status.failure("invalid, type without args for all dinfos", plr)
    end

    announceLibrary.status.success("check dbgview/chat", plr)
    df.printTbl(target())
end)