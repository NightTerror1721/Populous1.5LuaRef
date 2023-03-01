---@meta


---@alias SpecialList
---| `PEOPLELIST`
---| `BUILDINGLIST`
---| `BUILDINGMARKERLIST`
---| `FORMATIONSLIST`
---| `BEACONSLIST`
---| `WILDLIST`
---| `FIGHTLIST`
---| `PREFIGHTLIST`
---| `SPECIALLIST`
---| `AIRSHIPSLIST`
---| `BOATLIST`
---| `TRIGGERLIST`
---| `TRIGGERHEADLIST`
---| `SWAMPLIST`
---| `WOODLIST`


---@param arg0 integer
---@return PlayerContainer
function getPlayerContainer(arg0) end

---@param arg0 boolean
---@return lists
function getLists(arg0) end

---@param type integer
---@param model integer
---@param tribe integer
---@param coords Coord3D
---@param arg4 false
---@param arg5 false
---@return Thing
function createThing(type, model, tribe, coords, arg4, arg5) end

---@param tribe integer
---@return Thing|nil
function getShaman(tribe) end

---@param thing Thing
---@param new_tribe integer
function swapOwner(thing, new_tribe) end

---@param arg0 integer
---@param thing Thing
---@return Thing
---@overload fun(thing: Thing): Thing
function FindNextGlobalTypeList(arg0, thing) end

---@param arg0 integer
---@param arg1 integer
---@param thing Thing
---@return Thing
function FindNextSpecialList(arg0, arg1, thing) end

---@param thing Thing
function DestroyThing(thing) end

---@return integer
function objectCounts() end

---@param idx integer
---@return Thing
function GetThing(idx) end

---@param thing Thing
---@return Thing
function findWood(thing) end

---@param thing_type integer
---@param callback fun(thing: Thing): boolean
---@return Thing
function ProcessGlobalTypeList(thing_type, callback) end

---@param callback fun(thing: Thing): boolean
---@return Thing
function ProcessGlobalUsedList(callback) end

---@param tribe Tribe
---@param callback fun(thing: Thing): boolean
---@return Thing
function ProcessGlobalSpecialListAll(tribe, callback) end

---@param tribe Tribe
---@param list_type SpecialList
---@param callback fun(thing: Thing): boolean
---@return Thing
function ProcessGlobalSpecialList(tribe, list_type, callback) end

---@param thing Thing
function uninit_thing(thing) end

---@param thing Thing
---@return boolean
function uninit_triggered_thing(thing) end

---@param thing Thing
---@return boolean
function reinit_riggered_thing(thing) end

function uninit_all_triggered_things() end

---@param src Thing
---@param dst Thing
function copy_thing_data(src, dst) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
---@param arg3 Coord3D
---@param arg4 integer
---@param arg5 integer
---@param arg6 integer
---@param arg7 integer
---@return Thing
function CREATE_THING_FOR_TRAINING(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
---@param arg3 Coord3D
---@param arg4 integer
---@param arg5 integer
---@param arg6 integer
---@param arg7 integer
---@return Thing
function CREATE_THING_WITH_PARAMS4(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
---@param arg3 Coord3D
---@param arg4 integer
---@param arg5 integer
---@param arg6 integer
---@param arg7 integer
---@param arg8 integer
---@return Thing
function CREATE_THING_WITH_PARAMS5(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) end

---@param arg0 integer
---@param arg1 integer
---@param arg2 integer
---@param arg3 Coord3D
---@param arg4 integer
---@param arg5 integer
---@param arg6 integer
---@param arg7 integer
---@param arg8 integer
---@return Thing
function CREATE_THING_FOR_BUILDING_UPGRADING(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) end

---@param arrays ObjectList[]
---@param callback fun(thing: Thing): boolean
function ProcessObjectListVector(arrays, callback) end

---@param arrays ObjectList[]
---@return Thing[]
function ConvertObjectListVectorToThingVector(arrays) end

