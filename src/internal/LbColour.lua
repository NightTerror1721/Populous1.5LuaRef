---@meta

---@class TbColour
---@field Packed integer
---@field Blue integer
---@field Green integer
---@field Red integer
---@field Alpha integer
---@field Index integer
---@overload fun(): TbColour
---@overload fun(ind: integer): TbColour
---@overload fun(r: integer, g: integer, b: integer, a?: integer): TbColour
TbColour = {
    ---@param r integer
    ---@param g integer
    ---@param b integer
    ---@param a? integer
    Set = function(r, g, b, a) end,

    ---@return integer
    Get32bitValue = function() end,
}
