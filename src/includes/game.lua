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


import(Module_Math)
import(Module_PopScript)
include("includes/coords.lua")
include("includes/map.lua")


Game = {}


---@param enabled boolean
function Game.setAutoBuild(enabled)
    SET_AUTO_BUILD(enabled and 1 or 0)
end

---@param enabled boolean
function Game.setAutoHouse(enabled)
    SET_AUTO_HOUSE(enabled and 1 or 0)
end

function Game.setAutoDialog(enabled)
    AUTO_MESSAGES(enabled and 1 or 0)
end


function Game.win()
    TRIGGER_LEVEL_WON();
end

function Game.lose()
    TRIGGER_LEVEL_LOST();
end

---@param marker integer
function Game.fireTriggerAtMarker(marker)
    TRIGGER_THING(marker)
end


---@param trigger Thing
---@param times? integer
function Game.fireTrigger(trigger, times)
    times = times and math.max(1, times) or 1
    trigger.u.Trigger.TriggeredPendingCount = trigger.u.Trigger.TriggeredPendingCount + times
end

---@param x integer
---@param z integer
---@param times? integer
---@overload fun(coords: AnyCoord, times?: integer)
function Game.fireTriggerAt(x, z, times)
    local trigger
    if type(x) == "number" then
        trigger = Map.findFirstThingOf(ThingType.General, GeneralModel.Trigger, x, z)
    else
        times = z
        trigger = Map.findFirstThingOf(ThingType.General, GeneralModel.Trigger, x--[[@as AnyCoord]])
    end
    if trigger then
        Game.fireTrigger(trigger, times)
    end
end

---@param x integer
---@param z integer
---@return integer
---@overload fun(coords: AnyCoord): integer
function Game.getTriggerRemainingCounts(x, z)
    local trigger = Map.findFirstThingOf(ThingType.General, GeneralModel.Trigger, x, z)
    if trigger then
        return trigger.u.Trigger.TriggerCount
    end
    return 0
end
