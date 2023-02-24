--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     tribes
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

if __DEFINED_KRAMPUS1721_INCLUDES_TRIBES then return end
__DEFINED_KRAMPUS1721_INCLUDES_TRIBES = true


import(Module_Players)
import(Module_PopScript)
include("includes/spells.lua")
include("includes/buildings.lua")
include("includes/persons.lua")
include("includes/gametime.lua")


---@enum TribeNum
TribeNum = {
    Neutral = TRIBE_NEUTRAL,
    Blue = TRIBE_BLUE,
    Red = TRIBE_RED,
    Yellow = TRIBE_YELLOW,
    Green = TRIBE_GREEN,
    Cyan = TRIBE_CYAN,
    Pink = TRIBE_PINK,
    Black = TRIBE_BLACK,
    Orange = TRIBE_ORANGE,
    Hostbot = TRIBE_HOSTBOT,
}

---@class TribeSpellsPool
---@field Burn SpellInfo
---@field Blast SpellInfo
---@field LightningBolt SpellInfo
---@field Whirlwind SpellInfo
---@field InsectPlage SpellInfo
---@field Invisibility SpellInfo
---@field Hypnotism SpellInfo
---@field Firestorm SpellInfo
---@field GhostArmy SpellInfo
---@field Erosion SpellInfo
---@field Swamp SpellInfo
---@field LandBridge SpellInfo
---@field AngelOfDeath SpellInfo
---@field Earthquake SpellInfo
---@field Flatten SpellInfo
---@field Volcano SpellInfo
---@field ConvertWild SpellInfo
---@field Armageddon SpellInfo
---@field Shield SpellInfo
---@field Bloodlust SpellInfo
---@field Teleport SpellInfo
---@field Hill SpellInfo
---@field Rise SpellInfo
---@field Valley SpellInfo
---@field Dip SpellInfo
---@field PlaceTree SpellInfo
---@field ClearMapWho SpellInfo
---@field PlaceShaman SpellInfo
---@field PlaceWild SpellInfo

---@class TribeBuildingsPool
---@field Tepee BuildingInfo
---@field Tepee2 BuildingInfo
---@field Tepee3 BuildingInfo
---@field DrumTower BuildingInfo
---@field Temple BuildingInfo
---@field SpyTrain BuildingInfo
---@field WarriorTrain BuildingInfo
---@field SuperTrain BuildingInfo
---@field Reconversion BuildingInfo
---@field WallPiece BuildingInfo
---@field Gate BuildingInfo
---@field CurrOeSlot BuildingInfo
---@field BoatHut1 BuildingInfo
---@field BoatHut2 BuildingInfo
---@field AirshipHut1 BuildingInfo
---@field AirshipHut2 BuildingInfo
---@field GuardPost BuildingInfo
---@field Library BuildingInfo
---@field Prision BuildingInfo
---@field Hut BuildingInfo alias for Tepee2
---@field Farm BuildingInfo alias for Tepee3
---@field SmallHut BuildingInfo alias for Tepee
---@field MediumHut BuildingInfo alias for Tepee2
---@field LargeHut BuildingInfo alias for Tepee3
---@field FireWarriorTrain BuildingInfo alias for SuperTrain
---@field BoatHut BuildingInfo alias for BoatHut1
---@field AirshipHut BuildingInfo alias for AirshipHut1

---@class TribePersonsInfo
---@field Wild PersonInfo
---@field Brave PersonInfo
---@field Warrior PersonInfo
---@field Religious PersonInfo
---@field Spy PersonInfo
---@field SuperWarrior PersonInfo
---@field MedicineMan PersonInfo
---@field Angel PersonInfo
---@field FireWarrior PersonInfo alias for SuperWarrior
---@field Shaman PersonInfo alias for MedicineMan

---@enum AttackTargetType
AttackTargetType = {
    Marker = 0,
    Building = 1,
    Person = 2
}

---@enum AttackType
AttackType = {
    Normal = 0,
    ByBoat = 1,
    ByBalloon = 2
}

---@class AttackParameters
---@field targetTribe TribeNum|TribeInfo
---@field people integer
---@field targetType AttackTargetType
---@field targetModel (PersonModel|BuildingModel)?
---@field damage integer
---@field spell1 SpellModel?
---@field spell2 SpellModel?
---@field spell3 SpellModel?
---@field attackType AttackType?
---@field lookAfter integer?
---@field marker1 integer?
---@field marker2 integer?
---@field direction integer?


local _gsi = gsi()


---@class TribeAIAttributes
---@field Expansion integer
---@field PrefSpyTrains integer
---@field PrefReligiousTrains integer
---@field PrefWarriorTrains integer
---@field PrefSuperWarriorTrains integer
---@field PrefSpyPeople integer
---@field PrefReligiousPeople integer
---@field PrefWarriorPeople integer
---@field PrefSuperWarriorPeople integer
---@field MaxBuildingsOnGo integer
---@field HousePercentage integer
---@field AwayBrave integer
---@field AwayWarrior integer
---@field AwayReligious integer
---@field DefenseRadIncr integer
---@field MaxDefensiveActions integer
---@field AwaySpy integer
---@field AwaySuperWarrior integer
---@field AttackPercentage integer
---@field AwayShaman integer
---@field PeoplePerBoat integer
---@field PeoplePerBalloon integer
---@field DontUseBoats integer
---@field MaxSpyAttacks integer
---@field EnemySpyMaxStand integer
---@field MaxAttacks integer
---@field EmptyAtWaypoint integer
---@field SpyCheckFrequency integer
---@field RetreatValue integer
---@field BaseUnderAttackRetreat integer
---@field RandomBuildSide integer
---@field UsePreacherForDefense integer
---@field ShamenBlast integer
---@field MaxTrainAtOnce integer
---@field GroupOption integer
---@field PrefBoatHuts integer
---@field PrefBalloonHuts integer
---@field PrefBoatDrivers integer
---@field PrefBalloonDrivers integer
---@field FightStopDistance integer
---@field SpyDiscoverChance integer
---@field CountPreachDamage integer
---@field DontGroupAtDT integer
---@field SpellDelay integer
---@field DontDeleteUselessBoatHouse integer
---@field BoatHouseBroken integer
---@field DontAutoTrainPreachers integer
---@field Spare6 integer

local TribeAIAttributesMap = {
    Expansion = ATTR_EXPANSION,
    PrefSpyTrains = ATTR_PREF_SPY_TRAINS,
    PrefReligiousTrains = ATTR_PREF_RELIGIOUS_TRAINS,
    PrefWarriorTrains = ATTR_PREF_WARRIOR_TRAINS,
    PrefSuperWarriorTrains = ATTR_PREF_SUPER_WARRIOR_TRAINS,
    PrefSpyPeople = ATTR_PREF_SPY_PEOPLE,
    PrefReligiousPeople = ATTR_PREF_RELIGIOUS_PEOPLE,
    PrefWarriorPeople = ATTR_PREF_WARRIOR_PEOPLE,
    PrefSuperWarriorPeople = ATTR_PREF_SUPER_WARRIOR_PEOPLE,
    MaxBuildingsOnGo = ATTR_MAX_BUILDINGS_ON_GO,
    HousePercentage = ATTR_HOUSE_PERCENTAGE,
    AwayBrave = ATTR_AWAY_BRAVE,
    AwayWarrior = ATTR_AWAY_WARRIOR,
    AwayReligious = ATTR_AWAY_RELIGIOUS,
    DefenseRadIncr = ATTR_DEFENSE_RAD_INCR,
    MaxDefensiveActions = ATTR_MAX_DEFENSIVE_ACTIONS,
    AwaySpy = ATTR_AWAY_SPY,
    AwaySuperWarrior = ATTR_AWAY_SUPER_WARRIOR,
    AttackPercentage = ATTR_ATTACK_PERCENTAGE,
    AwayShaman = ATTR_AWAY_MEDICINE_MAN,
    PeoplePerBoat = ATTR_PEOPLE_PER_BOAT,
    PeoplePerBalloon = ATTR_PEOPLE_PER_BALLOON,
    DontUseBoats = ATTR_DONT_USE_BOATS,
    MaxSpyAttacks = ATTR_MAX_SPY_ATTACKS,
    EnemySpyMaxStand = ATTR_ENEMY_SPY_MAX_STAND,
    MaxAttacks = ATTR_MAX_ATTACKS,
    EmptyAtWaypoint = ATTR_EMPTY_AT_WAYPOINT,
    SpyCheckFrequency = ATTR_SPY_CHECK_FREQUENCY,
    RetreatValue = ATTR_RETREAT_VALUE,
    BaseUnderAttackRetreat = ATTR_BASE_UNDER_ATTACK_RETREAT,
    RandomBuildSide = ATTR_RANDOM_BUILD_SIDE,
    UsePreacherForDefense = ATTR_USE_PREACHER_FOR_DEFENCE,
    ShamenBlast = ATTR_SHAMEN_BLAST,
    MaxTrainAtOnce = ATTR_MAX_TRAIN_AT_ONCE,
    GroupOption = ATTR_GROUP_OPTION,
    PrefBoatHuts = ATTR_PREF_BOAT_HUTS,
    PrefBalloonHuts = ATTR_PREF_BALLOON_HUTS,
    PrefBoatDrivers = ATTR_PREF_BOAT_DRIVERS,
    PrefBalloonDrivers = ATTR_PREF_BALLOON_DRIVERS,
    FightStopDistance = ATTR_FIGHT_STOP_DISTANCE,
    SpyDiscoverChance = ATTR_SPY_DISCOVER_CHANCE,
    CountPreachDamage = ATTR_COUNT_PREACH_DAMAGE,
    DontGroupAtDT = ATTR_DONT_GROUP_AT_DT,
    SpellDelay = ATTR_SPELL_DELAY,
    DontDeleteUselessBoatHouse = ATTR_DONT_DELETE_USELESS_BOAT_HOUSE,
    BoatHouseBroken = ATTR_BOAT_HOUSE_BROKEN,
    DontAutoTrainPreachers = ATTR_DONT_AUTO_TRAIN_PREACHERS,
    Spare6 = ATTR_SPARE_6,
}


---@class TribeAIStates
---@field ConstructBuilding boolean write only
---@field FetchWood boolean write only
---@field ShamanGetWildPreeps boolean write only
---@field HouseAPerson boolean write only
---@field SendGhosts boolean write only
---@field BringNewPeopleBack boolean write only
---@field TrainPeople boolean write only
---@field PopulateDrumTower boolean write only
---@field Defend boolean write only
---@field DefendBase boolean write only
---@field SpellDefence boolean write only
---@field Preach boolean write only
---@field BuildWalls boolean write only
---@field Sabotage boolean write only
---@field SpellOffensive boolean write only
---@field SuperDefend boolean write only
---@field BuildVehicle boolean write only
---@field FetchLostPeople boolean write only
---@field FetchLostVehicle boolean write only
---@field FetchFarVehicle boolean write only
---@field AutoAttack boolean write only
---@field ShamanDefend boolean write only
---@field FlattenBase boolean write only
---@field BuildOuterDefences boolean write only
---@field GuardAtMarker boolean write only
---@field SendAllToMarker boolean write only
---@field PrayAtHead boolean write only
---@field BoatPatrol boolean write only
---@field DefendShamen boolean write only

local TribeAIStatesMap = {
    ConstructBuilding = CP_AT_TYPE_CONSTRUCT_BUILDING,
    FetchWood = CP_AT_TYPE_FETCH_WOOD,
    ShamanGetWildPreeps = CP_AT_TYPE_MED_MAN_GET_WILD_PEEPS,
    HouseAPerson = CP_AT_TYPE_HOUSE_A_PERSON,
    SendGhosts = CP_AT_TYPE_SEND_GHOSTS,
    BringNewPeopleBack = CP_AT_TYPE_BRING_NEW_PEOPLE_BACK,
    TrainPeople = CP_AT_TYPE_TRAIN_PEOPLE,
    PopulateDrumTower = CP_AT_TYPE_POPULATE_DRUM_TOWER,
    Defend = CP_AT_TYPE_DEFEND,
    DefendBase = CP_AT_TYPE_DEFEND_BASE,
    SpellDefence = CP_AT_TYPE_SPELL_DEFENCE,
    Preach = CP_AT_TYPE_PREACH,
    BuildWalls = CP_AT_TYPE_BUILD_WALLS,
    Sabotage = CP_AT_TYPE_SABOTAGE,
    SpellOffensive = CP_AT_TYPE_SPELL_OFFENSIVE,
    SuperDefend = CP_AT_TYPE_SUPER_DEFEND,
    BuildVehicle = CP_AT_TYPE_BUILD_VEHICLE,
    FetchLostPeople = CP_AT_TYPE_FETCH_LOST_PEOPLE,
    FetchLostVehicle = CP_AT_TYPE_FETCH_LOST_VEHICLE,
    FetchFarVehicle = CP_AT_TYPE_FETCH_FAR_VEHICLE,
    AutoAttack = CP_AT_TYPE_AUTO_ATTACK,
    ShamanDefend = CP_AT_TYPE_MED_MAN_DEFEND,
    FlattenBase = CP_AT_TYPE_FLATTEN_BASE,
    BuildOuterDefences = CP_AT_TYPE_BUILD_OUTER_DEFENCES,
    GuardAtMarker = CP_AT_TYPE_GUARD_AT_MARKER,
    SendAllToMarker = CP_AT_TYPE_SEND_ALL_TO_MARKER,
    PrayAtHead = CP_AT_TYPE_PRAY_AT_HEAD,
    BoatPatrol = CP_AT_TYPE_BOAT_PATROL,
    DefendShamen = CP_AT_TYPE_DEFEND_SHAMEN
}


---@param model PersonModel|nil
---@return InternalFollowerModel
local function GetInternalFollowerModel(model)
    if model == nil or model < PersonModel.Brave or model > PersonModel.MedicineMan then return INT_NO_SPECIFIC_PERSON end
    return model - 2 + INT_BRAVE
end


local InternalBuildingModelMap = {
    [BuildingModel.None] = INT_NO_SPECIFIC_BUILDING,
    [BuildingModel.Tepee] = INT_TEPEE,
    [BuildingModel.Hut] = INT_HUT,
    [BuildingModel.Farm] = INT_FARM,
    [BuildingModel.DrumTower] = INT_DRUM_TOWER,
    [BuildingModel.Temple] = INT_TEMPLE,
    [BuildingModel.SpyTrain] = INT_SPY_TRAIN,
    [BuildingModel.WarriorTrain] = INT_WARRIOR_TRAIN,
    [BuildingModel.SuperTrain] = INT_SUPER_TRAIN,
    [BuildingModel.Reconversion] = INT_RECONVERSION,
    [BuildingModel.WallPiece] = INT_WALL_PIECE,
    [BuildingModel.Gate] = INT_GATE,
    [BuildingModel.BoatHut1] = INT_BOAT_HUT_1,
    [BuildingModel.BoatHut2] = INT_BOAT_HUT_2,
    [BuildingModel.AirshipHut1] = INT_AIRSHIP_HUT_1,
    [BuildingModel.AirshipHut2] = INT_AIRSHIP_HUT_2,
}

---@param model BuildingModel|nil
---@return InternalBuildingModel
local function GetInternalBuildingModel(model)
    local value = InternalBuildingModelMap[model]
    return value and value or INT_NO_SPECIFIC_BUILDING
end


---@param targetType AttackTargetType
---@param model PersonModel|BuildingModel|nil
---@return InternalFollowerModel|InternalBuildingModel
local function SelectInternalModel(targetType, model)
    return targetType == AttackTargetType.Person and GetInternalFollowerModel(model) or GetInternalBuildingModel(model)
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

---@param model SpellModel
---@return InternalSpellModel
local function GetInternalSpellModel(model)
    local value = InternalSpellModel[model]
    return value and value or INT_NO_SPECIFIC_SPELL
end


---@param tribe TribeNum|TribeInfo
---@return TribeNum
local function ToTribe(tribe)
    if type(tribe) == "number" then
        return tribe
    else
        return tribe.num
    end
end


---@param tribe TribeNum
local function CreateAttributesObject(tribe)
    local mt = {}

    ---@param table table
    ---@param key any
    rawset(mt, "__index", function(table, key)
        local index = TribeAIAttributesMap[key]
        if index == nil then
            error("Unknown attribute '"..key.."'")
        end
        return READ_CP_ATTRIB(tribe, index)
        --return _gsi.ThisLevelInfo.Attribs[tribe].Value[index]
    end)
    
    ---@param table table
    ---@param key any
    ---@param value any
    rawset(mt, "__newindex", function(table, key, value)
        local index = TribeAIAttributesMap[key]
        if index == nil then
            error("Unknown attribute '"..key.."'")
        end
        --value = math.floor(math.max(0, math.min(255, value)))
        WRITE_CP_ATTRIB(tribe, index, value)
        --_gsi.ThisLevelInfo.Attribs[tribe].Value[index] = value
        return value
    end)

    local attrs = {}
    setmetatable(attrs, mt)
    return attrs
end

---@param tribe TribeNum
local function CreateStatesObject(tribe)
    local mt = {}

    ---@param table table
    ---@param key any
    rawset(mt, "__index", function(table, key)
        error("Cannot read state value")
    end)
    
    ---@param table table
    ---@param key any
    ---@param value any
    rawset(mt, "__newindex", function(table, key, value)
        local index = TribeAIStatesMap[key]
        if index == nil then
            error("Unknown state '"..key.."'")
        end
        value = value == true and 1 or 0
        STATE_SET(tribe, value, index)
        return value
    end)

    local attrs = {}
    setmetatable(attrs, mt)
    return attrs
end


---@param tribe TribeNum
---@return TribeInfo
local function CreateInstance(tribe)
    ---@type TribeInfo
    local obj = {}
    setmetatable(obj, TribeInfo)

    obj.num = tribe

    obj.Spells = {
        Burn = SpellInfo.get(tribe, SpellModel.Burn),
        Blast = SpellInfo.get(tribe, SpellModel.Blast),
        LightningBolt = SpellInfo.get(tribe, SpellModel.LightningBolt),
        Whirlwind = SpellInfo.get(tribe, SpellModel.Whirlwind),
        InsectPlage = SpellInfo.get(tribe, SpellModel.InsectPlage),
        Invisibility = SpellInfo.get(tribe, SpellModel.Invisibility),
        Hypnotism = SpellInfo.get(tribe, SpellModel.Hypnotism),
        Firestorm = SpellInfo.get(tribe, SpellModel.Firestorm),
        GhostArmy = SpellInfo.get(tribe, SpellModel.GhostArmy),
        Erosion = SpellInfo.get(tribe, SpellModel.Erosion),
        Swamp = SpellInfo.get(tribe, SpellModel.Swamp),
        LandBridge = SpellInfo.get(tribe, SpellModel.LandBridge),
        AngelOfDeath = SpellInfo.get(tribe, SpellModel.AngelOfDeath),
        Earthquake = SpellInfo.get(tribe, SpellModel.Earthquake),
        Flatten = SpellInfo.get(tribe, SpellModel.Flatten),
        Volcano = SpellInfo.get(tribe, SpellModel.Volcano),
        ConvertWild = SpellInfo.get(tribe, SpellModel.ConvertWild),
        Armageddon = SpellInfo.get(tribe, SpellModel.Armageddon),
        Shield = SpellInfo.get(tribe, SpellModel.Shield),
        Bloodlust = SpellInfo.get(tribe, SpellModel.Bloodlust),
        Teleport = SpellInfo.get(tribe, SpellModel.Teleport),

        Hill = SpellInfo.get(tribe, SpellModel.Hill),
        Rise = SpellInfo.get(tribe, SpellModel.Rise),
        Valley = SpellInfo.get(tribe, SpellModel.Valley),
        Dip = SpellInfo.get(tribe, SpellModel.Dip),
        PlaceTree = SpellInfo.get(tribe, SpellModel.PlaceTree),
        ClearMapWho = SpellInfo.get(tribe, SpellModel.ClearMapWho),
        PlaceShaman = SpellInfo.get(tribe, SpellModel.PlaceShaman),
        PlaceWild = SpellInfo.get(tribe, SpellModel.PlaceWild),
    }

    obj.Buildings = {
        Tepee = BuildingInfo.get(tribe, BuildingModel.Tepee),
        Tepee2 = BuildingInfo.get(tribe, BuildingModel.Tepee2),
        Tepee3 = BuildingInfo.get(tribe, BuildingModel.Tepee3),
        DrumTower = BuildingInfo.get(tribe, BuildingModel.DrumTower),
        Temple = BuildingInfo.get(tribe, BuildingModel.Temple),
        SpyTrain = BuildingInfo.get(tribe, BuildingModel.SpyTrain),
        WarriorTrain = BuildingInfo.get(tribe, BuildingModel.WarriorTrain),
        SuperTrain = BuildingInfo.get(tribe, BuildingModel.SuperTrain),
        Reconversion = BuildingInfo.get(tribe, BuildingModel.Reconversion),
        WallPiece = BuildingInfo.get(tribe, BuildingModel.WallPiece),
        Gate = BuildingInfo.get(tribe, BuildingModel.Gate),
        CurrOeSlot = BuildingInfo.get(tribe, BuildingModel.CurrOeSlot),
        BoatHut1 = BuildingInfo.get(tribe, BuildingModel.BoatHut1),
        BoatHut2 = BuildingInfo.get(tribe, BuildingModel.BoatHut2),
        AirshipHut1 = BuildingInfo.get(tribe, BuildingModel.AirshipHut1),
        AirshipHut2 = BuildingInfo.get(tribe, BuildingModel.AirshipHut2),
        GuardPost = BuildingInfo.get(tribe, BuildingModel.GuardPost),
        Library = BuildingInfo.get(tribe, BuildingModel.Library),
        Prision = BuildingInfo.get(tribe, BuildingModel.Prision)
    }
    obj.Buildings.Hut = obj.Buildings.Tepee2
    obj.Buildings.Farm = obj.Buildings.Tepee3
    obj.Buildings.SmallHut = obj.Buildings.Tepee
    obj.Buildings.MediumHut = obj.Buildings.Tepee2
    obj.Buildings.LargeHut = obj.Buildings.Tepee3
    obj.Buildings.FireWarriorTrain = obj.Buildings.SuperTrain
    obj.Buildings.BoatHut = obj.Buildings.BoatHut1
    obj.Buildings.AirshipHut = obj.Buildings.AirshipHut1

    obj.Persons = {
        Wild = PersonInfo.get(tribe, PersonModel.Wild),
        Brave = PersonInfo.get(tribe, PersonModel.Brave),
        Warrior = PersonInfo.get(tribe, PersonModel.Warrior),
        Religious = PersonInfo.get(tribe, PersonModel.Religious),
        Spy = PersonInfo.get(tribe, PersonModel.Spy),
        SuperWarrior = PersonInfo.get(tribe, PersonModel.SuperWarrior),
        MedicineMan = PersonInfo.get(tribe, PersonModel.MedicineMan),
        Angel = PersonInfo.get(tribe, PersonModel.Angel)
    }
    obj.Persons.FireWarrior = obj.Persons.SuperWarrior
    obj.Persons.Shaman = obj.Persons.MedicineMan
    obj.Followers = obj.Persons

    obj.Attributes = CreateAttributesObject(tribe)

    obj.States = CreateStatesObject(tribe)

    return obj
end


---@class TribeInfo
---@field num TribeNum
---@field Spells TribeSpellsPool
---@field Buildings TribeBuildingsPool
---@field Persons TribePersonsInfo
---@field Followers TribePersonsInfo alias for Persons
---@field Attributes TribeAIAttributes
---@field States TribeAIStates
---@field Count 10
TribeInfo = {}
TribeInfo.__index = TribeInfo
TribeInfo.__name = "Krampus1721.TribeInfo"

TribeInfo.Count = 10

function TribeInfo:getPlayer()
    return getPlayer(self.num)
end

function TribeInfo:getShaman()
    return getShaman(self.num)
end

function TribeInfo:isShamanAlive()
    return getShaman(self.num) ~= nil
end

function TribeInfo:getMana()
    return getPlayer(self.num).Mana
end

---@param amount integer
function TribeInfo:giveMana(amount)
    local player = getPlayer(self.num)
    player.Mana = player.Mana + math.max(0, amount)
end

function TribeInfo:getNumPeople()
    return getPlayer(self.num).NumPeople
end

function TribeInfo:getNumPeopleConverted()
    return getPlayer(self.num).NumPeopleConverted
end

function TribeInfo:getNumGhostPeople()
    return getPlayer(self.num).NumGhostPeople
end

function TribeInfo:getNumBuildings()
    return getPlayer(self.num).NumBuildings
end

function TribeInfo:getReincSiteCoord()
    return getPlayer(self.num).ReincarnSiteCoord
end

function TribeInfo:clearShamanLeftClick()
    CLEAR_SHAMAN_LEFT_CLICK(self.num)
end

function TribeInfo:clearShamanRightClick()
    CLEAR_SHAMAN_RIGHT_CLICK(self.num)
end

function TribeInfo:isShamanIconLeftClicked()
    return IS_SHAMAN_ICON_LEFT_CLICKED(self.num) ~= 0
end

function TribeInfo:isShamanIconRightClicked()
    return IS_SHAMAN_ICON_RIGHT_CLICKED(self.num) ~= 0
end

function TribeInfo:resetBaseMarker()
    RESET_BASE_MARKER(self.num)
end

---@param marker integer
function TribeInfo:setBaseMarker(marker)
    SET_BASE_MARKER(self.num, marker)
end

---@param marker integer
---@param radius integer
function TribeInfo:isShamanInArea(marker, radius)
    return IS_SHAMAN_IN_AREA(self.num, marker, radius) ~= 0
end

function TribeInfo:getNumPeopleBeingPreached()
    return GET_NUM_PEOPLE_BEING_PREACHED(self.num)
end

function TribeInfo:deselectAllPeople()
    DESELECT_ALL_PEOPLE(self.num)
end

---@param enabled boolean
function TribeInfo:setGiveUpAndSulk(enabled)
    GIVE_UP_AND_SULK(self.num, enabled and 1 or 0)
end

---@param enabled boolean
function TribeInfo:setDelayMainDrumTower(enabled)
    DELAY_MAIN_DRUM_TOWER(enabled and 1 or 0, self.num)
end

function TribeInfo:getNumPeopleInHouses()
    return COUNT_PEOPLE_IN_HOUSES(self.num)
end

function TribeInfo:startReincNow()
    return START_REINC_NOW(self.num)
end

---@param targetTribe TribeNum|TribeInfo
---@param people integer
---@param targetType AttackTargetType
---@param targetModel PersonModel|BuildingModel
---@param damage integer
---@param spell1 SpellModel
---@param spell2 SpellModel
---@param spell3 SpellModel
---@param attackType AttackType
---@param lookAfter integer
---@param marker1 integer
---@param marker2 integer
---@param direction integer
---@return boolean
---@overload fun(self: TribeInfo, params: AttackParameters): boolean
function TribeInfo:attack(
    targetTribe,
    people,
    targetType,
    targetModel,
    damage,
    spell1,
    spell2,
    spell3,
    attackType,
    lookAfter,
    marker1,
    marker2,
    direction
)
    local isTable = type(targetTribe) == "table"
    if not isTable or targetTribe.__name == TribeInfo.__name then
        if isTable then targetTribe = targetTribe.num end
        return ATTACK(
            self.num,
            targetTribe,
            people,
            targetType,
            SelectInternalModel(targetType, targetModel),
            damage,
            GetInternalSpellModel(spell1),
            GetInternalSpellModel(spell2),
            GetInternalSpellModel(spell3),
            attackType,
            lookAfter,
            marker1,
            marker2,
            direction
        ) ~= 0
    end

    local params = targetTribe--[[@as AttackParameters]]
    if type(params.targetTribe) ~= "number" then params.targetTribe = params.targetTribe.num end
    return ATTACK(
        self.num,
        params.targetTribe,
        params.people,
        params.targetType,
        SelectInternalModel(params.targetType, params.targetModel),
        params.damage,
        params.spell1 == nil and INT_NO_SPECIFIC_SPELL or GetInternalSpellModel(params.spell1),
        params.spell2 == nil and INT_NO_SPECIFIC_SPELL or GetInternalSpellModel(params.spell2),
        params.spell3 == nil and INT_NO_SPECIFIC_SPELL or GetInternalSpellModel(params.spell3),
        params.attackType == nil and AttackType.Normal or params.attackType,
        params.lookAfter == nil and 0 or (params.lookAfter--[[@as integer]]),
        params.marker1 == nil and -1 or (params.marker1--[[@as integer]]),
        params.marker2 == nil and -1 or (params.marker2--[[@as integer]]),
        params.direction == nil and -1 or (params.direction--[[@as integer]])
    ) ~= 0
end

---@class MarkerEntryProperties
---@field entry integer
---@field marker1 integer
---@field marker2 integer?
---@field braves integer?
---@field warriors integer?
---@field swarriors integer?
---@field preachers integer?

---@param entry integer
---@param marker1 integer
---@param marker2 integer
---@param num_braves? integer
---@param num_warriors? integer
---@param num_swarriors? integer
---@param num_preachers? integer
---@overload fun(self: TribeInfo, props: MarkerEntryProperties)
function TribeInfo:setMarkerEntry(entry, marker1, marker2, num_braves, num_warriors, num_swarriors, num_preachers)
    if type(entry) == "table" then
        local props = entry--[[@as MarkerEntryProperties]]
        entry = props.entry
        marker1 = props.marker1
        marker2 = props.marker2 and props.marker2 or -1
        num_braves = props.braves and props.braves or 0
        num_warriors = props.warriors and props.warriors or 0
        num_swarriors = props.swarriors and props.swarriors or 0
        num_preachers = props.preachers and props.preachers or 0
    else
        num_braves = num_braves == nil and 0 or (num_braves--[[@as integer]])
        num_warriors = num_warriors == nil and 0 or (num_warriors--[[@as integer]])
        num_swarriors = num_swarriors == nil and 0 or (num_swarriors--[[@as integer]])
        num_preachers = num_preachers == nil and 0 or (num_preachers--[[@as integer]])
    end
    SET_MARKER_ENTRY(self.num, entry, marker1, marker2, num_braves, num_warriors, num_swarriors, num_preachers)
end

---@param entry1 integer
---@param entry2? integer
---@param entry3? integer
---@param entry4? integer
function TribeInfo:enableMarkerEntries(entry1, entry2, entry3, entry4)
    entry2 = entry2 == nil and -1 or (entry2--[[@as integer]])
    entry3 = entry3 == nil and -1 or (entry3--[[@as integer]])
    entry4 = entry4 == nil and -1 or (entry4--[[@as integer]])
    MARKER_ENTRIES(self.num, entry1, entry2, entry3, entry4)
end

---@param angle integer
function TribeInfo:setCameraRotation(angle)
    CAMERA_ROTATION(self.num, angle)
end

function TribeInfo:callToArms()
    CALL_TO_ARMS(self.num)
end

function TribeInfo:marvellousHouseDeath()
    MARVELLOUS_HOUSE_DEATH(self.num)
end

---@param radius integer
function TribeInfo:setDefenceRadius(radius)
    SET_DEFENCE_RADIUS(self.num, radius)
end

function TribeInfo:disableReinc()
    SET_NO_REINC(self.num)
end

---@param enabled boolean
function TribeInfo:setBucketUsage(enabled)
    SET_BUCKET_USAGE(self.num, enabled and 1 or 0)
end

---@param enabled boolean
function TribeInfo:setExtraWoodCollection(enabled)
    EXTRA_WOOD_COLLECTION(enabled and 1 or 0, self.num)
end

---@param min integer
---@param max integer
---@param x integer
---@param z integer
---@overload fun(self: TribeInfo, min: integer, max: integer, coords: AnyCoord)
function TribeInfo:setWoodCollectionRadii(min, max, x, z)
    if z == nil then
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    SET_WOOD_COLLECTION_RADII(self.num, min, max, x, z)
end

---@param spell SpellModel
---@param multiplier integer
function TribeInfo:setBucketCountForSpell(spell, multiplier)
    SET_BUCKET_COUNT_FOR_SPELL(self.num, GetInternalSpellModel(spell), multiplier)
end

---@param enabled boolean
function TribeInfo:setReinc(enabled)
    SET_REINCARNATION(enabled and 1 or 0, self.num)
end

---@return integer
function TribeInfo:getCountWithBuildCommand()
    return COUNT_WITH_BUILD_COMMAND(self.num)
end

function TribeInfo:clearHouseInfoFlag()
    CLEAR_HOUSE_INFO_FLAG(self.num)
end

---@return integer
function TribeInfo:getShapesCount()
    return COUNT_SHAPES(self.num)
end

---@return boolean
function TribeInfo:isShamanSelected()
    return IS_SHAMAN_SELECTED(self.num) ~= 0
end

---@return boolean
function TribeInfo:hasBeenInEncyc()
    return HAS_PLAYER_BEEN_IN_ENCYC(self.num) ~= 0
end

---@param marker integer
function TribeInfo:sendPeopleToMarker(marker)
    return SEND_PEOPLE_TO_MARKER(self.num, marker)
end

function TribeInfo:partialBuildingCount()
    PARTIAL_BUILDING_COUNT(self.num)
end

---@return boolean
function TribeInfo:isShamanAvailableForAttack()
    return IS_SHAMAN_AVAILABLE_FOR_ATTACK(self.num) ~= 0
end

---@param angle integer
function TribeInfo:trackShamanExtraBollocks(angle)
    TRACK_SHAMAN_EXTRA_BOLLOCKS(self.num, angle)
end

---@param angle integer
function TribeInfo:trackShamanToAngle(angle)
    TRACK_SHAMAN_TO_ANGLE(self.num, angle)
end

---@param marker integer
function TribeInfo:moveShamanToMarker(marker)
    MOVE_SHAMAN_TO_MARKER(self.num, marker)
end

---@param tribe_target TribeNum|TribeInfo
---@param target_type AttackTargetType
---@param target_model? PersonModel|BuildingModel
---@param remember? integer
---@return boolean
function TribeInfo:navCheck(tribe_target, target_type, target_model, remember)
    return NAV_CHECK(
        self.num,
        ToTribe(tribe_target),
        target_type,
        SelectInternalModel(target_type, target_model),
        remember == nil and 0 or (remember--[[@as integer]])
    ) ~= 0
end

function TribeInfo:setOnlyStandAtMarkers()
    ONLY_STAND_AT_MARKERS(self.num)
end

function TribeInfo:clearStandingPeople()
    CLEAR_STANDING_PEOPLE(self.num)
end

---@param marker1 integer
---@param marker2? integer
---@param marker3? integer
---@param marker4? integer
function TribeInfo:clearGuardingFrom(marker1, marker2, marker3, marker4)
    marker2 = marker2 == nil and -1 or (marker2--[[@as integer]])
    marker3 = marker3 == nil and -1 or (marker3--[[@as integer]])
    marker4 = marker4 == nil and -1 or (marker4--[[@as integer]])
    MARKER_ENTRIES(self.num, marker1, marker2, marker3, marker4)
end

---@param model BuildingModel
---@param x integer
---@param z integer
---@param radius integer
---@return boolean
---@overload fun(self: TribeInfo, model: BuildingModel, coords: AnyCoord, radius: integer): boolean
function TribeInfo:isBuildingNear(model, x, z, radius)
    if type(x) ~= "number" then
        radius = z
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    return IS_BUILDING_NEAR(self.num, GetInternalBuildingModel(model), x, z, radius) ~= 0
end

---@param num_people integer
function TribeInfo:defendShamen(num_people)
    DEFEND_SHAMEN(self.num, num_people)
end

function TribeInfo:sendShamenDefendersHome()
    SEND_SHAMEN_DEFENDERS_HOME(self.num)
end

---@param num_people integer
---@param marker1 integer
---@param marker2 integer
---@param marker3? integer
---@param marker4? integer
---@param vehicle_type integer
function TribeInfo:setBoatPatrol(num_people, marker1, marker2, marker3, marker4, vehicle_type)
    marker3 = marker3 == nil and -1 or (marker3--[[@as integer]])
    marker4 = marker4 == nil and -1 or (marker4--[[@as integer]])
    vehicle_type = vehicle_type == nil and 0 or (vehicle_type--[[@as integer]])
    BOAT_PATROL(self.num, num_people, marker1, marker2, marker3, marker4, vehicle_type)
end

---@param num_people integer
---@param marker integer
function TribeInfo:prayAtHead(num_people, marker)
    PRAY_AT_HEAD(self.num, num_people, marker)
end

---@param model PersonModel
---@param x integer
---@param z integer
---@overload fun(self: TribeInfo, model: PersonModel, coords: AnyCoord)
function TribeInfo:putPersonInDT(model, x, z)
    if z == nil then
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    PUT_PERSON_IN_DT(self.num, GetInternalFollowerModel(model), x, z)
end

TribeInfo.populateDrumTower = TribeInfo.putPersonInDT

---@param num_people integer
---@param model PersonModel
function TribeInfo:trainPeopleNow(num_people, model)
    TRAIN_PEOPLE_NOW(self.num, num_people, GetInternalFollowerModel(model))
end

---@param direction BuildingOrientation
function TribeInfo:setBuildDirection(direction)
    SET_BUILDING_DIRECTION(self.num, direction)
end

---@param radius integer
function TribeInfo:setBaseRadius(radius)
    SET_BASE_RADIUS(self.num, radius)
end

---@param tribe_target TribeNum|TribeInfo
---@param marker integer
---@param radius integer
---@return integer
function TribeInfo:getPeopleInMarkerCount(tribe_target, marker, radius)
    return COUNT_PEOPLE_IN_MARKER(self.num, ToTribe(tribe_target), marker, radius)
end

---@param x integer
---@param z integer
---@overload fun(self: TribeInfo, coords: AnyCoord)
function TribeInfo:setMainDrumTowerPos(x, z)
    if z == nil then
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    SET_DRUM_TOWER_POS(self.num, x, z)
end

---@param marker integer
function TribeInfo:convertAtMarker(marker)
    return CONVERT_AT_MARKER(self.num, marker)
end

---@param marker integer
function TribeInfo:preachAtMarker(marker)
    return PREACH_AT_MARKER(self.num, marker)
end


---@param marker integer
function TribeInfo:sendAllPeopleToMarker(marker)
    SEND_ALL_PEOPLE_TO_MARKER(self.num, marker)
end

---@param marker1 integer
---@param marker2 integer
---@param num_braves integer
---@param num_warriors integer
---@param num_swarriors integer
---@param num_preachers integer
---@param use_ghosts? boolean
function TribeInfo:setGuardBetweenMarkers(marker1, marker2, num_braves, num_warriors, num_swarriors, num_preachers, use_ghosts)
    local type = use_ghosts and GUARD_WITH_GHOSTS or GUARD_NORMAL
    GUARD_BETWEEN_MARKERS(self.num, marker1, marker2, num_braves, num_warriors, num_swarriors, num_preachers, type)
end

---@param x integer
---@param z integer
---@overload fun(self: TribeInfo, coords: AnyCoord)
function TribeInfo:buildDrumTower(x, z)
    if z == nil then
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    BUILD_DRUM_TOWER(self.num, x, z)
end

---@param num integer
function TribeInfo:sendGhostPeople(num)
    SEND_GHOST_PEOPLE(self.num, num)
end

---@return boolean
function TribeInfo:hasHouseInfoBeenShown()
    return HAS_HOUSE_INFO_BEEN_SHOWN(self.num) ~= 0
end

---@param enabled boolean
function TribeInfo:setTargetDrumTowers(enabled)
    if enabled then
        TARGET_DRUM_TOWERS(self.num)
    else
        DONT_TARGET_DRUM_TOWERS(self.num)
    end
end

---@param enabled boolean
function TribeInfo:setTargetSuperWarriors(enabled)
    if enabled then
        TARGET_S_WARRIORS(self.num)
    else
        DONT_TARGET_S_WARRIORS(self.num)
    end
end

---@return integer
function TribeInfo:getFreeEntries()
    return FREE_ENTRIES(self.num)
end

---@return integer
function TribeInfo:getNumShamenDefenders()
    return NUM_SHAMEN_DEFENDERS(self.num)
end



---@param tribe TribeNum
---@return integer
---@overload fun(tribe: TribeInfo): integer
function TribeInfo:getPeopleKilled(tribe)
    if type(tribe) == "number" then
        return getPlayer(self.num).PeopleKilled[tribe]
    else
        return getPlayer(self.num).PeopleKilled[(tribe--[[@as TribeInfo]]).num]
    end
end

function TribeInfo:getDeadCount()
    return getPlayer(self.num).DeadCount
end

---@param every_turns? integer
---@param max_people_with_turbo? integer
function TribeInfo:updateBuckets(every_turns, max_people_with_turbo)
    if not every_turns then every_turns = 256 end
    if not max_people_with_turbo then max_people_with_turbo = 79 end

    Time.everyTurnsDo(every_turns, function()
        self:setBucketUsage(true)
        if self:getNumPeople() <= max_people_with_turbo then
            self:setBucketCountForSpell(SpellModel.Blast, 8);
            self:setBucketCountForSpell(SpellModel.ConvertWild, 8);
            self:setBucketCountForSpell(SpellModel.InsectPlage, 32);
            self:setBucketCountForSpell(SpellModel.Invisibility, 40);
            self:setBucketCountForSpell(SpellModel.Shield, 48);
            self:setBucketCountForSpell(SpellModel.LandBridge, 66);
            self:setBucketCountForSpell(SpellModel.LightningBolt, 64);
            self:setBucketCountForSpell(SpellModel.Hypnotism, 70);
            self:setBucketCountForSpell(SpellModel.Whirlwind, 72);
            self:setBucketCountForSpell(SpellModel.Swamp, 80);
            self:setBucketCountForSpell(SpellModel.Flatten, 100);
            self:setBucketCountForSpell(SpellModel.Earthquake, 140);
            self:setBucketCountForSpell(SpellModel.Erosion, 168);
            self:setBucketCountForSpell(SpellModel.Firestorm, 320);
            self:setBucketCountForSpell(SpellModel.AngelOfDeath, 408);
            self:setBucketCountForSpell(SpellModel.Volcano, 640);
        else
            self:setBucketCountForSpell(SpellModel.Blast, 4);
            self:setBucketCountForSpell(SpellModel.ConvertWild, 4);
            self:setBucketCountForSpell(SpellModel.InsectPlage, 16);
            self:setBucketCountForSpell(SpellModel.Invisibility, 20);
            self:setBucketCountForSpell(SpellModel.Shield, 24);
            self:setBucketCountForSpell(SpellModel.LandBridge, 33);
            self:setBucketCountForSpell(SpellModel.LightningBolt, 32);
            self:setBucketCountForSpell(SpellModel.Hypnotism, 35);
            self:setBucketCountForSpell(SpellModel.Whirlwind, 36);
            self:setBucketCountForSpell(SpellModel.Swamp, 40);
            self:setBucketCountForSpell(SpellModel.Flatten, 50);
            self:setBucketCountForSpell(SpellModel.Earthquake, 70);
            self:setBucketCountForSpell(SpellModel.Erosion, 84);
            self:setBucketCountForSpell(SpellModel.Firestorm, 180);
            self:setBucketCountForSpell(SpellModel.AngelOfDeath, 204);
            self:setBucketCountForSpell(SpellModel.Volcano, 320);
        end
    end)
end

function TribeInfo:initComputer()
    computer_init_player(getPlayer(self.num))
end

---@param x integer
---@param z integer
---@overload fun(coords: AnyCoord)
function TribeInfo:setComputerBasePos(x, z)
    if z == nil then
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    computer_set_base_pos(getPlayer(self.num), x, z)
end

function TribeInfo:setInitialCommand()
    set_players_shaman_initial_command(getPlayer(self.num))
end

function TribeInfo:destroyReinc()
    destroy_reinc(getPlayer(self.num))
end

---@param tribe TribeNum|TribeInfo
function TribeInfo:transferTribeToAnotherPlayer(tribe)
    tribe = ToTribe(tribe)
    transfer_tribe_to_another_player(self.num, tribe)
end

---@param tribe TribeNum|TribeInfo
---@return boolean
function TribeInfo:isMyAlly(tribe)
    tribe = ToTribe(tribe)
    return are_players_allied(self.num, tribe)
end

---@param tribe TribeNum|TribeInfo
---@return boolean
function TribeInfo:isMyEnemy(tribe)
    tribe = ToTribe(tribe)
    return not are_players_allied(self.num, tribe)
end

---@param tribe TribeNum|TribeInfo
---@param bidirectional? boolean default true
function TribeInfo:setMyAlly(tribe, bidirectional)
    tribe = ToTribe(tribe)
    set_players_allied(self.num, tribe)
    if bidirectional == nil or bidirectional == true then
        set_players_allied(tribe, self.num)
    end
end

---@param tribe TribeNum|TribeInfo
---@param bidirectional? boolean default true
function TribeInfo:setMyEnemy(tribe, bidirectional)
    tribe = ToTribe(tribe)
    set_players_enemies(self.num, tribe)
    if bidirectional == nil or bidirectional == true then
        set_players_enemies(tribe, self.num)
    end
end

---@param x integer
---@param z integer
---@overload fun(self: TribeInfo, coords: AnyCoord)
function TribeInfo:setShamanDefendBasePos(x, z)
    if z == nil then
        x, z = Coord.getMapXZ(x--[[@as AnyCoord]])
    end
    SHAMAN_DEFEND(self.num, x, z, 1)
end

function TribeInfo:disableShamanDefendBasePos()
    SHAMAN_DEFEND(self.num, 0, 0, 0)
end

function TribeInfo:getNumTepeesInAnyLevel()
    return self.Buildings.Tepee:getNumInWorld() + self.Buildings.Tepee2:getNumInWorld() + self.Buildings.Tepee3:getNumInWorld()
end





Tribe = {
    Neutral = CreateInstance(TribeNum.Neutral),
    Blue = CreateInstance(TribeNum.Blue),
    Red = CreateInstance(TribeNum.Red),
    Yellow = CreateInstance(TribeNum.Yellow),
    Green = CreateInstance(TribeNum.Green),
    Cyan = CreateInstance(TribeNum.Cyan),
    Pink = CreateInstance(TribeNum.Pink),
    Black = CreateInstance(TribeNum.Black),
    Orange = CreateInstance(TribeNum.Orange),
    Hostbot = CreateInstance(TribeNum.Hostbot),
}

local TribesArray = {
    Tribe.Neutral,
    Tribe.Blue,
    Tribe.Red,
    Tribe.Yellow,
    Tribe.Green,
    Tribe.Cyan,
    Tribe.Pink,
    Tribe.Black,
    Tribe.Orange,
    Tribe.Hostbot,
}

---@param tribe TribeNum
---@return TribeInfo
function TribeInfo.get(tribe)
    return TribesArray[tribe]
end
