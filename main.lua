------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------

--------------
--[[
    cuhHub Missions Addon
    Created by cuh4#7366

    This addon uses the cuhFramework, see above.
]]

--[[
    UI IDs:
        4001 = Spawn Map Object
        4002 = Resupply Station Point
        4003 = Disaster Map Object

        mission_id + 5000 = Mission Physical Popup UI
        mission_id + 5200 = Mission Map UI

        object_id + 7500 = NPC Chat Bubble

        peer_id + 10000 = Discord
        peer_id + 11000 = ?help
        peer_id + 12000 = Money UI
        peer_id + 13000 = Mission In Progress UI
        peer_id + 14000 = Level UI
        peer_id + 15000 = Mission Destination Physical Popup UI
        
        vehicle_id + 500 = Mission Vehicle Physical Popup
        object_idid + 25000 = Mission Character Physical Popup
]]
--------------

----------------------------------------------------------------
-- Variables
----------------------------------------------------------------
---@type table<integer, player>
players_unfiltered = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
------------- Uncategorised
chatAnnounce = function(message, player)
    cuhFramework.chat.send_message(miscellaneousLibrary.surround(config.info.server_name, "[]"), message, player)
end

notificationAnnounce = function(message, player)
    cuhFramework.ui.notifications.custom(miscellaneousLibrary.surround(config.info.server_name, "[]"), message, player, 7)
end

---@return player
getRandomPlayer = function()
    return cuhFramework.utilities.table.getRandomValue(players_unfiltered)
end

---@param min number|minMax
---@param max number|nil
minMax = function(min, max)
    if type(min) == "number" then
        return {
            min = min,
            max = max
        }
    elseif type(min) == "table" then
        if min.min > min.max then
            df.print("min over max")
            return 0
        end

        return math.random(min.min, min.max)
    else
        df.print("invalid min for minmax")
        return 0
    end
end

----------------------------------------------------------------
-- Loops
----------------------------------------------------------------
------------- Disasters
cuhFramework.utilities.loop.create(config.game.disasters.spawnTimer, function()
    -- must have a player in the server
    if miscellaneousLibrary.getPlayerCount() == 0 then
        return
    end

    -- get random player
    local player = getRandomPlayer()

    -- quick check
    if not player then
        return
    end

    -- get variables
    local playerPos = player:get_position()
    local randomPos = cuhFramework.utilities.matrix.scatterPosition(playerPos, 5000, false)

    local randomDisaster = disastersLibrary.disaster.getRandomDisaster()

    -- and now actually spawn the disaster
    disastersLibrary.disaster.start(randomDisaster, randomPos)
end)

------------- Cleanup
cuhFramework.utilities.loop.create(30, function()
    -- Remove radiation
    server.clearRadiation()

    -- Despawn objects
    cleanupLibrary.clearObjects()
end)

------------- Reminders
cuhFramework.utilities.loop.create(100, function()
    -- check if enough players in the server
    if miscellaneousLibrary.getPlayerCount() == 0 then
        return
    end

    -- get random reminder
    local reminder = remindersLibrary.reminder.getRandom()

    -- announce it
    if reminder then
        reminder:announce()
    end
end)

----------------------------------------------------------------
-- Setup
----------------------------------------------------------------
------------- Reload
for i = 1, 60000 do
    -- Remove UI
    cuhFramework.ui.screen.remove(i)
    server.removeMapID(-1, i)
    server.removeMapLine(-1, i)
    server.removeMapObject(-1, i)
    server.removeMapLabel(-1, i)

    -- Remove physical stuff
    local veh_data, success = server.getVehicleData(i)

    if not cuhFramework.characters.getCharacterByObjectId(i) then -- prevent despawning npcs
        cuhFramework.objects.despawnObject(i)
    end

    -- Despawn vehicles
    if success and veh_data.tags_full:find("railroad_signal") then -- prevent despawning railroad signals
        goto continue
    end

    cuhFramework.vehicles.despawnVehicle(i)

    -- Continue replacement
    ::continue::
end

------------- Tracebacks
cuhFramework.callbacks.onCreate:connect(function()
    traceback.onCreate()
end)

------------- Spawn Billboard
cuhFramework.vehicles.spawnAddonVehicle(config.playlistIds.BILLBOARD, matrix.multiply(config.game.billboardPosition, matrix.rotationY(config.game.billboardRotation)))

------------- Inits
debugLibrary.initialize()
missionLibrary.initialize()
resupplyStationsLibrary.initialize()
disastersLibrary.initialize()
easyPopupsLibrary.initialize()
eventsLibrary.initialize()

persistentLocationController.setDefaultPos(config.game.spawn)
persistentLocationController.setStartEnabled(true)

---@param player player
persistentLocationController.events.onTeleport:connect(function(player, success)
    if success then
        chatAnnounce("You have been teleported to where you was the last time you played on this server.\nIf you want to quickly get to a workbench, type '?wt' in chat.", player)
    else
        chatAnnounce("The addon failed to grab your location from the last time you played. Please report this to the developers in the Discord.", player)
    end
end)

-- respawnController.setDefaultCustomRespawnAllowed(false) -- disabled for now

------------- Storages
globalStorage = storageLibrary.new("Global Storage")

------------- Inventory
-- Items
local itemRope = inventoryLibrary.items.new("Rope", 22, 0, 0, 1)

local itemFlashlight = inventoryLibrary.items.new("Flashlight", 15, 0, 100, 2)
local itemBinoculars = inventoryLibrary.items.new("Binoculars", 6, 1, 1, 3)
local itemRadio = inventoryLibrary.items.new("Radio", 19, 1, 100, 4)
local itemStrobeLight = inventoryLibrary.items.new("Strobe Light", 23, 1, 100, 5)
local itemOxygenMask = inventoryLibrary.items.new("Oxygen Mask", 18, 0, 100, 7)
local itemMedkit = inventoryLibrary.items.new("First-Aid Kit", 11, 4, 4, 8)

local itemParachute = inventoryLibrary.items.new("Parachute", 4, 1, 1, 10)

-- Inventories
local starterInventory = inventoryLibrary.inventories.new("Starter", itemRope, itemFlashlight, itemBinoculars, itemRadio, itemStrobeLight, itemOxygenMask, itemMedkit, itemParachute)

---@param player player
---@param inventory inventory
eventsLibrary.new("giveInventory"):connect(function(player, inventory)
    starterInventory:give(player)
    announceLibrary.status.status("You have been given the '"..inventory.properties.name.."' inventory.\n"..table.concat(inventory:itemsToNamesInTable(), "\n"), player)
end)

------------- Reminders
-- Categories
local reminderCategoryMissions = remindersLibrary.category.new("Missions")
local reminderCategoryResupplyStations = remindersLibrary.category.new("Resupply Stations")
local reminderCategoryDisasters = remindersLibrary.category.new("Disasters")
local reminderCategoryMoney = remindersLibrary.category.new("Money")
local reminderCategoryLevels = remindersLibrary.category.new("Levels")
local reminderCategoryCommands = remindersLibrary.category.new("Commands")
local reminderCategoryVehicles = remindersLibrary.category.new("Vehicles")

-- Reminders
reminderCategoryMissions:newReminder(1, "To start a mission, head to a mission activation zone and type '?start'.\nType '?help' to see the short versions of all commands.")
reminderCategoryMissions:newReminder(3, "To cancel your active mission, type '?cancel'.")
reminderCategoryMissions:newReminder(4, "Missions require you to be above a certain level. You can obtain levels by completing missions.")
reminderCategoryMissions:newReminder(5, "Want to see mission details? Zoom in on a mission start point on the map, and mission details will appear.")

reminderCategoryCommands:newReminder(2, "Type '?help' to see all commands.")

reminderCategoryDisasters:newReminder(6, "Random disasters start every few minutes. Their location is shown on the map. Safe travels!")

reminderCategoryResupplyStations:newReminder(7, "Out of fuel? Out of electricity? Head to a resupply station to refuel and recharge. They are marked on the map.")

reminderCategoryMoney:newReminder(8, "Want to transfer money? Type '?transfer'.\nExample: '?transfer cuh4 10000'. Replace 'cuh4' with the name of the person you would like to transfer money to. The name can be partial (eg: 'cu').")
reminderCategoryMoney:newReminder(10, "Completing missions will give you money.")

reminderCategoryLevels:newReminder(9, "To earn levels, complete missions.")

reminderCategoryVehicles:newReminder(11, "Vehicles cost money since this is a custom career server. You can earn money by completing missions.")
reminderCategoryVehicles:newReminder(12, "You can despawn your vehicle with '?c'. Type '?help' to see the short versions of all commands.")
reminderCategoryVehicles:newReminder(13, "Want to despawn a specific vehicle? Type the name of the vehicle you want to despawn after you type '?c'. Example: '?c plane'. The name can be a partial name, and it is not caps-sensitive.\nType '?vehicles' to see all of your spawned vehicles and their names.")

------------- Cleanup - Object Type Exceptions
cleanupLibrary.add_object_type_exception(58) -- fire
cleanupLibrary.add_object_type_exception(66) -- c4
cleanupLibrary.add_object_type_exception(1) -- character
cleanupLibrary.add_object_type_exception(72) -- creature
cleanupLibrary.add_object_type_exception(72) -- glowstick

------------- Resupply Stations (add 0.35 meters to y when planting one)
resupplyStationsLibrary.new("Spawn", matrix.translation(-27.7, 4.55, 11.5))
resupplyStationsLibrary.new("Holt Town", matrix.translation(221.1, 6.56, -4915.5))
resupplyStationsLibrary.new("North Harbor", matrix.translation(1290, 4.73, -3584))
resupplyStationsLibrary.new("Terminal Endo", matrix.translation(-28970.4, 17, 89578))
resupplyStationsLibrary.new("Harrison Airbase", matrix.translation(-5938.5, 13.65, -6103.5))

------------- Disasters
-- disastersLibrary.disaster.create( --ERR: lag from forest fires
--     "Meteor Shower",
--     function(disaster, position) ---@param disaster disaster
--         server.spawnMeteorShower(position, 1, false)
--     end,
--     function() end,
--     50
-- )

disastersLibrary.disaster.create(
    "Whirlpool",
    function(disaster, position) ---@param disaster disaster
        server.spawnWhirlpool(position, 1)
    end,
    function()
        server.cancelGerstner()
    end,
    300
)

disastersLibrary.disaster.create(
    "Tornado",
    function(disaster, position) ---@param disaster disaster
        server.spawnTornado(position)
    end,
    function() end,
    300
)

----------------------------------------------------------------
-- Mission Types
----------------------------------------------------------------
------------- Vehicle Towing
-- Handlers
---@param player player
---@param mission mission
function vehicleTowStart(player, mission, playlistId)
    -- get storage
    local storage = mission.properties.storage

    -- check if vehicle exists already, if so, despawn
    local vehicle = storage:get(player.properties.peer_id.."_vehicle")

    if vehicle then
        vehicle:despawn()
        storage:remove(player.properties.peer_id.."_vehicle")
    end

    -- spawn vehicle
    local new_vehicle = cuhFramework.vehicles.spawnAddonVehicle(playlistId, cuhFramework.utilities.matrix.offsetPosition(mission.properties.startPosition, 0, 5, 5))

    if not new_vehicle then
        return chatAnnounce("Sorry, the addon failed to spawn a vehicle for your mission. Please report this to the developers in the Discord.", player)
    end

    storage:add(player.properties.peer_id.."_vehicle", new_vehicle)
    new_vehicle:set_tooltip("Mission:\n"..mission.properties.name.."\n\n"..moneyLibrary.format(mission.properties.reward).."\n"..player.properties.name)

    -- popup
    storage:add(player.properties.peer_id.."_popup_"..new_vehicle.properties.vehicle_id, easyPopupsLibrary.physical.create("Vehicle\n"..moneyLibrary.format(mission.properties.reward), matrix.translation(0, 3, 0), new_vehicle.properties.vehicle_id, new_vehicle.properties.vehicle_id + 500, player, 9999999))

    -- completion loop
    storage:add(player.properties.peer_id.."_completion_loop", cuhFramework.utilities.loop.create(1, function(id)
        -- check if mission still exists/is available
        local new_mission =  missionLibrary.main.get(mission.properties.name)

        if not new_mission then
            return
        end

        if not mission.properties.available then
            return
        end

        -- check if vehicle has arrived at the destination, if so, complete the mission for the player
        ---@type vehicle
        local actual_vehicle = storage:get(player.properties.peer_id.."_vehicle")

        if not actual_vehicle then
            return
        end

        local vehicle_pos = actual_vehicle:get_position()

        if matrix.distance(vehicle_pos, mission.properties.completionPosition) < 15 then
            mission:complete(player)
        end
    end))
end

---@param player player
---@param mission mission
function vehicleTowFinish(player, mission)
    -- get storage
    local storage = mission.properties.storage

    -- remove completion loop for player
    local loop = storage:get(player.properties.peer_id.."_completion_loop")

    if loop then
        loop:remove()
    end

    storage:remove(player.properties.peer_id.."_completion_loop")

    -- get vehicle
    ---@type vehicle
    local vehicle = storage:get(player.properties.peer_id.."_vehicle")

    -- check if exists
    if vehicle then
        -- despawn it
        vehicle:despawn()

        -- remove popup
        easyPopupsLibrary.physical.remove(vehicle.properties.vehicle_id + 500)
    end

    storage:remove(player.properties.peer_id.."_vehicle")
end

-- Types
-- Car
missionLibrary.types.create("Car Towing - Small",
    ---@param player player
    ---@param mission mission
    function(player, mission)
        vehicleTowStart(player, mission, config.playlistIds.LAND_VEHICLE_ONE)
    end,

    vehicleTowFinish,
    vehicleTowFinish,
    nil,
    nil,
    nil,
    colorLibrary.RGB.new(255, 125, 0)
)

missionLibrary.types.create("Car Towing - Large",
    ---@param player player
    ---@param mission mission
    function(player, mission)
        vehicleTowStart(player, mission, config.playlistIds.LAND_VEHICLE_TWO)
    end,

    vehicleTowFinish,
    vehicleTowFinish,
    nil,
    nil,
    nil,
    colorLibrary.RGB.new(255, 200, 50)
)

-- Sea
missionLibrary.types.create("Boat Towing - Medium",
    ---@param player player
    ---@param mission mission
    function(player, mission)
        vehicleTowStart(player, mission, config.playlistIds.SEA_VEHICLE_ONE)
    end,

    vehicleTowFinish,
    vehicleTowFinish,
    nil,
    nil,
    nil,
    colorLibrary.RGB.new(180, 180, 255)
)

------------- Cargo Delivery
-- Handlers
---@param player player
---@param mission mission
function cargoDeliveryStart(player, mission, playlistId, amount)
    -- enforce limit
    amount = cuhFramework.utilities.number.clamp(amount, 1, config.misc.maxCargo)

    -- get storage
    local storage = mission.properties.storage

    -- cargo stuffs
    local cargoStorage = {}

    for i = 1, amount do
        -- spawn cargo
        local x_offset = 4

        if amount == 1 then -- prevent cargo not being on target when theres jsut one
            x_offset = 1
        end

        local cargoVehicle = cuhFramework.vehicles.spawnAddonVehicle(playlistId, cuhFramework.utilities.matrix.offsetPosition(mission.properties.startPosition, i * x_offset, 1.5, 0))

        if not cargoVehicle then
            return chatAnnounce("Sorry, the addon failed to spawn cargo for your mission. Please report this to the developers in the Discord.", player)
        end

        table.insert(cargoStorage, cargoVehicle)
        cargoVehicle:set_tooltip("Mission:\n"..mission.properties.name.."\n\n"..moneyLibrary.format(mission.properties.reward).."\n"..player.properties.name)

        -- popup (dividing reward by amount because it wouldnt make sense if i didnt)
        storage:add(player.properties.peer_id.."_popup_"..cargoVehicle.properties.vehicle_id, easyPopupsLibrary.physical.create("Your Cargo\n"..moneyLibrary.format(mission.properties.reward / amount), matrix.translation(0, 3, 0), cargoVehicle.properties.vehicle_id, cargoVehicle.properties.vehicle_id + 500, player, 9999999))
    end

    -- save cargo
    storage:add(player.properties.peer_id.."_vehicles", cargoStorage)

    -- completion loop
    storage:add(player.properties.peer_id.."_completion_loop", cuhFramework.utilities.loop.create(1, function(id)
        -- check if mission still exists/is available
        local new_mission =  missionLibrary.main.get(mission.properties.name)

        if not new_mission then
            return
        end

        if not mission.properties.available then
            return
        end

        -- check if cargo arrived at destination, if so, complete the mission for the player
        local has_completed = 0

        ---@param v vehicle
        for i, v in pairs(storage:get(player.properties.peer_id.."_vehicles")) do
            -- get pos
            local cargoVehiclePos = v:get_position()

            if matrix.distance(cargoVehiclePos, mission.properties.completionPosition) < 15 then -- since cargo has made it to destination, increase has_completed var by 1
                has_completed = has_completed + 1
            end
        end

        -- if all cargo has made it, complete the mission
        if has_completed == amount then
            mission:complete(player)
        end
    end))
end

---@param player player
---@param mission mission
function cargoDeliveryFinish(player, mission)
    -- get storage
    local storage = mission.properties.storage

    -- remove completion loop for player
    local loop = storage:get(player.properties.peer_id.."_completion_loop")

    if loop then
        loop:remove()
    end

    storage:remove(player.properties.peer_id.."_completion_loop")

    -- remove all cargo
    ---@param v vehicle
    for i, v in pairs(storage:get(player.properties.peer_id.."_vehicles")) do
        -- despawn it
        v:despawn()

        -- remove popup
        easyPopupsLibrary.physical.remove(v.properties.vehicle_id + 500)
        storage:remove(player.properties.peer_id.."_popup_"..v.properties.vehicle_id)
    end

    -- remove data
    storage:remove(player.properties.peer_id.."_vehicles")
end

-- Types
for i = 1, config.misc.maxCargo do
    missionLibrary.types.create("Cargo Delivery - Tiny ("..i..")",
        ---@param player player
        ---@param mission mission
        function(player, mission)
            cargoDeliveryStart(player, mission, config.playlistIds.CARGO_CONTAINER_TINY, i)
        end,

        cargoDeliveryFinish,
        cargoDeliveryFinish
    )

    missionLibrary.types.create("Cargo Delivery - Small ("..i..")",
        ---@param player player
        ---@param mission mission
        function(player, mission)
            cargoDeliveryStart(player, mission, config.playlistIds.CARGO_CONTAINER_SMALL, i)
        end,

        cargoDeliveryFinish,
        cargoDeliveryFinish
    )

    missionLibrary.types.create("Cargo Delivery - Large ("..i..")",
        ---@param player player
        ---@param mission mission
        function(player, mission)
            cargoDeliveryStart(player, mission, config.playlistIds.CARGO_CONTAINER_LARGE, i)
        end,

        cargoDeliveryFinish,
        cargoDeliveryFinish
    )
end

------------- Passenger Transport
-- Handlers
local globalPassengerId = 0

---@param player player
---@param mission mission
function passengerTransportStart(player, mission, amount)
    -- enforce limit
    amount = cuhFramework.utilities.number.clamp(amount, 1, config.misc.maxPassengers)

    -- get storage
    local storage = mission.properties.storage

    -- passenger stuffs
    local passengerStorage = {}

    for i = 1, amount do
        -- spawn character
        local x_offset = 0.4

        if amount == 1 then
            x_offset = 1
        end

        local passenger = npcLibrary.new(
            npcLibrary.getRandomName().." - #"..globalPassengerId, -- prevent having the same name as another npc
            cuhFramework.utilities.matrix.offsetPosition(mission.properties.startPosition, i * x_offset, 1.5, 0),
            math.random(1, 11)
        )

        -- checks
        local function failureMessage()
            return chatAnnounce("Sorry, the addon failed to spawn a passenger for your mission. Please report this to the developers in the Discord.", player)
        end

        if not passenger then
            return failureMessage()
        end

        if not passenger.properties.character then
            return failureMessage()
        end

        -- save data
        table.insert(passengerStorage, passenger)

        -- popup (dividing reward by amount because it wouldnt make sense if i didnt)
        storage:add(
            player.properties.peer_id.."_popup_"..passenger.properties.character.properties.object_id,
            easyPopupsLibrary.physical.create(
                "Passenger "..i.."\n"..passenger.properties.name.."\n"..moneyLibrary.format(mission.properties.reward / amount),
                matrix.translation(0, 3, 0),
                passenger.properties.character.properties.object_id,
                passenger.properties.character.properties.object_id + 25000,
                player,
                9999999
            )
        ) -- so much shit aaaah

        -- increase passenger global id
        globalPassengerId = globalPassengerId + 1

        -- wait for character to load, then do stuff
        cuhFramework.utilities.delay.create(1, function() -- to prevent popup going to 0, 0, 0 bug n shit
            -- unlock character so the character can be picked up and set tooltip
            passenger.properties.character:set_character_data(100, true, false)
            passenger.properties.character:set_tooltip("Mission:\n"..mission.properties.name.."\n\n"..moneyLibrary.format(mission.properties.reward).."\n"..player.properties.name)
        end)
    end

    -- save passengers
    storage:add(player.properties.peer_id.."_passengers", passengerStorage)

    -- completion loop
    storage:add(player.properties.peer_id.."_completion_loop", cuhFramework.utilities.loop.create(1, function(id)
        -- check if mission still exists/is available
        local new_mission =  missionLibrary.main.get(mission.properties.name)

        if not new_mission then
            return
        end

        if not mission.properties.available then
            return
        end

        -- check if passengers arrived at destination, if so, complete the mission for the player
        local has_completed = 0

        ---@param v npc
        for i, v in pairs(mission.properties.storage:get(player.properties.peer_id.."_passengers")) do
            -- check if dead
            ---@type SWObjectData
            local data = v.properties.character:get_data()

            if data then
                -- dead, so cancel mission and notify player
                if data.dead or data.incapacitated or data.hp == 0 then
                    mission:cancel(player)
                    return announceLibrary.status.warning("One of your passengers died, as a result, the mission has been cancelled.", player)
                end
            end

            -- get pos
            local passenger_pos = v.properties.character:get_position()

            if matrix.distance(passenger_pos, mission.properties.completionPosition) < 15 then -- since passenger has made it to destination, increase has_completed var by 1
                has_completed = has_completed + 1
            end
        end

        -- if all passengers have made it, complete the mission
        if has_completed == amount then
            mission:complete(player)
        end
    end))
end

---@param player player
---@param mission mission
function passengerTransportFinish(player, mission)
    -- get storage
    local storage = mission.properties.storage

    -- remove completion loop for player
    local loop = storage:get(player.properties.peer_id.."_completion_loop")

    if loop then
        loop:remove()
    end

    storage:remove(player.properties.peer_id.."_completion_loop")

    -- remove all passengers
    ---@param v npc
    for i, v in pairs(storage:get(player.properties.peer_id.."_passengers")) do
        -- despawn it
        v:despawn()

        -- remove popup
        easyPopupsLibrary.physical.remove(v.properties.character.properties.object_id + 25000)
        storage:remove(player.properties.peer_id.."_popup_"..v.properties.character.properties.object_id)
    end

    -- remove data
    storage:remove(player.properties.peer_id.."_passengers")
end

-- Types
for i = 1, config.misc.maxPassengers do
    missionLibrary.types.create("Passenger Transport ("..i..")",
        ---@param player player
        ---@param mission mission
        function(player, mission)
            passengerTransportStart(player, mission, i)
        end,

        passengerTransportFinish,
        passengerTransportFinish,
        nil,
        nil,
        nil,
        colorLibrary.RGB.new(125, 220, 50)
    )
end

----------------------------------------------------------------
-- Missions
----------------------------------------------------------------
------------- cuhAirway | Supplies Transport | Tajin
-- Mission
__mission = missionLibrary.main.create(
    "cuhAirway | Supplies Transport | Tajin",
    "Transport 9 packages full of supplies to Tajin.",
    matrix.translation(-6420.7, 13.3, -6359.9),
    matrix.translation(-31159.8, 24.1, 91186.2),
    5,
    missionLibrary.types.get("Cargo Delivery - Small (9)"),
    true,
    1200,
    minMax(51000, 52000),
    15,
    40
)

------------- cuhAirway | Supplies Transport | Airport Island
-- Mission
__mission = missionLibrary.main.create(
    "cuhAirway | Supplies Transport | Airport Island",
    "Transport 4 packages full of supplies to Airport Island.",
    matrix.translation(4052.7, 9.5, -6152.9),
    matrix.translation(-7873.1, 24.3, 9791.7),
    5,
    missionLibrary.types.get("Cargo Delivery - Small (4)"),
    true,
    900,
    minMax(8000, 12000),
    5,
    25
)

------------- cuhAirway | Supplies Transport | Harrison
-- Mission
__mission = missionLibrary.main.create(
    "cuhAirway | Supplies Transport | Harrison",
    "Transport 3 packages full of supplies to Harrison.",
    matrix.translation(4369.2, 9.5, -6371),
    matrix.translation(-6338.3, 13.3, -6430.6),
    5,
    missionLibrary.types.get("Cargo Delivery - Small (3)"),
    true,
    600,
    minMax(5000, 5100),
    3,
    15
)
------------- Nyx Gang | Drug Transport
-- Mission
__mission = missionLibrary.main.create(
    "Nyx Gang | Drug Transport",
    "Transport 2 packages full of drugs to Nyx Gang's hideout.",
    matrix.translation(-7972.1, 24.2, -8998.8),
    matrix.translation(-17237.8, 10.6, -1948.5),
    5,
    missionLibrary.types.get("Cargo Delivery - Tiny (2)"),
    false,
    600,
    minMax(3000, 4000),
    5,
    10
)

------------- The Nova Project
-- Mission
__mission = missionLibrary.main.create(
    "The Nova Project",
    "12 scientists require a transport to a distant island to begin research on an ancient ruin.",
    matrix.translation(-8026.6, 24.3, 10108),
    matrix.translation(28046, 38.4, -60981.7),
    5,
    missionLibrary.types.get("Passenger Transport (12)"),
    true,
    600,
    minMax(17000, 23000),
    5,
    50
)

------------- Medic Transport
-- Mission
__mission = missionLibrary.main.create(
    "Medic Transport",
    "Transport 2 medics to a nearby island.",
    matrix.translation(-41.7, 1.5, -62),
    matrix.translation(145.5, 1.9, -887.2),
    10,
    missionLibrary.types.get("Passenger Transport (2)"),
    false,
    600,
    minMax(300, 500),
    1,
    1
)

------------- Final Wish
-- Mission
__mission = missionLibrary.main.create(
    "Final Wish",
    "Someone only has a week left to live, and would like to go on a road trip with a stranger. This is a one-time mission.",
    matrix.translation(1838.5, 22.5, -9823.8),
    matrix.translation(-7928.1, 9.0, -11568.5),
    50,
    missionLibrary.types.get("Passenger Transport (1)"),
    false,
    600,
    minMax(1000, 1500),
    3,
    25
)

local finalWishMessages = {
    "How's it going?",
    "Thank you for taking me on this trip. Been waiting for a while.",
    "This is awesome!",
    "Yoo!",
    "Nice vehicle!",
    "There is a remotely activated explosive hidden within the walls of your house. Everyone inside will immediately die upon activation of the explosive. You have 24 hours to find it, and deactivate it.",
    "This is fantastic.",
    "You're an awesome person!",
    "You know, I've been on this server a while, and I can confidently say that most of the people I see here 100% have dented brains. You're probably one of them.",
    "Heyo.",
    "This is great."
}

---@param player player
---@param mission mission
__mission.events.onStart:connect(function(player, mission)
    cuhFramework.utilities.loop.create(20, function(id)
        -- player cancelled or completed the mission
        if not missionLibrary.miscellaneous.isPlayerPartakingInMission(player, mission) then
            cuhFramework.utilities.loop.ongoingLoops[id] = nil
            return
        end

        -- get the person
        ---@type table<any, npc>
        local passengers = mission.properties.storage:get(player.properties.peer_id.."_passengers")

        if not passengers then
            return
        end

        -- say random shit
        for i, v in pairs(passengers) do
            v:chat(cuhFramework.utilities.table.getRandomValue(finalWishMessages), player)
        end
    end)
end)

---@param player player
---@param mission mission
__mission.events.onCompletion:connect(function(player, mission)
    -- get the person
    ---@type table<any, npc>
    local passengers = mission.properties.storage:get(player.properties.peer_id.."_passengers")

    if passengers then
        -- final message
        for i, v in pairs(passengers) do
            v:chat("Goodbye, friend.", player)
        end
    end

    -- remove the mission
    mission:remove()
end)

------------- Jeff's Long Lost Boat
-- Mission
__mission = missionLibrary.main.create(
    "Jeff's Long Lost Boat",
    "Jeff lost his boat. Return it to South Harbor for easy cash. This is a one-time mission.",
    matrix.translation(6222.9, -1.0, -11812.6),
    matrix.translation(7234.2, -0.9, -10448.3),
    50,
    missionLibrary.types.get("Boat Towing - Medium"),
    false,
    600,
    minMax(2300, 2500),
    4,
    20
)

---@param player player
---@param mission mission
__mission.events.onCompletion:connect(function(player, mission)
    mission:remove()
end)

------------- Dobb's Mistake
-- Mission
__mission = missionLibrary.main.create(
    "Dobb's Mistake",
    "Dobb overclocked his boat's engine, thinking it would make the boat go faster.\nIn reality, it resulted in engine failure.\nTow his boat to a dock for some quick bucks.",
    matrix.translation(1115.4, -0.4, -7120.1),
    matrix.translation(7169, 2.1, -10371.6),
    50,
    missionLibrary.types.get("Boat Towing - Medium"),
    true,
    600,
    minMax(4500, 5300),
    3,
    15
)

------------- Bobby's Repairs | Wind Turbine
-- Mission
__mission = missionLibrary.main.create(
    "Bobby's Repairs | Wind Turbine",
    "Transport a worker of Bobby's Repairs to a broken Wind Turbine so they can fix it.",
    matrix.translation(3695.2, 14.3, -5417.8),
    matrix.translation(17132.7, 14.2, -3197.7),
    10,
    missionLibrary.types.get("Passenger Transport (1)"),
    true,
    600,
    minMax(3000, 3250),
    2.5,
    10
)

------------- Oober | Olsen Bay to Harrison Airbase
-- Mission
__mission = missionLibrary.main.create(
    "Oober | Olsen Bay to Harrison Airbase",
    "Transport 4 people to Harrison Airbase.",
    matrix.translation(-5658.8, 6.5, -3376),
    matrix.translation(-5945.8, 13.3, -6126.1),
    10,
    missionLibrary.types.get("Passenger Transport (4)"),
    true,
    600,
    minMax(2000, 3000),
    3,
    15
)

------------- Oober | Holt Town to Olsen Bay
-- Mission
__mission = missionLibrary.main.create(
    "Oober | Holt Town to Olsen Bay",
    "Transport 2 people to Olsen Bay.",
    matrix.translation(-196.3, 10.2, -4671.3),
    matrix.translation(-5638.1, 5.9, -3448.4),
    10,
    missionLibrary.types.get("Passenger Transport (2)"),
    true,
    500,
    minMax(1000, 3000),
    2,
    5
)

---@param player player
---@param mission mission
__mission.events.onStart:connect(function(player, mission)
    cuhFramework.utilities.delay.create(1, function()
        local passengers = mission.properties.storage:get(player.properties.peer_id.."_passengers")

        if not passengers then
            return
        end

        ---@param v npc
        for i, v in pairs(passengers) do
            v:chat(cuhFramework.utilities.table.getRandomValue({"Thank you!", "Much appreciated!", "Ugh.. thanks I suppose.", "Hurry it up!", "Awesome, thanks!"}), player)
        end
    end)
end)

------------- eggTourism | 15 Lost Tourists
-- Mission
__mission = missionLibrary.main.create(
    "eggTourism | 15 Lost Tourists",
    "15 tourists were transported to a distant island but were never brought back. Rescue them for a huge cash prize.",
    matrix.translation(-23433.1, 2, -17298),
    matrix.translation(100.1, 14.5, -931.9),
    10,
    missionLibrary.types.get("Passenger Transport (15)"),
    true,
    600,
    minMax(13000, 16000),
    4,
    30
)

------------- eggTourism | Fishing Village
-- Mission
__mission = missionLibrary.main.create(
    "eggTourism | Fishing Village",
    "Transport 13 passengers to Fishing Island for the company 'eggTourism'.",
    matrix.translation(-8595.0, 8.1, -1153.8),
    matrix.translation(1056.4, 4.8, 6905.4),
    10,
    missionLibrary.types.get("Passenger Transport (13)"),
    false,
    500,
    minMax(6000, 7000),
    5,
    23
)

------------- eggTourism | Mount Trapdoor
-- Mission
__mission = missionLibrary.main.create(
    "eggTourism | Mount Trapdoor",
    "Transport 10 passengers to Mount Trapdoor for the company 'eggTourism'.",
    matrix.translation(-9068.1, 14.6, -922.2),
    matrix.translation(-23901.3, 7.5, -17713.5),
    10,
    missionLibrary.types.get("Passenger Transport (10)"),
    true,
    500,
    minMax(5600, 6500),
    4,
    25
)

------------- South Harbor | Passenger Transport
-- Mission
__mission = missionLibrary.main.create(
    "South Harbor | Passenger Transport",
    "Deliver 2 people from South Harbor to a distant 'island'.",
    matrix.translation(7129.9, 7.4, -10413.8),
    matrix.translation(-2995.1, 6.2, -14872.2),
    10,
    missionLibrary.types.get("Passenger Transport (2)"),
    true,
    500,
    minMax(3500, 4500),
    2,
    9
)

------------- Donkk | Passenger Transport
-- Mission
__mission = missionLibrary.main.create(
    "Donkk | Passenger Transport",
    "Deliver 10 people from Terminal Camodo to Terminal Spycakes.",
    matrix.translation(-13010.4, 16.8, -2829.9),
    matrix.translation(-20044.1, 16.8, -4725.1),
    10,
    missionLibrary.types.get("Passenger Transport (10)"),
    false,
    500,
    minMax(3500, 5000),
    2,
    7
)

------------- Evacuation to the Arctic
-- Mission
__mission = missionLibrary.main.create(
    "Evacuation to the Arctic",
    "Evacuate 6 passengers to the Arctic.",
    matrix.translation(4102.3, 9.5, -5938),
    matrix.translation(-31203.2, 24.1, 91232),
    20,
    missionLibrary.types.get("Passenger Transport (6)"),
    true,
    700,
    minMax(20000, 23000),
    4,
    10
)

__mission:createNPC("Lt. Bob Nipple", npcLibrary.npcType.MILITARY)

---@type npc
__missionNPC = __mission:getNPC()
server.setCharacterItem(__missionNPC.properties.character.properties.object_id, 1, 39, false, 30, 30) -- rifle
server.setCharacterItem(__missionNPC.properties.character.properties.object_id, 10, 78, false, 30, 30) -- armor vest

---@param player player
---@param mission mission
__mission.events.onStart:connect(function(player, mission)
    ---@type npc
    local npc = mission:getNPC()

    if npc then
        npc:chat("Gods work brother. Make sure the passengers get to the Arctic safely!", player)
    end
end)

------------- Donkk | Mining Supplies Transport
-- Mission
__mission = missionLibrary.main.create(
    "Donkk | Mining Supplies Transport",
    "Deliver a few mining supplies to the inside of a mine.",
    matrix.translation(-19148.5, 8.3, -4691.8),
    matrix.translation(-19797.9, 14.2, -3712.9),
    10,
    missionLibrary.types.get("Cargo Delivery - Tiny (3)"),
    true,
    350,
    minMax(1500, 2500),
    1,
    6
)

__mission:createNPC("Amazzoon Worker", npcLibrary.npcType.WORKER)

------------- Amazzoon Delivery | Fishing Village
-- Mission
__mission = missionLibrary.main.create(
    "Amazzoon Delivery | Fishing Village",
    "Deliver plenty of packages to a nearby town.",
    matrix.translation(-20074.3, 16.8, -4729.7),
    matrix.translation(-20048.1, 9.4, -3075.2),
    10,
    missionLibrary.types.get("Cargo Delivery - Tiny (5)"),
    true,
    500,
    minMax(7500, 9000),
    2,
    5
)

__mission:createNPC("Amazzoon Worker", npcLibrary.npcType.WORKER)

---@param player player
---@param mission mission
__mission.events.onStart:connect(function(player, mission)
    ---@type npc
    local npc = mission:getNPC()

    if npc then
        npc:chat("Good luck! Make sure to damage the packages as much as possible. :)", player)
    end
end)

------------- Bob's Laptop Delivery
-- Mission
__mission = missionLibrary.main.create(
    "Bob's Laptops Delivery",
    "Bob needs his laptops transported to Holt Town as soon as possible.",
    matrix.translation(1353.3, 7.6, -3694.1),
    matrix.translation(58.6, 9.4, -4771.7),
    10,
    missionLibrary.types.get("Cargo Delivery - Small (3)"),
    false,
    120,
    minMax(1500, 1700),
    1,
    2
)

__mission:createNPC("Bob", npcLibrary.npcType.SCIENCE)

------------- Drake's Broken Car
-- Mission
__mission = missionLibrary.main.create(
    "Drake's Broken Car",
    "Drake's car randomly broke. Bring it to Harrison for a reward.",
    matrix.translation(-2319.9, 15.4, -9009.2),
    matrix.translation(-5923, 13.3, -6070.3),
    10,
    missionLibrary.types.get("Car Towing - Small"),
    true,
    700,
    minMax(3000, 3250),
    1.5,
    3
)

__mission:createNPC("Drake", npcLibrary.npcType.CIVILIAN)

---@param player player
---@param mission mission
__mission.events.onStart:connect(function(player, mission)
    ---@type npc
    local npc = mission:getNPC()

    if npc then
        npc:chat("Thank you! Here's my car, had it up my arse for safekeeping. Anywho, good luck, and I'm gonna stay here because I quite like this area.", player)
    end
end)

------------- Mark's Inconvenience
-- Mission
__mission = missionLibrary.main.create(
    "Mark's Inconvenience",
    "Mark's car broke down. Bring it to Fishing Village for a cash reward.",
    matrix.translation(83, 5.1, -4913.8),
    matrix.translation(6861.7, 8.9, -9822.6),
    10,
    missionLibrary.types.get("Car Towing - Large"),
    true,
    650,
    minMax(4000, 4500),
    2,
    3
)

__mission:createNPC("Mark", npcLibrary.npcType.CIVILIAN)

---@param player player
---@param mission mission
__mission.events.onStart:connect(function(player, mission)
    ---@type npc
    local npc = mission:getNPC()

    if npc then
        npc:chat("Yeh, thanks and all, but can you hurry this whole thing up? I'm offering a lot of money here, so I'm expecting you to be quick. Ugh.", player)
    end
end)

------------- Marcus' Research Transport
-- Mission
__mission = missionLibrary.main.create(
    "Marcus' Research Transport",
    "Marcus needs his testicular cancer research transported to Olsen Bay.",
    matrix.translation(7059.5, 7.3, -9729),
    matrix.translation(-5649.1, 6.5, -3361),
    10,
    missionLibrary.types.get("Cargo Delivery - Small (2)"),
    false,
    500,
    minMax(6000, 7500),
    2,
    5
)

__mission:createNPC("Marcus", npcLibrary.npcType.SCIENCE)

------------- Rob's Fish Transport
-- Mission
__mission = missionLibrary.main.create(
    "Rob's Fish Transport",
    "Rob needs his fish transported to North Harbor.",
    matrix.translation(-113.9, 3, -906.5),
    matrix.translation(1349.0, 4.4, -3582.8),
    6,
    missionLibrary.types.get("Cargo Delivery - Small (1)"),
    false,
    300,
    minMax(600, 980),
    1,
    1
)

__mission:createNPC("Rob", npcLibrary.npcType.FISHING)

------------- Dean Hall | Supplies Transport
-- Mission
__mission = missionLibrary.main.create(
    "Dean Hall | Supplies Transport",
    "The Dean Hall company needs their supplies transported to Wind Farm.",
    matrix.translation(-890.4, 32.8, -6129),
    matrix.translation(2580.8, 43.6, -7640.6),
    6,
    missionLibrary.types.get("Cargo Delivery - Small (1)"),
    false,
    100,
    minMax(2100, 2500),
    1.5,
    3
)

__mission:createNPC("Max", npcLibrary.npcType.WORKER)

------------- cuhRailway | Supplies Transport
-- Mission
__mission = missionLibrary.main.create(
    "cuhRailway | Supplies Transport",
    "The cuhRailway company needs their supplies transported to ONeill Airbase.",
    matrix.translation(6999.9, 13.9, -9124.7),
    matrix.translation(3949.9, 12.5, -6048.0),
    15,
    missionLibrary.types.get("Cargo Delivery - Large (1)"),
    true,
    250,
    minMax(7000, 8500),
    2,
    5
)

__mission:createNPC("Jack", npcLibrary.npcType.WORKER)

------------- Arctic | Wind Turbine Supplies Transport
-- Mission
__mission = missionLibrary.main.create(
    "Arctic | Wind Turbine Supplies Transport",
    "A Wind Turbine requires emergency supplies from a location in the Arctic as soon as possible. It is recommended to use a helicopter/VTOL.",
    matrix.translation(-27035.4, 7.5, 84010.7),
    matrix.translation(15015.3, 21.1, -13999.8),
    5,
    missionLibrary.types.get("Cargo Delivery - Small (1)"),
    true,
    750,
    minMax(15000, 17000),
    8,
    45
)

__mission:createNPC("Jeffrey", npcLibrary.npcType.WORKER)

------------- Volcano Surveillance 
-- Mission
__mission = missionLibrary.main.create(
    "Volcano Surveillance",
    "A research company requires their surveillance equipment to be transported onto Mount Goldblum, a volcano.",
    matrix.translation(4060.6, 20.1, -15994.97),
    matrix.translation(132.1, 445.0, -7656.1),
    8,
    missionLibrary.types.get("Cargo Delivery - Small (1)"),
    false,
    2000,
    minMax(5000, 6000),
    3,
    5
)

__mission:createNPC("Bobberson", npcLibrary.npcType.SCIENCE)

------------- Cave Surveillance 
-- Mission
__mission = missionLibrary.main.create(
    "Cave Surveillance",
    "A research company requires their surveillance equipment to be transported into Lorgs Cave.",
    matrix.translation(-16012.9, 7.7, -15978.9),
    matrix.translation(-19812.4, -0.3, -18319.6),
    8,
    missionLibrary.types.get("Cargo Delivery - Small (2)"),
    true,
    1750,
    minMax(3000, 4000),
    2,
    4
)

__mission:createNPC("Roberson", npcLibrary.npcType.SCIENCE)

------------- Arctic | Deliver Town Supplies
-- Mission
__mission = missionLibrary.main.create(
    "Arctic | Deliver Town Supplies",
    "A town is running low on food supplies. Deliver some food supplies for easy money.",
    matrix.translation(-29368.7, 33, 89742.7),
    matrix.translation(-28252.1, 7.4, 89844.6),
    5,
    missionLibrary.types.get("Cargo Delivery - Small (1)"),
    true,
    300,
    minMax(3000, 4500),
    4,
    15
)

__mission:createNPC("Ronald", npcLibrary.npcType.MILITARY)

------------- Krailworks | Deliver Oil
-- Mission
__mission = missionLibrary.main.create(
    "Krail Oilworks | Deliver Oil",
    "Krail Oilworks needs their oil delivered to ArcTech Survey Base.",
    matrix.translation(-28890.3, 6.7, 90941.5),
    matrix.translation(-34077.3, 27.1, 92994.6),
    10,
    missionLibrary.types.get("Cargo Delivery - Tiny (2)"),
    false,
    200,
    minMax(5000, 7000),
    2,
    10
)

__mission:createNPC("George", npcLibrary.npcType.SCIENCE)

------------- Arctic | Deliver Spare Electronics
-- Mission
__mission = missionLibrary.main.create(
    "Arctic | Deliver Spare Electronics",
    "Terminal Trinite has too many resources, they need some delivered to Terminal Endo.",
    matrix.translation(-28614.3, 16.7, 90662.5),
    matrix.translation(-29024.2, 16.2, 89622.4),
    3,
    missionLibrary.types.get("Cargo Delivery - Small (1)"),
    true,
    300,
    minMax(5000, 7100),
    2,
    7
)

__mission:createNPC("Jeff", npcLibrary.npcType.WORKER)

------------- cuhAirway | Luggage Recovery
-- Mission
__mission = missionLibrary.main.create(
    "cuhAirway | Luggage Recovery",
    "A cuhAirway plane had an incident in the air and dropped a bunch of luggage at the outskirts of Sawyer. Recover the luggage and bring it to Harrison.",
    matrix.translation(7918.5, 18.9, -4641.1),
    matrix.translation(-5880.9, 13.3, -6064.6),
    50,
    missionLibrary.types.get("Cargo Delivery - Tiny (5)"),
    true,
    2000,
    minMax(10000, 12000),
    7,
    20
)