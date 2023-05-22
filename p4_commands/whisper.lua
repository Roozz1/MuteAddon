---------------------------------------
------------- Command - Whisper to someone
---------------------------------------

------------- ?whisper
---@param message string
cuhFramework.commands.create("whisper", {"w", "dm", "pm"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Checks
    if not args[1] then
        return announceLibrary.status.failure("Please specify who you would like to whisper to (player name). For example: ?whisper *bob* 100. You can also do a partial name.", player)
    end

    if not args[2] then
        return announceLibrary.status.failure("Please specify what you want to say. For example: ?whisper bob *hey bob how's it going*.", player)
    end

    -- Get target player
    local target_player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[1], false)

    -- More checks
    if not target_player then
        return announceLibrary.status.failure("The player you searched for doesn't exist. Did you type their name correctly?", player)
    end

    if target_player == player then
        return announceLibrary.status.failure("You cannot whisper to yourself.", player)
    end

    -- Whisper
    table.remove(args, 1)

    local to_send = table.concat(args, " ")
    player:fake_chat("[WHISPER - To You] "..to_send, target_player) -- to target
    player:fake_chat("[WHISPER - To "..target_player.properties.name.."] "..to_send, player) -- to player
end, "Privately message someone.")