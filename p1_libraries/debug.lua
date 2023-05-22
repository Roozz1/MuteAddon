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