include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

local SIG_STOP=2
local SIG_PROJ=4
local SIG_SNAKE =8
local SIG_ACCELERATOR= 16
local SIG_MOVE=32
ReloadTime=22000

--This function is called whenever the unit is damaged
function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	return damage 
end

center=piece"center"
ProjPlace=piece"ProjPlace"


ProjStage={}
for i=1,10 do
	
	name="ProjStage"..(i-1)
	ProjStage[i]=piece(name)
end

aimpiece=ProjStage[9]
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
	stopSpinT(locT,y_axis,0)
	stopSpinT(locM,y_axis,0)
	stopSpinT(locPtW,y_axis,0)
	stopSpinT(pieceTable,y_axis,0)
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
	recReseT(TablesOfPiecesGroups)
	
	--pieces Intialization finnished
	
	getOrgPos()
	hideT(ProjStage)	
	hideGlowPieces()
	-- i wanted to become a god, for that they made me a gamedev
	StartThread(walkAnimation)	
	StartThread(armedAndDangerous)	
end




function acceleratorAnimation()
Signal(SIG_ACCELERATOR)
SetSignalMask(SIG_ACCELERATOR)
	Sleep(500)

	resetAllUnitPieces(82.5)

	WaitForTurns(pieceTable)
	WaitForTurns(locPtW)
	WaitForTurns(locM)
	WaitForTurns(locT)
	WaitForMoves(locPtW)
	WaitForMoves(locT)
	WaitForMoves(locM)
	
	--direction up or down
	Sign= randSign()
	
	
	i=1
	for j=1,6, 1 do
		
		distanceOut= 16*j
		distanceDown= Sign*15*(7-j)
		
		for i=math.min(33,2^(j-1)), math.min(33,2^j),1 do	
			MovePieceToPiece(locT[i],center, 22,{x=0,y=distanceDown,z=0})	
			
			
			Move(locM[i],x_axis,distanceOut, 9)
			
			--Turn in Circle Direction
			valueToTurnTowards=(720/(2^j))*(math.min(33,2^j)-i)
			WTurn(locT[i],y_axis,math.rad(valueToTurnTowards),37)
		end
		
	end
	if boolMoving == true then return end
	WaitForMoves(locT)
	WaitForMoves(locM)
	
		for j=1,6, 1 do
		
		speed=math.random(5,52)
		for i=2^(j-1), 2^j,1 do	
			if locT[i] then
				value=speed* ((-1)^j)
				Spin(locT[i],y_axis,math.rad(value),0)
			end
			
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

function endAcceleratorAnimation()
	
	resetAllUnitPieces(40)
end

function snakeAnimation	(time_frame)
	Signal(SIG_SNAKE)
	SetSignalMask(SIG_SNAKE)
	while boolMoving== true do
		
		frame=Spring.GetGameFrame()
		time_frame= ((startframe - frame) % 150) /150
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
		Sleep(100	)
	end	
end

boolArmed=false
function walkAnimation()
	startframe=Spring.GetGameFrame()
	while true do
		
		
		if boolMoving == true then
		
			resetLoadedState()	
			resetAllUnitPieces(120)
			
				frame=Spring.GetGameFrame()
				time_frame= ((startframe - frame) % 150) /150
				StartThread(snakeAnimation,time_frame)		
				while boolMoving== true do
					Sleep(100)
				end
				Signal(SIG_SNAKE)

		end
		
		if boolMoving == false then 
			StartThread(acceleratorAnimation)
			boolArmed=true
				while boolMoving == false do
				Sleep(100)
				end
				Signal(SIG_ACCELERATOR)
				boolArmed=false
				endAcceleratorAnimation()
			
		end
		Sleep(100)	
	end
	
end

boolReloaded=false
reloadCounter=ReloadTime
function resetLoadedState()
	Signal(SIG_PROJ)
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
	
	return boolReloaded
	
end


function script.FireWeapon1()	
	resetLoadedState()
	return true
end

boolMoving=false
function delayedMove()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	Sleep(1000)

	boolMoving=true	

end

function script.StartMoving()
	StartThread(delayedMove)	
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