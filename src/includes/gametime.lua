--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     gametime
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

if __DEFINED_KRAMPUS1721_INCLUDES_GAMETIME then return end
__DEFINED_KRAMPUS1721_INCLUDES_GAMETIME = true

import(Module_Globals)
import(Module_System)
import(Module_Math)

---@alias Turn integer
---@alias Seconds number


local _gsi = gsi()


Time = {}

---@param turns Turn
---@return Seconds
function Time.toSeconds(turns)
    return turns / 12.0
end

---@param seconds Seconds
---@return Turn
function Time.toTurns(seconds)
    return math.floor(seconds * 12)
end

---@return Turn
function Time.getTurn()
    return _gsi.Counts.ProcessThings
end

---@param turn Turn
function Time.isTurn(turn)
    return Time.getTurn() == turn
end

---@param turn Turn
function Time.isAtLeastTurn(turn)
    return Time.getTurn() >= turn
end

---@param turn Turn
function Time.isAtMostTurn(turn)
    return Time.getTurn() <= turn
end

---@param min Turn
---@param max Turn
function Time.isTurnBetween(min, max)
    local turn = Time.getTurn()
    return min >= turn and turn >= max
end


---Return current game time in seconds
function Time.getSeconds()
    return Time.toSeconds(Time.getTurn())
end

---@param seconds Seconds
function Time.isSeconds(seconds)
    return Time.getSeconds() == seconds
end

---@param seconds Seconds
function Time.isAtLeastTime(seconds)
    return Time.getSeconds() >= seconds
end

---@param seconds Seconds
function Time.isAtMostTime(seconds)
    return Time.getSeconds() <= seconds
end

---@param min_seconds Seconds
---@param max_seconds Seconds
function Time.isTimeBetween(min_seconds, max_seconds)
    local seconds = Time.getTime()
    return min_seconds >= seconds and seconds >= max_seconds
end


---@param turns Turn
---@param delay? Turn
function Time.everyTurns(turns, delay)
    local turn = Time.getTurn() - (delay and math.max(0, math.floor(delay)) or 0)
    if turn <= 0 then return false end
    return (turn % turns) == 0
end

---@param base integer
---@param exponent integer
---@param delay? Turn
function Time.everyPowTurns(base, exponent, delay)
    return Time.everyTurns(math.floor(base ^ exponent), delay)
end

---@param base integer
---@param delay? Turn
function Time.every2PowTurns(base, delay)
    return Time.everyPowTurns(base, 2, delay)
end

---@param turns Turn
---@param delay Turn
---@param action fun()
---@return boolean
---@overload fun(turns: Turn, action: fun()): boolean
function EveryTurnsDo(turns, delay, action)
    if action == nil then
        local test = Time.everyTurns(turns)
        if test then (delay--[[@as fun()]])() end
        return test
    else
        local test = Time.everyTurns(turns, delay)
        if test then action() end
        return test
    end
end

---@param base integer
---@param exponent integer
---@param delay Turn
---@param action fun()
---@return boolean
---@overload fun(base: integer, exponent: integer, action: fun()): boolean
function Time.everyPowTurnsDo(base, exponent, delay, action)
    return Time.everyTurnsDo(math.floor(base ^ exponent), delay, action)
end

---@param base integer
---@param delay Turn
---@param action fun()
---@return boolean
---@overload fun(base: integer, action: fun()): boolean
function Time.every2PowTurnsDo(base, delay, action)
    return Time.everyPowTurnsDo(base, 2, delay, action)
end


---@param seconds Seconds
---@param delay_seconds? Seconds
function Time.everySeconds(seconds, delay_seconds)
    local delay = delay_seconds and Time.toTurns(delay_seconds) or 0
    return Time.everyTurns(Time.toTurns(seconds), delay)
end

---@param seconds Seconds
---@param delay_seconds Seconds
---@param action fun()
---@return boolean
---@overload fun(seconds: Seconds, action: fun()): boolean
function Time.everySecondsDo(seconds, delay_seconds, action)
    if action == nil then
        local test = Time.everySeconds(seconds)
        if test then (delay_seconds--[[@as fun()]])() end
        return test
    else
        local test = Time.everySeconds(seconds, delay_seconds)
        if test then action() end
        return test
    end
end
