-----------------
-- [Library] config.lua
-----------------
---------------------------------------
------------- Configuration
---------------------------------------

config = {
    isDedicatedServer = true,
    debugEnabled = true,
    debugShouldLog = true,
    serverLinkPort = 2000,
	serverLinkCodename = "missions",

    databasePort = 8000,
    databaseCodename = "missions",
    databaseKey = "2lGoSjxGhjs",

    info = {
        server_name = "Missions",
        discord = "discord.gg/zTQxaZjwDr",
        help_message = "Advance your vehicles and progress through the server by earning money from completing missions.\nTo start a mission, head to a mission on the map and type '?start'."
    },

    game = {
        startingMoney = 20000,
        spawn = matrix.translation(-28.2, 5.2, 16.2),
        billboardPosition = matrix.translation(-27.6, 3.6, 18.4),
        billboardRotation = 3.15,

        levelToGivePerMissionCompletion = 1,
        maxLevel = 500,

        moneyLossOnDeathPercentage = 1,

        disasters = {
            spawnTimer = 310
        },
    },

    playlistIds = {
        CARGO_CONTAINER_LARGE = 1,
        CARGO_CONTAINER_SMALL = 2,
        CARGO_CONTAINER_TINY = 6,
        BILLBOARD = 3,
        RESUPPLY_STATION = 4,
        LAND_VEHICLE_ONE = 5,
        LAND_VEHICLE_TWO = 8,
        SEA_VEHICLE_ONE = 9,
        BEACON_ACTIVATION = 7
    },

    vehicles = {
        antiLag = {
            maxVoxels = 80000,
            maxTpsImpact = 10,
            maxLoadTime = 10,
            maxTpsImpactMeasureTime = 20
        },

        refund_percentage = 100, --TODO: change back to 95% after crashes are fixed next update/hot fix idk
        limit = 2,
    },

    misc = {
        maxCargo = 10,
        maxPassengers = 20
    }
}

-----------------
-- [Library] intellisense.lua
-----------------
-------------------------------------------------
-------------------------- NPC
-------------------------------------------------
------------- NPC
---@class npc
---@field properties npcProperties
---@field chat function<self, string, player|nil>
---@field spawn function<self, SWMatrix|nil>
---@field despawn function<self>

------------- NPC Properties
---@class npcProperties
---@field name string
---@field position SWMatrix
---@field npcType integer
---@field character character
---
---@field chatDelay table|nil
---@field storage storage

-------------------------------------------------
-------------------------- Mission
-------------------------------------------------
------------- Mission
---@class mission
---@field properties missionProperties
---@field events missionEvents
---
---@field start function<self, player>
---@field cancel function<self, player|nil>
---@field complete function<self, player>
---@field remove function<self>
---
---@field setAvailability function<self, boolean>
---@field refreshUI function<self>
---@field refreshMapUI function<self, player, boolean>
---
---@field createNPC function<self, string, integer>
---@field getNPC function<self>
---
---@field attach function<self, integer|nil, vehicle|nil>
---@field detach function<self>

------------- Mission Properties
---@class missionProperties
---@field name string
---@field description string
---
---@field startPosition SWMatrix
---@field activationRadius number
---@field completionPosition SWMatrix
---
---@field type missionType
---@field storage storage
---@field cancelsOnCompletion boolean
---@field timeUntilAvailableAgain number
---@field reward number
---@field mission_id integer
---@field available boolean
---@field levelToGiveOnCompletion number
---@field minimumLevel number
---
---@field attach integer obj_id/veh_id for dest map ui to attach to
---@field isAttachedVehicle boolean  true == vehicle
---
---@field destinationMarker object
---
---@field popup physicalPopup
---
---@field partakingPlayers table<integer, player>
---
---@field internal missionInternal

------------- Mission Internal
---@class missionInternal
---@field refreshLoop any

------------- Mission Events
---@class missionEvents
---@field onStart event
---@field onCompletion event
---@field onCancellation event
---@field availabilityChanged event
---@field onCreation event
---@field onRemoval event

------------- Mission Type
---@class missionType
---@field onStart function
---@field onCompletion function
---@field onCancellation function
---@field availabilityChanged function
---@field onCreation function
---@field onRemoval function
---
---@field name string
---@field color colorRGB|colorHSV

-------------------------------------------------
-------------------------- Easy Popups
-------------------------------------------------
------------- Physical Popup
---@class physicalPopup
---@field properties physicalPopupProperties
---@field setVisibility function<self, boolean>
---@field refresh function<self>
---@field edit function<self, string|nil, SWMatrix|nil, number|nil, player|nil, number|nil>
---@field remove function<self>

------------- Physical Popup Properties
---@class physicalPopupProperties
---@field text string
---@field pos SWMatrix
---@field id number
---@field player player|nil
---@field shownForAll boolean
---@field renderDistance number
---@field visible boolean
---
---@field obj_id number
---@field veh_id number

-------------------------------------------------
-------------------------- Disasters
-------------------------------------------------
------------- Disaster
---@class disaster
---@field name string
---@field startCallback function
---@field stopCallback function
---@field delay number

-------------------------------------------------
-------------------------- Miscellaneous
-------------------------------------------------
------------- Color
---@class colorRGB
---@field r number
---@field g number
---@field b number
---@field a number

---@class colorHSV
---@field h number
---@field s number
---@field v number
---@field a number

------------- Inventory
---@class inventory
---@field properties inventoryProperties
---@field give function<self, player>
---@field remove function<self>
---@field itemsToNamesInTable function<self>

---@class inventoryProperties
---@field items table<integer, item>
---@field name string

---@class item
---@field name string
---@field equipment_id SWEquipmentTypeEnum
---@field int integer
---@field float number
---@field slot SWSlotNumberEnum

------------- Event
---@class event
---@field name string
---@field connections table<any, function>
---
---@field connect function<self, function>
---@field fire function<self, any>
---@field remove function<self>

------------- Storage
---@class storage
---@field name string
---@field storage table<any, any>
---
---@field add function<self, any, any>
---@field remove function<self, any>
---@field get function<self, any>

------------- MinMax
---@class minMax
---@field min number
---@field max number

------------- Resupply Station
---@class resupplyStation
---@field properties resupplyStationProperties
---@field replenish function<self>
---@field remove function<self>
---@field refreshMapUI function<self, player|nil, boolean|nil, boolean|nil>

---@class resupplyStationProperties
---@field position SWMatrix
---@field name string
---@field vehicle vehicle

------------- Reminder
---@class reminder
---@field properties reminderProperties
---@field remove function<self>
---@field announce function<self>

---@class reminderProperties
---@field id any
---@field category reminderCategory
---@field description string

------------- Reminder Category
---@class reminderCategory
---@field properties reminderCategoryProperties
---@field newReminder function<self, any, description>

---@class reminderCategoryProperties
---@field name string

-----------------
-- [Library] settings.lua
-----------------
-------------------------------------------------
-------------------------- Settings
-------------------------------------------------

------------- Main
local settings = {
    ["infinite_money"] = false,
    ["infinite_resources"] = false
}

for i, v in pairs(settings) do
    server.setGameSetting(i, v)
end

------------- Tile Inventory
local tile_scan = 50
for x = -tile_scan, tile_scan do
    local tile_x = x * 1000 -- tile is 1km x 1km

    for y = -tile_scan, tile_scan do
        local tile_y = y * 1000
        server.setTileInventory(matrix.translation(tile_x, 0, tile_y), 10000000, 10000000, 10000000, 10000000)
    end
end

-----------------
-- [Library | Folder: p0_cuhFramework] cuhFramework.lua
-----------------
------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--[[
	------
	Information
	------
	This is the cuhFramework.lua file, which contains the entirety of cuhFramework.
	It is HIGHLY recommended that you code your addon in a different .lua file (script.lua or another file),
	then when you are ready, run 'cuhFramework - Build Project.exe' to combine your code with this framework,
	ready to use in-game.

	It is highly recommended that you use the popular Lua LSP extension on VSCode,
	and it is also highly recommended that you use NameousChangey's Stormworks Lua with LifeboatAPI
	VSCode Extension.

	If you're not already, make sure to code your addon with something like VSCode, and do not use the in-game
	editor because, chances are, your code and this framework will not fit within the in-game addon character limit.
	The limit can be bypassed if you code outside of in-game (using something like VSCode as said), which is why
	you shouldn't code your addon in-game.

	------
	Documentation:
	------
	To see the documentation, head over to the wiki page at https://github.com/Roozz1/cuhFramework.
]]

----------------------------------------
----------------------------------------
--//Framework\\--
----------------------------------------
----------------------------------------
cuhFramework = {
	players = {},
	vehicles = {},
	objects = {},
	creatures = {},
	characters = {},
	savedata = {},
	tps = {},
	customZones = {},
	ui = {},
	disasters = {},
	animation = {},
	http = {},

	utilities = {},
	callbacks = {},
	customCallbacks = {},
	references = {},

	chat = {},
	commands = {},

	backend = {
		updates = {
			---Insert update function. Don't use this
			---@param func function Function that should be called every tick
			insert = function(self, func)
				table.insert(self, func)
			end,

			---Create an exception. The exception will not be called by onTick. Don't use this
			---@param exception function The function to exclude
			create_exception = function(self, exception)
				table.insert(self.exceptions, exception)
			end,

			exceptions = {}
		}
	}
}

----------------------------------------
----------------------------------------
--//Backend - Updates [DO NOT USE]\\--
----------------------------------------
----------------------------------------
cuhFramework.backend.updates:create_exception(cuhFramework.backend.updates.create_exception)
cuhFramework.backend.updates:create_exception(cuhFramework.backend.updates.insert)

----------------------------------------
----------------------------------------
--//Framework - Callbacks\\--
----------------------------------------
----------------------------------------
cuhFramework.callbacks.onTick = {
	connections = {},
	---Connect a callback to onTick
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onTick(...)
	-- Backend - Update
	for i, v in pairs(cuhFramework.backend.updates) do
		if cuhFramework.utilities.table.isValueInTable(cuhFramework.backend.updates.exceptions, v) then -- yeah this isn't so good for performance but oh well
			goto continue
		end

		if type(v) ~= "function" then
			goto continue
		end

		v(...)

		::continue::
	end

	for i, v in pairs(cuhFramework.callbacks.onTick.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCreate = {
	connections = {},
	---Connect a callback to onCreate
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCreate(...)
	for i, v in pairs(cuhFramework.callbacks.onCreate.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onDestroy = {
	connections = {},
	---Connect a callback to onDestroy
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onDestroy(...)
	for i, v in pairs(cuhFramework.callbacks.onDestroy.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCustomCommand = {
	connections = {},
	---Connect a callback to onCustomCommand
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCustomCommand(...)
	for i, v in pairs(cuhFramework.callbacks.onCustomCommand.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onChatMessage = {
	connections = {},
	---Connect a callback to onChatMessage
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onChatMessage(...)
	for i, v in pairs(cuhFramework.callbacks.onChatMessage.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerJoin = {
	connections = {},
	---Connect a callback to onPlayerJoin
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerJoin(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerJoin.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerSit = {
	connections = {},
	---Connect a callback to onPlayerSit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerSit(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerSit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerUnsit = {
	connections = {},
	---Connect a callback to onPlayerUnsit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerUnsit(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerUnsit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterSit = {
	connections = {},
	---Connect a callback to onCharacterSit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterSit(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterSit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterUnsit = {
	connections = {},
	---Connect a callback to onCharacterUnsit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterUnsit(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterUnsit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterPickup = {
	connections = {},
	---Connect a callback to onCharacterPickup
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterPickup(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterPickup.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onEquipmentPickup = {
	connections = {},
	---Connect a callback to onEquipmentPickup
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onEquipmentPickup(...)
	for i, v in pairs(cuhFramework.callbacks.onEquipmentPickup.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onEquipmentDrop = {
	connections = {},
	---Connect a callback to onEquipmentDrop
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onEquipmentDrop(...)
	for i, v in pairs(cuhFramework.callbacks.onEquipmentDrop.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterPickup = {
	connections = {},
	---Connect a callback to onCharacterPickup
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterPickup(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterPickup.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerRespawn = {
	connections = {},
	---Connect a callback to onPlayerRespawn
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerRespawn(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerRespawn.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerLeave = {
	connections = {},
	---Connect a callback to onPlayerLeave
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerLeave(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerLeave.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onToggleMap = {
	connections = {},
	---Connect a callback to onToggleMap
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onToggleMap(...)
	for i, v in pairs(cuhFramework.callbacks.onToggleMap.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerDie = {
	connections = {},
	---Connect a callback to onPlayerDie
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerDie(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerDie.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleSpawn = {
	connections = {},
	---Connect a callback to onVehicleSpawn
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleSpawn(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleSpawn.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleDespawn = {
	connections = {},
	---Connect a callback to onVehicleDespawn
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleDespawn(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleDespawn.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleLoad = {
	connections = {},
	---Connect a callback to onVehicleLoad
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleLoad(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleLoad.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleUnload = {
	connections = {},
	---Connect a callback to onVehicleUnload
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleUnload(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleUnload.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleTeleport = {
	connections = {},
	---Connect a callback to onVehicleTeleport
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleTeleport(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleTeleport.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onObjectLoad = {
	connections = {},
	---Connect a callback to onObjectLoad
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onObjectLoad(...)
	for i, v in pairs(cuhFramework.callbacks.onObjectLoad.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onObjectUnload = {
	connections = {},
	---Connect a callback to onObjectUnload
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onObjectUnload(...)
	for i, v in pairs(cuhFramework.callbacks.onObjectUnload.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onButtonPress = {
	connections = {},
	---Connect a callback to onButtonPress
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onButtonPress(...)
	for i, v in pairs(cuhFramework.callbacks.onButtonPress.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onSpawnAddonComponent = {
	connections = {},
	---Connect a callback to onSpawnAddonComponent
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onSpawnAddonComponent(...)
	for i, v in pairs(cuhFramework.callbacks.onSpawnAddonComponent.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleDamaged = {
	connections = {},
	---Connect a callback to onVehicleDamaged
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleDamaged(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleDamaged.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.httpReply = {
	connections = {},
	---Connect a callback to httpReply
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function httpReply(...)
	for i, v in pairs(cuhFramework.callbacks.httpReply.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onFireExtinguished = {
	connections = {},
	---Connect a callback to onFireExtinguished
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onFireExtinguished(...)
	for i, v in pairs(cuhFramework.callbacks.onFireExtinguished.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onForestFireSpawned = {
	connections = {},
	---Connect a callback to onForestFireSpawned
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onForestFireSpawned(...)
	for i, v in pairs(cuhFramework.callbacks.onForestFireSpawned.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onForestFireExtinguised = {
	connections = {},
	---Connect a callback to onForestFireExtinguised
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onForestFireExtinguised(...)
	for i, v in pairs(cuhFramework.callbacks.onForestFireExtinguised.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onTornado = {
	connections = {},
	---Connect a callback to onTornado
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onTornado(...)
	for i, v in pairs(cuhFramework.callbacks.onTornado.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onMeteor = {
	connections = {},
	---Connect a callback to onMeteor
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onMeteor(...)
	for i, v in pairs(cuhFramework.callbacks.onMeteor.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onTsunami = {
	connections = {},
	---Connect a callback to onTsunami
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onTsunami(...)
	for i, v in pairs(cuhFramework.callbacks.onTsunami.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onWhirlpool = {
	connections = {},
	---Connect a callback to onWhirlpool
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onWhirlpool(...)
	for i, v in pairs(cuhFramework.callbacks.onWhirlpool.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVolcano = {
	connections = {},
	---Connect a callback to onVolcano
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVolcano(...)
	for i, v in pairs(cuhFramework.callbacks.onVolcano.connections) do
		v(...)
	end
end

----------------------------------------
----------------------------------------
--//Framework - Custom Callbacks\\--
----------------------------------------
----------------------------------------
cuhFramework.customCallbacks.onCommandActivated = {
	connections = {},
	---Connect a function to onCommandActivated (custom)
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

----------------

cuhFramework.customCallbacks.onVehicleSpawn = {
	connections = {},
	---Connect a function to onVehicleSpawn (custom)
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

----------------

cuhFramework.customCallbacks.onVehicleLoad = {
	connections = {},
	---Connect a function to onVehicleLoad (custom)
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

----------------

cuhFramework.customCallbacks.onVehicleDespawn = {
	connections = {},
	---Connect a function to onVehicleDespawn (custom)
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

----------------------------------------
----------------------------------------
--//Framework - Utilities\\--
----------------------------------------
----------------------------------------

------------------------
------String
------------------------
cuhFramework.utilities.string = {}

---Converts a string into a table, same as Python's split() function, from: https://stackoverflow.com/questions/1426954/split-string-in-lua
---@param str string String to split
---@param sep string|nil Pattern to split the string by
---@return table split_string The split string in a table
cuhFramework.utilities.string.split = function(str, sep)
	if sep == nil then
		sep = "%s"
	end

	local split_string = {}

	for strn in string.gmatch(str, "([^"..sep.."]+)") do
		cuhFramework.utilities.table.insert(split_string, strn)
	end

	return split_string
end

---Converts anything into a string, alias to tostring()
---@param input any|nil The input to convert to a string
---@return string string The tostring()'d version of input
cuhFramework.utilities.string.tostring = function(input)
	return tostring(input)
end

---Converts a string to a bool. "true"/"True"/"TrUe" becomes true. "false"/"False"/"FalSe" becomes false. Anything else becomes nil
---@param str string The string to convert to a bool
---@return boolean|nil bool True or false depending on the string. Nil if the string doesn't match true or false
cuhFramework.utilities.string.tobool = function(str)
	if input:lower() == "true" then
		return true
	elseif input:lower() == "false" then
		return false
	end
end

---Replaces occurences in a string with something else, alias to string.gsub()
---@param input string Input string
---@param pattern string The pattern to find
---@param replacement string What to replace all occurences of the specified pattern with
---@return string string The new string
---@return integer occurences The amount of occurences of the pattern in the input string
cuhFramework.utilities.string.replace = function(input, pattern, replacement)
	return input:gsub(pattern, replacement)
end

------------------------
------Table
------------------------
cuhFramework.utilities.table = {}

---Whether or not a value exists in a table
---@param tbl table Table to look in
---@param value any What value to look for in the table
---@return boolean found Whether or not the value was found
cuhFramework.utilities.table.isValueInTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			return true
		end
	end

	return false
end

---Get the amount of values in a table
---@param tbl table Table to check
---@return integer value_count The amount of values in this table
cuhFramework.utilities.table.getValueCountOfTable = function(tbl)
	local count = 0

	for _ in pairs(tbl) do
		count = count + 1
	end

	return count
end

---Remove a value from a table
---@param tbl table Table to look in
---@param value any What value to remove from the table
---@return boolean removed Whether or not the value was found and removed
cuhFramework.utilities.table.removeValueFromTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			table.remove(tbl, i)
			return true
		end
	end

	return false
end

---Get a value from a table
---@param tbl table Table to look in
---@param value any What value to look for in the table
---@return any|nil value The value, or nil if not found
cuhFramework.utilities.table.getValueInTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			return v
		end
	end
end

---Whether or not an index exists in a table
---@param tbl table Table to look in
---@param index any What index to look for in the table
---@return boolean found Whether or not the index was found
cuhFramework.utilities.table.indexInTable = function(tbl, index)
	return tbl[index] ~= nil
end

---Insert a value into a table, alias to table.insert
---@param tbl table Table to insert the value in
---@param value any Value to insert
cuhFramework.utilities.table.insert = function(tbl, value)
	table.insert(tbl, value)
end

---Get a random value in a table
---@param tbl table Table to get a random value from
---@return any randomTableValue The random table value, or nil if there are no values in the table
cuhFramework.utilities.table.getRandomValue = function(tbl)
	local count = #tbl

	if count < 1 then
		return
	end

	return tbl[math.random(1, count)]
end

---Swap the values of a table with the index of the value
---@param tbl table Table to apply the result of this function to
---@return table newTable The new table with all values as the index, and all indexes as the values
cuhFramework.utilities.table.swapValuesAndIndexes = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		new[v] = i
	end

	return new
end

---Convert all table values to a string
---@param tbl table Table of values to convert
---@return table newTable The new table with all values as a string
cuhFramework.utilities.table.tostringValues = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		new[i] = cuhFramework.utilities.string.tostring(v)
	end

	return new
end

---Convert all table string values to a lowercase version
---@param tbl table Table of values to convert
---@return table newTable The new table with all string values as lowercase
cuhFramework.utilities.table.lowercaseStringValues = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		if type(v) == "string" then
			new[i] = v:lower()
		end
	end

	return new
end

---Convert all table string values to a uppercase version
---@param tbl table Table of values to convert
---@return table newTable The new table with all string values as uppercase
cuhFramework.utilities.table.uppercaseStringValues = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		if type(v) == "string" then
			new[i] = v:upper()
		end
	end

	return new
end

---Get the sum of all number values in a table
---@param tbl table Table of values to sum up
---@return number result The added values
cuhFramework.utilities.table.sumOfTable = function(tbl)
	local current = 0

	for i, v in pairs(tbl) do
		if type(v) == "number" then
			current = current + v
		end
	end

	return current
end

---Get the value count in a table (recommended to do #tbl instead of using this)
---@param tbl table Table to check
---@return integer valueCount The amount of values in this table
cuhFramework.utilities.table.valueCount = function(tbl)
	local count = 0

	for i, v in pairs(tbl) do
		count = count + 1
	end

	return count
end

------------------------
------Number
------------------------
cuhFramework.utilities.number = {}

---Converts any number into an integer
---@param num number The number to convert into an integer
---@return integer integer The new integer
cuhFramework.utilities.number.tointeger = function(num)
	return math.floor(num)
end

---Converts a string/bool into a number
---@param input string|bool|number The number to convert into a float
---@return number number The new number, or 0 if failure
cuhFramework.utilities.number.tonumber = function(input)
	if type(input) == "bool" then
		if input then
			return 1
		else
			return 0
		end
	end

	return tonumber(input) or 0
end

---Round a number 
---@param input number The number to round 
---@param numDecimalPlaces integer Amount of decimal places to round to 
---@return number roundedNumber The rounded number, or 0 if rounding error 
 cuhFramework.utilities.number.round = function(input, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(input * mult + 0.5) / mult
end

---Clamps a number between two numbers
---@param number number The number to clamp
---@param minimum number The minimum value the number can be
---@param maximum number The maximum value the number can be
---@return number number The clamped number
cuhFramework.utilities.number.clamp = function(number, minimum, maximum)
	if number < minimum then
		number = minimum
	elseif number > maximum then
		number = maximum
	end

	return number
end

------------------------
------Matrix
------------------------
cuhFramework.utilities.matrix = {}

---Offset position
---@param position SWMatrix The position to offset
---@param x number|nil X offset
---@param y number|nil Y offset
---@param z number|nil Z offset
---@return SWMatrix newPosition The offset position
cuhFramework.utilities.matrix.offsetPosition = function(position, x, y, z)
	return cuhFramework.references.matrix.translation(position[13] + (x or 0), position[14] +(y or 0), position[15] + (z or 0))
end

---Scatter position, think utilities.matrix.offsetPosition but by a random amount
---@param position SWMatrix The position to scatter
---@param amount integer The amount to scatter the position by (if amount is 2, it becomes math.random(-2, 2) in this function)
---@param shouldApplyToY boolean|nil Whether or not to scatter the Y position too (default is false)
---@return SWMatrix newPosition The new position
cuhFramework.utilities.matrix.scatterPosition = function(position, amount, shouldApplyToY)
	if not shouldApplyToY then
		return cuhFramework.utilities.matrix.offsetPosition(position, math.random(-amount, amount), 0, math.random(-amount, amount))
	else
		return cuhFramework.utilities.matrix.offsetPosition(position, math.random(-amount, amount), math.random(-amount, amount), math.random(-amount, amount))
	end
end

------------------------
------Miscellaneous
------------------------
cuhFramework.utilities.miscellaneous = {}

---Switch between two values depending on the state of something
---@param off any The return value if switch is false/nil
---@param on any The return value if switch is anything apart from false and nil
---@param switch boolean|any Switch between the off and on value
---@return any
cuhFramework.utilities.miscellaneous.switchbox = function(off, on, switch)
	if switch then
		return on
	else
		return off
	end
end

---Get the closest player to a position
---@param position SWMatrix The position to check
---@param exceptions table<any, player>|nil A table containing players to ignore
---@return player|nil
cuhFramework.utilities.miscellaneous.getClosestPlayerToPosition = function(position, exceptions)
	local recentPlayer = nil
	local recentDistance = -1

	local list = {}

	if exceptions then
		for i, v in pairs(exceptions) do
			list[v.properties.peer_id] = true
		end
	end

	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if list[v.properties.peer_id] then
			goto continue
		end

		local player_position = v:get_position()
		local distance = cuhFramework.references.matrix.distance(player_position, position)

		if distance < recentDistance or recentDistance == -1 then
			recentDistance = distance
			recentPlayer = v
		end

	    ::continue::
	end

	return recentPlayer
end

------------------------
------Delays
------------------------
local delay_id = 0
cuhFramework.utilities.delay = {}
cuhFramework.utilities.delay.ongoingDelays = {}

---Update delays, don't use this
cuhFramework.utilities.delay.update = function()
	for i, v in pairs(cuhFramework.utilities.delay.ongoingDelays) do
		local timeNow = server.getTimeMillisec()
		if timeNow >= v.creationTime + (v.time * 1000) and not v.paused then
			v.callback(v.id, table.unpack(v.args))
			cuhFramework.utilities.delay.remove(v.id)
		end
	end
end

cuhFramework.backend.updates:insert(cuhFramework.utilities.delay.update) -- reference

---Call a function after x seconds
---@param duration number How long until the callback is called in seconds
---@param callback function The function to call after the delay is manually called or when the delay naturally completes itself
---@param ... any Arguments to pass through to the delay callback
cuhFramework.utilities.delay.create = function(duration, callback, ...)
    local id = delay_id
	delay_id = delay_id + 1

	cuhFramework.utilities.delay.ongoingDelays[id] = {
		callback = callback,
		args = {...},
		time = duration,
		creationTime = server.getTimeMillisec(),
		id = id,
		paused = false,
	}

	return {
		properties = cuhFramework.utilities.delay.ongoingDelays[id],

		---Set the duration of the delay
		---@param newDuration number What to set the delay duration to in seconds 
		setDuration = function(self, newDuration)
			self.properties.time = newDuration
		end,

		---Manually call the callback assigned to the delay
		call = function(self)
			self.properties.callback()
		end,

		---Remove/Cancel the delay
		remove = function(self)
			cuhFramework.utilities.delay.ongoingDelays[id] = nil
		end,

		---Pause/Unpause the delay. The delay timer will still go up if paused, but the function will not be called upon completion
		---@param state boolean True = pause delay, false = unpause delay
		setPaused = function(self, state)
			self.properties.paused = state
		end,
	}
end

---Remove a delay by its ID
---@param id number The ID of the delay
cuhFramework.utilities.delay.remove = function(id)
	cuhFramework.utilities.delay.ongoingDelays[id] = nil
end

------------------------
------Loops
------------------------
local loop_id = 0
cuhFramework.utilities.loop = {}
cuhFramework.utilities.loop.ongoingLoops = {}

---Update loops, don't use this
cuhFramework.utilities.loop.update = function()
	for i, v in pairs(cuhFramework.utilities.loop.ongoingLoops) do
		local timeNow = server.getTimeMillisec()
		if timeNow >= v.creationTime + (v.time * 1000) and not v.paused then
			v.callback(v.id, table.unpack(v.args))
			v.creationTime = timeNow
		end
	end
end

cuhFramework.backend.updates:insert(cuhFramework.utilities.loop.update) -- reference

---Call a function every x seconds
---@param duration number How long until the callback is called in seconds
---@param callback function The function to call after the loop is manually called or when a loop iteration has completed
---@param ... any Arguments to pass through to the loop callback
cuhFramework.utilities.loop.create = function(duration, callback, ...)
    local id = loop_id
	loop_id = loop_id + 1

	cuhFramework.utilities.loop.ongoingLoops[id] = {
		callback = callback,
		args = {...},
		time = duration,
		creationTime = server.getTimeMillisec(),
		id = id,
		paused = false,
	}

	return {
		properties = cuhFramework.utilities.loop.ongoingLoops[id],

		---Set the duration of the loop
		---@param newDuration number What to set the loop duration to in seconds 
		setDuration = function(self, newDuration)
			self.properties.time = newDuration
		end,

		---Manually call the callback assigned to the loop
		call = function(self)
			self.properties.callback()
		end,

		---Remove/Cancel the loop
		remove = function(self)
			cuhFramework.utilities.loop.ongoingLoops[id] = nil
		end,

		---Pause/Unpause the loop. The loop timer will still go up if paused, but the function will not be called upon an iteration completion
		---@param state boolean True = pause loop, false = unpause loop
		setPaused = function(self, state)
			self.properties.paused = state
		end,
	}
end

---Remove a loop by its ID
---@param id number The ID of the loop
cuhFramework.utilities.loop.remove = function(id)
	cuhFramework.utilities.loop.ongoingLoops[id] = nil
end

------------------------
------Animation
------------------------

------------------------
------Intellisense
------------------------
---@class animation
---@field properties animation_properties
---@field remove function<animation> Remove this animation
---@field setPaused function<animation, boolean> Pause/Unpause this animation
---@field setLooped function<animation, boolean> Make this animation loop/not loop
---@field isFinished function<animation> Returns whether or not the animation is finished. Same as doing animation.properties.finished
---@field edit function<animation, SWMatrix|nil, SWMatrix|nil, SWMatrix|nil, number|nil> Edit this animation. Order: new_start_position, new_destination_position, new_current_position, new_increment. If any is nil, it will not be changed

---@class animation_properties
---@field start_pos SWMatrix The start position of the animation
---@field current_pos SWMatrix The position the animation is currently at
---@field destination_pos SWMatrix The end position of the animation
---@field paused boolean Whether or not the animation is paused
---@field looping boolean Whether or not the animation repeats after
---@field increment number I can't think of the right words to use to explain this, you probably know what this is though, mainly because you're a smart, lovable human being, and you are truly awesome. You make other people's days good, even when you're having a bad day, and that is why you are truly awesome and lovable. You are the person everyone looks up to when they desire to be a perfect human being. Keep being you. Because you are amazing.
---@field callback function The function that is called every animation tick. One argument is passed through, the animation data
---@field id integer The ID of this animation
---@field finished boolean Whether or not the animation has been completed.
---@field type string Type of animation

------------------------
------Animation
------------------------
---@type table<integer, animation>
cuhFramework.animation.ongoingAnimations = {}

---Create a linear animation. Does not support rotation, only XYZ position
---@param start_position SWMatrix The position for the animation to start at
---@param desired_position SWMatrix The position for the animation to end at
---@param increment number I can't think of the right words to use to explain this, you probably know what this is though, mainly because you're a smart, lovable human being, and you are truly awesome. You make other people's days good, even when you're having a bad day, and that is why you are truly awesome and lovable. You are the person everyone looks up to when they desire to be a perfect human being. Keep being you. Because you are amazing.
---@param should_loop boolean Whether or not the animation should repeat upon reaching the desired position
---@param callback function<animation> The function that is called every animation tick. One argument is passed through, the animation itself
cuhFramework.animation.createLinearAnimation = function(start_position, desired_position, increment, should_loop, callback)
	local id = #cuhFramework.animation.ongoingAnimations + 1
	cuhFramework.animation.ongoingAnimations[id] = {
		properties = {
			start_pos = start_position,
			current_pos = matrix.translation(start_position[13], start_position[14], start_position[15]),
			destination_pos = desired_position,
			paused = false,
			looping = should_loop,
			increment = increment,
			callback = callback,
			id = id,
			finished = false,
			type = "linear"
		},

		remove = function(self)
			return cuhFramework.animation.removeAnimation(self.properties.id)
		end,

		setPaused = function(self, state)
			self.properties.paused = state
		end,

		setLooped = function(self, state)
			self.properties.looping = state
		end,

		isFinished = function(self)
			return self.properties.finished
		end,

		edit = function(self, new_start_position, new_destination_position, new_current_position, new_increment)
			self.properties.start_pos = new_start_position or self.properties.start_pos
			self.properties.destination_pos = new_destination_position or self.properties.destination_pos
			self.properties.current_pos = new_current_position or self.properties.current_pos
			self.properties.increment = new_increment or self.properties.increment
		end
	}

	return cuhFramework.animation.ongoingAnimations[id]
end

---Remove an animation by its ID
---@param id integer The ID of the animation. You can get the ID of an animation on creation. For example: cuhFramework.animation.createAnimation(...).properties.id
---@return nil
cuhFramework.animation.removeAnimation = function(id)
	cuhFramework.animation.ongoingAnimations[id] = nil
end

---Manage animations
cuhFramework.backend.updates:insert(function()
	for i, v in pairs(cuhFramework.animation.ongoingAnimations) do
		-- quick check
		if v.properties.paused then
			goto continue
		end

		if v.properties.looping and v.properties.finished then
			v.properties.finished = false
		end

		-- it gets messy kinda, but yeah main animation handling stuff here
		local got_to_destination_count = 0
		if v.properties.type == "linear" then
			for i2 = 1, 3 do
				-- check if reached destination, fuck precision all the homies hate precision btw
				if v.properties.current_pos[12 + i2] > v.properties.destination_pos[12 + i2] - v.properties.increment and v.properties.current_pos[12 + i2] < v.properties.destination_pos[12 + i2] + v.properties.increment then
					got_to_destination_count = got_to_destination_count + 1
					goto continue
				end

				-- some checks and moving and some stuff too and other stuff
				if v.properties.current_pos[12 + i2] < v.properties.destination_pos[12 + i2] then
					v.properties.current_pos[12 + i2] = v.properties.current_pos[12 + i2] + v.properties.increment
				elseif v.properties.current_pos[12 + i2] > v.properties.destination_pos[12 + i2] then
					v.properties.current_pos[12 + i2] = v.properties.current_pos[12 + i2] - v.properties.increment
				end

				-- jggjh
				::continue::
			end
		end

		-- check if animation is done
		if got_to_destination_count == 3 then -- 3 because x y z
			-- set finished
			v.properties.finished = true

			-- repeat anim
			if v.properties.looping then
				local old = v.properties.start_pos
				v.properties.start_pos = v.properties.destination_pos
				v.properties.destination_pos = old
			end
		end

		-- call callback, also since we are using ":", v is passed into the function!! wooooooooo!!!!!
		v.properties.callback(v)

		-- good old goto statement
		::continue::
	end
end)

----------------------------------------
----------------------------------------
----------------------------------------
--//Framework - Savedata\\--
----------------------------------------
----------------------------------------
g_savedata = {}

------------------------
------Savedata
------------------------
cuhFramework.savedata.saved_data = g_savedata

---Save a value to save data. Functions cannot be saved
---@param value any The value to save. Cannot be a function
---@param index any|nil The index of the value. If nil, none will be used. Example (if nil): {value1, value}. Example (if not nil): {index_here = value1, index_here = value}. Cannot be a function. The index is also converted to a string
---@param key any|nil The key to give the value, can be nil if the value doesn't have a key. This is useless if index is nil. Gets converted to a string within this function
---@return nil
cuhFramework.savedata.add = function(value, index, key)
	if key then
		key = tostring(key)
	end

	if index then
		index = tostring(index)
	end

	if key and index then
		index = key.."_"..index
	end

	if index then
		g_savedata[index] = value
	else
		cuhFramework.utilities.table.insert(g_savedata, value)
	end
end

---Remove a value from save data
---@param value any The value to remove. Cannot be a function
---@param index any|nil The index to use when searching for the value to remove (instead of looping through the values, it removes parent[index]). If nil, this function will just loop through the values to find and remove the passed value
---@param key any|nil The key of the value, can be nil if the value doesn't have a key. This is useless if index is nil. Gets converted to a string within this function
---@return nil
cuhFramework.savedata.remove = function(value, index, key)
	if key then
		key = tostring(key)
	end

	if index then
		index = tostring(index)
	end

	if key and index then
		index = key.."_"..index
	end

	if index then
		g_savedata[index] = nil
	else
		cuhFramework.utilities.table.removeValueFromTable(g_savedata, value)
	end
end

---Get a value from save data
---@param value any The value to find
---@param index any|nil The index to use when searching (instead of looping through the values, it returns parent[index]). If nil, this function will just loop through the values to find the desired value
---@param key any|nil The key of the value, can be nil if the value doesn't have a key. This is useless if index is nil. Gets converted to a string within this function
---@return any|nil value The retrieved value, or nil if not found
cuhFramework.savedata.get = function(value, index, key)
	if key then
		key = tostring(key)
	end

	if index then
		index = tostring(index)
	end

	if key and index then
		index = key.."_"..index
	end

	if index then
		return g_savedata[index]
	else
		return cuhFramework.utilities.table.getValueInTable(g_savedata, value)
	end
end

------------------------
------Misc
------------------------
---Save the game, only works in dedicated servers. Pretty much an alias to server.save()
---@param save_name string|nil The name of the save. If nil, autosave will be used (I think)
---@return nil
cuhFramework.savedata.save = function(save_name)
	return server.save(save_name)
end

----------------------------------------
----------------------------------------
----------------------------------------
--//Framework - Commands\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class command
---@field id integer The ID of this command
---@field command_name string The name of this command
---@field shorthands table The shorthands of this command
---@field caps_sensitive boolean|nil Whether or not this command is caps sensitive
---@field callback function The callback that is called upon the command being executed
---@field description string The description of the command, unused in cuhFramework, but may be useful if you want to create a '?help' command.

------------------------
------Commands
------------------------
---@type table<integer, command>
cuhFramework.commands.registeredCommands = {}

---Create a command
---@param command_name string The name of the command, example: "my_command"
---@param shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c"
---@param caps_sensitive boolean|nil Whether or not the command is caps sensitive
---@param callback function The function that will be called upon a player typing the command
---@param description string|nil The description of this command
cuhFramework.commands.create = function(command_name, shorthands, caps_sensitive, callback, description)
	if type(shorthands) == "string" then
		shorthands = {shorthands}
	end

	local id = #cuhFramework.commands.registeredCommands + 1
	cuhFramework.commands.registeredCommands[id] = {
		id = id,
		command_name = command_name,
		shorthands = shorthands or {},
		caps_sensitive = caps_sensitive,
		callback = callback,
		description = description or ""
	}

	return {
		properties = cuhFramework.commands.registeredCommands[id],

		---Edit the properties of this command
		---@param new_command_name string|nil The name of the command, example: "my_command". If this is nil, the name of the command will not be changed
		---@param new_shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c". If this is nil, the shorthands of the command will not be changed
		---@param new_caps_sensitive boolean|nil Whether or not the command should be caps sensitive. If this is nil, the command will remain caps sensitive or not caps sensitive depending on what it was set to beforehand
		---@param new_callback function|nil The function that will be called upon a player typing the command. If this is nil, the command callback will not be changed
		---@return table command The command itself
		edit = function(self, new_command_name, new_shorthands, new_caps_sensitive, new_callback)
			self.properties.command_name = new_command_name or self.properties.command_name
			self.properties.shorthands = new_shorthands or self.properties.shorthands
			self.properties.caps_sensitive = new_caps_sensitive or self.properties.caps_sensitive
			self.properties.callback = new_callback or self.properties.callback

			return self
		end,

		---Removes the command permanently
		remove = function(self)
			cuhFramework.commands.registeredCommands[self.properties.id] = nil
		end
	}
end

---Get a command by the name
---@param command_name string The name of the command
---@param caps_sensitive_search boolean|nil Whether or not the search should be caps sensitive, example: if a command is named "Hey" and you look for a command named "hey" with caps_sensitive set to false, it will return the command with the name of "Hey"
---@return table|nil command The command, or nil if not found
cuhFramework.commands.getCommandFromName = function(command_name, caps_sensitive_search)
	for i, v in pairs(cuhFramework.commands.registeredCommands) do
		if caps_sensitive_search then
			if v.command_name == command_name then
				return v
			end
		else
			if v.command_name:lower() == command_name:lower() then
				return v
			end
		end
	end
end

---Remove a command by its ID
---@param command_id integer The ID of the command. To get the ID of a command: cuhFramework.commands.create("my_command", {"m_c", "mc"}, function() end, false).properties.id or use cuhFramework.commands.getCommandFromName()
cuhFramework.commands.remove = function(command_id)
	cuhFramework.commands.registeredCommands = nil
end

---Manage commands [Backend]
cuhFramework.callbacks.onCustomCommand:connect(function(msg, peer_id, is_admin, is_auth, command, ...)
	-- get variables
	local player = cuhFramework.players.getPlayerByPeerId(peer_id)
	local edited_command = command:sub(2, -1) --"?hey" becomes "hey"

	for i, v in pairs(cuhFramework.commands.registeredCommands) do
		if v.caps_sensitive then
			-- caps sensitive
			if v.command_name == edited_command or cuhFramework.utilities.table.isValueInTable(v.shorthands, edited_command) then
				for _, con in pairs(cuhFramework.customCallbacks.onCommandActivated.connections) do
					con(v, player, ...)
				end

				v.callback(msg, peer_id, is_admin, is_auth, command, ...)
			end
		else
			-- not caps sensitive
			if v.command_name:lower() == edited_command:lower() or cuhFramework.utilities.table.isValueInTable(cuhFramework.utilities.table.lowercaseStringValues(v.shorthands), edited_command:lower()) then
				for _, con in pairs(cuhFramework.customCallbacks.onCommandActivated.connections) do
					con(v, player, ...)
				end

				v.callback(msg, peer_id, is_admin, is_auth, command, ...)
			end
		end
	end
end)

----------------------------------------
----------------------------------------
--//Framework - Chat\\--
----------------------------------------
----------------------------------------

---Sends a message into chat
---@param author string The orange text in chat, if author was "Bob", in chat, it would look like: "Bob			(message here)"
---@param message string|table What to send in chat (can be a string or a table)
---@param player player|nil The player to send the message to. If this is nil, the message will be sent to everyone
cuhFramework.chat.send_message = function(author, message, player)
	local msg = tostring(message)

	if type(message) == "table" then
		msg = table.concat(cuhFramework.utilities.table.tostringValues(message), " ")
	end

	if player then
		server.announce(author, msg, player.properties.peer_id)
	else
		server.announce(author, msg)
	end
end

---Clears the chat by sending 11 blank messages
---@param player player|nil The player to clear chat for. If this is nil, chat will be cleared for everyone
cuhFramework.chat.clear = function(player)
	for _ = 1, 11 do
		cuhFramework.chat.send_message("", " ", player)
	end
end

----------------------------------------
----------------------------------------
--//Framework - Players\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class playerProperties
---@field peer_id integer The peer_id of this player
---@field admin boolean Whether or not this player is an admin
---@field auth boolean Whether or not this player is authed
---@field name string The name of this player
---@field steam_id integer The steam_id of this player
---@field disconnecting boolean Whether or not the player is leaving the server

---@class player
---@field properties playerProperties The properties of this player
---@field kick function<player> Kick this player
---@field ban function<player> Ban this player
---@field kill function<player> Kills this player
---@field teleport function<player, SWMatrix> Teleport this player to a position
---@field fake_chat function<player, string, player|nil> Send a fake message that seems like this player sent it
---@field get_position function<player> Returns the position of this player as a matrix
---@field set_admin function<player, boolean> Gives this player admin/Removes it
---@field set_auth function<player, boolean> Gives this player auth/Removes it
---@field give_item function<player, SWSlotNumberEnum, SWEquipmentTypeEnum, integer, float, boolean|nil> Gives this player an item
---@field remove_item function<player, SWSlotNumberEnum> Removes an item in the specified slot from this player
---@field get_item function<player, SWSlotNumberEnum> Return the item in the specified slot
---@field damage function<player, number> Apply damage to a player, pass a negative number to heal
---@field get_character function<player> Returns the object ID of this player's character
---@field seat function<player, vehicle, seat_name> Places this player in a seat

------------------------
------Players
------------------------
---@type table<integer, player>
cuhFramework.players.connectedPlayers = {}

-- Update connectedPlayers [Backend]
cuhFramework.backend.givePlayerData = function(steam_id, name, peer_id, is_admin, is_auth)
	local data = {
		properties = {
			peer_id = peer_id,
			admin = is_admin,
			auth = is_auth,
			name = name,
			steam_id = steam_id,
			disconnecting = false
		},

		kick = function(self)
			server.kickPlayer(self.properties.peer_id)
		end,

		ban = function(self)
			server.banPlayer(self.properties.peer_id)
		end,

		teleport = function(self, pos)
			return server.setPlayerPos(self.properties.peer_id, pos)
		end,

		fake_chat = function(self, message, target_player)
			cuhFramework.chat.send_message(self.properties.name, message, target_player)
		end,

		get_position = function(self)
			local pos = server.getPlayerPos(self.properties.peer_id)
			return pos
		end,

		set_admin = function(self, give)
			if give then
				server.addAdmin(self.properties.peer_id)
			else
				server.removeAdmin(self.properties.peer_id)
			end
		end,

		set_auth = function(self, give)
			if give then
				server.addAuth(self.properties.peer_id)
			else
				server.removeAuth(self.properties.peer_id)
			end
		end,

		give_item = function(self, slot, item, int, float, active)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.setCharacterItem(char_id, slot, item, active, int, float)
		end,

		remove_item = function(self, slot)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.setCharacterItem(char_id, slot, 0, false, 0, 0)
		end,

		get_item = function(self, slot)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.getCharacterItem(char_id, slot)
		end,

		kill = function(self)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			-- server.killCharacter(char_id) -- tends to call onPlayerDie twice
			server.setCharacterData(char_id, 0, false, false)
		end,

		damage = function(self, amount)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			local data = server.getCharacterData(char_id)

			if not data then
				return
			end

			server.setCharacterData(char_id, data.hp - amount, data.interactible, data.ai)
		end,

		get_character = function(self)
			return server.getPlayerCharacterID(self.properties.peer_id)
		end,

		seat = function(self, vehicle, seat_name)
			local char_id, success = self:get_character()

			if not success then
				return
			end

			return server.setCharacterSeated(char_id, vehicle.properties.vehicle_id, seat_name)
		end
	}

	cuhFramework.players.connectedPlayers[peer_id] = data
end

cuhFramework.backend.giveDataToCurrentPlayers = function(shouldFireEvents)
	for i, v in pairs(server.getPlayers()) do
		cuhFramework.backend.givePlayerData(v.steam_id, v.name, v.id, v.admin, v.auth)

		if not shouldFireEvents then
			goto continue
		end

		cuhFramework.utilities.delay.create(0.02, function()
			for _, connection in pairs(cuhFramework.callbacks.onPlayerJoin.connections) do
				connection(v.steam_id, v.name, v.id, v.admin, v.auth)
			end

			local char_id = server.getPlayerCharacterID(v.id)

			for _, connection in pairs(cuhFramework.callbacks.onObjectLoad.connections) do
				connection(char_id)
			end
		end)
	end

    ::continue::
end

cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, is_admin, is_auth)
	cuhFramework.backend.givePlayerData(steam_id, name, peer_id, is_admin, is_auth)

	-- and show running ui (extremely useful)
	cuhFramework.utilities.delay.create(0.01, function()
		for i, v in pairs(cuhFramework.ui.screen.activeUI) do
			if not v.properties.player then
				server.setPopupScreen(peer_id, v.properties.id, "", v.properties.visible, v.properties.text, v.properties.x, v.properties.y)
			end
		end
	end)
end)

cuhFramework.backend.giveDataToCurrentPlayers(true)

cuhFramework.utilities.loop.create(0.1, function() -- update player properties (auth, etc)
	cuhFramework.backend.giveDataToCurrentPlayers(false)
end)

cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, is_admin, is_auth)
	for i, v in pairs(cuhFramework.ui.screen.activeUI) do
		if v.properties.player then
			if v.properties.player == cuhFramework.players.getPlayerByPeerId(peer_id) then
				cuhFramework.ui.screen.remove(v.properties.id)
			end
		end
	end

	cuhFramework.players.connectedPlayers[peer_id].properties.disconnecting = true

	cuhFramework.utilities.delay.create(0.1, function()
		cuhFramework.players.connectedPlayers[peer_id] = nil
	end)
end)

---Get a player by their peer_id
---@param peer_id integer Peer ID of the player you want to get
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByPeerId = function(peer_id)
	return cuhFramework.players.connectedPlayers[peer_id] or nil
end

---Get a player by their Steam ID
---@param steam_id integer Steam ID of the player you want to get
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerBySteamId = function(steam_id)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if cuhFramework.utilities.string.tostring(v.properties.steam_id) == cuhFramework.utilities.string.tostring(steam_id) then
			return v
		end
	end
end

---Get a player by an object ID
---@param object_id integer The object ID of the player
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByObjectId = function(object_id)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if (server.getPlayerCharacterID(v.properties.peer_id)) == object_id then
			return v
		end
	end
end

---Get a player by their name
---@param name string Name of the player
---@param caps_sensitive boolean Whether or not the search should be caps sensitive
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByName = function(name, caps_sensitive)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if caps_sensitive then
			if v.properties.name:lower() == name:lower() then
				return v
			end
		else
			if v.properties.name == name then
				return v
			end
		end
	end
end

---Get a player by their name, but a partial name is allowed (award for best function name goes to me)
---@param name string Name/Partial name of the player
---@param caps_sensitive boolean Whether or not the search should be caps sensitive
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByNameWithAllowedPartialName = function(name, caps_sensitive)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if not caps_sensitive then
			if v.properties.name:lower():gsub(" ", ""):find(name:lower():gsub(" ", "")) then
				return v
			end
		else
			if v.properties.name:gsub(" ", ""):find(name:gsub(" ", "")) then
				return v
			end
		end
	end
end

---Get player count
---@param isDedicatedServer boolean|nil Whether or not this addon is running in a dedicated server, set to true if this addon is running in a dedicated server
---@return integer playerCount Number of players in the server
cuhFramework.players.getPlayerCount = function(isDedicatedServer)
	local count = cuhFramework.utilities.table.getValueCountOfTable(cuhFramework.players.connectedPlayers)

	if isDedicatedServer then
		return count - 1
	else
		return count
	end
end

----------------------------------------
----------------------------------------
--//Framework - HTTP\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class http_get_request
---@field port integer The port of the request
---@field url string The URL of the request (eg: "/my_thingy". you can only send a rqeuest ot localhost)
---@field callback function|nil The function that will be called when this request receives a reply
---@field id integer The ID of the request data

---@class url_arg
---@field name string The name of the argument to be passed through (becomes: "?name=value")
---@field value string The value itself (becomes: "?name=value")

------------------------
------HTTP
------------------------
---@type table<integer, http_get_request>
cuhFramework.http.requests = {}

---Send a get request
---@param url string The URL to send the request to (example: "/my_thingy"). You cannot send a request to anywhere but localhost because Stormworks is silly like that
---@param port integer The port of the request
---@param reply_callback function|nil The function that will be called when a reply is received. An argument is passed through to this function, the response of the request
cuhFramework.http.get = function(url, port, reply_callback)
	local id = #cuhFramework.http.requests + 1
	cuhFramework.http.requests[id] = {
		port = port,
		url = url,
		callback = reply_callback,
		id = id
	}

	cuhFramework.references.httpGet(port, url)

	return {
		properties = cuhFramework.http.requests[id],

		---Cancel this request
		---@return nil
		cancel = function(self)
			cuhFramework.http.cancel(self.properties.id)
		end
	}
end

---Cancel a request by its ID
---@param id integer The ID of the request
---@return nil
cuhFramework.http.cancel = function(id)
	cuhFramework.http.requests[id] = nil
end

---Determines whether or not a request was successful, recommended to use in the reply callback when sending a get request
---@param response boolean The response of the request
---@return boolean ok Whether or not the request was successful
cuhFramework.http.ok = function(response)
	return response ~= "Connection closed unexpectedly" and response ~= "connect(): Connection refused" and response ~=  "recv(): Connection reset by peer" and response ~= "timeout"
end

---Adds arguments to a url. Example: "/get?my_argument=1", 
---@param url string The URL itself
---@param ... url_arg The arguments to plop into the URL (eg: {name = "yo", value="hey"}, {name="hey", value="yo"}). Do not use custom indexes
---@return string url The URL with the arguments added
cuhFramework.http.url_args = function(url, ...)
	-- convert args to stuffs tghfgdfd
	local args = {}
	local packed = {...}

	for i, v in pairs(packed) do
		if i == 1 then
			table.insert(args, "?"..cuhFramework.http.url_encode(v.name).."="..cuhFramework.http.url_encode(v.value))
		else
			table.insert(args, "&"..cuhFramework.http.url_encode(v.name).."="..cuhFramework.http.url_encode(v.value))
		end
	end

	-- anddd return
	return url..table.concat(args)
end

---Converts a string to a bool
---@param input string The string to convert to a bool
---@return boolean state True/false
cuhFramework.http.stringToBool = function(input)
	return input:lower() == "true"
end

---URL encode a string
---@param input string The string to encode
---@return string encoded_string The URL encoded string
cuhFramework.http.url_encode = function(input)
	input = tostring(input)
	input = string.gsub(input, "\n", "\r\n")
	input = string.gsub(input, "([^%w ])",
		function (c)
			return string.format("%%%02X", string.byte(c))
		end
	)

	input = string.gsub(input, " ", "+")

	return input
end

---URL decode a string
---@param input string The string to decode
---@return string decoded_string The decoded string
cuhFramework.http.url_decode = function(input)
    if type(input) == "string" then
        input = string.gsub(input, "+", " ")
        input = string.gsub(input, "%%(%x%x)",
            function (hex)
				return string.char(tonumber(hex, 16))
			end
		)

        input = string.gsub(input, "\r\n", "\n")
    end

    return input
end

---Manage requests
cuhFramework.callbacks.httpReply:connect(function(port, url, response)
	for i, v in pairs(cuhFramework.http.requests) do
		if v.port == port and v.url == url and v.callback then
			v.callback(response)
			cuhFramework.http.requests[i] = nil
		end
	end
end)

----------------------------------------
----------------------------------------
--//Framework - TPS\\--
----------------------------------------
----------------------------------------
---@type table<string, any>
cuhFramework.tps.tpsData = {
	averageTPS = 62.0,
	serverTPS = 62.0,

	ticks = 0,
	ticks_time = 0,
	backend_avgTpsTable = {}
}

-- Update TPS [Backend]
cuhFramework.backend.updates:insert(function()
	cuhFramework.tps.tpsData.ticks  = cuhFramework.tps.tpsData.ticks  + 1

    if server.getTimeMillisec() - cuhFramework.tps.tpsData.ticks_time >= 500 then
        cuhFramework.tps.tpsData.serverTPS = cuhFramework.tps.tpsData.ticks  * 2
        cuhFramework.tps.tpsData.ticks = 0
        cuhFramework.tps.tpsData.ticks_time = server.getTimeMillisec()
    end

	if #cuhFramework.tps.tpsData.backend_avgTpsTable <= 120 then
		cuhFramework.utilities.table.insert(cuhFramework.tps.tpsData.backend_avgTpsTable, cuhFramework.tps.tpsData.serverTPS)
	else
		cuhFramework.tps.tpsData.averageTPS = cuhFramework.utilities.table.sumOfTable(cuhFramework.tps.tpsData.backend_avgTpsTable) / #cuhFramework.tps.tpsData.backend_avgTpsTable
		cuhFramework.tps.tpsData.backend_avgTpsTable = {}
	end
end)

---Get TPS Data
cuhFramework.tps.getTPSData = function()
	return cuhFramework.tps.tpsData
end

----------------------------------------
----------------------------------------
--//Framework - Objects\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class object_properties
---@field object_id integer The object ID of this object
---@field position SWMatrix The position this object was spawned at
---@field object_type SWObjectTypeEnum The type of object

---@class object
---@field properties object_properties The properties of this creature
---@field despawn function<object> Despawn this object
---@field teleport function<object, SWMatrix> Teleport this object
---@field get_position function<object> Get the position of this object
---@field get_data function<object> Returns the raw data of this object provided by Stormworks
---@field explode function<object, number|nil> Explodes this object, while also despawning this object
---@field set_tooltip function<object, string> Sets the tooltip of this object

------------------------
------Objects
------------------------
---@type table<integer, object>
cuhFramework.objects.spawnedObjects = {}

---Spawn a object
---@param position SWMatrix The position to spawn this object at
---@param object_type SWObjectTypeEnum The type of object to spawn
---@return object object The object, or nil if failed to spawn
cuhFramework.objects.spawnObject = function(position, object_type)
	local object_id, success = server.spawnObject(position, object_type)

	if not success then
		return
	end

	cuhFramework.objects.spawnedObjects[object_id] = {
		properties = {
			object_id = object_id,
			spawn_position = position,
			object_type = object_type
		},

		despawn = function(self)
			return cuhFramework.objects.despawnObject(self.properties.object_id)
		end,

		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		get_position = function(self)
			local pos = server.getObjectPos(self.properties.object_id)
			return pos
		end,

		get_data = function(self)
			return server.getObjectData(self.properties.object_id)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		set_tooltip = function(self, tooltip)
			return server.setCharacterTooltip(self.properties.object_id, tooltip)
		end
	}

	return cuhFramework.objects.spawnedObjects[object_id]
end

---Get object by object ID
---@param object_id integer The object ID of the object
---@return object object The object, or nil if no object found
cuhFramework.objects.getObjectByObjectId = function(object_id)
	return cuhFramework.objects.spawnedObjects[object_id]
end

---Despawn an object
---@param object_id integer The object ID of the object you want to despawn
---@return boolean success Whether or not despawning this object was successful
cuhFramework.objects.despawnObject = function(object_id)
	cuhFramework.objects.spawnedObjects[object_id] = nil
	return server.despawnObject(object_id, true)
end

---Despawn all addon-recognised objects
cuhFramework.objects.despawnAllObjects = function()
	for i, v in pairs(cuhFramework.objects.spawnedObjects) do
		cuhFramework.objects.despawnObject(v.properties.object_id)
	end
end

----------------------------------------
----------------------------------------
--//Framework - Creatures\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class creature_properties
---@field object_id integer The object ID of this creature
---@field position SWMatrix The position this creature was spawned at
---@field creature_type SWCreatureTypeEnum The creature type of this creature
---@field size_multiplier number The size multiplier of this creature

---@class creature
---@field properties creature_properties The properties of this creature
---@field despawn function<creature> Despawn this creature
---@field teleport function<creature, SWMatrix> Teleport this creature
---@field kill function<creature> Kill this creature
---@field get_position function<creature> Get the position of this creature
---@field damage function<creature, number> Damage this creature, negative number = heal
---@field set_move_target function<creature, SWMatrix> Make the creature walk to this position
---@field get_data function<creature> Returns the raw data of this creature provided by Stormworks
---@field explode function<creature, number|nil> Explodes this creature, while also despawning this creature
---@field set_tooltip function<creature, string> Sets the tooltip of this creature
---@field set_character_data function<creature, number, boolean, boolean> Sets the data of this creature

------------------------
------Creatures
------------------------
---@type table<integer, creature>
cuhFramework.creatures.spawnedCreatures = {}

---Spawn a creature
---@param position SWMatrix The position to spawn this creature at
---@param creature_type SWCreatureTypeEnum The type of creature
---@param size_multiplier number The size multiplier of this creature
---@return creature creature The creature, or nil if failed to spawn
cuhFramework.creatures.spawnCreature = function(position, creature_type, size_multiplier)
	local object_id, success = server.spawnCreature(position, creature_type, size_multiplier)

	if not success then
		return
	end

	cuhFramework.creatures.spawnedCreatures[object_id] = {
		properties = {
			object_id = object_id,
			spawn_position = position,
			creature_type = creature_type,
			size_multiplier = size_multiplier
		},

		despawn = function(self)
			return cuhFramework.creatures.despawnCreature(self.properties.object_id)
		end,

		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		kill = function(self)
			server.killCharacter(self.properties.object_id)
		end,

		get_position = function(self)
			local pos = server.getObjectPos(self.properties.object_id)
			return pos
		end,

		damage = function(self, amount)
			local data = self:get_data()

			if not data then
				return false
			end

			server.setCharacterData(self.properties.object_id, data.hp - amount, data.interactible, data.ai)
			return true
		end,

		set_move_target = function(self, position)
			return server.setCreatureMoveTarget(self.properties.object_id, position)
		end,

		get_data = function(self)
			return server.getObjectData(self.properties.object_id)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		set_tooltip = function(self, tooltip)
			return server.setCreatureTooltip(self.properties.object_id, tooltip)
		end,

		set_creature_data = function(self, hp, interactable, ai)
			return server.setCharacterData(self.properties.object_id, hp, interactable, ai)
		end
	}

	return cuhFramework.creatures.spawnedCreatures[object_id]
end

---Get creature by object ID
---@param object_id integer The object ID of the creature
---@return creature creature The creature, or nil if no creature found
cuhFramework.creatures.getCreatureByObjectId = function(object_id)
	return cuhFramework.creatures.spawnedCreatures[object_id]
end

---Despawn a creature
---@param object_id integer The object ID of the creature you want to despawn
---@return boolean success Whether or not despawning this creature was successful
cuhFramework.creatures.despawnCreature = function(object_id)
	cuhFramework.creatures.spawnedCreatures[object_id] = nil
	return server.despawnObject(object_id, true)
end

----------------------------------------
----------------------------------------
--//Framework - Characters\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class character_properties
---@field object_id integer The object ID of this character
---@field position SWMatrix The position this character was spawned at
---@field outfit_id SWOutfitTypeEnum The character type of this character

---@class character
---@field properties character_properties The properties of this character
---@field despawn function<character> Despawn this character
---@field teleport function<character, SWMatrix> Teleport this character
---@field kill function<character> Kill this character
---@field get_position function<character> Get the position of this character
---@field damage function<character, number> Damage this character, negative number = heal
---@field get_data function<character> Returns the raw data of this character provided by Stormworks
---@field explode function<character, number|nil> Explodes this character, while also despawning this character
---@field set_tooltip function<character, string> Sets the tooltip of this character
---@field set_character_data function<character, number, boolean, boolean> Sets the data of this character

------------------------
------Characters
------------------------
---@type table<integer, character>
cuhFramework.characters.spawnedCharacters = {}

---Spawn a character
---@param position SWMatrix The position to spawn this character at
---@param outfit_id SWOutfitTypeEnum The character outfit the character should spawn with
---@return character character The character, or nil if failed to spawn
cuhFramework.characters.spawnCharacter = function(position, outfit_id)
	local object_id, success = server.spawnCharacter(position, outfit_id)

	if not success then
		return
	end

	cuhFramework.characters.spawnedCharacters[object_id] = {
		properties = {
			object_id = object_id,
			spawn_position = position,
			outfit_id = outfit_id
		},

		despawn = function(self)
			return cuhFramework.characters.despawnCharacter(self.properties.object_id)
		end,

		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		kill = function(self)
			server.killCharacter(self.properties.object_id)
		end,

		get_position = function(self)
			local pos = server.getObjectPos(self.properties.object_id)
			return pos
		end,

		damage = function(self, amount)
			local data = self:get_data()

			if not data then
				return false
			end

			server.setCharacterData(self.properties.object_id, data.hp - amount, data.interactible, data.ai)
			return true
		end,

		get_data = function(self)
			return server.getObjectData(self.properties.object_id)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		set_tooltip = function(self, tooltip)
			return server.setCharacterTooltip(self.properties.object_id, tooltip)
		end,

		set_character_data = function(self, hp, interactable, ai)
			return server.setCharacterData(self.properties.object_id, hp, interactable, ai)
		end
	}

	return cuhFramework.characters.spawnedCharacters[object_id]
end

---Get character by object ID
---@param object_id integer The object ID of the character
---@return character character The character, or nil if no character found
cuhFramework.characters.getCharacterByObjectId = function(object_id)
	return cuhFramework.characters.spawnedCharacters[object_id]
end

---Despawn a character
---@param object_id integer The object ID of the character you want to despawn
---@return boolean success Whether or not despawning this character was successful
cuhFramework.characters.despawnCharacter = function(object_id)
	cuhFramework.characters.spawnedCharacters[object_id] = nil
	return server.despawnObject(object_id, true)
end

----------------------------------------
----------------------------------------
--//Framework - UI\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class screenUiProperties
---@field x integer horizontal_offset, -1 = left, 1 = right
---@field y integer vertical_offset, -1 = bottom, 1 = top
---@field text string The text this UI object is showing
---@field player player|nil The player that this UI object is being shown to. Nil if everyone
---@field id integer The ID of this UI object
---@field visible boolean Whether or not this UI object is visible

---@class screenUiObject
---@field properties screenUiProperties The properties of this screen UI object
---@field remove function<screenUiObject> Remove this UI
---@field edit function<screenUiObject, string, number, number, player> Edit this UI (new_text, new_x, new_y, and player can be nil). If any of these parameters are nil, then the corresponding property will not be changed
---@field setVisibility function<screenUiObject, boolean> Whether or not this UI is visible
---@field refresh function<screenUiObject> Refresh this UI object

------------------------
------Screen UI
------------------------
cuhFramework.ui.screen = {}

---@type table<integer, screenUiObject>
cuhFramework.ui.screen.activeUI = {}

---Create a screen UI object for a player
---@param id integer The ID of the UI object
---@param text string The text that should be in the UI (can be updated)
---@param x number -1 = left, 1 = right
---@param y number -1 = bottom, 1 = top
---@param player player|nil The player to show this UI object to
---@return screenUiObject
cuhFramework.ui.screen.create = function(id, text, x, y, player)
	cuhFramework.ui.screen.activeUI[id] = {
		properties = {
			x = x,
			y = y,
			text = text,
			player = player,
			id = id,
			visible = true
		},

		remove = function(self)
			return cuhFramework.ui.screen.remove(self.properties.id)
		end,

		edit = function(self, new_text, new_x, new_y, new_player)
			self.properties.x = new_x or self.properties.x
			self.properties.y = new_y or self.properties.y
			self.properties.text = new_text or self.properties.text

			self.properties.player = new_player or self.properties.player

			if new_player and new_player == -1 then
				self.properties.player = nil
			end

			self:refresh()
		end,

		setVisibility = function(self, shouldShow)
			if self.properties.visible == shouldShow then
				return
			end

			self.properties.visible = shouldShow
			self:refresh()
		end,

		refresh = function(self)
			local v_peer_id = -1

			if self.properties.player then
				v_peer_id = self.properties.player.properties.peer_id
			end

			cuhFramework.references.createScreenPopup(v_peer_id, self.properties.id, "", self.properties.visible, self.properties.text, self.properties.x, self.properties.y)
		end
	}

	cuhFramework.ui.screen.activeUI[id]:refresh()
	return cuhFramework.ui.screen.activeUI[id]
end

---Remove a screen UI object
---@param id integer The ID of the UI object
cuhFramework.ui.screen.remove = function(id)
	cuhFramework.references.removePopup(-1, id)
	cuhFramework.ui.screen.activeUI[id] = nil
end

---Get a screen UI object
---@param id integer The ID of the UI object
---@return screenUiObject uiObject The retrieved UI object, or nil if none found
cuhFramework.ui.screen.get = function(id)
	local uiObject = cuhFramework.ui.screen.activeUI[id]
	return uiObject
end

------------------------
------Notifications UI
------------------------
cuhFramework.ui.notifications = {}

---Show a success notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
cuhFramework.ui.notifications.success = function(text, player)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, "Success", text, 4)
end

---Show a warning notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
cuhFramework.ui.notifications.warning = function(text, player)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, "Warning", text, 1)
end

---Show a failure notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
cuhFramework.ui.notifications.failure = function(text, player)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, "Failure", text, 3)
end

---Show a custom notification
---@param title string The title of the notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
---@param notification_type SWNotifiationTypeEnum|nil The notification type, aka the icon in the notification. If nil, it will become 4 (complete_mission, green success icon)
cuhFramework.ui.notifications.custom = function(title, text, player, notification_type)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, title, text, notification_type or 4)
end

----------------------------------------
----------------------------------------
--//Framework - Custom Zones\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class player_customZone
---@field position SWMatrix The position of this zone
---@field size number The size of this zone
---@field callback function The callback that will be activated when a player enters/leaves the zone
---@field id integer The ID of this zone
---@field playersInZone table<integer, player> The players in this zone

---@class vehicle_customZone
---@field position SWMatrix The position of this zone
---@field size number The size of this zone
---@field callback function The callback that will be activated when a vehicle enters/leaves the zone
---@field id integer The ID of this zone
---@field vehiclesInZone table<integer, vehicle> The vehicles in this zone

------------------------
------Custom Zones (Player)
------------------------
---@type table<integer, player_customZone>
cuhFramework.customZones.activePlayerZones = {}

---Create a zone for players
---@param position SWMatrix The position the zone should be at
---@param size number The size of the zone in meters
---@param callback function The function that should be called when a player enters the zone. A player will be sent through the callback if a player enters/leaves the zone, along with a boolean. true = Player entered, false = Player left
cuhFramework.customZones.createPlayerZone = function(position, size, callback)
	if not callback then
		return false
	end

	local id = #cuhFramework.customZones.activePlayerZones + 1
	cuhFramework.customZones.activePlayerZones[id] = {
		position = position,
		size = size,
		callback = callback,
		id = id,
		playersInZone = {},

		backend_loop = cuhFramework.utilities.loop.create(0.02, function()
			local zone = cuhFramework.customZones.activePlayerZones[id]
			for i, player in pairs(cuhFramework.players.connectedPlayers) do
				local distance = cuhFramework.references.matrix.distance(player:get_position(), zone.position)

				if distance <= zone.size then
					if not zone.playersInZone[player.properties.peer_id] then
						zone.playersInZone[player.properties.peer_id] = player
						zone.callback(player, true)
					end
				else
					if zone.playersInZone[player.properties.peer_id] then
						zone.playersInZone[player.properties.peer_id] = nil
						zone.callback(player, false)
					end
				end
			end
		end),

		backend_checkIfPlayerLeft = cuhFramework.callbacks.onPlayerLeave:connect(function(_, _, peer_id)
			local data = cuhFramework.customZones.activePlayerZones[id]
			local player = cuhFramework.players.getPlayerByPeerId(peer_id)

			if data.playersInZone[peer_id] then
				data.playersInZone[peer_id] = nil
				data.callback(player, false)
			end
		end)
	}

	return {
		---@type player_customZone
		properties = cuhFramework.customZones.activePlayerZones[id],

		---Remove this zone
		remove = function(self)
			cuhFramework.customZones.removePlayerZone(self.properties.id)
		end,

		---Edit this zone
		---@param new_position SWMatrix|nil What the new position should be, set to nil if you don't want to change
		---@param new_size number|nil What the new size should be, set to nil if you don't want to change
		---@param new_callback function|nil What the new callback should be, set to nil if you don't want to change
		edit = function(self, new_position, new_size, new_callback)
			self.properties.position = new_position or self.properties.position
			self.properties.size = new_size or self.properties.size
			self.properties.callback = new_callback or self.properties.callback
		end
	}
end

---Whether or not a position is within a player zone
---@param position SWMatrix The position to check
---@return player_customZone|nil zone The player zone the position is in, or nil if no player zone was found
cuhFramework.customZones.isPositionInPlayerZone = function(position)
	for i, v in pairs(cuhFramework.customZones.activePlayerZones) do
		if cuhFramework.references.matrix.distance(position, v.position) <= v.size then
			return v
		end
	end
end

---Remove a player zone
---@param id integer The ID of the player zone
cuhFramework.customZones.removePlayerZone = function(id)
	local zone = cuhFramework.customZones.activePlayerZones[id]

	if zone then
		zone.backend_loop:remove()
		zone.backend_checkIfPlayerLeft:disconnect()
	end

	cuhFramework.customZones.activePlayerZones[id] = nil
end

------------------------
------Custom Zones (Vehicle)
------------------------
---@type table<integer, vehicle_customZone>
cuhFramework.customZones.activeVehicleZones = {}

---Create a zone for vehicles
---@param position SWMatrix The position the zone should be at
---@param size number The size of the zone in meters
---@param callback function The function that should be called when a vehicle enters the zone. A vehicle will be sent through the callback if a vehicle enters/leaves the zone, along with a boolean. true = Vehicle entered, false = Vehicle left
cuhFramework.customZones.createVehicleZone = function(position, size, callback)
	if not callback then
		return false
	end

	local id = #cuhFramework.customZones.activeVehicleZones + 1
	cuhFramework.customZones.activeVehicleZones[id] = {
		position = position,
		size = size,
		callback = callback,
		id = id,
		vehiclesInZone = {},

		backend_blacklist = {},

		backend_loop = cuhFramework.utilities.loop.create(0.02, function()
			local zone = cuhFramework.customZones.activeVehicleZones[id]
			for i, vehicle in pairs(cuhFramework.vehicles.spawnedVehicles) do
				local distance = cuhFramework.references.matrix.distance(vehicle:get_position(), zone.position)

				if not zone.backend_blacklist[vehicle.properties.vehicle_id] then
					if distance <= zone.size then
						if not zone.vehiclesInZone[vehicle.properties.vehicle_id] then
							zone.vehiclesInZone[vehicle.properties.vehicle_id] = vehicle
							zone.callback(vehicle, true)
						end
					else
						if zone.vehiclesInZone[vehicle.properties.vehicle_id] then
							zone.vehiclesInZone[vehicle.properties.vehicle_id] = nil
							zone.callback(vehicle, false)
						end
					end
				end
			end
		end),

		backend_checkIfVehicleDespawned = cuhFramework.callbacks.onVehicleDespawn:connect(function(vehicle_id)
			local data = cuhFramework.customZones.activeVehicleZones[id]
			local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

			if data.vehiclesInZone[vehicle_id] then
				data.vehiclesInZone[vehicle_id] = nil
				data.callback(vehicle, false)
				data.backend_blacklist[vehicle_id] = true
			end
		end)
	}

	return {
		---@type vehicle_customZone
		properties = cuhFramework.customZones.activeVehicleZones[id],

		---Remove this zone
		remove = function(self)
			cuhFramework.customZones.removeVehicleZone(self.properties.id)
		end,

		---Edit this zone
		---@param new_position SWMatrix|nil What the new position should be, set to nil if you don't want to change
		---@param new_size number|nil What the new size should be, set to nil if you don't want to change
		---@param new_callback function|nil What the new callback should be, set to nil if you don't want to change
		edit = function(self, new_position, new_size, new_callback)
			self.properties.position = new_position or self.properties.position
			self.properties.size = new_size or self.properties.size
			self.properties.callback = new_callback or self.properties.callback
		end
	}
end

---Whether or not a position is within a vehicle zone
---@param position SWMatrix The position to check
---@return vehicle_customZone|nil zone The vehicle zone the position is in, or nil if no vehicle zone was found
cuhFramework.customZones.isPositionInVehicleZone = function(position)
	for i, v in pairs(cuhFramework.customZones.activeVehicleZones) do
		if cuhFramework.references.matrix.distance(position, v.position) <= v.size then
			return v
		end
	end
end

---Remove a vehicle zone
---@param id integer The ID of the vehicle zone
cuhFramework.customZones.removeVehicleZone = function(id)
	local zone = cuhFramework.customZones.activeVehicleZones[id]

	if zone then
		zone.backend_loop:remove()
		zone.backend_checkIfVehicleDespawned:disconnect()
	end

	cuhFramework.customZones.activeVehicleZones[id] = nil
end

----------------------------------------
----------------------------------------
--//Framework - Disasters\\--
----------------------------------------
----------------------------------------

---Spawn a tsunami
---@param position SWMatrix The matrix position the tsunami should spawn at
---@param magnitude number The magnitude of the tsunami (0 - 1)
cuhFramework.disasters.spawnTsunami = function(position, magnitude)
	server.spawnTsunami(position, magnitude)
	return {
		---Cancel this tsunami
		cancel = function(self)
			server.cancelGerstner()
		end
	}
end

---Spawn a whirlpool
---@param position SWMatrix The matrix position the whirlpool should spawn at
---@param magnitude number The magnitude of the whirlpool (0 - 1)
cuhFramework.disasters.spawnWhirlpool = function(position, magnitude)
	server.spawnWhirlpool(position, magnitude)
	return {
		---Cancel this whirlpool
		cancel = function(self)
			server.cancelGerstner()
		end
	}
end

---Spawn a volcano
---@param position SWMatrix The matrix position the volcano should spawn at
---@param magnitude number The magnitude of the volcano (0 - 1)
---@return boolean success Whether or not the volcano spawned successfully
cuhFramework.disasters.spawnVolcano = function(position, magnitude)
	return server.spawnVolcano(position, magnitude)
end

---Get volcano data
---@return table<number, SWVolcano> volcano_data Table containing all volcanoes
cuhFramework.disasters.getVolcanoes = function(position, magnitude)
	return server.getVolcanos()
end

---Spawn a meteor
---@param position SWMatrix The matrix position the meteor should spawn at
---@param magnitude number The magnitude of the meteor (0 - 1)
---@return boolean success Whether or not the meteor spawned successfully
cuhFramework.disasters.spawnMeteor = function(position, magnitude)
	return server.spawnMeteor(position, magnitude, false)
end

---Spawn a meteor shower
---@param position SWMatrix The matrix position the meteor shower should spawn at
---@param magnitude number The magnitude of the meteor shower (0 - 1)
---@return boolean success Whether or not the meteor shower spawned successfully
cuhFramework.disasters.spawnMeteorShower = function(position, magnitude)
	return server.spawnMeteorShower(position, magnitude, false)
end

---Spawn a tornado
---@param position SWMatrix The matrix position the tornado should spawn at
---@param magnitude number The magnitude of the tornado (0 - 1)
---@return boolean success Whether or not the tornado spawned successfully
cuhFramework.disasters.spawnTornado = function(position, magnitude)
	return server.spawnTornado(position, magnitude)
end

----------------------------------------
----------------------------------------
--//Framework - Vehicles\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class vehicleProperties
---@field vehicle_id integer The ID of this vehicle
---@field owner player The owner of this vehicle
---@field spawnPos SWMatrix The position this vehicle was spawned at
---@field cost number The cost of this vehicle
---@field addon_spawned boolean Whether or not an addon spawned this vehicle
---@field name string The name of this vehicle
---@field loaded boolean Whether or not this vehicle is loaded
---@field loaded_vehicle_data SWVehicleData The data of this vehicle that can only be retrieved when the vehicle is loaded. The table is empty if the vehicle hasn't loaded yet

---@class vehicle
---@field properties vehicleProperties The properties of this vehicle
---@field despawn function<vehicle> Despawn this vehicle
---@field teleport function<vehicle, SWMatrix> Teleport this vehicle
---@field explode function<vehicle, number> Explodes this vehicle and despawns it
---@field get_position function<vehicle, number?, number?, number?> Get the position of this vehicle. The voxel parameters are optional
---@field set_tooltip function<vehicle, string> Sets the tooltip of this vehicle
---@field set_invulnerability function<vehicle, boolean> Sets the invulnerability of this vehicle to whatever you specify (true = this vehicle can receive no damage, false = this vehicle can receive damage)
---@field repair function<vehicle> Repairs the vehicle. Clears all damage and refills inventories by completely respawning the vehicle at its current position
---@field set_keypad function<vehicle, string, number> Sets the value of a keypad on this vehicle to the specified value
---@field get_dial function<vehicle, string> Returns dial data of the specified dial on this vehicle
---@field press_button function<vehicle, string> Presses the specified button on this vehicle
---@field get_button function<vehicle, string> Returns button data of the specified button on this vehicle
---@field set_editable function<vehicle, boolean> Sets whether this vehicle is editable or not

------------------------
------Vehicles
------------------------
---@type table<integer, vehicle>
cuhFramework.vehicles.spawnedVehicles = {}

-- Update spawnedVehicles [Backend]
cuhFramework.backend.vehicle_spawn_giveVehicleData = function(vehicle_id, peer_id, x, y, z, cost)
	if cuhFramework.vehicles.spawnedVehicles[vehicle_id] then
		return
	end

	local data = {
		properties = {
			vehicle_id = vehicle_id,
			owner = cuhFramework.players.getPlayerByPeerId(peer_id),
			spawnPos = matrix.translation(x, y, z),
			cost = cost,
			addon_spawned = peer_id == -1,
			name = (server.getVehicleName(vehicle_id)),

			loaded = false,
			loaded_vehicle_data = {}
		},

		despawn = function(self)
			server.despawnVehicle(self.properties.vehicle_id, true)
			cuhFramework.utilities.delay.create(0.1, function()
				cuhFramework.vehicles.despawnVehicle(self.properties.vehicle_id)
			end)
		end,

		teleport = function(self, pos)
			return server.setVehiclePos(self.properties.vehicle_id, pos)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		get_position = function(self, voxel_x, voxel_y, voxel_z)
			local pos = server.getVehiclePos(self.properties.vehicle_id, voxel_x, voxel_y, voxel_z)
			return pos
		end,

		set_tooltip = function(self, text)
			return server.setVehicleTooltip(self.properties.vehicle_id, text)
		end,

		set_invulnerability = function(self, state)
			return server.setVehicleInvulnerable(self.properties.vehicle_id, state)
		end,

		repair = function(self)
			return server.resetVehicleState(self.properties.vehicle_id)
		end,

		set_keypad = function(self, keypad_name, value)
			return server.setVehicleKeypad(self.properties.vehicle_id, keypad_name, value)
		end,

		get_dial = function(self, dial_name)
			return server.getVehicleDial(self.properties.vehicle_id, dial_name)
		end,

		press_button = function(self, button_name)
			return server.pressVehicleButton(self.properties.vehicle_id, button_name)
		end,

		get_button = function(self, button_name)
			return server.getVehicleButton(self.properties.vehicle_id, button_name)
		end,

		set_editable = function(self, state)
			return server.setVehicleEditable(self.properties.vehicle_id, state)
		end
	}

	cuhFramework.vehicles.spawnedVehicles[vehicle_id] = data
end

cuhFramework.backend.vehicle_load_setVehicleData = function(vehicle_id)
	local vehicle_data = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

	if not vehicle_data then
		return
	end

	if vehicle_data.properties.loaded then
		return
	end

	vehicle_data.properties.loaded = true

	local data, success = server.getVehicleData(vehicle_id)

	if not success then
		return
	end

	vehicle_data.properties.loaded_vehicle_data = data
end

cuhFramework.callbacks.onVehicleSpawn:connect(function(vehicle_id, peer_id, x, y, z, cost)
	if cuhFramework.vehicles.spawnedVehicles[vehicle_id] then -- already has data
		return
	end

	cuhFramework.backend.vehicle_spawn_giveVehicleData(vehicle_id, peer_id, x, y, z, cost)

	local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

	for i, v in pairs(cuhFramework.customCallbacks.onVehicleSpawn.connections) do
		v(vehicle)
	end
end)

cuhFramework.callbacks.onVehicleLoad:connect(function(vehicle_id)
	cuhFramework.utilities.delay.create(1, function()
		local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

		if not vehicle then
			return
		end

		cuhFramework.backend.vehicle_load_setVehicleData(vehicle_id)

		for i, v in pairs(cuhFramework.customCallbacks.onVehicleLoad.connections) do
			v(vehicle)
		end
	end)
end)

cuhFramework.callbacks.onVehicleDespawn:connect(function(vehicle_id, peer_id)
	local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

	if not vehicle then
		goto remove
	end

	for i, v in pairs(cuhFramework.customCallbacks.onVehicleDespawn.connections) do
		v(vehicle)
	end

	::remove::
	cuhFramework.vehicles.spawnedVehicles[vehicle_id] = nil
end)

---Spawn an addon vehicle
---@param playlist_id integer The ID of the addon vehicle, this can be found in the playlist.xml file or in the in-game editor
---@param position SWMatrix The position to spawn this vehicle at
---@return vehicle vehicle The vehicle, or nil if failed to spawn
cuhFramework.vehicles.spawnAddonVehicle = function(playlist_id, position)
	local vehicle_id, success = server.spawnAddonVehicle(position, (server.getAddonIndex()), playlist_id)

	if success then
		cuhFramework.backend.vehicle_spawn_giveVehicleData(vehicle_id, -1, position[13], position[14], position[15])
	end

	return cuhFramework.vehicles.spawnedVehicles[vehicle_id] or nil
end

---Get a vehicle by its vehicle ID
---@param vehicle_id integer Vehicle ID of the vehicle you want to retrieve
---@return vehicle vehicle The retrieved vehicle
cuhFramework.vehicles.getVehicleByVehicleId = function(vehicle_id)
	return cuhFramework.vehicles.spawnedVehicles[vehicle_id] or nil
end

---Get a list of vehicles owned by a player
---@param player player The player to check, use cuhFramework.players.getPlayerByPeerId() to get the player from a peer ID, see documentation
---@return table<integer, vehicle> vehicles Table of all vehicles owned by this player, or nil if no vehicles
cuhFramework.vehicles.getAllVehiclesOwnedByPlayer = function(player)
	local list = {}

	for i, v in pairs(cuhFramework.vehicles.spawnedVehicles) do
		if v.properties.owner == player then
			cuhFramework.utilities.table.insert(list, v)
		end
	end

	return list
end

---Get vehicle count
---@return integer vehicleCount Number of vehicles that are spawned and recognised by this addon
cuhFramework.vehicles.getVehicleCount = function()
	local count = 0

	for _ in pairs(cuhFramework.vehicles.spawnedVehicles) do -- i dont trust #tableName when the index is a number anymore
		count = count + 1
	end

	return count
end

---Despawn vehicle
---@param vehicle_id integer The vehicle ID of the vehicle you want to despawn
cuhFramework.vehicles.despawnVehicle = function(vehicle_id)
	server.despawnVehicle(vehicle_id, true)
end

----------------------------------------
----------------------------------------
--//Framework - References\\--
----------------------------------------
----------------------------------------

------------------------
------Vehicles
------------------------
cuhFramework.references.spawnAddonVehicle = server.spawnAddonVehicle
cuhFramework.references.despawnVehicle = server.despawnVehicle

------------------------
------UI
------------------------
cuhFramework.references.addMapLabel = server.addMapLabel
cuhFramework.references.removeMapLabel = server.removeMapLabel

cuhFramework.references.createPhysicalPopup = server.setPopup
cuhFramework.references.createScreenPopup = server.setPopupScreen
cuhFramework.references.removePopup = server.removePopup

cuhFramework.references.addMapLine = server.addMapLine
cuhFramework.references.removeMapLine = server.removeMapLine

cuhFramework.references.addMapObject = server.addMapObject
cuhFramework.references.addMapLabel = server.addMapLabel
cuhFramework.references.removeMapObject = server.removeMapObject
cuhFramework.references.removeMapLabel = server.removeMapLabel

cuhFramework.references.createUniqueUIID = server.getMapID
cuhFramework.references.removeAllUIWithId = server.removeMapID

------------------------
------Matrix
------------------------
cuhFramework.references.matrix = matrix

------------------------
------Miscellaneous
------------------------
cuhFramework.references.explode = server.spawnExplosion
cuhFramework.references.httpGet = server.httpGet

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Addon Code
------------------------------------------------------------------------
------------------------------------------------------------------------

-----------------
-- [Library | Folder: p1_libraries] announce.lua
-----------------
---------------------------------------
------------- Announce
---------------------------------------

------------- Library
announceLibrary = {
	status = {
        success = function(msg, player)
            cuhFramework.ui.notifications.custom(miscellaneousLibrary.surround(config.info.server_name, "[]").." Success", msg, player, 4)
        end,

        warning = function(msg, player)
            cuhFramework.ui.notifications.custom(miscellaneousLibrary.surround(config.info.server_name, "[]").." Warning", msg, player, 1)
        end,

        failure = function(msg, player)
            cuhFramework.ui.notifications.custom(miscellaneousLibrary.surround(config.info.server_name, "[]").." Failure", msg, player, 2)
        end,

        status = function(msg, player)
            cuhFramework.ui.notifications.custom(miscellaneousLibrary.surround(config.info.server_name, "[]").." Status", msg, player, 11)
        end
    },

	reminder = function(msg)
        cuhFramework.ui.notifications.custom(miscellaneousLibrary.surround(config.info.server_name, "[]").." Reminder", msg, nil, 8)
	end,

    discordAnnounce = function(msg, who, emoji)
        serverLinkLibrary.send_data("custom_message", who, msg, emoji)
    end,

    popupAnnounce = function(text, timer)
        if announcementRemovalDelay then
            announcementRemovalDelay:remove()
        end

        local announce_ui = cuhFramework.ui.screen.create(2500, text, 0, 0)
        announcementRemovalDelay = cuhFramework.utilities.delay.create(timer or 10, function()
            announce_ui:remove()
        end)
    end
}

-----------------
-- [Library | Folder: p1_libraries] cleanup.lua
-----------------
---------------------------------------
------------- Cleanup
---------------------------------------

------------- Variables
cleanup_exceptions = {}
cleanup_exceptions_obj_types = {}
cleanup_previous_obj = nil

------------- Library
cleanupLibrary = {
    clearObjects = function()
        -- first time
        if not cleanup_previous_obj then
            cleanup_previous_obj = cuhFramework.objects.spawnObject(matrix.translation(0, 0, 0), 100)
        end

        -- just in case
        if not cleanup_previous_obj then
            return
        end

        local new = cuhFramework.objects.spawnObject(matrix.translation(0, 0, 0), 100)

        if not new then
            return
        end

        if cleanup_previous_obj.properties.object_id > new.properties.object_id then
            return
        end

        for i = cleanup_previous_obj.properties.object_id, new.properties.object_id do
           -- get object data
           local obj_data = server.getObjectData(i)

           -- make sure object type isnt in object type exceptions
           if obj_data then
               if cleanup_exceptions_obj_types[obj_data.object_type] then
                   goto continue
               end
           end

           -- despawn
           if not cleanup_exceptions[i] then
               cuhFramework.objects.despawnObject(i)
           end

           -- continue
           ::continue::
       end

       cleanup_previous_obj = cuhFramework.objects.spawnObject(matrix.translation(0, 0, 0), 100)
   end,

   add_object_type_exception = function(id)
       cleanup_exceptions_obj_types[id] = true
   end,

   add_exception = function(id)
       cleanup_exceptions[id] = true
   end
}

-----------------
-- [Library | Folder: p1_libraries] color.lua
-----------------
---------------------------------------
------------- Color
---------------------------------------

------------- Library
colorLibrary = {
    RGB = {
        basicColors = {
            red = {
                h = 0,
                s = 100,
                v = 100,
                a = 255
            },

            green = {
                h = 120,
                s = 100,
                v = 100,
                a = 255
            },

            blue = {
                h = 240,
                s = 100,
                v = 100,
                a = 255
            },
        },

        ---@return colorRGB
        new = function(r, g, b, a)
            return {
                r = r or 255,
                g = g or 255,
                b = b or 255,
                a = a or 255
            }
        end,

        ---@param color colorRGB
        unpack = function(color)
            return color.r, color.g, color.b, color.a
        end,

        ---@param color colorRGB
        ---@return colorHSV
        toHSV = function(color)
            local r, g b, a = colorLibrary.RGB.unpack(color)

            local max_val = math.max(r, g, b)
            local min_val = math.min(r, g, b)
            local delta = max_val - min_val
            local h, s, v

            if delta == 0 then
                h = 0
            elseif max_val == r then
                h = ((g - b) / delta) % 6
            elseif max_val == g then
                h = ((b - r) / delta) + 2
            elseif max_val == b then
                h = ((r - g) / delta) + 4
            end

            h = h * 60
            if h < 0 then
                h = h + 360
            end

            if max_val == 0 then
                s = 0
            else
                s = delta / max_val
            end

            v = max_val

            return colorLibrary.HSV.new(h, s, v, a)
        end
    },

    HSV = {
        basicColors = {
            red = {
                h = 0,
                s = 100,
                v = 100,
                a = 255
            },

            green = {
                h = 120,
                s = 100,
                v = 100,
                a = 255
            },

            blue = {
                h = 240,
                s = 100,
                v = 100,
                a = 255
            },
        },

        ---@return colorHSV
        new = function(h, s, v, a)
            return {
                h = h or 360,
                s = s or 100,
                v = v or 100,
                a = a or 255
            }
        end,

        ---@param color colorHSV
        unpack = function(color)
            return color.h, color.s, color.v, color.a
        end,

        ---@param color colorHSV
        ---@return colorRGB
        toRGB = function(color)
            local h, s, v, a = colorLibrary.HSV.unpack(color)

            local c = v * s
            local x = c * (1 - math.abs((h / 60) % 2 - 1))
            local m = v - c
            local r, g, b

            if h < 60 then
                r, g, b = c, x, 0
            elseif h < 120 then
                r, g, b = x, c, 0
            elseif h < 180 then
                r, g, b = 0, c, x
            elseif h < 240 then
                r, g, b = 0, x, c
            elseif h < 300 then
                r, g, b = x, 0, c
            else
                r, g, b = c, 0, x
            end

            r, g, b = (r + m) * 255, (g + m) * 255, (b + m) * 255

            return colorLibrary.RGB.new(r, g, b, a)
        end
    },

    ---@param color colorRGB|colorHSV
    ---@return "rgb"|"hsv"|nil
    type = function(color)
        if not color.a then
            return
        end

        if color.r and color.g and color.b then
            return "rgb"
        elseif color.h and color.s and color.v then
            return "hsv"
        end
    end
}

-----------------
-- [Library | Folder: p1_libraries] cooldown.lua
-----------------
---------------------------------------
------------- Cooldown
---------------------------------------

------------- Variables
local cooldowns = {}

------------- Library
cooldownLibrary = {
    ---@param key any
    new = function(key, duration)
        cooldowns[key] = {
            delay = cuhFramework.utilities.delay.create(duration, function()
                cooldownLibrary.remove(key)
            end)
        }
    end,

    hasCooldown = function(key)
        return cooldowns[key] ~= nil
    end,

    remove = function(key)
        if cooldowns[key] then
            cooldowns[key].delay:remove()
        end

        cooldowns[key] = nil
    end
}

-----------------
-- [Library | Folder: p1_libraries] database.lua
-----------------
---------------------------------------
------------- Database
---------------------------------------

------------- Library
databaseLibrary = {
    ---@param player player
    field_name = function(field_name, player)
        df.print("(databaseLibrary.field_name) field: "..field_name.." | player: "..player.properties.name)
        return field_name.."_"..tostring(player.properties.steam_id)
    end,

	set = function(field_name, value, codename)
        df.print("(databaseLibrary.set) args: "..table.concat({field_name, value, codename}, ", "))
        cuhFramework.http.get("/database/"..cuhFramework.http.url_encode(codename or config.databaseCodename)..("/set?fieldname=%s&value=%s&key=%s"):format(cuhFramework.http.url_encode(field_name), cuhFramework.http.url_encode(value), cuhFramework.http.url_encode(config.databaseKey)), config.databasePort)
    end,

    get = function(field_name, callback, codename)
        df.print("(databaseLibrary.get) args: "..table.concat({field_name, codename or config.databaseCodename}, ", "))

        cuhFramework.http.get("/database/"..cuhFramework.http.url_encode(codename or config.databaseCodename)..("/get?fieldname=%s&key=%s"):format(cuhFramework.http.url_encode(field_name), cuhFramework.http.url_encode(config.databaseKey)), config.databasePort, function(response)
            if not cuhFramework.http.ok(response) then
                return callback(nil)
            end

            callback(response)
        end)
    end,

    remove = function(field_name, codename)
        df.print("(databaseLibrary.remove) args: "..table.concat({field_name, codename}, ", "))
        cuhFramework.http.get("/database/"..cuhFramework.http.url_encode(codename or config.databaseCodename)..("/remove?fieldname=%s&key=%s"):format(cuhFramework.http.url_encode(field_name), cuhFramework.http.url_encode(config.databaseKey)), config.databasePort)
    end,

    add = function(field_name, amount, codename)
        df.print("(databaseLibrary.remove) args: "..table.concat({field_name, amount, codename}, ", "))
        cuhFramework.http.get("/database/"..cuhFramework.http.url_encode(codename or config.databaseCodename)..("/add?fieldname=%s&value=%s&key=%s"):format(cuhFramework.http.url_encode(field_name), cuhFramework.http.url_encode(amount), cuhFramework.http.url_encode(config.databaseKey)), config.databasePort)
    end,

    subtract = function(field_name, amount, codename)
        df.print("(databaseLibrary.remove) args: "..table.concat({field_name, amount, codename}, ", "))
        cuhFramework.http.get("/database/"..cuhFramework.http.url_encode(codename or config.databaseCodename)..("/subtract?fieldname=%s&value=%s&key=%s"):format(cuhFramework.http.url_encode(field_name), cuhFramework.http.url_encode(amount), cuhFramework.http.url_encode(config.databaseKey)), config.databasePort)
    end,

    ---@param player player
    basicChecks = function(player, response)
        df.print("(databaseLibrary.basicChecks) "..player.properties.name.." - checking "..tostring(response))

        -- player doesnt exist anymore
        if not cuhFramework.players.getPlayerByPeerId(player.properties.peer_id) then
            return false
        end

        -- database server offline
        if not response then
            return false
        end

        -- success
        return true
    end
}

-- ERR: anywhere in the code giving non-number as amount param?

-----------------
-- [Library | Folder: p1_libraries] debounce.lua
-----------------
---------------------------------------
------------- Debounce
---------------------------------------

------------- Variables
---@type table<string, boolean>
local debounces = {}

------------- Library
debounceLibrary = {
    ---@param key any
    debounce = function(key, duration)
        -- debounce in progress, so return true
        if debounces[key] then
            return true
        end

        -- add debounce
        debounces[key] = true

        -- remove after some time
        cuhFramework.utilities.delay.create(duration, function()
            debounces[key] = nil
        end)

        -- return false
        return false
    end,

    getAll = function()
        return debounces
    end
}

-----------------
-- [Library | Folder: p1_libraries] debug.lua
-----------------
---------------------------------------
------------- Debug
---------------------------------------

------------- Variables
local debug_addon_name = "Debug library hasn't been initialized."

------------- Library
debugLibrary = {
    initialize = function()
        -- set addon name
        local index = server.getAddonIndex()
        debug_addon_name = server.getAddonData(index).name

        -- alive loop
        cuhFramework.utilities.loop.create(1, function()
            df.print("alive")
        end)

        -- check
        if not debugLibrary.debugEnabled() then
            return
        end

        -- inject into callbacks (ERR: breaks addon)
        -- for i, v in pairs(cuhFramework.callbacks) do
        --     if i == "onTick" then
        --         goto continue
        --     end
        --     df.printTbl(v)

        --     v:connect(function(...)
        --         df.print("cuhframework callback - "..i.." | called with args: "..cuhFramework.utilities.table.tostringValues({...}))
        --     end)

        --     ::continue::
        -- end
    end,

    debugEnabled = function()
        return config.debugEnabled
    end,

    error = function(source, msg, ...)
        df.print(("(%s)"):format(source).." | ERR: "..msg:format(...))
    end,

    print = function(toPrint, disableSep)
        if not debugLibrary.debugEnabled() then
            return
        end

        toPrint = tostring(toPrint)
        toPrint = "DEBUG "..config.info.server_name.." - "..debug_addon_name.." - "..toPrint..cuhFramework.utilities.miscellaneous.switchbox("\n-----------------", "", disableSep)

        if config.debugShouldLog then
            debug.log(toPrint)
        else
            chatAnnounce(toPrint)
        end
    end,

    printTbl = function(tbl, indent)
        if not indent then
            indent = 0
        end

        for i, v in pairs(tbl) do
            formatting = string.rep("  ", indent)..i..": "

            if type(v) == "table" then
                df.print(formatting, true)
                df.printTbl(v, indent + 1)
            else
                df.print(formatting..tostring(v), true)
            end
        end
    end
}

df = debugLibrary

-----------------
-- [Library | Folder: p1_libraries] disasters.lua
-----------------
---------------------------------------
------------- Disasters
---------------------------------------

------------- Variables
---@type table<string, disaster>
local disasters = {}

---@type table<integer, disaster>
local randomDisasters = {}

------------- Library
disastersLibrary = {
    initialize = function()
        -- create events
        disasterStart = eventsLibrary.new("disaster_Start")
        disasterStop= eventsLibrary.new("disaster_Stop")
    end,

    disaster = {
        getAll = function()
            return disasters
        end,

        ---@param disaster disaster
        ---@param position SWMatrix
        start = function(disaster, position)
            -- fire events
            disasterStart:fire(disaster, position)

            -- start the disaster
            disaster:startCallback(position)

            cuhFramework.utilities.delay.create(disaster.delay, function()
                -- stop the disaster
                disaster:stopCallback(position)

                -- and fire events again
                disasterStop:fire(disaster, position)
            end)
        end,

        create = function(name, startCallback, stopCallback, delay)
            disasters[name] = {
                name = name,
                startCallback = startCallback,
                stopCallback = stopCallback,
                delay = delay
            }

            table.insert(randomDisasters, disasters[name])

            return disasters[name]
        end,

        get = function(name)
            return disasters[name]
        end,

        getRandomDisaster = function()
            return cuhFramework.utilities.table.getRandomValue(randomDisasters)
        end
    }
}

-----------------
-- [Library | Folder: p1_libraries] easyPopups.lua
-----------------
---------------------------------------
------------- Easy Popups
---------------------------------------

------------- Variables
local popups = {
    ---@type table<number, physicalPopup>
    physical = {}
}

------------- Library
easyPopupsLibrary = {
    initialize = function()
        cuhFramework.callbacks.onPlayerLeave:connect(function(_, _, peer_id)
            local player = cuhFramework.players.getPlayerByPeerId(peer_id)

            if not player then
                return
            end

            for i, v in pairs(popups.physical) do
                if v.properties.player == player then
                    v:remove()
                end
            end
        end)
    end,

    physical = {
        ---@param attach number|nil 0, nil or object id/vehicle id
        ---@param player player
        create = function(text, pos, attach, id, player, renderDistance)
            -- defaults
            if not renderDistance then
                renderDistance = 15
            end

            if not attach then
                attach = 0
            end

            -- get object_id/vehicle_id
            local idType = miscellaneousLibrary.isVehicleOrObject(attach)
            local obj_id = 0
            local veh_id = 0

            if idType == "object" then
                obj_id = attach
            elseif idType == "vehicle" then
                veh_id = attach
            end

            -- set data
            popups.physical[id] = {
                properties = {
                    text = text,
                    pos = pos,
                    id = id,
                    player = player,
                    shownForAll = player == nil,
                    renderDistance = renderDistance,
                    visible = true,

                    obj_id = obj_id,
                    veh_id = veh_id
                },

                ---@param self physicalPopup
                setVisibility = function(self, new)
                    self.properties.visible = new
                    self:refresh()
                end,

                ---@param self physicalPopup
                refresh = function(self)
                    server.setPopup(easyPopupsLibrary.miscellaneous.getTarget(self.properties.player), self.properties.id, "", self.properties.visible, self.properties.text, self.properties.pos[13], self.properties.pos[14], self.properties.pos[15], self.properties.renderDistance, self.properties.veh_id, self.properties.obj_id)
                end,

                ---@param self physicalPopup
                edit = function(self, newText, newPos, newAttach, newPlayer, newRenderDistance)
                    self.properties.text = newText or self.properties.text
                    self.properties.pos = newPos or self.properties.pos
                    self.properties.player = newPlayer or self.properties.player
                    self.properties.renderDistance = newRenderDistance or self.properties.renderDistance

                    if not newAttach then
                        return
                    end

                    local new_idType = miscellaneousLibrary.isVehicleOrObject(newAttach)
                    local new_obj_id = 0
                    local new_veh_id = 0

                    if new_idType == "object" then
                        new_obj_id = attach
                    elseif new_idType == "vehicle" then
                        new_veh_id = attach
                    end

                    self.properties.obj_id = new_obj_id
                    self.properties.veh_id = new_veh_id

                    self:refresh()
                end,

                ---@param self physicalPopup
                remove = function(self)
                    return easyPopupsLibrary.physical.remove(self.properties.id)
                end
            }

            -- show
            popups.physical[id]:refresh()

            -- return
            return popups.physical[id]
        end,

        remove = function(id)
            local data = popups.physical[id]

            if not data then
                return df.error("easyPopupsLibrary.physical.remove", "failed to remove physical popup because id is invalid oops. id = %s", id)
            end

            server.removePopup(easyPopupsLibrary.miscellaneous.getTarget(data.properties.player), id)

            popups.physical[id] = nil
        end,

        get = function(id)
            return popups.physical[id]
        end,

        getAll = function()
            return popups.physical
        end
    },

    miscellaneous = {
        ---@param player player|nil
        getTarget = function(player)
            if player then
                return player.properties.peer_id
            else
                return -1
            end
        end
    }
}

-----------------
-- [Library | Folder: p1_libraries] events.lua
-----------------
---------------------------------------
------------- Events
---------------------------------------

------------- Variables
---@type table<string, event>
local events = {}

------------- Library
eventsLibrary = {
    initialize = function()
        -- debug
        if not df.debugEnabled() then
            return
        end

        local handled = {}

        cuhFramework.utilities.loop.create(5, function()
            for i, v in pairs(events) do
                if not handled[v.name] then
                    handled[v.name] = true

                    v:connect(function(...)
                        local args = {...}
                        df.print(v.name.." (event) - fired with args: "..table.concat(cuhFramework.utilities.table.tostringValues(args), ", "))
                    end)
                end
            end
        end)
    end,

    new = function(name)
        events[name] = {
            name = name,
            connections = {},

            connect = function(self, func)
                table.insert(self.connections, func)
            end,

            fire = function(self, ...)
                for i, v in pairs(self.connections) do
                    v(...)
                end
            end,

            remove = function(self)
                return eventsLibrary.remove(self.name)
            end
        }

        return events[name]
    end,

    get = function(name)
        return events[name]
    end,

    remove = function(name)
        events[name] = nil
    end,

    getAll = function()
        return events
    end
}

-----------------
-- [Library | Folder: p1_libraries] inventory.lua
-----------------
---------------------------------------
------------- Inventory
---------------------------------------

------------- Variables
---@type table<string, inventory>
local inventories = {}

---@type table<string, item>
local items = {}

------------- Library
inventoryLibrary = {
    items = {
        new = function(name, equipment_id, int, float, slot)
            items[name] = {
                name = name,
                equipment_id = equipment_id,
                int = int,
                float = float,
                slot = slot
            }

            return inventoryLibrary.items.get(name)
        end,

        get = function(name)
            return items[name]
        end,

        getAll = function()
            return items
        end
    },

    inventories = {
        new = function(name, ...)
            inventories[name] = {
                properties = {
                    items = {...},
                    name = name
                },

                ---@param self inventory
                ---@param player player
                give = function(self, player)
                    for i, v in pairs(self.properties.items) do
                        player:give_item(v.slot, v.equipment_id, v.int, v.float)
                    end
                end,

                ---@param self inventory
                remove = function(self)
                    return inventoryLibrary.inventories.remove(self)
                end,

                ---@param self inventory
                itemsToNamesInTable = function(self)
                    local itemNames = {}

                    for i, v in pairs(self.properties.items) do
                        itemNames[i] = v.name .." [Slot "..v.slot.."]"
                    end

                    return itemNames
                end
            }

            return inventoryLibrary.inventories.get(name)
        end,

        get = function(name)
            return inventories[name]
        end,

        ---@param inventory inventory
        remove = function(inventory)
            inventories[inventory.properties.name] = nil
        end,

        getAll = function()
            return inventories
        end
    }
}

-----------------
-- [Library | Folder: p1_libraries] levels.lua
-----------------
---------------------------------------
------------- Levels
---------------------------------------

------------- Library
levelsLibrary = {
    ---@param player player
    get = function(player, get_callback)
        databaseLibrary.get(databaseLibrary.field_name("level", player), function(level)
            -- check
            if not databaseLibrary.basicChecks(player, level) then
                return
            end

            -- no money data, so give starting level
            if level == "None" then
                levelsLibrary.set(player, 1)
                return get_callback(1)
            end

            -- not a number
            if not tonumber(level) then
                return chatAnnounce("The addon failed to grab your level. Please report this to the developers in the Discord.", player)
            end

            -- activate callback
            get_callback(tonumber(level))
        end)
    end,

    ---@param player player
    set = function(player, value)
        -- enforce limit
        levelsLibrary.get(player, function(level)
            if level + value >= config.game.maxLevel then -- dont wanna go any higher than the limit
                return databaseLibrary.set(databaseLibrary.field_name("level", player), config.game.maxLevel)
            end

            databaseLibrary.set(databaseLibrary.field_name("level", player), value)
        end)
    end,

    ---@param player player
    increase = function(player, amount)
        -- enforce limit
        levelsLibrary.get(player, function(level)
            if level >= config.game.maxLevel then -- dont wanna go any higher than the limit
                return
            end

            databaseLibrary.add(databaseLibrary.field_name("level", player), amount)
        end)
    end,

    ---@param player player
    decrease = function(player, amount)
        databaseLibrary.subtract(databaseLibrary.field_name("level", player), amount)
    end,

    format = function(level, isLevelUp)
        local num_level = tonumber(level)

        if not num_level then
            df.print("Failed to format level: "..level)
            return "Level 0"
        end

        if isLevelUp then
            return level.." Level(s)"
        else
            return "Level "..math.floor(level)
        end
    end
}

-----------------
-- [Library | Folder: p1_libraries] matrix.lua
-----------------
---------------------------------------
------------- Matrix
---------------------------------------

------------- Library
matrix.add = function(matrix1, matrix2)
    local new = matrix.translation(0, 0, 0)

    for i, v in pairs(new) do
        if matrix1[i] and matrix2[i] then
            new[i] = matrix1[i] + matrix2[i]
        end
    end

    return new
end

-----------------
-- [Library | Folder: p1_libraries] miscellaneous.lua
-----------------
---------------------------------------
------------- Miscellaneous
---------------------------------------

------------- Library
miscellaneousLibrary = {
    indentTable = function(tbl, indent)
        if not indent then
            indent = 0
        end

        for i, v in pairs(tbl) do
            if type(v) == "string" then
                tbl[i] = (" "):rep(indent)..v
            end
        end

        return tbl
    end,

    ---@return string
    surround = function(input, with)
        return with:sub(1, 1)..input..with:sub(-1, -1)
    end,

    stringBeforeAfter = function(before, string, after)
        return before..string..after
    end,

    aOrAn = function(str)
        local first_character = str:sub(1, 1):lower()

        if ("aeiou"):find(first_character:lower()) then
            return "an "
        end

        return "a "
    end,

    ---@param player player
    unnamedClientOrServerOrDisconnecting = function(player, dontCheckDisconnecting)
        return (player.properties.peer_id == 0 and config.isDedicatedServer or player.properties.steam_id == 0) or (player.properties.disconnecting and not dontCheckDisconnecting)
    end,

    ---@param pos SWMatrix
    matrixFormatted = function(pos)
        return cuhFramework.utilities.number.round(pos[13], 1)..", "..cuhFramework.utilities.number.round(pos[14], 1)..", "..cuhFramework.utilities.number.round(pos[15], 1)
    end,

    getPlayerCount = function()
        local count = 0

        for _, v in pairs(cuhFramework.players.connectedPlayers) do
            if not miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(v) then
                count = count + 1
            end
        end

        df.print("player count - "..count)

        return count
    end,

    pluralOrSingular = function(input)
        if tonumber(input) == 1 then
            return ""
        else
            return "s"
        end
    end,

    ---@return "object"|"vehicle"|nil
    isVehicleOrObject = function(id)
        local _, is_obj = server.getObjectData(id)
        local _, is_vehicle = server.getVehicleData(id)

        if is_vehicle then
            return "vehicle"
        else
            return "object"
        end
    end,

    groupCall = function(functions, ...)
        for i, v in pairs(functions) do
            v(...)
        end
    end,

    addCommas = function(number)
        local formatted = tostring(number)
        local k = 3

        while true do
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2', k)

            if k == 0 then
                break
            end
        end

        return formatted
    end,

    globalOffsetPos = function(pos, x, y, z)
        return matrix.translation(pos[13] + x, pos[14] + y, pos[15] + z)
    end,

    tableToString = function(tbl)
        local str = {}
        local indent = 0

        function check(t)
            indent = indent + 2

            for i, v in pairs(t) do
                table.insert(str, string.rep(" ", indent)..i.." - "..tostring(v))

                if type(v) == "table" then
                    check(v)
                end
            end
        end

        check(tbl)
        return table.concat(str, "\n")
    end,

    ---@param input string
    strToName = function(input)
        return input:sub(1, 1):upper()..input:sub(2, -1):lower()
    end,

    percentageOfNumber = function(number, percentage)
        return number * (percentage / 100)
    end
}

-----------------
-- [Library | Folder: p1_libraries] missions.lua
-----------------
---------------------------------------
------------- Missions
---------------------------------------

------------- Variables
---@type table<integer, mission>
local missions = {}

---@type table<integer, missionType>
local missionTypes = {}

------------- Library
missionLibrary = {
    ------------- Init
    initialize = function()
        -- create events
        globalOnStart = eventsLibrary.new("mission_globalOnStart")
        globalOnCompletion = eventsLibrary.new("mission_globalOnCompletion")
        globalOnCancellation = eventsLibrary.new("mission_globalOnCancellation")
        globalAvailabilityChanged = eventsLibrary.new("mission_globalAvailabilityChanged")
        globalOnCreation = eventsLibrary.new("mission_globalOnCreation")
        globalOnRemoval = eventsLibrary.new("mission_globalOnRemoval")

        -- keep mission npcs safe
        cuhFramework.utilities.loop.create(10, function()
            for i, v in pairs(missionLibrary.miscellaneous.getAllMissions()) do
                -- get npc
                ---@type npc
                local npc = v.properties.storage:get("npc")

                -- if npc exists, teleport to mission start position, as well as revive the npc
                if npc then
                    server.reviveCharacter(npc.properties.character.properties.object_id)
                    npc.properties.character:damage(-100)
                    npc.properties.character:teleport(v.properties.startPosition)
                end
            end
        end)

        -- teleport destination markers
        cuhFramework.utilities.loop.create(0.01, function()
            for i, v in pairs(missions) do
                if v.properties.destinationMarker and v.properties.available then
                    v.properties.destinationMarker:teleport(v.properties.completionPosition)
                end
            end
        end)
    end,

    ------------- Types
    types = {
        ---@param color colorRGB|colorHSV|nil
        create = function(name, onStart, onCompletion, onCancellation, availabilityChanged, onCreation, onRemoval, color)
            missionTypes[name] = {
                onStart = onStart or function() end,
                onCompletion = onCompletion or function() end,
                onCancellation = onCancellation or function() end,
                availabilityChanged = availabilityChanged or function() end,
                onCreation = onCreation or function() end,
                onRemoval = onRemoval or function() end,

                name = name,
                color = color or colorLibrary.RGB.new(255, 255, 255, 255)
            }

            return missionTypes[name]
        end,

        get = function(name)
            return missionTypes[name]
        end
    },

    ------------- Main
   main = {
    ---@param reward minMax|number
        create = function(name, description, startPosition, completionPosition, activationRadius, missionType, shouldCancelOnCompletion, timeUntilAvailableAgain,  reward, levelToGiveOnCompletion, minimumLevel)
            -- check
            if type(reward) == "table" then
                reward = minMax(reward)
            end

            -- set data
            local mission_id = cuhFramework.utilities.table.getValueCountOfTable(missions)

            missions[name] = {
                properties = {
                    name = name,
                    description = description,
                    startPosition = startPosition,
                    activationRadius = activationRadius,
                    completionPosition = completionPosition,
                    type = missionType,
                    storage = storageLibrary.new("mission_"..name),
                    cancelsOnCompletion = shouldCancelOnCompletion,
                    timeUntilAvailableAgain = timeUntilAvailableAgain,
                    reward = reward,
                    mission_id = mission_id,
                    available = true,
                    levelToGiveOnCompletion = levelToGiveOnCompletion or 0.5,
                    minimumLevel = minimumLevel or 1,

                    attach = 0,
                    isAttachedVehicle = false,

                    destinationMarker = cuhFramework.objects.spawnObject(completionPosition, 71), -- glowstick

                    popup = easyPopupsLibrary.physical.create("", cuhFramework.utilities.matrix.offsetPosition(startPosition, 0, 15, 0), nil, mission_id + 5000, nil, 100),

                    partakingPlayers = {},

                    internal = {
                        refreshLoop = cuhFramework.utilities.loop.create(0.5, function() -- removed refreshing map ui to hopefully fix map lag. map ui is refreshed in toggle map callback instead
                            local data = missions[name]

                            if not data then
                                return
                            end

                            data:refreshUI()
                        end)
                    }
                },

                events = {
                    onStart = eventsLibrary.new("mission_"..name.."_onStart"),
                    onCompletion = eventsLibrary.new("mission_"..name.."_onCompletion"),
                    onCancellation = eventsLibrary.new("mission_"..name.."_onCancellation"),
                    availabilityChanged = eventsLibrary.new("mission_"..name.."_availabilityChanged"),
                    onCreation = eventsLibrary.new("mission_"..name.."_onCreation"),
                    onRemoval = eventsLibrary.new("mission_"..name.."_onRemoval")
                },

                ---@param self mission
                ---@param player player
                start = function(self, player)
                    -- quick check to see if the player has already started this mission
                    if missionLibrary.miscellaneous.isPlayerPartakingInMission(player, self) then
                        return
                    end

                    -- and another check to see if the mission is unavailable or not
                    if not self.properties.available then
                        return
                    end

                    levelsLibrary.get(player, function(level)
                        -- check if level is high enough
                        if level < self.properties.minimumLevel then
                            return
                        end

                        -- add player into partaking players
                        self.properties.partakingPlayers[player.properties.peer_id] = player

                        -- fire events
                        self.events.onStart:fire(player, self)
                        self.properties.type.onStart(player, self)
                        globalOnStart:fire(player, self)
                    end)
                end,

                ---@param self mission
                ---@param player player|nil
                cancel = function(self, player)
                    if not player then
                        -- cancel for all
                        for i, v in pairs(self.properties.partakingPlayers) do
                            -- remove player from partaking players
                            self.properties.partakingPlayers[i] = nil

                            -- fire events
                            self.events.onCancellation:fire(v, self)
                            self.properties.type.onCancellation(v, self)
                            globalOnCancellation:fire(v, self)
                        end
                    else
                        -- cancel for this player
                        -- quick check to see if the player hasn't started this mission
                        if not missionLibrary.miscellaneous.isPlayerPartakingInMission(player, self)then
                            return df.print("mission:cancel() | player is not partaking in a mission")
                        end

                        -- remove player from partaking players
                        self.properties.partakingPlayers[player.properties.peer_id] = nil

                        -- fire events
                        self.events.onCancellation:fire(player, self)
                        self.properties.type.onCancellation(player, self)
                        globalOnCancellation:fire(player, self)
                    end
                end,

                ---@param self mission
                ---@param player player
                complete = function(self, player)
                    -- quick check to see if the player hasn't started this mission
                    if not missionLibrary.miscellaneous.isPlayerPartakingInMission(player, self) then
                        return
                    end

                    -- remove player from partaking players
                    self.properties.partakingPlayers[player.properties.peer_id] = nil

                    -- make mission on longer available if cancelsOnCompletion is true
                    if self.properties.cancelsOnCompletion then
                        cuhFramework.utilities.delay.create(10, function()
                            self:setAvailability(false)

                            cuhFramework.utilities.delay.create(self.properties.timeUntilAvailableAgain, function()
                                self:setAvailability(true)
                            end)
                        end)
                    end

                    -- fire events
                    self.events.onCompletion:fire(player, self)
                    self.properties.type.onCompletion(player, self)
                    globalOnCompletion:fire(player, self)
                end,

                ---@param self mission
                remove = function(self)
                    return missionLibrary.main.remove(self.properties.name)
                end,

                ---@param self mission
                setAvailability = function(self, state)
                    -- quick check
                    if self.properties.available == state then
                        return
                    end

                    -- actually set availability
                    self.properties.available = state

                    -- since we are setting the mission to not available, cancel the mission for all players
                    if not state then
                        self:cancel()
                    end

                    -- fire events
                    self.events.availabilityChanged:fire(self, state)
                    self.properties.type.availabilityChanged(self, state)
                    globalAvailabilityChanged:fire(self, state)
                end,

                ---@param self mission
                refreshUI = function(self)
                    -- hide mission popup, but if should show, then reveal mission popup
                    self.properties.popup:setVisibility(true)
                    self.properties.popup:edit(self.properties.name.."\n"..moneyLibrary.format(self.properties.reward).."\n\nType '?start'\n\n[Mission]"..cuhFramework.utilities.miscellaneous.switchbox("\n[Unavailable]", "", self.properties.available))
                end,

                ---@param self mission
                ---@param player player
                refreshMapUI = function(self, player, show)
                    -- get ui id
                    local ui_id = self.properties.mission_id + 5200

                    -- get peer_id
                    local peer_id = easyPopupsLibrary.miscellaneous.getTarget(player)

                    -- very messy, but remove ui stuffs
                    server.removeMapID(peer_id, ui_id)

                    -- and dont add ui stuffs if shouldnt show
                    if not show then
                        return
                    end

                    ------------- get color
                    local r, g, b, a = 255, 255, 255, 255

                    if colorLibrary.type(self.properties.type.color) == "rgb" then
                        r, g, b, a = colorLibrary.RGB.unpack(self.properties.type.color)
                    elseif colorLibrary.type(self.properties.type.color) == "hsv" then
                        r, g, b, a = colorLibrary.RGB.unpack(colorLibrary.HSV.toRGB(self.properties.type.color))
                    end

                    ------------- get pos type
                    local pos_type = 0
                    local obj_id = 0
                    local veh_id = 0

                    -- check
                    if self.properties.attach == 0 then -- no need to change if no vehicle/obj to attach map ui to
                        goto skip
                    end

                    if self.properties.isAttachedVehicle then
                        -- vehicle
                        pos_type = 2
                        veh_id = self.properties.attach
                    else
                        -- object
                        pos_type = 1
                        obj_id = self.properties.attach
                    end

                    ::skip::

                    ------------- map ui
                    -- line
                    server.addMapLine(
                        peer_id,
                        ui_id,
                        self.properties.startPosition,
                        self.properties.completionPosition,
                        0.5,
                        r, g, b, a
                    )

                    -- start point
                    local hover_label = missionLibrary.miscellaneous.formatMissionBasicsIntoString(self, 0)
                    server.addMapObject(
                        peer_id,
                        ui_id,
                        0,
                        2,
                        self.properties.startPosition[13], self.properties.startPosition[15],
                        nil, nil, nil, nil,
                        self.properties.name,
                        self.properties.activationRadius,
                        hover_label.."\n\n(START)",
                        r, g, b, a
                    )

                    -- destination point
                    server.addMapObject(
                        peer_id,
                        ui_id,
                        pos_type,
                        10,
                        self.properties.completionPosition[13],
                        self.properties.completionPosition[15],
                        nil, nil, veh_id, obj_id,
                        self.properties.name,
                        30,
                        hover_label.."\n\n(DESTINATION)",
                        r, g, b, a
                    )

                    -- mission details at start point
                    server.addMapLabel(peer_id, ui_id, 4, missionLibrary.miscellaneous.formatMissionDetailsIntoString(self), self.properties.startPosition[13] + 20, self.properties.startPosition[15])
                end,

                ---@param self mission
                createNPC = function(self, npcName, npcType)
                    self.properties.storage:add("npc", npcLibrary.new(npcName, self.properties.startPosition, npcType))
                end,

                ---@param self mission
                getNPC = function(self)
                    return self.properties.storage:get("npc")
                end,

                ---@param self mission
                ---@param vehicle vehicle
                attach = function(self, obj_id, vehicle)
                    self.properties.isAttachedVehicle = vehicle ~= nil

                    if obj_id then
                        self.properties.attach = obj_id
                        return
                    else
                        self.properties.attach = vehicle.properties.vehicle_id
                        return
                    end
                end,

                ---@param self mission
                detach = function(self)
                    self.properties.attach = 0
                    self.properties.isAttachedVehicle = false
                end
            }

            -- setup stuffs
            local data = missions[name]
            if data.properties.destinationMarker then
                data.properties.destinationMarker:set_tooltip(data.properties.name.." - Destination")
                cleanupLibrary.add_exception(data.properties.destinationMarker.properties.object_id)
            end

            -- fire onCreation events
            data.events.onCreation:fire(data)
            data.properties.type.onCreation(data)
            eventsLibrary.get("mission_globalOnCompletion"):fire(data)

            -- return mission
            return missions[name]
        end,

        remove = function(name)
            -- get the actual mission
            local data = missions[name]

            -- quick check
            if not data then
                return df.error("missionsLibrary.remove", "attempted to remove mission with name: %s", name)
            end

            -- fire events
            data.events.onRemoval:fire(data)
            data.properties.type.onRemoval(data)
            globalOnRemoval:fire(data)

            -- cancel the mission for all players
            data:cancel()

            -- remove/hide ui
            data:refreshMapUI()
            data.properties.popup:remove()

            -- remove objects
            data.properties.destinationMarker:despawn()

            -- remove npc
            ---@type npc
            local npc = data:getNPC()

            if npc then
                npc:despawn()
            end

            -- remove events n shit
            for i, v in pairs(data.events) do
                v:remove() -- ERR: idk maybe, intellisense didnt get this correct
            end

            data.properties.internal.refreshLoop:remove() -- stop ui loop

            -- and finally, remove the mission data
            missions[name] = nil
        end,

        get = function(name)
            return missions[name]
        end
   },

    ------------- Miscellaneous
    miscellaneous = {
        getAllMissions = function()
            return missions
        end,

        getAllMissionTypes = function()
            return missionTypes
        end,

        ---@param mission mission
        formatMissionDetailsIntoString = function(mission, indent)
            -- get the deets and format em nicely
            local to_concatenate = {
                mission.properties.name.." "..miscellaneousLibrary.surround(mission.properties.type.name, "[]"),
                miscellaneousLibrary.surround("+"..moneyLibrary.format(mission.properties.reward), "[]").." | "..
                    miscellaneousLibrary.surround(levelsLibrary.format(mission.properties.levelToGiveOnCompletion, true), "[]")..
                    " | "..miscellaneousLibrary.surround(levelsLibrary.format(mission.properties.minimumLevel).."+ required", "[]")..
                    cuhFramework.utilities.miscellaneous.switchbox(
                        "",
                        "| "..miscellaneousLibrary.surround("This mission cancels upon completion", "[]"),
                        mission.properties.cancelsOnCompletion
                    ),
                mission.properties.description,
                "\\__"..table.concat(missionLibrary.miscellaneous.formatPlayersIntoTableOfNames(mission.properties.partakingPlayers), ", ")
            }

            -- and now return
            return table.concat(miscellaneousLibrary.indentTable(to_concatenate, indent), "\n")
        end,

        ---@param mission mission
        formatMissionBasicsIntoString = function(mission, indent)
            -- format the deets
            local to_concatenate = {
                mission.properties.name,
                miscellaneousLibrary.surround(mission.properties.type.name, "[]"),
                miscellaneousLibrary.surround("+"..moneyLibrary.format(mission.properties.reward), "[]").." | "..
                    miscellaneousLibrary.surround(levelsLibrary.format(mission.properties.levelToGiveOnCompletion, true), "[]"),
                miscellaneousLibrary.surround(levelsLibrary.format(mission.properties.minimumLevel).."+ required.", "[]")
            }

            -- anndd return
            return table.concat(miscellaneousLibrary.indentTable(to_concatenate, indent), "\n")
        end,

        ---@param players table<any, player>
        formatPlayersIntoTableOfNames = function(players)
            local list = {}

            for i, v in pairs(players) do
                table.insert(list, v.properties.name.." ["..v.properties.peer_id.."]")
            end

            if list[1] then
                return list
            else
                return {"No players."}
            end
        end,

        ---@param pos SWMatrix
        getMissionByPosition = function(pos)
            for i, v in pairs(missions) do
                if matrix.distance(v.properties.startPosition, pos) <= v.properties.activationRadius then
                    return v
                end
            end
        end,

        getMissionBySearch = function(input)
            for i, v in pairs(missions) do
                if v.properties.name:lower():find(input:lower()) then
                    return v
                end
            end
        end,

        ---@param player player
        isPlayerPartakingInAMission = function(player)
            for i, v in pairs(missions) do
                if missionLibrary.miscellaneous.isPlayerPartakingInMission(player, v) then
                    return true
                end
            end

            return false
        end,

        ---@param player player
        ---@param mission mission
        isPlayerPartakingInMission = function(player, mission)
            return mission.properties.partakingPlayers[player.properties.peer_id] ~= nil
        end,

        ---@param player player
        getMissionFromPlayer = function(player)
            for i, v in pairs(missions) do
                if missionLibrary.miscellaneous.isPlayerPartakingInMission(player, v) then
                    return v
                end
            end
        end
    }
}

-----------------
-- [Library | Folder: p1_libraries] money.lua
-----------------
---------------------------------------
------------- Money
---------------------------------------

------------- Library
moneyLibrary = {
    ---@param player player
    get = function(player, get_callback)
        databaseLibrary.get(databaseLibrary.field_name("money", player), function(money)
            -- check
            if not databaseLibrary.basicChecks(player, money) then
                return
            end

            -- no money data, so give starting money
            if money == "None" then
                moneyLibrary.set(player, config.game.startingMoney)
                return get_callback(config.game.startingMoney)
            end

            -- not a number
            if not tonumber(money) then
                return chatAnnounce("The addon failed to grab your money. Please report this to the developers in the Discord.", player)
            end

            -- activate callback
            get_callback(tonumber(money))
        end)
    end,

    ---@param player player
    set = function(player, value)
        databaseLibrary.set(databaseLibrary.field_name("money", player), value)
    end,

    ---@param player player
    remove = function(player)
        databaseLibrary.remove(databaseLibrary.field_name("money", player))
    end,

    ---@param player player
    add = function(player, amount)
        databaseLibrary.add(databaseLibrary.field_name("money", player), amount)
    end,

    ---@param player player
    subtract = function(player, amount)
        databaseLibrary.subtract(databaseLibrary.field_name("money", player), amount)
    end,

    format = function(money)
        local num_money = tonumber(money)

        if not num_money then
            return df.print("failed to tonumber money | input: "..tostring(money))
        end

        return "$"..miscellaneousLibrary.addCommas(cuhFramework.utilities.number.round(num_money, 1))
    end,

    compare = function(money, cost, yourMoneyReplacement, costReplacement)
        local first = yourMoneyReplacement or "Your money:"
        local second = costReplacement or "Cost:"
        return first.." "..moneyLibrary.format(money).."\n"..second.." "..moneyLibrary.format(cost)
    end
}

-----------------
-- [Library | Folder: p1_libraries] npc.lua
-----------------
---------------------------------------
------------- NPC
---------------------------------------

------------- Variables
---@type table<integer, npc>
local npcs = {}
local npcsRaw = {}

------------- Library
npcLibrary = {
    new = function(name, position, npcType)
        -- set data
        npcs[name] = {
            properties = {
                name = name,
                position = position,
                npcType = npcType,
                character = cuhFramework.characters.spawnCharacter(position, npcType),

                chatDelay = nil,
                storage = storageLibrary.new("npc_"..name)
            },

            ---@param self npc
            ---@param player player|nil
            chat = function(self, message, player)
                cuhFramework.chat.send_message(self.properties.name.." [NPC]", message, player) -- chat

                -- popup
                local target = -1

                if player then
                    target = player.properties.peer_id
                end

                if self.properties.chatDelay then
                    self.properties.chatDelay:remove() -- prevent interruptions
                end

                server.setPopup(target, self.properties.character.properties.object_id + 7500, "NPC_speak", true, self.properties.name.."\n[NPC]\n"..message, 0, 2, 0, 10, nil, self.properties.character.properties.object_id)
                self.properties.chatDelay = cuhFramework.utilities.delay.create(10, function() -- remove chat popup after some time
                    server.removePopup(-1, self.properties.character.properties.object_id + 7500)
                end)
            end,

            ---@param self npc
            despawn = function(self)
                return npcLibrary.remove(self)
            end
        }

        -- quick setup
        local data = npcLibrary.getNPCByName(name)

        if not data.properties.character then
            df.error("npcLibrary.new", "failed to spawn character")
            return data
        end

        table.insert(data, npcsRaw) -- for getRandomNPC()

        cuhFramework.utilities.delay.create(0.3, function() -- wait for npc object to load
            cleanupLibrary.add_exception(data.properties.character.properties.object_id)
            data.properties.character:set_character_data(100, false, false) -- so the character cannot be picked up
            data.properties.character:set_tooltip(name.." [NPC]") -- set tooltip of npc to the npc's name
        end)

        -- return
        return data
    end,

    getRandomNPC = function()
        return cuhFramework.utilities.table.getRandomValue(npcsRaw)
    end,

    getAll = function()
        return npcs
    end,

    getNPCByName = function(name)
        return npcs[name]
    end,

    getRandomName = function()
        return miscellaneousLibrary.strToName(cuhFramework.utilities.table.getRandomValue(npcLibrary.npcNames))
    end,

    ---@param npc npc
    remove = function(npc)
        -- remove chat popup
        if npc.properties.chatDelay and npc.properties.chatDelay.fire and npc.properties.chatDelay.remove then
            npc.properties.chatDelay:fire()
            npc.properties.chatDelay:remove()
        end

        -- despawn npc character
        if npc.properties.character then
            npc.properties.character:despawn()
        end

        -- finally, remove npc data
        npcs[npc.properties.name] = nil

        for i, v in pairs(npcsRaw) do
            if v.properties.name == npc.properties.name then
                table.remove(npcsRaw, i)
            end
        end
    end,

    npcType = {
        WORKER = 1,
        FISHING = 2,
        WAITER = 3,
        SWIMSUIT = 4,
        MILITARY = 5,
        OFFICE = 6,
        POLICE = 7,
        SCIENCE = 8,
        MEDICAL = 9,
        WETSUIT = 10,
        CIVILIAN = 11
    },

    npcNames = {
        "JAMES",
        "JOHN",
        "ROBERT",
        "MICHAEL",
        "WILLIAM",
        "DAVID",
        "RICHARD",
        "CHARLES",
        "JOSEPH",
        "THOMAS",
        "CHRISTOPHER",
        "DANIEL",
        "PAUL",
        "MARK",
        "DONALD",
        "GEORGE",
        "KENNETH",
        "STEVEN",
        "EDWARD",
        "BRIAN",
        "RONALD",
        "ANTHONY",
        "KEVIN",
        "JASON",
        "MATTHEW",
        "GARY",
        "TIMOTHY",
        "JOSE",
        "LARRY",
        "JEFFREY",
        "FRANK",
        "SCOTT",
        "ERIC",
        "STEPHEN",
        "ANDREW",
        "RAYMOND",
        "GREGORY",
        "JOSHUA",
        "JERRY",
        "DENNIS",
        "WALTER",
        "PATRICK",
        "PETER",
        "HAROLD",
        "DOUGLAS",
        "HENRY",
        "CARL",
        "ARTHUR",
        "RYAN",
        "ROGER",
        "JOE",
        "JUAN",
        "JACK",
        "ALBERT",
        "JONATHAN",
        "JUSTIN",
        "TERRY",
        "GERALD",
        "KEITH",
        "SAMUEL",
        "WILLIE",
        "RALPH",
        "LAWRENCE",
        "NICHOLAS",
        "ROY",
        "BENJAMIN",
        "BRUCE",
        "BRANDON",
        "ADAM",
        "HARRY",
        "FRED",
        "WAYNE",
        "BILLY",
        "STEVE",
        "LOUIS",
        "JEREMY",
        "AARON",
        "RANDY",
        "HOWARD",
        "EUGENE",
        "CARLOS",
        "RUSSELL",
        "BOBBY",
        "VICTOR",
        "MARTIN",
        "ERNEST",
        "PHILLIP",
        "TODD",
        "JESSE",
        "CRAIG",
        "ALAN",
        "SHAWN",
        "CLARENCE",
        "SEAN",
        "PHILIP",
        "CHRIS",
        "JOHNNY",
        "EARL",
        "JIMMY",
        "ANTONIO",
        "DANNY",
        "BRYAN",
        "TONY",
        "LUIS",
        "MIKE",
        "STANLEY",
        "LEONARD",
        "NATHAN",
        "DALE",
        "MANUEL",
        "RODNEY",
        "CURTIS",
        "NORMAN",
        "ALLEN",
        "MARVIN",
        "VINCENT",
        "GLENN",
        "JEFFERY",
        "TRAVIS",
        "JEFF",
        "CHAD",
        "JACOB",
        "LEE",
        "MELVIN",
        "ALFRED",
        "KYLE",
        "FRANCIS",
        "BRADLEY",
        "JESUS",
        "HERBERT",
        "FREDERICK",
        "RAY",
        "JOEL",
        "EDWIN",
        "DON",
        "EDDIE",
        "RICKY",
        "TROY",
        "RANDALL",
        "BARRY",
        "ALEXANDER",
        "BERNARD",
        "MARIO",
        "LEROY",
        "FRANCISCO",
        "MARCUS",
        "MICHEAL",
        "THEODORE",
        "CLIFFORD",
        "MIGUEL"
    }
}

-----------------
-- [Library | Folder: p1_libraries] playerStates.lua
-----------------
---------------------------------------
------------- Player States
---------------------------------------

------------- Variables
---@type table<string, table>
local playerStates = {}

------------- Library
playerStatesLibrary = {
    ---@param player player
	setState = function(player, state)
        if not playerStates[state] then
            playerStates[state] = {}
        end

        playerStates[state][player.properties.peer_id] = true
        return true
    end,

    ---@param player player
    removeState = function(player, state)
        if not playerStates[state] then
            playerStates[state] = {}
        end

        playerStates[state][player.properties.peer_id] = nil
        return true
    end,

    ---@param player player
    hasState = function(player, state)
        if not playerStates[state] then
            playerStates[state] = {}
            return false
        end

        return playerStates[state][player.properties.peer_id] ~= nil
    end,

    ---@param player player
    clearStates = function(player)
        for i, v in pairs(playerStates) do
            local state = playerStates[i]
            if state[player.properties.peer_id] then
                playerStatesLibrary.removeState(player, i)
            end
        end
    end,

    getAll = function()
        return playerStates
    end
}

-----------------
-- [Library | Folder: p1_libraries] reminders.lua
-----------------
---------------------------------------
------------- Reminders
---------------------------------------

------------- Variables
---@type table<any, reminder>
local reminders = {}

---@type table<integer, reminder>
local reminders_raw = {}

---@type table<string, reminderCategory>
local reminderCategories = {}

------------- Library
remindersLibrary = {
    reminder = {
        new = function(category, id, description)
            reminders[id] = {
                properties = {
                    id = id,
                    category = category,
                    description = description
                },

                ---@param self reminder
                remove = function(self)
                    return remindersLibrary.reminder.remove(self.properties.id)
                end,

                ---@param self reminder
                announce = function(self)
                    return remindersLibrary.reminder.announce(self)
                end
            }

            table.insert(reminders_raw, reminders[id])
            return remindersLibrary.reminder.get(id)
        end,

        remove = function(id)
            cuhFramework.utilities.table.removeValueFromTable(reminders_raw, reminders[id])
            reminders[id] = nil
        end,

        get = function(id)
            return reminders[id]
        end,

        getRandom = function()
            return cuhFramework.utilities.table.getRandomValue(reminders_raw)
        end,

        ---@param reminder reminder
        announce = function(reminder)
            announceLibrary.reminder(reminder.properties.description.."\n\\__Category: "..reminder.properties.category.properties.name)
            announceLibrary.discordAnnounce("\n"..reminder.properties.description, "[Category - "..reminder.properties.category.properties.name.."]", ":tickets: :grey_question:")
        end
    },

    category = {
        new = function(name)
            reminderCategories[name] = {
                properties = {
                    name = name
                },

                ---@param self reminderCategory
                newReminder = function(self, id, description)
                    return remindersLibrary.reminder.new(self, id, description)
                end
            }

            return remindersLibrary.category.get(name)
        end,

        get = function(name)
            return reminderCategories[name]
        end
    },

    misc = {
        getAll = function()
            return reminders
        end
    }
}

-----------------
-- [Library | Folder: p1_libraries] replenish.lua
-----------------
---------------------------------------
------------- Replenish
---------------------------------------

------------- Library
replenishLibrary = {
	vehicle = {
        ---@param vehicle vehicle
        repair = function(vehicle)
            vehicle:repair()
        end,

        ---@param vehicle vehicle
        refillTanks = function(vehicle)
            if not vehicle.properties.loaded then
                return
            end

            local data = vehicle.properties.loaded_vehicle_data
            for i, v in pairs(data.components.tanks) do
                server.setVehicleTank(vehicle.properties.vehicle_id, v.name, v.capacity, v.fluid_type)
            end
        end,

        ---@param vehicle vehicle
        recharge = function(vehicle)
            if not vehicle.properties.loaded then
                return
            end

            local data = vehicle.properties.loaded_vehicle_data
            for i, v in pairs(data.components.batteries) do
                server.setVehicleBattery(vehicle.properties.vehicle_id, v.name, 100)
            end
        end,

        ---@param vehicle vehicle
        resupplyAmmo = function(vehicle)
            if not vehicle.properties.loaded then
                return
            end

            local data = vehicle.properties.loaded_vehicle_data
            for i, v in pairs(data.components.guns) do
                server.setVehicleWeapon(vehicle.properties.vehicle_id, v.name, v.capacity)
            end
        end,
    }
}

-----------------
-- [Library | Folder: p1_libraries] resupplyStations.lua
-----------------
---------------------------------------
------------- Resupply Stations
---------------------------------------

------------- Variables
---@type table<string, resupplyStation>
local resupplyStations = {}

------------- Library
resupplyStationsLibrary = {
    initialize = function()
        -- resupply the resupply stations.. haha
        cuhFramework.utilities.loop.create(5, function()
            for i, v in pairs(resupplyStations) do
                v:replenish()
            end
        end)
    end,

    new = function(name, position)
        local vehicle = cuhFramework.vehicles.spawnAddonVehicle(config.playlistIds.RESUPPLY_STATION, position)

        if not vehicle then
            return
        end

        vehicle:set_tooltip("Resupply Station\n"..name)

        resupplyStations[name] = {
            properties = {
                position = position,
                name = name,
                vehicle = vehicle
            },

            ---@param self resupplyStation
            replenish = function(self)
                replenishLibrary.vehicle.refillTanks(self.properties.vehicle)
                replenishLibrary.vehicle.recharge(self.properties.vehicle)
                replenishLibrary.vehicle.resupplyAmmo(self.properties.vehicle)
            end,

            ---@param self resupplyStation
            remove = function(self)
                return resupplyStationsLibrary.remove(self.properties.name)
            end,

            ---@param self resupplyStation
            ---@param player player|nil
            refreshMapUI = function(self, player, shouldShow, dontDelete)
                if not dontDelete then
                    server.removeMapID(easyPopupsLibrary.miscellaneous.getTarget(player), 4002)
                end

                if not shouldShow then
                    return
                end

                return server.addMapObject(easyPopupsLibrary.miscellaneous.getTarget(player), 4002, 0, 11, self.properties.position[13], self.properties.position[15], 0, 0, 0, 0, "Resupply Station\n["..self.properties.name.."]", 25, "You can refuel/recharge your vehicles here.", 200, 255, 200, 255)
            end
        }

        local data = resupplyStations[name]
        return data
    end,

    get = function(name)
        return resupplyStations[name]
    end,

    remove = function(name)
        local data = resupplyStationsLibrary.get(name)

        if not data then
            return
        end

        data:refreshMapUI(nil, false) -- remove ui
        data.properties.vehicle:despawn() -- despawn
        resupplyStations[name] = nil
    end,

    getAll = function()
        return resupplyStations
    end
}

-----------------
-- [Library | Folder: p1_libraries] serverLink.lua
-----------------
---------------------------------------
------------- Server Link
---------------------------------------

------------- Library
serverLinkLibrary = {
    char_to_hex = function(str)
        return string.format("%%%02X", string.byte(str))
    end,

    url_encode = function(url)
        if not url then
            return "nil"
        end

        url = url:gsub("\n", "\r\n")
        url = url:gsub("([^%w _ %- . ~])", serverLinkLibrary.char_to_hex)
        url = url:gsub(" ", "+")

        return url
    end,

    send_data = function(event, target, content, custom_emoji)
        server.httpGet(config.serverLinkPort, "/server_link/"..config.serverLinkCodename.."/"..event.."/"..serverLinkLibrary.url_encode(target).."/"..serverLinkLibrary.url_encode(content).."/"..serverLinkLibrary.url_encode(custom_emoji))
    end
}

-----------------
-- [Library | Folder: p1_libraries] storage.lua
-----------------
---------------------------------------
------------- Storage
---------------------------------------

------------- Variables
---@type table<string, storage>
local storages = {}

------------- Library
storageLibrary = {
    new = function(name)
        storages[name] = {
            name = name,
            storage = {},

            ---@param self storage
            add = function(self, index, value)
                self.storage[index] = value
                df.print(("(storageLibrary.new(%s).add(%s, %s)) added "..tostring(value).." to "..tostring(index)):format(self.name, tostring(value), tostring(index)))

                return self.storage[index]
            end,

            ---@param self storage
            remove = function(self, index)
                self.storage[index] = nil
                df.print(("(storageLibrary.new(%s).remove(%s)) removed "..tostring(index)):format(self.name, tostring(index)))

                return self.storage
            end,

            ---@param self storage
            get = function(self, index)
                local retrieved = self.storage[index]
                df.print(("(storageLibrary.new(%s).get(%s)) got "..tostring(retrieved)):format(self.name, tostring(index)))

                return retrieved
            end,
        }

        df.print("(storageLibrary.new) storage created with name "..name)
        return storageLibrary.get(name)
    end,

    get = function(name)
        local retrieved = storages[name]
        df.print("(storageLibrary.get) retrieved "..name..". exists: "..tostring(retrieved ~= nil))

        return retrieved
    end
}

-----------------
-- [Library | Folder: p1_libraries] vehicle.lua
-----------------
---------------------------------------
------------- Vehicle
---------------------------------------

------------- Variables
---@type table<integer, vehicle>
vehicles = {}

------------- Functions
vehicleLibrary = {
    ---@param vehicle vehicle
    track_vehicle = function(vehicle)
        vehicles[vehicle.properties.vehicle_id] = vehicle
    end,

    ---@param vehicle vehicle
    untrack_vehicle = function(vehicle)
        vehicles[vehicle.properties.vehicle_id] = nil
    end,

    ---@param vehicle vehicle
    is_vehicle_tracked = function(vehicle)
        return vehicles[vehicle.properties.vehicle_id] ~= nil
    end,

    ---@param vehicle vehicle
    get_vehicle = function(vehicle)
        return vehicles[vehicle.properties.vehicle_id]
    end,

    is_vehicle_tracked_by_vehicle_id = function(vehicle_id)
        return vehicles[vehicle_id] ~= nil
    end,

    get_vehicle_by_vehicle_id = function(vehicle_id)
        return vehicles[vehicle_id]
    end,

    get_vehicle_by_name = function(query)
        for i, v in pairs(vehicles) do
            if v.properties.name:gsub(" ", ""):lower():find(query:lower():gsub(" ", "")) then
                return v
            end
        end
    end,

    untrack_vehicle_by_vehicle_id = function(vehicle_id)
        for i, v in pairs(vehicles) do
            if v.properties.vehicle_id == vehicle_id then
                vehicles[i] = nil
            end
        end
    end,

    getAll = function()
        return vehicles
    end,

    --------------------------------------

	getDynamicVoxelLimit = function()
		local amountOfPlayers = miscellaneousLibrary.getPlayerCount()
        local tpsData = cuhFramework.tps.getTPSData()
		return cuhFramework.utilities.number.clamp(config.vehicles.antiLag.maxVoxels / ((amountOfPlayers / 9) / (tpsData.averageTPS / 60)), 10000, config.vehicles.antiLag.maxVoxels)
	end,

	getDynamicTPSImpact = function()
		local amountOfPlayers = miscellaneousLibrary.getPlayerCount()
		return cuhFramework.utilities.number.clamp(config.vehicles.antiLag.maxTpsImpact - (amountOfPlayers / 7), 1, config.vehicles.antiLag.maxTpsImpact)
	end,

    ---@param player player
    despawnAllVehiclesOwnedByPlayer = function(player)
        for i, v in pairs(vehicles) do
            if v.properties.addon_spawned or not v.properties.owner then
                goto continue
            end

            if v.properties.owner.properties.peer_id == player.properties.peer_id then
                v:despawn()
            end

            ::continue::
        end
    end,

    ---@param vehicle vehicle
    despawnVehicle = function(vehicle)
        return vehicle:despawn()
    end,

    ---@param player player
    getVehicleCountOfPlayer = function(player)
        local count = 0

        for i, v in pairs(vehicles) do
            if v.properties.addon_spawned then
                goto continue
            end

            if v.properties.owner.properties.peer_id == player.properties.peer_id then
                count = count + 1
            end

            ::continue::
        end

        return count
    end,

    ---@param vehicle vehicle
    getFormattedName = function(vehicle)
        return vehicle.properties.name.." (#"..vehicle.properties.vehicle_id..")"
    end,

    getVehicleList = function(player, formatted)
        local list = {}

        if formatted then
            for i, v in pairs(vehicles) do
                if v.properties.addon_spawned then
                    goto continue
                end

                if v.properties.owner.properties.peer_id == player.properties.peer_id then
                    cuhFramework.utilities.table.insert(list, vehicleLibrary.getFormattedName(v))
                end

                ::continue::
            end
        else
            for i, v in pairs(vehicles) do
                if v.properties.addon_spawned then
                    goto continue
                end

                if v.properties.owner.properties.peer_id == player.properties.peer_id then
                    cuhFramework.utilities.table.insert(list, v)
                end

                ::continue::
            end
        end

        if list[1] then
            return list
        else
            return nil
        end
    end
}

-----------------
-- [Library | Folder: p2_callbackHandlers] disasters.lua
-----------------
---------------------------------------
------------- Disasters
---------------------------------------
cuhFramework.utilities.delay.create(0.01, function() -- wait some time for events to be made
    -- handle disaster start
    ---@param disaster disaster
    disasterStart:connect(function(disaster, position)
        -- create map object
        server.addMapObject(-1, 4003, 0, 8, position[13], position[15], 0, 0, 0, 0, "Disaster - "..disaster.name, 500, "A disaster has started in this area.\nBe careful.")

        -- announce
        local message = disaster.name.." [Disaster] has started at "..miscellaneousLibrary.matrixFormatted(position)..". Be careful!"
        chatAnnounce(message)
        announceLibrary.discordAnnounce(message, nil, ":boom:")
    end)

    -- handle disaster stop
    ---@param disaster disaster
    disasterStop:connect(function(disaster, position)
        -- remove map object
        server.removeMapObject(-1, 4003)

        -- announce
        local message = disaster.name.." [Disaster] has ended."
        chatAnnounce(message)
        announceLibrary.discordAnnounce(message, nil, ":boom:")
    end)
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] map_toggle.lua
-----------------
---------------------------------------
------------- Map Toggle
---------------------------------------

cuhFramework.callbacks.onToggleMap:connect(function(peer_id, opened)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Quick check
    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Check if opened
    if opened then
        -- Refresh all mission UI
        for i, v in pairs(missionLibrary.miscellaneous.getAllMissions()) do
            v:refreshMapUI(player, v.properties.available)
        end
    end
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] mission.lua
-----------------
---------------------------------------
------------- Mission
---------------------------------------

---@param player player
---@param mission mission
function bothCancelAndCompletion(player, mission)
    if not player then
        return
    end

    -- hide ui
    local ui = cuhFramework.ui.screen.get(player.properties.peer_id + 13000)
    if ui then
        ui:setVisibility(false)
    end

    -- hide mission destination popup
    local destinationUI = easyPopupsLibrary.physical.get(player.properties.peer_id + 15000)

    if destinationUI then
        destinationUI:setVisibility(false)
    end
end

cuhFramework.utilities.delay.create(0.01, function()
    ------------- onStart
    ---@param player player
    ---@param mission mission
    eventsLibrary.get("mission_globalOnStart"):connect(function(player, mission)
        -- debug
        df.print(mission.properties.name.." starting for "..player.properties.name)

        -- announce
        miscellaneousLibrary.groupCall({chatAnnounce, notificationAnnounce}, "[!] You have started a mission.\n"..missionLibrary.miscellaneous.formatMissionBasicsIntoString(mission, 5)..cuhFramework.utilities.miscellaneous.switchbox("", "\nBe careful! This mission becomes temporarily unavailable upon completion.", mission.properties.cancelsOnCompletion), player)

        chatAnnounce(player.properties.name.." has started a mission.\n\\__"..mission.properties.name)
        announceLibrary.discordAnnounce("has started a mission.\n"..mission.properties.name, player.properties.name, ":factory_worker: :white_check_mark: ")

        -- show ui
        local ui = cuhFramework.ui.screen.get(player.properties.peer_id + 13000)
        if ui then
            ui:setVisibility(true)
        end

        -- show mission destination popup
        local destinationUI = easyPopupsLibrary.physical.get(player.properties.peer_id + 15000)
        if destinationUI then
            destinationUI:edit("[Destination]", mission.properties.completionPosition)
            destinationUI:setVisibility(true)
        end
    end)

    ------------- onCompletion
    ---@param player player
    ---@param mission mission
    eventsLibrary.get("mission_globalOnCompletion"):connect(function(player, mission)
        -- debug
        df.print(mission.properties.name.." completed by "..player.properties.name..")")

        -- give money
        moneyLibrary.add(player, mission.properties.reward)

        -- give level
        levelsLibrary.increase(player, mission.properties.levelToGiveOnCompletion)

        -- announce
        local formatted = moneyLibrary.format(mission.properties.reward)
        miscellaneousLibrary.groupCall({chatAnnounce, notificationAnnounce}, "[!] You have completed your mission.\n   +"..formatted.."\n   +"..levelsLibrary.format(mission.properties.levelToGiveOnCompletion, true), player)

        chatAnnounce(player.properties.name.." has completed a mission.\n\\__"..mission.properties.name)
        announceLibrary.discordAnnounce("has completed a mission.\n"..mission.properties.name.."\n+"..formatted, player.properties.name, ":factory_worker: :money_with_wings: ")

        -- stuffs
        bothCancelAndCompletion(player, mission)
    end)

    ------------- onCancellation
    ---@param player player
    ---@param mission mission
    eventsLibrary.get("mission_globalOnCancellation"):connect(function(player, mission)
        -- debug
        df.print(mission.properties.name.." cancelled for "..player.properties.name)

        -- announce
       miscellaneousLibrary.groupCall({chatAnnounce, notificationAnnounce}, "[!] Your mission, "..mission.properties.name..", was cancelled.", player)

       chatAnnounce(player.properties.name.." has cancelled a mission.\n\\__"..mission.properties.name)
       announceLibrary.discordAnnounce("has cancelled a mission.\n"..mission.properties.name, player.properties.name, ":factory_worker: :x: ")

       -- stuffs
       bothCancelAndCompletion(player, mission)
    end)

    ------------- availabilityChanged
    ---@param mission mission
    eventsLibrary.get("mission_globalAvailabilityChanged"):connect(function(mission, available)
        -- debug
        df.print(mission.properties.name.." availability set to "..tostring(available))

        -- announce
        if available then
            chatAnnounce(mission.properties.name.." (Mission) is now available.")
            announceLibrary.discordAnnounce(mission.properties.name.." (Mission) is now available.", nil, ":desktop:")
        else
            chatAnnounce(mission.properties.name.." (Mission) is no longer available.")
            announceLibrary.discordAnnounce(mission.properties.name.." (Mission) is no longer available.", nil, ":desktop:")
        end
    end)

    ------------- onRemoval
    ---@param mission mission
    eventsLibrary.get("mission_globalOnRemoval"):connect(function(mission, available)
        -- debug
        df.print(mission.properties.name.." was removed")

        -- announce
        chatAnnounce(mission.properties.name.." (Mission) has been removed.")
        announceLibrary.discordAnnounce(mission.properties.name.." (Mission) has been moved.", nil, ":desktop::x:")
    end)
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] player_character_load.lua
-----------------
---------------------------------------
------------- Player Character Load
---------------------------------------

cuhFramework.callbacks.onObjectLoad:connect(function(object_id)
    -- Get variables
    local player = cuhFramework.players.getPlayerByObjectId(object_id)

    if not player then
        return
    end

    if player.properties.disconnecting then
        return
    end
    -- Give starter inventory
    eventsLibrary.get("giveInventory"):fire(player, inventoryLibrary.inventories.get("Starter"))
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] player_die.lua
-----------------
---------------------------------------
------------- Player Die
---------------------------------------

cuhFramework.callbacks.onPlayerDie:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Announce
    chatAnnounce(player.properties.name.." has died.")

    -- Get thy money
    moneyLibrary.get(player, function(money)
        -- lose thy money
        local toTake = miscellaneousLibrary.percentageOfNumber(money, config.game.moneyLossOnDeathPercentage)
        moneyLibrary.subtract(player, toTake)

        -- and announce thy money subtraction
        announceLibrary.status.warning(
            "You have lost "..math.floor(config.game.moneyLossOnDeathPercentage).."% of your money because you died.\n"..
            moneyLibrary.compare(money, money - toTake, "Before:", "After:"),
            player
        )
    end)
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] player_join.lua
-----------------
---------------------------------------
------------- Player Join
---------------------------------------

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

    -- debug
    df.print(name.." joined the server")

    -- Announce
    chatAnnounce(player.properties.name.." has joined the server.")

    -- Auth
    player:set_auth(true)

    -- Refund if server restarted and this player lost money from vehicle spawning n stuff
    local field_name = databaseLibrary.field_name("totalVehCost", player)
    databaseLibrary.get(field_name, function(amount)
        -- quick check
        if not databaseLibrary.basicChecks(player, amount) or amount == "None" then
            return
        end

        -- refund
        moneyLibrary.add(player, tonumber(amount))

        -- and reset
        databaseLibrary.remove(field_name)
    end)

    -- Add
    table.insert(players_unfiltered, player)
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] player_leave.lua
-----------------
---------------------------------------
------------- Player Leave
---------------------------------------

cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player, true) then
        return
    end

    -- debug
    df.print(name.." left the server")

    -- Remove from players table
    for i, v in pairs(players_unfiltered) do
        if v.properties.peer_id == peer_id then
            table.remove(players_unfiltered, i)
        end
    end

    -- Clear States
    cuhFramework.utilities.delay.create(0.1, function() -- give time for other playerleave callbacks using plaayerstates to do stuff
        playerStatesLibrary.clearStates(player)
    end)

    -- Cancel mission for this player if they have started one
    local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
    if mission then
        df.print(name.." left - has mission, cancelling")
        mission:cancel(player)
    end

    -- Announce
    chatAnnounce(player.properties.name.." has left the server.")

    -- Despawn all vehicles owned by this player
    vehicleLibrary.despawnAllVehiclesOwnedByPlayer(player)
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] player_respawn.lua
-----------------
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

-----------------
-- [Library | Folder: p2_callbackHandlers] vehicle_despawn.lua
-----------------
---------------------------------------
------------- Vehicle Despawn
---------------------------------------

dont_refund = {}
recognisedDespawns = {}

-- Despawn (recognise, refund, etc)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleDespawn:connect(function(vehicle)
    -- Check
    if vehicle.properties.addon_spawned then
        return
    end

    if recognisedDespawns[vehicle.properties.vehicle_id] then
        return
    end

    -- Get variables
    local player = vehicle.properties.owner
    local name = player.properties.name

    -- Announce
    local formattedName = vehicleLibrary.getFormattedName(vehicle)
    cuhFramework.utilities.delay.create(0.11, function() -- prevent despawn message appearing before spawn message
        chatAnnounce(formattedName.." owned by "..name.." has been despawned.")
    end)

    -- Untrack
    vehicleLibrary.untrack_vehicle_by_vehicle_id(vehicle.properties.vehicle_id)

    -- Refund
    if not dont_refund[vehicle.properties.vehicle_id] then
        -- refund
        local refund_amount = miscellaneousLibrary.percentageOfNumber(vehicle.properties.cost, config.vehicles.refund_percentage)
        moneyLibrary.add(player, refund_amount)

        -- and announce the refund
        announceLibrary.status.success("You have been refunded "..moneyLibrary.format(refund_amount).." out of "..moneyLibrary.format(vehicle.properties.cost)..".", player)

        -- also, remove saved vehicle cost since player has been refunded
        databaseLibrary.subtract(
            databaseLibrary.field_name("totalVehCost", vehicle.properties.owner),
            vehicle.properties.cost
        )
    end

    -- Set recognised
    recognisedDespawns[vehicle.properties.vehicle_id] = true
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] vehicle_load.lua
-----------------
---------------------------------------
------------- Vehicle Load
---------------------------------------

-- Load (voxel limit + anti-steal)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleLoad:connect(function(vehicle)
    -- Checks
    if vehicle.properties.addon_spawned then
        return
    end

    if not vehicleLibrary.is_vehicle_tracked(vehicle) then
        return
    end

    -- Get player
    local player = vehicle.properties.owner

    -- Check
    if vehicle["acknowledged"] then
        return
    end

	vehicle["acknowledged"] = true

    -- Anti-Steal
    vehicle:set_editable(false)

    -- Replenish
    replenishLibrary.vehicle.recharge(vehicle)
    replenishLibrary.vehicle.refillTanks(vehicle)
    replenishLibrary.vehicle.resupplyAmmo(vehicle)

    -- Get Variables
    local voxels = vehicle.properties.loaded_vehicle_data.voxels
    local maxVoxelLimit = vehicleLibrary.getDynamicVoxelLimit()

    -- Too many voxels
    if voxels > maxVoxelLimit then
        announceLibrary.status.failure("This vehicle has too many voxels.\n      Voxel Count: "..math.floor(voxels).."\n      Voxel Limit: "..math.floor(maxVoxelLimit), player)
        return vehicleLibrary.despawnVehicle(vehicle)
    end
end)

-----------------
-- [Library | Folder: p2_callbackHandlers] vehicle_spawn.lua
-----------------
---------------------------------------
------------- Vehicle Spawn
---------------------------------------

-- Spawn (addon vehicles - refill battery)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    -- Main stuff
    if vehicle.properties.addon_spawned then
        df.print("is addon spawned - "..vehicle.properties.vehicle_id.. " | addon spawned vehicle | callbackhandler vehicle.lua")
        cuhFramework.utilities.loop.create(0.5, function(id)
            -- Check if spawned still
            local vehicle_check = cuhFramework.vehicles.getVehicleByVehicleId(vehicle.properties.vehicle_id)

            if not vehicle_check then
                cuhFramework.utilities.loop.ongoingLoops[id] = nil
                return
            end

            -- Refill battery
            server.setVehicleBattery(vehicle.properties.vehicle_id, config.game.static_vehicle_battery_name, 100)
        end)
    end
end)

-- Setup (anti-lag, recognise, etc)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    -- Set server money
    server.setCurrency(9999999999, 9999999999)

    -- Set don't refund (turn off when need to refund)
    dont_refund[vehicle.properties.vehicle_id] = true

    -- Checks
    if vehicle.properties.addon_spawned then
        return
    end

    -- Get player
    local player = vehicle.properties.owner

    -- Announce
    local formattedName = vehicleLibrary.getFormattedName(vehicle)
    chatAnnounce(formattedName.." owned by "..player.properties.name.." has been spawned.")

    -- Track
    vehicleLibrary.track_vehicle(vehicle)

    -- Too many vehicles spawned
    local count = vehicleLibrary.getVehicleCountOfPlayer(player)

    if count > config.vehicles.limit then
        announceLibrary.status.failure("You can only have "..config.vehicles.limit.." vehicle spawned.", player)
        return vehicleLibrary.despawnVehicle(vehicle)
    end

    -- Anti-Steal
    vehicle:set_editable(false)

    -- Measure TPS impact
    chatAnnounce("The TPS impact of your vehicle is being measured. If the TPS impact is too high, it will be despawned.\nThis process takes "..math.floor(config.vehicles.antiLag.maxTpsImpactMeasureTime).." seconds.", player)

    local spawnTps = cuhFramework.tps.getTPSData().averageTPS
    cuhFramework.utilities.delay.create(config.vehicles.antiLag.maxTpsImpactMeasureTime, function()
        if not vehicleLibrary.is_vehicle_tracked_by_vehicle_id(vehicle.properties.vehicle_id) then
            return df.print("vehicle spawn - id "..vehicle.properties.vehicle_id.." - owned by nil | tps impact - vehicle no longer tracked")
        end

        -- Get TPS
        local currentTps = cuhFramework.tps.getTPSData().averageTPS

        -- Check if impact is positive/none
        if currentTps >= spawnTps then
            return
        end

        -- Get impact
        local max_impact = vehicleLibrary.getDynamicTPSImpact()
        local impact = math.abs(currentTps - spawnTps)

        -- Too high
        if impact >= max_impact then
            announceLibrary.status.failure("The TPS impact from your vehicle was too high.\nMax Impact: "..cuhFramework.utilities.number.round(max_impact, 1).." TPS \nTPS Impact: "..cuhFramework.utilities.number.round(impact, 1).." TPS", player)
            return vehicleLibrary.despawnVehicle(vehicle)
        end
    end)

    -- Check if player has enough money for the vehicle
    moneyLibrary.get(player, function(money)
        if money < vehicle.properties.cost then
            announceLibrary.status.warning("You do not have enough money to spawn this vehicle.\n"..moneyLibrary.compare(money, vehicle.properties.cost), player)
            return vehicleLibrary.despawnVehicle(vehicle)
        else
            announceLibrary.status.success("You have been charged "..moneyLibrary.format(vehicle.properties.cost).." for your vehicle.", player)
            moneyLibrary.subtract(player, vehicle.properties.cost)
            dont_refund[vehicle.properties.vehicle_id] = false

            -- save vehicle cost in case server restarts/crashes
            databaseLibrary.add(
                databaseLibrary.field_name("totalVehCost", vehicle.properties.owner),
                vehicle.properties.cost
            )
        end
    end)
end)

-- Spawn (tooltip, etc)
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    if vehicle.properties.addon_spawned then
        return
    end

    -- Main
    cuhFramework.utilities.delay.create(0.1, function()
        -- Checks
        if not vehicleLibrary.get_vehicle_by_vehicle_id(vehicle.properties.vehicle_id) then
            return
        end

        -- Get player
        local player = vehicle.properties.owner

        -- Set Tooltip
        local formattedName = vehicleLibrary.getFormattedName(vehicle)
        vehicle:set_tooltip(formattedName.."\nOwner: "..player.properties.name)
    end)
end)

-----------------
-- [Library | Folder: p3_ui] local.lua
-----------------
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

-----------------
-- [Library | Folder: p4_commands] admin_debug.lua
-----------------
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

-----------------
-- [Library | Folder: p4_commands] admin_pos.lua
-----------------
---------------------------------------
------------- Command - Shows your position in chat [Admin]
---------------------------------------

------------- ?pos
cuhFramework.commands.create("pos", {"p"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check if admin
    if not admin then
        return
    end

    -- Print pos in chat
    chatAnnounce(miscellaneousLibrary.matrixFormatted(player:get_position()))
end, "")

-----------------
-- [Library | Folder: p4_commands] admin_reminder.lua
-----------------
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

-----------------
-- [Library | Folder: p4_commands] admin_set_level.lua
-----------------
---------------------------------------
------------- Command - Set level [Admin]
---------------------------------------

------------- ?level_set
cuhFramework.commands.create("level_set", {"ls"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local args = {...}
    if args[1] and args[2] then
        local player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[2], false)
        if player then
            levelsLibrary.set(player, tonumber(args[1]))
        end
    end
end)

-----------------
-- [Library | Folder: p4_commands] admin_set_money.lua
-----------------
---------------------------------------
------------- Command - Set money [Admin]
---------------------------------------

------------- ?money_set
cuhFramework.commands.create("money_set", {"ms"}, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local args = {...}
    if args[1] and args[2] then
        local player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[2], false)
        if player then
            moneyLibrary.set(player, tonumber(args[1]))
        end
    end
end)

-----------------
-- [Library | Folder: p4_commands] admin_set_per_location.lua
-----------------
---------------------------------------
------------- Command - Set persistent location [Admin]
---------------------------------------

------------- ?spl
cuhFramework.commands.create("spl", nil, false, function(message, peer_id, admin, auth, command, ...)
    if not admin then
        return
    end

    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local pos = player:get_position()
    databaseLibrary.set(databaseLibrary.field_name("persistentLocation", player), pos[13]..","..pos[14]..","..pos[15])
end)

-----------------
-- [Library | Folder: p4_commands] clean.lua
-----------------
---------------------------------------
------------- Command - Despawn your vehicles
---------------------------------------

------------- ?clean
cuhFramework.commands.create("clean", {"c", "clear", "despawn", "d"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Despawn
    if args[1] then
        -- Check if ID or name
        local isId = tonumber(args[1])

        -- Get vehicle, by ID or name
        local vehicle

        if isId then
            vehicle = vehicleLibrary.get_vehicle_by_vehicle_id(isId)
        else
            vehicle = vehicleLibrary.get_vehicle_by_name(args[1]:gsub("_", ""))
        end

        -- Main stuffs
        if not vehicle then
            return announceLibrary.status.failure("The vehicle you want to despawn could not be found.", player)
        end

        if vehicle.properties.owner and vehicle.properties.owner ~= player then --ERR: if owner is nil, it might error? tested in lua.org/demo.html, doesnt error i think
            return announceLibrary.status.failure("You do not own this vehicle.", player)
        end

        vehicleLibrary.despawnVehicle(vehicle)
    else
        vehicleLibrary.despawnAllVehiclesOwnedByPlayer(player)
    end

    -- Announce
    announceLibrary.status.success("Successfully despawned your vehicle(s)."..cuhFramework.utilities.miscellaneous.switchbox("\n\nTip: If you want to despawn a specific vehicle, type the name/ID of it.\nIt does not have to be the exact same, a partial name will be fine.\nType '?vehicles' to see your vehicles.\nExample: '?c my_vehicle'. Make sure to use underscores for spaces.", "", args[1]), player)
end, "Despawns your vehicle(s).")

-----------------
-- [Library | Folder: p4_commands] help.lua
-----------------
---------------------------------------
------------- Command - Shows a help message
---------------------------------------

------------- ?help
cuhFramework.commands.create("help", {"h"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Pack commands into table
    local commands = {}

    for i, v in pairs(cuhFramework.commands.registeredCommands) do
        -- probably an admin/internal command
        if v.description == "" then
            goto continue
        end

        -- new shorthands stuff
        local shorthands = {}
        for _, shorthand in pairs(v.shorthands) do
            table.insert(shorthands, "?"..shorthand)
        end

        -- add to commands list but nice and formatted
        table.insert(commands, "?"..v.command_name.."\n     \\___"..table.concat(shorthands, ", ").."\n     \\___"..v.description)

        ::continue::
    end

    -- Show commands and help message
    if not commands[1] then
        commands[1] = "This addon has no commands."
    end

    chatAnnounce("// Help\n"..config.info.help_message.."\n\n// Commands:\n"..table.concat(commands, "\n"), player)
end, "Shows all commands along with help.")

-----------------
-- [Library | Folder: p4_commands] mission.lua
-----------------
---------------------------------------
------------- Command - Starts/Cancels a mission
---------------------------------------

------------- ?start
cuhFramework.commands.create("start", {"s"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Get mission
    local mission = missionLibrary.miscellaneous.getMissionByPosition(player:get_position())

    -- Quick checks
    if missionLibrary.miscellaneous.isPlayerPartakingInAMission(player) then
        return announceLibrary.status.failure("You are already partaking in a mission. Type '?cancel' to cancel it.", player)
    end

    if not mission then
        return announceLibrary.status.failure("You are not in a mission activation zone. Check the map to find missions to start.", player)
    end

    if not mission.properties.available then
        return announceLibrary.status.failure("This mission is not available at the moment.", player)
    end

    if debounceLibrary.debounce(player.properties.peer_id.."_missioncommand1", 3) then
        return announceLibrary.status.failure("This command is on cooldown.", player)
    end

    -- Main stuffs
    levelsLibrary.get(player, function(level)
        -- Check if level is high enough
        if level < mission.properties.minimumLevel then
            return announceLibrary.status.failure("Your level is not high enough.\nYour Level: "..levelsLibrary.format(level).."\nLevel Needed: "..levelsLibrary.format(mission.properties.minimumLevel).."+", player)
        end

        -- Start mission
        mission:start(player)
    end)
end, "Starts a mission.")

------------- ?cancel
cuhFramework.commands.create("cancel", {"ca"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Get mission
    local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)

    -- Quick check
    if not mission then
        return announceLibrary.status.failure("You haven't started a mission. Check the map to find missions to start.", player)
    end

    if debounceLibrary.debounce(player.properties.peer_id.."_missioncommand2", 3) then
        return announceLibrary.status.failure("This command is on cooldown.", player)
    end

    -- Cancel
    mission:cancel(player)
end, "Cancels your mission.")

------------- ?details
cuhFramework.commands.create("details", {"det"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Checks
    if not args[1] then
        return announceLibrary.status.failure("Please provide the name of the mission you would like to get information about. The name can be partial, just like when you search something with Google.\nExample: \"?details bob's_la\" - Shows information on the \"Bob's Laptop Delivery\" mission.", player)
    end

    -- Get mission
    local mission = missionLibrary.miscellaneous.getMissionBySearch(args[1]:gsub("_", " "))

    -- Quick check
    if not mission then
        return announceLibrary.status.failure("This mission doesn't exist.", player)
    end

    -- Show details
    announceLibrary.status.success("Check chat to see information about \""..mission.properties.name.."\" (Mission).")
    chatAnnounce(missionLibrary.miscellaneous.formatMissionDetailsIntoString(mission), player)
end, "Shows mission information.")

-----------------
-- [Library | Folder: p4_commands] refreshUI.lua
-----------------
---------------------------------------
------------- Command - Refresh UI
---------------------------------------

------------- ?refresh_ui
cuhFramework.commands.create("refresh_ui", {"refreshui", "rui", "ru"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Main
    for _, v in pairs(cuhFramework.ui.screen.activeUI) do
        if v.properties.player and v.properties.player.properties.peer_id == player.properties.peer_id then
            v:refresh()
        end
    end

    for _, v in pairs(easyPopupsLibrary.physical.getAll()) do
        if v.properties.player and v.properties.player.properties.peer_id == player.properties.peer_id then
            v:refresh()
        end
    end

    announceLibrary.status.success("Successfully refreshed all UI with you as the target.", player)
end, "Refreshes most UI shown to you.")

-----------------
-- [Library | Folder: p4_commands] reset.lua
-----------------
---------------------------------------
------------- Command - Reset data
---------------------------------------

------------- ?reset
cuhFramework.commands.create("reset", {"re"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Cooldown check
    if debounceLibrary.debounce(player.properties.peer_id.."_resetcommand", 3) then
        return announceLibrary.status.failure("This command is on cooldown.", player)
    end

    -- Main
    if playerStatesLibrary.hasState(player, "reset_data") then
        -- confirmed
        playerStatesLibrary.removeState(player, "reset_data")
        announceLibrary.status.success("Your money and levels have been reset. This cannot be undone.", player)

        -- despawn vehicles
        vehicleLibrary.despawnAllVehiclesOwnedByPlayer(player)

        -- cancel mission if in one
        local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
        if mission then
            mission:cancel(player)
        end

        -- actually reset
        moneyLibrary.remove(player)
        databaseLibrary.remove(databaseLibrary.field_name("level", player))

        -- now teleport
        player:teleport(config.game.spawn)
    else
        -- confirming
        playerStatesLibrary.setState(player, "reset_data")

        announceLibrary.status.warning("Type this command again to confirm that you want to reset your money and levels to the starting value.\n*This CANNOT be undone.*", player)
        chatAnnounce("Type the command again to reset your money and level.\nThis cannot be undone.", player)

        -- timeout
        cuhFramework.utilities.delay.create(15, function()
            playerStatesLibrary.removeState(player, "reset_data")
        end)
    end
end, "Resets your data (money, etc).")


-----------------
-- [Library | Folder: p4_commands] suicide.lua
-----------------
---------------------------------------
------------- Command - Suicide
---------------------------------------

------------- ?die
cuhFramework.commands.create("die", {"suicide", "su", "kys", "di"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Die
    player:damage(1000)
end, "You have so much to live for.")


-----------------
-- [Library | Folder: p4_commands] transfer.lua
-----------------
---------------------------------------
------------- Command - Transfer money to someone
---------------------------------------

------------- ?transfer
cuhFramework.commands.create("transfer", {"give", "t", "g"}, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Checks
    if not args[1] then
        return announceLibrary.status.failure("Please specify who you would like to transfer money to (player name). For example: ?transfer *bob* 100. You can also do a partial name.", player)
    end

    if not args[2] then
        return announceLibrary.status.failure("Please specify how much you would like to transfer. For example: ?transfer bob *100*.", player)
    end

    -- Get target player
    local target_player = cuhFramework.players.getPlayerByNameWithAllowedPartialName(args[1], false)

    -- More checks
    if not target_player then
        return announceLibrary.status.failure("The player you searched for doesn't exist. Did you type their name correctly?", player)
    end

    if target_player == player then
        return announceLibrary.status.failure("You cannot transfer money to yourself.", player)
    end

    -- Get amount
    local toTransfer = tonumber(args[2])

    -- More more checks
    if not toTransfer then
        return announceLibrary.status.failure("The amount of money you want to transfer must be a number.", player)
    end

    if toTransfer <= 0 then
        return announceLibrary.status.failure("The amount of money you want to transfer must be above 0.", player)
    end

    -- Transfer
    moneyLibrary.get(player, function(money)
        if money < toTransfer then
            return announceLibrary.status.failure("You don't have enough money.", player)
        end

        -- edit money
        moneyLibrary.add(target_player, toTransfer)
        moneyLibrary.subtract(player, toTransfer)

        -- announce
        announceLibrary.status.success("Succesfully transferred "..moneyLibrary.format(toTransfer).." to "..target_player.properties.name..".", player)
        chatAnnounce(player.properties.name.." transferred "..moneyLibrary.format(toTransfer).." to you.", target_player)
    end)
end, "Privately message someone.")

-----------------
-- [Library | Folder: p4_commands] ui.lua
-----------------
---------------------------------------
------------- Command - Toggle UI
---------------------------------------

------------- ?ui
local ui_ids = {
    10000,
    11000,
    12000,
    14000
}

cuhFramework.commands.create("ui", { "u", "hud" }, false, function(message, peer_id, admin, auth, command, ...)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Main
    if playerStatesLibrary.hasState(player, "ui_toggle") then
        -- Show UI
        playerStatesLibrary.removeState(player, "ui_toggle")

        for i, v in pairs(ui_ids) do
            local ui = cuhFramework.ui.screen.get(peer_id + v)

            if ui then
                ui:setVisibility(true)
            end
        end

        -- Show mission UI
        local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
        if mission then
            for i, v in pairs(mission.properties.storage.storage) do
                if v.edit and v.refresh and v.properties and v.remove and v.setVisibility then -- probably a physical popup
                    v:setVisibility(true)
                end
            end
        end

        -- Announce
        announceLibrary.status.success("Most UI elements have now been shown.", player)
    else
        -- Hide UI
        playerStatesLibrary.setState(player, "ui_toggle")

        for i, v in pairs(ui_ids) do
            local ui = cuhFramework.ui.screen.get(peer_id + v)

            if ui then
                ui:setVisibility(false)
            end
        end

        -- Hide mission UI
        local mission = missionLibrary.miscellaneous.getMissionFromPlayer(player)
        if mission then
            for i, v in pairs(mission.properties.storage.storage) do
                if v.edit and v.refresh and v.properties and v.remove and v.setVisibility then -- probably a physical popup
                    v:setVisibility(false)
                end
            end
        end

        -- Announce
        announceLibrary.status.success("Most UI elements have now been hidden.", player)
    end
end, "Toggles most UI elements.")

-----------------
-- [Library | Folder: p4_commands] vehicles.lua
-----------------
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

-----------------
-- [Library | Folder: p4_commands] whisper.lua
-----------------
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

-----------------
-- [Library | Folder: p4_commands] workbenchTP.lua
-----------------
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

-----------------
-- [Library | Folder: p5_controllers] persistentLocationController.lua
-----------------
---------------------------------------
------------- Controller - Persistent Location
---------------------------------------

------------- Variables
local persistentLocationEnabled = false
local defaultPos = matrix.translation(0, 0, 0)

------------- Functions
persistentLocationController = {
    ---@param new boolean
    setStartEnabled = function(new)
        persistentLocationEnabled = new
    end,

    ---@param new SWMatrix
    setDefaultPos = function(new)
        defaultPos = new
    end,

    ---@param player player
    ---@param new boolean
    setPersistentLocationEnabledForPlayer = function(player, new)
        if new then
            playerStatesLibrary.setState(player, "persistentLocationEnabled")
        else
            playerStatesLibrary.removeState(player, "persistentLocationEnabled")
        end

        return new
    end,

    ---@param player player
    isPersistentLocationEnabledForPlayer = function(player)
        return playerStatesLibrary.hasState(player, "persistentLocationEnabled")
    end,

    ---@param player player
    updatePersistentLocationForPlayer = function(player)
        local pos = player:get_position()
        databaseLibrary.set(databaseLibrary.field_name("persistentLocation", player), pos[13]..","..pos[14]..","..pos[15])
    end,

    ---@param player player
    getPersistentLocationFromPlayer = function(player, callback)
        databaseLibrary.get(databaseLibrary.field_name("persistentLocation", player), function(response)
            -- quick check
            if not databaseLibrary.basicChecks(player, response) then
                return callback(false, matrix.translation(0, 0, 0))
            end

            -- first time playing, so ignore and wait for persistent location to be set
            if response == "None" then
                return
            end

            -- main stuffs
            local x, y, z = table.unpack(cuhFramework.utilities.string.split(response, ","))

            if not x or not y or not z then
                df.print("persistent location - "..player.properties.steam_id.." - coords invalid")
                return callback(false, matrix.translation(0, 0, 0))
            end

            return callback(true, matrix.translation(x, y, z))
        end)
    end,

    events = {
        onTeleport = eventsLibrary.new("persistentLocationOnTeleport") -- player, success
    }
}

------------- Callback Handlers
cuhFramework.callbacks.onPlayerJoin:connect(function(_, _, peer_id)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Set persistent location for player to default
    persistentLocationController.setPersistentLocationEnabledForPlayer(player, persistentLocationEnabled)
end)

cuhFramework.callbacks.onObjectLoad:connect(function(object_id)
    -- Get variables
    local player = cuhFramework.players.getPlayerByObjectId(object_id)

    if not player then
        return
    end

    if player.properties.disconnecting then
        return
    end

    -- Teleport (with persistent location)
    if not persistentLocationController.isPersistentLocationEnabledForPlayer(player) then
        return
    end

    ---@param pos SWMatrix
    persistentLocationController.getPersistentLocationFromPlayer(player, function(success, pos)
        -- use if fails for whatever reason
        local function failureTeleport()
            persistentLocationController.events.onTeleport:fire(player, false)
            return player:teleport(defaultPos)
        end

        -- quick check
        if not success then
            return failureTeleport()
        end

        -- teleport
        cuhFramework.utilities.delay.create(1, function()
            persistentLocationController.events.onTeleport:fire(player, true)
            player:teleport(cuhFramework.utilities.matrix.offsetPosition(pos, 0, 5, 0))
        end)
    end)
end)

cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player, true) then
        return
    end

    -- Persistent location
    persistentLocationController.updatePersistentLocationForPlayer(player)
end)

-----------------
-- [Library | Folder: p5_controllers] respawnController.lua
-----------------
-- might be the cause of addon crashes, disabled for now
-- ---------------------------------------
-- ------------- Controller - Respawn Controller
-- ---------------------------------------

-- ------------- Variables
-- local defaultCustomRespawnEnabled = false
-- local spawnPoints = {}

-- ------------- Functions
-- respawnController = {
--     ---@param new boolean
--     setDefaultCustomRespawnAllowed = function(new)
--         defaultCustomRespawnEnabled = new
--     end,

--     getCustomRespawnAllowed = function()
--         return defaultCustomRespawnEnabled
--     end,

--     ---@param player player
--     ---@param new boolean
--     setCustomRespawnAllowed = function(player, new)
--         if new then
--             playerStatesLibrary.setState(player, "respawnEnabled")
--         else
--             playerStatesLibrary.removeState(player, "respawnEnabled")
--         end

--         return new
--     end,

--     ---@param player player
--     isPlayerAllowedCustomRespawn = function(player)
--         return playerStatesLibrary.hasState(player, "respawnEnabled")
--     end,

--     ---@param pos SWMatrix
--     addSpawnPoint = function(pos)
--         table.insert(spawnPoints, pos)
--     end,

--     ---@param pos SWMatrix
--     removeSpawnPoint = function(pos)
--         for i, v in pairs(spawnPoints) do
--             if v[13] == pos[13] and v[14] == pos[14] and v[15] == pos[15] then
--                 table.remove(spawnPoints, i)
--             end
--         end
--     end,

--     events = {
--         onRespawn = eventsLibrary.new("respawnOnRespawn") -- player, customRespawnEnabled
--     }
-- }

-- ------------- Callback Handlers
-- cuhFramework.callbacks.onPlayerJoin:connect(function(_, _, peer_id)
--     -- Get variables
--     local player = cuhFramework.players.getPlayerByPeerId(peer_id)

--     -- Checks
--     if not player then
--         return
--     end

--     if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
--         return
--     end

--     -- Set respawn at die
--     respawnController.setCustomRespawnAllowed(player, defaultCustomRespawnEnabled)
-- end)

-- cuhFramework.callbacks.onPlayerRespawn:connect(function(peer_id)
--     -- Get variables
--     local player = cuhFramework.players.getPlayerByPeerId(peer_id)

--     -- Checks
--     if not player then
--         return
--     end

--     if miscellaneousLibrary.unnamedClientOrServerOrDisconnecting(player) then
--         return
--     end

--     -- Teleport to random spawn point
--     respawnController.events.onRespawn:fire(player, respawnController.isPlayerAllowedCustomRespawn(player))

--     if respawnController.isPlayerAllowedCustomRespawn(player) then
--         player:teleport(cuhFramework.utilities.table.getRandomValue(spawnPoints) or matrix.translation(0, 0, 0))
--     end
-- end)

-----------------
-- [Main File] main.lua
-----------------
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