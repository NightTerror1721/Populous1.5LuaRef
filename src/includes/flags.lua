--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     flags
    Author:     Krampus1721
    Site:       http://popre.net
    Discord:    https://discord.gg/buRQ4HK
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]--


Flags = {}

---@param base integer
---@param values integer
---@return integer
function Flags.set(base, values)
        return base | values
end

---@param base integer
---@param bitIdx integer
---@return integer
function Flags.setBit(base, bitIdx)
        return base | (0x1 << bitIdx)
end

---@param base integer
---@param values integer
---@return integer
function Flags.clear(base, values)
    return base & ~values
end

---@param base integer
---@param bitIdx integer
---@return integer
function Flags.clearBit(base, bitIdx)
    return base & ~(0x1 << bitIdx)
end

---@param base integer
---@param flags integer
---@return boolean
function Flags.isSet(base, flags)
    return (base & flags) == flags
end

---@param base integer
---@param bitIdx integer
---@return boolean
function Flags.isBitSet(base, bitIdx)
    return (base & (0x1 << bitIdx)) ~= 0
end
