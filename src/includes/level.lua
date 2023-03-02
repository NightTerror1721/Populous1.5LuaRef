--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     level
    Author:     Krampus1721
    Site:       http://popre.net
    Discord:    https://discord.gg/buRQ4HK
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]--

if __DEFINED_KRAMPUS1721_INCLUDES_LEVEL then return end
__DEFINED_KRAMPUS1721_INCLUDES_LEVEL = true


include("includes/serialization.lua")
include("includes/tribes.lua")


local DB = {}

---@param tribe TribeInfo
---@return table<Value, Value>
local function GetTribeDatabase(tribe)
    local tribeDBKey = tribe.num
    local tribeDB =  rawget(DB, tribeDBKey)
    if not tribeDB then
        tribeDB = {}
        rawset(DB, tribeDBKey, tribeDB)
    end
    return tribeDB
end

---@param tribe TribeInfo
---@param name string
---@return Value|nil
local function ReadDatabaseValue(tribe, name)
    return rawget(GetTribeDatabase(tribe), name)
end

---@param tribe TribeInfo
---@param name string
---@param value Value
local function WriteDatabaseValue(tribe, name, value)
    rawset(GetTribeDatabase(tribe), name, value)
end


---@param tribe TribeInfo
---@param name string
local function CreateTribeDBAccessProxy(tribe, name)
    local mt = {}

    rawset(mt, "__index", function(_, key)
        local dbContainer = rawget(GetTribeDatabase(tribe), name)
        return dbContainer and dbContainer[key] or false
    end)

    rawset(mt, "__newindex", function(_, key, value)
        local dbContainer = rawget(GetTribeDatabase(tribe), name)
        if dbContainer then dbContainer[key] = value end
        return value
    end)

    local proxy = {}
    setmetatable(proxy, mt)
    return proxy
end

---@param tribe TribeInfo
local function ExportTribeAttributesAndStates(tribe)
    local tribeDB = GetTribeDatabase(tribe)
    tribeDB.__attributes = tribe:exportAttributes()
    tribeDB.__states = tribe:exportStates()
end

---@param tribe TribeInfo
local function ImportTribeAttributesAndStates(tribe)
    local tribeDB = GetTribeDatabase(tribe)
    tribe:importAttributes(tribeDB.__attributes--[[@as integer[] ]])
    tribe:importStates(tribeDB.__states--[[@as boolean[] ]])

    tribeDB.__attributes = nil
    tribeDB.__states = nil
end


---@alias LevelTribeDataProxy table<Value, Value>

---@class LevelTribeDataProxies
---@field localVars LevelTribeDataProxy

---@class LevelTribeData
---@field tribe TribeInfo
---@field db LevelTribeDataProxies
---@field OnInit fun()?
---@field OnFirstTurn fun()?
---@field OnTurn fun()?
---@field OnCreateThing fun(thing: Thing)?
---@field OnChat fun(tribe: TribeNum, msg: string)?

---@type table<TribeNum, LevelTribeData>
local Tribes = {}

---@param tribe TribeInfo
---@return LevelTribeData|nil
local function RegisterTribe(tribe)
    if Tribes[tribe.num] then return nil end

    ---@type LevelTribeData
    local data = {
        tribe = tribe,
        db = {
            localVars = CreateTribeDBAccessProxy(tribe, "localVars"),
        }
    }

    WriteDatabaseValue(tribe, "localVars", {})

    Tribes[tribe.num] = data
    return data
end

---@param tribeData LevelTribeData
---@param hookName string
local function ExtractHookFromGlobal(tribeData, hookName)
    local hook = _G[hookName]
    if hook and type(hook) == "function" then
        tribeData[hookName] = hook
    end
    _G[hookName] = nil
end

---@type string
local LevelFolderPath = ""

---@type table<TribeNum, string>
local TribeScriptNames = {
    [Tribe.Blue.num] = "blue.lua",
    [Tribe.Red.num] = "red.lua",
    [Tribe.Yellow.num] = "yellow.lua",
    [Tribe.Green.num] = "green.lua",
    [Tribe.Cyan.num] = "cyan.lua",
    [Tribe.Pink.num] = "pink.lua",
    [Tribe.Black.num] = "black.lua",
    [Tribe.Orange.num] = "orange.lua",
    [Tribe.Neutral.num] = "neutral.lua",
    [Tribe.Hostbot.num] = "hostbot.lua",
}


LevelScript = {}
LevelScript.hook = {}

---@param path string
function LevelScript.setLevelFolderPath(path)
    LevelFolderPath = path
end

---@param tribe TribeInfo
---@param name string
function LevelScript.setTribeScriptName(tribe, name)
    TribeScriptNames[tribe.num] = name
end

---@param tribe TribeInfo
---@return boolean
function LevelScript.registerTribe(tribe)
    local data = RegisterTribe(tribe)
    if data then
        include(LevelFolderPath.."/"..TribeScriptNames[tribe.num])
        ExtractHookFromGlobal(data, "OnInit")
        ExtractHookFromGlobal(data, "OnFirstTurn")
        ExtractHookFromGlobal(data, "OnTurn")
        ExtractHookFromGlobal(data, "OnCreateThing")
        ExtractHookFromGlobal(data, "OnChat")
        data.tribe:initComputer()
        return true
    end
    return false
end

---@param writer Script4SaveData
function LevelScript.saveData(writer)
    for _, tribeData in pairs(Tribes) do
        ExportTribeAttributesAndStates(tribeData.tribe)
    end
    DataSaver.saveTable(writer, DB)
end

---@param reader Script4LoadData
function LevelScript.loadData(reader)
    DB = DataLoader.loadTable(reader)
    for _, tribeData in pairs(Tribes) do
        ImportTribeAttributesAndStates(tribeData.tribe)
    end
end

---@param tribe TribeInfo
---@return LevelTribeDataProxy
function LevelScript.getLocalVarsProxy(tribe)
    return Tribes[tribe.num].db.localVars
end

function LevelScript.hook.OnInit()
    for _, tribe in pairs(Tribes) do
        if tribe.OnInit then tribe.OnInit() end
    end
end

function LevelScript.hook.OnFirstTurn()
    for _, tribe in pairs(Tribes) do
        if tribe.OnFirstTurn then tribe.OnFirstTurn() end
    end
end

function LevelScript.hook.OnTurn()
    for _, tribe in pairs(Tribes) do
        if tribe.OnTurn then tribe.OnTurn() end
    end
end

---@param thing Thing
function LevelScript.hook.OnCreateThing(thing)
    for _, tribe in pairs(Tribes) do
        if tribe.OnCreateThing then tribe.OnCreateThing(thing) end
    end
end

---@param tribeNum TribeNum
---@param msg string
function LevelScript.hook.OnChat(tribeNum, msg)
    for _, tribe in pairs(Tribes) do
        if tribe.OnChat then tribe.OnChat(tribeNum, msg) end
    end
end



---@param folderPath string
---@param tribes TribeInfo[]
function LevelScript.buildMainLevelScript(folderPath, tribes)
    LevelScript.setLevelFolderPath(folderPath)
    for _, tribe in pairs(tribes) do
        LevelScript.registerTribe(tribe)
    end

    _G["OnCreateThing"] = LevelScript.hook.OnCreateThing
    _G["OnChat"] = LevelScript.hook.OnChat
    _G["OnTurn"] = function()
        if Time.getTurn() == 0 then LevelScript.hook.OnFirstTurn() end
        LevelScript.hook.OnTurn()
    end
    _G["OnLoad"] = LevelScript.loadData
    _G["OnSave"] = LevelScript.saveData

    LevelScript.hook.OnInit()
end
