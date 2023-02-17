---@meta


---@class OBJLIST
---@field t_thing Thing
---@field next OBJLIST
---@field prev OBJLIST
OBJLIST = {}

---@class Internal_It
---@field _ol ObjectList
---@field _curr OBJLIST
Internal_It = {}

---@enum ObjectListType
ObjectListType = {
    
    ---@type integer
    None = nil,

    ---@type integer
    FreeList = nil,

    ---@type integer
    UsedList = nil,

    ---@type integer
    TypeList = nil,
}


---@class ObjectList
---@overload fun(type: ObjectListType): ObjectList
---@overload fun(cpy: ObjectList): ObjectList
ObjectList = {
    ---@param type ObjectListType
    setObjectListType = function(type) end,

    ---@param t Thing
    ---@return OBJLIST
    insert = function(t) end,

    ---@param t Thing
    ---@param delete? boolean
    remove = function(t, delete) end,

    ---@return Thing
    front = function() end,

    ---@return Thing
    tail = function() end,

    ---@return Thing
    pop_front = function() end,

    ---@return Thing
    pop_tail = function() end,

    ---@param t Thing
    ---@return Thing
    getNextThing = function(t) end,

    ---@param t Thing
    ---@return Thing
    getPreviousThing = function(t) end,

    ---@return integer
    count = function() end,

    ---@return ObjectListType
    whatListAmI = function() end,

    ---@param predicate fun(predicate: Thing): Thing|nil
    processList = function(predicate) end,

    reset = function() end,

    isEmpty = function() end,

    ---@param t Thing
    ---@return OBJLIST | nil
    AmIInList = function(t) end,

    ---@param idx integer
    ---@return Thing
    getNth = function(idx) end,

    ---@return Thing[]
    toThingVector = function() end,

    ---@return ObjectProxy[]
    toObjectProxyVector = function() end,
}
