--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     coords
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

if __DEFINED_KRAMPUS1721_INCLUDES_COORDS then return end
__DEFINED_KRAMPUS1721_INCLUDES_COORDS = true

import(Module_DataTypes)
import(Module_Map)
import(Module_Table)
import(Module_String)

---@alias AnyCoord Coord2D | Coord3D | MapPosXZ

---@return string
local function GetClassType(class)
    local instance = class.new()
    return getmetatable(instance).__name
end

CoordType = {
    Coord2D = GetClassType(Coord2D),
    Coord3D = GetClassType(Coord3D),
    MapPosXZ = GetClassType(MapPosXZ)
}

local CoordTypeMap = {
    [CoordType.Coord2D] = CoordType.Coord2D,
    [CoordType.Coord3D] = CoordType.Coord3D,
    [CoordType.MapPosXZ] = CoordType.MapPosXZ,
    [CoordType.Coord2D.."*"] = CoordType.Coord2D,
    [CoordType.Coord3D.."*"] = CoordType.Coord3D,
    [CoordType.MapPosXZ.."*"] = CoordType.MapPosXZ
}

Coord = {}

---@param coords AnyCoord
---@return string
function Coord.getType(coords)
    return CoordTypeMap[getmetatable(coords).__name--[[@as string]]]
end


---@param coords Coord2D
---@return Coord2D
---@overload fun(coords: Coord3D): Coord3D
---@overload fun(coords: MapPosXZ): MapPosXZ
function Coord.copy(coords)
    local ctype = Coord.getType(coords)
    if ctype == CoordType.Coord2D then
        local copy = Coord2D.new()
        copy.Xpos = (coords--[[@as Coord2D]]).Xpos
        copy.Zpos = (coords--[[@as Coord2D]]).Zpos
        return copy
    elseif ctype == CoordType.Coord3D then
        local copy = Coord3D.new()
        copy.Xpos = (coords--[[@as Coord3D]]).Xpos
        copy.ypos = (coords--[[@as Coord3D]]).Ypos
        copy.Zpos = (coords--[[@as Coord3D]]).Zpos
        return copy
    else
        local copy = MapPosXZ.new()
        copy.Pos = (coords--[[@as MapPosXZ]]).Pos
        return copy
    end
end

---@param coords AnyCoord
---@return Coord2D
function Coord.to2D(coords)
    local coord = Coord2D.new()
    local ctype = Coord.getType(coords)
    if ctype == CoordType.MapPosXZ then
        map_idx_to_world_coord2d(coords.Pos, coord)
    elseif ctype == CoordType.Coord3D then
        coord3D_to_coord2D(coords--[[@as Coord3D]], coord)
    else
        coord.Xpos = coords.Xpos
        coord.Zpos = coords.Zpos
    end
        return coord
end

---@param x integer
---@param z integer
---@overload fun(coords: AnyCoord): Coord2D
---@overload fun(): Coord2D
---@return Coord2D
function Coord.new2D(x, z)
    if x == nil then
        return Coord2D.new()
    elseif z ~= nil then
        local coord = Coord2D.new()
        coord.Xpos = x
        coord.Zpos = z
        return coord
    else
        return Coord.to2D(x--[[@as AnyCoord]])
    end
end

---@param coords AnyCoord
---@return Coord3D
function Coord.to3D(coords)
    local coord = Coord3D.new()
    local ctype = Coord.getType(coords)
    if ctype == CoordType.MapPosXZ then
        map_idx_to_world_coord3d(coords.Pos, coord)
    elseif ctype == CoordType.Coord3D then
        coord.Xpos = coords.Xpos
        coord.Ypos = coords.Ypos
        coord.Zpos = coords.Zpos
    else
        coord2D_to_coord3D(coords--[[@as Coord2D]], coord)
    end
        return coord
end

---@param x integer
---@param y integer
---@param z integer
---@overload fun(coords: AnyCoord): Coord3D
---@overload fun(): Coord3D
---@return Coord3D
function Coord.new3D(x, y, z)
    if x == nil then
        return Coord3D.new()
    elseif y ~= nil then
        local coord = Coord3D.new()
        coord.Xpos = x
        coord.Xpos = y
        coord.Zpos = z
        return coord
    else
        return Coord.to3D(x--[[@as AnyCoord]])
    end
end

---@param coords AnyCoord
---@return MapPosXZ
function Coord.toMapPos(coords)
    local coord = MapPosXZ.new()
    local ctype = Coord.getType(coords)
    if ctype == CoordType.MapPosXZ then
        coord.Pos = coords.Pos
        coord.XZ.X = coords.XZ.X
        coord.XZ.Z = coords.XZ.Z
    elseif ctype == CoordType.Coord3D then
        coord.Pos = world_coord3d_to_map_idx(coords--[[@as Coord3D]])
    else
        coord.Pos = world_coord2d_to_map_idx(coords--[[@as Coord2D]])
    end
        return coord
end

---@param x integer
---@param z integer
---@overload fun(idx: integer): MapPosXZ
---@overload fun(coords: AnyCoord): MapPosXZ
---@overload fun(): MapPosXZ
---@return MapPosXZ
function Coord.newMapPos(x, z)
    if x == nil then
        return MapPosXZ.new()
    elseif z ~= nil then
        local coord = MapPosXZ.new()
        coord.XZ.X = x
        coord.XZ.Z = z
        return coord
    elseif type(x) == "number" then
        local coord = MapPosXZ.new()
        coord.Pos = x
        return coord
    else
        return Coord.toMapPos(x--[[@as AnyCoord]])
    end
end

---@param x integer
---@param z integer
---@return Coord2D
function Coord.get2DFromMapXZ(x, z)
    local coord = Coord2D.new()
    map_xz_to_world_coord2d(x, z, coord)
    return coord
end

---@param x integer
---@param z integer
---@return Coord3D
function Coord.get3DFromMapXZ(x, z)
    return MAP_XZ_2_WORLD_XYZ(x, z)
end

---@param x integer
---@param z integer
---@return MapPosXZ
function Coord.getMapPosFromMapXZ(x, z)
    local coord = MapPosXZ.new()
    coord.XZ.X = x
    coord.XZ.Z = z
    return coord
end

---@param coords AnyCoord
---@return integer x, integer z
function Coord.getMapXZ(coords)
    local mapPos = Coord.toMapPos(coords)
    return mapPos.XZ.X, mapPos.XZ.Z
end


---@param coords Coord3D
function Coord.ensureOnGround(coords)
    ensure_point_on_ground(coords)
    return coords
end

---@param coords Coord3D
function Coord.ensureAboveround(coords)
    ensure_point_above_ground(coords)
    return coords
end

---@param thing Thing
function Coord.ensureThingOnGround(thing)
    ensure_thing_on_ground(thing)
    return thing
end

---@param coords Coord2D
---@return Coord2D
---@overload fun(coords: Coord3D): Coord3D
function Coord.centerOnBlock(coords)
    if Coord.getType(coords) == CoordType.Coord2D then
        centre_coord_on_block(coords)
    else
        entre_coord3d_on_block(coords--[[@as Coord3D]])
    end
    return coords
end

---@param coords Coord2D
---@return Coord2D
---@overload fun(coords: Coord3D): Coord3D
function Coord.zeroOnBlock(coords)
    if Coord.getType(coords) == CoordType.Coord2D then
        zero_coord_on_block(coords)
    else
        zero_coord3d_on_block(coords--[[@as Coord3D]])
    end
    return coords
end

---@param coords Coord2D
---@return Coord2D
function Coord.randomizeOnBlock(coords)
    randomize_coord_on_block(coords)
    return coords
end
