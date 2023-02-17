---@meta


---@class ObjectProxy
---@overload fun(): ObjectProxy
---@overload fun(t: Thing): ObjectProxy
---@overload fun(me: ObjectProxy): ObjectProxy
ObjectProxy = {
    ---@param refT Thing
    set = function(refT) end,

    ---@return Thing
    get = function() end,

    ---@return boolean
    isNull = function() end,

    ---@return integer
    getType = function() end,

    ---@return integer
    getFlags = function() end,

    ---@param f integer
    setFlags = function(f) end,

    ---@param f integer
    setFlag = function(f) end,

    ---@param f integer
    unsetFlag = function(f) end,

    ---@param t integer
    is_type = function(t) end,

    ---@param f integer
    is_flag_enabled = function(f) end,

    clear = function() end
}
