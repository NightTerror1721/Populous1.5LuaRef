--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     spells
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

if __DEFINED_KRAMPUS1721_INCLUDES_SPELLS then return end
__DEFINED_KRAMPUS1721_INCLUDES_SPELLS = true

import(Module_Globals)
import(Module_System)
import(Module_Players)
import(Module_Math)
include("includes/flags.lua")
include("includes/coords.lua")
include("includes/things.lua")


local _gsi = gsi()
local _sti = spells_type_info()

---@param tribe Tribe
local function GetPlayerThings(tribe)
    return _gsi.ThisLevelInfo.PlayerThings[tribe]
end

---@param tribe Tribe
local function GetPlayer(tribe)
    return getPlayer(tribe)
end


local InternalSpellModel = {
    [SpellModel.None] = INT_NO_SPECIFIC_SPELL,
    [SpellModel.Burn] = INT_BURN,
    [SpellModel.Blast] = INT_BLAST,
    [SpellModel.LightningBolt] = INT_LIGHTNING_BOLT,
    [SpellModel.Whirlwind] = INT_WHIRLWIND,
    [SpellModel.InsectPlage] = INT_INSECT_PLAGUE,
    [SpellModel.Invisibility] = INT_INVISIBILITY,
    [SpellModel.Hypnotism] = INT_HYPNOTISM,
    [SpellModel.Firestorm] = INT_FIRESTORM,
    [SpellModel.GhostArmy] = INT_GHOST_ARMY,
    [SpellModel.Erosion] = INT_EROSION,
    [SpellModel.Swamp] = INT_SWAMP,
    [SpellModel.LandBridge] = INT_LAND_BRIDGE,
    [SpellModel.AngelOfDeath] = INT_ANGEL_OF_DEATH,
    [SpellModel.Earthquake] = INT_EARTHQUAKE,
    [SpellModel.Flatten] = INT_FLATTEN,
    [SpellModel.Volcano] = INT_VOLCANO,
    [SpellModel.ConvertWild] = INT_CONVERT,
    [SpellModel.Armageddon] = INT_WRATH_OF_GOD,
    [SpellModel.Shield] = INT_SHIELD,
    [SpellModel.Bloodlust] = INT_BLOODLUST,
    [SpellModel.Teleport] = INT_TELEPORT
}


---@class SpellInfo
---@field tribe Tribe
---@field model integer
---@field private TribesSpells SpellInfo[][]
---@field Count SpellModel.COUNT
SpellInfo = {}
SpellInfo.__index = SpellInfo
SpellInfo.__name = "Krampus1721.SpellInfo"

SpellInfo.Count = SpellModel.COUNT

---@param tribe Tribe
---@param spell SpellModel
---@return SpellInfo
local function CreateInstance(tribe, spell)
    ---@type SpellInfo
    local obj = {}
    setmetatable(obj, SpellInfo)

    obj.tribe = tribe
    obj.model = spell
    return obj
end

---@param enabled boolean
function SpellInfo:setChargeEnabled(enabled)
    local data = GetPlayerThings(self.tribe)
    if not enabled then
        data.SpellsNotCharging = Flags.setBit(data.SpellsNotCharging, self.model - 1)
    else
        data.SpellsNotCharging = Flags.clearBit(data.SpellsNotCharging, self.model - 1)
    end
end

function SpellInfo:isChargeEnabled()
    return not Flags.isBitSet(GetPlayerThings(self.tribe).SpellsNotCharging, self.model - 1)
end

---@param enabled boolean
function SpellInfo:setEnabled(enabled)
    local data = GetPlayerThings(self.tribe)
    if enabled then
        data.SpellsAvailable = Flags.setBit(data.SpellsAvailable, self.model)
    else
        data.SpellsAvailable = Flags.clearBit(data.SpellsAvailable, self.model)
    end
end

function SpellInfo:isEnabled()
    return Flags.isBitSet(GetPlayerThings(self.tribe).SpellsAvailable, self.model)
end

---@param shots integer
function SpellInfo:setShots(shots)
    GetPlayerThings(self.tribe).SpellsAvailableOnce[self.model] = math.max(0, shots)
end

function SpellInfo:getShots()
    return GetPlayerThings(self.tribe).SpellsAvailableOnce[self.model]
end

---@param shots integer
function SpellInfo:giveShots(shots)
    self:setShots(self:getShots() + math.max(0, shots))
end

---@param enabled boolean
function SpellInfo:setLevelEnabled(enabled)
    local data = GetPlayerThings(self.tribe)
    if enabled then
        data.SpellsAvailableLevel = Flags.setBit(data.SpellsAvailableLevel, self.model)
    else
        data.SpellsAvailableLevel = Flags.clearBit(data.SpellsAvailableLevel, self.model)
    end
end

function SpellInfo:isLevelEnabled()
    return Flags.isBitSet(GetPlayerThings(self.tribe).SpellsAvailableLevel, self.model)
end

function SpellInfo:getMana()
    return GetPlayer(self.tribe).SpellsMana[self.model]
end

function SpellInfo:getCastCount()
    if self.model > 22 then return 0 end
    return GetPlayer(self.tribe).SpellsCast[self.model]
end

---@param coords AnyCoord
---@return Thing
function SpellInfo:cast(coords)
    return CreateSpell(self.model, self.tribe, Coord.to3D(coords))
end

---@param self SpellInfo
---@return integer
---@overload fun(model: SpellModel): integer
function SpellInfo.getCost(self)
    if type(self) ~= "number" then
        return _sti[self.model].Cost
    end
    return _sti[self].Cost
end

---@param self SpellInfo
---@return InternalSpellModel
---@overload fun(model: SpellModel): integer
function SpellInfo.getInternalModel(self)
    local value
    if type(self) ~= "number" then
        value = InternalSpellModel[self.model]
    else
        value = InternalSpellModel[self]
    end
    return value and value or INT_NO_SPECIFIC_SPELL
end




---@type SpellInfo[][]
SpellInfo.TribesSpells = {}
for tribe = 0, 10, 1 do
    local tribeSpells = {}
    for spellModel = 1, SpellInfo.Count, 1 do
        tribeSpells[spellModel] = CreateInstance(tribe, spellModel)
    end
    SpellInfo.TribesSpells[tribe] = tribeSpells
end

---@param tribe Tribe
---@param spell SpellModel
---@return SpellInfo
function SpellInfo.get(tribe, spell)
    return SpellInfo.TribesSpells[tribe][spell]
end
