---@meta


---@param test boolean
---@param message string
function assertmsg(test, message) end

---@param test boolean
function assert(test) end

---@param script_path string
---@return boolean
function load_script(script_path) end

---@param script_path string
function remove_script(script_path) end

function OBJECT_BREAK() end

---@param script_path string
function __save_script_header(script_path) end

---@param script_path string
---@param header_path string
function __save_script_header(script_path, header_path) end

---@param script string
---@return string
function get_script_filepath(script) end

---@param error_message string
function fatalError(error_message) end

---@param message string
function log(message) end
