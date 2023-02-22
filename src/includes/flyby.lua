--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     flyby
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

if __DEFINED_KRAMPUS1721_INCLUDES_FLYBY then return end
__DEFINED_KRAMPUS1721_INCLUDES_FLYBY = true


import(Module_PopScript)
include("includes/gametime.lua")
include("includes/coords.lua")


---@class Flyby
Flyby = {}


function Flyby.create()
    FLYBY_CREATE_NEW()
end

function Flyby.start()
    FLYBY_START()
end

function Flyby.stop()
    FLYBY_STOP()
end

---@param enabled boolean
function Flyby.setAllowInterrupt(enabled)
    FLYBY_ALLOW_INTERRUPT(enabled and 1 or 0)
end

---@param x integer
---@param z integer
---@param start integer
---@param duration Turn
---@overload fun(coords: AnyCoord, start: integer, duration: Turn)
function Flyby.setEventPos(x, z, start, duration)
    if type(x) ~= "number" then
        duration = start
        start = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    FLYBY_SET_EVENT_POS(x, z, start, duration)
end

---@param angle integer
---@param start integer
---@param duration Turn
function Flyby.setEventAngle(angle, start, duration)
    FLYBY_SET_EVENT_ANGLE(angle, start, duration)
end

---@param zoom integer
---@param start integer
---@param duration Turn
function Flyby.setEventZoom(zoom, start, duration)
    FLYBY_SET_EVENT_ZOOM(zoom, start, duration)
end

---@param x integer
---@param z integer
---@param code integer
---@param start Turn
---@param duration Turn
---@overload fun(coords: AnyCoord, code: integer, start: Turn, duration: Turn)
function Flyby.setEventTooltip(x, z, code, start, duration)
    if type(x) ~= "number" then
        duration = start
        start = code
        code = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    FLYBY_SET_EVENT_TOOLTIP(x, z, code, start, duration)
end

---@param x integer
---@param z integer
---@param angle integer
---@param duration Turn
---@overload fun(coords: AnyCoord, angle: integer, duration: Turn)
function Flyby.setEndTarget(x, z, angle, duration)
    if type(x) ~= "number" then
        duration = angle
        angle = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    FLYBY_SET_END_TARGET(x, z, angle, duration)
end

---@param dialog_idx integer
---@param start Turn
function Flyby.openDialog(dialog_idx, start)
    FLYBY_OPEN_DIALOG(dialog_idx, start)
end



---@class FlybyEvent
---@field start Turn
---@field duration Turn

---@class FlybyEventPosition: FlybyEvent
---@field x integer?
---@field z integer?
---@field coord AnyCoord?

---@class FlybyEventAngle: FlybyEvent
---@field angle integer

---@class FlybyEventZoom: FlybyEvent
---@field zoom integer

---@class FlybyEventTooltip: FlybyEvent
---@field x integer?
---@field z integer?
---@field coord AnyCoord?
---@field code integer

---@class FlybyEndTarget
---@field x integer?
---@field z integer?
---@field coord AnyCoord?
---@field angle integer
---@field duration Turn


---@class FlybyParameters
---@field positions FlybyEventPosition[]?
---@field angles FlybyEventAngle[]?
---@field zooms FlybyEventZoom[]?
---@field tooltips FlybyEventTooltip[]?
---@field target FlybyEndTarget?


---@param event FlybyEventPosition
local function ProcessPositionEvent(event)
    if event.coord ~= nil then
        Flyby.setEventPos(event.coord, event.start, event.duration)
    else
        Flyby.setEventPos(event.x, event.z, event.start, event.duration)
    end
end

---@param event FlybyEventAngle
local function ProcessAngleEvent(event)
    Flyby.setEventAngle(event.angle, event.start, event.duration)
end

---@param event FlybyEventZoom
local function ProcessZoomEvent(event)
    Flyby.setEventZoom(event.zoom, event.start, event.duration)
end

---@param event FlybyEventTooltip
local function ProcessTooltipEvent(event)
    if event.coord ~= nil then
        Flyby.setEventTooltip(event.coord, event.code, event.start, event.duration)
    else
        Flyby.setEventTooltip(event.x, event.z, event.code, event.start, event.duration)
    end
end

---@param event FlybyEndTarget
local function ProcessEndTarget(event)
    if event.coord ~= nil then
        Flyby.setEndTarget(event.coord, event.angle, event.duration)
    else
        Flyby.setEndTarget(event.x, event.z, event.angle, event.duration)
    end
end


---@param params FlybyParameters
function Flyby.build(params)
    Flyby.create()
    if params.positions then
        for index, value in ipairs(params.positions) do
            ProcessPositionEvent(params.positions[index])
        end
    end
    if params.angles then
        for index, value in ipairs(params.angles) do
            ProcessAngleEvent(params.angles[index])
        end
    end
    if params.zooms then
        for index, value in ipairs(params.zooms) do
            ProcessZoomEvent(params.zooms[index])
        end
    end
    if params.tooltips then
        for index, value in ipairs(params.tooltips) do
            ProcessTooltipEvent(params.tooltips[index])
        end
    end
    if params.target then
        ProcessEndTarget(params.target)
    end
end

---@param params FlybyParameters
function Flyby.buildAndStart(params)
    Flyby.build(params)
    Flyby.start()
end
