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

import(Module_System)
import(Module_Math)

---@alias Turn integer
---@alias Time number


local _gsi = gsi()


---@param turns Turn
---@return Time
function TurnsToSeconds(turns)
    return turns / 12.0
end

---@param seconds Time
---@return Turn
function SecondsToTurns(seconds)
    return math.floor(seconds * 12)
end

---@return Turn
function GetTurn()
    return _gsi.Counts.GameTurn
end

---@param turn Turn
function IsTurn(turn)
    return GetTurn() == turn
end

---@param turn Turn
function IsAtLeastTurn(turn)
    return GetTurn() >= turn
end

---@param turn Turn
function IsAtMostTurn(turn)
    return GetTurn() <= turn
end

---@param min Turn
---@param max Turn
function IsTurnBetween(min, max)
    local turn = GetTurn()
    return min >= turn and turn >= max
end


---Return current game time in seconds
function GetTime()
    return TurnsToSeconds(GetTurn())
end

---@param seconds Time
function IsTime(seconds)
    return GetTime() == seconds
end

---@param seconds Time
function IsAtLeastTime(seconds)
    return GetTime() >= seconds
end

---@param seconds Time
function IsAtMostTime(seconds)
    return GetTime() <= seconds
end

---@param min_seconds Time
---@param max_seconds Time
function IsTimeBetween(min_seconds, max_seconds)
    local seconds = GetTime()
    return min_seconds >= seconds and seconds >= max_seconds
end


---@param turns Turn
---@param delay? Turn
function EveryTurns(turns, delay)
    local turn = GetTurn() - (delay and math.max(0, math.floor(delay)) or 0)
    if turn <= 0 then return false end
    return (turn % turns) == 0
end

---@param base integer
---@param exponent integer
---@param delay? Turn
function EveryPowTurns(base, exponent, delay)
    return EveryTurns(math.floor(base ^ exponent), delay)
end

---@param base integer
---@param delay? Turn
function Every2PowTurns(base, delay)
    return EveryPowTurns(base, 2, delay)
end

---@param turns Turn
---@param delay Turn
---@param action fun()
---@return boolean
---@overload fun(turns: Turn, action: fun()): boolean
function EveryTurnsDo(turns, delay, action)
    if action == nil then
        local test = EveryTurns(turns)
        if test then (delay--[[@as fun()]])() end
        return test
    else
        local test = EveryTurns(turns, delay)
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
function EveryPowTurnsDo(base, exponent, delay, action)
    return EveryTurnsDo(math.floor(base ^ exponent), delay, action)
end

---@param base integer
---@param delay Turn
---@param action fun()
---@return boolean
---@overload fun(base: integer, action: fun()): boolean
function Every2PowTurnsDo(base, delay, action)
    return EveryPowTurnsDo(base, 2, delay, action)
end


---@param seconds Time
---@param delay_seconds? Time
function EverySeconds(seconds, delay_seconds)
    local delay = delay_seconds and SecondsToTurns(delay_seconds) or 0
    return EveryTurns(SecondsToTurns(seconds), delay)
end

---@param seconds Time
---@param delay_seconds Time
---@param action fun()
---@return boolean
---@overload fun(seconds: Time, action: fun()): boolean
function EverySecondsDo(seconds, delay_seconds, action)
    if action == nil then
        local test = EverySeconds(seconds)
        if test then (delay_seconds--[[@as fun()]])() end
        return test
    else
        local test = EverySeconds(seconds, delay_seconds)
        if test then action() end
        return test
    end
end
