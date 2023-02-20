--[[
    Populous Reincarnated © 2023
    Populous is a registered trademark of Electronic Arts Inc.
    
    Script:     things
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

if __DEFINED_KRAMPUS1721_INCLUDES_THINGS then return end
__DEFINED_KRAMPUS1721_INCLUDES_THINGS = true

import(Module_Objects)


---@enum ThingType
ThingType = {
    Person = 1,
    Building = 2,
    Creature = 3,
    Vehicle = 4,
    Scenary = 5,
    General = 6,
    Effect = 7,
    Shot = 8,
    Shape = 9,
    Internal = 10,
    Spell = 11,

    COUNT = 11
}


---@enum BuildingModel
BuildingModel = {
    Tepee = 1, SmallHut = 1,
    Tepee2 = 2, Hut = 2, MediumHut = 2,
    Tepee3 = 3, Farm = 3, LargeHut = 3,
    DrumTower = 4,
    Temple = 5,
    SpyTrain = 6,
    WarriorTrain = 7,
    SuperTrain = 8, FireWarriorTrain = 8,
    Reconversion = 9,
    WallPiece = 10,
    Gate = 11,
    CurrOeSlot = 12,
    BoatHut1 = 13, BoatHut = 13,
    BoatHut2 = 14,
    AirshipHut1 = 15, AirshipHut = 15,
    AirshipHut2 = 16,
    GuardPost = 17,
    Library = 18,
    Prision = 19,

    COUNT = 19
}

---@enum BuildingState
BuildingState = {
    UnderConstruction = 1,
    Stand = 2,
    Dying = 3,
    OnFire = 4,
    LibrarySink = 5,
    ControledRaise = 6
}


---@enum CreatureModel
CreatureModel = {
    Bear = 1,
    Buffalo = 2,
    Wolf = 3,
    Eagle = 4,
    Rabbit = 5,
    Beaver = 6,
    Fish = 7,

    COUNT = 7
}


---@enum EffectModel
EffectModel = {
    SimpleBlast = 1,
    SpriteCircles = 2,
    Smoke = 3,
    LightningElem = 4,
    BurnCellObstacles = 5,
    FlattenLand = 6,
    MoveRSPillar = 7,
    PrepareRSLand = 8,
    SphereExplode1 = 9,
    Fireball = 10,
    Firecloud = 11,
    GhostArmy = 12,
    Invisibility = 13,
    ExplodeBuildingPartial = 14,
    Volcano = 15,
    Hypnotism = 16,
    LightningBolt = 17,
    Swamp = 18,
    AngelOfDead = 19,
    Whirlwind = 20,
    InsectPlague = 21,
    Firestorm = 22,
    Erosion = 23,
    LandBridge = 24,
    WrathOfGod = 25,
    Earthquake = 26,
    FlyThingummy = 27,
    SphereExplodeAndFire = 28,
    BigFire = 29,
    Lightning = 30,
    Flatten = 31,
    General = 32,
    ShapeSparkle = 33,
    LavaFlow = 34,
    VolcanoExplosions = 35,
    PurifyLand = 36,
    UnpurifyLand = 37,
    Explosion1 = 38,
    Explosion2 = 39,
    LavaSquare = 40,
    WWElement = 41,
    LightningStrand = 42,
    WWDust = 43,
    RaiseLand = 44,
    LowerLand = 45,
    Hill = 46,
    Valley = 47,
    PlaceTree = 48,
    Rise = 49,
    Dip = 50,
    ReinRockDebris = 51,
    ClearMapwho = 52,
    PlaceShaman = 53,
    PlaceWild = 54,
    BuildingSmoke = 55,
    MuchSimplerBlast = 56,
    TumblingBranch = 57,
    ConversionFlash = 58,
    HypnosisFlash = 59,
    Sparkle = 60,
    SmallSparkle = 61,
    Explosion3 = 62,
    RockExplosion = 63,
    LavaGloop = 64,
    Splash = 65,
    SmokeCloud = 66,
    SmokeCloudConstant = 67,
    Fireball2 = 68,
    GroundShockwave = 69,
    Orbiter = 70,
    BigSparkle = 71,
    Meteor = 72,
    ConvertWild = 73,
    BuildingSmoke2Full = 74,
    BuildingSmoke2Partial = 75,
    BuildingDamagedSmoke = 76,
    DeleteRSPillars = 77,
    SpellBlast = 78,
    FirestormSmoke = 79,
    PlayerDead = 80,
    RevealFogArea = 81,
    Shield = 82,
    BoatHutRepair = 83,
    ReedyGrass = 84,
    SwampMist = 85,
    Armageddon = 86,
    Bloodlust = 87,
    Teleport = 88,
    AtlantisSet = 89,
    AtlantisInvoke = 90,
    StatueToAOD = 91,
    FillOneShots = 92,
    FireRollElem = 93,
    ArmaArena = 94,

    COUNT = 95
}


---@enum PersonModel
PersonModel = {
    None = 0,
    Wild = 1,
    Brave = 2,
    Warrior = 3,
    Religious = 4,
    Spy = 5,
    SuperWarrior = 6, FireWarrior = 6,
    MedicineMan = 7,
    Angel = 8,

    COUNT = 8
}

---@enum PersonState
PersonState = {
    None = 0,
    StandForTime = 1,
    Drowning = 2,
    Dying = 3,
    Wander = 4,
    GotoAndEat = 5,
    GotoAndDrink = 6,
    GotoDebugPoint = 7,
    WildRoam = 8,
    Summoned = 9,
    UnderCommand = 10,
    Selected = 11,
    ReselectWait = 12,
    BaseWander = 13,
    AwaitingCommand = 14,
    WildEat = 15,
    WildDrink = 16,
    GotoBaseAndWait = 17,
    GotoPoint = 18,
    WaitAtPoint = 19,
    Spare = 20,
    WaitAtBuilding = 21,
    SpellTrance = 22,
    BeingPreached = 23,
    InWhirlwind = 24,
    FightPerson2 = 25,
    RunAway = 26,
    SwampDrowning = 27,
    AngelRoam = 28,
    PreFightPerson2 = 29,
    WaitInVehicle = 30,
    OnFire = 31,
    WildRepopulate = 32,
    NavigationFailed = 33,
    WildStareAtThing = 34,
    SurprisedByPlayer = 35,
    SuperReturnFire = 36,
    WaitFirstAppear = 37,
    GotoSpellCastPoint = 38,
    ArmageddonAttackReady = 39,
    AOD2Victim = 40,
    VictoryDance = 41,
    ShamanInPrision = 42,
    Scatter = 43,
    Electrocuted = 44,

    COUNT = 45
}


---@enum SceneryModel
SceneryModel = {
    Tree1 = 1,
    Tree2 = 2,
    Tree3 = 3,
    Tree4 = 4,
    Tree5 = 5,
    Tree6 = 6,
    Plant1 = 7,
    Plant2 = 8,
    Head = 9,
    Fire = 10,
    WoodPile = 11,
    RSPillar = 12,
    Rock = 13,
    Portal = 14,
    Island = 15,
    Bridge = 16,
    DormantTree = 17,
    TopLevelScenery = 18,
    SubLevelScenery = 19,

    COUNT = 19
}

---@enum SceneryState
SceneryState = {
    Stand = 1,
    Sink = 2,
    Fire = 3,
    WoodPile = 4,
    OnFire = 5,
    RSPillar = 6,
    Rolling = 7,
    DoNothing = 8,
    DormantTree = 9,
    Grounded = 10,
    HeadRaise = 11,
    HeadLower = 12,
    ControlledRaise = 13
}


---@enum SpellModel
SpellModel = {
    None = 0,
    Burn = 1,
    Blast = 2,
    LightningBolt = 3,
    Whirlwind = 4,
    InsectPlage = 5,
    Invisibility = 6,
    Hypnotism = 7,
    Firestorm = 8,
    GhostArmy = 9,
    Erosion = 10,
    Swamp = 11,
    LandBridge = 12,
    AngelOfDeath = 13,
    Earthquake = 14,
    Flatten = 15,
    Volcano = 16,
    ConvertWild = 17,
    Armageddon = 18,
    Shield = 19,
    Bloodlust = 20,
    Teleport = 21,

    LandscapeSpellNone = 22,
    Hill = 23,
    Rise = 24,
    Valley = 25,
    Dip = 26,
    PlaceTree = 27,
    ClearMapWho = 28,
    PlaceShaman = 29,
    PlaceWild = 30,

    NORMALS_COUNT = 21,
    NUM_LANDSCAPE = 30,
    COUNT = 32
}


---@enum GeneralModel
GeneralModel = {
    Light = 1,
    Discovery = 2,
    DebugStatic = 3,
    DebugFlying = 4,
    DebugFlag = 5,
    Trigger = 6,
    VehicleConstruction = 7,
    MapwhoThing = 8,
    BuildingAddOn = 9,
    DiscoveryMarker = 10,

    COUNT = 10
}


---@enum ShotModel
ShotModel = {
    Standard = 1,
    Standard2 = 2,
    Standard3 = 3,
    Fireball = 4,
    Lightning = 5,
    SuperWarrior = 6,
    VolcanoFireball1 = 7,
    VolcanoFireball2 = 8,

    COUNT = 8
}


---@enum ShapeModel
ShapeModel = {
    General = 1,

    COUNT = 1
}


---@enum InternalModel
InternalModel = {
    Formation = 1,
    Beacon = 2,
    ThingInfoDisplay = 3,
    SoulConverter = 4,
    SoulMan = 5,
    MedManAttract = 6,
    ObjFace = 7,
    Fight = 8,
    PreFight = 9,
    GuardControl = 10,
    BridgeControl = 11,
    SoulConverter2 = 12,
    DTBeacon = 13,
    PlayerRaise = 14,
    PlayerLower = 15,
    GuardPostDisplay = 16,
    PlayerSmooth = 17,
    WoodDisturb = 18,
    SinkingBuilding = 19,

    COUNT = 19
}


---@enum VehicleModel
VehicleModel = {
    Boat1 = 1, Boat = 1,
    Boat2 = 2,
    Airship1 = 3, Airship = 3,
    Airship2 = 4,

    COUNT = 4
}



--[[ Create Things functions ]]--

---@param model BuildingModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateBuilding(model, owner, coords)
    return createThing(ThingType.Building, model, owner, coords, false, false)
end

---@param model CreatureModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateCreature(model, owner, coords)
    return createThing(ThingType.Creature, model, owner, coords, false, false)
end

---@param model EffectModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateEffect(model, owner, coords)
    return createThing(ThingType.Effect, model, owner, coords, false, false)
end

---@param model PersonModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreatePerson(model, owner, coords)
    return createThing(ThingType.Person, model, owner, coords, false, false)
end

---@param model SceneryModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateScenery(model, owner, coords)
    return createThing(ThingType.Scenery, model, owner, coords, false, false)
end

---@param model SpellModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateSpell(model, owner, coords)
    return createThing(ThingType.Spell, model, owner, coords, false, false)
end

---@param model GeneralModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateGeneral(model, owner, coords)
    return createThing(ThingType.General, model, owner, coords, false, false)
end

---@param model ShotModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateShot(model, owner, coords)
    return createThing(ThingType.Shot, model, owner, coords, false, false)
end

---@param model ShapeModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateShape(model, owner, coords)
    return createThing(ThingType.Shape, model, owner, coords, false, false)
end

---@param model InternalModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateInternal(model, owner, coords)
    return createThing(ThingType.Internal, model, owner, coords, false, false)
end

---@param model VehicleModel
---@param owner Tribe
---@param coords Coord3D
---@return Thing
function CreateVehicle(model, owner, coords)
    return createThing(ThingType.Vehicle, model, owner, coords, false, false)
end
