include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua"

flares = {}
for i = 1, 8, 1 do
    flares[i] = {}
    temp = "flare" .. i
    flares[i] = piece(temp)
end


--unitPieces
local nanoemit = piece "nanoemit"
local condrone = piece "condrone"
local Contornado = piece "Contornado"

local boolOnlyOnce = true
local boolMoving = false
local SIG_ONTHEFLY = 4
local SIG_BUILD = 2
local SIG_LANDED = 8
local SIG_HOVER = 16
local SIG_CHECK = 32
local SIG_WIND = 64

local SIG_MOMENTUM = 128
local SIG_EXAUST = 256
local SIG_TIMER = 512


function script.Activate()
    --activates the secondary weapon

    --	return 1
end

function script.Deactivate()
    --deactivates the secondary weapon


    --return 0
end


idleAnim= piece"idleAnim"
 function landed()
		--	Hide(Contornado)
			Hide(condrone)

	while boolLongStop== true do
		for i=1,#TableOfPieceGroups["Rest"],1 do
			if TableOfPieceGroups["Rest"][i] then
				Show(TableOfPieceGroups["Rest"][i] )
			end
			if TableOfPieceGroups["Rest"][i-1] then
				Hide(TableOfPieceGroups["Rest"][i-1])
			end
		Sleep(200)
		end
		for i=#TableOfPieceGroups["Rest"],1,-1 do
			if TableOfPieceGroups["Rest"][i] then
				Show(TableOfPieceGroups["Rest"][i] )
			end
			if TableOfPieceGroups["Rest"][i+1] then
				Hide(TableOfPieceGroups["Rest"][i+1])
			end
		Sleep(200)
		end
	Sleep(10)
	end
	for i=1,#TableOfPieceGroups["Rest"],1 do
			if TableOfPieceGroups["Rest"][i] then
				Show(TableOfPieceGroups["Rest"][i] )
			end
			if TableOfPieceGroups["Rest"][i-1] then
				Hide(TableOfPieceGroups["Rest"][i-1])
			end
		Sleep(200)
		end

end


local function onTheFly()
end


function unitBuiltCheck()
    --test if unit built is a soldier
    while buildID == nil or buildID == -666 do
        Sleep(150)
        buildID = Spring.GetUnitIsBuilding(unitID)
    end
    local unitDefID = Spring.GetUnitDefID(buildID)

    if unitDefID == UnitDefNames["cit"].id then

        return true

    else

        return false
    end
end

function createCorpseCBuilding(unitID)

    --moveX=unitPosX -birthX
    --moveZ=birthZ-unitPosZ

    Move(condrone, y_axis, 425, 82)
    Sleep(1200)
    Move(condrone, y_axis, 625, 150)
    Sleep(2000)
    Move(condrone, y_axis, 825, 200)
    --Move(condrone,x_axis,moveX,9)
    --Move(condrone,z_axis,moveZ,9)
    --WaitForMove(condrone,x_axis)
    --WaitForMove(condrone,z_axis)
end
boolLongStop= false
function moveStateCheck()
    while (true) do



        if boolMoving == false and boolShortStop == false then
            Sleep(512)
            if boolShortStop == false then
                boolLongStop = true
				end
        end
        if boolLongStop == true then
            landed()
				Show(Contornado)
				Show(condrone)
				hideT(TableOfPieceGroups["Rest"])
        end


        Sleep(500)
    end
end



function script.StartMoving()

    --windGet()

      

	 boolLongStop= false
    boolMoving = true
    boolShortStop = true
end

function script.StopMoving()

    Signal(SIG_TIMER)
    boolMoving = false
    boolShortStop = false
end



local function workInProgress()



    SetSignalMask(SIG_HOVER)
    while (true) do

        actualHealth = Spring.GetUnitHealth(unitID)
        if actualHealth == 1 then
            actualHealth = actualHealth - 1
            Spring.SetUnitNoSelect(unitID, true)
            --makes the Unit go home, to the place it was born- west Virginia
            createCorpseCBuilding(unitID)

            Spring.SetUnitHealth(unitID, actualHealth)
        end
        actualHealth = actualHealth - 1
        Spring.SetUnitHealth(unitID, actualHealth)

        Sleep(250)
        if boolUnitIsSoldier == true then
            boolUnitIsSoldier = false
            StartThread(ropeThread)
            Sleep(10)
        end
    end
    StopSpin(conspin, y_axis, 1)
end
	TableOfPieceGroups= {}
function script.Create()

	 TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	 hideT(TableOfPieceGroups["Rest"])
    Spin(Contornado, z_axis, math.rad(128), 0)

    birthX, birthY, birthZ = Spring.GetUnitPosition(unitID)
    --updateDelete
    for i = 1, 8, 1 do
        Hide(flares[i])
    end

    StartThread(moveStateCheck)
    StartThread(landed)
end

function script.Killed()

    Spring.SetUnitCrashing(unitID, true)
    --needsWreckageFeature
    --fixxed


    Sleep(400)
    return 0
end

-------- BUILDING---------
function script.StopBuilding()
    Signal(SIG_HOVER)


    SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)


    Signal(SIG_HOVER)
    --Signal(SIG_CHECK)
    StartThread(workInProgress)


    SetUnitValue(COB.INBUILDSTANCE, 1)
end

Spring.SetUnitNanoPieces(unitID, { nanoemit })