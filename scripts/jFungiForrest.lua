include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_jw.lua"
include "lib_Build.lua"



fungi1 = piece "fungi1"
fungi2 = piece "fungi2"
fungi3 = piece "fungi3"
fungi4 = piece "fungi4"
emitPoint = piece "emitPoint"
center = piece "center"
fungiActiveDelayTime= 15000
DeathRadius= 500

function breathingDeath()
    local lEmitSfx = EmitSfx
    while (true) do
        Move(fungi1, y_axis, 5, 0.3)
        Move(fungi2, y_axis, 5, 0.4)
        Move(fungi3, y_axis, 5, 0.5)


        WaitForMove(fungi1, y_axis)
        for i = 1, 10, 1 do
            lEmitSfx(emitPoint, 1024)
            Sleep(50)
        end

        Move(fungi1, y_axis, 0, 0.55)
        Move(fungi2, y_axis, 0, 0.4)
        Move(fungi3, y_axis, 0, 0.3)
        for i = 1, 14, 1 do
            lEmitSfx(emitPoint, 1024)
            Sleep(75)
        end

        WaitForMove(fungi3, y_axis)
    end
end

fungiImuneTypeTable = getFungiImuneUnitTypeTable(UnitDefNames)
local spGetUnitDefID = Spring.GetUnitDefID

function grabTooKill()

    x, y, z = Spring.GetUnitPosition(unitID)
	T= Spring.GetUnitsInCylinder(x, z, DeathRadius)
    T = process( T,
        function(id)
			
				if id ~= unitID and not fungiImuneTypeTable[Spring.GetUnitDefID(id)] then
					return id
				end
			end)

    return T or {}
end

rotators = {}
swings = {}
for i = 1, 11, 1 do

    rotators[i] = {}
    swings[i] = {}
    tempr = "rot" .. i
    temps = "swing" .. i

    rotators[i] = piece(tempr)
    swings[i] = piece(temps)
end

globalHeightUnit = 0
dowNer = -75

function delayedAppearance(piece, ki)
    times = math.ceil(math.random(5000, 15000))
    Sleep(times)
	sinOffset= math.sin(ki*((2*math.pi)/11))*10
    Move(piece, x_axis, DeathRadius +sinOffset 		, 0)
    x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, piece)
    myHeight = Spring.GetGroundHeight(x, z)
    heightdifference = math.abs(globalHeightUnit - myHeight)
    if myHeight < globalHeightUnit then heightdifference = -heightdifference end


    Show(piece)

    SpeedRand = math.random(0.3, 1)
    Move(piece, y_axis, heightdifference, SpeedRand)
    WaitForMove(piece, y_axis)
    boolNotGrown = false
end

TableOfPieceGroups= 	{}

function init()
	
    x, y, z = Spring.GetUnitPosition(unitID)
    globalHeightUnit = Spring.GetGroundHeight(x, z)
    Move(fungi1, y_axis, -34, 0)
    Move(fungi2, y_axis, -34*(1/0.7), 0)
    Move(fungi3, y_axis, -34*(1/0.6), 0)
    Move(fungi4, y_axis, -34*2, 0)
    Sleep(10)
    Show(fungi1)
    Show(fungi2)
    Show(fungi3)
    Show(fungi4)

    delayTillComplete(unitID)

    RandRot = math.random(-360, 360)
    Turn(center, y_axis, math.rad(RandRot), 0)
    for i = 1, 11, 1 do
        Hide(swings[i])
        Move(swings[i], y_axis, dowNer, 0)
        RandRot = i * (360 / 11)
        Turn(rotators[i], y_axis, math.rad(RandRot), 0)
        StartThread(delayedAppearance, swings[i],i)
    end

    mSyncIn(fungi1, 0, 0,0,fungiActiveDelayTime)
    mSyncIn(fungi2, 0, 0,0,fungiActiveDelayTime)
    mSyncIn(fungi3, 0, 0,0,fungiActiveDelayTime)
    mSyncIn(fungi4, 0, 0,0,fungiActiveDelayTime)
	Sleep(fungiActiveDelayTime)

    StartThread(breathingDeath)
    StartThread(circleOfLife)
end

function circleOfLife()


    tables = {}


    while true do
        Sleep(450)
		 if not GG.Spore then GG.Spore = {} end
		 if not GG.GoldSpore then GG.GoldSpore = {} end
		 
        tables = grabTooKill()
        if tables ~= nil and table.getn(tables) > 0 then
            for i = 1, table.getn(tables), 1 do             
                    valLua = tables[i]
                    GG.GoldSpore[#GG.GoldSpore + 1] =valLua
            end
        end
    end
end

function script.Create()
	TableOfPieceGroups=  getPieceTableByNameGroups(false, true)
    x, y, z = Spring.GetUnitPosition(unitID)
    holsDerGaia = Spring.GetGaiaTeamID()
    Spring.CreateUnit("jfungiforrestdecalfactory", x, y, z, 0, holsDerGaia)
hideT(TableOfPieceGroups["fungi"])
hideT(TableOfPieceGroups["swings"])
    for i = 1, 11, 1 do
        Hide(swings[i])
    end


    StartThread(init)
end

function script.Killed()

    return 0
end