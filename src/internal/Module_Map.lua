---@meta


---@param mapPos MapPosXZ
---@param coords Coord3D
---@return Coord3D
---@overload fun(x: integer, z: integer): Coord3D
function MAP_XZ_2_WORLD_XYZ(mapPos, coords) end

---@param elem MapElement
---@return integer
function MAP_ELEM_PTR_2_IDX(elem) end

---@param coords Coord3D
function ensure_point_on_ground(coords) end

---@param coords Coord2D
---@return integer
function is_map_point_land(coords) end

---@param x integer
---@param z integer
---@param direction integer
---@return integer
function is_sub_cell_walkable_in_direction(x, z, direction) end

---@param cell integer
---@param player integer
---@return integer
function is_map_cell_a_building_belonging_to_player(cell, player) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
---@return integer
function is_map_cell_n_squares_away_from_other_owned_building(arg0, arg1, arg2) end

---@param cell integer
---@return integer
function is_map_cell_flat_and_land(cell) end

---@param cell integer
---@return integer
function is_map_cell_flat(cell) end

---@param cell integer
---@return integer
function is_map_cell_land(cell) end

---@param coords Coord2D
---@return integer
function is_map_point_sea(coords) end

---@param cell integer
---@param radius integer
---@return integer
function is_map_cell_near_coast(cell, radius) end

---@param player Player
---@param cell integer
---@param arg2 integer
---@param arg3 integer
---@param arg4 integer
---@param arg5 integer
---@return integer
function is_map_cell_bldg_markable(player, cell, arg2, arg3, arg4, arg5) end

---@param cell integer
---@param arg1 integer
---@param arg2 integer
---@return integer
function is_cell_markable_with_near_bldgs_and_markers(cell, arg1, arg2) end

---@param elemList unknown
---@param arg1 integer
---@return integer
function are_list_map_elems_flat(elemList, arg1) end

---@param arg0 integer
---@param arg1 integer
---@return integer
function are_surround_cells_too_steep_for_building(arg0, arg1) end

---@param arg0 integer
---@return integer
function are_surround_cells_too_steep_for_wall(arg0) end

---@param arg0 integer
---@return integer
function are_surround_cells_all_land(arg0) end

---@param coords1 Coord3D
---@param coords2 Coord3D
---@return integer
function get_world_dist_xyz(coords1, coords2) end

---@param coords Coord2D
---@param elem MapElement
---@param arg2 integer
---@return integer
function get_coastline_point(coords, elem, arg2) end

---@param cell Coord2D
---@param arg1 integer
---@param arg2 integer
function get_max_and_min_alts_for_cell(cell, arg1, arg2) end

---@param coords Coord2D
---@return integer
function get_max_alt_diff_for_coord2d(coords) end

---@param arg0 integer
---@return integer
function get_shade_from_dir_code(arg0) end

---@param cell integer
---@return integer
function get_max_alt_diff_for_cell(cell) end

---@param square unknown
---@param arg1 integer
---@param arg2 integer
---@return integer
function get_map_square_from_map_idxs(square, arg1, arg2) end

---@param elemList unknown
---@param arg1 integer
---@return integer
function get_map_elem_list_average_alt(elemList, arg1) end

---@param cell integer
---@param elemId integer
---@return MapElement
function get_cell_surround_map_element(cell, elemId) end

---@param arg0 integer
---@param arg1 integer
---@param coords1 integer
---@param coords2 integer
---@return Thing
function get_closest_map_cell_thing_type(arg0, arg1, coords1, coords2) end

---@param coords1 Coord2D
---@param coords2 Coord2D
---@return integer
function get_world_dist_xz(coords1, coords2) end

---@param coords1 integer
---@param coords2 integer
---@return integer
function get_dist_xz_cell_quick(coords1, coords2) end

---@param coords1 Coord2D
---@param coords2 Coord2D
---@return integer
function get_world_dist_xz_quick(coords1, coords2) end

---@param coords1 Coord3D
---@param coords2 Coord3D
---@return integer
function get_world_dist_xyz_quick(coords1, coords2) end

---@param cell1 integer
---@param cell2 integer
---@return integer
function get_world_dist_xz_cell(cell1, cell2) end

---@param arg0 integer
---@param arg1 integer
---@return integer
function get_wrap_dist_1d(arg0, arg1) end

---@param arg0 integer
---@param arg1 integer
---@return integer
function get_signed_wrap_world_dist_1d(arg0, arg1) end

---@param coords Coord2D
---@return MapElement
function world_coord2d_to_map_ptr(coords) end

---@param coords Coord3D
---@return MapElement
function world_coord3d_to_map_ptr(coords) end

---@param coords Coord2D
---@return integer
function world_coord2d_to_map_idx(coords) end

---@param coords Coord3D
---@return integer
function world_coord3d_to_map_idx(coords) end

---@param elem MapElement
---@param coords Coord2D
function map_ptr_to_world_coord2d(elem, coords) end

---@param elem MapElement
---@param coords Coord2D
function map_ptr_to_world_coord2d_centre(elem, coords) end

---@param idx integer
---@param coords Coord2D
function map_idx_to_world_coord2d(idx, coords) end

---@param idx integer
---@param coords Coord2D
function map_idx_to_world_coord2d_centre(idx, coords) end

---@param cell integer
---@param coords Coord2D
function map_idx_sub_cell_to_world_coord2d_centre(cell, coords) end

---@param idx integer
---@param coords Coord3D
function map_idx_to_world_coord3d(idx, coords) end

---@param idx integer
---@param coords Coord3D
function map_idx_to_world_coord3d_centre(idx, coords) end

---@param idx integer
---@param coords Coord3D
function map_idx_to_world_coord3d_no_alt(idx, coords) end

---@param idx integer
---@param coords Coord3D
function map_idx_to_world_coord3d_centre_no_alt(idx, coords) end

---@param x integer
---@param z integer
---@param coords Coord2D
function map_xz_to_world_coord2d(x, z, coords) end

---@param cell integer
---@return integer
function world_to_in_cell_position(cell) end

---@param cell integer
---@return integer
function world_coord_start_of_cell(cell) end

---@param elem MapElement
---@return integer
function get_map_elem_collide_table_idx(elem) end

---@param elem MapElement
---@param idx integer
function set_map_elem_collide_table_idx(elem, idx) end

---@param elem MapElement
---@param player integer
---@return integer
function is_map_elem_warrior_in_drum_tower_flag_set_for_player(elem, player) end

---@param elem MapElement
---@return integer
function is_map_elem_coast(elem) end

---@param elem MapElement
---@return integer
function is_map_elem_all_land(elem) end

---@param elem MapElement
---@return integer
function is_map_elem_all_sea(elem) end

---@param elem MapElement
---@return integer
function is_map_elem_all_grass(elem) end

---@param elem MapElement
---@return integer
function is_map_elem_sea_or_coast(elem) end

---@param elem MapElement
---@return integer
function is_map_elem_land_or_coast(elem) end

---@param coords Coord2D
---@return integer
function is_coord2d_at_cell_centre(coords) end

---@param coords Coord2D
function centre_coord_on_block(coords) end

---@param coords Coord3D
function entre_coord3d_on_block(coords) end

---@param coords Coord2D
function zero_coord_on_block(coords) end

---@param coords Coord2D
function randomize_coord_on_block(coords) end

---@param coords Coord3D
function zero_coord3d_on_block(coords) end

---@param cell integer
---@return integer
function is_building_on_map_cell(cell) end

---@param thing Thing
function ensure_thing_on_ground(thing) end

---@param coords Coord3D
function ensure_point_above_ground(coords) end

---@param cell integer
---@return integer
function is_map_cell_obstacle_free(cell) end

---@param thing Thing
---@return integer
function is_thing_on_ground(thing) end

---@param coords Coord3D
---@return integer
function is_coord_on_ground(coords) end

---@param coords Coord2D
---@param thing Thing
---@return integer
function is_point_too_steep_for_moving_thing(coords, thing) end

---@param coords Coord2D
---@param arg1 integer
---@return integer
function is_point_steeper_than(coords, arg1) end

---@param cell integer
---@param arg1 integer
---@return integer
function is_cell_too_steep_for_building(cell, arg1) end

---@param cell integer
---@param arg1 integer
---@return integer
function is_cell_too_steep_for_building_destroy(cell, arg1) end

---@param srcCoords Coord2D
---@param dstCoords Coord3D
function coord2D_to_coord3D(srcCoords, dstCoords) end

---@param srcCoords Coord3D
---@param dstCoords Coord2D
function coord3D_to_coord2D(srcCoords, dstCoords) end

---@param coords Coord2D
---@param elemList unknown
function get_four_surround_map_cell_info(coords, elemList) end

---@param arg0 integer
---@param elemList unknown
function get_four_alt_surround_map_cell_info(arg0, elemList) end

---@param coords Coord2D
---@param elemList unknown
function get_nine_surround_map_cell_info(coords, elemList) end

---@param coords Coord2D
---@param waypoint unknown
function coord2d_to_jnav_point(coords, waypoint) end

---@param waypoint unknown
---@param coords Coord2D
function jnav_point_to_coord2d(waypoint, coords) end

---@param waypoint1 unknown
---@param waypoint2 unknown
---@return integer
function get_jnav_point_dist_sq(waypoint1, waypoint2) end

---@param thing Thing
---@param waypoint1 unknown
---@param waypoint2 unknown
function get_jnav_thing_start_and_end_points(thing, waypoint1, waypoint2) end

---@param coords1 Coord2D
---@param coords2 Coord2D
---@return integer
function are_coords_on_same_map_cell(coords1, coords2) end

---@param elem MapElement
---@param team integer
function set_map_elem_owner(elem, team) end

---@param coords Coord3D
---@param thing Thing
function validate_thing_coord(coords, thing) end

---@param pos MapPosXZ
---@param arg1 integer
function increment_map_idx_by_orient(pos, arg1) end

---@param elem MapElement
---@param arg1 integer
function set_map_elem_object_shadow(elem, arg1) end

---@param elem MapElement
---@return integer
function get_map_elem_object_shadow(elem) end

---@param elem MapElement
---@param num integer
function set_map_elem_lava_num(elem, num) end

---@param elem MapElement
---@return integer
function get_map_elem_lava_num(elem) end

---@param wx integer
---@param wz integer
---@return integer
function point_altitude_with_objects(wx, wz) end

---@param wx integer
---@param wz integer
---@return integer
function point_altitude(wx, wz) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
function set_square_map_params(arg0, arg1, arg2) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
function affect_mapwho_area(arg0, arg1, arg2) end

---@param shape `SQUARE`|`CIRCULAR`
---@param arg1 0
---@param arg2 0
---@param radius integer
---@param coord_idx integer
---@param action fun(elem: MapElement)
function SearchMapCells(shape, arg1, arg2, radius, coord_idx, action) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
---@param arg3 integer
---@param arg4 integer
---@param action fun(elem: MapElement, pos: MapPosXZ)
function SearchMapCellsXZ(arg0, arg1, arg2, arg3, arg4, action) end
