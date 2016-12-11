
local piecesTable={}
center =piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
turnerPoint =piece"turnerPoint"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= turnerPoint
Main =piece"Main"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Main

Head =piece"Head"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Head
Eye1 =piece"Eye1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Eye1
Eye2 =piece"Eye2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Eye2
Kreis01 =piece"Kreis01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis01
upleg1 =piece"upleg1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= upleg1

LegTable={}
Leg1 =piece"Leg1"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Leg1
LLeg1 =piece"LLeg1"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= LLeg1
Leg2 =piece"Leg2"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Leg2
LLeg2 =piece"LLeg2"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= LLeg2
Leg3 =piece"Leg3"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Leg3
LLeg3 =piece"LLeg3"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= LLeg3
Leg4 =piece"Leg4"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Leg4
LLeg4 =piece"LLeg4"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= LLeg4
Leg5 =piece"Leg5"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Leg5
LLeg5 =piece"LLeg5"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= LLeg5

Lupleg1 =piece"Lupleg1"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Lupleg1
upleg2 =piece"upleg2"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= upleg2
Lupleg2 =piece"Lupleg2"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Lupleg2
upleg3 =piece"upleg3"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= upleg3
Lupleg3 =piece"Lupleg3"
LegTable[#LegTable+1]={}
LegTable[#LegTable]= Lupleg3

RateOfDecrease=65
ItterationsTillReSpawn=0
MAGICRESPAWNNUMBER=Spring.GetUnitHealth(unitID)
MAGICRESPAWNNUMBER=MAGICRESPAWNNUMBER/2

SIG_MOVE=1
SIG_LAY=2

-- Spring.PlaySoundFile("sounds/jFactory/Factory1.wav",(loudness+i/10)%1) 

function costlyWhileOnTheMove()
	local lSetUnitHealth=Spring.SetUnitHealth
	local lGetUnitHealth=Spring.GetUnitHealth
	while(true) do
		
		while boolMoving==true do
			
			for i=10,15,1 do
				if i~=12 and i~= 13 then
					Turn(LegTable[i],y_axis,math.rad(22),7)
				else
					Turn(LegTable[i],z_axis,math.rad(22),7)
				end
			end
			WaitForTurn(LegTable[15],y_axis)
			Sleep(200)
			for i=10,15,1 do
				if i~=12 and i~= 13 then
					Turn(LegTable[i],y_axis,math.rad(-22),3)
				else
					Turn(LegTable[i],z_axis,math.rad(-22),3)
				end
			end
			
			WaitForTurn(LegTable[15],y_axis)
			health=lGetUnitHealth(unitID)
			lSetUnitHealth(unitID,health-RateOfDecrease*(0.05*math.max(1,GG.SunGodCattleTable[teamID])))
		end
		
		health=lGetUnitHealth(unitID)
		lSetUnitHealth(unitID,health-2*(0.05*math.max(1,GG.SunGodCattleTable[teamID])))
		
		Sleep(1000)
	end
	
	
end		

function layDownYourWorryHead()
	SetSignalMask(SIG_LAY)
	Sleep(900)
	boolMoving=false
	
	Turn(center,y_axis,math.rad(math.random(-360,360)),0.25)
	Signal(SIG_GET)
	Rand=math.ceil(math.random(3200,19000))
	Sleep(Rand)
	
	Turn(turnerPoint,z_axis,math.rad(-45),12)
	WaitForTurn(turnerPoint,z_axis)
	
	Turn(turnerPoint,z_axis,math.rad(-85),0.2)
	WaitForTurn(turnerPoint,z_axis)
	Sleep(2000)
	
	for i=1,table.getn(LegTable),1 do
		deg=math.random(22,40)
		Turn(LegTable[i],x_axis,math.rad(deg),0.1)
		deg=math.random(22,40)
		Turn(LegTable[i],y_axis,math.rad(deg),0.1)
		deg=math.random(22,40)
		Turn(LegTable[i],z_axis,math.rad(-deg),0.1)
	end
	
	
	--lay DownAnimation
	
end		

SIG_GET=4
function inProtest()
	Sleeptime=math.ceil(math.random(1500,5000))
	Sleep(Sleeptime)
	loudness=math.random(0.8,1)
	Spring.PlaySoundFile("sounds/jSunCattle/UrScream.wav",loudness)
end


function getUpAndMove()
	SetSignalMask(SIG_GET)
	Turn(center,y_axis,math.rad(0),5)
	for i=1,table.getn(LegTable),1 do
		Turn(LegTable[i],x_axis,math.rad(0),0.22)
		Turn(LegTable[i],y_axis,math.rad(0),0.22)
		Turn(LegTable[i],z_axis,math.rad(20),0.22)
	end
	
	Turn(turnerPoint,z_axis,math.rad(0),0.27)
	
	while (true==Spring.UnitScript.IsInTurn (piecesTable[2], z_axis)) do
		for i=10,15,1 do
			if i~=12 and i~= 13 then
				Turn(LegTable[i],y_axis,math.rad(22),7)
			else
				Turn(LegTable[i],z_axis,math.rad(22),7)
			end
		end
		WaitForTurn(LegTable[15],y_axis)
		Sleep(200)
		for i=10,15,1 do
			if i~=12 and i~= 13 then
				Turn(LegTable[i],y_axis,math.rad(-22),3)
			else
				Turn(LegTable[i],z_axis,math.rad(-22),3)
			end
		end
		
		WaitForTurn(LegTable[15],y_axis)
		Sleep(200)
	end
	
	WaitForTurn(turnerPoint,z_axis)
	for i=1,table.getn(LegTable),1 do
		Turn(LegTable[i],x_axis,math.rad(0),1)
		Turn(LegTable[i],y_axis,math.rad(0),1)
		Turn(LegTable[i],z_axis,math.rad(0),1)
	end
	
	StartThread(inProtest)
	Turn(turnerPoint,z_axis,math.rad(0),1)
	
	WaitForTurn(turnerPoint,z_axis)
	
	local ra=math.random
	local lLegTable=LegTable
	modu=1
	while true do 
		
		if modu==1 then
			modu=0
			for i=1,11, 4 do
				Turn(lLegTable[i],x_axis,math.rad(-44-ra(-5,15)),0.8+ra(0.1,0.6))
				Turn(lLegTable[i+1],x_axis,math.rad(-6-ra(7,14)),0.8+ra(0.1,0.6))
			end
			
			for i=3,11, 4 do
				Turn(lLegTable[i],x_axis,math.rad(12+ra(1,12)),0.8+ra(0.1,0.6))
				Turn(lLegTable[i+1],x_axis,math.rad(12+ra(1,12)),0.8+ra(0.1,0.6))
			end
			d=ra(1,3)
			Turn(turnerPoint,x_axis,math.rad(d),d/10)
			d=ra(2,6)
			Turn(turnerPoint,z_axis,math.rad(d),d/20)
			d=ra(-7,3)
			Turn(Head,x_axis,math.rad(d),0.4)
			Move(Main,y_axis,-12,2.5)
			d=ra(0,10)
			Turn(Eye1,y_axis,math.rad(d),3)
			d=ra(30,50)
			Turn(Eye1,y_axis,math.rad(d),d/10)
			Turn(Main,x_axis,math.rad(4.2),0.2)
		else
			for i=3,11, 4 do
				Turn(lLegTable[i],x_axis,math.rad(-44-ra(-5,15)),0.8+ra(0.1,0.6))
				Turn(lLegTable[i+1],x_axis,math.rad(-6-ra(7,14)),0.8+ra(0.1,0.6))
			end
			
			for i=1,11, 4 do
				Turn(lLegTable[i],x_axis,math.rad(12+ra(1,12)),0.8+ra(0.1,0.6))
				Turn(lLegTable[i+1],x_axis,math.rad(12+ra(1,12)),0.8+ra(0.1,0.6))
			end
			
			d=ra(2,20)
			Turn(Eye1,y_axis,math.rad(d),3)
			Turn(Eye2,y_axis,math.rad(-10),3)
			d=ra(-6,0)
			Move(Main,y_axis,d,3.5)
			Turn(Main,x_axis,math.rad(-4.2),0.2)
			Turn(turnerPoint,z_axis,math.rad(-5),0.25)
			
			modu=1
		end
		EmitSfx(center,1024)				
		EmitSfx(turnerPoint,1024)				
		WaitForTurn(lLegTable[1],x_axis)
		WaitForTurn(lLegTable[3],x_axis)
		EmitSfx(center,1024)				
		EmitSfx(turnerPoint,1024)	
		
		if modu== 0 then 
			Turn(turnerPoint,x_axis,math.rad(-3),0.5) 
			Turn(Head,x_axis,math.rad(5),0.5)
		end
	end
	
end		

boolMoving=false
_,originalHealth=Spring.GetUnitHealth(unitID)	
function script.StartMoving()
	Signal(SIG_MOVE)
	Signal(SIG_LAY)
	Signal(SIG_GET)
	boolMoving=true
	
	StartThread(getUpAndMove)
	
	
end
function legDown()
	for i=1,table.getn(LegTable),1 do
		Turn(LegTable[1],x_axis,math.rad(0),3.25)
		Turn(LegTable[1],y_axis,math.rad(0),3.25)
		Turn(LegTable[1],z_axis,math.rad(0),3.25)
	end
end
function script.StopMoving()
	
	
	Signal(SIG_LAY)
	legDown()
	StartThread(layDownYourWorryHead)
	
	
end

teamID=Spring.GetUnitTeam(unitID)

function timeDelayedMoveGoal(myYoung,x,y,z)
	Sleep(2000)
	Spring.SetUnitMoveGoal(myYoung,x,y,z)
	
end

boolDefBuffActive=true


function script.HitByWeapon ( x, z, weaponDefID, damage )
	
	if damage then
		
		boolDefBuffActive=false
		Signal(SIG_MOVE)
		degree=math.deg(math.atan2(x,z))
		ItterationsTillReSpawn=ItterationsTillReSpawn+damage
		
		if ItterationsTillReSpawn > MAGICRESPAWNNUMBER then
			boolThreadStart=true
		end
		
		
		Spring.SetUnitHealth(unitID,originalHealth)
	end
	return 0
end

boolThreadStart=false
function threadStartLoop()
	while true do
		Sleep(500)
		if boolThreadStart==true then
			boolThreadStart=false
			ItterationsTillReSpawn=ItterationsTillReSpawn-MAGICRESPAWNNUMBER
			x,y,z=Spring.GetUnitPosition(unitID)
			GG.UnitsToSpawn:PushCreateUnit("jsuneggnogg",x,y+15,z+15, 0, teamID) 
			hp=Spring.GetUnitHealth(unitID)
			Spring.SetUnitHealth(unitID,math.ceil(hp*0.8))
			
			--StartThread(timeDelayedMoveGoal,myYoung,x,y,z)
		end
	end
end
function script.Killed(damage,_)
	GG.SunGodCattleTable[teamID]=GG.SunGodCattleTable[teamID]-1
	--fallingDown Animation
	
	return 0
end

maxHealth= Spring.GetUnitHealth(unitID)

--DeBuff Cycle
local spGetUnitHealth=Spring.GetUnitHealth
local spSpawnCEG=Spring.SpawnCEG
UNITDEBUFFVAL=25
function applyDeBuff(T)
	unithealth=Spring.GetUnitHealth(unitID)
	local ratio=unithealth/maxHealth
	for i=1,#T,1 do
		hp=spGetUnitHealth(T[i])
		if ratio < 0.3 then 
			Spring.AddTeamResource(teamID,"metal",3)
		end
		Spring.SetUnitHealth(T[i], {paralyze = hp*(15-(15*ratio))})
		--sfx
		x,y,z=Spring.GetUnitPosition(T[i])
		spSpawnCEG("electric_explosion",x,y+10,z,0,1,0,50,0)
	end
end

function DeBuff()
	local spGetUnitsInCylinder=Spring.GetUnitsInCylinder
	local spGetUnitPosition=Spring.GetUnitPosition
	local RANGE=600
	
	while true do
		x,y,z=spGetUnitPosition(unitID)
		if boolDefBuffActive==true then
			T=spGetUnitsInCylinder(x,z,RANGE)
			if T then T=filterAllUnitsForDeBuff(T) end
			if T then applyDeBuff(T) end
			EmitSfx(1025,Eye1) -- Placeholder Sfx
		end
		
	end
	Sleep(500)
end			

local spGetUnitTeam=Spring.GetUnitTeam
function filterAllUnitsForDeBuff(Table)
	table.remove(Table,unitID)
	if Table then
		RT={}
		for i=1,#Table, 1 do
			if spGetUnitTeam(Table[i])~=teamID then RT[#RT+1]=Table[i] end
		end
		if #RT > 0 then return RT end
	end
end

boolHitIt=false
function threadStarter()
	while boolHitIt==false do
		Sleep(500)
	end
	
	if boolHitIt==true then 
		StartThread(costlyWhileOnTheMove) 
		StartThread(DeBuff)
	end
end

function threatenToStart()
	Sleep(1500)
	boolHitIt=true
end

function script.Create()
	if not GG.SunGodCattleTable then GG.SunGodCattleTable ={} end
	if not GG.SunGodCattleTable[teamID] then GG.SunGodCattleTable[teamID] =0 end
	GG.SunGodCattleTable[teamID]=GG.SunGodCattleTable[teamID]+1
	StartThread(threadStarter)
	StartThread(threatenToStart)
	StartThread(threadStartLoop)
end