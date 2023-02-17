---@meta

---@param player Player
---@param x integer
---@param z integer
function computer_set_base_pos(player, x, z) end

---@param player Player
function computer_init_player(player) end

---@param player Player
function set_players_shaman_initial_command(player) end

---@param player Player
function destroy_reinc(player) end

---@param tribe1 integer
---@param tribe2 integer
function transfer_tribe_to_another_player(tribe1, tribe2) end

---@param tribe1 integer
---@param tribe2 integer
---@return boolean
function are_players_allied(tribe1, tribe2) end

---@param tribe1 integer
---@param tribe2 integer
function set_players_enemies(tribe1, tribe2) end

---@param tribe1 integer
---@param tribe2 integer
function set_players_allied(tribe1, tribe2) end

---@param tribe integer
---@return Player
function getPlayer(tribe) end
