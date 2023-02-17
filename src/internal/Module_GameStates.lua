---@meta

---@return integer
function save_game_state() end

---@param arg0 integer
function overwrite_game_state(arg0) end

---@param arg0 integer
function load_game_state(arg0) end

---@param arg0 integer
function delete_game_state(arg0) end

---@param arg0 integer
---@param arg1 string
function save_game_state_to_disk(arg0, arg1) end
