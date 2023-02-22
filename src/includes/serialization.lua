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

---@enum ValueSerializationStatus
local ValueSerializationStatus = {
    Ok = 0,
    Error = 1,
    EndPart = 5,
}

---@param n number
local function IsInteger(n)
    return math.floor(n) == n
end

---@param writer Script4SaveData
---@param type ValueType
local function WriteType(writer, type)
    writer:push_int(type)
end

---@param writer Script4SaveData
---@param value Value
local function WriteValue(writer, value)
    local vtype = type(value)
    if vtype == "number" then
        if IsInteger(value) then
            WriteType(writer, ValueType.Integer)
            writer:push_int(value)
        else
            WriteType(writer, ValueType.Float)
            writer:push_float(value)
        end
    elseif vtype == "boolean" then
        WriteType(writer, ValueType.Boolean)
        writer:push_bool(value)
    elseif vtype == "string" then
        WriteType(writer, ValueType.String)
        writer:push_string(value)
    elseif vtype == "table" then
        WriteType(writer, ValueType.Table)
        for index, tableValue in ipairs(value) do
            writer:push_int(index)
            WriteValue(writer, tableValue)
        end
        writer:push_int(ValueSerializationStatus.EndPart)
        for key, tableValue in pairs(value) do
            if type(key) == "string" then
                writer:push_string(key)
                WriteValue(writer, tableValue)
            end
        end
        writer:push_int(ValueSerializationStatus.EndPart)
    end
end


---@param reader Script4LoadData
---@param vtype integer
---@return Value
local function ReadValue0(reader, vtype)
    if vtype == ValueType.Integer then
        return reader:pop_int()
    elseif vtype == ValueType.Boolean then
        return reader:pop_bool()
    elseif vtype == ValueType.Number then
        return reader:pop_float()
    elseif vtype == ValueType.String then
        return reader:pop_string()
    elseif vtype == ValueType.Table then
        local value = {}
        while true do
            local evtype = reader:pop_int()
            if evtype == ValueSerializationStatus.EndPart then
                break
            end
            local index = reader:pop_int()
            local entryValue = ReadValue0(reader, reader:pop_int())
            value[index] = entryValue
        end
        while true do
            local evtype = reader:pop_int()
            if evtype == ValueSerializationStatus.EndPart then
                break
            end
            local key = reader:pop_string()
            local entryValue = ReadValue0(reader, reader:pop_int())
            value[key] = entryValue
        end
        return value
    else
        return 0
    end
end

---@param reader Script4LoadData
local function ReadValue(reader)
    return ReadValue0(reader, reader:pop_int())
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

function DataSaver:save()
    WriteValue(self.writer, self.data)
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

function DataLoader:load()
    local value = ReadValue(self.reader)
    if type(value) ~= "table" then
        return false
    else
        self.data = value
        return true
    end
end
