include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}



IntegrationRadius= 150

center = piece "center"
aimpiece = piece "aimpiece"

teamID = Spring.GetUnitTeam(unitID)
function instanciate()
	if not GG.HiveMind then GG. HiveMind = {} end
	if not GG.HiveMind[teamID] then GG. HiveMind[teamID]  = {teamActive=false} end
	if not GG.HiveMind[teamID][unitID] then GG.HiveMind[teamID][unitID] = { rewindMilliSeconds = 0, boolActive= false} end

end
function script.Create()
	instanciate()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
	StartThread(integrateNewMembers)
end

function script.Killed(recentDamage, _)
    createCorpseJUnitGeneric(recentDamage)
    return 1
end

function integrateNewMembers()
	x,y,z= Spring.GetUnitPosition(unitID)
	integrateAbleUnits= getInfantryTypeTable()
	
	while true do
	InCircle= getAllInCircle(x,z, IntegrationRadius)
	process(InCircle,
			function(id)
				defID = Spring.GetUnitDefID(id)
				if integrateAbleUnits[defID] then
					GG.HiveMind[teamID][unitID].rewindMilliSeconds = GG.HiveMind[teamID][unitID].rewindMilliSeconds + 100
					Spring.DestroyUnit(id, true, true)
				end
			end
			)
	Sleep(100)
	end

end


function slowMo()
	GG.HiveMind[teamID][unitID].boolActive = true

	Spring.TodoHiveMindSound
	while GG.HiveMind[teamID][unitID].rewindMilliSeconds > 0 do
	Sleep(100)
	GG.HiveMind[teamID][unitID].rewindMilliSeconds =GG.HiveMind[teamID][unitID].rewindMilliSeconds - 100
	end

	Spring.TODOUptoSpeedSound
	GG.HiveMind[teamID][unitID].boolActive = false

end

function lookForOtherActiveHives()
	boolOneOtherActive=false
	other= nil
	for team, utab in pairs(GG.HiveMind)do
		for unit, utab in pairs(utab) do
			if utab.boolActive == true then
				boolOneOtherActive=true
				other = unit
			end
		end
	end
end

function setActive()
	StartThread(slowMo)
end

function setPassiv()
	GG.HiveMind[teamID][unitID].boolActive = false
end


function script.Activate()
	instanciate()
	if GG.HiveMind[teamID][unitID].rewindMilliSeconds > 0 then
		setActive()
	end
    return 1
end

function script.Deactivate()

    return 0
end

function script.QueryBuildInfo()
    return center
end

Spring.SetUnitNanoPieces(unitID, { center })

