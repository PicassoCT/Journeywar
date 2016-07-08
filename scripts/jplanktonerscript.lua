include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

local SIG_STOP=2
local SIG_PROJ=4
ReloadTime=22000

--This function is called whenever the unit is damaged
function script.HitByWeapon ( x, z, weaponDefID, damage ) 
return damage 
end

center=piece"center"
ProjPlace=piece"ProjPlace"
aimpiece=ProjPlace

ProjStage={}
for i=1,10 do
	
	name="ProjStage"..(i-1)
	ProjStage[i]=piece(name)
end


--function displays the Animated Projectile
function projAnimLoop()
	Signal(SIG_PROJ)
	SetSignalMask(SIG_PROJ)
	hideT(ProjStage)
	WMove(ProjPlace,y_axis,-20,20)
	Show(ProjStage[1])
	while true do
		WMove(ProjPlace,y_axis,0,10)
		for i=1,10 do
			if ProjStage[i-1] then Hide(ProjStage[i-1]) end
			Show(ProjStage[i])
			Sleep(150)
		end
		
		hideT(ProjStage)
		for i=10,1,-1 do
			if ProjStage[i+1] then Hide(ProjStage[i+1]) end
			Show(ProjStage[i])
			Sleep(150)
		end
		
	end
end

--Table of Local Turning Points for Snake segments
locT={}
--Table of Local Movement Points for Snake Segments
locM={}
--Table of Pieces of the Snake
pieceTable={}
--Table of WingPieces
locPtW={}

--display the diffrently textured glow pieces
function showGlowPieces()
	
	hideT(pieceTable)
	hideT(locPtW)
	showT(pieceTable,34,66)
	showT(locPtW,15,28)
	
	
end
--hide the diffrently textured glow pieces
function hideGlowPieces()
	hideT(pieceTable)
	hideT(locPtW)
	showT(pieceTable,1,33)
	showT(locPtW,1,14)
	
	
end
--resets all the Pieces involved in the Units Animation (visible and invisible)
function resetAllUnitPieces(speed)
	resetT(locT,speed)
	resetT(locM,speed)
	resetT(locPtW,speed)
	resetT(pieceTable,speed)
end

function script.Create()
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	locT=TablesOfPiecesGroups["locT"]
	locM=TablesOfPiecesGroups["locM"]
	pieceTable=TablesOfPiecesGroups["pT"]
	locPtW=TablesOfPiecesGroups["pTw"]
	resetAllUnitPieces(0) --instantanious reset
	
	--pieces Intialization finnished

	getOrgPos()
	hideT(ProjStage)	
	hideGlowPieces()
	-- i wanted to become a god, for that they made me a gamedev
	StartThread(walkAnimation)	
	StartThread(armedAndDangerous)	
end

function prepAcceleratorAnimation()

	resetAllUnitPieces(22.5)
	WaitForTurns(locT)
	WaitForMoves(locT)
	
	k=1
	for j=1,6, 1 do
		kCopy=k
		distanceOut= 16*j
		distanceDown= -15*(7-j)
		for i=k, math.min(33,2^j),1 do			
				MovePieceToPiece(locT[i],center, 32,{x=0,y=distanceDown,z=0})
				Move(locM[i],x_axis,distanceOut, 9)
				valueToTurnTowards=(780/(2^j))*(i-kCopy)

				WTurn(locT[i],y_axis,math.rad(valueToTurnTowards),37)
			
			k=i
		end
	end
	WaitForMoves(locM)

end



function acceleratorAnimation()

	k=1
	for j=1,6, 1 do
		
		speed=math.random(5,52)
		for i=k, 2^j,1 do	
			if locT[i] then
				value=speed* ((-1)^j)
				Spin(locT[i],y_axis,math.rad(value),0)
			end
			k=i
		end
	end
end

locTorgPos={}
function getOrgPos()
	for i=1, #locT,1 do
		locTorgPos[i]={}	
		locTorgPos[i].x,locTorgPos[i].y,locTorgPos[i].z =Spring.GetUnitPiecePosition(unitID,pieceTable[i])
	end
	
end

function endAcceleratorAnimation	()
	for i=1, #locT,1 do
		StopSpin(locT[i],y_axis)
	end
	resetAllUnitPieces(40)
end

function snakeAnimation	(time_frame)
	centerPoint={}
	centerPoint.x,centerPoint.y,centerPoint.z= Spring.GetUnitPiecePosition(unitID,locT[1])
	xMax=65
	yMax=5
	
	for i=1, #locT,1 do
		timePerPiece= ((1/#locT)*i +time_frame % 1.0)
		timePerPiece= (timePerPiece*2)-1
		MovePieceToPos(locT[i],locTorgPos[i].x +(xMax*math.sin(timePerPiece*math.pi)) ,0, 0 ,12)
		Turn(locT[i],y_axis, math.cos(timePerPiece*math.pi),0.42)
	end
	--this might take exactly so long that the animation never plays
	WaitForTurns(locT)
	
end

boolArmed=false
function walkAnimation()
	startframe=Spring.GetGameFrame()
	while true do
		
		
		if boolMoving == true then
			resetLoadedState()
		if boolMoving == true then	
			while boolMoving== true do
				
				frame=Spring.GetGameFrame()
				time_frame= ((startframe - frame) % 150) /150
				snakeAnimation(time_frame)
				Sleep(100	)
			end
		end
		end
		
		if boolMoving == false then 
		Spring.Echo("prepAcceleratorAnimation")
			prepAcceleratorAnimation()
		if boolMoving == false then 			
			while boolMoving == false do
				acceleratorAnimation()
				Sleep(100)
				boolArmed=true
			end
			boolArmed=false
						Spring.Echo("endAcceleratorAnimation")
			endAcceleratorAnimation()
		end
		end
		Sleep(100)	
	end
	
end

boolReloaded=false
reloadCounter=ReloadTime
function resetLoadedState()
	Signal(SIG_PROJ)
	resetAllUnitPieces(60)
	hideT(ProjStage)
	hideGlowPieces()
	reloadCounter=ReloadTime
	boolReloaded=false
end

function armedAndDangerous()
	while true do
		if boolArmed ==true and boolReloaded== false then
			StartThread(projAnimLoop)
			boolReloaded=true
		end
		Sleep(100)
		if reloadCounter > 0 and boolMoving == false then reloadCounter = reloadCounter -100 end
		if boolReloaded== false and reloadCounter <= 0 then
			boolReloaded= true 
			showGlowPieces()
		end
		
	end
	
end

function script.Killed(recentDamage,_)
	
	suddenDeathV(recentDamage)
	return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end



function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
	
end


function script.FireWeapon1()	
	
	return true
end

boolMoving=false


function script.StartMoving()
	boolMoving=true	
end



function delayedStop()
	Signal(SIG_STOP)
	SetSignalMask(SIG_STOP)
	Sleep(500)
	boolMoving=false	
end


function script.StopMoving()
	StartThread(delayedStop)	
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end

function script.QueryBuildInfo() 
	return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})