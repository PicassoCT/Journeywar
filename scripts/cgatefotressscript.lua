include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

TableOfPieces = {}
center = piece("center")
TableOfPieces[#TableOfPieces + 1] = center
Erker4 = piece("Erker4")
TableOfPieces[#TableOfPieces + 1] = Erker4
InnerLoop10 = piece("InnerLoop10")
TableOfPieces[#TableOfPieces + 1] = InnerLoop10
InnerLoop1 = piece("InnerLoop1")
TableOfPieces[#TableOfPieces + 1] = InnerLoop1
InnerLoop2 = piece("InnerLoop2")
TableOfPieces[#TableOfPieces + 1] = InnerLoop2
InnerLoop3 = piece("InnerLoop3")
TableOfPieces[#TableOfPieces + 1] = InnerLoop3
InnerLoop4 = piece("InnerLoop4")
TableOfPieces[#TableOfPieces + 1] = InnerLoop4
InnerLoop5 = piece("InnerLoop5")
TableOfPieces[#TableOfPieces + 1] = InnerLoop5
InnerLoop6 = piece("InnerLoop6")
TableOfPieces[#TableOfPieces + 1] = InnerLoop6
InnerLoop7 = piece("InnerLoop7")
TableOfPieces[#TableOfPieces + 1] = InnerLoop7
InnerLoop8 = piece("InnerLoop8")
TableOfPieces[#TableOfPieces + 1] = InnerLoop8
InnerLoop9 = piece("InnerLoop9")
TableOfPieces[#TableOfPieces + 1] = InnerLoop9
InnerLoopC = piece("InnerLoopC")
TableOfPieces[#TableOfPieces + 1] = InnerLoopC
NGon085 = piece("NGon085")
TableOfPieces[#TableOfPieces + 1] = NGon085
NGon086 = piece("NGon086")
TableOfPieces[#TableOfPieces + 1] = NGon086
NGon089 = piece("NGon089")
TableOfPieces[#TableOfPieces + 1] = NGon089
NGon090 = piece("NGon090")
TableOfPieces[#TableOfPieces + 1] = NGon090
NGon088 = piece("NGon088")
TableOfPieces[#TableOfPieces + 1] = NGon088
Gun3 = piece("Gun3")
TableOfPieces[#TableOfPieces + 1] = Gun3
Mag5 = piece("Mag5")
TableOfPieces[#TableOfPieces + 1] = Mag5
Mag6 = piece("Mag6")
TableOfPieces[#TableOfPieces + 1] = Mag6
Erker3 = piece("Erker3")
TableOfPieces[#TableOfPieces + 1] = Erker3
Erker2 = piece("Erker2")
TableOfPieces[#TableOfPieces + 1] = Erker2
NGon087 = piece("NGon087")
TableOfPieces[#TableOfPieces + 1] = NGon087
InnerOrigin = piece("InnerOrigin")
TableOfPieces[#TableOfPieces + 1] = InnerOrigin
OuterLoop12 = piece("OuterLoop12")
TableOfPieces[#TableOfPieces + 1] = OuterLoop12
OuterLoop24 = piece("OuterLoop24")
TableOfPieces[#TableOfPieces + 1] = OuterLoop24
OuterLoop27 = piece("OuterLoop27")
TableOfPieces[#TableOfPieces + 1] = OuterLoop27
Gun1 = piece("Gun1")
TableOfPieces[#TableOfPieces + 1] = Gun1
Mag1 = piece("Mag1")
TableOfPieces[#TableOfPieces + 1] = Mag1
Mag2 = piece("Mag2")
TableOfPieces[#TableOfPieces + 1] = Mag2
OuterLoop25 = piece("OuterLoop25")
TableOfPieces[#TableOfPieces + 1] = OuterLoop25
OuterLoop29 = piece("OuterLoop29")
TableOfPieces[#TableOfPieces + 1] = OuterLoop29
Gun4 = piece("Gun4")
TableOfPieces[#TableOfPieces + 1] = Gun4
Mag7 = piece("Mag7")
TableOfPieces[#TableOfPieces + 1] = Mag7
Mag8 = piece("Mag8")
TableOfPieces[#TableOfPieces + 1] = Mag8
OuterLoop30 = piece("OuterLoop30")
TableOfPieces[#TableOfPieces + 1] = OuterLoop30
OuterLoop31 = piece("OuterLoop31")
TableOfPieces[#TableOfPieces + 1] = OuterLoop31
OuterLoop32 = piece("OuterLoop32")
TableOfPieces[#TableOfPieces + 1] = OuterLoop32
OuterLoop35 = piece("OuterLoop35")
TableOfPieces[#TableOfPieces + 1] = OuterLoop35
OuterLoop36 = piece("OuterLoop36")
TableOfPieces[#TableOfPieces + 1] = OuterLoop36
OuterLoop37 = piece("OuterLoop37")
TableOfPieces[#TableOfPieces + 1] = OuterLoop37
OuterLoop38 = piece("OuterLoop38")
TableOfPieces[#TableOfPieces + 1] = OuterLoop38
OuterLoop39 = piece("OuterLoop39")
TableOfPieces[#TableOfPieces + 1] = OuterLoop39
Erker5 = piece("Erker5")
TableOfPieces[#TableOfPieces + 1] = Erker5
Erker6 = piece("Erker6")
TableOfPieces[#TableOfPieces + 1] = Erker6
OuterLoop34 = piece("OuterLoop34")
TableOfPieces[#TableOfPieces + 1] = OuterLoop34
OuterLoop40 = piece("OuterLoop40")
TableOfPieces[#TableOfPieces + 1] = OuterLoop40
OuterLoop41 = piece("OuterLoop41")
TableOfPieces[#TableOfPieces + 1] = OuterLoop41
OuterLoop43 = piece("OuterLoop43")
TableOfPieces[#TableOfPieces + 1] = OuterLoop43
RailGun = piece("RailGun")
TableOfPieces[#TableOfPieces + 1] = RailGun
Projectile = piece("Projectile")
TableOfPieces[#TableOfPieces + 1] = Projectile
DronePod1 = piece("DronePod1")
TableOfPieces[#TableOfPieces + 1] = DronePod1
DronePod2 = piece("DronePod2")
TableOfPieces[#TableOfPieces + 1] = DronePod2
OuterLoop33 = piece("OuterLoop33")
TableOfPieces[#TableOfPieces + 1] = OuterLoop33
OuterLoop42 = piece("OuterLoop42")
TableOfPieces[#TableOfPieces + 1] = OuterLoop42
OuterLoop44 = piece("OuterLoop44")
TableOfPieces[#TableOfPieces + 1] = OuterLoop44
OuterLoop47 = piece("OuterLoop47")
TableOfPieces[#TableOfPieces + 1] = OuterLoop47
OuterLoop55 = piece("OuterLoop55")
TableOfPieces[#TableOfPieces + 1] = OuterLoop55
Erker9 = piece("Erker9")
TableOfPieces[#TableOfPieces + 1] = Erker9
Erker10 = piece("Erker10")
TableOfPieces[#TableOfPieces + 1] = Erker10
OuterLoop54 = piece("OuterLoop54")
TableOfPieces[#TableOfPieces + 1] = OuterLoop54
DronePod3 = piece("DronePod3")
TableOfPieces[#TableOfPieces + 1] = DronePod3
Erker11 = piece("Erker11")
TableOfPieces[#TableOfPieces + 1] = Erker11
OuterLoop50 = piece("OuterLoop50")
TableOfPieces[#TableOfPieces + 1] = OuterLoop50
OuterLoop51 = piece("OuterLoop51")
TableOfPieces[#TableOfPieces + 1] = OuterLoop51
DronePod4 = piece("DronePod4")
TableOfPieces[#TableOfPieces + 1] = DronePod4
OuterLoop45 = piece("OuterLoop45")
TableOfPieces[#TableOfPieces + 1] = OuterLoop45
OuterLoop46 = piece("OuterLoop46")
TableOfPieces[#TableOfPieces + 1] = OuterLoop46
OuterLoop53 = piece("OuterLoop53")
TableOfPieces[#TableOfPieces + 1] = OuterLoop53
OuterLoop52 = piece("OuterLoop52")
TableOfPieces[#TableOfPieces + 1] = OuterLoop52
Erker1 = piece("Erker1")
TableOfPieces[#TableOfPieces + 1] = Erker1
Erker8 = piece("Erker8")
TableOfPieces[#TableOfPieces + 1] = Erker8
OuterLoop48 = piece("OuterLoop48")
TableOfPieces[#TableOfPieces + 1] = OuterLoop48
OuterLoop49 = piece("OuterLoop49")
TableOfPieces[#TableOfPieces + 1] = OuterLoop49
Erker7 = piece("Erker7")
TableOfPieces[#TableOfPieces + 1] = Erker7
DronePod5 = piece("DronePod5")
TableOfPieces[#TableOfPieces + 1] = DronePod5
Wall = piece("Wall")
TableOfPieces[#TableOfPieces + 1] = Wall
GatePoint = piece("GatePoint")
TableOfPieces[#TableOfPieces + 1] = GatePoint
RingB = piece("RingB")
TableOfPieces[#TableOfPieces + 1] = RingB
Ring0 = piece("Ring0")
TableOfPieces[#TableOfPieces + 1] = Ring0
GatePortal = piece("GatePortal")
TableOfPieces[#TableOfPieces + 1] = GatePortal
GateWave = piece("GateWave")
TableOfPieces[#TableOfPieces + 1] = GateWave
WaveA = piece("WaveA")
TableOfPieces[#TableOfPieces + 1] = WaveA
Feed10 = piece("Feed10")
TableOfPieces[#TableOfPieces + 1] = Feed10
Feed9 = piece("Feed9")
TableOfPieces[#TableOfPieces + 1] = Feed9
Feed8 = piece("Feed8")
TableOfPieces[#TableOfPieces + 1] = Feed8
Feed7 = piece("Feed7")
TableOfPieces[#TableOfPieces + 1] = Feed7
Feed6 = piece("Feed6")
TableOfPieces[#TableOfPieces + 1] = Feed6
Feed5 = piece("Feed5")
TableOfPieces[#TableOfPieces + 1] = Feed5
Feed4 = piece("Feed4")
TableOfPieces[#TableOfPieces + 1] = Feed4
Feed3 = piece("Feed3")
TableOfPieces[#TableOfPieces + 1] = Feed3
Feed2 = piece("Feed2")
TableOfPieces[#TableOfPieces + 1] = Feed2
Feed1 = piece("Feed1")
TableOfPieces[#TableOfPieces + 1] = Feed1
Ring3 = piece("Ring3")
TableOfPieces[#TableOfPieces + 1] = Ring3
Ring2 = piece("Ring2")
TableOfPieces[#TableOfPieces + 1] = Ring2
Ring1 = piece("Ring1")
TableOfPieces[#TableOfPieces + 1] = Ring1
BigLUpCenter = piece("BigLUpCenter")
TableOfPieces[#TableOfPieces + 1] = BigLUpCenter
OuterLoop13 = piece("OuterLoop13")
TableOfPieces[#TableOfPieces + 1] = OuterLoop13
OuterLoop14 = piece("OuterLoop14")
TableOfPieces[#TableOfPieces + 1] = OuterLoop14
OuterLoop15 = piece("OuterLoop15")
TableOfPieces[#TableOfPieces + 1] = OuterLoop15
OuterLoop16 = piece("OuterLoop16")
TableOfPieces[#TableOfPieces + 1] = OuterLoop16
OuterLoop17 = piece("OuterLoop17")
TableOfPieces[#TableOfPieces + 1] = OuterLoop17
OuterLoop18 = piece("OuterLoop18")
TableOfPieces[#TableOfPieces + 1] = OuterLoop18
OuterLoop19 = piece("OuterLoop19")
TableOfPieces[#TableOfPieces + 1] = OuterLoop19
OuterLoop20 = piece("OuterLoop20")
TableOfPieces[#TableOfPieces + 1] = OuterLoop20
OuterLoop21 = piece("OuterLoop21")
TableOfPieces[#TableOfPieces + 1] = OuterLoop21
OuterLoop22 = piece("OuterLoop22")
TableOfPieces[#TableOfPieces + 1] = OuterLoop22
OuterLoop23 = piece("OuterLoop23")
TableOfPieces[#TableOfPieces + 1] = OuterLoop23

BigLCenter = piece("BigLCenter")
TableOfPieces[#TableOfPieces + 1] = BigLCenter
OuterLoop10 = piece("OuterLoop10")
TableOfPieces[#TableOfPieces + 1] = OuterLoop10
OuterLoop11 = piece("OuterLoop11")
TableOfPieces[#TableOfPieces + 1] = OuterLoop11

UpGo1 = piece("UpGo1")
TableOfPieces[#TableOfPieces + 1] = UpGo1
UpGo2 = piece("UpGo2")
TableOfPieces[#TableOfPieces + 1] = UpGo2

OuterLoop1 = piece("OuterLoop1")
TableOfPieces[#TableOfPieces + 1] = OuterLoop1

OuterLoop56 = piece("OuterLoop56")
TableOfPieces[#TableOfPieces + 1] = OuterLoop56
OuterLoop26 = piece("OuterLoop26")
TableOfPieces[#TableOfPieces + 1] = OuterLoop26
OuterLoop28 = piece("OuterLoop28")
TableOfPieces[#TableOfPieces + 1] = OuterLoop28
Gun2 = piece("Gun2")
TableOfPieces[#TableOfPieces + 1] = Gun2
Mag3 = piece("Mag3")
TableOfPieces[#TableOfPieces + 1] = Mag3
Mag4 = piece("Mag4")
TableOfPieces[#TableOfPieces + 1] = Mag4
OuterLoop2 = piece("OuterLoop2")
TableOfPieces[#TableOfPieces + 1] = OuterLoop2
OuterLoop3 = piece("OuterLoop3")
TableOfPieces[#TableOfPieces + 1] = OuterLoop3
OuterLoop4 = piece("OuterLoop4")
TableOfPieces[#TableOfPieces + 1] = OuterLoop4
OuterLoop5 = piece("OuterLoop5")
TableOfPieces[#TableOfPieces + 1] = OuterLoop5
OuterLoop6 = piece("OuterLoop6")
TableOfPieces[#TableOfPieces + 1] = OuterLoop6
OuterLoop7 = piece("OuterLoop7")
TableOfPieces[#TableOfPieces + 1] = OuterLoop7
OuterLoop8 = piece("OuterLoop8")
TableOfPieces[#TableOfPieces + 1] = OuterLoop8
OuterLoop9 = piece("OuterLoop9")
TableOfPieces[#TableOfPieces + 1] = OuterLoop9
CatapultRoto1 = piece("CatapultRoto1")
TableOfPieces[#TableOfPieces + 1] = CatapultRoto1
CataLow1 = piece("CataLow1")
TableOfPieces[#TableOfPieces + 1] = CataLow1
CataUp1 = piece("CataUp1")
TableOfPieces[#TableOfPieces + 1] = CataUp1
CataHead1 = piece("CataHead1")
TableOfPieces[#TableOfPieces + 1] = CataHead1
CatapultRoto2 = piece("CatapultRoto2")
TableOfPieces[#TableOfPieces + 1] = CatapultRoto2
CataLow2 = piece("CataLow2")
TableOfPieces[#TableOfPieces + 1] = CataLow2
CataUp2 = piece("CataUp2")
TableOfPieces[#TableOfPieces + 1] = CataUp2
CataHead2 = piece("CataHead2")
TableOfPieces[#TableOfPieces + 1] = CataHead2
InLoopCenter = piece("InnerLoopC")
TableOfPieces[#TableOfPieces + 1] = InLoopCenter
flare02 = piece "flare02"


TablesOfPiecesGroups = {} --=makePiecesTablesByNameGroups(false,true)
UpTable = {}
SeedTable = {}
genSignal = 1
function SigGen()
    genSignal = 2 * genSignal
    return genSignal
end

for i = 1, 12, 1 do
    val = i + 12
    name = "OuterLoop" .. (val)
    piecenumber = piece(name)
    UpTable[#UpTable + 1] = piecenumber
end
for i = 1, 10 do
    name = "Seed" .. (i)
    piecenumber = piece(name)
    SeedTable[i] = piecenumber
end
Feed = {}
OuterLoopTable = {}

Mag = {}
Ring = {}
InnerLoop = {}
GunTable = {}
DronePodTable = {}

--Constants
feed_speed = 53
GateDeg = -15
LengthFeed = 53
FeedTime = 1.1666666666666
InnerLoopRadius = 82
boolActivateTravelling = false

function script.HitByWeapon(x, z, weaponDefID, damage)
    return damage
end

function gunFloater()
    Sleep(1000)
    while true do
        for i = 1, #GunTable do
            Move(GunTable[i], y_axis, math.random(0, 12), 1)
        end
        WaitForMoves(GunTable)
        Sleep(3000)
    end
end

function createProcess()
  Hide(flare02)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
    Feed = TablesOfPiecesGroups["Feed"]
    hideT(SeedTable)
    OuterLoopTable = TablesOfPiecesGroups["OuterLoop"]
    Mag = TablesOfPiecesGroups["Mag"]
    Ring = TablesOfPiecesGroups["Ring"]
    InnerLoop = TablesOfPiecesGroups["InnerLoop"]
    GunTable = TablesOfPiecesGroups["Gun"]
    CataRoto = TablesOfPiecesGroups["CatapultRoto"]
    CataLow = TablesOfPiecesGroups["CataLow"]
    CataUp = TablesOfPiecesGroups["CataUp"]
    CataHead = TablesOfPiecesGroups["CataHead"]
    DronePodTable = TablesOfPiecesGroups["DronePod"]


    makeWeaponsTable()
    for i = 1, #Mag do
        Sign = i % 2
        if Sign == 0 then Sign = -1 end
        Spin(Mag[i], z_axis, math.rad(42 * Sign), 0)
    end
    x, y, z = Spring.GetUnitPiecePosDir(unitID, RingB)

    hideT(TableOfPieces)
    StartThread(deployOnceComplete)
    StartThread(waitForTheWatcher)
    StartThread(turretReseter)
    StartThread(gunFloater)
end

function script.Create()
  
    StartThread(createProcess)
end

function deployOnceComplete()
	hp, mHp, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
	while not buildProgress and hp ~= mHp do
	hp, mHp, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
	Sleep(500)
	end
    hp, mHp, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
    while buildProgress and buildProgress < 0 do
        echo(buildProgress)
        hp, mHp, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
        Sleep(1000)
    end

    unfoldAnimation()
end

function script.Killed(recentDamage, _)
    return 1
end

DeTa = {}
DeTa[DronePod1] = { x = 0, y = 0, z = 3.4 }
DeTa[DronePod2] = { x = 0, y = 0, z = -3.4 }
DeTa[DronePod3] = { x = 0, y = 0, z = 3.4 }
DeTa[DronePod4] = { x = 4.3, y = 0, z = 0 }
DeTa[DronePod5] = { x = -4.3, y = 0, z = 0 }

DeTa[Erker1] = { x = 0, y = 0, z = -5.3 }
DeTa[Erker2] = { x = -5.3, y = 0, z = 0 }
DeTa[Erker3] = { x = -5.3, y = 0, z = 0 }
DeTa[Erker4] = { x = 0, y = 0, z = -5.3 }
DeTa[Erker5] = { x = -5.3, y = 0, z = 0 }
DeTa[Erker6] = { x = 5.3, y = 0, z = 0 }
DeTa[Erker7] = { x = 5.3, y = 0, z = 0 }
DeTa[Erker8] = { x = -5.3, y = 0, z = 0 }
DeTa[Erker9] = { x = -5.3, y = 0, z = 0 }
DeTa[Erker10] = { x = 5.3, y = 0, z = 0 }
DeTa[Erker11] = { x = 0, y = 0, z = 5.3 }

un_foldDepotspeed = 4.25
function un_foldDepots(boolUnfold, speed)
    lastPieceName = ""
    if boolUnfold == true then
        un_foldDepots(false, 0)
        for piecename, tab in pairs(DeTa) do
            mP(piecename, 0, 0, 0, speed)
            lastPieceName = piecename
            Show(piecename)
        end
        WaitForMove(lastPieceName, x_axis)
        WaitForMove(lastPieceName, y_axis)
        WaitForMove(lastPieceName, z_axis)
    else

        for piecename, tab in pairs(DeTa) do
            mP(piecename, tab.x * -1, tab.y, tab.z, speed)
            lastPieceName = piecename
        end
        WaitForMove(lastPieceName, x_axis)
        WaitForMove(lastPieceName, y_axis)
        WaitForMove(lastPieceName, z_axis)
        for piecename, tab in pairs(DeTa) do
            Hide(piecename)
        end
    end
end

function AnimTest()
    while true do
        --unfoldAnimation()

        while true do
            Sleep(1000)
            echo("FirstTrainDeploy")
            StartThread(InnerCircleLoop, true)
            Sleep(10000)
            SignalTable["InnerCircleLoop"] = false
            Sleep(500)
            echo("FirstTrainDeploy")
            StartThread(InnerCircleLoop, false)
            Sleep(10000)
            SignalTable["InnerCircleLoop"] = false
            Sleep(500)
        end
        --foldAnimation()
        Sleep(1000)
    end
end


SignalTable = {}

function stopSoundInOrder(tables)
    for k, v in pairs(tables) do
        if v.boolOnce == false then
            GG.soundInOrderTable["cgatefort" .. unitID].signal = false
        end
    end
end

soundInOrderTableUnfold = {}
soundInOrderTableUnfold[1] = { boolOnce = true, postdelay = 0, predelay = 3000, sound = "sounds/cgatefortress/GateOPen.ogg" }
soundInOrderTableUnfold[2] = { boolOnce = false, postdelay = 2500, sound = { [1] = "sounds/cgatefortress/GateLoop1.ogg", [2] = "sounds/cgatefortress/GateLoop.ogg", [3] = "sounds/cgatefortress/GateLoop2.ogg" } }
soundInOrderTableUnfold[3] = { boolOnce = false, postdelay = 2500, sound = { [1] = "sounds/cgatefortress/GateOnly1.ogg", [2] = "sounds/cgatefortress/GateOnly2.ogg" } }

if not GG.soundInOrderTable then GG.soundInOrderTable = {} end
if not GG.soundInOrderTable["cgatefort" .. unitID] then GG.soundInOrderTable["cgatefort" .. unitID] = { signal = true } end

SIG_SOUNDINORDER = SigGen()

function playSoundChain(soundInOrderTableUnfold, name)
    SetSignalMask(SIG_SOUNDINORDER)
    playSoundInOrder(soundInOrderTableUnfold, name)
end

function unfoldAnimation()

    resetT(TableOfPieces)
    hideT(TableOfPieces)
    --randoVal=iRand(-360,360)
    --Turn(center,y_axis,math.rad(randoVal),0)
    Sleep(10)
    StartThread(playSoundChain, soundInOrderTableUnfold, "cgatefort" .. unitID)
    spawnCegAtPiece(unitID, GatePoint, "dirt", 10)
    GateDeploy(true)
    StartThread(GateLoop, true)

    FirstTrainDeploy(true)
    StartThread(TrainLoop, true)

    InnerCircleDeploy(true)

    StartThread(InnerCircleLoop, true)

    OuterCircleDeploy(true)

    StartThread(GoUp, true, 2 * math.pi * 0.1 * (1 / 1.1666))
    StartThread(OuterCircleLoop, true)


    UpperCircleDeploy(true)

    StartThread(UpperCircleLoop, true, 4)

    Spring.PlaySoundFile("sounds/cgatefortress/gateFortOut.wav", 1.0)
    TowerDeploy(true)

    DeployInOrder(true)



    InnerCityDeploy(true)
    un_foldRailGun(true)
    un_foldDepots(true, un_foldDepotspeed)

    stopSoundInOrder(soundInOrderTableUnfold)
    Signal(SIG_SOUNDINORDER)
    boolDeployed = true
    for k, v in pairs(SignalTable) do
        SignalTable[k] = false
    end
    StartThread(timeDelayWeapon1)
end

bFold = false
function foldAnimation()
    Sleep(10)
    un_foldDepots(bFold, un_foldDepotspeed)
    StartThread(TrainLoop, bFold)
    StartThread(InnerCircleLoop, bFold)
    StartThread(playSoundChain, soundInOrderTableUnfold, "cgatefort" .. unitID)
    StartThread(GateLoop, bFold)
    boolDeployed = false
    Spring.PlaySoundFile("sounds/cgatefortress/gateFortIn.wav", 1.0)


    un_foldRailGun(bFold)
    InnerCityDeploy(bFold)
    DeployInOrder(bFold)
    TowerDeploy(bFold)
    StartThread(OuterCircleLoop, bFold)
    StartThread(GoUp, bFold, 2 * math.pi * 0.1 * (1 / 1.1666))
    UpperCircleDeploy(bFold)

    OuterCircleDeploy(bFold)
    SignalTable["OuterCircleLoop"] = false
    SignalTable["GoUp"] = false
    SignalTable["InnerCircleLoop"] = false

    InnerCircleDeploy(bFold)
    FirstTrainDeploy(bFold)

    Sleep(10)

    GateDeploy(bFold)

    boolOnTheMove = true
    hideT(TableOfPieces)
    resetT(TableOfPieces)
    hideT(TableOfPieces)
    Signal(SIG_SOUNDINORDER)
    stopSoundInOrder(soundInOrderTableUnfold)

    for k, v in pairs(SignalTable) do
        SignalTable[k] = false
    end
end

boolDeployed = false
boolOnTheMove = false
boolOneShot = true
teamid = Spring.GetUnitTeam(unitID)


function GateDeploy(boolUnfold)


    if boolUnfold == true then
        spawnCegAtPiece(unitID, GatePoint, "dirt", 15)
        Sleep(1000)
        spawnCegAtPiece(unitID, GatePoint, "dirt", 10)
        Turn(GatePoint, y_axis, math.rad(GateDeg), 9)
        --Preparation
        Move(center, y_axis, 2.5, 0)
        Move(Ring0, y_axis, -15, 0)
        Turn(Ring0, y_axis, math.rad(-90), 0)
        ShowKill(Ring0)
        Show(RingB)
        Turn(Ring0, y_axis, math.rad(0), 1.2)
        moveExpPiece(Ring0, y_axis, 15, -15, 5, 750, 15, false)
        Move(Ring0, y_axis, 0, 35)
        WaitForMove(Ring0, y_axis)
        spawnCegAtPiece(unitID, Ring0, "dirt", 0)
        Turn(Ring3, x_axis, math.rad(180 + 46), 0)
        Turn(Ring2, x_axis, math.rad(180 + 2 * 46), 0)
        Turn(Ring1, x_axis, math.rad(180 + 3 * 46), 0)
        WaitForTurn(Ring3, x_axis)
        WaitForTurn(Ring2, x_axis)
        WaitForTurn(Ring1, x_axis)
        Turn(Ring1, x_axis, math.rad(0), 10)
        Show(Ring1)
        WaitForTurn(Ring1, x_axis)
        Turn(Ring2, x_axis, math.rad(0), 10)
        Show(Ring2)
        WaitForTurn(Ring2, x_axis)
        Turn(Ring3, x_axis, math.rad(0), 10)
        Show(Ring3)
        WaitForTurn(Ring3, x_axis)
        spawnCegAtPiece(unitID, GatePortal, "cgateopen", 0)
        Show(GatePortal)
        Spin(GatePortal, x_axis, math.rad(42), 0)

    else

        Turn(GatePoint, y_axis, math.rad(GateDeg), 9)
        --Preparation


        Hide(GatePortal)

        Show(Ring3)
        WaitForTurn(Ring3, x_axis)
        Turn(Ring3, x_axis, math.rad(0), 10)
        WaitForTurn(Ring2, x_axis)
        Show(Ring2)
        Turn(Ring2, x_axis, math.rad(0), 10)
        WaitForTurn(Ring1, x_axis)
        Show(Ring1)
        Turn(Ring1, x_axis, math.rad(0), 10)
        WaitForTurns(Ring1, Ring2, Ring3)
        Turn(Ring3, x_axis, math.rad(180 + 46), 0)
        Turn(Ring2, x_axis, math.rad(180 + 2 * 46), 0)
        Turn(Ring1, x_axis, math.rad(180 + 3 * 46), 0)
        Move(Ring0, y_axis, 0, 35)
        WaitForMove(Ring0, y_axis)
        moveExpPiece(Ring0, y_axis, 15, -15, 5, 750, 15, false)
        Turn(Ring0, y_axis, math.rad(0), 1.2)
        Show(RingB)
        ShowKill(Ring0)
        spawnCegAtPiece(unitID, GatePortal, "cgateopen", offset)
        Hide(GatePortal)
        Turn(Ring0, y_axis, math.rad(-90), 0)
        Move(center, y_axis, 2.5, 0)
        Move(Ring0, y_axis, -15, 0)
    end
end

function GateLoop(boolUnfold)
    AlterRate = 0
    SignalTable["GateLoop"] = true
    if boolUnfold == true then
        while SignalTable["GateLoop"] == true do
            AlterRate = AlterRate + 1
            Spin(GateWave, x_axis, math.rad(42), 0)
            Spin(WaveA, x_axis, math.rad(42), 0)
            Show(GateWave)
            Show(WaveA)
            speed = math.random(1.5, 4)
            if raNil() then
                if AlterRate % 2 == 1 then
                    Move(GateWave, x_axis, -5.5, speed)
                end

                if AlterRate % 2 == 0 then
                    Move(WaveA, x_axis, -3.14, speed)
                end
            end

            WaitForMove(WaveA, x_axis)
            WaitForMove(GateWave, x_axis)
            Move(WaveA, x_axis, 0, speed)
            Move(GateWave, x_axis, 0, speed)
            WaitForMove(WaveA, x_axis)
            WaitForMove(GateWave, x_axis)


            Sleep(10)
        end

    else
    end
    --HoldPosition
end

function FirstTrainDeploy(boolUnfold)
    boolDirection = false
    if boolReverse then boolDirection = boolReverse end
    --if the animation should be aborted, we revert it


    if boolUnfold == true then

        WMove(Feed10, x_axis, 0, 0)
        count_up = 0

        for i = 0, -LengthFeed, -4.8 do
            WMove(Feed10, x_axis, i, feed_speed)
            if Feed[count_up] then
                ShowKill(Feed[count_up])
            end
            count_up = math.min(count_up + 1, 9)
        end

        Show(Feed10)
        hideT(Feed)
    else
        WMove(Feed10, x_axis, -LengthFeed, 0)
        count_dow = 10
        showT(Feed)
        for i = -1 * LengthFeed, 0, 4.8 do
            WMove(Feed10, x_axis, i, feed_speed)
            if Feed[count_dow] then
                Hide(Feed[count_dow])
            end
            count_dow = math.max(count_dow - 1, 1)
        end

        Show(Feed10)
        hideT(Feed)
    end
end

function TrainLoop(boolUnfold)
    SignalTable["TrainLoop"] = true

    while SignalTable["TrainLoop"] == true do
        if boolUnfold == true then
            WMove(Feed10, x_axis, 0, 0)
            count_up = 0

            for i = 0, -LengthFeed, -4.8 do
                WMove(Feed10, x_axis, i, feed_speed)
                if Feed[count_up] then
                    Show(Feed[count_up])
                end
                count_up = math.min(count_up + 1, 9)
            end
            Show(Feed10)
            WMove(Feed10, x_axis, -LengthFeed, feed_speed)
            hideT(Feed)
        else -- fold
            WMove(Feed10, x_axis, -LengthFeed, 0)
            count_down = 10
            showT(Feed)
            for i = -LengthFeed, 0, 4.8 do
                WMove(Feed10, x_axis, i, feed_speed)
                if Feed[count_down] then
                    Hide(Feed[count_down])
                end
                count_down = math.max(count_down - 1, 1)
            end
        end
    end
end


innerCircleIterator = 0
function InnerCircleDeploy(boolUnfold)
    --if the animation should be aborted, we revert it
    radialSpeed = 2 * math.pi * 0.1 * (1 / 1.1666)
    hideT(InnerLoop)

    if boolUnfold == true then
        WTurn(InLoopCenter, y_axis, math.rad(-36), 0)
        for inner = 1, 4, 1 do
            ShowKill(InnerLoop[inner])
            WTurn(InLoopCenter, y_axis, math.rad(inner * -36), radialSpeed)
            if InnerLoop[inner - 3] then
                Hide(InnerLoop[inner - 3])
            end
            if inner == 4 then

                return
            end
        end
    else
        showT(InnerLoop, 1, 5)
        WTurn(InLoopCenter, y_axis, math.rad(-36 * 4), 0)

        for inner = 4, 0, -1 do
            Turn(InLoopCenter, y_axis, math.rad(inner * -36), radialSpeed)
            WaitForTurn(InLoopCenter, y_axis)
            if InnerLoop[inner + 1] then
                Hide(InnerLoop[inner + 1])
            end
        end
    end
end

SeedCenter = piece "SeedCenter"
function SeedLoop(nrOfPumps, feed_speed, boolDirection, radialSpeed)

    for k = 1, nrOfPumps, 1 do


        offSet = {}
        offSet.x, offSet.y, offSet.z = 0, 0, 0
        WMove(SeedTable[10], x_axis, 0, 0)
        if boolDirection == true then
            seed_count_up = 0
            hideT(SeedTable)
            for seedIndex = 0, -LengthFeed, -4.8 do
                WMove(SeedTable[10], x_axis, seedIndex, feed_speed)
                if SeedTable[seed_count_up] then
                    Show(SeedTable[seed_count_up])
                end
                seed_count_up = math.min(seed_count_up + 1, 10)
            end
            hideT(SeedTable)

        else
            seed_count_up = 10
            WMove(SeedTable[10], x_axis, LengthFeed * 2, 0)
            showT(SeedTable)
            for seedIndex = LengthFeed * 2, LengthFeed * 3, 4.8 do
                WMove(SeedTable[10], x_axis, seedIndex, feed_speed)
                if SeedTable[seed_count_up] then
                    Hide(SeedTable[seed_count_up])
                end
                seed_count_up = math.max(seed_count_up - 1, 1)
            end
            hideT(SeedTable)
        end
    end
end

function InnerCircleLoop(boolUnfold)

    SignalTable["InnerCircleLoop"] = true
    inner = 4
    radialSpeed = 2 * math.pi * 0.10 * (1 / 1.1666)
    if boolUnfold == true then
        hideT(InnerLoop)
        showT(InnerLoop, 1, 4)
    else
        hideT(InnerLoop)
        showT(InnerLoop, 1, 4)
    end
    WTurn(InLoopCenter, y_axis, math.rad(inner * -36), 0)

    while SignalTable["InnerCircleLoop"] == true do

        if boolUnfold == true then

            Show(InnerLoop[inner])
            Turn(InLoopCenter, y_axis, math.rad(inner * -36), radialSpeed)

            WaitForTurn(InLoopCenter, y_axis)
            offSet = ((inner + 6) % 10) + 1

            if InnerLoop[offSet] then
                Hide(InnerLoop[offSet])
            end
            inner = inner % 10 + 1

        else -- fold
            showIndex = inner - 2
            if showIndex < 1 then showIndex = 10 + showIndex end
            Show(InnerLoop[showIndex])
            WTurn(InLoopCenter, y_axis, math.rad(inner * -36), radialSpeed)

            offSetIndex = showIndex - 7
            if offSetIndex < 1 then offSetIndex = 10 + offSetIndex end

            if InnerLoop[offSetIndex] then
                Hide(InnerLoop[offSetIndex])
            end

            inner = (inner - 1) % 10
            if inner == 0 then inner = 10 end
        end
    end
    Hide(InnerLoop[inner])
end

function OuterCircleDeploy(boolUnfold)

    out_radialSpeed = 2 * math.pi * 0.08333333333333333333 * (1 / 1.1666)

    hideT(OuterLoopTable)

    if boolUnfold == true then
        WTurn(BigLCenter, y_axis, math.rad(-5), 0)
        for out = 1, 12, 1 do

            temp = ((out + 1) % 12) + 1
            ShowKill(OuterLoopTable[temp])
            Turn(BigLCenter, y_axis, math.rad(out * -30 + 25), out_radialSpeed)
            WaitForTurn(BigLCenter, y_axis)

            if OuterLoopTable[out - 7] then
                Hide(OuterLoopTable[out - 7])
                return
            end
        end


    else
        WTurn(BigLCenter, y_axis, math.rad(-5), 0)

        for out = 1, 12, 1 do

            temp = ((out + 1) % 12) + 1
            ShowKill(OuterLoopTable[temp])
            Turn(BigLCenter, y_axis, math.rad(out * 30 + 25), out_radialSpeed)
            WaitForTurn(BigLCenter, y_axis)

            if OuterLoopTable[out - 7] then
                Hide(OuterLoopTable[out - 7])
                return
            end
        end
    end
end

UpGoTurn1 = piece "UpGoTurn1"
UpGoTurn2 = piece "UpGoTurn2"

function ShowKill(piecename)
    killAtPiece(unitID, piecename)
    Show(piecename)
end

function OuterCircleLoop(boolUnfold)

    SignalTable["OuterCircleLoop"] = true

    Show(UpGo1)
    Show(UpGo2)


    out_radialSpeed = 2 * math.pi * 0.08333333333333333333 * (1 / 1.1666)

    out = 8
    if boolUnfold == false then
        out = 4
    end

    Show(OuterLoopTable[6])
    Show(OuterLoopTable[7])
    Show(OuterLoopTable[8])
    Show(OuterLoopTable[9])
    Show(OuterLoopTable[10])
    Turn(BigLCenter, y_axis, math.rad(-215), 0, true)
    WaitForTurn(BigLCenter, y_axis)

    while SignalTable["OuterCircleLoop"] == true do
        if boolUnfold == true then
            temp = ((out + 1) % 12) + 1

            Show(OuterLoopTable[temp])
            Turn(BigLCenter, y_axis, math.rad(out * -30 + 25), radialSpeed)

            WaitForTurn(BigLCenter, y_axis)
            offSet = ((out + 5) % 12) + 1

            if SignalTable["OuterCircleLoop"] == false then return end
            Hide(OuterLoopTable[offSet])
            out = out % 12 + 1
        else
            showIndex = (out - 1)
            if showIndex <= 0 then showIndex = 12 end

            Show(OuterLoopTable[showIndex])
            Turn(BigLCenter, y_axis, math.rad(out * 30 + 25), radialSpeed)

            WaitForTurn(BigLCenter, y_axis)
            hideoffSet = math.min(math.max(math.abs(out - 7), 1), 12)
            if SignalTable["OuterCircleLoop"] == false then return end
            Hide(OuterLoopTable[hideoffSet])

            out = (out - 1)
            if out < 1 then out = 12 end
        end
    end
end

function GoUp(boolReverse, radialSpeed)
    boolDirection = false; if boolReverse then boolDirection = boolReverse end

    SignalTable["GoUp"] = true


    offset = 30

    if boolDirection == true then

        while SignalTable["GoUp"] == true do
            Hide(UpGo1)
            Hide(UpGo2)
            Turn(UpGoTurn2, y_axis, math.rad(0 + offset), 0)
            Turn(UpGoTurn1, y_axis, math.rad(30 + offset), 0)

            Turn(UpGo2, x_axis, math.rad(0), 0)
            Turn(UpGo1, x_axis, math.rad(-20), 0)

            WaitForTurn(UpGoTurn1, y_axis)
            WaitForTurn(UpGoTurn2, y_axis)
            WaitForTurn(UpGo2, x_axis)
            WaitForTurn(UpGo1, x_axis)
            Show(UpGo1)
            Show(UpGo2)
            Turn(UpGo2, x_axis, math.rad(-20), 0.35)
            Turn(UpGo1, x_axis, math.rad(0), 0.35)
            Turn(UpGoTurn2, y_axis, math.rad(0), radialSpeed)
            Turn(UpGoTurn1, y_axis, math.rad(30), radialSpeed)
            WaitForTurn(UpGoTurn1, y_axis)
            WaitForTurn(UpGoTurn2, y_axis)
        end

    else
        while SignalTable["GoUp"] == true do
            Hide(UpGo1)
            Hide(UpGo2)

            Turn(UpGo2, x_axis, math.rad(-20), 0)
            Turn(UpGo1, x_axis, math.rad(0), 0)
            Turn(UpGoTurn2, y_axis, math.rad(0), 0)
            Turn(UpGoTurn1, y_axis, math.rad(30), 0)
            WaitForTurn(UpGoTurn1, y_axis)
            WaitForTurn(UpGoTurn2, y_axis)
            Show(UpGo1)
            Show(UpGo2)
            Turn(UpGo2, x_axis, math.rad(0), 0.35)
            Turn(UpGo1, x_axis, math.rad(-20), 0.35)
            Turn(UpGoTurn2, y_axis, math.rad(0 + offset), radialSpeed)
            Turn(UpGoTurn1, y_axis, math.rad(30 + offset), radialSpeed)

            WaitForTurn(UpGoTurn1, y_axis)
            WaitForTurn(UpGoTurn2, y_axis)
            WaitForTurn(UpGo2, x_axis)
            WaitForTurn(UpGo1, x_axis)
        end
    end
end

function UpperCircleDeploy(boolUnfold)

    --12
    out_radialSpeed = 2 * math.pi * 0.08333333333333333333 * (1 / 1.1666)


    if boolUnfold == true then
        Turn(BigLUpCenter, y_axis, math.rad(60), 0)
        WaitForTurn(BigLUpCenter, y_axis)
        for upcircdepindex = 0, 12, 1 do

            temp = ((upcircdepindex) % 12) + 1

            if UpTable[upcircdepindex] then Show(UpTable[upcircdepindex]) end

            Turn(BigLUpCenter, y_axis, math.rad(upcircdepindex * -30 + 30), out_radialSpeed)
            WaitForTurn(BigLUpCenter, y_axis)

            if UpTable[upcircdepindex - 9] then
                Hide(UpTable[upcircdepindex - 9])
            end
        end
    else
        WTurn(BigLUpCenter, y_axis, math.rad(11 * -30), out_radialSpeed)
        for upcircdepindex = 12, 1, -1 do

            temp = ((upcircdepindex) % 12) - 1
            if temp < 1 then temp = 12 end

            if UpTable[upcircdepindex] then Hide(UpTable[upcircdepindex]) end

            Turn(BigLUpCenter, y_axis, math.rad(upcircdepindex * -30 + 30), out_radialSpeed)
            WaitForTurn(BigLUpCenter, y_axis)
        end
    end
end

UpGoTurn1 = piece "UpGoTurn1"
UpGoTurn2 = piece "UpGoTurn2"

function UpperCircleLoop(boolUnfold, totalLength)
    boolDirection = false; if boolReverse then boolDirection = boolReverse end
    SignalTable["UpperCircleLoop"] = true

    upperCircOutIndex = 10
    Counter = 0
    Turn(BigLUpCenter, y_axis, math.rad(-270), 0, true)
    WaitForTurn(BigLUpCenter, y_axis)

    if boolUnfold == false then
        Turn(BigLUpCenter, y_axis, math.rad(0), 0)
        resetT(UpTable)
        showT(UpTable)
        Show(OuterLoop14)
        WMove(Wall, y_axis, -7, math.pi)
        Hide(Wall)
    end

    while SignalTable["UpperCircleLoop"] == true do

        if boolUnfold == true then
            temp = ((upperCircOutIndex) % 12) + 1


            Turn(BigLUpCenter, y_axis, math.rad(upperCircOutIndex * -30), radialSpeed)
            WaitForTurn(BigLUpCenter, y_axis)
            if UpTable[temp] then Show(UpTable[temp]) end
            upperloopoffSet = upperCircOutIndex - 6
            if upperloopoffSet < 1 then upperloopoffSet = upperloopoffSet + 12 end

            if UpTable[upperloopoffSet] then Hide(UpTable[upperloopoffSet]) end

            upperCircOutIndex = upperCircOutIndex % 12 + 1
        else
            Turn(BigLUpCenter, y_axis, math.rad(upperCircOutIndex * 30), radialSpeed)
            WaitForTurn(BigLUpCenter, y_axis)
            if UpTable[temp] then Show(UpTable[temp]) end
            upperloopoffSet = upperCircOutIndex - 6
            if upperloopoffSet < 1 then upperloopoffSet = upperloopoffSet + 12 end

            if UpTable[upperloopoffSet] then Hide(UpTable[upperloopoffSet]) end

            upperCircOutIndex = upperCircOutIndex % 12 + 1
        end
        if boolUnfold == true then
            Counter = Counter + 1
            if Counter == totalLength then
                Turn(BigLUpCenter, y_axis, math.rad(0), 0)
                resetT(UpTable)
                showT(UpTable)
                Hide(OuterLoop14)
                Move(Wall, y_axis, -7, 0); Show(Wall); Move(Wall, y_axis, 0, 3.1415)
            end
        end
    end

    --clean up
    if boolUnfold == true then
        Turn(BigLUpCenter, y_axis, math.rad(0), 0)
        resetT(UpTable)
        showT(UpTable)
        Hide(OuterLoop14)
        Move(Wall, y_axis, -7, 0); Show(Wall); Move(Wall, y_axis, 0, 3.1415)
    else
        Turn(BigLUpCenter, y_axis, math.rad(0), 0)
        resetT(UpTable)
        hideT(UpTable)
        Hide(OuterLoop14)
        WMove(Wall, y_axis, -7, 3.1415); Hide(Wall);
    end
end

SecondTowerCenter = OuterLoop30
TowerCenter = NGon085
STowerTable = {}
TowerTable = {}
TowerTable[1] = { NGon090, NGon089, NGon086, Gun3, Mag5, Mag6 }
TowerTable[2] = { NGon085, NGon086, NGon087 }
STowerTable[1] = { OuterLoop31 }
STowerTable[2] = { OuterLoop30 }

function TowerDeploy(boolUnfold)
    if boolUnfold == true then -- up

        DeployInOrderTower(true)
        SignalTable["UpperCircleLoop"] = false
        SignalTable["GoUp"] = false
        SignalTable["OuterCircleLoop"] = false
    else
        DeployInOrderTower(false)
        SignalTable["UpperCircleLoop"] = false
        SignalTable["GoUp"] = false
        SignalTable["OuterCircleLoop"] = false
    end
end

Seed10 = piece "Seed10"
towerDeployTable = {
    [1] = { pieceA = NGon085, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = { NGon086, NGon087 }, SeedDir = { x = 0, y = 180, z = -90 } },
    [2] = { pieceA = NGon090, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = { NGon088, NGon089, Gun3, Mag5, Mag6 }, SeedDir = { x = 0, y = 180, z = -90 } },
    [3] = { pieceA = OuterLoop30, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [4] = { pieceA = OuterLoop31, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } }
}

piecesDeployTable = {
    [1] = { pieceA = OuterLoop25, offA = { x = 0, y = 0, z = LengthFeed + 17.5 }, pieceList = {}, SeedDir = { x = 90, y = -90, z = 0 } },
    [2] = { pieceA = OuterLoop29, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = { Gun4, Mag8, Mag7 }, SeedDir = { x = 0, y = 180, z = -90 } },
    [3] = { pieceA = OuterLoop26, offA = { x = -LengthFeed - 17.5, y = 0, z = 0 }, pieceList = {}, SeedDir = { x = 90, y = 180, z = 0 } },
    [4] = { pieceA = OuterLoop28, offA = { x = -2, y = -LengthFeed - 20, z = 0 }, pieceList = { Gun2, Mag4, Mag3 }, SeedDir = { x = 0, y = 180, z = -90 } },
    [5] = { pieceA = OuterLoop56, offA = { x = 0, y = -23, z = -1 * (LengthFeed + 17.5) }, pieceList = {}, SeedDir = { x = -180, y = 90, z = 0 } },
    [6] = { pieceA = OuterLoop27, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = { Gun1, Mag1, Mag2 }, SeedDir = { x = 0, y = 270, z = -90 } },
    [7] = { pieceA = OuterLoop33, offA = { x = -LengthFeed - 20.5, y = 0, z = 0 }, pieceList = { InnerOrigin }, SeedDir = { x = 180, y = 180, z = 0 } },
    [8] = { pieceA = OuterLoop32, offA = { x = -LengthFeed - 20.5, y = 0, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = 0 } },
    [9] = { pieceA = OuterLoop42, offA = { x = -LengthFeed - 20.5, y = 0, z = 0 }, pieceList = {}, SeedDir = { x = 180, y = 180, z = 0 } },
    [10] = { pieceA = OuterLoop35, offA = { x = -7, y = 10, z = LengthFeed / 2 + 5 }, pieceList = {}, SeedDir = { x = 90, y = -90, z = 0 } },
    [11] = { pieceA = OuterLoop34, offA = { x = -7, y = 10, z = -LengthFeed - 5 }, pieceList = {}, SeedDir = { x = 90, y = 90, z = 0 } },
    [12] = { pieceA = OuterLoop40, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [13] = { pieceA = OuterLoop41, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [14] = { pieceA = OuterLoop43, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [15] = { pieceA = OuterLoop44, offA = { x = 0, y = -52, z = -52 }, pieceList = {}, SeedDir = { x = 0, y = 90, z = -45 } },
    [16] = { pieceA = OuterLoop47, offA = { x = 0, y = -52, z = -52 }, pieceList = {}, SeedDir = { x = 0, y = 90, z = -45 } },
    [17] = { pieceA = OuterLoop55, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [18] = { pieceA = OuterLoop54, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [19] = { pieceA = OuterLoop50, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [20] = { pieceA = OuterLoop51, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [21] = { pieceA = OuterLoop45, offA = { x = 0, y = -52, z = -52 }, pieceList = {}, SeedDir = { x = 0, y = 90, z = -45 } },
    [22] = { pieceA = OuterLoop46, offA = { x = 0, y = -52, z = -52 }, pieceList = {}, SeedDir = { x = 0, y = 90, z = -45 } },
    [23] = { pieceA = OuterLoop48, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [24] = { pieceA = OuterLoop49, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [25] = { pieceA = OuterLoop53, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [26] = { pieceA = OuterLoop52, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [27] = { pieceA = OuterLoop36, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [28] = { pieceA = OuterLoop37, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [29] = { pieceA = OuterLoop38, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },
    [30] = { pieceA = OuterLoop39, offA = { x = 0, y = -LengthFeed - 23, z = 0 }, pieceList = {}, SeedDir = { x = 0, y = 180, z = -90 } },

    --[1]={pieceA,offA,pieceList,seedDir},
}

function DeployInOrderTower(boolUnfold)

    if boolUnfold == true then
        for i = 1, #GunTable, 1 do
            Turn(GunTable[i], x_axis, math.rad(-90), 0)
        end
        pieceToGo = 0
        for i = 1, #towerDeployTable, 1 do
            pieceToGo = towerDeployTable[i].pieceA

            offSet = towerDeployTable[i].offA
            DirVec = towerDeployTable[i].SeedDir
            reset(SeedCenter, 0)
            movePieceToPiece(unitID, SeedCenter, pieceToGo, 0, offSet, forceUpdate)

            Turn(SeedCenter, x_axis, math.rad(DirVec.x), 0)
            Turn(SeedCenter, y_axis, math.rad(DirVec.y), 0)
            Turn(SeedCenter, z_axis, math.rad(DirVec.z), 0)

            SeedLoop(1, feed_speed, true, radialSpeed)

            Show(pieceToGo)
            if towerDeployTable[i].pieceList then showT(towerDeployTable[i].pieceList) end
        end
        Sleep(100)
    else --fold
        echo("Folding Tower")
        for i = #towerDeployTable, 1, -1 do
            vector = { x = 0, y = 0, z = 0 }
            pieceToGo = towerDeployTable[i].pieceA
            Hide(pieceToGo)
            vector.x, vector.y, vector.z = towerDeployTable[i].offA.x, towerDeployTable[i].offA.y, towerDeployTable[i].offA.z
            vector.y = vector.y + LengthFeed * 3
            DirVec = towerDeployTable[i].SeedDir
            reset(SeedCenter, 0)

            movePieceToPiece(unitID, SeedCenter, pieceToGo, 0, vector, forceUpdate)

            Turn(SeedCenter, x_axis, math.rad(DirVec.x), 0)
            Turn(SeedCenter, y_axis, math.rad(DirVec.y), 0)
            Turn(SeedCenter, z_axis, math.rad(DirVec.z), 0)

            SeedLoop(1, feed_speed, false, radialSpeed)
            if towerDeployTable[i].pieceList then hideT(towerDeployTable[i].pieceList) end
        end
    end
end

function DeployInOrder(boolUnfold)
    if boolUnfold == true then
        for i = 1, #GunTable, 1 do
            Turn(GunTable[i], x_axis, math.rad(-90), 0)
        end


        pieceToGo = 0
        for i = 1, #piecesDeployTable, 1 do

            pieceToGo = piecesDeployTable[i].pieceA

            offSet = piecesDeployTable[i].offA
            DirVec = piecesDeployTable[i].SeedDir
            reset(SeedCenter, 0)
            movePieceToPiece(unitID, SeedCenter, pieceToGo, 0, offSet, forceUpdate)

            Turn(SeedCenter, x_axis, math.rad(DirVec.x), 0)
            Turn(SeedCenter, y_axis, math.rad(DirVec.y), 0)
            Turn(SeedCenter, z_axis, math.rad(DirVec.z), 0)
            SeedLoop(1, feed_speed, boolUnfold, radialSpeed)


            Show(pieceToGo)
            if piecesDeployTable[i].pieceList then showT(piecesDeployTable[i].pieceList) end
        end
        Sleep(100)
    else -- fold
        for i = #piecesDeployTable, 1, -1 do
            pieceToGo = piecesDeployTable[i].pieceA

            Hide(pieceToGo)
            offSet = piecesDeployTable[i].offA
            offSet = mulVector(offSet, -1)
            DirVec = piecesDeployTable[i].SeedDir
            reset(SeedCenter, 0)
            movePieceToPiece(unitID, SeedCenter, pieceToGo, 0, offSet, forceUpdate)

            Turn(SeedCenter, x_axis, math.rad(DirVec.x), 0)
            Turn(SeedCenter, y_axis, math.rad(DirVec.y), 0)
            Turn(SeedCenter, z_axis, math.rad(DirVec.z), 0)

            SeedLoop(1, feed_speed, false, radialSpeed)


            if piecesDeployTable[i].pieceList then hideT(piecesDeployTable[i].pieceList) end
        end
    end
end

CataRoto = {}
CataLow = {}
CataUp = {}
CataHead = {}
function hideCatapult(speedfactor)
    resetT(CataRoto, 19, false, true)
    resetT(CataLow)
    resetT(CataUp)
    resetT(CataHead)

    turnT(CataHead, x_axis, -178, 6 * speedfactor, false, true)
    turnT(CataUp, x_axis, -11, 2 * speedfactor, false, true)
    Sleep(1000)
    showT(CataHead)
    showT(CataUp)
    hideT(CataLow)
    turnT(CataHead, x_axis, -269, 6 * speedfactor, false, true)
    turnT(CataLow, x_axis, -179, 6 * speedfactor)
    turnT(CataUp, x_axis, 125, 6 * speedfactor, false, true)
    Sleep(1000)
    hideT(CataUp)
    turnT(CataUp, x_axis, 210, 6 * speedfactor, false, true)
    turnT(CataHead, x_axis, -252, 6 * speedfactor, false, true)
    turnT(CataLow, x_axis, -279, 6 * speedfactor)
    Sleep(1000)
    moveT(CataLow, z_axis, -10, 5 * speedfactor, false, true)
end

function unfoldCatapult(speedfactor)
    moveT(CataLow, z_axis, 0, speedfactor * 5, false, true)
    Sleep(1000)
    showT(CataHead)
    showT(CataUp)
    hideT(CataLow)
    turnT(CataHead, x_axis, -269, speedfactor * 6, false, true)
    turnT(CataLow, x_axis, -179, speedfactor * 6)
    turnT(CataUp, x_axis, 125, speedfactor * 6, false, true)
    Sleep(3000)
    showT(CataHead)
    showT(CataUp)
    showT(CataLow)
    resetT(CataLow, speedfactor * 15, false, true)
    resetT(CataUp, speedfactor * 15, false, true)
    resetT(CataHead, speedfactor * 15, false, true)
    Sleep(1000)
    randMoveCatapult()
end

function reloadCataPult()

    hideCatapult(1)
    unfoldCatapult(1)
end

function InnerCityDeploy(boolUnfold)
    if boolUnfold == true then
        hideCatapult(0)
        unfoldCatapult(1)
        for k, v in pairs(SignalTable) do
            if k ~= "GateLoop" then
                SignalTable[k] = false
            end
        end
        showT(CataLow)

    else
        hideCatapult(1)
    end
end

function un_foldRailGun(boolReverse)
    if boolReverse == true then
        WMove(RailGun, y_axis, -110 - 18, 0)
        Show(RailGun)
        WMove(RailGun, y_axis, 0, feed_speed)
        Show(Projectile)
    else
        WMove(RailGun, y_axis, -110 - 18, 0)
        Hide(RailGun)
    end
end


function watchForImpact()
    while not GG.FiringGateFotressTable or not GG.FiringGateFotressTable[teamid] do
        Sleep(500)
    end
    while GG.FiringGateFotressTable[teamid][unitID] == true do
        Sleep(250)
    end
    boolOnTheMove = true
    foldAnimation()
    Spring.DestroyUnit(unitID, true, false)
end

function script.Activate()
    Move(RailGun, y_axis, 0, 45)
    boolActivateTravelling = true
    return 1
end

function script.Deactivate()
    Move(RailGun, y_axis, -110 - 18, 75)
    boolActivateTravelling = false
    return 0
end

turretSpeed = 3.141
boolFireRailGun = true
function waitForTheWatcher()
    while boolFireRailGun == true do
        Sleep(100)
    end
    watchForImpact()
end

function Weapon1fire()


    boolOneShot = false
    if not GG.FiringGateFotressTable then GG.FiringGateFotressTable = {} end
    if not GG.FiringGateFotressTable[teamid] then GG.FiringGateFotressTable[teamid] = {} end
    GG.FiringGateFotressTable[teamid][unitID] = true
    WMove(RailGun, y_axis, -110 - 18, 75)
    boolFireRailGun = false

    return true
end

boolUnfoldComplete = false
boolTimeDelayed = false

function timeDelayWeapon1()
    for i = 1, 3 do
        for k = 1, 60 do
            Sleep(1000)
        end
    end
    echo("Gatefortress: RailGun: Ready")
    boolTimeDelayed = true
end

function Weapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy
    gunKey, isUserTarget, val = Spring.GetUnitWeaponTarget(unitID, 1)
    px, py, pz = 0, 0, 0
    if gunKey == 1 and isUserTarget == true then px, py, pz = Spring.GetUnitPosition(val)
        return boolOneShot == true and boolDeployed == true and boolTimeDelayed == true and boolActivateTravelling == true
    end

    if gunKey == 2 and isUserTarget == true then
        px, py, pz = val[1], val[2], val[3]
        return boolOneShot == true and boolDeployed == true and boolTimeDelayed == true and boolActivateTravelling == true
    end
end



function script.FireWeapon(weaponID)
    --Spring.Echo("FireWeapon")
    if WeaponsTable[weaponID].coolDownTimer then WeaponsTable[weaponID].coolDownTimer = 9000 end

    if WeaponsTable[weaponID] and WeaponsTable[weaponID].firefunc then
        WeaponsTable[weaponID].firefunc()
    end
    return true
end

function genAim(weaponID, heading, pitch)
    Signal(WeaponsTable[weaponID].signal)
    SetSignalMask(WeaponsTable[weaponID].signal)
    WTurn(WeaponsTable[weaponID].aimpiece, y_axis, heading, turretSpeed)
    WTurn(WeaponsTable[weaponID].aimpiece, x_axis, -pitch, turretSpeed)
    return boolDeployed == true
end

catapult1Heading = math.huge
function CataAim1(weaponID, heading, pitch)

    Signal(WeaponsTable[weaponID].signal)
    SetSignalMask(WeaponsTable[weaponID].signal)
    heading = heading + math.rad(-5)
    WTurn(CataRoto[1], y_axis, heading, 2)
    --WTurn(WeaponsTable[weaponID].aimpiece,x_axis,-pitch,3)

    return boolDeployed == true
end

function CataAim2(weaponID, heading, pitch)

    Signal(WeaponsTable[weaponID].signal)
    SetSignalMask(WeaponsTable[weaponID].signal)
    heading = heading + math.rad(5)

    WTurn(CataRoto[2], y_axis, heading, 2)
    --WTurn(WeaponsTable[weaponID].aimpiece,x_axis,-pitch,3)

    return boolDeployed == true
end

function genFire(WeaponID)

    return true
end


function randMoveCatapult()
    Turn(CataRoto[1], y_axis, math.rad(math.random(-360, 360)), 0.05)
    Turn(CataRoto[2], y_axis, math.rad(math.random(-360, 360)), 0.05)
end

function cataFireFunc()
    StartThread(randMoveCatapult)
    return true
end

WeaponsTable = {}
function makeWeaponsTable()
    WeaponsTable[1] = { aimpiece = flare02, emitpiece = flare02, aimfunc = Weapon1, firefunc = Weapon1fire, signal = SigGen() }
    WeaponsTable[2] = { aimpiece = CataHead1, emitpiece = CataHead1, aimfunc = CataAim1, firefunc = cataFireFunc, signal = SigGen() }
    WeaponsTable[3] = { aimpiece = CataHead2, emitpiece = CataHead2, aimfunc = CataAim2, firefunc = cataFireFunc, signal = SigGen() }
    WeaponsTable[4] = { aimpiece = Gun1, emitpiece = Gun1, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[5] = { aimpiece = Gun2, emitpiece = Gun2, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[6] = { aimpiece = Gun3, emitpiece = Gun3, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[7] = { aimpiece = Gun4, emitpiece = Gun4, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[8] = { aimpiece = DronePodTable[1], emitpiece = DronePodTable[1], aimfunc = function() return true end, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[9] = { aimpiece = DronePodTable[2], emitpiece = DronePodTable[2], aimfunc = function() return true end, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[10] = { aimpiece = DronePodTable[3], emitpiece = DronePodTable[3], aimfunc = function() return true end, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
    WeaponsTable[11] = { aimpiece = DronePodTable[4], emitpiece = DronePodTable[4], aimfunc = function() return true end, firefunc = genFire, signal = SigGen(), coolDownTimer = 0 }
end


function turretReseter()
    while true do
        Sleep(1000)
        for i = 4, 7 do
            if WeaponsTable[i].coolDownTimer > 0 then
                WeaponsTable[i].coolDownTimer = math.max(WeaponsTable[i].coolDownTimer - 1000, 0)

            elseif WeaponsTable[i].coolDownTimer <= 0 then
                tP(WeaponsTable[i].emitpiece, -90, 0, 0, 0)
                WeaponsTable[i].coolDownTimer = -1
            end
        end
    end
end

function script.AimFromWeapon(weaponID)
    if WeaponsTable[weaponID] then
        return WeaponsTable[weaponID].aimpiece
    else
        return Gun1
    end
end

function script.QueryWeapon(weaponID)
    if WeaponsTable[weaponID] then
        return WeaponsTable[weaponID].emitpiece
    else
        return Gun1
    end
end



function script.AimWeapon(weaponID, heading, pitch)
    if WeaponsTable[weaponID] then
        if WeaponsTable[weaponID].aimfunc then
            return WeaponsTable[weaponID].aimfunc(weaponID, heading, pitch) and boolDeployed == true
        elseif boolDeployed == true then
            WTurn(WeaponsTable[weaponID].aimpiece, y_axis, heading, turretSpeed)
            WTurn(WeaponsTable[weaponID].aimpiece, x_axis, -pitch, turretSpeed)
            return true
        end
    end
    return false
end