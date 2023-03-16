---@meta

---@class AODDrawThing
---@field TargetDrawNum integer
---@field TweenCount integer
AODDrawThing = {}

---@class Beacon
---@field BDInfo BeaconDisplayInfo[] length = 3
---@field Count integer
---@field CurrCellRadius integer
---@field CurrMaxCellRadius integer
---@field InfluenceFactor integer
---@field LinkedThingIdx ObjectProxy
---@field TimeBeforeSearchStart integer
Beacon = {}

---@class BeaconDisplayInfo
---@field Alt integer
---@field Flags integer
---@field Radius integer
BeaconDisplayInfo = {}

---@class Blast
---@field AffectAll integer
---@field AltIncrement integer
---@field BurningBlast integer
---@field CurrCellRadius integer
---@field DoneFirstAffect integer
---@field Duration integer
---@field Flags integer
---@field MaxCellRadius integer
---@field MaxEffectSpeed integer
---@field MaxEffectWorldRadius integer
---@field RadiusIncrement integer
Blast = {}

---@class BridgeControl
---@field BridgeThingIdx ObjectProxy
BridgeControl = {}

---@class Building
---@field AddOnIdx ObjectProxy
---@field BasePos Coord2D
---@field BeaconIdx ObjectProxy
---@field ChimneySmokeIdx ObjectProxy
---@field Count integer
---@field Damaged integer
---@field DrawOwner integer
---@field Dwellers ObjectProxy[] length = 6
---@field Flags integer
---@field HasBuildingExistedBefore integer
---@field LastDamagedBy integer
---@field LastPersonLeftAt integer
---@field LastPersonTrainedAt integer
---@field LinkTriggerIdx ObjectProxy
---@field NumDwellers integer
---@field NumExpected integer
---@field NumExpectedCountDown integer
---@field PersonToBeTrainedIdx integer
---@field PrevOwner integer
---@field PrevStage integer
---@field QueueInteractCount integer
---@field QueueLinkIdx ObjectProxy
---@field QueueReorderPos integer
---@field ShapeThingIdx ObjectProxy
---@field SproggingCount integer
---@field TIDIdx integer
---@field TmpProcessChild ObjectProxy
---@field TrainingManaCost integer
---@field UpgradeCount integer
---@field VehicleAcquiredWood integer
---@field VehicleConstrThingIdx ObjectProxy
Building = {}

---@class BuildingTypeInfo
---@field ObjectIdx integer
---@field ButtonTooltipText integer
---@field ToolTipStrId1 integer
---@field ToolTipStrId2 integer
---@field ToolTipStrId3 integer
---@field DiscoveryObjectIdx integer
---@field DrawTableIdx integer
---@field GUIButtonId integer
---@field CursorSpriteNum integer
---@field MinBuilders integer
---@field MaxBuilders integer
---@field DfltBuilders integer
---@field ReqdShapeWood integer
---@field ReqdBldgWood integer
---@field AtlantisWoodDecr integer
---@field MaxNumWoodCollectors integer
---@field MaxNumFlatteners integer
---@field MaxNumDwellers integer
---@field MaxNumAttackers integer
---@field WaiterWanderRadius integer
---@field WorkWanderRadius integer
---@field WorkAltOffset integer
---@field UnitHarmonyIncr integer
---@field TrainingLength integer
---@field ConversionCount integer
---@field DamageThreshold integer
---@field BldgValue integer
---@field ModelProduced integer
---@field GuiStateGroup integer
---@field UpgradeLevel integer
---@field UpgradeModel integer
---@field ShadowDepth integer
---@field UpgradeTime integer
---@field HouseBldgManaFactor integer
---@field PeopleMinMaxPopValue integer
---@field SproggingTime integer
---@field AddOnInfo integer
---@field ArmageddonValue integer
---@field ArmageddonModel integer
---@field FlattenAmt integer
---@field RepairAltIncr integer
---@field MaxAltDiff integer
---@field Flags integer
BuildingTypeInfo = {}

---@class BytePosOffsets
---@field XO integer
---@field ZO integer
BytePosOffsets = {}

---@class CmdIdxSize
---@field CellsX integer
---@field CellsZ integer
---@field MapIdx integer
CmdIdxSize = {}

---@class CmdTMIdxs
---@field MapIdx integer
---@field TargetIdx ObjectProxy
CmdTMIdxs = {}

---@class CmdTargetInfo
---@field BldgModel integer
---@field Owner integer
---@field TargetCoord Coord2D
---@field TargetIdx ObjectProxy
---@field TIdxSize CmdIdxSize
---@field TMIdxs CmdTMIdxs
CmdTargetInfo = {}

---@class Commands
---@field CommandType integer
---@field ControlThingIdx ObjectProxy
---@field Flags integer
---@field NumCommandees integer
---@field u CmdTargetInfo
Commands = {}

---@class ComputerAttributes
---@field Value integer[] length = 48
ComputerAttributes = {}

---@class Coord2D
---@field Xpos integer
---@field Zpos integer
Coord2D = {
    ---@return Coord2D
    new = function() end
}

---@class Coord3D
---@field Xpos integer
---@field Ypos integer
---@field Zpos integer
Coord3D = {
    ---@return Coord3D
    new = function() end
}

---@class Coord3DDebug
---@field Xpos0 integer
---@field Xpos1 integer
---@field Ypos0 integer
---@field Ypos1 integer
---@field Zpos0 integer
---@field Zpos1 integer
Coord3DDebug = {}

---@class Creature
---@field AheadAlt integer
---@field Count integer
---@field EagleRoll integer
---@field Flags integer
---@field Hunger integer
---@field LeaderIdx ObjectProxy
---@field Leadership integer
---@field Life integer
---@field MaxMembersInGroup integer
---@field MembersInGroup integer
---@field MeStoreIdx integer
---@field PrefAlt integer
---@field RaiseAlt integer
---@field TargetIdx ObjectProxy
---@field Thirst integer
Creature = {}

---@class CurrentGameDescription
---@field CurrentLevel integer
CurrentGameDescription = {}

---@class DTBeacon
---@field CurrBldgCellRange integer
---@field CurrDwellerCellRange integer
---@field CurrMaxCellRange integer
---@field LinkedThingIdx ObjectProxy
---@field RecalcBldgRange integer
---@field RecalcDwellerRange integer
DTBeacon = {}

---@class Discovery
---@field AvailabilityType integer
---@field CountToEffect integer
---@field CountToPlayerUpdate integer
---@field DiscoveringPlayer integer
---@field DiscoveryModel integer
---@field DiscoveryType integer
---@field DrawLinkThing ObjectProxy
---@field ManaAmt integer
---@field TriggerType integer
Discovery = {}

---@class DiscoveryDescription
---@field Model integer
---@field ObjectiveIndex integer
---@field Type integer
DiscoveryDescription = {}

---@class DiscoveryMarker
---@field AvailabilityType integer
---@field CountToEffect integer
---@field CountToPlayerUpdate integer
DiscoveryMarker = {}

---@class DormantTree
---@field Count integer
---@field Model integer
---@field Type integer
DormantTree = {}

---@class DrawInfo
---@field Alpha integer
---@field DrawNum integer
---@field DrawTableIdx integer
---@field Flags integer
---@field FrameCount integer
---@field FrameNum integer
---@field SeqNum integer
DrawInfo = {}

---@class DrawnAtInfo
---@field EngineDrawnAtX integer
---@field EngineDrawnAtY integer
---@field ScannerDrawnAtX integer
---@field ScannerDrawnAtY integer
DrawnAtInfo = {}

---@class EffectAlphaInfo
---@field Alpha integer[] length = 3
---@field Prob integer[] length = 2
EffectAlphaInfo = {}

---@class EffectArmageddon
---@field CreateArenaCount integer
---@field EndArmageddon integer
---@field GotoBattleCount integer
---@field LastShamanCastingIdx integer
---@field NumPeopleMovePerTurn integer[] length = 10
---@field PlayerArenaOrder integer[] length = 10
---@field ProcessBldgDestroy integer
---@field ProcessCameraAngle integer
---@field ProcessCreateArena integer
---@field ProcessLineUpPeople integer
---@field ProcessReincSites integer
---@field ShamanSpellCastCount integer
---@field SilenceBeforeAttackTime integer
---@field SoundEffectCount integer
EffectArmageddon = {}

---@class EffectAtlantis
---@field CreateOwner integer
EffectAtlantis = {}

---@class EffectAttached
---@field ThingIdx ObjectProxy
EffectAttached = {}

---@class EffectEarthquake
---@field MePos integer
---@field Side integer
EffectEarthquake = {}

---@class EffectFireCloud
---@field Count2 integer
---@field HorizRadius integer
---@field NumElems integer
---@field VertRadius integer
EffectFireCloud = {}

---@class EffectFireRoll
---@field AODLinkThing integer
---@field CurrentStage integer
---@field StageCount integer
---@field StatueLinkThing integer
EffectFireRoll = {}

---@class EffectFireStorm
---@field StartPos Coord2D
EffectFireStorm = {}

---@class EffectFlatten
---@field FireRadius integer
---@field LandRadius integer
---@field PrefAlt integer
---@field Radius integer
EffectFlatten = {}

---@class EffectFlyThing
---@field Colour integer
---@field FlyFriends Coord2D[] length = 5
---@field PrefOffsetY integer
EffectFlyThing = {}

---@class EffectGeneral
---@field Count integer
---@field Duration integer
---@field EffectLinkThing ObjectProxy
---@field AttackedThingsIdxs ObjectProxy[] length = 10
---@field ScaleFactorX integer
---@field ScaleFactorY integer
---@field AlphaInfo EffectAlphaInfo
---@field AODStatue EffectStatueToAOD
---@field Armageddon EffectArmageddon
---@field Atlantis EffectAtlantis
---@field Earthquake EffectEarthquake
---@field FireCloud EffectFireCloud
---@field FireStorm EffectFireStorm
---@field Flatten EffectFlatten
---@field FlyThing EffectFlyThing
---@field InsectPlage EffectInsectPlage
---@field LandAlter EffectLandAlter
---@field LandBridge EffectLandBridge
---@field LavaFlow EffectLavaFlow
---@field Lightning EffectLightning
---@field Meteor EffectMeteor
---@field Orbiter EffectOrbiter
---@field RSPrepare EffectRSPrepare
---@field Swamp EffectSwamp
EffectGeneral = {}

---@class EffectInsectPlage
---@field NumElems integer
---@field SS2 integer
---@field StartPos Coord2D
EffectInsectPlage = {}

---@class EffectLandAlter
---@field Height integer
---@field MePos integer
---@field Radius integer
---@field Sense integer
EffectLandAlter = {}

---@class EffectLandBridge
---@field EndC2D Coord2D
---@field EndMapPos MapPosXZ
---@field StartC2D Coord2D
---@field StartMapPos MapPosXZ
---@field Type integer
---@field Water integer
---@field XStep integer
---@field YStep integer
---@field ZStep integer
EffectLandBridge = {}

---@class EffectLavaFlow
---@field CurrRadius integer
---@field MaxRadius integer
---@field Volume integer
EffectLavaFlow = {}

---@class EffectLightning
---@field Points Coord3D[] length = 9
---@field RandSeed integer
---@field Remainder integer
---@field Stages integer
EffectLightning = {}

---@class EffectMeteor
---@field Radius integer
---@field YSpeed integer
EffectMeteor = {}

---@class EffectOrbiter
---@field AngleStep integer
---@field Direction integer
---@field Lissajoux integer
---@field Phi integer
---@field Radius integer
---@field Theta integer
EffectOrbiter = {}

---@class EffectRSPrepare
---@field FireRadius integer
---@field Flags integer
---@field LandRadius integer
EffectRSPrepare = {}

---@class EffectStatueToAOD
---@field CurrentStage integer
---@field  StageCount integer
EffectStatueToAOD = {}

---@class EffectSwamp
---@field ReedsPositionCode integer
EffectSwamp = {}

---@class EffectTumblingBranch
---@field WWThingIdx ObjectProxy
EffectTumblingBranch = {}

---@class EffectWhirlwind
---@field ConeHeight integer
---@field Count integer
---@field Duration integer
---@field NumCircuits integer
---@field NumElements integer
---@field OverWaterCount integer
---@field Rotation integer
---@field TopRadius integer
EffectWhirlwind = {}

---@class Fight
---@field FighterIdxs ObjectProxy[] length = 6
---@field LinkBlgdIdx ObjectProxy
---@field Owner1 integer
---@field Owner2 integer
---@field TotalFighters integer
---@field UnderDogIdx ObjectProxy
---@field WinningOwner integer
Fight = {}

---@class FontNums
---@field Debug integer
---@field FlashMsg integer
---@field GameOverMsg integer
---@field GenButtons integer
---@field Input integer
---@field LevelStats integer
---@field Panel integer
---@field PeoplePanel integer
---@field ThingDebug integer
---@field UserMsg integer
---@field VersionInfo integer
---@field VersionInfoSmall integer
FontNums = {}

---@class Formation
---@field FirstFreePos integer
---@field NumMembers integer
---@field PosOffsets BytePosOffsets[] length = 12
---@field ThingIdxs ObjectProxy[] length = 12
Formation = {}

---@class GameParams
---@field AltChangeNoAffectDist integer
---@field CurrParamNum integer
---@field CurrParamValueNum integer
---@field Flags integer
---@field Flags2 integer
---@field MoveMomentumAmt integer
---@field NumParams integer
GameParams = {}

---@class General
---@field BasePos Coord2D
---@field Orient integer
General = {}

---@class General3D
---@field X integer
---@field Y integer
---@field Z integer
General3D = {}

---@class GlobalClassesItems
---@field WoodSearchEngine2 unknown
GlobalClassesItems = {}

---@class GlobalNonSaveItems
---@field PlayerNum integer
---@field PhysScreenW integer
---@field PhysScreenH integer
---@field ScreenW integer
---@field ScreenH integer
---@field ScreenD integer
---@field FontNums FontNums
---@field Flags integer
---@field GameParams GameParams
---@field ThingLevelHeader LevelHeaderv3
---@field StartLevelNumber integer
---@field DwellCapacityValidity integer
---@field CurrentGameDescription CurrentGameDescription
---@field AudioInfo AudioInfo
GlobalNonSaveItems = {}

---@class FogOfWar
FogOfWar = {}

---@param tribe Tribe
---@param elem MapElement
function FogOfWar:uncover(tribe, elem) end

---@param tribe Tribe
---@param elem MapElement
function FogOfWar:perm_uncover(tribe, elem) end

---@param elem MapElement
function FogOfWar:uncover_for_all_players(elem) end

---@param elem MapElement
function FogOfWar:perm_uncover_all_players(elem) end

function FogOfWar:clear() end

---@param elem MapElement
---@return integer
function FogOfWar:is_uncovered(elem) end

---@param elem MapElement
function FogOfWar.clear_perm_uncover_all_players(elem) end

---@param tribe Tribe
---@param elem MapElement
function FogOfWar.clear_perm_uncover(tribe, elem) end


---@class GlobalSaveItems
---@field Level Level
---@field Counts NetworkCounts
---@field Players Player[] length = 10
---@field CurrNumPlayers integer
---@field CurrMaxNumPlayers integer
---@field CurrObjectBank integer
---@field CurrLevelFlags integer
---@field GameSpeed integer
---@field StartNumWildPeople integer
---@field SpellsPresentOnLevel integer
---@field BuildingsPresentOnLevel integer
---@field PermBuildingPresentOnLevel integer
---@field LevelInfo LevelInfo
---@field ThisLevelInfo ThisLevelInfo
---@field FogOfWar FogOfWar
GlobalSaveItems = {}

---@class GuardAreaControl
---@field CellsX integer
---@field CellsZ integer
---@field Count1 integer
---@field Count2 integer
---@field CurrDist integer
---@field CurrPeopleCount integer
---@field EnemyPresence integer
---@field GameTurnProcessed integer
---@field MapIdx integer
---@field PrevPeopleCount integer
---@field PrevPeopleCountTotal integer
GuardAreaControl = {}

---@class Level
---@field MapElements MapElement[] length = 16384
---@field WildBuckets integer[] length = 64
Level = {}

---@class LevelHeaderv3
---@field LevelType integer
---@field ObjectsBankNum integer
---@field LevelFlags integer
---@field NumPlayers integer
LevelHeaderv3 = {}

---@class LevelInfo
---@field PlayerStartPositions Coord2D[] length = 10
LevelInfo = {}

---@class MapElement
---@field Alt integer
---@field Cliff integer
---@field CollideTableIdxAndWDTFlags integer
---@field Flags integer
---@field Flags2 integer
---@field MapWhoList ObjectList
---@field MapWhoLocalList ObjectList
---@field ObjectShadowAndLavaNum integer
---@field OwnerInfo integer
---@field PlayerMapWho ObjectList[] length = 10
---@field Shade1 integer
---@field ShadeIncr integer
---@field ShapeOrBldgIdx ObjectProxy
MapElement = {}

---@class MapPosXZ
---@field Pos integer
---@field XZ PosAsXZ
MapPosXZ = {
    ---@return MapPosXZ
    new = function() end
}

---@class MedManAttract
---@field BeaconIdx ObjectProxy
---@field Count integer
---@field FireIdx ObjectProxy
---@field MedManIdx ObjectProxy
MedManAttract = {}

---@class Movement
---@field BldgDieCount integer
---@field BldgDrawNum integer
---@field CurrAngleXZ integer
---@field CurrDest MovementDestInfo
---@field FinalCoord Coord2D
---@field LastNavigation integer
---@field LastWoodSearchEngineIdx integer
---@field NavigationCount integer
---@field ObjectBlastedCount integer
---@field ObjectBlastedMapIdx integer
---@field SelfPowerSpeed integer
---@field StageCoord Coord2D
---@field Velocity General3D
---@field WanderFactor integer
Movement = {}

---@class MovementDestAngleInfo
---@field XZ integer
---@field ZY integer
MovementDestAngleInfo = {}

---@class MovementDestCoordInfo
---@field D2 Coord2D
---@field D3 Coord3D
MovementDestCoordInfo = {}

---@class MovementDestInfo
---@field Angles MovementDestAngleInfo
---@field  AngleXZ integer
---@field Coord Coord2D
---@field Coords MovementDestCoordInfo|integer
MovementDestInfo = {}

---@class NetworkCounts
---@field GameTurn integer
---@field ProcessThings integer
NetworkCounts = {}

---@class ObjectFaceThing
---@field AngleIncrs integer[] length = 3
---@field DrawFrame integer
---@field FaceIdx integer
---@field NumPoints integer
---@field Points Points3DWord[] length = 4
---@field PolyDrawMode integer
---@field WWThingIdx ObjectProxy
---@field YIncr integer
ObjectFaceThing = {}

---@class ObjectThingInfo
---@field ConstructionStage integer
---@field CurrentFrame integer
---@field KeyStart integer
---@field KeyStop integer
---@field NumFrames integer
---@field Roll integer
---@field Scale integer
---@field StopFrame integer
---@field Tilt integer
ObjectThingInfo = {}

---@class ObjectTraversal
ObjectTraversal = {
    ---@param arg integer
    ---@return integer
    sortOutNeutralPlayerNum = function(arg) end
}

---@class P3Constants
---@field MaxManaValue integer
---@field StartManaValue integer
---@field ConvertPersonManaCost integer
---@field GrabSoulManaCost integer
---@field TrainingManaBucketSize integer
---@field HumanManaAdjustFactor integer
---@field ComputerManaAdjustFactor integer
---@field HarmonyUnsheltered integer
---@field HarmonySheltered integer
---@field HarmonyEmployed integer
---@field HarmonyUnemployed integer
---@field MaxHarmonyIncr integer
---@field MinHarmonyIncr integer
---@field TrainingManaFactor integer
---@field HouseManaFactor integer
---@field WorkingManaFactor integer
---@field MaxManaFactor integer
---@field ManaUpdateFreq integer
---@field MaxWalkableAltDiff integer
---@field MaxWalkableAltDiffShallow integer
---@field MaxBuildableAltDiff integer
---@field MaxBoatHutAltDiff integer
---@field MaxBuildingDestroyAltDiff integer
---@field RaiseLowerManaCost integer
---@field TriggerReactiveCount integer
---@field SuperWarriorFireRate integer
---@field SuperWarriorBlastDamage integer
---@field SuperWarriorFireRateTower integer
---@field SuperWarriorBlastDamageTower integer
---@field SproggRatePer256Bands integer[] length = 20
---@field HypnoNumPeopleAffected integer
---@field SwampNumPeopleAffected integer
---@field LightningNumPeopleAffected integer
---@field InvisNumPeopleAffected integer
---@field ShieldNumPeopleAffected integer
---@field BloodlustNumPeopleAffected integer
---@field ShapeNearBldgCells integer
---@field ShamenDeadManaPer256Lost integer
---@field ShamenDeadManaPer256Gained integer
---@field InvisibleCount integer
---@field HypnotisedCount integer
---@field ShieldCount integer
---@field BldgDamageDelay integer
---@field PreacheeCheckConvFreq integer
---@field PreacheeConvertChance integer
---@field BloodlustCount integer
---@field BldgBlastDamage integer
---@field PersBlastDamage integer
---@field SwarmPersonDamage integer
---@field LandBridgeMaxAltChange integer
---@field BraveDtRadius integer
---@field WarriorDtRadius integer
---@field SpyDtRadius integer
---@field SuperWarriorDtRadius integer
---@field MedicineManDtRadius integer
---@field FallOutOfWhirlwindDamage integer
---@field AltBandSpellRadiusAffectPer256 integer[] length = 8
---@field AltBandSuperRadiusAffectPer256 integer[] length = 8
---@field SpecialConvManaCostPer256Bands integer[] length = 10
---@field FirestormDuration integer
---@field SpyDisgueseDelay integer
---@field MultipleSelectNumber integer
---@field DMETimeBeforeRestore integer
---@field AOD2KillCount integer
---@field AOD2Duration integer
---@field LandBridgeDuration integer
---@field BloodlustDamageMultiplier integer
---@field BloodlustHealthMultiplier integer
---@field BloodlustSWarriorBlastRate integer
---@field FriendliesAffectedByBlast integer
---@field IdleBravesMana integer
---@field IdleSpecialistsMana integer
---@field BusyBravesMana integer
---@field BusySpecialistsMana integer
---@field LSMENumTreesPerShot integer
---@field LSMENumWildsPerShot integer
---@field LSMETimeLimitSeconds integer
---@field LSMEPointAltAlterAmount integer
---@field HumanReincStartDelay integer
---@field LSMEWorldCoordRangeRaiseLower integer
---@field AOD2StatueSecsBeforeSeekShaman integer
---@field SuperWarriorBlastDamageShamanInVehiclePer256 integer
P3Constants = {}

---@class PeopleTypeInfo
---@field AttackPower integer
---@field AutoGuardFreq integer
---@field BaseFightEnergy integer
---@field BaseHunger integer
---@field BaseThirst integer
---@field CanCarryWood integer
---@field ComputerConvManaCost integer
---@field ConvValue integer
---@field CPDefenceValue integer
---@field DefaultLife integer
---@field DrownAlt integer
---@field DrownRate integer
---@field FightPriority integer
---@field Flags integer
---@field GhostingValue integer
---@field GotoPointDistCheck integer
---@field GuardDiamCmd integer
---@field GuardDiamIdle integer
---@field HumanConvManaCost integer
---@field KilledValue integer
---@field LifeIncrease integer
---@field ManaValue integer
---@field MoveInfoIdx integer
---@field Radius integer
---@field SightCells integer
---@field SWBlastPer256 integer
---@field ToolTipStrId1 integer
---@field ToolTipStrId2 integer
---@field TopState integer
---@field UnemployedState integer
---@field WoodCutTime integer
PeopleTypeInfo = {}

---@class Person
---@field Life integer
---@field MaxLife integer
---@field Hunger integer
---@field Thirst integer
---@field TargetIdx ObjectProxy
---@field WoodCarrying integer
---@field u PersonThingData
Person = {}

---@class PersonOwned
---@field BloodlustCount integer
---@field Count2 integer
---@field FightGroup integer
---@field GuardPosSlot integer
---@field HypnoTime integer
---@field InHouseCount integer
---@field InvisibleCount integer
---@field LastDamageBy integer
---@field OnFireCount integer
---@field OriginalHypnoOwner integer
---@field ShieldCount integer
---@field SubState2a integer
---@field SubState3 integer
---@field SubState4 integer
---@field TimeDoingNothing integer
---@field u unknown
---@field AngleHasKilled integer
---@field MissileFireCount integer
---@field PreacherFlags integer
---@field ShamanFlags integer
---@field SpyDiscuiseOwner integer
PersonOwned = {}

---@class PersonThingData
---@field Owned PersonOwned
---@field Wild PersonWild
PersonThingData = {}

---@class PersonWild
---@field NextOwner integer
---@field ProcessSummon integer
---@field SummonInfo unknown[] length = 10
---@field TimeBeforeSummonable integer
---@field UnderInfluence integer
PersonWild = {}

---@class Player
---@field PlayerNum Tribe Tribe
---@field StartNumPeople integer
---@field Mana integer
---@field NumPeople integer
---@field NumBuildings integer
---@field NumBuildingMarkers integer
---@field NumBuildingsOfType integer[] length = 20
---@field NumBuiltOrPartBuiltBuildingsOfType integer[] length = 20
---@field NumDeadSoulConverters integer
---@field NumGhostPeople integer
---@field NumLocalPeopleInBalloons integer[] length = 9
---@field NumLocalPeopleInBoats integer[] length = 9
---@field NumLocalPeopleInGuiState integer[][] length = rows:9, cols:6
---@field NumLocalPeopleOfType integer[] length = 9
---@field NumPeopleOfType integer[] length = 9
---@field NumVehiclesOfType integer[] length = 5
---@field NumWildToRepopulate integer
---@field ShamanLives integer
---@field ReincarnSiteCoord Coord3D
---@field SpellsMana integer[] length = 32
---@field PeopleKilled integer[] length = 10
---@field SpellsCast integer[] length = 22
---@field ManaTransferAmt integer
---@field ManaUnspent integer
---@field TotalManaIncr integer
---@field OptimalManaIncome integer
---@field ManaTransferCount integer
---@field ManaTransferRate integer
---@field NumPeopleConverted integer
---@field SpellDelayCount integer
---@field PlayerType integer
---@field PlayerActive integer
---@field MigratedPlayer integer
---@field DeadCount integer
Player = {}

---@class PlayerContainer
---@field Shaman Thing
---@field PlayerLists ObjectList[] length = 15
PlayerContainer = {}

---@class PlayerThings
---@field BuildingsAvailable integer
---@field BuildingsAvailableLevel integer
---@field BuildingsAvailableOnce integer
---@field Flags integer
---@field SpellsAvailable integer
---@field SpellsAvailableLevel integer
---@field SpellsAvailableOnce integer[] length = 32
---@field SpellsNotCharging integer
---@field TrainingManOff integer
---@field VehiclesAvailable integer
PlayerThings = {}

---@class Points3DWord
---@field WX integer
---@field WY integer
---@field WZ integer
Points3DWord = {}

---@class PosAsXZ
---@field X integer
---@field Z integer
PosAsXZ = {}

---@class PreFight
---@field FighterIdxs ObjectProxy[] length = 2
---@field LinkBldgIdx ObjectProxy
---@field Owner1 integer
---@field Owner2 integer
PreFight = {}

---@class Scenery
---@field AltOffset integer
---@field BridgeIdx ObjectProxy
---@field BridgeNum integer
---@field Cost integer[] length = 8
---@field Duration integer
---@field Flags integer
---@field GrowthRate integer
---@field HeadType integer
---@field IsLandNum integer
---@field LevelDrawNum integer
---@field LinkTriggerIdx ObjectProxy
---@field MaxScale integer
---@field PlayerEnroute integer
---@field PortalLevel integer
---@field PortalStatus integer
---@field PortalType integer
---@field ResourceRemaining integer
---@field ScaleIncr integer
---@field Type integer
---@field UnitsEnroute integer
---@field UserId integer
---@field WWThingIdx integer
Scenery = {}

---@class SceneryTypeInfo
---@field DrawTableIdx integer
---@field ToolTipStrId integer
---@field DfltResourceValue integer
---@field DormantTime integer
---@field DrawNum integer
---@field DrownRate integer
---@field DrownAlt integer
---@field Colour integer
---@field TopState integer
---@field MoveInfoIdx integer
---@field ShadowDepth integer
---@field Flags integer
SceneryTypeInfo = {}

---@class Shape
---@field AcquiredWood integer
---@field AttackDamageDelay integer
---@field BldgModel integer
---@field BldgThingIdx ObjectProxy
---@field Flags integer
---@field LastDamangeBy integer
---@field NumWorkers integer
---@field Orient integer
---@field OriginMapIdx integer
---@field OtherWallAlt integer
---@field ShapeIdx integer
---@field TimeOut integer
---@field WorkerIdxs ObjectProxy[] length = 20
Shape = {}

---@class ShotGeneral
---@field Count integer
---@field Count2 integer
---@field EffectModel integer
---@field EffectNumParams integer
---@field EffectParams integer[] length = 4
---@field EffectType integer
---@field Flags integer
---@field ItemDuration integer
---@field ItemsPerTurn integer
---@field ItemThingIdxs ObjectProxy[] length = 6
---@field ShotThingParent integer
---@field SpecialThingIdxs ObjectProxy[] length = 2
---@field SpeedPerItem integer
---@field StartCoord Coord3D
---@field TargetCoord Coord3D
---@field TargetThingIdx ObjectProxy
ShotGeneral = {}

---@class SoulConverter
---@field BeamClr integer
---@field Count integer
---@field CurrModel integer
---@field FallenToGround integer
---@field NumReturns integer
---@field ReturnBldgIdx ObjectProxy
---@field ReturnModel integer
---@field ReturnOwner integer
---@field SoulManIdx ObjectProxy
---@field WoodUnitsToDrop integer
SoulConverter = {}

---@class SpellGeneral
---@field ChargePlayer integer
---@field Shot2StartCoord Coord3D
---@field ShotThingIdx ObjectProxy
---@field TargetCoord Coord3D
---@field TargetThingIdx ObjectProxy
SpellGeneral = {}

---@class SpellsTypeInfo
---@field Active integer
---@field NetworkOnly integer
---@field Cost integer
---@field Model integer
---@field GUIButtonId integer
---@field CursorSpriteNum integer
---@field DiscoveryDrawIdx integer
---@field AvailableSpriteIdx integer
---@field NotAvailablePriteIdx integer
---@field ClickedSpriteIdx integer
---@field ToolTipStrIdx integer
---@field ToolTipStrIdxLSME integer
---@field Flags integer
---@field WorldCoordRange integer
---@field WorldCoordRangeLSME integer
---@field OneOffMaximum integer
---@field LSMEOneOffMaximum integer
---@field ShieldReboundable integer
---@field PanelSampleIdx integer
---@field PanelSampleCount integer
---@field PanelSampleType integer
---@field CreateCastMsg integer
---@field CastMsgTimeout integer
---@field EncyclPage integer
---@field OptimalChargeSecs integer
---@field DrawOffsetX integer
---@field DrawOffsetY integer
---@field ShotModels integer[] length = 2
---@field EffectModels integer[] length = 5
SpellsTypeInfo = {}

---@class SpriteCircles
---@field Colour integer
---@field Duration integer
---@field RadiusCurr integer
---@field RadiusEnd integer
---@field RadiusIncr integer
---@field RadiusStart integer
SpriteCircles = {}

---@class TIDThing
---@field CellResourceValue integer
---@field GuardianPersonIdx ObjectProxy
---@field PersonFightingBldgIdx ObjectProxy
---@field TIDIdx integer
---@field TIDTypeCode integer
---@field TIDTypeFlags integer
TIDThing = {}

---@class TbSprite
---@field Data unknown 
---@field Height integer
---@field Width integer
TbSprite = {}

---@class Thing
---@field Type integer
---@field Model integer
---@field Owner Tribe
---@field TimeSlice integer
---@field ThingNum integer
---@field AngleXZ integer
---@field Flags integer
---@field Flags2 integer
---@field Flags3 integer
---@field LastAttackCountDown integer
---@field CurrNumAttackers integer
---@field State integer
---@field SubState integer
---@field MoveInfoIdx integer
---@field DrawInfo DrawInfo
---@field Move Movement
---@field Pos ThingPos
---@field InterpolatePosInc ThingPos
---@field InterpolateAngleXZInc integer
---@field u ThingTypeData
Thing = {
    ---@param other Thing
    ---@return boolean
    __eq = function(other) end
}

---@class ThingPos
---@field D2 Coord2D
---@field D3 Coord3D
---@field D3Debug Coord3DDebug
ThingPos = {}

---@class ThingTypeData
---@field AODDrawThing AODDrawThing
---@field Beacon Beacon
---@field Blast Blast
---@field Bldg Building
---@field BridgeControl BridgeControl
---@field Creature Creature
---@field Discovery Discovery
---@field DiscoveryMarker DiscoveryMarker
---@field DormantTree DormantTree
---@field DrawnAtInfo DrawnAtInfo
---@field DTBeacon DTBeacon
---@field Effect EffectGeneral
---@field Fight Fight
---@field Formation Formation
---@field General General
---@field  GuardControl GuardAreaControl
---@field MedManAttract MedManAttract
---@field ObjectInfo ObjectThingInfo
---@field ObjFace ObjectFaceThing
---@field Pers Person
---@field Platform unknown
---@field PreFight PreFight
---@field Scenery Scenery
---@field Shape Shape
---@field Shot ShotGeneral
---@field SoulConverter SoulConverter
---@field SoulMan unknown
---@field Spell SpellGeneral
---@field SprCircles SpriteCircles
---@field TIDThing TIDThing
---@field Trigger Trigger
---@field Vehicle Vehicle
---@field WDC WoodDistribControl
---@field Whirlwind EffectWhirlwind
ThingTypeData = {}

---@class ThingTypeInfo
---@field Flags integer
---@field ListFlags integer
---@field NumModels integer
ThingTypeInfo = {}

---@class ThisLevelInfo
---@field Discoveries DiscoveryDescription[] length = 3
---@field PlayerThings PlayerThings[] length = 10
---@field Attribs ComputerAttributes[] length = 10
---@field Allies integer[] length = 10
---@field ScriptInfo unknown[] length = 10
---@field ObjectiveData unknown
ThisLevelInfo = {}

---@class Trigger
---@field CellRadius integer
---@field Counts integer[] length = 10
---@field CountToReactive integer
---@field CreatePlayerOwned integer
---@field CurrRadius integer
---@field EditorThingIdx integer[] length = 10
---@field Flags integer
---@field HeadThingIdx ObjectProxy
---@field InactiveTime integer
---@field NumOccurences integer
---@field NumPlayersCurrPraying integer
---@field OriginalInactiveTime integer
---@field PrayCount integer
---@field PrayTime integer
---@field RandomValue integer
---@field ResetCount integer
---@field StartInactive integer
---@field TriggerCount integer
---@field TriggeredPendingCount integer
---@field TriggeringLastTouchedPlayer integer
---@field TriggeringPlayer integer
---@field TriggerType integer
Trigger = {}

---@class Vehicle
---@field CollideWait integer
---@field DelayBeforeSendingHome integer
---@field FightGroup integer
---@field Flags integer
---@field LastUserOwner integer
---@field Life integer
---@field NextNavRegenCount integer
---@field NumOccupants integer
---@field OccupantChangeCount integer
---@field Occupants unknown[] length = 12
---@field StuckAngleIncr integer
---@field StuckCount integer
---@field VerticalSpeed integer
---@field WaitCount integer
Vehicle = {}

---@class VehicleTypeInfo
---@field DefaultLife integer
---@field ObjectIdx integer
---@field ToolTipStrId integer
---@field MaxNumOccupants integer
---@field PositionTableIdx integer
---@field StandState integer
---@field TravelState integer
---@field ExitBldgAlt integer
---@field GroundClearance integer
---@field BoardingDist integer
---@field WoodValue integer
---@field Flags integer
VehicleTypeInfo = {}

---@class WoodDistribControl
---@field WoodDistribControl unknown[] length = 16
WoodDistribControl = {}

---@class lists
---@field FreeList ObjectList
---@field TypeList ObjectList[][] length = rows:12 cols:96
---@field UsedList ObjectList
lists = {}
