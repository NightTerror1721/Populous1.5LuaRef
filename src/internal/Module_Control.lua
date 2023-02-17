---@meta

---@param msg string
---@param duration integer
---@param player_num integer
---@param attributes integer
function flash_player_msg_on(msg, duration, player_num, attributes) end

function flash_player_msg_off() end

---@param msg string
---@param player_num integer
---@param attributes integer
function permanent_player_msg_on(msg, player_num, attributes) end

function permanent_player_msg_off() end

---@param arg0 number
---@param player Player
function change_game_draw_mode(arg0, player) end
