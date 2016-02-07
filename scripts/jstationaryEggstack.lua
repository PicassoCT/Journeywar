
include "lib_UnitScript.lua"
eggnok={}
for i=1,36,1 do
	eggnok[i]={}
	temp="eggnog"..i
	eggnok[i]=piece (temp)
end
eggrotate=piece"eggrotate"
local boolAllreadyDead=false
local boolAllreadyStarted=false
local boolMurdered=true
local mexID = -666
SIG_RESET=1
boolUnDeployed=false
local boolSafetyFirst=false
boolMightBeAReset=false
local boolreVert=false
--Created
center=piece"center"

deCidere=1
Eggtable={}
localPiece=piece
Eggtable=makeTableOfPieceNames("egg",10,1,localPiece)

fruitwat={}
for i=1, 2, 1 do
	fruitwat[i]={}
	feetFeti="water"..i
	fruitwat[i]=piece (feetFeti)
	Spin(fruitwat[i],y_axis,math.rad(42),0.1)
end

feetFetish={}
for i=1, 6, 1 do
	feetFetish[i]={}
	feetFeti="feet0"..i
	feetFetish[i]=piece (feetFeti)
end


function script.Killed(recentDamage, maxHealth)
	return 1
	
	
end

function water()
	xR=math.random(-42,42)
	Spin(eggrotate,y_axis,math.rad(xR),0.3)
	
	interVall=0	
	while true do
		dirSpin=math.random(-42,42)
		for i=1, 2, 1 do
			Spin(fruitwat[i],y_axis,math.rad(dirSpin),0.1)
		end
		if math.abs(interVall) <0.25 then interVall = math.random(5,9) end
		Move(eggrotate,y_axis,interVall,19.15)
		Move(fruitwat[2],y_axis,0,0.25)
		WaitForMove(fruitwat[2],y_axis)
		Move(fruitwat[1],y_axis,-3,1.25)
		WaitForMove(fruitwat[1],y_axis)
		interVall=interVall*-0.5
		Move(eggrotate,y_axis,interVall,19.15)	
		Move(fruitwat[1],y_axis,0,1.25)
		WaitForMove(fruitwat[1],y_axis)
		Move(fruitwat[2],y_axis,-3,1.25)
		WaitForMove(fruitwat[2],y_axis)
		if math.random(0,1)==1 then Move(eggrotate,x_axis,math.random(-2.5,2.5),0.7) end
		if math.random(0,1)==1 then Move(eggrotate,z_axis,math.random(-2.5,2.5),0.7) end
	end
end




boolBuilding=false
function workInProgress()
	StartThread(water)
	
	buildID=nil
	buildIDofOld=nil
	counter=0
	while(true)do
		buildID=Spring.GetUnitIsBuilding(unitID)
		if buildID and buildID~= buildIDofOld then
			
			counter=counter+1
			if counter >35 then 	Spring.DestroyUnit(unitID,true,false) end
			Hide(eggnok[counter])
			boolBuilding=true
			Spring.SetUnitNoDraw(buildID,true)
			buildProgress=0
			
			while  buildProgress and buildProgress < 1 do
				health,maxHealth,paralyzeDamage,captureProgress,buildProgress=Spring.GetUnitHealth(buildID)
				if buildProgress then
					--show the egg
					buildProgress=math.min(math.max(1,math.floor(buildProgress*10)),#Eggtable)
					hideT(Eggtable)
					Show(Eggtable[buildProgress])			
				else
					buildProgress=nil
				end
				Sleep(150)
			end
			
			if buildID ~=nil then
				buildIDofOld=buildID	
				buildID=nil
			end	
			
			if buildID == nil and buildIDofOld ~= nil and Spring.ValidUnitID(buildIDofOld)==true then				
				Spring.SetUnitNoDraw(buildIDofOld,false)
				hideT(Eggtable)
				Move(eggrotate,y_axis,0,0)
				buildIDofOld=nil
				
			end		
		end
			Sleep(120)
	end
	boolBuilding=false
end




--Killed
function script.QueryBuildInfo() 
	tempDeci=math.max((deCidere+2)%5,1)
	Show(Eggtable[1])
	return (Eggtable[1])
	
end


Spring.SetUnitNanoPieces(unitID,{ eggs})

function bobbingEggs()

	while(true) do

		for i=1,table.getn(eggnok),1 do
		if math.random(0,2)==1 then
		turnPieceRandDir(eggnok[i],5,42,-42,42,-42,42,-42)
		end
		end
		naptime=math.floor(math.random(1400,2800))
		Sleep(naptime)		
	end
	
end


function script.Activate ( )
	
	
	
	SetUnitValue(COB.YARD_OPEN, 1)
	SetUnitValue(COB.INBUILDSTANCE, 1)
	SetUnitValue(COB.BUGGER_OFF, 1)
	
	return 1
end


function script.Deactivate ( )
	
	
	
	
	
	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	SetUnitValue(COB.BUGGER_OFF, 0)
	return 0
end




function script.StartBuilding()	
	
end

function script.StopBuilding()
	
	
end

function script.Create()
	
	
	hideT(Eggtable)	
	Move(center,y_axis,-30,8.7)
	
	
	StartThread(workInProgress)
	StartThread(bobbingEggs)
end