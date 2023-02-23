--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     serialization
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

if __DEFINED_KRAMPUS1721_INCLUDES_SERIALIZATION then return end
__DEFINED_KRAMPUS1721_INCLUDES_SERIALIZATION = true

import(Module_Table)
import(Module_Math)


---@alias Value boolean|number|string|table


---@enum ValueType
local ValueType = {
    Integer = 0,
    Boolean = 1,
    Float = 2,
    String = 3,
    Table = 4
}

local ValueTypeNames = {
    [ValueType.Integer] = "integer",
    [ValueType.Boolean] = "boolean",
    [ValueType.Float] = "number",
    [ValueType.String] = "string",
    [ValueType.Table] = "table"
}

local ValidTypes = {
    number = true,
    boolean = true,
    string = true,
    table = true
}

---@alias DataEntry { type: ValueType, value: Value }

local _DebugSerialization = false

---@class DataEntryStack
---@field private stack DataEntry[]
local DataEntryStack = {}
DataEntryStack.__index = DataEntryStack
DataEntryStack.__name = "Krampus1721.__DataEntryStack"

---@return DataEntryStack
function DataEntryStack.new()
    ---@type DataEntryStack
    local obj = {}
    setmetatable(obj, DataEntryStack)

    obj.stack = {}
    return obj
end

function DataEntryStack:size()
    return #self.stack
end

function DataEntryStack:isEmpty()
    return #self.stack == 0
end

---@param value integer
function DataEntryStack:pushInt(value)
    table.insert(self.stack, { type = ValueType.Integer, value = value })
end

---@param value number
function DataEntryStack:pushFloat(value)
    table.insert(self.stack, { type = ValueType.Float, value = value })
end

---@param value number
function DataEntryStack:pushNumber(value)
    if math.floor(value) == value then
        self:pushInt(value)
    else
        self:pushFloat(value)
    end
end

---@param value boolean
function DataEntryStack:pushBool(value)
    table.insert(self.stack, { type = ValueType.Boolean, value = value })
end

---@param value string
function DataEntryStack:pushString(value)
    table.insert(self.stack, { type = ValueType.String, value = value })
end

---@param length integer
function DataEntryStack:pushTableLength(length)
    table.insert(self.stack, { type = ValueType.Table, value = length })
end

---@return DataEntry
function DataEntryStack:pop()
    return table.remove(self.stack)
end

function DataEntryStack:clear()
    while #self.stack > 0 do
        table.remove(self.stack)
    end
end

---@param writer Script4SaveData
function DataEntryStack:write(writer)
    local count = 0
    for i = 1, #self.stack, 1 do
        local entry = self.stack[i]
        if entry.type == ValueType.Integer then
            if _DebugSerialization then log("push_int: "..tostring(entry.value)) end
            writer:push_int(entry.value--[[@as integer]])
            writer:push_int(ValueType.Integer)
            count = count + 1
        elseif entry.type == ValueType.Boolean then
            if _DebugSerialization then log("push_bool: "..tostring(entry.value)) end
            writer:push_bool(entry.value--[[@as boolean]])
            writer:push_int(ValueType.Boolean)
            count = count + 1
        elseif entry.type == ValueType.Float then
            if _DebugSerialization then log("push_float: "..tostring(entry.value)) end
            writer:push_float(entry.value--[[@as number]])
            writer:push_int(ValueType.Float)
            count = count + 1
        elseif entry.type == ValueType.String then
            if _DebugSerialization then log("push_string: "..tostring(entry.value)) end
            writer:push_string(entry.value--[[@as string]])
            writer:push_int(ValueType.String)
            count = count + 1
        elseif entry.type == ValueType.Table then
            if _DebugSerialization then log("push_tablelength: "..tostring(entry.value)) end
            writer:push_int(entry.value--[[@as integer]])
            writer:push_int(ValueType.Table)
            count = count + 1
        end
    end
    writer:push_int(count)
end

---@param reader Script4LoadData
function DataEntryStack:read(reader)
    self:clear()
    local count = reader:pop_int()
    for i = 1, count, 1 do
        local type = reader:pop_int()
        if type == ValueType.Integer then
            local value = reader:pop_int()
            if _DebugSerialization then log("pop_int: "..tostring(value)) end
            self:pushInt(value)
        elseif type == ValueType.Boolean then
            local value = reader:pop_bool()
            if _DebugSerialization then log("pop_bool: "..tostring(value)) end
            self:pushBool(value)
        elseif type == ValueType.Float then
            local value = reader:pop_float()
            if _DebugSerialization then log("pop_float: "..tostring(value)) end
            self:pushFloat(value)
        elseif type == ValueType.String then
            local value = reader:pop_string()
            if _DebugSerialization then log("pop_string: "..tostring(value)) end
            self:pushString(value)
        elseif type == ValueType.Table then
            local value = reader:pop_int()
            if _DebugSerialization then log("pop_tablelength: "..tostring(value)) end
            self:pushTableLength(value)
        end
    end
end



local function IsValidType(value)
    return ValidTypes[type(value)] ~= nil
end

---@param n number
local function IsInteger(n)
    return math.floor(n) == n
end

---@param table table
---@return { [1]: Value, [2]: Value }[] entries, integer size
local function ExtractTableEntries(table)
    ---@type { [1]: Value, [2]: Value }[]
    local entries = {}
    local size = 0
    for key, value in pairs(table) do
        if IsValidType(key) and IsValidType(value) then
            entries[size + 1] = { key, value }
            size = size + 1
        end
    end
    return entries, size
end

local Parser = {}

---@param data DataEntryStack
---@param value Value
function Parser.writeValue(data, value)
    local vtype = type(value)
    if vtype == "number" then
        data:pushNumber(value)
    elseif vtype == "boolean" then
        data:pushBool(value)
    elseif vtype == "string" then
        data:pushString(value)
    elseif vtype == "table" then
        local entries, size = ExtractTableEntries(value)
        data:pushTableLength(size)
        for i = 1, size, 1 do
            local val = entries[i]
            Parser.writeValue(data, val[1])
            Parser.writeValue(data, val[2])
        end
    end
end

---@param data DataEntryStack
---@return Value
function Parser.readValue(data)
    local entry = data:pop()
    if entry.type == ValueType.Table then
        local table = {}
        local size = entry.value--[[@as integer]]
        for _ = 1, size, 1 do
            local key = Parser.readValue(data)
            local value = Parser.readValue(data)
            table[key] = value
        end
        return table
    end
    return entry.value
end



---@class DataSaver
---@field private writer Script4SaveData
---@field private data table
DataSaver = {}
DataSaver.__index = DataSaver
DataSaver.__name = "Krampus1721.DataSaver"


---@param writer Script4SaveData
---@return DataSaver
function DataSaver.new(writer)
    ---@type DataSaver
    local obj = {}
    setmetatable(obj, DataSaver)

    obj.writer = writer
    obj.data = {}
    return obj
end

---@param name string
---@param value Value
---@return DataSaver
function DataSaver:put(name, value)
    self.data[name] = value
    return self
end

---@param table table
---@return DataSaver
function DataSaver:putAll(table)
    for key, value in pairs(table) do
        if type(key) == "string" then
            self.data[key] = value
        end
    end
    return self
end

function DataSaver:save()
    DataSaver.saveTable(self.writer, self.data)
end

---@param writer Script4SaveData
---@param table table
function DataSaver.saveTable(writer, table)
    local data = DataEntryStack.new()
    Parser.writeValue(data, table)
    data:write(writer)
    data:clear()
end



---@class DataLoader
---@field private reader Script4LoadData
---@field private data table
DataLoader = {}
DataLoader.__index = DataLoader
DataLoader.__name = "Krampus1721.DataLoader"


---@param reader Script4LoadData
---@return DataLoader
function DataLoader.new(reader)
    ---@type DataLoader
    local obj = {}
    setmetatable(obj, DataLoader)

    obj.reader = reader
    obj.data = {}
    return obj
end

---@param name string
---@param defaultValue? Value
---@return Value
function DataLoader:get(name, defaultValue)
    ---@type Value
    local value = self.data[name]
    if value == nil then
        if defaultValue == nil then return 0 else return defaultValue end
    else
        return value
    end
end

---@param action fun(key: string, value: Value)
function DataLoader:forEach(action)
    for key, value in pairs(self.data) do
        action(key, value)
    end
end

function DataLoader:load()
    self.data = DataLoader.loadTable(self.reader)
end

---@param reader Script4LoadData
---@return table
function DataLoader.loadTable(reader)
    local data = DataEntryStack.new()
    data:read(reader)
    local value = Parser.readValue(data)
    data:clear()
    if type(value) ~= "table" then return {} end
    return value
end


---@class LocalVariablesPool
LocalVariablesPool = {}
LocalVariablesPool.__index = LocalVariablesPool
LocalVariablesPool.__name = "Krampus1721.LocalVariablesPool"

---@param writer Script4SaveData
function LocalVariablesPool:save(writer)
    local ds = DataSaver.new(writer)
    ds:putAll(self)
    ds:save()
end

---@param reader Script4LoadData
function LocalVariablesPool:load(reader)
    local dl = DataLoader.new(reader)
    dl:load()
    dl:forEach(function(key, value)
        self[key] = value
    end)
end

---@param name string
---@param value Value
function LocalVariablesPool:set(name, value)
    rawset(self, name, value)
end

---@param name string
---@return Value|nil
function LocalVariablesPool:get(name)
    return rawget(self, name)
end

---@param name string
---@param defaultValue? integer
---@return integer
function LocalVariablesPool:getInt(name, defaultValue)
    local value = self:get(name)
    if value == nil or type(value) ~= "number" then
        return defaultValue == nil and 0 or defaultValue--[[@as integer]]
    end
    return value
end

---@param name string
---@param defaultValue? boolean
---@return boolean
function LocalVariablesPool:getBool(name, defaultValue)
    local value = self:get(name)
    if value == nil or type(value) ~= "boolean" then
        return defaultValue == nil and false or defaultValue--[[@as boolean]]
    end
    return value
end

---@param name string
---@param defaultValue? number
---@return number
function LocalVariablesPool:getFloat(name, defaultValue)
    local value = self:get(name)
    if value == nil or type(value) ~= "number" then
        return defaultValue == nil and 0 or defaultValue--[[@as number]]
    end
    return value
end

---@param name string
---@param defaultValue? string
---@return string
function LocalVariablesPool:getString(name, defaultValue)
    local value = self:get(name)
    if value == nil or type(value) ~= "string" then
        return defaultValue == nil and "" or defaultValue--[[@as string]]
    end
    return value
end

---@param name string
---@param defaultValue? table
---@return table
function LocalVariablesPool:getTable(name, defaultValue)
    local value = self:get(name)
    if value == nil or type(value) ~= "table" then
        return defaultValue == nil and {} or defaultValue--[[@as table]]
    end
    return value
end

function LocalVariablesPool.new()
    ---@type LocalVariablesPool
    local obj = {}
    setmetatable(obj, LocalVariablesPool)

    return obj
end
