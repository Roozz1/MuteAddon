---------------------------------------
------------- UI [Local]
---------------------------------------

------------- Main
cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    ------------- Physical Popups
    local missionDestinationUI = easyPopupsLibrary.physical.create("", matrix.translation(0, 0, 0), nil, peer_id + 15000, player, 99999999999)
    missionDestinationUI:setVisibility(false)

    ------------- Screen Popups
    -- Money
    local moneyUI = cuhFramework.ui.screen.create(peer_id + 12000, "Setting up...", 0, 0.9, player)
    cuhFramework.utilities.loop.create(1.5, function(id)
        -- safety checks
        if not moneyUI or not cuhFramework.players.getPlayerByPeerId(peer_id) then
            cuhFramework.utilities.loop.ongoingLoops[id] = nil
            return
        end

        -- main stuffs
        moneyLibrary.get(player, function(money)
            if not moneyUI or not cuhFramework.players.getPlayerByPeerId(peer_id) then
                cuhFramework.utilities.loop.ongoingLoops[id] = nil
                return
            end

            moneyUI:edit(moneyLibrary.format(money))
        end)
    end)

    -- Level
    local levelUi = cuhFramework.ui.screen.create(peer_id + 14000, "Setting up...", 0, 0.8, player)
    cuhFramework.utilities.loop.create(1.5, function(id)
        -- safety checks
        if not levelUi or not cuhFramework.players.getPlayerByPeerId(peer_id) then
            cuhFramework.utilities.loop.ongoingLoops[id] = nil
            return
        end

        -- main stuffs
        levelsLibrary.get(player, function(level)
            if not levelUi or not cuhFramework.players.getPlayerByPeerId(peer_id) then
                cuhFramework.utilities.loop.ongoingLoops[id] = nil
                return
            end

            levelUi:edit(levelsLibrary.format(level))
        end)
    end)

    -- Mission
    local missionUI = cuhFramework.ui.screen.create(peer_id + 13000, "Mission In Progress", 0, 0.7, player)
    missionUI:setVisibility(false)

    -- Discord
    local discord_ui = cuhFramework.ui.screen.create(peer_id + 10000, "Discord:\n"..config.info.discord, -0.9, 0.2, player)

    -- Help
    local help_ui = cuhFramework.ui.screen.create(peer_id + 11000, "Type '?help' for help.", -0.9, 0.37, player)

    ------------- Map UI
    -- Resupply Stations [Map Objects]
    for i, v in pairs(resupplyStationsLibrary.getAll()) do
        v:refreshMapUI(player, true, true) -- show resupply stations, but dont remove/refresh/thingy
    end

    -- Spawn [Map Object]
    server.addMapObject(-1, 4001, 0, 1, config.game.spawn[13], config.game.spawn[15], 0, 0, 0, 0, "Spawn", 100, "New? Type '?help'.", 255, 255, 255, 255)
end)