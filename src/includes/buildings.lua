--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     buildings
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

if __DEFINED_KRAMPUS1721_INCLUDES_BUILDINGS then return end
__DEFINED_KRAMPUS1721_INCLUDES_BUILDINGS = true

import(Module_Globals)
import(Module_System)
import(Module_Players)
include("includes/flags.lua")
include("includes/coords.lua")
include("includes/things.lua")

local _gsi = gsi()

---@param tribe Tribe
local function GetPlayerThings(tribe)
    return _gsi.ThisLevelInfo.PlayerThings[tribe]
end

---@param tribe Tribe
local function GetPlayer(tribe)
    return getPlayer(tribe)
end


---@enum BuildingOrientation
BuildingOrientation = {
    North = 1000,
    South = 0,
    East = 1500,
    West = 500
}

local ValidOrientations = {
    [BuildingOrientation.North] = BuildingOrientation.North,
    [BuildingOrientation.South] = BuildingOrientation.South,
    [BuildingOrientation.East] = BuildingOrientation.East,
    [BuildingOrientation.West] = BuildingOrientation.West
}


---@class BuildingInfo
---@field tribe Tribe
---@field model BuildingModel
---@field private TribesBuildings BuildingInfo[][]
---@field Count BuildingModel.COUNT
BuildingInfo = {}
BuildingInfo.__index = BuildingInfo
BuildingInfo.__name = "Krampus1721.BuildingInfo"

BuildingInfo.Count = BuildingModel.COUNT

---@param tribe Tribe
---@param model BuildingModel
---@return BuildingInfo
local function CreateInstance(tribe, model)
    ---@type BuildingInfo
    local obj = {}
    setmetatable(obj, BuildingInfo)

    obj.tribe = tribe
    obj.model = model
    return obj
end

---@param tribe Tribe
function BuildingInfo.getTribeBuildingsCount(tribe)
    return GetPlayer(tribe).NumBuildings
end

---@param tribe Tribe
---@param models BuildingModel[]
---@param action fun(building: Thing): boolean|nil
---@overload fun(tribe: Tribe, model: BuildingModel, action: fun(building: Thing): boolean|nil)
---@overload fun(tribe: Tribe, action: fun(building: Thing): boolean|nil)
function BuildingInfo.forEachTribeBuilding(
    tribe,
    models,
    action
)
    if action == nil then
        ProcessGlobalTypeList(ThingType.Building, function(building)
            if building.Owner == tribe then
                local result = (models--[[@as fun(building: Thing): boolean|nil)]])(building)
                return result == nil or result == true
            else
                return true
            end
        end)
    else
        local checker;
        if type(models) == "number" then
            ---@param building Thing
            ---@param model BuildingModel
            checker = function(building, model) return building.Model == model end
        else
            ---@param building Thing
            ---@param models_list BuildingModel[]
            checker = function(building, models_list) return models_list[building.Model] ~= nil end
        end
        ProcessGlobalTypeList(ThingType.Building, function(building)
            if building.Owner == tribe and checker(building, models) then
                local result = action(building)
                return result == nil or result == true
            else
                return true
            end
        end)
    end
end

---@param models BuildingModel[]
---@param action fun(building: Thing): boolean|nil
---@overload fun(tribe: Tribe, model: BuildingModel, action: fun(building: Thing): boolean|nil)
---@overload fun(tribe: Tribe, action: fun(building: Thing): boolean|nil)
function BuildingInfo.forEachBuilding(
    models,
    action
)
    if action == nil then
        ProcessGlobalTypeList(ThingType.Building, function(building)
            local result = (models--[[@as fun(building: Thing): boolean|nil)]])(building)
            return result == nil or result == true
        end)
    else
        local checker;
        if type(models) == "number" then
            ---@param building Thing
            ---@param model BuildingModel
            checker = function(building, model) return building.Model == model end
        else
            ---@param building Thing
            ---@param models_list BuildingModel[]
            checker = function(building, models_list) return models_list[building.Model] ~= nil end
        end
        ProcessGlobalTypeList(ThingType.Building, function(building)
            if checker(building, models) then
                local result = action(building)
                return result == nil or result == true
            else
                return true
            end
        end)
    end
end

---@param enabled boolean
function BuildingInfo:setEnabled(enabled)
    local data = GetPlayerThings(self.tribe)
    if enabled then
        data.BuildingsAvailable = Flags.setBit(data.BuildingsAvailable, self.model)
    else
        data.BuildingsAvailable = Flags.clearBit(data.BuildingsAvailable, self.model)
    end
end

function BuildingInfo:isEnabled()
    return Flags.isBitSet(GetPlayerThings(self.tribe).BuildingsAvailable, self.model)
end

---@param shots integer
function BuildingInfo:setOnceShots(shots)
    GetPlayerThings(self.tribe).BuildingsAvailableOnce[self.model] = math.max(0, shots)
end

function BuildingInfo:getOnceShots()
    return GetPlayerThings(self.tribe).BuildingsAvailableOnce[self.model]
end

---@param shots integer
function BuildingInfo:giveShots(shots)
    self:setOnceShots(self:getOnceShots() + math.max(0, shots))
end

---@param enabled boolean
function BuildingInfo:setLevelEnabled(enabled)
    local data = GetPlayerThings(self.tribe)
    if enabled then
        data.BuildingsAvailableLevel = Flags.setBit(data.BuildingsAvailableLevel, self.model)
    else
        data.BuildingsAvailableLevel = Flags.clearBit(data.BuildingsAvailableLevel, self.model)
    end
end

function BuildingInfo:isLevelEnabled()
    return Flags.isBitSet(GetPlayerThings(self.tribe).BuildingsAvailableLevel, self.model)
end

function BuildingInfo:getNumInWorld()
    return GetPlayer(self.tribe).NumBuildingsOfType[self.model]
end

---@param action fun(building: Thing): boolean|nil
function BuildingInfo:forEachInWorld(action)
    BuildingInfo.forEachTribeBuilding(self.tribe, self.model, action)
end

---@param coords AnyCoord
---@param orientation? BuildingOrientation
---@return Thing
function BuildingInfo:create(coords, orientation)
    local bldg = CreateBuilding(self.model, self.tribe, Coord.to3D(coords))
    if bldg then
        orientation = orientation and ValidOrientations[orientation] or nil
        if orientation then
            bldg.AngleXZ = orientation
        end
    end
    return bldg
end




---@type BuildingInfo[][]
BuildingInfo.TribesBuildings = {}
for tribe = 0, 10, 1 do
    local tribeBuildings = {}
    for buildingModel = 1, BuildingInfo.Count, 1 do
        tribeBuildings[buildingModel] = CreateInstance(tribe, buildingModel)
    end
    BuildingInfo.TribesBuildings[tribe] = tribeBuildings
end

---@param tribe Tribe
---@param building BuildingModel
---@return BuildingInfo
function BuildingInfo.get(tribe, building)
    return BuildingInfo.TribesBuildings[tribe][building]
end
