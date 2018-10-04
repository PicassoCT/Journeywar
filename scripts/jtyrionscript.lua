include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"



boolShowTrueColours = false
 teamID = Spring.GetUnitTeam(tID)
function checkYourself()
    while GG.Traitors == nil or GG.Traitors[unitID] == nil do
        Sleep(600)
    end

    local tID = GG.Traitors[unitID]
    local spUnitIsDead = Spring.Spring.GetUnitIsDead
    local spGetUnitPosition = Spring.GetUnitPosition
    local spMoveCtrlSetPosition = Spring.MoveCtrl.SetPosition

    Spring.MoveCtrl.Enable(unitID, true)
    teamID = Spring.GetUnitTeam(tID)
	FactoryHasBuilt={}
    while spUnitIsDead(tID) == false or boolShowTrueColours == false do
        x, y, z = spGetUnitPosition(tID)
        spMoveCtrlSetPosition(tID, x, y + 120, z +2)
        Sleep(100)
		buildID = Spring.GetUnitIsBuilding(tID)
		if buildID then
			FactoryHasBuilt[buildID]= buildID
		end
    end

    if boolShowTrueColours == true and spUnitIsNotDead(tID) == true then
	process(FactoryHasBuilt,
			function(id)
				spawnCegAtUnit(id, "jtyrion", 0, 45, 0)
				Spring.TransferUnit(id, teamID, false)
			end
			)
		
    end
	
	for i=1,10 do 
	spawnCegAtUnit(unitID, "jtyrion", 0, 25, 0)
	Sleep(150)
	end

    Spring.DestroyUnit(unitID, true, true)
end







function script.Create()
    Spring.SetUnitNeutral(unitID, true)
    Spring.SetUnitNoSelect(unitID, false)
    Spring.SetUnitNoDraw(unitID, true)
    Spring.SetUnitNoMinimap(unitID, true)
    Spring.SetUnitBlocking(unitID, false, false, false)
    StartThread(checkYourself)--before you wreck yourself
    StartThread(watcher)--before you wreck yourself
end
spectratorid = nil
function regenerateWatcher()
	if not spectratorid or Spring.GetUnitIsDead(spectratorid)== true then
		x,y,z= Spring.GetUnitPosition(unitID)
		spectratorid=Spring.CreateUnit("spectrator", x,y,z, 0, teamID)
	end
function watcher()
	while true do
	regenerateWatcher()
	for i=1,#FactoryHasBuilt do
		if Spring.GetUnitIsDead(FactoryHasBuilt[i]) )== false then
			MoveUnitToUnit(spectratorid,FactoryHasBuilt[i],0, 3, 120,0)
			Sleep(1)
		end
	end

	Sleep(100)
	end
end



function script.Activate()
	Spring.Echo("Tyrion activated")
    boolShowTrueColours = true
    return 1
end



function script.Killed()
	Spring.DestroyUnit(spectratorid,true,true)
end