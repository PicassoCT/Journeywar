include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_jw.lua"
include "lib_Build.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center = piece "center"


piecesTable = {}
piecesTable[#piecesTable + 1] = {}
piecesTable[#piecesTable] = center
Egg = piece "Egg"
piecesTable[#piecesTable + 1] = {}
piecesTable[#piecesTable] = Egg
Base = piece "Base"
piecesTable[#piecesTable + 1] = {}
piecesTable[#piecesTable] = Base

BUILDPROGRESS = 0.0001
Down = -208
--Hide(Base)
--Hide(Egg)
function script.Create()
    Spring.SetUnitBlocking(unitID, false)
  --  Spring.SetUnitAlwaysVisible(unitID, true)
    hideT(piecesTable)
    StartThread(osLoop)
    StartThread(destroyOnTimeOut)
end

buildingTypes = getJourneyBuildingTypeTable(UnitDefNames)

function identifyUnit()
    searchRange = 75
    x, y, z = Spring.GetUnitPosition(unitID)
    TableTop = {}
    TableTop = Spring.GetUnitsInCylinder(x, z, searchRange)

	for i=1,#TableTop do if TableTop[i]== unitID then table.remove(TableTop,i) end end
    --itterate throught table, searching a familiar building

    if not TableTop or table.getn(TableTop) == 0 then return end

    for i = 1, table.getn(TableTop), 1 do
            hp, maxhp, paDmg, capProg, buildProgress = Spring.GetUnitHealth(TableTop[i])
            if buildProgress then
				defID= Spring.GetUnitDefID(TableTop[i])
                if buildingTypes[defID] then
							
                    return TableTop[i]
					  end
            end
        end

end

function assureUnitExists(id)

    if Spring.ValidUnitID(id) == false or Spring.GetUnitIsDead(id) == true then
        Move(center, y_axis, -200, 30);
        WaitForMove(center, y_axis);
        Spring.DestroyUnit(unitID, false, true)
    end
    return true
end


constBuildID= unitID
constUp = 0
function updateBP(buildID)

    if Spring.GetUnitIsDead(buildID) == false then
        h, mh, pD, cP, bP = Spring.GetUnitHealth(buildID)
        constUp = math.min(constUp, bP)
        if bP then return bP else return 0 end
    end


    return constUp
end

function script.Killed(recentDamage, _)

    if constBuildID and constBuildID ~= unitID and Spring.ValidUnitID(constBuildID) == true then
        Spring.SetUnitAlwaysVisible(constBuildID, true)
    end
    return 1
end

function buildAnimation(buildID)
	Signal(SIG_DESTROY)
	 constBuildID= buildID
    Spring.SetUnitAlwaysVisible(buildID, false)
    StartThread(randomRotate, Egg, y_axis, 0.03, -5, 5)
    StartThread(randomRotate, Egg, x_axis, 0.03, -15, 15)
    StartThread(randomRotate, Egg, z_axis, 0.03, -5, 5)
    Move(center, y_axis, Down, 0, true)
    hideUnit(unitID)
    Show(Egg)
    Show(Base)
    local BUILDPROGRESS = updateBP(buildID)
    signum = -1
    currently = 1

    while assureUnitExists(buildID) == true and BUILDPROGRESS and BUILDPROGRESS < 1 do
		--	Spring.Echo("BUILDPROGRESS:"..BUILDPROGRESS)
        BUILDPROGRESS = updateBP(buildID)
        Sleep(150)

        if BUILDPROGRESS < 0.02 then
            Move(center, y_axis, Down * (1 - BUILDPROGRESS), 22)
        else
            Move(center, y_axis, 0, 122)
        end


        currently = currently * signum
        Up = math.random(0, 5) * currently
        Move(Egg, y_axis, Up, 3.3)
        Move(Base, y_axis, -Up, 0.3)
        StopSpin(Egg, y_axis, 0.1)
        Spin(Egg, y_axis, math.rad(math.random(20 * signum, 30) / 100), 11)
        Spin(Base, y_axis, math.rad(math.random(10 * signum, 20) / 100), 11)

        Sleep(750)
    end
    showUnit(unitID)
    Spring.SetUnitAlwaysVisible(buildID, true)
end

function finalAnimation()
	Move(Base, y_axis, -50, 3)
    Explode(Egg, SFX.SHATTER)
    Explode(Egg, SFX.SHATTER)
    Move(Egg, y_axis, Down, 150, true)
    Sleep(3000)

    WaitForMove(Base, y_axis)
    Hide(Base)

end

SIG_BUILD = 2
timeOutMax = 3 * 60 * 1000 --3minutes
function osLoop()

    buildID = unitID
    timeout = 0
    while not buildID or buildID == unitID and timeout < timeOutMax do
        buildID = identifyUnit()
        Sleep(100)
        timeout = timeout + 100
    end

    if timeout < timeOutMax and buildID then
		--Spring.Echo("Starting BuildAnimation")
        buildAnimation(buildID)
    end
   
    finalAnimation()
    Spring.DestroyUnit(unitID, false, true)
end

MaxTime = 9 * 60 * 1000
SIG_DESTROY= 8
function destroyOnTimeOut()
	SetSignalMask(SIG_DESTROY)
    Sleep(MaxTime)
    Spring.DestroyUnit(unitID, false, true)
end