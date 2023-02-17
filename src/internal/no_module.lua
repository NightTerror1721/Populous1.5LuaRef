---@meta

---@type PopModule
Module_Commands = nil

---@type PopModule
Module_Control = nil

---@type PopModule
Module_DataTypes = nil

---@type PopModule
Module_Defines = nil

---@type PopModule
Module_Draw = nil

---@type PopModule
Module_Game = nil

---@type PopModule
Module_GameStates = nil

---@type PopModule
Module_Globals = nil

---@type PopModule
Module_Helpers = nil

---@type PopModule
Module_Level = nil

---@type PopModule
Module_Map = nil

---@type PopModule
Module_MapWho = nil

---@type PopModule
Module_Objects = nil

---@type PopModule
Module_Person = nil

---@type PopModule
Module_Players = nil

---@type PopModule
Module_PopScript = nil

---@type PopModule
Module_Sound = nil

---@type PopModule
Module_StringTools = nil

---@type PopModule
Module_System = nil

---@alias PopModule
---| `Module_Commands` #Commands Module
---| `Module_Control` #Control Module
---| `Module_DataTypes` #DataTypes Module
---| `Module_Defines` #Defines Module
---| `Module_Draw` #Draw Module
---| `Module_Game` #Game Module
---| `Module_GameStates` #GameStates Module
---| `Module_Globals` #Globals Module
---| `Module_Helpers` #Helpers Module
---| `Module_Level` #Level Module
---| `Module_Map` #Map Module
---| `Module_MapWho` #MapWho Module
---| `Module_Objects` #Objects Module
---| `Module_Person` #Person Module
---| `Module_Players` #Players Module
---| `Module_PopScript` #PopScript Module
---| `Module_Sound` #Sound Module
---| `Module_StringTools` #StringTools Module
---| `Module_System` #System Module


---Imports a Populous Lua Module
---@param module PopModule
function import(module) end

function exit() end

---@param filename string
function include(filename) end
