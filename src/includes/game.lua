--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     game
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


if __DEFINED_KRAMPUS1721_INCLUDES_GAME then return end
__DEFINED_KRAMPUS1721_INCLUDES_GAME = true


import(Module_PopScript)


Game = {}


function Game.win()
    TRIGGER_LEVEL_WON();
end

function Game.lose()
    TRIGGER_LEVEL_LOST();
end

---@param marker integer
function Game.fireTrigger(marker)
    TRIGGER_THING(marker)
end
