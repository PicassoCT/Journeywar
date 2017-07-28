include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}



IntegrationRadius= 125

center = piece "Server"

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
	TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
	
	StartThread(integrateNewMembers)
	StartThread(showState)
	
	
	StartThread(configure)
	StartThread(ragDoll)

	
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
				glowDial(GG.HiveMind[teamID][unitID].rewindMilliSeconds/TIME_MAX)
				StartThread(ragDoll)
				GG.HiveMind[teamID][unitID].rewindMilliSeconds = GG.HiveMind[teamID][unitID].rewindMilliSeconds + 100
				Spring.SetUnitPosition(id,px,py,pz)
				Spring.DestroyUnit(id, true, true)
			end
		end
		)
		Sleep(100)
	end
	
end


heigthPagode=120

function showState()
	instanciate()
	while true do
		level = math.ceil(GG.HiveMind[teamID][unitID].rewindMilliSeconds / 1000)/10
		WMove(center, y_axis, level * heigthPagode, 15)
		Sleep(100)
	end
end

boolAlarmOn = false
function blinkAlarm()
	boolAlarmOn = not boolAlarmOn
	if boolAlarmOn == true then
		showT(TablesOfPiecesGroups["lightOn"])
		hideT(TablesOfPiecesGroups["LightOff"])
	else
		hideT(TablesOfPiecesGroups["lightOn"])
		showT(TablesOfPiecesGroups["LightOff"])
		
	end
end

function configure ()
	hideT(TablesOfPiecesGroups["BarOn"])
	showT(TablesOfPiecesGroups["BarOff"])
	hideT(TablesOfPiecesGroups["lightOn"])
	showT(TablesOfPiecesGroups["LightOff"])
end

function ragDoll()
		StartThread(swing,TablesOfPiecesGroups["Head"],x_axis, 12, 0.35, 0.1)
		StartThread(swing,TablesOfPiecesGroups["Arm"],x_axis, 12, 0.35, 0.1)
		StartThread(swing,TablesOfPiecesGroups["Up"],x_axis,  12, 0.35, 0.1)
		StartThread(swing,TablesOfPiecesGroups["Leg"],x_axis, 12, 0.35, 0.1)


end


SIG_SLOWMO = 2
function slowMo()
	SetSignalMask(SIG_SLOWMO)
	
	GG.HiveMind[teamID][unitID].boolActive = true
	modulator= 0
	while GG.HiveMind[teamID][unitID].rewindMilliSeconds > 0 do
		Sleep(100)
		modulator = inc(modulator)
		if modulator % 3 == 0 then 	
			blinkAlarm()
			glowDial(GG.HiveMind[teamID][unitID].rewindMilliSeconds/TIME_MAX)
			GG.HiveMind[teamID][unitID].rewindMilliSeconds =math.max(0,GG.HiveMind[teamID][unitID].rewindMilliSeconds - 100)
		end
		
		GG.HiveMind[teamID][unitID].boolActive = false
		
	end
end


function glowDial(percent)
	hideT(TablesOfPiecesGroups["BarOn"])
	hideT(TablesOfPiecesGroups["BarOff"])
	if percent == 0.0 then
		showT(TablesOfPiecesGroups["BarOff"])
	else
		lowLimit = math.ceil(percent * #TablesOfPiecesGroups["BarOff"])
		showT(TablesOfPiecesGroups["BarOff"],lowLimit+1,#TablesOfPiecesGroups["BarOff"])
		showT(TablesOfPiecesGroups["BarOn"],0,lowLimit)
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