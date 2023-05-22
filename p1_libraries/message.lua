---------------------------------------
------------- Message
---------------------------------------

------------- Variables
---@type table<integer, message>
local messages = {}

------------- Library
messageLibrary = {
    initialize = function()
        -- log messages
        cuhFramework.callbacks.onChatMessage:connect(function(peer_id, _, message)
            -- get thy player
            local player = cuhFramework.players.getPlayerByPeerId(peer_id)

            if not player then
                df.print(("failed to retrieve player. peer_id = %s"):format(peer_id), nil, "(messageLibrary.initialize)")
            end

            -- enforce thy message limit
            if #messages >= 50 then
                table.remove(messages, 1)
            end

            -- log thy message
            table.insert(messages, messageLibrary.messages.construct(player, message))
        end)
    end,

    messages = {
        ---@param player player
        ---@return message
        construct = function(player, content)
            return {
                properties = {
                    author = player,
                    content = content
                },

                ---@param self message
                delete = function(self, _player)
                    return messageLibrary.messages.delete(self, player)
                end,

                ---@param self message
                edit = function(self, newContent, _player)
                    return messageLibrary.messages.edit(self, newContent, player)
                end,
            }
        end,

        ---@param message message
        ---@param player player|nil
        delete = function(message, player)
            -- clear chat
            cuhFramework.chat.clear(player)

            -- send all logged messages apart from the message that needs to be deleted
            for i, v in pairs(messages) do
                -- remove the message from log if its the message that needs to be deleted
                if v == message then
                    table.remove(messages, i)
                    goto continue
                end

                -- send the message
                cuhFramework.chat.send_message(v.properties.author.properties.name, v.properties.content, player)

                -- go to next
                ::continue::
            end
        end,

        ---@param message message
        ---@param player player|nil
        edit = function(message, newContent, player)
            -- clear chat
            cuhFramework.chat.clear(player)

            -- send all logged messages, including the now edited target message
            for i, v in pairs(messages) do
                -- remove the message from log if its the message that needs to be deleted
                if v == message then
                    v.properties.content = newContent
                    messages[i] = v
                end

                -- send the message
                cuhFramework.chat.send_message(v.properties.author.properties.name, v.properties.content, player)
            end
        end,

        getAll = function()
            return messages
        end,

        getMostRecent = function()
            return messages[#messages]
        end
    },

    events = {
        onMessageSend = eventsLibrary.new("onMessageSend"), -- first param = message
        onMessageEdit = eventsLibrary.new("onMessageEdit"), -- first param = message
       onMessageDelete = eventsLibrary.new("onMessageDelete") -- first param = message
    }
}