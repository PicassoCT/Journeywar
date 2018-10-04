include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}



IntegrationRadius= 125

center = piece "center"

TIME_MAX = 1000 *10
teamID = Spring.GetUnitTeam(unitID)
function instanciate()
	if not GG.HiveMind then GG. HiveMind = {} end
	if not GG.HiveMind[teamID] then GG. HiveMind[teamID] = {teamActive=false} end
	if not GG.HiveMind[teamID][unitID] then GG.HiveMind[teamID][unitID] = { rewindMilliSeconds = 0, boolActive= false} end
end

function script.Create()
	reset(center)

	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	hideT(TablesOfPiecesGroups["body"])
	StartThread(integrateNewMembers)
	StartThread(showState)
	StartThread(sway)
end

function script.Killed(recentDamage, _)
	createCorpseJUnitGeneric(recentDamage)
	return 1
end

function integrateNewMembers()
	instanciate()
	x,y,z= Spring.GetUnitPosition(unitID)
	integrateAbleUnits= getInfantryTypeTable()
	
	while true do
		InCircle= getAllInCircle(x,z, IntegrationRadius)
		px,py,pz= Spring.GetUnitPosition(unitID)
		process(InCircle,
		function(id)
			defID = Spring.GetUnitDefID(id)
			if integrateAbleUnits[defID] and GG.HiveMind[teamID][unitID].rewindMilliSeconds < TIME_MAX then
				GG.HiveMind[teamID][unitID].rewindMilliSeconds = GG.HiveMind[teamID][unitID].rewindMilliSeconds + 100
				Spring.SetUnitPosition(id,px,py,pz)
				Spring.DestroyUnit(id, false, true)
			end
		end
		)
		Sleep(100)
	end
	
end

function sway()
	temple = piece"temple"
	while true do 
		WTurn(temple,x_axis,math.rad(0.325),0.00225)
		Sleep(10)
		WTurn(temple,x_axis,math.rad(-0.325),0.00225)
		Sleep(10)
	end
	
end

heigthPagode=369
maxTurn= 6*90
function showState()
	instanciate()
	while true do
		level = math.ceil(GG.HiveMind[teamID][unitID].rewindMilliSeconds / 1000)/10
		rotary = level * maxTurn
		Turn(center,y_axis,math.rad(rotary),0.35)
		WMove(center, y_axis, level * heigthPagode, 15)
		Sleep(100)
	end
end

SIG_SLOWMO = 2
function slowMo()
	SetSignalMask(SIG_SLOWMO)
	GG.HiveMind[teamID][unitID].boolActive = true
	modulator= 0
	
	x,y,z=Spring.GetUnitPosition(unitID)
	team = Spring.GetUnitTeam(unitID)
	Spring.CreateUnit("gcorpsedecalfactory",x,y,z,0,team)
	
	while GG.HiveMind[teamID][unitID].rewindMilliSeconds > 0 do
		Sleep(100)
		modulator = inc(modulator)
		if modulator % 3 == 0 then 	
			selectbody=TablesOfPiecesGroups["body"][math.random(1,#TablesOfPiecesGroups["body"])]
			Move(selectbody,y_axis,math.random(-150,0),0)
			Move(selectbody,x_axis,math.random(10,35)*randSign(),0)
			Move(selectbody,z_axis,math.random(10,35)*randSign(),0)
		Explode(selectbody,SFX.FALL +SFX.NO_HEATCLOUD + SFX.EXPLODE_ON_HIT) end
		GG.HiveMind[teamID][unitID].rewindMilliSeconds =math.max(0,GG.HiveMind[teamID][unitID].rewindMilliSeconds - 100)
	end
	jw_AddTerrainDeformation(x,z, 44, 0.75)
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
	Signal(SIG_SLOWMO)
	GG.HiveMind[teamID][unitID].boolActive = false
	
	return 0
end