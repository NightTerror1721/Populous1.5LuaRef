--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     persons
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

if __DEFINED_KRAMPUS1721_INCLUDES_PERSONS then return end
__DEFINED_KRAMPUS1721_INCLUDES_PERSONS = true


import(Module_Globals)
import(Module_System)
import(Module_Players)
include("includes/flags.lua")
include("includes/coords.lua")
include("includes/things.lua")

local _gsi = gsi()

---@param tribe Tribe
local function GetPlayer(tribe)
    return getPlayer(tribe)
end


---@enum PersonOrientation
PersonOrientation = {
    North = 1000,
    NorthEast = 1250,
    East = 1500,
    SouthEast = 1750,
    South = 0,
    SouthWest = 250,
    West = 500,
    NorthWest = 750
}

local ValidOrientations = {
    [PersonOrientation.North] = PersonOrientation.North,
    [PersonOrientation.NorthEast] = PersonOrientation.NorthEast,
    [PersonOrientation.East] = PersonOrientation.East,
    [PersonOrientation.SouthEast] = PersonOrientation.SouthEast,
    [PersonOrientation.South] = PersonOrientation.South,
    [PersonOrientation.SouthWest] = PersonOrientation.SouthWest,
    [PersonOrientation.West] = PersonOrientation.West,
    [PersonOrientation.NorthWest] = PersonOrientation.NorthWest
}


---@class PersonInfo
---@field tribe Tribe
---@field model PersonModel
---@field private TribesPersons PersonInfo[][]
---@field Count PersonModel.COUNT
PersonInfo = {}
PersonInfo.__index = PersonInfo
PersonInfo.__name = "Krampus1721.PersonInfo"

PersonInfo.Count = PersonModel.COUNT

---@param tribe Tribe
---@param model PersonModel
---@return PersonInfo
local function CreateInstance(tribe, model)
    ---@type PersonInfo
    local obj = {}
    setmetatable(obj, PersonInfo)

    obj.tribe = tribe
    obj.model = model
    return obj
end

---@param tribe Tribe
---@param models PersonModel[]
---@param action fun(person: Thing): boolean|nil
---@overload fun(tribe: Tribe, model: PersonModel, action: fun(person: Thing): boolean|nil)
---@overload fun(tribe: Tribe, action: fun(person: Thing): boolean|nil)
function PersonInfo.forEachTribePerson(
    tribe,
    models,
    action
)
    if action == nil then
        ProcessGlobalTypeList(ThingType.Person, function(person)
            if person.Owner == tribe then
                local result = (models--[[@as fun(person: Thing): boolean|nil)]])(person)
                return result == nil or result == true
            else
                return true
            end
        end)
    else
        local checker;
        if type(models) == "number" then
            ---@param person Thing
            ---@param model PersonModel
            checker = function(person, model) return person.Model == model end
        else
            ---@param person Thing
            ---@param models_list PersonModel[]
            checker = function(person, models_list) return models_list[person.Model] ~= nil end
        end
        ProcessGlobalTypeList(ThingType.Person, function(person)
            if person.Owner == tribe and checker(person, models) then
                local result = action(person)
                return result == nil or result == true
            else
                return true
            end
        end)
    end
end

---@param models PersonModel[]
---@param action fun(person: Thing): boolean|nil
---@overload fun(tribe: Tribe, model: PersonModel, action: fun(person: Thing): boolean|nil)
---@overload fun(tribe: Tribe, action: fun(person: Thing): boolean|nil)
function PersonInfo.forEachPerson(
    models,
    action
)
    if action == nil then
        ProcessGlobalTypeList(ThingType.Person, function(person)
            local result = (models--[[@as fun(person: Thing): boolean|nil)]])(person)
            return result == nil or result == true
        end)
    else
        local checker;
        if type(models) == "number" then
            ---@param person Thing
            ---@param model PersonModel
            checker = function(person, model) return person.Model == model end
        else
            ---@param person Thing
            ---@param models_list PersonModel[]
            checker = function(person, models_list) return models_list[person.Model] ~= nil end
        end
        ProcessGlobalTypeList(ThingType.Person, function(person)
            if checker(person, models) then
                local result = action(person)
                return result == nil or result == true
            else
                return true
            end
        end)
    end
end

function PersonInfo:getNumInWorld()
    return GetPlayer(self.tribe).NumPeopleOfType[self.model]
end

function PersonInfo:getNumInBoats()
    return GetPlayer(self.tribe).NumLocalPeopleInBoats[self.model]
end

function PersonInfo:getNumInBalloons()
    return GetPlayer(self.tribe).NumLocalPeopleInBalloons[self.model]
end

---@param action fun(person: Thing): boolean|nil
function PersonInfo:forEachInWorld(action)
    PersonInfo.forEachTribePerson(self.tribe, self.model, action)
end

---@param coords AnyCoord
---@param orientation? PersonOrientation
---@return Thing
function PersonInfo:create(coords, orientation)
    local person = CreatePerson(self.model, self.tribe, Coord.to3D(coords))
    if person then
        orientation = orientation and ValidOrientations[orientation] or nil
        if orientation then person.AngleXZ = orientation end
    end
    return person
end



local OrderIdle = {
    [PersonState.WaitAtPoint] = true,
    [PersonState.WaitFirstAppear] = true,
    [PersonState.Spare] = true,
    [PersonState.AwaitingCommand] = true,
    [PersonState.Selected] = true,
    [PersonState.ReselectWait] = true,
    [PersonState.GotoBaseAndWait] = true
}

local OrderRunning = {
    [PersonState.Wander] = true,
    [PersonState.BaseWander] = true
}

local OrderOnHouse = {
    [PersonState.WaitAtBuilding] = true
}

---@param people_required integer
---@return Thing[] list, boolean minimum_required
function PersonInfo:getListOrderedByIdleFirst(people_required)
    local lists = {
        [1] = {},
        [2] = {},
        [3] = {},
        [4] = {}
    }
    local idle = lists[1]
    local running = lists[2]
    local onHouse = lists[3]
    local others = lists[4]
    ProcessGlobalSpecialList(self.tribe, PEOPLELIST, function(person)
        if person.Model ~= self.model then return true end
        local state = person.State
        if OrderIdle[state] then
            table.insert(idle, person)
        elseif OrderRunning[state] then
            table.insert(running, person)
        elseif OrderOnHouse[state] and not is_person_in_drum_tower(person) then
            table.insert(onHouse, person)
        else
            table.insert(others, person)
        end
        if #idle >= people_required then return false end
        return true
    end)

    local result = idle
    if #result >= people_required then return result, true end
    for i = 2, 4, 1 do
        for _, value in ipairs(lists[i]) do
            table.insert(result, value)
        end
        if #result >= people_required then return result, true end
    end
    return result, false
end




---@type PersonInfo[][]
PersonInfo.TribesPersons = {}
for tribe = 0, 10, 1 do
    local tribePersons = {}
    for personModel = 1, PersonInfo.Count, 1 do
        tribePersons[personModel] = CreateInstance(tribe, personModel)
    end
    PersonInfo.TribesPersons[tribe] = tribePersons
end

---@param tribe Tribe
---@param person PersonModel
---@return PersonInfo
function PersonInfo.get(tribe, person)
    return PersonInfo.TribesPersons[tribe][person]
end
