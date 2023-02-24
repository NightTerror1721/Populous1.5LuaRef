--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     map
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

if __DEFINED_KRAMPUS1721_INCLUDES_MAP then return end
__DEFINED_KRAMPUS1721_INCLUDES_MAP = true


import(Module_Globals)
import(Module_System)
import(Module_Map)
include("includes/coords.lua")


local _gsi = gsi()


Map = {}

---@param coords AnyCoord
---@return boolean
function Map.isLand(coords)
    return is_map_point_land(Coord.to2D(coords)) ~= 0
end

---@param coords AnyCoord
---@return boolean
function Map.isSea(coords)
    return is_map_point_sea(Coord.to2D(coords)) ~= 0
end

---@param x integer
---@param z integer
---@param direction integer
---@return boolean
---@overload fun(coords: AnyCoord, direction: integer): boolean
function Map.isSubCellWalkableInDirection(x, z, direction)
    if type(x) ~= "number" then
        direction = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    return is_sub_cell_walkable_in_direction(x, z, direction) ~= 0
end

---@param cell integer
---@return boolean
function Map.isCellFlatAndLand(cell)
    return is_map_cell_flat_and_land(cell) ~= 0
end

---@param cell integer
---@return boolean
function Map.isCellFlat(cell)
    return is_map_cell_flat(cell) ~= 0
end

---@param cell integer
---@return boolean
function Map.isCellLand(cell)
    return is_map_cell_land(cell) ~= 0
end

---@param cell integer
---@param radius integer
---@return boolean
function Map.isCellNearCoast(cell, radius)
    return is_map_cell_near_coast(cell, radius) ~= 0
end

---@param coords1 AnyCoord|integer
---@param coords2 AnyCoord|integer
---@return integer
function Map.getWorldDist(coords1, coords2)
    if type(coords1) == "number" then
        return get_world_dist_xz_cell(coords1, coords2--[[@as integer]])
    end

    local type = Coord.getType(coords1--[[@as AnyCoord]])
    if type == CoordType.Coord2D then
        return get_world_dist_xz(coords1--[[@as Coord2D]], Coord.to2D(coords2--[[@as AnyCoord]]))
    elseif type == CoordType.Coord3D then
        return get_world_dist_xyz(coords1--[[@as Coord3D]], Coord.to3D(coords2--[[@as AnyCoord]]))
    else
        return get_world_dist_xz_cell((coords1--[[@as MapPosXZ]]).Pos, Coord.toMapPos(coords2--[[@as AnyCoord]]).Pos);
    end
end

---@param coords AnyCoord|integer
function Map.getMaxAltitudeDifferenceFor(coords)
    if type(coords) == "number" then
        return get_max_alt_diff_for_cell(coords)
    end
    return get_max_alt_diff_for_coord2d(Coord.to2D(coords--[[@as AnyCoord]]))
end

---@param x integer
---@param z? integer
---@return MapElement
---@overload fun(coords: AnyCoord)
function Map.getElement(x, z)
    if type(x) == "number" then
        if z == nil then
            return _gsi.Level.MapElements[x]
        else
            return world_coord2d_to_map_ptr(Coord.get2DFromMapXZ(x, z))
        end
    end
    local type = Coord.getType(x--[[@as AnyCoord]])
    if type == CoordType.Coord2D then
        return world_coord2d_to_map_ptr(x--[[@as Coord2D]])
    elseif type == CoordType.Coord3D then
        return world_coord3d_to_map_ptr(x--[[@as Coord3D]])
    else
        return world_coord2d_to_map_ptr(Coord.get2DFromMapXZ((x--[[@as MapPosXZ]]).XZ.X, (x--[[@as MapPosXZ]]).XZ.Z))
    end
end

---@param elem MapElement|integer
---@return Coord2D
function Map.get2D(elem)
    local coords = Coord.new2D()
    if type(elem) == "number" then
        map_idx_to_world_coord2d(elem, coords)
    else
        map_ptr_to_world_coord2d(elem--[[@as MapElement]], coords)
    end
    return coords
end

---@param elem MapElement|integer
---@return Coord2D
function Map.get2DCenter(elem)
    local coords = Coord.new2D()
    if type(elem) == "number" then
        map_idx_to_world_coord2d_centre(elem, coords)
    else
        map_ptr_to_world_coord2d_centre(elem--[[@as MapElement]], coords)
    end
    return coords
end

---@param elem MapElement|integer
---@return Coord3D
function Map.get3D(elem)
    if type(elem) == "number" then
        local coords = Coord.new3D()
        map_idx_to_world_coord3d(elem, coords)
        return coords
    else
        return Coord.to3D(Map.get2D(elem))
    end
end

---@param elem MapElement|integer
---@return Coord3D
function Map.get3DCenter(elem)
    if type(elem) == "number" then
        local coords = Coord.new3D()
        map_idx_to_world_coord3d_centre(elem, coords)
        return coords
    else
        return Coord.to3D(Map.get2DCenter(elem))
    end
end

---@param elem MapElement
---@return boolean
function Map.isElemCoast(elem)
    return is_map_elem_coast(elem) ~= 0
end

---@param elem MapElement
---@return boolean
function Map.isElemAllLand(elem)
    return is_map_elem_all_land(elem) ~= 0
end

---@param elem MapElement
---@return boolean
function Map.isElemAllSea(elem)
    return is_map_elem_all_sea(elem) ~= 0
end

---@param elem MapElement
---@return boolean
function Map.isElemAllGrass(elem)
    return is_map_elem_all_grass(elem) ~= 0
end

---@param elem MapElement
---@return boolean
function Map.isElemSeaOrCoast(elem)
    return is_map_elem_sea_or_coast(elem) ~= 0
end

---@param elem MapElement
---@return boolean
function Map.isElemLandOrCoast(elem)
    return is_map_elem_land_or_coast(elem) ~= 0
end

---@param coords AnyCoord
---@return boolean
function Map.isAtCellCenter(coords)
    return is_coord2d_at_cell_centre(Coord.to2D(coords)) ~= 0
end

---@param cell integer
---@return boolean
function Map.isCellObstacleFree(cell)
    return is_map_cell_obstacle_free(cell) ~= 0
end


---@param thing Thing
---@return boolean
function Map.isThingOnGround(thing)
    return is_thing_on_ground(thing) ~= 0
end

---@param coords AnyCoord
---@return boolean
function Map.isCoordOnGround(coords)
    return is_coord_on_ground(Coord.to3D(coords)) ~= 0
end

---@param coords AnyCoord
---@param thing Thing
---@return boolean
function Map.isPointTooSteepForMovingThing(coords, thing)
    return is_point_too_steep_for_moving_thing(Coord.to2D(coords), thing) ~= 0
end

---@param coords1 AnyCoord
---@param coords2 AnyCoord
---@return boolean
function Map.areCoordsOnSameMapCell(coords1, coords2)
    return are_coords_on_same_map_cell(
        Coord.to2D(coords1),
        Coord.to2D(coords2)
    ) ~= 0
end

---@param elem MapElement
---@param tribe Tribe
function Map.setElemOwner(elem, tribe)
    set_map_elem_owner(elem, tribe)
end

---@param coords AnyCoord
---@param thing Thing
---@return Coord3D
function Map.validateThingCoord(coords, thing)
    local c3d = Coord.to3D(coords)
    validate_thing_coord(c3d, thing)
    return c3d
end

---@param elem MapElement
---@param num integer
function Map.setElemLavaNum(elem, num)
    set_map_elem_lava_num(elem, num)
end

---@param elem MapElement
---@return integer
function Map.getElemLavaNum(elem, num)
    return get_map_elem_lava_num(elem)
end

---@param world_x integer
---@param world_z integer
---@return integer
---@overload fun(coords: AnyCoord): integer
function Map.getAltitude(world_x, world_z)
    if type(world_x) ~= "number" then
        local c2d = Coord.to2D(world_x--[[@as AnyCoord]])
        world_x = c2d.Xpos
        world_z = c2d.Zpos
    end
    return point_altitude(world_x, world_z)
end

---@param world_x integer
---@param world_z integer
---@return integer
---@overload fun(coords: AnyCoord): integer
function Map.getAltitudeWithObjects(world_x, world_z)
    if type(world_x) ~= "number" then
        local c2d = Coord.to2D(world_x--[[@as AnyCoord]])
        world_x = c2d.Xpos
        world_z = c2d.Zpos
    end
    return point_altitude_with_objects(world_x, world_z)
end

---@param coords AnyCoord|integer
---@return integer
function Map.getCellIndex(coords)
    if type(coords) == "number" then return coords end
    local type = Coord.getType(coords--[[@as AnyCoord]])
    if type == CoordType.Coord2D then
        return world_coord2d_to_map_idx(coords--[[@as Coord2D]])
    elseif type == CoordType.Coord3D then
        return world_coord3d_to_map_idx(coords--[[@as Coord3D]])
    else
        return (coords--[[@as MapPosXZ]]).Pos
    end
end


---@enum Map.SearchShape
Map.SearchShape = {
    Square = SQUARE,
    Circular = CIRCULAR
}

---@param shape Map.SearchShape
---@param radius integer
---@param coords AnyCoord|integer
---@param action fun(elem: MapElement): boolean
function Map.search(shape, radius, coords, action)
    coords = Map.getCellIndex(coords)
    SearchMapCells(shape, 0, 0, radius, coords, action)
end



FOW = {}

---@param tribe Tribe
---@param radius integer
---@param elem MapElement
function FOW.uncoverElement(tribe, radius, elem)
    Map.search(Map.SearchShape.Circular, radius, Map.get2D(elem), function(e)
        _gsi.FogOfWar:uncover(tribe, e)
        return true
    end)
end

---@param tribe Tribe
---@param radius integer
---@param x integer
---@param z? integer
---@overload fun(coords: AnyCoord)
function FOW.uncover(tribe, radius, x, z)
    FOW.uncoverElement(tribe, radius, Map.getElement(x, z))
end

---@param tribe Tribe
---@param radius integer
---@param elem MapElement
function FOW.uncoverPermanentElement(tribe, radius, elem)
    Map.search(Map.SearchShape.Circular, radius, Map.get2D(elem), function(e)
        _gsi.FogOfWar:perm_uncover(tribe, e)
        return true
    end)
end

---@param tribe Tribe
---@param radius integer
---@param x integer
---@param z? integer
---@overload fun(coords: AnyCoord)
function FOW.uncoverPermanent(tribe, radius, x, z)
    FOW.uncoverPermanentElement(tribe, radius, Map.getElement(x, z))
end

---@param radius integer
---@param elem MapElement
function FOW.uncoverForAllPlayersElement(radius, elem)
    Map.search(Map.SearchShape.Circular, radius, Map.get2D(elem), function(e)
        _gsi.FogOfWar:uncover_for_all_players(e)
        return true
    end)
end

---@param radius integer
---@param x integer
---@param z? integer
---@overload fun(coords: AnyCoord)
function FOW.uncoverForAllPlayers(radius, x, z)
    FOW.uncoverForAllPlayersElement(radius, Map.getElement(x, z))
end

---@param radius integer
---@param elem MapElement
function FOW.uncoverPermanentForAllPlayersElement(radius, elem)
    Map.search(Map.SearchShape.Circular, radius, Map.get2D(elem), function(e)
        _gsi.FogOfWar:perm_uncover_all_players(e)
        return true
    end)
end

---@param radius integer
---@param x integer
---@param z? integer
---@overload fun(coords: AnyCoord)
function FOW.uncoverPermanentForAllPlayers(radius, x, z)
    FOW.uncoverPermanentForAllPlayersElement(radius, Map.getElement(x, z))
end

---@param elem MapElement
---@return boolean
function FOW.isUncoveredElement(elem)
    return _gsi.FogOfWar:is_uncovered(elem) ~= 0
end
