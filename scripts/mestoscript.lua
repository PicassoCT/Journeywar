
include "createCorpse.lua"

local mestorage = piece "mestorage"
local meelevator = piece "meelevator"

local center=piece"center"
local addOn=piece"addOn"
local gettinLow=-91
local SIG_ACTIVE=2
teamID=Spring.GetUnitTeam(unitID)
alt1=piece"alt1"
alt2=piece"alt2"

pillarPieces={}
for i=1,12,1 do
	pillarPieces[i]={}
	pillar="pillAr"..i
	pillarPieces[i]=piece(pillar)
end
store={}
for i=1,5,1 do
	store[i]={}
	starage="storage"..i
	store[i]=piece(starage)
end

function moveDown()
	SetSignalMask(SIG_DOWN)
	Move(center,y_axis,0,0.2)
	WaitForMove(center,y_axis)
end

function moveUp()
	SetSignalMask(SIG_UP)
	
	Show(store[1])
	Show(store[2])
	Show(store[3])
	Show(store[4])
	
	Move(addOn,y_axis,87,0.3)
	WaitForMove(addOn,y_axis)
	gettinLow=-80
	x=342
	for i=2,3,1 do
		if i==3 then
			for i=1,12,1 do
				rand=math.random(0,1)
				if rand==1 then
					Show(pillarPieces[i])
				end
			end
		end
		
		tax=(i)*x
		Move(center,y_axis,150,0.3)
		WaitForMove(center,y_axis)
	end
end

function inStore()
	Sleep(10000)
	valueOfNew=0
	valeOfOld=0
	currentLevel, storage, pull, income, expense, share, sent, received	=Spring.GetTeamResources(teamID, "metal" ) 
	valeOfOld=storage
	valueOfNew=storage
	Sleep(1000)
	while(true) do
		sat, valueOfNew, pull, income, expense, share, sent, received=Spring.GetTeamResources(teamID, "metal" ) 
		if valueOfNew >= valeOfOld and valueOfNew~= 0 then
			Signal(SIG_DOWN)
			StartThread(moveUp) 
		else
			Signal(SIG_UP)
			StartThread(moveDown)
		end
		
		Sleep(1000) 
		valeOfOld=valueOfNew
		
	end
	
end

function uncannyTeachVally()
	while true do
	Sleep(280000)
		if math.random(0,1)==1 then 
			moveBlocks(math.random(0.001,0.025))
		end
	end
end

boolMeElevator=true
function script.Create()
	moveBlocks(0)
	StartThread(uncannyTeachVally) 
	randoval=math.random(0,12)
	randoval=randoval*90
	Turn(center,y_axis,math.rad(randoval),0)
	
	for i=1,12,1 do
		Hide(pillarPieces[i])
	end
	for i=1,5,1 do
		Hide(store[i])
	end
	Hide(alt1)	
	Hide(alt2)	
	Hide(mestorage)	
	Hide(mestorage2)	
	
	if math.random(0,1)==1 then
		Show(mestorage)
		x=math.random(0,4)
		if x== 1 then
			StartThread(inStore)
		end
		--boolAllreadyAlarmed=false 
		--StartThread(alarmCheck)
		if math.random(0,6)~=1 then
			Hide(meelevator)
			boolMeElevator=false
		end
		
	else
		Hide(meelevator)
		boolMeElevator=false
		if math.random(0,1)==1 then 
			Show(alt1) 
		else 
			Show(alt2) 
		end
	end
end

local function iliketoMoveIt()
	Signal(SIG_ACTIVE)
	SetSignalMask(SIG_ACTIVE)
	while(boolMeElevator==true)do
		Move(meelevator,y_axis,-70,0.5)
		WaitForMove(meelevator,y_axis)
		
		Move(meelevator,y_axis,-81,0.25)
		WaitForMove(meelevator,y_axis)
		
		Move(meelevator,y_axis,gettinLow,0.125)
		WaitForMove(meelevator,y_axis)
		
		Sleep(50)
		
		Move(meelevator,y_axis,-81,0.25)
		WaitForMove(meelevator,y_axis)
		
		Move(meelevator,y_axis,-70,0.5)
		WaitForMove(meelevator,y_axis)
		
		Move(meelevator,y_axis,-10,0.25)
		WaitForMove(meelevator,y_axis)
		
		Move(meelevator,y_axis,0,0.125)
		WaitForMove(meelevator,y_axis)
		Sleep(50)
	end
	
	
end


function script.Killed(recentDamage, maxHealth)
	
	Explode(mestorage,SFX.SHATTER)
	Explode(meelevator,SFX.FALL+SFX.FIRE)
	
	createCorpseCBuilding(unitID,recentDamage)
	
	return 0
end

function moveBlocks(speed)
	blockTable={}
	for i=0,14 do
		blockTable[i]="Blok"..i
		blockTable[i]=piece(blockTable[i])
	end
	
	for i=0,14,1 do
		dx,dy,dz=0,0,0
		if (i-1) % 5== 0 then
			dx,dy,dz=randSign()*40,-10,randSign()*40
		else
			if math.random(0,5) < 4 then
				dx=math.random(-1,1)*math.random(15,20)	+math.random(-1,1);
				dz=math.random(-1,1)*math.random(15,20)	+math.random(-1,1);
			else
				dy=math.random(0,1)*math.random(15,20)	+math.random(-1,1);
			end			
		end
		mP(blockTable[i],dx,dy,dz,speed)
	end
end


function script.Activate()
	Signal(SIG_ACTIVE)
	StartThread(iliketoMoveIt)
	return 1
end

function script.Deactivate()
	
	Signal(SIG_ACTIVE)
	return 0
end


--------BUILDING---------