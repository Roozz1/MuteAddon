---------------------------------------
------------- Command - Teleport to a workbench
---------------------------------------

-- Workbenches
local workbenches = {
    ["ONeill"] = {
        cost = 2000,
        pos = matrix.translation(4113.8, 9.5, -5926.7)
    },

    ["Harrison"] = {
        cost = 2500,
        pos = matrix.translation(-5921.3, 13.3, -6107.7)
    },

    ["Tajin"] = {
        cost = 10000,
        pos = matrix.translation(-31140.2, 24.1, 91258.9)
    },

    ["Spawn"] = {
        cost = 1500,
        pos = config.game.spawn
    },

    ["NorthHarbor"] = {
        cost = 2500,
        pos = matrix.translation(1339.3, 7.6, -3669.1)
    }
}

local function getWorkbenchByName(input)
    for i, v in pairs(workbenches) do
        if i:lower():find(input:lower()) then
            return v, i
        end
    end
end

local function calculateCost(distance, workbench)
    return cuhFramework.utilities.number.clamp(workbench.cost * (distance / (workbench.cost * 1.5)), workbench.cost, workbench.cost * 50)
end

---@param player player
local function formattedWorkbenches(player)
    local list = {}
    local pos = player:get_position()

    for i, v in pairs(workbenches) do
        table.insert(list, i.." ["..moneyLibrary.format(calculateCost(matrix.distance(pos, v.pos), v)).."]\n\\__?wt "..i:sub(1, 3):lower())
    end

    return table.concat(list, "\n\n")
end

------------- ?workbench_tp
cuhFramework.commands.create("workbench_tp", {"wt"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Checks
    if debounceLibrary.debounce(player.properties.peer_id.."_commandworkbenchtp", 5) then -- cooldown
        return announceLibrary.status.warning("This command is on cooldown.", player)
    end

    if not args[1] then
        chatAnnounce("Available workbenches:\n"..formattedWorkbenches(player).."\n\n[!] The cost of teleporting to a workbench scales with distance.", player)
        return announceLibrary.status.failure("Please specify the name of the workbench you would like to teleport to. For example: ?wt *harrison*. You can also do a partial name (eg: harri).", player)
    end

    -- Get Workbench
    local workbenchData, name = getWorkbenchByName(args[1])

    -- Quick check
    if not workbenchData then
        return announceLibrary.status.failure("This workbench does not exist. Type '?wt' with no arguments to see a list of all workbenches.", player)
    end

    -- Check money
    moneyLibrary.get(player, function(money)
        local cost = calculateCost(matrix.distance((player:get_position()), workbenchData.pos), workbenchData)

        if money < cost then
            return announceLibrary.status.warning("You do not have enough money to travel to this workbench.\n"..moneyLibrary.compare(money, cost), player)
        else
            moneyLibrary.subtract(player, cost)
            player:teleport(workbenchData.pos)

            return announceLibrary.status.success("Successfully teleported you to "..name.." for "..moneyLibrary.format(cost)..".", player)
        end
    end)
end, "Teleports you to a workbench.")