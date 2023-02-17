---@meta


---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
function regenerate_level(arg0, arg1, arg2) end

---@param id integer
---@return integer
function load_level(id) end

---@param level_name string
---@return integer
function load_level_by_name(level_name) end

---@param arg0 integer
function level_update_default_info_for_this_level(arg0) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
function generate_level(arg0, arg1, arg2) end

---@param arg0 integer
function level_load_in_level_details_and_computer_player_info(arg0) end

---@param arg0 integer
function change_level(arg0) end

---@param arg0 integer
function set_level_type(arg0) end

---@param arg0 integer
function set_object_type(arg0) end
