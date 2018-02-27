include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


sporeRange=235
attaPoint=piece"attaPoint"
swingersClub=piece"swingersClub"
local AttachUnits = Spring.UnitScript.AttachUnit
local DropUnits = Spring.UnitScript.DropUnit
boolImAGoldenSpore = (Spring.GetUnitDefID(unitID) = UnitDefNames["goldspore"].id)

timeTillFirstSymptoms= math.random(6,12)*1000
incubationStart= math.random(4,8)*1000
totalGrowTime=5000
teamID= Spring.GetUnitTeam(unitID)
boolOutlier = fairRandom(teamID.."jFungiOutlier", 0.3)

spores={}
spheres={}
for o=1,9, 1 do
	
	spores[o]={}
	for i=1,3,1 do
		
		spores[o][i]={}
		tempPiece="ext"..o
		tempPiece=tempPiece..i
		spores[o][i]=piece(tempPiece)
		
	end
	spheres[o]={}
	tem="extsphere"..o
	spheres[o]= piece (tem)
end


function randomizedTurn(p)
	x=math.random(0,360)
	y=math.random(0,360)
	z=math.random(0,360)
	tSyncIn(p,x,y,z,500)	
end

local spGetUnitDefID=Spring.GetUnitDefID

function filterForHostDefID(lunitTable)
	local T={}
	
	if #lunitTable > 0 or boolThreadStart==false then
		for i=1,#lunitTable do
			id=spGetUnitDefID(lunitTable[i])
			if id==hostDefID then 	T[#T+1]=lunitTable[i] end
		end
		return T
	else 
		return {}
	end
end

function limrandomizedTurn(piece)
	x=math.random(-15,15)
	y=math.random(-15,15)
	z=math.random(-15,15)
	Turn(piece,x_axis,math.rad(x),0.03)
	Turn(piece,y_axis,math.rad(y),0.03)
	Turn(piece,z_axis,math.rad(z),0.03)
	
end
local jsporeid=UnitDefNames["jspore"].id
local fungiforrestid=UnitDefNames["jfungiforrest"].id

function grabTooKill(idOfOldenTimes)
	if idOfOldenTimes== nil then idOfOldenTimes=unitID end
	
	x,y,z=Spring.GetUnitPosition(unitID)
	proChoice={}
	proChoice=Spring.GetUnitsInCylinder(x,z,sporeRange)
	proChoice=filterForHostDefID(proChoice)
	--proChoice if 
	fixxedNumber=table.getn(proChoice)
	--removing the fat from the table
	for i=1, fixxedNumber,1 do
		if proChoice[i]== unitID or proChoice[i]==idOfOldenTimes then 
			table.remove(proChoice,i)
			if i ~= 1 then i=i-1 end
			fixxedNumber=fixxedNumber-1
		end
	end
	n=table.getn(proChoice)
	if proChoice == nil or n <= 1 then 
		return nil 
	else
		counter=0
		while(counter < 4) do
			dice=math.ceil(math.random(0,n))
			
			if proChoice[dice] ~= nil then
				tempDefID=Spring.GetUnitDefID(proChoice[dice])
				if tempDefID~= nil and tempDefID ~= jsporeid and tempDefID ~= fungiforrestid then return proChoice[dice] end
			end
			
			counter=counter+1
		end
		
	end
	
	
	return nil
end

function isInfantry(id)
	passengerDefID=Spring.GetUnitDefID(id)
	if passengerDefID== UnitDefNames["bg"].id or passengerDefID== UnitDefNames["tiglil"].id or passengerDefID== UnitDefNames["skinfantry"].id or passengerDefID== UnitDefNames["vort"].id then
		return true
	else
		return false
	end
end



function delayedSound(id)
	diceWouldBeNice=math.random(1,7)
	if diceWouldBeNice == 4 then
		if isInfantry(id) == true then
			Spring.PlaySoundFile("sounds/jfungiforrest/infantryfungi.wav") 
		else
			Spring.PlaySoundFile("sounds/jfungiforrest/fungi.wav") 
		end
	end
	
	
end

SparedTable={}
function catchingTheCold(handedOverUnitID)
	dxsexLualOrientation,dy,dz=Spring.GetUnitDirection(handedOverUnitID)
	Spring.SetUnitDirection(unitID,dxsexLualOrientation,dy,dz)
	
	Spring.SetUnitNeutral(unitID,true)
	Spring.SetUnitAlwaysVisible(unitID,true)
	Spring.SetUnitBlocking(unitID,false)
	Spring.SetUnitNoSelect (unitID, true)
	
	for o=1,9, 1 do
		for i=1,3,1 do
			Hide(spores[o][i])
		end
		Hide(spheres[o])
	end
	
	RottenToTheCore= handedOverUnitID
	
	
	
	
	if RottenToTheCore then
		Spring.SetUnitAlwaysVisible(RottenToTheCore,true)
		x,y,z=Spring.GetUnitPosition(RottenToTheCore)
		rand=math.random(-15,15)
		Spin(swingersClub,y_axis,math.rad(rand),0.25)
		Spin(attaPoint,y_axis,math.rad(-rand),0.25)
		Spring.SetUnitPosition(unitID,x,z)
		AttachUnits(attaPoint,RottenToTheCore)
		Show(spheres[1])
		for o=1,9, 1 do
			randomizedTurn(spheres[o])
			Show(spheres[o])
			for i=1,3,1 do
				Show(spores[o][i])
				if o==2 and i==1 then
					
					nextDeadGuy=grabTooKill(RottenToTheCore)
					if nextDeadGuy then
					
					StartThread(delayedSound,nextDeadGuy)
						if GG.Spore== nil then GG.Spore={} end
						GG.Spore[#GG.Spore+1] ={}
						GG.Spore[#GG.Spore] =nextDeadGuy						
					
					end
				end
				limrandomizedTurn(spores[o][i])
				if i~= 1 then
					speedySpeeSpeedySpoo=math.random(81,120)/100
					Move(spores[o][i],z_axis,4.2,speedySpeeSpeedySpoo)
					WaitForMove(spores[o][i],z_axis)
				end
			end
			
		end
		
		for i=1,40, 1 do
			Sleep(100)
			
			x=(i%8)+1
			EmitSfx(spores[x][3],1024) 
		end
		
		Move(spheres[1],y_axis,-12,19)
		--DropUnits(RottenToTheCore)
		
		Spring.DestroyUnit(RottenToTheCore,true,false)
		
		WaitForMove(spheres[1],y_axis)
		
		
		
		
	end
	for o=1,9, 1 do
		for i=1,3,1 do
			Hide(spores[o][i])
		end
		Hide(spheres[o])
	end
	-- instantReset()
	
	Spring.DestroyUnit(unitID,false,true)
	
	
end
boolThreadStart=false
local idHandle="NotAnID"
local hostDefID= "NotAnDefID"

function handsUpAhemDown(iCanHandleThis)
	idHandle=iCanHandleThis
	boolThreadStart=true
end

function yoursTrully()
	while(true) do
		if boolThreadStart==true then 
			boolThreadStart=false 
			StartThread(catchingTheCold,idHandle)
			hostDefID=spGetUnitDefID(idHandle)
		end
		Sleep(100)
	end
	
end

function script.Create()
	StartThread(yoursTrully)
end

function script.Killed()
	
	return 0
end