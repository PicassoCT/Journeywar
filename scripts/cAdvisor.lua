include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


local emitHer = piece "emitHer"
local center = piece "center"
advisor = ""

advisor1 = piece "advisor1"

advisor2 = piece "advisor2"

local advleg1 = piece "advleg1"
local advleg2 = piece "advleg2"
local advarm1 = piece "advarm1"
local advarm1low = piece "advarm1low"
local advarm2 = piece "advarm2"
local advarm2low = piece "advarml2ow"
local advGluePoint = piece "advGluePoint"
local circCenter = piece "circCenter"
local circIcon = piece "circIcon"
local spinMeRightRound = piece "spinMeRightRound"
local fourRealGpoint = piece "fourRealGpoint"
local aheadGetter = piece "aheadGetter"

local attachunit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit

local UnitHealthReduce = 24
local orgSensorRad = 200
include "lib_jw.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


local currentSensorRad = orgSensorRad
local addUpRad = 16
local iconRad = currentSensorRad
local PSIrange = 280
local itterator = 1
local SIG_IDLE = 2
local SIG_ICON = 4
local SIG_WALK = 8
local SIG_LEG = 16
local SIG_VAMPIRE = 32
local boolStillAttackin = false
local booldIdle = true
local boolUnitAttached = false
boolHandsfree = true
local boolStalker = false
stone= piece"stone"
boolCastrated= false
function idle()
	SetSignalMask(SIG_IDLE)
	while (true) do
		if boolIdle == true and boolCastrated == false then
			randVal= math.random(-3,4)
			eqValx= math.random(-10,10)
			eqVal= math.random(-110,-50)
			equiTurn(advarm1,advarm1low,z_axis,eqValx, math.abs(eqValx)/10)
			equiTurn(advarm2,advarm2low,z_axis,eqValx*-1, math.abs(eqValx)/10)
			equiTurn(advarm1,advarm1low,y_axis,eqVal, math.abs(eqVal)/100)
			equiTurn(advarm2,advarm2low,y_axis,eqVal*-1, math.abs(eqVal)/100)
			WMove(advisor2,y_axis,randVal,2)
			
		else
			resetT(TableOfPieceGroups["advarm"])
			reset(advarm2low)
			reset(advarm1low)
			Sleep(3500)
			boolIdle = true
		end
		Sleep(100)
	end
end


function script.Create()
	TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	hideT(TableOfPieceGroups["flare"])
	Hide(stone)
	Hide(advisor1)
	Hide(advleg1)
	Hide(advleg2)
	
	StartThread(idle)
	StartThread(lightMyFire)
	StartThread(bulletOS)
	Spin(fourRealGpoint, y_axis, math.rad(-9), 0.5)
	Spin(circCenter, y_axis, math.rad(9), -0.5)
	Move(circIcon, x_axis, -1*orgSensorRad, 0)
	Hide(circIcon)
end

function script.Killed()
	Spring.SetUnitNeutral(unitID,true)
	Spring.SetUnitNoSelect(unitID,true)
	for k,v in pairs(CurrentlyControlledProjectiles) do
		Spring.SetProjectileMoveControl(k, false)
	end
	
	setSpeedEnv(unitID, 0.0)
	Signal(SIG_IDLE)
	Signal(SIG_ICON)
	Signal(SIG_VAMPIRE)
	if Spring.ValidUnitID(lastAttachedUnit) and Spring.GetUnitIsDead(lastAttachedUnit)==false then
		DropUnit(lastAttachedUnit)
	end
	violentMoveTime=math.random(1000,4500)
	bloodySunday= function() 
		if boolCastrated == true then
			EmitSfx(advisor1,1025)	
		else
			EmitSfx(advisor2,1025)
		end
	end
	spinRand(advisor1,10,42,5)
	spinRand(advisor2,10,42,5)
	while violentMoveTime > 0 do
		x_val, y_val, z_val = math.random(-100,100),math.random(20,100),math.random(-100,100)
		timeSnippet=math.random(350,800)
		tSyncIn(center, math.random(-5,5), math.random(-10,10), math.random(-5,5), timeSnippet)
		mSyncIn(center, x_val, y_val, z_val, timeSnippet)
		whileMovingDo(center, y_axis, 150, bloodySunday	)
		whileMovingDo(center, x_axis, 150, bloodySunday	)
		whileMovingDo(center, z_axis, 150, bloodySunday	)		
		Sleep(10)
		violentMoveTime=violentMoveTime -timeSnippet
	end

	tSyncIn(center, 0,0, 0, 600)
	mP(center,0,math.random(20,75),0,80)
	whileMovingDo(center, y_axis, 150, bloodySunday	)

	mP(center,0,0,0,30)
	whileMovingDo(center, y_axis, 150, bloodySunday	)
	for i=1,10,1 do
		bloodySunday()
		Sleep(150)
	end
	return 1
end

ox, oy, oz = Spring.GetUnitPosition(unitID)
boolOnce = true
numbers = { 
["0"] = true, 
["1"] = true, 
["2"] = true, 
["3"] = true, 
["4"] = true, 
["5"] = true, 
["6"] = true, 
["7"] = true, 
["8"] = true, 
["9"] = true }
advisorDef = Spring.GetUnitDefID(unitID)
function reportForNeuralEnhancement()
	strings = "Citizen Nr:"
	PlaySoundByUnitDefID(advisorDef, "sounds/cadvisor/advisorreportA.ogg", 1, 1000, 1)	
	unitidstring = tostring(unitID)

	for i = 1, string.len(unitidstring) do
		
		local c = trim(string.sub(unitidstring, i, i))
		Spring.Echo(c)
		if c and numbers[c] then
			-- do something with c
			strings = strings .. c
			PlaySoundByUnitDefID(advisorDef, "sounds/numbers/" .. c .. ".ogg", 1, 650, 1)	
		end
	end
	PlaySoundByUnitDefID(advisorDef, "sounds/cadvisor/advisorreportB.ogg", 1, 25000, 1)
	--Spring.Echo(strings.." please report to administration for a performance review")
end

function punnish()
	Spring.SetUnitNoSelect(unitID, true)
	
	nx, ny, nz = Spring.GetUnitPosition(unitID)
	ux, uy, uz = Spring.GetUnitPosition(unitID)
	reportForNeuralEnhancement()
	while math.abs(ux - ox) > 85 or math.abs(uy - oy) > 85 or math.abs(uz - oz) > 85 do
		Spring.SetUnitMoveGoal(unitID, ox, oy, oz)
		ux, uy, uz = Spring.GetUnitPosition(unitID)
		Sleep(1000)
	end
	boolStalker = true
	PSIrange = 320
	orgSensorRad = 600
	Move(advisor2, y_axis, 0, 0)
	Hide(advisor2)
	Show(advisor1)
	Show(advleg1)
	Show(advleg2)
	Spring.SetUnitMoveGoal(unitID, nx, ny, nz)
	Spring.SetUnitNoSelect(unitID, false)
	boolCastrated = true
end

boolOnce = false
function script.Activate()
	if boolOnce == false then boolOnce = true
		StartThread(punnish)
	end
	
	return 1
end

function script.Deactivate()
	
	return 0
end



function walk()
	SetSignalMask(SIG_WALK)
	while (true) do
		dolo = math.random(0, 5)
		if dolo == 1 then
			Move(advisor1, y_axis, 5, 0.1)
		elseif dolo == 2 then
			Move(advisor1, y_axis, 0, 0.1)
		end
		Turn(advleg1, x_axis, math.rad(-22), 6)
		Turn(advleg2, x_axis, math.rad(22), 6)
		if boolOnce == true then
			Turn(advisor1, x_axis, math.rad(1.2), 0.5)
			
			WaitForTurn(advleg2, x_axis)
			WaitForTurn(advleg1, x_axis)
			Turn(advleg1, x_axis, math.rad(22), 6)
			Turn(advleg2, x_axis, math.rad(-22), 6)
			Turn(advisor1, x_axis, math.rad(-0.8), 0.5)
			WaitForTurn(advleg2, x_axis)
			WaitForTurn(advleg1, x_axis)
		else
			Move(advisor2, y_axis, math.random(0, 50), 3)
			Sleep(300)
		end
		val = math.random(10, 60)
		zval = math.random(0, 56)
		Turn(advarm1, y_axis, math.rad(-val), 1.2)
		Turn(advarm1, z_axis, math.rad(zval), 1.2)
		Turn(advarm1low, y_axis, math.rad(val * 2), 3.2)
		Turn(advarm2, y_axis, math.rad(val), 1.2)
		Turn(advarm2, z_axis, math.rad(-zval), 1.2)
		Turn(advarm2low, y_axis, math.rad(val * -2), 3.2)
	end
end

function script.StartMoving()
	Turn(center,y_axis,0,5)
	Signal(SIG_WALK)
	StartThread(walk)
end

function legs_down()
	SetSignalMask(SIG_LEG)
	Sleep(250)
	Move(advisor1, y_axis, 0, 3)
	Move(advisor1, x_axis, 0, 3)
	Move(advisor1, z_axis, 0, 3)
	
	Turn(advisor1, y_axis, math.rad(0), 6)
	Turn(advleg1, x_axis, math.rad(0), 6)
	Turn(advleg2, x_axis, math.rad(0), 6)
	
	Turn(advisor1, x_axis, math.rad(0), 9)
	val = 70
	zval = 25
	Turn(advarm1, y_axis, math.rad(-val), 1.2)
	Turn(advarm1, z_axis, math.rad(zval), 1.2)
	Turn(advarm1low, y_axis, math.rad(val * 2), 3.2)
	Turn(advarm2, y_axis, math.rad(val), 1.2)
	Turn(advarm2, z_axis, math.rad(-zval), 1.2)
	Turn(advarm2low, y_axis, math.rad(val * -2), 3.2)
end

function script.StopMoving()
	Signal(SIG_WALK)
	StartThread(legs_down)
end



roundTimeInFrames = 30*30

function hpCheck()
	boolUnitAttached = true
	hpOfOld = Spring.GetUnitHealth(unitID)
	hpCurrent = hpOfOld
	--attachUnit TODO
	while hpCurrent >= hpOfOld and boolUnitAttached == true do
		
		hpOfOld = hpCurrent
		hpCurrent = Spring.GetUnitHealth(unitID)
		Sleep(250)
	end
	--detachUnit TODO
	boolUnitAttached = false
end

function returnRandomLastAttacker(UnitTable)
	tableOfVolunteers = {}
	if UnitTable ~= nil then
		for i = 1, table.getn(UnitTable), 1 do
			if Spring.GetUnitLastAttacker(UnitTable[i]) == unitID then
				table.insert(tableOfVolunteers, UnitTable[i])
			end
		end
		if tableOfVolunteers ~= nil and table.getn(tableOfVolunteers) > 0 then
			
			theOne = math.random(1, table.getn(tableOfVolunteers))
			return tableOfVolunteers[theOne]
		end
	else
	end
end

function iconOngraphy()
	SetSignalMask(SIG_ICON)
	local reduceFactor=1
	while (true) do
		Sleep(150)
		mx,my,mz= Spring.GetUnitPosition(unitID)
		ghostrotation= ((Spring.GetGameFrame() % roundTimeInFrames)/roundTimeInFrames)*math.pi*2
		offx,offz= Rotate(0, iconRad*reduceFactor, ghostrotation)
		gh= Spring.GetGroundHeight(mx+offx,mz+offz)
		Spring.SpawnCEG("cpsiscan", offx+mx, gh + 5, offz+mz, 0, 1, 0, 60)
		ghostrotation= ((Spring.GetGameFrame()+ (roundTimeInFrames/2) % roundTimeInFrames)/roundTimeInFrames)*math.pi*2
		offx,offz= Rotate(0, iconRad*reduceFactor, ghostrotation)
		gh= Spring.GetGroundHeight(mx+offx,mz+offz)
		Spring.SpawnCEG("cpsiscan", offx+mx, gh + 5, offz+mz, 0, 1, 0, 60)
		
	end
end

function lightMyFire()
	while true do
		while boolLightMyFire == true do
			EmitSfx(emitHer, 1024)
			EmitSfx(advisor1, 1024)
			Sleep(50)
		end
		Sleep(500)
	end
end

boolLightMyFire = false
lastAttachedUnit = nil
function vampireCycle(attachUnitID)
	SetSignalMask(SIG_VAMPIRE)
	if lastAttachedUnit ~= nil and Spring.ValidUnitID(lastAttachedUnit) == true then
		DropUnit(lastAttachedUnit)
		--detach Unit of Old
	end
	--attachUnit
	Signal(SIG_ICON)
	StartThread(iconOngraphy)
	SetUnitValue(COB.BUSY, 1)
	
	attachunit(fourRealGpoint, attachUnitID)
	boolUnitAttached = true
	
	lastAttachedUnit = attachUnit
	health = Spring.GetUnitHealth(attachUnitID)
	
	
	Spin(spinMeRightRound, y_axis, math.rad(42), 0.01)
	
	boolLightMyFire = true
	
	while health and (boolUnitAttached == true and health > 0) do
		
		Sleep(250)
		
		currentSensorRad = currentSensorRad + addUpRad/4
		health = Spring.GetUnitHealth(attachUnitID)
		if health then
			health = health - UnitHealthReduce/4
			Spring.SetUnitHealth(attachUnitID, health)
			--expand radarRange
			Spring.SetUnitSensorRadius(unitID, "los", currentSensorRad+5)
			Spring.SetUnitSensorRadius(unitID, "radar", currentSensorRad+5)
			--update
			iconRad = currentSensorRad
		end
	end
	
	boolLightMyFire = false
	--Spring.Echo("AdvisorStalker_reaching AttachFunction8")
	StopSpin(spinMeRightRound, y_axis, 0)
	DropUnit(attachUnitID)
	currentSensorRad = orgSensorRad
	iconRad = currentSensorRad
	
	Signal(SIG_ICON)
	--Shrink RadarRange back to normal
	Spring.SetUnitSensorRadius(unitID, "los", orgSensorRad)
	Spring.SetUnitSensorRadius(unitID, "radar", orgSensorRad)
	SetUnitValue(COB.BUSY, 0)
end

function getUnitsInRange()
	--Sleep(500)
	Sleep(1200)
	px, py, pz = Spring.GetUnitPosition(unitID)
	UnitsTable = {}
	UnitsTable = Spring.GetUnitsInCylinder(px, pz, PSIrange)
	--get Units in Range
	
	if UnitsTable ~= nil then
		--filter out who have the AdvisorStalker as last Opponent
		--random Dice one out
		vicTim = returnRandomLastAttacker(UnitsTable)
		if vicTim ~= nil then
			Sleep(50)
			StartThread(vampireCycle, vicTim)
			boolUnitAttached = true
			StartThread(hpCheck)
		end
		--StartThread
		
		
	else
		--caught a empty table
	end
end

function script.QueryWeapon1()
	return advGluePoint
end

function script.AimFromWeapon1()
	--soundstart="sentryalert"
	return advGluePoint
end

Valx = -10
Val = -30
function script.AimWeapon1(heading, pitch)
	Signal(SIG_IDLE)
	Val = math.min(Val +5, 90)
	Valx = math.min(Val +1, 10)
	equiTurn(advarm1,advarm1low,z_axis,Valx, math.abs(Valx)/10)
	equiTurn(advarm2,advarm2low,z_axis,Valx*-1, math.abs(Valx)/10)
	equiTurn(advarm1,advarm1low,y_axis,Val*-1, math.abs(Val)/100)
	equiTurn(advarm2,advarm2low,y_axis,Val, math.abs(Val)/100)
	if boolUnitAttached == false then
		Turn(advisor1, y_axis, heading, 2.0)
		-- Turn(advisor1,x_axis,-pitch,2.0)
		WaitForTurn(advisor1, y_axis)
		
		
		return true
	else
		return false
	end
end


function script.FireWeapon1()
	
	Valx =-10
	Val = -70
	StartThread(getUnitsInRange)
end


function script.QueryWeapon2()
	return spinMeRightRound
end

function script.AimFromWeapon2()
	
	return spinMeRightRound
end


function script.AimWeapon2(heading, pitch)
	Signal(SIG_IDLE)
	Show(stone)
	spinRand(stone,10,42,5)
	WMove(stone,y_axis,0,35)
	Turn(center,y_axis,heading,5)
	EmitSfx(stone, 1024)
	EmitSfx(advisor1, 1024)
	EmitSfx(advisor2, 1024)
	return true
end


function script.FireWeapon2()
	Hide(stone)
	WMove(stone,y_axis,-10,0)
	stopSpins(stone,0)
end







CurrentlyControlledProjectiles = {}
Counter = 0
TimeTillDestroy = 22000
myTeamID = Spring.GetUnitTeam(unitID)

function bulletOS()
	
	while boolStalker == false do
		ux, uy, uz = Spring.GetUnitPosition(unitID)
		if boolUnitAttached == false then
			catchProjectiles(ux, uy, uz)
		end
		whirlAndDropProjectiles(200, ux, uy, uz)
		
		Sleep(200)
	end
end


function catchProjectiles(ux, uy, uz)
	
	
	T = Spring.GetProjectilesInRectangle(ux - 100, uz - 100, ux + 100, uz + 100)
	if not T then return end
	
	T= process(T,
	function(id)
		team = Spring.GetProjectileTeamID (id)
		if team ~= myTeamID then 
			return id 
		end
	end
	)
	
	if not T then return end
	for i = 1, #T, 1 do
		if T[i] and Counter < 5 then
			Spring.SetProjectileMoveControl(T[i], true)
			CurrentlyControlledProjectiles[T[i]] = TimeTillDestroy
			Counter = Counter + 1
		end
	end
end

function whirlAndDropProjectiles(timeSinceLastCall, ux, uy, uz)
	
	
	--0.001999198 = 1/TimeTillDestroy*NrOfTotalSpins
	for k, v in pairs(CurrentlyControlledProjectiles) do
		px, py, pz = Spring.GetProjectilePosition(k)
		if px and ux then
			SpeedAtStart = (v * 2) / TimeTillDestroy
			x, z = Rotate(px - ux, pz - uz, math.rad(v * 0.001999198 * (SpeedAtStart)))
			Spring.SetProjectilePosition(k, x + ux, py, z + uz)
			CurrentlyControlledProjectiles[k] = v - timeSinceLastCall
			
			if v <= 0 or boolUnitAttached == true then
				Spring.SetProjectileGravity(k, 9000)
				Spring.SetProjectileMoveControl(k, false)
				CurrentlyControlledProjectiles[k] = nil
				Counter = math.max(0, Counter - 1)
			end
		end
	end
end