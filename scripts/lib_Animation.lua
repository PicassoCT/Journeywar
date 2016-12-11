
--[[
This library is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA.

]]--

--================================================================================================================
-- Animation Functions
--================================================================================================================
-->CombinedWaitForMove
function WMove(lib_piece,lib_axis,lib_distance,lib_speed)
	Move(lib_piece,lib_axis,lib_distance,lib_speed)
	WaitForMove(lib_piece,lib_axis)
end

-->CombinedWaitTurn
function WTurn(lib_piece,lib_axis,lib_distance,lib_speed)
	Turn(lib_piece,lib_axis,lib_distance,lib_speed)
	WaitForTurn(lib_piece,lib_axis)
end

-->Waits for anyTurnToComplete
function WaitForTurns(...)
	   local arg = arg ;  if (not arg) then arg = {...}; arg.n = #arg end
	
	local arg={...}
	if not arg then
		return 
	end
	
	typeArg=type(arg)
	
	if typeArg == "table" then
		
		for k,v in pairs(arg) do
			if type(v)=="number" then
				WaitForTurn(v,x_axis)
				WaitForTurn(v,y_axis)
				WaitForTurn(v,z_axis)
			end
		end
		return 
	elseif typeArg == "number" then
		WaitForTurn(arg,x_axis)
		WaitForTurn(arg,y_axis)
		WaitForTurn(arg,z_axis)
	end
end

-->Waits for anyTurnToComplete
function WaitForMoves(...)
	   local arg = arg ;  if (not arg) then arg = {...}; arg.n = #arg end
	
	local arg={...}
	if not arg then
		return 
	end
	
	typeArg=type(arg)
	
	if typeArg == "table" then
		
		for k,v in pairs(arg) do
			if type(v)=="number" then
			
				WaitForMove(v,x_axis)
			
				WaitForMove(v,y_axis)
			
				WaitForMove(v,z_axis)

			
			end
		end
		return 
	elseif typeArg == "number" then
		WaitForMove(arg,x_axis)
		WaitForMove(arg,y_axis)
		WaitForMove(arg,z_axis)
	
	end
end

-->Turn a piece towards a random direction
function turnPieceRandDir(piecename,speed, LIMUPX,LIMLOWX,LIMUPY,LIMLOWY,LIMUPZ,LIMLOWZ)
	if not LIMUPX then
		Turn(piecename,x_axis,math.rad(math.random(-360,360)),speed)
		Turn(piecename,y_axis,math.rad(math.random(-360,360)),speed)
		Turn(piecename,z_axis,math.rad(math.random(-360,360)),speed)
	else

		Turn(piecename,x_axis,math.rad(math.random(LIMLOWX,LIMUPX)),speed)
		Turn(piecename,y_axis,math.rad(math.random(LIMLOWY,LIMUPY)),speed)
		Turn(piecename,z_axis,math.rad(math.random(LIMLOWZ,LIMUPZ)),speed)
	end
end

-->Move a piece towards a random direction
function movePieceRandDir(piecename,speed, LIMUPX,LIMLOWX,LIMUPY,LIMLOWY,LIMUPZ,LIMLOWZ)
	if not LIMUPX then
		return
	else
		Move(piecename,x_axis,math.rad(math.random(LIMLOWX,LIMUPX)),speed)
		Move(piecename,y_axis,math.rad(math.random(LIMLOWY,LIMUPY)),speed)
		Move(piecename,z_axis,math.rad(math.random(LIMLOWZ,LIMUPZ)),speed)
	end
end

-->generic AmphibMovementThread: Threaded Creates with the given pieces and animations a Unit that auto changes its animation
-- between land and water
function AmphibMoveThread(unitid
	,PivotPoints
	,pieces
	,updateCycle
	,moveRatio
	,nlswimAnimation
	,nlstopSwimAnimation
	,nloutOfWaterAnimation
	,nlbackIntoWaterAnimation
	,nlwalkAnimation
	,nlstopWalkAnimation)
	
	local swimAnimation =nlswimAnimation 
	local stopSwimAnimation =nlstopSwimAnimation
	local outOfWaterAnimation =nloutOfWaterAnimation
	local backIntoWaterAnimation =nlbackIntoWaterAnimation
	local walkAnimation =nlwalkAnimation
	local stopWalkAnimation		 =nlstopWalkAnimation								
	local spGetUnitPosition =	Spring.GetUnitPosition
	
	boolInWater= function ()
		x,y,z=spGetUnitPosition(unitID)
		h=Spring.GetGroundHeight(x,z)
		if h > 0 then return false else return true end
	end
	
	boolMoving= function (ox,oy,oz)
		x,y,z=spGetUnitPosition(unitID)
		return math.abs(ox-x)+math.abs(oz-z)+math.abs(oy-y) > 0
	end
	
	
	while true do
		while boolInWater()==true do
			ox,oy,oz=spGetUnitPosition(unitID)
			Sleep(math.floor(updateCycle/2))
			if boolMoving(ox,oy,oz)==true then
				swimAnimation(PivotPoints,pieces)
			else 
				Sleep(math.floor(updateCycle/2))
				stopSwimAnimation(PivotPoints,pieces)
			end
			Sleep(math.ceil(updateCycle/2))
			
		end
		
		outOfWaterAnimation(PivotPoints,pieces)
		while boolInWater()==false do
			ox,oy,oz=spGetUnitPosition(unitID)
			Sleep(math.floor(updateCycle/2))
			if boolMoving(ox,oy,oz)==true then
				walkAnimation(PivotPoints,pieces)
			else 
				Sleep(math.floor(updateCycle/2))
				stopWalkAnimation(PivotPoints,pieces)
			end
			Sleep(math.ceil(updateCycle/2))
		end
		backIntoWaterAnimation(PivotPoints,pieces)
		Sleep(50)
	end
	
end	

-->Executes a function every n-times during a move
function whileMovingDo(PIECE,axis, times, fuoonction)
totalTime=0
	while  (true==Spring.UnitScript.IsInMove (PIECE, axis) ) do
	fuoonction(totalTime)
	Sleep(times)
	totalTime=totalTime + times
	end
end


-->Reset a Piece at speed
function reset(piecename,lspeed,boolWaitForIT)
	if not piecename then return end
	speed= lspeed or 0 
	
	Turn(piecename,x_axis,0,speed)
	Turn(piecename,y_axis,0,speed)
	Turn(piecename,z_axis,0,speed)
	
	Move(piecename,x_axis,0,speed)
	Move(piecename,y_axis,0,speed)
	Move(piecename,z_axis,0,speed,true)
	if boolWaitForIT and boolWaitForIT==true then 
		WaitForTurn(piecename,1)
		WaitForTurn(piecename,2)
		WaitForTurn(piecename,3)
	end
	
	
	
end

-->counterturns a piece pair
function equiTurn(p1,p2,axis,deg,speed)
	Turn(p1,axis,math.rad(deg),speed)
	Turn(p2,axis,math.rad(-1*deg),speed)
end

--> Turns a piece in all 3 axis and waits for it
function tP(piecename,x_val,y_val,z_val,speed, boolWaitForIT)
if piecename == nil then echo("libAnimation::tP got nil piece ".. x_val,y_val) end
	Turn(piecename,x_axis,math.rad(x_val),speed)
	Turn(piecename,y_axis,math.rad(y_val),speed)
	Turn(piecename,z_axis,math.rad(z_val),speed)
	if boolWaitForIT then 
		WaitForTurn(piecename,x_axis)
		WaitForTurn(piecename,y_axis)
		WaitForTurn(piecename,z_axis)
	end
end

-->Turns a piece with radiants
function tPrad(piecename,xval,yval,zval,speed)

	Turn(piecename,1,xval,speed)
	Turn(piecename,2,yval,speed)
	Turn(piecename,3,zval,speed)
end

--> synTurns a Piece to arrive at times on all axis
function syncTurn(unitID,piecename,x_val,y_val,z_val,speed)
	speed=math.max(speed,0.0001)
	maxv=math.max(math.abs(x_val),math.max(math.abs(z_val),math.abs(y_val)))
	if maxv== 0 then
		x_deg,y_deg,z_deg=Spring.GetUnitPieceDirection(unitID,piecename)
		turnSyncInSpeed(piecename,x_val,y_val,z_val,speed,x_deg,y_deg,z_deg)
		return
	end
	times=math.abs(maxv/speed)
	
	Turn(piecename,x_axis,math.rad(x_val),(times/x_val)*speed)
	Turn(piecename,y_axis,math.rad(y_val),(times/y_val)*speed)
	Turn(piecename,z_axis,math.rad(z_val),(times/z_val)*speed)
	
end

-----------------------------------------
-->turns a Piece syncInTime working with a Table of Move Commands
function turnSyncInTimeT(Table, times,x_deg,y_deg,z_deg)
	
	for piece,v in pairs(Table) do

		turnInTime(v.piecenr, v.axis,math.rad(v.deg), times, x_deg,y_deg,z_deg,false)
	end
	
end


-->Turns a Piece on all given axis, snychronously
function turnSyncInSpeed(piecename,x,y,z,speed,x_deg,y_deg,z_deg)
	if not piecename then return end
	if speed ==0 then
		tP(piecename,x,y,z,speed)
		return
	end
	
	
	tx=	absoluteRotation(piecename,x_axis,x,x_deg,y_deg,z_deg)+0.01
	ty=	absoluteRotation(piecename,y_axis,y,x_deg,y_deg,z_deg)+0.01
	tz=	absoluteRotation(piecename,z_axis,z,x_deg,y_deg,z_deg)+0.01
	
	xtime=math.abs(tx)/speed
	ytime=math.abs(ty)/speed
	ztime=math.abs(tz)/speed
	maxtime=math.max(xtime,math.max(ytime,ztime))
	if maxtime== 0 then maxtime=0.1 end
	
	Turn(piecename,x_axis,math.rad(x),(xtime/maxtime)*speed)
	Turn(piecename,y_axis,math.rad(y),(ytime/maxtime)*speed)
	Turn(piecename,z_axis,math.rad(z),(ztime/maxtime)*speed)
	
end


-->Turns a piece in the speed necessary to arrive after x Milliseconds - overrirdes the spring shortes path turns
function turnInTime(piecename,taxis,degree,timeInMs,x_deg,y_deg,z_deg, boolWait )
	assert(z_deg)
	
	--Gets the absolute Biggest Rotation
	absoluteDeg=absoluteRotation(piecename,taxis,degree,x_deg,y_deg,z_deg)
	
	timeInMs=(timeInMs+1)/1000
	Speed=(math.abs(math.rad(absoluteDeg))/math.pi) /(math.abs(timeInMs))--9.3
	
	if absoluteDeg < 0.0001 then return end
	
	if lib_boolDebug==true then
		--Spring.Echo(" TurnInTime for"..piecename.." Speed:"..Speed)
		--Spring.Echo("to reach Degree:"..degree.."with abs deg to go:"..absoluteDeg.. " in times "..timeInMs.. " seconds"	)
	end
	

	if absoluteDeg <= 180 then
		
		Turn(piecename,taxis,math.rad(degree),Speed)
		
		if boolWait and boolWait==true then WaitForTurn(piecename,taxis) end
		
	else
		OverTurnDirection(piecename,taxis,degree,Speed)
		if boolWait and boolWait==true then Sleep(10); WaitForTurn(piecename,taxis) end
	end	
end

-->Turns along a direction, ignoring the spring shortest way implementation
function OverTurnDirection(piecename,axis, degree,speed)
	x_deg,y_deg,z_deg= Spring.GetPieceRotation(piecename)
	
	curdeg=0;
	if axis==x_axis then
		curdeg=x_deg 
	elseif axis== y_axis then 
		curdeg=y_deg 
	else curdeg= z_deg 
	end
	curdeg=math.rad(curdeg)
	
	dir =1
	
	if curdeg+360 < degree+360 then 
		dir =-1 
	end
	
	Turn(piecename,axis,math.rad(curdeg +179*dir),speed)
	WaitForTurn(piecename,axis) 
	Turn(piecename,axis,math.rad(degree),Speed)
	WaitForTurn(piecename,axis) 
	
	
end

function tSyncIn(piecename,x_val,y_val,z_val,times, UnitScript)
x_deg,y_deg,z_deg= UnitScript.GetPieceRotation(piecename)
syncTurnInTime(piecename,x_val,y_val,z_val,times,x_deg,y_deg,z_deg)
end

-->Turns a piece on every axis in times 
function syncTurnInTime(piecename,x_val,y_val,z_val,times,x_deg,y_deg,z_deg)
	if lib_boolDebug==true then
		--Spring.Echo("times for syncTurnInTime:"..times)
	end

	turnInTime(piecename,1, (x_val),times,x_deg,y_deg,z_deg,false) -- -28 3000
	turnInTime(piecename,2, (y_val),times,x_deg,y_deg,z_deg,false)
	turnInTime(piecename,3, (z_val),times,x_deg,y_deg,z_deg,false)
	
end
--> Move a piece so that it arrives at  all axis on the given times
function syncMoveInTime(piecename,x_val,y_val,z_val,times)	
	times=times/1000
	--ratio = 1/(val/max)*times => max*times / val
	Move(piecename,1,x_val,math.abs(x_val/times))
	Move(piecename,2,y_val,math.abs(y_val/times))
	Move(piecename,3,z_val,math.abs(z_val/times))
	
end

--> Move a piece so that it arrives at the same times on all axis
function syncMove(piecename,x_val,y_val,z_val,speed)
	max=math.max(math.abs(x_val),math.max(math.abs(z_val),math.abs(y_val)))
	times=math.abs(max/speed)
	--ratio = 1/(val/max)*times => max*times / val
	Move(piecename,x_axis,(x_val),(max*times/x_val)*speed)
	Move(piecename,y_axis,(y_val),(max*times/y_val)*speed)
	Move(piecename,z_axis,(z_val),(max*times/z_val)*speed)
	
end


-->Turns a piece in wind direction with offset
function TurnTowardsWind(piecename,speed,offset)
	offSet=offset or 0
	dx,dy,dz=Spring.GetWind()
	headRad=math.atan2(dx,dz)
	Turn(piecename,y_axis,headRad+offSet,speed)
	return headRad
end

-->Spins a Table
function spinT(Table, axis,speed,rdeg, degup)
	if not degup then
		for k,v in pairs(Table) do
			if v then
			Spin(v,axis,math.rad(rdeg),speed)
			end
		end
	else
		for k,v in pairs(Table) do
			if v then
			Spin(v,axis,math.rad(math.random(rdeg,degup)),speed)
			end
		end
	end
	
end
--> Stops Spinning Table
function stopSpinT(Table,axis, speed)
	for i=1,#Table do
		StopSpin(Table[i],axis,speed)
	end
	
end

-->Moves a UnitPiece to Position in Unitspace at speed
function MovePieceToPos(piecename, X,Y,Z,speed)
	
	Move(piecename,x_axis,X,speed)
	Move(piecename,y_axis,Y,speed)
	Move(piecename,z_axis,Z,speed,true)	
	
end

	-->Helperfunction of recursiveAddTable -> builds a bonesubsystem
	function buildBone(parent ,piecetable)
	
		PieceInfo =Spring.GetUnitPieceInfo(unitID,parent)
		children= tableToKeyTable(PieceInfo.children)
		
	SubBoneTables={}
	if children then
		for key, piecenumber in pairs(piecetable) do			
			
			if children[key] then
			SubSubBoneTable={}
			SubSubBoneTable=buildBone(key, piecetable)
			SubBoneTables[key]=SubSubBoneTable
			end
		
		end
	end
	
	return SubBoneTables
	end
	-->function traverses a bonetable, getting all elements in depth Steps
	function getElementsNStepsDown(Steps, Value)
	if Steps == 0 then return Value end
	
		if Steps > 0 and type(Value) == "table" then
		Tables={}
			for i=1, #Value do
			foundIt= getElementsNStepsDown(Steps-1,Value[i])
				if foundIt then
					table.insert(Tables,foundIt)	
				end
			end
		return Tables
		end	
	end
	
	--Dictionary of pieces --> with accumulated Weight in every Node
	--> Every Node also holds a bendLimits which defaults to ux=-45 x=45, uy=-180 y=180,uz=-45 z=45
	function buildSkeleton(rootpiecename,keyPieceNrtable)
	
	Bones={}
	SubPieces={}
		for key, piecenumber in pairs(keyPieceNrtable) do
			--not rootpiece and 		
			PieceInfo =Spring.GetUnitPieceInfo(unitID,key)
			parent= PieceInfo.parent	
		
			if parent and parent == rootpiecename then
				SubPieces[key] = {}
			end
		end
		
		Bones[rootpiecename] = SubPieces
		
		for key,v in pairs(Bones[rootpiecename]) do
		subBoneTables= buildBone(key, keyPieceNrtable)	
			if subBoneTables then
			table.insert(Bones[rootpiecename][key],	subBoneTables)
			end	
		end	
	
	end
	
-->Moves a UnitPiece to a UnitPiece at speed
function AlignPieceToPiece( pieceToAlign, PieceToAlignTo,speed, boolWaitForIt,boolDebug, GlowPoints)
	
	if not pieceToAlign or not PieceToAlignTo then return end
	
	--We use existing function to move the piece to the other pieces center
	MovePieceToPiece(pieceToAlign,PieceToAlignTo,0)
	
	WaitForMove(pieceToAlign,x_axis)
	WaitForMove(pieceToAlign,y_axis)
	WaitForMove(pieceToAlign,z_axis)	
	
	--Get the Data of the Piece we want to align to
	_,_,_,vx,vy,vz=Spring.GetUnitPiecePosDir(unitID,PieceToAlignTo)
	norm=distance(vx,vy,vz)+0.00001
	
	vx=vx/norm
	vy=vy/norm
	vz=vz/norm
	-----------------------------------------------------------------
	
	OrientVec={x=vy*-1,
		y=vx,
		z=0}

	DirectionV={x=vx,y=vy,z=vz}

	assert(OrientVec)
	assert(DirectionV)
	assert(type(OrientVec)=="table")
	assert(type(DirectionV)=="table")
	assert(OrientVec.x)
	assert(DirectionV.x)
	OrientUpVec=mulVector(OrientVec,DirectionV)
	
	UpVec = {x=0,y=1,z=0}
	assert(OrientUpVec)
	assert(UpVec)
	
	angleX= math.atan2(VDotProduct(OrientVec,UpVec), 	VDotProduct(OrientUpVec,UpVec)/ Vabs(OrientVec) * Vabs(OrientUpVec))
	
	--Turn the Piece to the Vector of the PieceToAlignTo
	Turn(pieceToAlign,x_axis,angleX,speed)
	Turn(pieceToAlign,y_axis,math.atan2(vy,vx),speed)
	Turn(pieceToAlign,z_axis,math.asin(vz),speed,true)
	
	if not boolWaitForIt or boolWaitForIt == true then
		WaitForTurn(pieceToAlign,x_axis)
		WaitForTurn(pieceToAlign,y_axis)
		WaitForTurn(pieceToAlign,z_axis)
	end
	
	if boolDebug and boolDebug==true then
		debugDisplayPieceChain(GlowPoints)
	end
	
end
function sigN(num)
if num < 0 then return -1 end
return 1
end

function echoMove(name, x,y,z)
Spring.Echo("Moving Piece "..name.." to x:"..x.." ,y:"..y.." , z:"..z)
end
-->Moves a UnitPiece to a UnitPiece at speed
function MovePieceToPieceAlt(piecename, pieceDest,speed,offset,forceUpdate)

	if not pieceDest or not piecename then return end	
	
	ox,oy,oz=Spring.GetUnitPiecePosition(unitID,pieceDest)
	orx,ory,orz=Spring.GetUnitPiecePosition(unitID,piecename)
	
	dirSignX,dirSignY,dirSignZ= 1, 1 ,1 
	dirValX,dirValY,dirValZ= 1, 1 ,1 
	
	if sigN(ox) < sigN(orx) then dirSignX= -1 end
	if sigN(oy) < sigN(ory) then dirSignY= -1 end
	if sigN(oz) < sigN(orz) then dirSignZ= -1 end
	
	if sigN(ox) == sigN(orx) then
		ox= math.abs(ox- orx)*dirSignX
	else
		ox= (math.abs(ox) + math.abs(orx))*dirSignX
	end
	
	if sigN(oy) == sigN(ory) then
		oy= math.abs(oy- ory)*dirSignY
	else
		oy= (math.abs(oy) + math.abs(ory))*dirSignY
	end
	
	if sigN(oz) == sigN(orz) then
		oz= math.abs(oz- orz)*dirSignZ
	else
		oz= (math.abs(oz) + math.abs(orz))*dirSignZ
	end

	

	ox=ox*-1
	if offset then		
		ox= ox +(offset.x)
		oy= oy +offset.y
		oz= oz +offset.z
	end	
	
--	echoMove(piecename, ox,oy,oz)
	Move(piecename,x_axis,ox,0)
	Move(piecename,y_axis,oy,0)
	Move(piecename,z_axis,oz,0,forceUpdate or true)
	
	
	WaitForMove(piecename,x_axis); WaitForMove(piecename,z_axis); WaitForMove(piecename,y_axis);
	
	
	
end
-->Moves a UnitPiece to a UnitPiece at speed
function MovePieceToPiece(piecename, pieceDest,speed,offset,forceUpdate)

	if not pieceDest or not piecename then return end	
	
	ox,oy,oz=Spring.GetUnitPiecePosition(unitID,pieceDest)
	orx,ory,orz=Spring.GetUnitPiecePosition(unitID,piecename)
	
	ox,oy,oz = ox -	orx,oy - ory,oz - orz
	

	ox=ox*-1
	if offset then		
		ox= ox +(offset.x)
		oy= oy +offset.y
		oz= oz +offset.z
	end	
	
--	echoMove(piecename, ox,oy,oz)
	Move(piecename,x_axis,ox,0)
	Move(piecename,y_axis,oy,0)
	Move(piecename,z_axis,oz,0,forceUpdate or true)
	
	
	WaitForMove(piecename,x_axis); WaitForMove(piecename,z_axis); WaitForMove(piecename,y_axis);
	
	
	
end
-->Moves a Piece to a Position on the Ground in UnitSpace
function MoveUnitPieceToGroundPos(unitID,piecename, X,Z,speed,offset)
	if not piecename then return error("No piecename given") end
	if not X or not Z then return end
	loffset=offset or 0
	x,globalHeightUnit,z=Spring.GetUnitPosition(unitID)
	Move(piecename,x_axis,X,0)
	Move(piecename,z_axis,Z,0,true)	
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piecename)
	if not x then return end
	myHeight=Spring.GetGroundHeight(x,z)
	heightdifference=math.abs(globalHeightUnit-myHeight)
	if myHeight < globalHeightUnit then heightdifference=-heightdifference end
	Move(piecename,y_axis,heightdifference+loffset,speed,true)
end

-->Moves a Piece to WaterLevel on the Ground in UnitSpace
function KeepPieceAfloat(unitID,piecename,speed,offset)
	if not piecename then return error("No piecename given") end
	loffset=offset or 0
	x,globalHeightUnit,z=Spring.GetUnitPosition(unitID)
	
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piecename)
	myHeight=0
	heightdifference=math.abs(globalHeightUnit-myHeight)
	if myHeight < globalHeightUnit then heightdifference=-heightdifference end
	Move(piecename,y_axis,heightdifference+loffset,speed,true)
end

-->Paint a Piece Pattern 
function PaintPatternPieces(ListOfPieces, ListOfCoords,sx,sy,sz)
	prevx,prevy,prevz=sx,sy,sz
	
	
	MovePieceToPos(ListOfPieces[1],ListOfCoords[1].x,ListOfCoords[1].y,ListOfCoords[i].z)
	TurnPieceTowards(ListOfPieces[1],sx,sy,sz,0)
	prevx,prevy,prevz=ListOfCoords[1].x,ListOfCoords[1].y,ListOfCoords[i].z
	
	
	for i=2,#ListOfCoords-1 do
		MovePieceToPos(ListOfPieces[i],ListOfCoords[i].x,ListOfCoords[i].y,ListOfCoords[i].z)
		TurnPieceTowardsPiece(ListOfPieces[i],ListOfPieces[i-1],0)
	end
	
end

-->Moves a Piece to a Position on the Ground in Worldspace
function MoveUnitPieceToRelativeWorldPos(unitID,piecename, relX,relZ,speed,loffset)
	offset = loffset or 0
	x,globalHeightUnit,z=Spring.GetUnitPosition(unitID)
	x,z=relX-x,relZ-z
	Move(piecename,x_axis,x,0,true)
	Move(piecename,z_axis,z,0,true)	
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piecename)
	myHeight=Spring.GetGroundHeight(x,z)
	heightdifference=math.abs(globalHeightUnit-myHeight)
	if myHeight < globalHeightUnit then heightdifference=-heightdifference end
	Move(piecename,y_axis,heightdifference+ offset ,speed,true)
end

--> Move with a speed Curve
function moveSpeedCurve(piecename, axis, NumberOfArgs, now, timeTotal , distToGo, Offset,...)
	   local arg = arg ;  if (not arg) then arg = {...}; arg.n = #arg end
	--!TODO calcSpeedUpId from functionkeys,check calculations for repetitons and store that key in to often as result in GG
	--should handle all sort of equations of the type 0.3*x^2+0.1*x^1+offset
	-- in our case that would be [2]=0.3 ,[1]=0.1 and so forth
	
	ArgFactorTable={}
	NrCopy=NumberOfArgs
	for _, factor in pairs(arg) do
		ArgFactorTable[NrCopy]=factor	 
		NrCopy=NrCopy-1
	end
	
	--init tangent table
	tangentTable={n=#ArgFactorTable-1}
	
	
	--first derivative 
	--http://en.wikipedia.org/wiki/Derivative
	for i=table.getn(tangentTable), 1, -1 do
		tangentTable[i]=(i+1)*ArgFactorTable[i+1]
	end
	
	Totalspeed=Offset
	for i=1, NumberOfArgs-1 do
		Totalspeed=Totalspeed+tangentTable[i]*(now^i)
	end
	
	Move(piecename, axis, distToGo, Totalspeed)
end

--> Drops a piece to the ground
function DropPieceToGround(unitID,piecename,speed, boolWait,boolHide, ExplodeFunction,SFXCOMBO)
	x,y,z=Spring.GetUnitPiecePosition(unitID,piecename)
	MoveUnitPieceToGroundPos(unitID,piecename,x,z,speed, 5)
	
	if boolWait then WaitForMove(piecename,y_axis) end
	
	if boolHide then Hide(piecename) end	
	
	if ExplodeFunction then ExplodeFunction(piecename,SFXCOMBO) end
end

	
	-->Takes a List of Pieces forming a kinematik System and guides them through points on a Plane
		-- ListPiece={
		--ArmCenterOffset={ox = 0, oy=0, oz=0}
		--[1]={ 
			-- Piece = pieceName,			
			--CenterPoint - used for a Offset of the Arm to UnitCenter
				-- cX=0, 
				-- cY=0,
				-- cZ=0, 		
			--current setting allowed
			-- length of piece 
				-- lX = 25,
				-- lY = 25,
				-- lZ = 25,

			-- dirX,
			-- dirY,
			-- dirZ,
			--active axis
				-- ax =false, 
				-- ay=true,
				-- az=true, 
			-- lastPointIndex
			-- piecelength
			
		-- } --Active Axis for this piece
		
	-- }
	
	-- SnakePoint={ x,y,z -- Worldspace Coordinates
		-- vx,vy,vz --VoluminaCube
		
	-- }
	function snakeOnAPlane(unitID, cPceDescLst,FirstSensor, WindowDescriptorList, axis,speed ,tolerance, boolPartStepExecution, boolWait)
		local PceDescLst= cPceDescLst --Piece_Pos_Deg_Length_PointIndex_boolGateCrossed_List
		
		--early error out
		if not PceDescLst then echo("libAnimation::snakeOnAPlane - No Valid PieceCegTable"); return end
		if  WindowDescriptorList == nil then echo("libAnimation::snakeOnAPlane - No Valid Goals to move"); return end
	

	--Working Defaults
	
		--if not defined ArmCenter - define Arm as centered in UnitSpace
		if not PceDescLst.ArmCenterOffset then PceDescLst.ArmCenterOffset ={ox=0, oy = 0, oz = 0} end
		
		for iNumerated,arm in ipairs(PceDescLst) do
		--TODO
		end
		--total Length arm
		--Preparations and Default Initialisations
		for iNumerated,arm in ipairs(PceDescLst) do

			if not arm.Piece then echo("libAnimation::snakeOnAPlane - No Valid Piece in Arm"); return end
			
			armTcX, armTcY, armTcZ, armTdX,armTdY,armTdZ =Spring.GetUnitPiecePosDir(unitID, arm.Piece)
			--initialise the arm direction
			if not arm.cx then 		arm.cX, arm.cY, arm.cZ = armTcX, armTcY, armTcZ;	end
			if not arm.dirX then 	arm.dirX, arm.dirY, arm.dirZ = armTdX,armTdY,armTdZ;	end
			
			--length of the piece
			successorPiece= FirstSensor
			if PceDescLst[iNumerated+1] and PceDescLst[iNumerated+1].Piece then successorPiece = PceDescLst[iNumerated+1].Piece  end
			
			sucTcX, sucTcY, sucTcZ = Spring.GetUnitPiecePosDir(unitID, successorPiece)
			
			--default arm length per piece
			if not arm.lx then
			arm.lx,arm.ly,arm.lz = absDistance(armTcX,sucTcX), absDistance(armTcY,sucTcY), absDistance(armTcZ,sucTcZ)
			end
			
			--set default axis
			if not arm.ax then
				if  iNumerated ~= 1 then
				arm.ax, arm.ay, arm.az=true,false,false
				else
				arm.ax, arm.ay, arm.az=false,true,false
				end
			end
			
			if not arm.piecelength  then 
			if arm.ax==true then 	arm.piecelength = arm.lx end
			if arm.ay==true then 	arm.piecelength = arm.ly end
			if arm.ay==true then 	arm.piecelength = arm.lz end		

			end
			

			if not arm.lastPointIndex then arm.lastPointIndex = 0 end
		end
		
		--local copy of the ArmTable
		local ArmTable={}
		for i=1,#PceDescLst do ArmTable[i]=PceDescLst[i].Piece end
		
		--get StartPosition and Move First Piece Into the Cube
		boolResolved=false
		if not WindowDescriptorList then echo("snakeOnAPlane:: Not WindowDescriptorList delivered"); return end
		
		LastInsertedPoint=WindowDescriptorList[1]
		Sensor=FirstSensor
		
		vOrg={};
		vOrg.x,vOrg.y,vOrg.z=Spring.GetUnitPiecePosition(unitID,PceDescLst[#PceDescLst].Piece)
		echoT(PceDescLst)
		for i=1, #WindowDescriptorList do
		
		end
		--func
	
--Preparations Completed
		
		
		
		
			--Turn the axis towards the goal
		--getPointPlane(point, -degAroundAxis)
				
		TurnPieceTowardsPoint(cPceDescLst[1].Piece, vOrg.x,vOrg.y,vOrg.z,0.5)	
		WaitForTurns(cPceDescLst[1].Piece)
		
		
		while boolResolved==false do
			
			boolAlgoRun=false
			while boolAlgoRun ==false do
				hypoModel=PceDescLst
				GlobalIndex= #PceDescLst
				
				
				
				for Index= #PceDescLst, 1, -1 do
					
					local nextGoal=PceDescLst[Index].PointIndex
					x,y,z,dx,dy,dz=Spring.GetUnitPiecePosDir(unitID,PceDescLst[Index].Piece)
					
					local PieceStartPoint =makeVector(x,y,z)
					px,py,pz,pdx,pdy,pdz=Spring.GetUnitPiecePosDir(unitID,PceDescLst[math.min(Index+1,#PceDescLst)].Piece)
					local PieceEndPoint		 =makeVector(px,py,pz)
					
					ppx,ppy,ppz,ppdx,ppdy,ppdz=Spring.GetUnitPiecePosDir(unitID,PceDescLst[math.min(Index+1,#PceDescLst)].Piece)
					local PrevGatePoint		 =makeVector(ppx,ppy,ppz)
					
					
					--CheckCenterPastPoint_PointIndex 
					boolPastCenterPoint=checkCenterPastPoint( midVector(PieceStartPoint,PieceEndPoint),
					WindowDescriptorList[nextGoal],
					PrevGatePoint)
					
					-->if pointIndex is beyond Last Point this piece is far beyond 
					if nextGoal > #SnakePoint then 
						-- align yourself counterVectorwise from the last Point you crossed
						
					end
					
					-->True && boolGateCrossed =false
					if boolPastCenterPoint == true and PceDescLst[Index].boolGateCrossed ==false then
						
						--TurnPieceTowardstNextPoint(PrevPieceIndex) hypoModel
						--WaitForTurns(ArmTable)
						counterTurnDeg=0
						for BackTrackIndex= Index, #PceDescLst, 1 do
							--ReAlign Piece Goal
						end
						--
						PceDescLst[Index].boolGateCrossed = checkCenterPastPoint( midVector(PieceStartPoint,	PieceEndPoint),
						WindowDescriptorList[nextGoal],
						PrevGatePoint)
						
						if PceDescLst[Index].boolGateCrossed == true then
							PceDescLst[Index].PointIndex= PceDescLst[Index].PointIndex +1 
						end
						--boolGateCrossed=True 
						--IncPointIndex
						--CheckCenterPastPoint_PrevPiece() && boolGateCrossed != true
						--> True
						--Index =PrevPointIndex
						
						--SubIndex
						
						-->True && boolGateCrossed =true
					elseif boolPastCenterPoint == true and PceDescLst[Index].boolGateCrossed ==true then
						
						if boolPartStepExecution == true then 
							--Execute from top down to index, moves in order
							--+-boolWait
						else
							
						end
						--SubIndex
						
					elseif	boolPastCenterPoint == false	then
						-->False
						--TurnPieceTowardstPoint(PieceIndex) hypoModel
						--WaitForTurns(ArmTable)
						--CounterTurnPrevPiece hypoModel
					end
					
					
					if Index== 1 then boolAlgoRun=true; break end
				end
			end
			applyChangesAsTurns(PceDescLst)
			--WaitForTurns(ArmTable)
			boolResolved=isSnakeAtMax(PceDescLst)
		end
		--]]
	end
	
	function isSnakeAtMax(PceDescLst,SnakePoints)
		--if every point from the base point out is aligned towards its next goal
		for i=1, #PceDescLst do
			px,py,pz,dx,dy,dz=Spring.GetUnitPiecePosDir(unitID,PceDescLst[i].Piece)
			pgx,pgy,pgz,dgx,dgy,dgz=Spring.GetUnitPiecePosDir(unitID,SnakePoints[PceDescLst[Index].PointIndex])
			vec=	norm2Vector(makeVector(px-pgx,py-pgy,pz-pgz))
			if eqVec(makeVector(dx,dy,dz),vec)==false then return false end
			
		end
		
		return true
	end
	
	function mulVectorS4Mat(mat,vec)
	enVec={[1]=vec.x,[2]=vec.y,[3]=vec.z, [4]= 1}
	resVec={[1]=0,[2]=0,[3]=0,[4]=0 }
		
		for u=0,3, 1 do
		sum=0
			for v=1,4, 1 do
			sum= sum + (enVec[v]*mat[u*4 + v])		
			end
			
		resVec[u+1]=sum
		end
		
	return {x=resVec[1],y=resVec[2],z=resVec[3],w= resVec[4] }
	end
	
	
	function hang(pieceName,offSetVec,speed)
	diVec=makeVector(0,0,0)
	mat={}
	hx,hy =Spring.GetUnitPosition(unitID)
	dx,dy,dz=Spring.GetGroundNormal(hx,hy)
	dv=makeVector(dx,dy,dz)
	upv= makeVector(0,1,0)
	dv= subVector(upv,dv)
	
	tPVector(pieceName,dv,speed)
	end
	
	
	function TurnPieceList( ScriptEnviroment,PieceList, boolTurnInOrder, boolWaitForTurn,boolSync)
		
		
		
		
		for i=1,table.getn(PieceList),5 do
			
			if boolSync == false then
				tP(PieceList[i],PieceList[i+1],PieceList[i+2], PieceList[i+3],PieceList[i+4],boolTurnInOrder)
			else
				if not PieceList[i] then 
					echo("TurnPieceList piece "..i.." missing") 
				else	
					x_deg,y_deg,z_deg= ScriptEnviroment.GetPieceRotation(PieceList[i])
					
					turnSyncInSpeed(PieceList[i],PieceList[i+1],PieceList[i+2], PieceList[i+3],PieceList[i+4],math.deg(x_deg),math.deg(y_deg),math.deg(z_deg))
				end
			end
			
		end
		
		if boolWaitForTurn==true and boolTurnInOrder== false then
			for i=1,table.getn(PieceList),5 do
				WaitForTurns(PieceList[i])
			end
		end
		
		
	end
	
	--> Turn a Table towards local T
	function moveT(t, axis, dist,speed,boolInstantUpdate)
		if boolInstantUpdate then
			for i=1,#t,1 do
				Move(t[i],axis,dist,0,true)
			end
			return
		end
		
		if not speed or speed==0 then
			for i=1,#t,1 do
				Move(t[i],axis,dist,0)
			end
		else
			for i=1,#t,1 do
				Move(t[i],axis,dist,speed)
			end
		end
		return
	end
	
	function turnTableRand(t, taxis, uparg, downarg,speed,boolInstantUpdate)
		axis=taxis or 2 --y_axis as default
		down=downarg or math.random(-50,0)
		up=uparg or math.random(0,50)
		if down > up then down=down*-1-1 end
		
		if boolInstantUpdate then
			for i=1,#t,1 do
				Turn(t[i],axis,math.rad(math.random(down,up)),0,true)
			end
			return
		end
		
		if not speed or speed==0 then
			for i=1,#t,1 do
				Turn(t[i],axis,math.rad(math.random(down,up)),0)
			end
		else
			for i=1,#t,1 do
				Turn(t[i],axis,math.rad(math.random(down,up)),speed)
			end
		end
		return
	end


	function unfoldAnimation(ListOfPieces,specialeffectsfunction,unitID,maxSpeed)
		--sort them BySize --samesizes by closeness to ground
		
		PieceIDSizeTable={}
		PieceIDHeightTable={}
		AllreadyVisiblePieces={}
		hideT(ListOfPieces)
		for k,v in pairs(ListOfPieces) do
			x,y,z=Spring.GetUnitPieceCollisionVolumeData(unitID,v)
			min=math.floor(math.min(x,math.min(y,z)))
			PieceIDSizeTable[v]=min
			_,y_=Spring.GetUnitPiecePosDir(unitID,v)
			PieceIDHeightTable[v]=y
		end
		--sortBySize
		SizeSortedTable={}
		HeightSortedTable={}
		
		for k,v in pairs(ListOfPieces) do
			SizeSortedTable= binaryInsertTable(SizeSortedTable,PieceIDSizeTable[v],v,k) 	
			HeightSortedTable=binaryInsertTable(HeightSortedTable,PieceIDHeightTable[v],v,k) 	
		end
		
		ClosedTable={}
		AllreadyVisiblePieces[ SizeSortedTable[#SizeSortedTable].key]=PieceIDSizeTable[SizeSortedTable[#SizeSortedTable].key]
		MovePieceoPieceUnitSpace(AllreadyVisiblePieces[1],0,0,0,0)
		Show(AllreadyVisiblePieces[1])
		ClosedTable[AllreadyVisiblePieces[1]]=true
		local StartPiece=AllreadyVisiblePieces[1]
		
		--we now have Table of Pieces Sorted by size and height in the building
		-- we itterate over the lower table - and pick by size 
		
		for i=1,#HeightSortedTable, 1 do	
			if HeightSortedTable[i].value ~= StartPiece then
				--find a StartPiece
				local mySize=PieceIDSizeTable[HeightSortedTable[i].value]
				PieceBiggerThenMe=StartPiece
				for k,v in pairs(AllreadyVisiblePieces) do
					if v > mySize then
						PieceBiggerThenMe=k
						if math.random(0,2)==1 then break end
					end
				end
				
				MovePieceToPiece( HeightSortedTable[i].value, PieceBiggerThenMe,0)
				Show(HeightSortedTable[i].value)
				--get Element Bigger in Table 
				Move(HeightSortedTable[i].value,0,x_axis,speed)
				Move(HeightSortedTable[i].value,0,z_axis,speed)
				WaitForMove(HeightSortedTable[i].value,z_axis)
				WaitForMove(HeightSortedTable[i].value,x_axis)
				Move(HeightSortedTable[i].value,0,y_axis,speed)
				WaitForMove(HeightSortedTable[i].value,y_axis)
				AllreadyVisiblePieces[HeightSortedTable[i].value]=PieceIDSizeTable[HeightSortedTable[i].value]
				--ShowTheBiggest
			end
		end
		-- Move through the showedList, from a randomPoint find a piece that has a fitting size
	end	
	
	-->Drops a unitpiece towards the ground
	function PieceDropTillStop(unitID,piece,speedPerSecond, VspeedMax, lbounceNr, boolSpinWhileYouDrop, bounceConstant,driftFunc)
		if not unitID or not piece or not speedPerSecond or not VspeedMax then return end
		x,globalHeightUnit,z=Spring.GetUnitPosition(unitID)
		
		speed=speedPerSecond or 9.81
		speedMax=VspeedMax or 9.81
		bounceNr = lbounceNr or 12
		times=1000
		factorT=times/1000
		
		if boolSpinWhileYouDrop and boolSpinWhileYouDrop==true then
			SpinAlongSmallestAxis(unitID,piece, math.random(-25,25),2)
		end
		
		dirX,dirY,dirZ= Spring.GetUnitPiecePosition(unitID,piece)
		bdirX,bdirY,bdirZ= Spring.GetUnitPiecePosition(unitID,piece)
		dirX,dirZ=bdirX-dirX,bdirZ-dirZ
		
		--Spring.Echo("Spring.GetUnitWeaponVectors(unitID,1)"..dirX.. " z:"..dirZ)
		norm=math.sqrt(dirX*dirX + dirZ*dirZ)
		dirX,dirZ=(dirX/norm),(dirZ/norm)
		dirX,dirZ= -0.5*randSign(),-0.5*randSign()
		vec={vx=dirX ,vy= 0.4, vz=dirZ ,x=0,y=17,z=0,}
		
		
		
		
		gh=Spring.GetGroundHeight(x,z)
		bump=0
		force=16
		
		while bump < bounceNr do 
			--accelerate by vector +gravity 
			vec.y=vec.y + clampMaxSign(vec.vy* force	%(speed*factorT) - 1*speed, factorT*speedMax) 
			vec.x=vec.x + clampMaxSign(vec.vx* force	%(speed*factorT)			, factorT*speedMax)
			vec.z=vec.z + clampMaxSign(vec.vz* force	%(speed*factorT)			, factorT*speedMax)
			
			
			mP(piece,vec.x,vec.y,vec.z, factorT*speed)
			
			--shrink vec with sqrt as a approximation for air resistance
			vec.vx=clampMaxSign(math.sqrt((math.abs(vec.vx)^1.414))*sigNum(vec.vx),1)
			vec.vz=clampMaxSign(math.sqrt((math.abs(vec.vz)^1.414))*sigNum(vec.vz),1)
			
			--apply a approximation for the decay of movement
			vec.vy=clampMaxSign(1-(1/(force+0.0001))* (vec.vy ) , 1 )
			WaitForMove(piece,y_axis)
			Sleep(10)
			--Spring.Echo("Looping Physics")
			x,y,z=Spring.GetUnitPiecePosDir(unitID,piece)
			gh=Spring.GetGroundHeight(x,z)
			
			
			
			if gh - y > 5 then
				
				
				bump=bump+1
				force=math.sqrt(force)
				--not realistic but a start we take the ground normal as new vector 
				--reset Position
				x,y,z=Spring.GetUnitPiecePosDir(unitID,piece)
				
				MoveUnitPieceToGroundPos(unitID,piece,x,z,0,0)
				dx,dy,dz, slope =Spring.GetGroundNormal(x,z)
				
				--Spring.Echo("X>"..vec.x .. " Y> ".. vec.y .. " Z>" .. vec.z) 
				--Spring.Echo("VX>"..vec.vx .. " VY> ".. vec.vy .. " VZ>" .. vec.vz) 
				--Spring.Echo("DX>"..dx .. " DZ>" .. dz) 
				if math.abs(dy) > 0.5 and force < 1 then 
					StopSpin(piece,x_axis,0.5)
					StopSpin(piece,y_axis,0.5)
					StopSpin(piece,z_axis,0.5)
					LayFlatOnGround(piece)
					x,y,z=Spring.GetUnitPiecePosDir(unitID,piece)
					MoveUnitPieceToGroundPos(unitID,piece,x,z,0,0)
					
					return
				else
					force=force *2 
				end
				px,py,pz=Spring.GetUnitPiecePosition(unitID,piece)
				vec.vx,vec.vy,vec.vz=(clampMaxSign(dx*0.5,1)),vec.vy*-0.75,(clampMaxSign(dz*0.5,1))
				
				vec.y= vec.y + clampMaxSign(vec.vy* force^2	 , factorT*speedMax) 
				vec.x= vec.x + clampMaxSign(vec.vx* force^2				, factorT*speedMax)
				vec.z= vec.z + clampMaxSign(vec.vz* force^2				, factorT*speedMax)
				mP(piece,vec.x,vec.y,vec.z, factorT*speed)
				WaitForMove(piece,y_axis)
				Sleep(10)
				
				
			end
			
		end
		
		
	end
	
		
	--> Move all Elements of a Table to Zero
	function resetMT(t)
		for i=1, #t, 1 do
			Move(t[i],y_axis,0,0)
			Move(t[i],z_axis,0,0)
			Move(t[i],z_axis,0,0)
		end
	end
	
	--> Turn a Table towards local T
	function turnT(t, axis, deg,speed,boolInstantUpdate,boolWait)
		if boolInstantUpdate then
			for i=1,#t,1 do
				Turn(t[i],axis,math.rad(deg),0,true)
			end
			return
		end
		
		if not speed or speed==0 then
			for i=1,#t,1 do
				Turn(t[i],axis,math.rad(deg),0)
			end
			
		else
			for i=1,#t,1 do
				Turn(t[i],axis,math.rad(deg),speed)
			end
			if boolWait then 	for i=1,#t,1 do WaitForTurn(t[i],axis) end end
		end
		return
	end
	
	
	
	
	--unitID,centerNode,centerNodes, nrofLegs, FeetTable={firstAxisTable, KneeTable[nrOfLegs]},SensorTable,frameRate, FeetLiftForce
	--> Trys to create a animation using every piece there is as Legs.. 
	function adaptiveAnimation(configTable,inPeace,id,ScriptEnviroment)
		local spGetUnitPosition=Spring.GetUnitPosition
		local infoT= configTable
		pieceMap={}
		oldHeading=(Spring.GetUnitHeading(unitID)/32768)*3.14159
		pieceMap[infoT.centerNode]={}
		pieceMap=recursiveAddTable(pieceMap,infoT.centerNode, infoT.centerNode,inPeace)
		
		if not GG.MovementOS_Table then GG.MovementOS_Table={} end
		quadrantMap={[1]=0,[2]=0,[3]=0,[4]=0}
		tx,ty,tz=spGetUnitPosition(unitID)
		GG.MovementOS_Table[unitID]={quadrantMap=quadrantMap,boolmoving=false, stability=1, tx=tx,ty=ty,tz=tz, ForwardVector={x=0,z=0}}
		
		
		
		
		
		maxDeg=math.random(12,32)
		turnOffset=360/#infoT.feetTable.Knees
		
		for i=1,infoT.nr do
			
			StartThread( feetThread,
			math.floor(math.min(math.max(0,(i*turnOffset)/360),1)*4),
			(-190+(85)*i),
			maxDeg,
			i,
			infoT.feetTable.firstAxis[i],
			infoT.feetTable.Knees[i],
			infoT.sensorTable[i],
			infoT.ElementWeight or 10,
			infoT.FeetLiftForce or 2,
			infoT.LiftFunction,
			infoT.Height,
			infoT.WiggleFunc,
			ScriptEnviroment,
			infoT.tipTable[i]
			)
		end
		
		
		local MotionDetect=	function (ox,oz)
			x,y,z=Spring.GetUnitPosition(unitID)
			return math.abs(ox-x) +math.abs(oz-z) < 15,x,z
		end
		
		
		Sleep(100)
		
		ox,oy,oz= spGetUnitPosition(unitID)
		boolMoving=false
		Height=infoT.Height
		while true do
			--find out whether we are moving
			ux,uz=ox,oz
			boolMoving,ox,oz=MotionDetect(ox,oz)
			GG.MovementOS_Table[unitID].tx=ox
			GG.MovementOS_Table[unitID].tz=oz
			
			
			GG.MovementOS_Table[unitID].ForwardVector={x=ox-ux,z=oz-uz}
			
			local one, three =GG.MovementOS_Table[unitID].quadrantMap[1],GG.MovementOS_Table[unitID].quadrantMap[3]
			local two,four =GG.MovementOS_Table[unitID].quadrantMap[2],GG.MovementOS_Table[unitID].quadrantMap[4]
			total=one+two+three+four
			one,two,three,four=one>0,two> 0, three>0, four> 0
			--		//stabilityfactor
			BoolStable=((one and two and (three or four) )	)or 
			((two and four) and ( three or one) )or 
			((four and three) and ( one or two) )or
			((three and one ) and ( four or two))
			
			if BoolStable==false then
				GG.MovementOS_Table[unitID].stability=math.min(1,(1/total)*	GG.MovementOS_Table[unitID].stability)
			else
				GG.MovementOS_Table[unitID].stability=1			
			end
			
			Move(infoT.centerNode,y_axis,GG.MovementOS_Table[unitID].stability*Height,3)
			
			Heading=(Spring.GetUnitHeading(unitID)/32768)*3.14159
			boolTurning= math.abs(Heading - oldHeading) > 1
			
			
			for i=1,infoT.nr,1 do			
				degOffSet=(-190+(85)*i)
				RelHeading=(((degOffSet+360 )-(Heading+360))-360)%360
				if (RelHeading < 0) then RelHeading = (RelHeading+360)*-1 end		
				
				if boolTurning== true then 				
					speed=math.random(5,15)/100
					Turn(	infoT.feetTable.firstAxis[i],y_axis,math.rad(degOffSet+clamp(RelHeading,-25,25)*-1),speed)
					turnT(infoT.feetTable.Knees[i],y_axis,clamp(RelHeading,-10,10)*-1,speed,false,true)			
				else
					infoT.WiggleFunc(	infoT.feetTable.firstAxis[i],degOffSet)
				end
			end
			Sleep(400)	
		end
	end

	
-->Moves a UnitPiece to a UnitPiece at speed
function MovePieceoPieceUnitSpace(unitID,piecename, piecenameB,speed, waitForIt)
	if not piecenameB or not piecename then return end
	bx,by,bz=Spring.GetUnitPiecePosition(unitID,piecenameB)
	bx=-1*bx
	
	Move(piecename,x_axis,bx,speed)
	Move(piecename,y_axis,by,speed)
	Move(piecename,z_axis,bz,speed,true)	
	if waitForIt==true then
		WaitForMove(piecename,x_axis)
		WaitForMove(piecename,y_axis)
		WaitForTurn(piecename,y_axis)
	end
end

-->Turns a Piece towards a position in unitspace 
function TurnPieceTowards(piecename,x,y,z,speed)
	
	Turn(piecename,x_axis,math.rad(x),speed)
	Turn(piecename,y_axis,math.rad(y),speed)
	Turn(piecename,z_axis,math.rad(z),speed,true)	
	
end

-->Turn a Piece towards another Piece 
function TurnPieceTowardsPiece(piecename,pieceB,speed)
	ax,ay,az=Spring.GetUnitPiecePosition(unitID,piecename)
	assert(ax)
	px,py,pz=Spring.GetUnitPiecePosition(unitID,pieceB)
	assert(px)
	px,py,pz=ax-px,ay-py,az-pz
	dx = math.deg(math.atan2(px,pz))
	dy = math.deg(math.atan2(px,pz))
	dz = math.deg(math.atan2(py,px))
	
	echo("Turntoards point")
		TurnPieceTowards(piecename,dx,dy,dz,speed)

	
end

--> Turns a Piece into the Direction of the coords given (can take allready existing piececoords for a speedup
function TurnPieceTowardsPoint (piecename, x,y,z,Speed,lox,loy,loz)
	pvec={x=0,y=0,z=0}
	lox=lox or 0
	loy=loy or 0
	loz= loz or 0
	ox,oy,oz=math.rad(loy), math.rad(lox), math.rad(loz)
	

	px,py,pz,pvec.x,pvec.y,pvec.z =Spring.GetUnitPiecePosDir(unitID,piecename) 
	pvec=normVector(pvec)
	
	vec={}
	vec.x,vec.y,vec.z=x-px,y-py,z-pz
	vec=normVector(vec)
	vec=subVector(vec,pvec)
	vec=normVector(vec)
	
	tPrad(piecename, math.atan2(vec.y,vec.z)+ox,math.atan2(vec.x,vec.z)+oy,math.atan2(vec.x,vec.y)+oz,Speed)
end

function tPVector(piece, vec, speed)
x=math.atan2(vec.y,vec.z)
y=math.atan2(vec.x,vec.z)
z=math.atan2(vec.x,vec.y)
	tPrad(piece, x,y,z,speed)

end

--> Moves a Piece to a WorldPosition relative to the Units Position
function MovePieceToRelativeWorldPos(id,piecename, relX,relY,relZ,speed)
	x,y,z=Spring.GetUnitPosition(id)
	x,y,z=relX-x,y-relY,relZ-z
	Move(piecename,x_axis,x,speed)
	Move(piecename,y_axis,y,speed)
	Move(piecename,z_axis,z,speed,true)	
	
end


function resetDir(piecename,speed)
	Turn(piecename,x_axis,0,speed)
	Turn(piecename,y_axis,0,speed)
	Turn(piecename,z_axis,0,speed)
	
	
end

--> calcSpeedThroughDegByTime
function GetSpeed(timeInSeconds, degree)
	degRad=math.rad(degree)
	return (degRad/timeInSeconds)
end

-->Reset a Table of Pieces at speed
function resetT(tableName,speed, ShowAll, boolWait, boolIstantUpdate)
	lboolWait=boolWait or false
	lspeed=speed or 0
	
	assert(tableName,"libAnimation::resetT: No valid Table")
	
	for i=1,#tableName do
		
		reset(tableName[i],lspeed,false, boolIstantUpdate)
		if ShowAll and tableName[i] then
			Show(tableName[i])
		end
		
	end
	
	if lboolWait == true then
	WaitForTurns(tableName)
	end
	
end

-->Recursively Resets Tables
function recReseT(Table,speed)
	if type(Table)=="table" then 
		for k,v in pairs(Table) do
			recReseT(v,speed)
		end
	elseif type(Table)=="number" then
		reset(Table,speed)
	end
	
	
end

function reset(piecename,speed,boolWaitForIT, boolIstantUpdate)
	if not piecename then return end
	if type(piecename) ~= "number" then Spring.Echo("libAnimation::reset:Invalid piecename-got ".. piecename) end
	bIstantUpdate = boolIstantUpdate or true
	Turn(piecename,x_axis,0,speed)
	Turn(piecename,y_axis,0,speed)
	Turn(piecename,z_axis,0,speed)
	
	Move(piecename,x_axis,0,speed)
	Move(piecename,y_axis,0,speed)
	Move(piecename,z_axis,0,speed,bIstantUpdate)
	if boolWaitForIT then 
		WaitForTurn(piecename,1)
		WaitForTurn(piecename,2)
		WaitForTurn(piecename,3)
	end	
end


-->Shows a Pieces Table
function showT(tablename,lowLimit,upLimit,delay)
	if not tablename then Spring.Echo("No table given as argument for showT") return end
	
	if lowLimit and upLimit then
		for i=lowLimit,upLimit, 1 do
			if tablename[i] then
				Show(tablename[i])
			end
			if delay and delay > 0 then Sleep(delay) end
		end
		
	else
		for i=1,table.getn(tablename), 1 do
			if tablename[i] then
				Show(tablename[i])
			end
		end
	end
end

--> Hides a PiecesTable, 
function hideT(tablename,lowLimit,upLimit,delay)
	if not tablename then return end
	boolDebugActive= (lib_boolDebug==true and lowLimit and type(lowLimit) ~= "string")
	
	if lowLimit and upLimit then
		for i=upLimit,lowLimit, -1 do
			if tablename[i] then
				Hide(tablename[i])
			elseif boolDebugActive == true then
				echo("In HideT, table ".. lowLimit .." contains a empty entry")
			end
			
			if delay and delay > 0 then Sleep(delay) end
		end
		
	else
		for i=1,table.getn(tablename), 1 do
			if tablename[i] then
				Hide(tablename[i])
			elseif boolDebugActive == true then
				echo("In HideT, table ".. lowLimit .." contains a empty entry")
			end
		end
	end
end

		
	function objectFalling(objectname,weight,step, OVect,term)
		Terminal=term or -9.81
		weight=1/weight
		dx,dy,dz=Spring.GetUnitDirection(unitID)
		ObjectVector=OVec or {x=0,y=0,z=0}
		sizeX,sizeY,sizeZ=Spring.GetUnitPieceCollisionVolumeData(unitID,objectname)
		size=math.sqrt(sizeX*sizeX+sizeY*sizeY+sizeZ*sizeZ)
		
		--Here be pseudo physics :)
		while true do
			oPosX,oPosY,oPosZ=Spring.GetUnitPiecePosDir(unitID,objectname)
			
			--ApplyGravity
			OVec.y= math.max(math.max(OVec.y^2,1.7)*-1,term)
			
			--CheckCollission
			if OPosY-size < Spring.GetGroundHeight(oPosX,oPosZ) then
				groundX,groundY,groundZ=Spring.GetGroundNormal(oPosX,oPosY)
				OVec.x,OVec.y,Ovec.z=groundX+OVec.x,(OVec.y*-1)*weight+groundY,OVec.z+groundZ	
			end
			
			--MoveObject
			MaxVal=math.abs(Ovec.y)/(1000/step)
			
			--Normalisieren des ObjectVectors
			normV=normVector(OVec)
			normV=mulVector(normV,TotalEnergy)
			
			speed=3.141
			stepTimesVec=1
			
			Move(objectname,x_axis,Ovec.x*stepTimesVec,speed)
			Move(objectname,y_axis,Ovec.y*stepTimesVec,speed)
			Move(objectname,z_axis,Ovec.z*stepTimesVec,speed)
			
			Sleep(step)
		end
		
	end

--> Turns a Pieces table according to a function provided
	function waveATable(Table, axis, lfoonction, lsignum, lspeed,lfuncscale,ltotalscale, boolContra,offset)
	
	if type(Table) ~= "table" then return end
	
	
		func = lfoonction or function(x) return x end
		signum = lsignum or 1
		speed = lspeed or 1
		totalscale= ltotalscale or (#Table *3.14159)
		funcscale = lfuncscale or 3.14159
		boolCounter=boolContra or false
		offset=offset or 0
		scalar= signum* (totalscale)
		nr=table.getn(Table)
		pscale=funcscale/nr
		total=0
		
		for i=1,nr do
			val=scalar*func(offset+i*pscale)
			
			if type(Table[i])=="table" then 
				waveATable(Table[i], axis, func, signum, speed,funcscale,totalscale, boolContra,offset)
			else	
				
				if boolCounter == true then
					
					Turn(Table[i],axis,math.rad(total+val),speed)
					
					total=total+val
				else
					Turn(Table[i],axis,math.rad(val),speed)
				end
			end
		end
		
		
	end	

--> creates a table of Accessors 
function getTableAccessor(xDepth, zDepth, boolRandomize)
	halfX=math.ceil(math.abs((xDepth/2)))*-1
	halfZ=math.ceil(math.abs((zDepth/2)))*-1
	resulT={}
	Spring.Echo("getTableAccessor::",halfX,halfZ)
	for x=halfX, math.abs(halfX) do
		for z=halfZ, math.abs(halfZ) do
			resulT[#resulT+1]={x=x, z = z}
		end
	end
	if boolRandomize== true then
		return randT(resulT)
	else
		return resulT
	end
end
--================================================================================================================
--================================================================================================================
