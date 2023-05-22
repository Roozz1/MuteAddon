---------------------------------------
------------- Command - Mutes/unmutes a player
---------------------------------------

------------- Mute Handler
local muted = {}

---@param message message
messageLibrary.events.onMessageSend:connect(function(message)
    for i, v in pairs(muted) do
        if v[message.properties.author.properties.peer_id] then -- the person who sent this message is muted by v
            local player = cuhFramework.players.getPlayerByPeerId(i)

            if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then -- player probably left
                goto continue
            end

            message:delete(player)
        end

        ::continue::
    end
end)

------------- ?mute
cuhFramework.commands.create("mute", {"m"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Check
    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Make sure this player is setup
    if not muted[peer_id] then
        muted[peer_id] = {}
    end

    -- Main
    if args[1] then
        -- get target player
        local targetPlayer = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[1], false)

        -- check if valid
        if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(targetPlayer) then
            return announceLibrary.status.failure("This player doesn't exist. Did you type their name correctly?", player)
        end

        -- check if player is already muted
        local mutedData = muted[peer_id]

        if not mutedData[targetPlayer.properties.peer_id] then
            -- mute
            mutedData[targetPlayer.properties.peer_id] = targetPlayer

            -- and announce
            announceLibrary.status.success("You have muted "..targetPlayer.properties.name..".", player)
            announceLibrary.status.warning(player.properties.name.." muted you.", targetPlayer)
        else
            -- unmute
            mutedData[targetPlayer.properties.peer_id] = nil

            -- announce
            announceLibrary.status.success("You have unmuted "..targetPlayer.properties.name..".", player)
            announceLibrary.status.warning(player.properties.name.." unmuted you.", targetPlayer)
        end
    else
        return announceLibrary.status.failure("Please specify the player you would like to mute/unmute.\nThe name can be partial, as if you were searching for something on Google.\nExample: '?mute "..player.properties.name:sub(1, 3).."'", player)
    end
end, "Mute/unmute a player.")