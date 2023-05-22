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