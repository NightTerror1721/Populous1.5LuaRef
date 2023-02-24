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
    setObjectListType = function(self, type) end,

    ---@param self ObjectList
    ---@param t Thing
    ---@return OBJLIST
    insert = function(self, t) end,

    ---@param self ObjectList
    ---@param t Thing
    ---@param delete? boolean
    remove = function(self, t, delete) end,

    ---@param self ObjectList
    ---@return Thing
    front = function(self) end,

    ---@param self ObjectList
    ---@return Thing
    tail = function(self) end,

    ---@param self ObjectList
    ---@return Thing
    pop_front = function(self) end,

    ---@param self ObjectList
    ---@return Thing
    pop_tail = function(self) end,

    ---@param self ObjectList
    ---@param t Thing
    ---@return Thing
    getNextThing = function(self, t) end,

    ---@param t Thing
    ---@return Thing
    getPreviousThing = function(self, t) end,

    ---@param self ObjectList
    ---@return integer
    count = function(self) end,

    ---@param self ObjectList
    ---@return ObjectListType
    whatListAmI = function(self) end,

    ---@param self ObjectList
    ---@param predicate fun(predicate: Thing): boolean
    ---@return Thing|nil
    processList = function(self, predicate) end,

    ---@param self ObjectList
    reset = function(self) end,

    ---@param self ObjectList
    isEmpty = function(self) end,

    ---@param self ObjectList
    ---@param t Thing
    ---@return OBJLIST | nil
    AmIInList = function(self, t) end,

    ---@param self ObjectList
    ---@param idx integer
    ---@return Thing
    getNth = function(self, idx) end,

    ---@param self ObjectList
    ---@return Thing[]
    toThingVector = function(self) end,

    ---@param self ObjectList
    ---@return ObjectProxy[]
    toObjectProxyVector = function(self) end,
}
