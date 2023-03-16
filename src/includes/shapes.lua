--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     shapes
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

if __DEFINED_KRAMPUS1721_INCLUDES_SHAPES then return end
__DEFINED_KRAMPUS1721_INCLUDES_SHAPES = true

import(Module_Shapes)
include("includes/things.lua")
include("includes/buildings.lua")
include("includes/map.lua")


---@enum ShapeMode
ShapeMode = {
    SetTemporal = 0,
    RemoveTemporal = 1,
    SetPermanent = 2,
    RemovePermanent = 3,
    ConvertToBuilding = 4
}


---@param x integer
---@param z integer
---@overload fun(coords: AnyCoord)
---@overload fun(cellIndex: integer)
---@return integer
local function AnyPosToCellIndex(x, z)
    if z ~= nil then
        return Map.getCellIndex(Coord.get2DFromMapXZ(x, z))
    end
    if type(x) == "number" then
        return x
    end
    return Map.getCellIndex(x--[[@as AnyCoord]])
end


Shape = {}

---@param tribe Tribe
---@param buildingModel BuildingModel
---@param orient BuildingOrientation
---@param mode ShapeMode
---@param x integer
---@param z integer
---@overload fun(tribe: Tribe, buildingModel: BuildingModel, orient: BuildingOrientation, mode: ShapeMode, coords: AnyCoord)
---@overload fun(tribe: Tribe, buildingModel: BuildingModel, orient: BuildingOrientation, mode: ShapeMode, cellIndex: integer)
function Shape.create(tribe, buildingModel, orient, mode, x, z)
    process_shape_map_elements(AnyPosToCellIndex(x, z), buildingModel, orient, tribe, mode)
end

---@param tribe Tribe
---@param buildingModel BuildingModel
---@param orient BuildingOrientation
---@param x integer
---@param z integer
---@return boolean
---@overload fun(tribe: Tribe, buildingModel: BuildingModel, orient: BuildingOrientation, mode: ShapeMode, coords: AnyCoord): boolean
---@overload fun(tribe: Tribe, buildingModel: BuildingModel, orient: BuildingOrientation, mode: ShapeMode, cellIndex: integer): boolean
function Shape.isValidAtPos(tribe, buildingModel, orient, x, z)
    return is_shape_valid_at_map_pos(AnyPosToCellIndex(x, z), buildingModel, orient, tribe) ~= 0
end
