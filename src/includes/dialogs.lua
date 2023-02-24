--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     dialogs
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


if __DEFINED_KRAMPUS1721_INCLUDES_DIALOGS then return end
__DEFINED_KRAMPUS1721_INCLUDES_DIALOGS = true


import(Module_PopScript)
include("includes/coords.lua")


Dialog = {}


function Dialog.clearAllMessages()
    CLEAR_ALL_MSG()
end

---@param id integer
function Dialog.setMessageID(id)
    SET_MSG_ID(id)
end

---@return integer
function Dialog.messageID()
    return MSG_ID()
end

---@return integer
function Dialog.getMessageID()
    return GET_MSG_ID()
end

---@param id integer
function Dialog.killAllMessagesWithID(id)
    KILL_ALL_MSG_ID(id)
end

---@param index integer
function Dialog.createNarrativeMessage(index)
    CREATE_MSG_NARRATIVE(index)
end

---@param index integer
function Dialog.createObjectiveMessage(index)
    CREATE_MSG_OBJECTIVE(index)
end

---@param index integer
function Dialog.createInformationMessage(index)
    CREATE_MSG_INFORMATION(index)
end

---@param index integer
---@param x integer
---@param z integer
---@param angle integer
---@overload fun(index: integer, coords: AnyCoord, angle: integer)
function Dialog.createZoomInformationMessage(index, x, z, angle)
    if type(x) ~= "number" then
        angle = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    CREATE_MSG_INFORMATION_ZOOM(index, x, z, angle)
end

---@param x integer
---@param z integer
---@param angle integer
---@overload fun(coords: AnyCoord, angle: integer)
function Dialog.setMessageZoom(x, z, angle)
    if type(x) ~= "number" then
        angle = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    SET_MSG_ZOOM(x, z, angle)
end

---@param timeout integer
function Dialog.setMessageTimeout(timeout)
    SET_MSG_TIMEOUT(timeout)
end

function Dialog.setMessageDeleteOnOK()
    SET_MSG_DELETE_ON_OK()
end

function Dialog.setMessageReturnOnOK()
    SET_MSG_RETURN_ON_OK()
end

function Dialog.setMessageDeleteOnRMBZoom()
    SET_MSG_DELETE_ON_RMB_ZOOM()
end

function Dialog.setMessageOpenDialogOnRMBZoom()
    SET_MSG_OPEN_DLG_ON_RMB_ZOOM()
end

function Dialog.setMessageCreateReturnMessageOnRMBZoom()
    SET_MSG_CREATE_RETURN_MSG_ON_RMB_ZOOM()
end

function Dialog.setMessageOpenDialogOnRMBDelete()
    SET_MSG_OPEN_DLG_ON_RMB_DELETE()
end

function Dialog.setMessageZoomOnLMBOpenDialog()
    SET_MSG_ZOOM_ON_LMB_OPEN_DLG()
end

function Dialog.setMessageOkSaveExitDialog()
    SET_MSG_OK_SAVE_EXIT_DLG()
end

function Dialog.setMessageAutoOpenDialog()
    SET_MSG_AUTO_OPEN_DLG()
end


---@enum MessageType
MessageType = {
    Narrative = 0,
    Objective = 1,
    Informative = 2,
    angle = 3
}


---@class MessagePropertiesZoomData
---@field x integer?
---@field z integer?
---@field coords AnyCoord?
---@field angle integer

---@class MessageProperties
---@field index integer
---@field type MessageType
---@field zoom MessagePropertiesZoomData?
---@field timeout integer?
---@field deleteOnOK boolean?
---@field returnOnOK boolean?
---@field autoOpen boolean?
---@field id integer?

---@param props MessageProperties
function Dialog.open(props)
    if props.type == MessageType.Narrative then
        Dialog.createNarrativeMessage(props.index)
    elseif props.type == MessageType.Objective then
        Dialog.createObjectiveMessage(props.index)
    elseif props.type == MessageType.Informative then
        Dialog.createNarrativeMessage(props.index)
    else
        return
    end

    if props.zoom then
        if props.zoom.coords then
            Dialog.setMessageZoom(props.zoom.coords, props.zoom.angle)
        else
            Dialog.setMessageZoom(props.zoom.x, props.zoom.z, props.zoom.angle)
        end
    end

    if props.timeout then
        Dialog.setMessageTimeout(props.timeout)
    end

    if props.deleteOnOK then
        Dialog.setMessageDeleteOnOK()
    end

    if props.returnOnOK then
        Dialog.setMessageReturnOnOK()
    end

    if props.autoOpen then
        Dialog.setMessageAutoOpenDialog()
    end

    if props.id then
        Dialog.setMessageID(props.id)
    end
end
