---@meta

---@param arg0 integer
---@param arg1 integer
---@return boolean
function is_cmd_relevant_for_person_model(arg0, arg1) end

---@param pray Thing
---@param coord Coord2D
---@return boolean
function is_pray_coord_occupied_by_another(pray, coord) end

---@param coord Coord2D
---@return boolean
function is_guard_area_point_valid(coord) end

---@param person Thing
---@param commands Commands
---@return boolean
function is_person_at_cmd_point_dest_exact(person, commands) end

---@param person Thing
---@param commands Commands
---@return boolean
function is_person_at_cmd_point_dest(person, commands) end

---@param coord Coord2D
---@return boolean
function is_flatten_cmd_area_valid(coord) end

---@param person Thing
---@param commandId integer
---@return boolean
function is_cmd_relevant_for_person(person, commandId) end

---@param coord Coord2D
---@param tribeId integer
---@return boolean
function is_coord_valid_for_reincarnation_site(coord, tribeId) end

---@param person Thing
---@param commands Commands
---@return boolean
function is_person_near_cmd_area(person, commands) end

---@param person Thing
---@param commands Commands
---@return boolean
function is_person_ready_near_attack_area(person, commands) end

---@param thing Thing
---@return Commands
function get_thing_curr_cmd_list_ptr(thing) end

function set_non_context_sensitive_cmd_menu_cmd_command_type() end

---@param player Player
---@param arg1 integer
---@param arg2 integer
---@param arg3 integer
---@return integer
function set_players_awaiting_peoples_commands_of_type(player, arg1, arg2, arg3) end

---@param thing Thing
function set_persons_current_command_complete(thing) end

---@param thing Thing
---@param commandId number
function set_persons_command_complete(thing, commandId) end

---@param thing Thing
---@return number
function set_persons_next_command(thing) end

---@param arg0 number
function set_my_players_context_commands_info(arg0) end

---@param thing Thing
---@param commands Commands
function set_persons_post_command_base_pos(thing, commands) end

---@param arg0 integer
---@param arg1 integer
function set_cmd_menu_hilite_item_from_coord(arg0, arg1) end

function set_cmd_accept_menu_info() end

---@param arg0 number
function set_curr_cmd_menu_item_by_cmd_type(arg0) end

function set_cmd_menu_dflt_drag_area_sizes() end

---@param player Player
function set_players_people_last_group_flag(player) end

---@param commands Commands
---@param arg1 number
---@param cmdInfo CmdTargetInfo
---@param arg3 number
function update_cmd_list_entry(commands, arg1, cmdInfo, arg3) end

---@param thing Thing
function remove_all_persons_commands(thing) end

---@param thing Thing
---@param commands Commands
---@param arg2 number
function add_persons_command(thing, commands, arg2) end

---@param thing Thing
---@param coords Coord2D
---@return number
function command_person_go_to_coord2d(thing, coords) end
