

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




-->Print Seperated
function printV(...)
	conCat=""
	if arg then
		for k,v in pairs(arg) do
			
			conCat=conCat.." || "..k .. " <-> "..v.. " ¦ "
			
		end
	end
	Spring.Echo(conCat)
	
end

-->Plays a Soundscape
--> Expects: a path, a table containing :
-- a Table of openers, containing "Name"
-- Numbers and time to play

-- a similar table for the backgrounds
-- a similar table for the single sound solos
-- a Table of closers, containing "Name"
-- Numbers and time to play
function playSoundScape_OS(path, dataTable, restIntervallMin, restIntervallMax, loudness, unitID)
	unitTypeunitdefDefID=Spring.GetUnitDefID(unitID)
	
	if GG.UnitDefSoundLock == nil then GG.UnitDefSoundLock={} end
	if GG.UnitDefSoundLock[unitdef] == nil then GG.UnitDefSoundLock[unitdef]=0 end
	timeTable={soloGo=0, backgroundGo=0}
	
	while true do
		if GG.UnitDefSoundLock[unitdef] <= 0 then
			GG.UnitDefSoundLock[unitdef] = 1
			openerIndex=iRand(1,#dataTable.opener)
			otime =dataTable.opener[openerIndex]
			--opening
			Spring.PlaySoundFile(path.."opener/single"..openerIndex..".ogg",loudness)
			Sleep(otime)
			--work out solos
			soloNumber= dataTable.storyBoard Rand(1,dataTable.soloNumber)
			
			while soloNumber > 0 do
				if timetable.backgroundGo <= 0 then
					backgroundIndx=iRand(1,#dataTable.background)
					Spring.PlaySoundFile(path.."background/background"..backgroundIndx..".ogg",loudness)
					timetable.backgroundGo = dataTable.background[backgroundIndx]
				end
				-- if there is no storyboard randomize
				currentSolo=iRand(1,#dataTable.solo)
				if dataTable.storyBoard then
					currentSolo = dataTable.storyBoard[dataTable.storyBoard.index]
					dataTable.storyBoard.index=dataTable.storyBoard.index+1
				end
				
				if timetable.soloGo <= 0 then
					soloIndx=iRand(1,#dataTable.solo)
					Spring.PlaySoundFile(path.."solo/solo"..soloIndx..".ogg",loudness)
					timetable.soloGo = dataTable.solo[soloIndx]
				end
				maxRestTime=math.min(timetable.soloGo,timetable.backgroundGo)
				Sleep(maxRestTime)
				timetable.soloGo,timetable.backgroundGo=timetable.soloGo-maxRestTime,timetable.backgroundGo-maxRestTime
				
				soloNumber=soloNumber-1
			end
			remainTime=math.max(math.abs(timetable.backgroundGo)-500,1)
			Sleep(remainTime)
			--play Closer
			currentCloser=iRand(1,#dataTable.closer)
			Spring.PlaySoundFile(path.."closer/closer"..currentCloser..".ogg",loudness)
			Sleep(dataTable.closer[currentCloser])
			
			
			--release lock
			GG.UnitDefSoundLock[unitdef] = 0
		else
			Sleep(500)
		end

		 rest=iRand(restIntervallMin, restIntervallMax)
		 Sleep(rest)
	end
end


--> Plays a DescriptorTable in Order reciving Signals for a global soundOrderTable	
function playSoundInOrder(soundInOrderTable)
	
	for i=1,#soundInOrderTable,1 do
		if soundInOrderTable[i].boolOnce then
			if soundInOrderTable[i].predelay then 	Sleep(soundInOrderTable[i].predelay) end
			Spring.PlaySoundFile(soundInOrderTable[i].sound,1.0)
			if soundInOrderTable[i].postdelay then 	Sleep(soundInOrderTable[i].postdelay) end
			
		else
			while soundInOrderTable[i].signal==true do
				if soundInOrderTable[i].predelay then 	Sleep(soundInOrderTable[i].predelay) end
				if type(soundInOrderTable[i].sound)=="table" then
					dice=math.floor(math.random(1,#soundInOrderTable[i].sound))
					Spring.PlaySoundFile(soundInOrderTable[i].sound[dice],1.0)
				else
					Spring.PlaySoundFile(soundInOrderTable[i].sound,1.0)
				end
				if soundInOrderTable[i].postdelay then 	Sleep(soundInOrderTable[i].postdelay) end
			end
		end
	end
end


--This Section contains standalone functions to be executed as independent systems monitoring and handling lua-stuff
--mini OS Threads

--> Unit Statemachine
function stateMachine(unitid, sleepTime,State, stateT)
	local time=0
	local StateMachine=stateT
	local stateStorage={}
	while true do
		
		if not stateStorage[State]then stateStorage[State]={} end
		
		State, stateStorage =StateMachine[State](unitid,time,stateStorage)
		Sleep(sleepTime)
		time=time+sleepTime
	end
end


--> Gadget:missionScript expects frame, the missionTable, which contains per missionstep the following functions
-- e.g. [1]= {situationFunction(frame,TABLE,nr), continuecondtion(frame,TABLE,nr,boolsuccess), continuecondtion(frame,TABLE,nr,boolsuccess)}
-- in Addition every Functions Table contains a MissionMap which consists basically of a statediagramm starting at one
-- MissionMap={[1]=> {2,5},[2] => {1,5},[3]=>{5},[4]=>{5},[5]=>{1,5}}
function missionHandler(frame,TABLE,nr)
	--wethere the mission is continuing to the next nr
	boolContinue=false
	--wether the mission has a Outcome at all
	boolSituationOutcome =TABLE[nr].situationFunction(frame,TABLE,nr)
	
	--we return nil if the situation has no defined outcome
	if not boolSituationOutcome then return end
	
	if not TABLE[nr].continuecondtion then
		boolContinue=true
	elseif type(TABLE[nr].continuecondtion)=='number'then	
		if frame > TABLE[nr].continuecondtion then boolsuccess=true end
	elseif type(TABLE[nr].continuecondtion)=='function'then	
		boolContinue=TABLE[nr].continuecondtion(frame,TABLE,nr,boolsuccess)
	end 
	
	if boolContinue==true then
		return TABLE[nr].continuecondtion(frame,TABLE,nr,boolsuccess)
	else
		return nr
	end
	
end

--> jobfunc header jobFunction(unitID,x,y,z, Previousoutcome) --> checkFuncHeader checkFunction(unitID,x,y,z,outcome)
function getJobDone(unitID, dataTable, jobFunction, checkFunction,rest)
	local dataT=dataTable
	local spGetUnitPosition=Spring.GetUnitPosition
	x,y,z=spGetUnitPosition(unitID)
	outcome=false
	
	while checkFunction(unitID,dataT,x,y,z,outcome) ==false do
		x,y,z=spGetUnitPosition(unitID)
		outcome=jobFunction(unitID, dataT, x,y,z, outcome)
		Sleep(rest)
	end
	
end

-->pumpOS shows a circularMovingObject
function circulOS(TableOfPieces,CircleCenter,axis, PieceLength, AnimSpeed, arcStart, arcEnd, arcMoving)
	start,ending= arcStart,arcEnd
	boolArcMoving= arcMoving ~= nil
	hideT(TableOfPieces)
	speed=arcMoving or AnimSpeed
	speed=speed/100
	
	accumulatedTurn=0
	modulatedTurn=0
	
	Spin(CircleCenter,axis,math.rad(speed),0)
	while true do
		if start < ending then
			for i=1,#TableOfPieces, 1 do
				if i <start or i> ending then
					Hide(TableOfPieces[i])
				else
					Show(TableOfPieces[i])
				end
			end
			
		else
			for i=1,#TableOfPieces, 1 do
				if i < start and i > ending then
					Hide(TableOfPieces[i])
				else
					Show(TableOfPieces[i])
				end
			end
			
			if math.abs(modulatedTurn-accumulatedTurn) > PieceLength then
				start=start+1
				if start > #TableOfPieces then start=1 end
				ending=ending+1
				if ending > #TableOfPieces then ending=1 end
				modulatedTurn=accumulatedTurn
			end
			
		end
		
		accumulatedTurn=accumulatedTurn+speed
		Sleep(100)
	end
	
	
end

function portalOS(piecesTable, center, pieceLength, axis, moveDistance, speed,prePostShow,SleepTime)
	while true do
		hideT(piecesTable)
		Move(center,axis,0,0)
		for i=1,#piecesTable, 1 do
			Move(center,axis, pieceLength*i,speed)
			if prePostShow ==true then Show(piecesTable[i]) end
			WaitForMove(center,axis)
			if prePostShow ==false then Show(piecesTable[i]) end
		end
		Sleep(SleepTime)
	end
	
end

--> genericOS 
function genericOS(unitID, dataTable,jobFunctionTable, checkFunctionTable,rest)
	local checkFunctionT	=checkFunctionTable
	local jobFunctionT		=jobFunctionTable
	local dataT				=dataTable
	local spGetUnitPosition=Spring.GetUnitPosition
	
	x,y,z=spGetUnitPosition(unitID)
	outcomeTable=iniT(#jobFunctionT,false)
	boolAtLeastOneNotDone=true
	while boolAtLeastOneNotDone ==true do
		x,y,z=spGetUnitPosition(unitID)
		for i=1,#jobFunctionT do
			outcomeTable[i]=jobFunctionT[i](unitID,x,y,z, outcomeTable[i],dataT)
			Sleep(rest)
		end
		boolAtLeastOneNotDone=true
		for i=1,#checkFunctionT do
			boolAtLeastOneNotDone= checkFunction(unitID,x,y,z,outcomeTable[i]) and boolAtLeastOneNotDone
			Sleep(rest)
		end
		
	end
end

-->encapsulates a function, stores arguments given, chooses upon returned nil, 
--	the most often chosen argument
function heuristicDefault(fooNction,fname, teamID, ...)
	
	if not GG[fname] then GG[fname]={} end
	if not GG[fname][teamID] then GG[fname][teamID] ={} end
	
	local heuraTable= GG[fname][teamID] 
	ArgumentCounter=1
	for k,v in pairs(arg) do
		if not heuraTable[ArgumentCounter]then heuraTable[ArgumentCounter]={}end
		if not heuraTable[ArgumentCounter][v] then heuraTable[ArgumentCounter][v]=1 else heuraTable[v]=heuraTable[ArgumentCounter][v]+1 end
		ArgumentCounter=ArgumentCounter+1
	end
	
	results=fooNction(args)
	
	if not results then
		--devalue current Arguments
		ArgumentCounter=1
		for k,v in pairs(arg) do
			heuraTable[ArgumentCounter][v]=heuraTable[ArgumentCounter][v]-1 
			ArgumentCounter=ArgumentCounter+1
		end
		
		--call the function with the most likely arguments
		newWorkingSet={}
		ArgumentCounter=1
		for k,v in pairs (arg) do
			highestVal,highestCount=0,0
			for i,j in pairs ( heuraTable[ArgumentCounter]) do
				if heuraTable[ArgumentCounter][v] > highestCount then
					highestCount= heuraTable[ArgumentCounter][v] 
					highestVal= v
				end 
			end
			table.insert(newWorkingSet,highestVal)
			ArgumentCounter=ArgumentCounter+1
		end
		results=fooNction(newWorkingSet)
		Spring.Echo("FallBack::Heuristic Default")
		assert(results, "Heuristic Default has inssuficient working samples.Returns Nil")
		GG[fname][teamID]=heuraTable
		return results
	else
		GG[fname][teamID]=heuraTable
		return results
	end
end 

function scaleOfChange(a,b, trigger)
	val=math.abs(a-b)
	
end

--==============================================Eventstream Jobs
-- action(id,frame, StreamUnits[id].persPack)

-->Expects in the Package {updaterate, Pos, DefID, hitpoints, assignedSubAI, buildid}
function buildJob(id, frame,Package)
	
	--check if we are there yet
	
	--if we are grab for the building
	
	--else move it
	
	--if the job is completed return yourself to the unitpool
	-- GG.UnitPool:Return(id,teamid,assignedSubAI,father)
	return nextFrame, Package
end

-->Expects in the Package {updaterate, Pos, DefID, hitpoints, assignedSubAI, guardid}
function guardJob(id, frame,Package)
	
	--check if we are there yet
	
	--if we are grab for the building
	
	--else move it
	
	--if the job is completed return yourself to the unitpool
	-- GG.UnitPool:Return(id,teamid,assignedSubAI,father)
	
	return nextFrame, Package
end

-->Expects in the Package {updaterate, Pos, DefID, hitpoints, assignedSubAI, teamMembers}
function exploreJob(id, frame,Package)
	
	--check if we are there yet
	
	--if we are grab for the building
	
	--else move it
	
	--if the job is completed return yourself to the unitpool
	-- GG.UnitPool:Return(id,teamid,assignedSubAI,father)
	return nextFrame, Package
end

-->Turn Piece into various diretions within range
function randomRotate(Piecename,axis, speed, rangeStart,rangeEnd)
	while true do
		Turn(Piecename,axis,math.rad(math.random(rangeStart,rangeEnd)),speed)
		WaitForTurn(Piecename,axis)
		Sleep(1000)
	end
	
end

--> breath 
function breathOS(body, lowDist, upDist , LegTable,LegNumber,degree, speed, count)
	leglength= upDist/2
	
	bLoop = true
	frames= 30
	lcount = count or 1
	if count and count > 0 then
		bLoop = false
	end
	
	if lowDist > upDist then return end
	
	while bLoop == true or lcount > 0 do
		
		distance= math.random(lowDist,upDist)
		percentage= distance/upDist
		time= distance/(math.abs(speed)+0.001)
		degreeC = percentage*degree
		--downDeg=math.asin(leglength*distance)
		--upDeg= math.asin()
		
		
		speedDeg= frames/(degreeC *(time))+0.0001 
		--speedDeg= 0.5
		degHalf= degreeC/9 +0.001
		degHalfMins= degHalf *-1.3
		degreeMinus= degreeC *-1.7
		
		Move(body, y_axis, -distance, speed)
		for i=1, LegNumber, 1 do
			Turn(LegTable[i].up,x_axis, math.rad(degreeC), speedDeg)
			Turn(LegTable[i].down,x_axis, math.rad(degreeMinus), 2*speedDeg)
		end
		
		WaitForMove(body, y_axis)
		Sleep(100)
		Move(body, y_axis, 0, speed)
		for i=1,LegNumber do
			
			Turn(LegTable[i].up,x_axis, math.rad(degHalf), speedDeg)
			Turn(LegTable[i].down,x_axis, math.rad( degHalfMins), speedDeg)
		end
		WaitForMove(body, y_axis)
		Sleep(100)
		lcount= lcount-1
	end
end

-->plays the sounds handed over in a table 
function playSoundByUnitTypOS(unitID,loudness,SoundNameTimeT)
	local SoundNameTimeTable=SoundNameTimeT
	unitdef=Spring.GetUnitDefID(unitID)
	
	while true do
		dice=math.random(1,#SoundNameTimeTable)
		
		PlaySoundByUnitType(unitdef, SoundNameTimeTable[dice].name,loudness, SoundNameTimeTable[dice].time, 1)
		Sleep(1000)
	end
end

-->partOfShipPartOfCrew binds a creature to a piece
function partOfShipPartOfCrew( point, CreatureID,MotherID)
	Spring.SetUnitNeutral(CreatureID,true)
	Spring.MoveCtrl.Enable(CreatureID,true)
	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	roX,roY,roZ=0,0,0
	
	while GGboolBuildEnded == false do
		tx,ty,tz=spGetUnitPiecePosDir(unitID,CreatureID)
		Spring.MoveCtrl.SetPosition(CreatureID,tx+math.random(-5,5),ty,tz+math.random(-5,5))
		Spring.MoveCtrl.SetRotation(CreatureID,roX, roY,roZ)
		roX,roY,roZ=roX+math.random(-0.01,0.01),roY+math.random(-0.01,0.01),roZ+math.random(-0.01,0.01)
		Sleep(500)
	end
	
	Spring.SetUnitAlwaysVisible(CreatureID,false)
	Spring.DestroyUnit(CreatureID,true,true)
end


--================================================================================================================
--OS Support Functionality


--> Sorts Pieces By Height in Model
function sortPiecesByHeight(ableStableTableOfBabelEnable)
	bucketSortList={}
	
	for i=1,#ableStableTableOfBabelEnable do
		px,py,pz=Spring.GetUnitPiecePosDir(unitID,ableStableTableOfBabelEnable[i])
		if not bucketSortList[math.ceil(py)] then 
			bucketSortList[math.ceil(py)]={}
		end
	end
	sortedTable={}
	index=1
	for k,v in pairs(bucketSortList) do
		if type(v)=="number" then
			sortedTable[index]=ableStableTableOfBabelEnable[v]
		else
			for i=1,#v do
				sortedTable[index]=ableStableTableOfBabelEnable[v[i]]
			end
		end
	end
	return sortedTable
end



-->Transformer OS: Assembles from SubUnits in Team a bigger Unit
function assemble(center,unitid,udefSub,CubeLenghtSub, nrNeeded,range, AttachPoints)
	--Move UnderGround
	
	makeCascadingGlobalTables("InfoTable["..unitid"].boolBuildEnded",true)
	
	piecesTable=Spring.GetUnitPieceList(unitid)
	for i=1,#piecesTable do
		piecesTable[i]=piece(piecesTable[i])
	end
	hideT(piecesTable)
	if AttachPoints then
		AttachPoints=sortPiecesByHeight(AttachPoints) 
	else
		AttachPoints=sortPiecesByHeight(piecesTable)
	end
	indexP=1
	hx,hy,hz=spGetUnitPiecePosDir(untid,AttachPoints[indexP])
	base=Spring.GetGroundHeight(hx,hz)
	DistanceDown=base-hy
	Move(center,y_axis,DistanceDown,0)
	
	makeCascadingGlobalTables("BoundToThee")
	
	oldHP=Spring.GetUnitHealth(unitid)
	newHP=oldHP
	
	while nrAdded < nrNeeded and Spring.GetUnitIsDead(unitid)==false do
		Move(center,y_axis,DistanceDown*(nrAdded/nrNeeded),1.5)
		--check VaryFoos around you
		allSub={}
		--check wether we are under Siege and send the Underlings not allready buildin
		newHP=Spring.GetUnitHealth(unitid)
		boolUnderAttack=oldHP > newHP
		oldHP=newHP
		if GG.InfoTable[unitid].boolUnderAttack==true then
			--defend moma
			ax,ay,az=Spring.GetUnitNearestEnemy(untid)
			for i=1,#allSub do
				if not GG.BoundToThee[allSub[i]] then
					Spring.SetUnitMoveGoal(allSub[i],ax,ay,az)		
				end
			end
			
		else --build on
			--get nextPiece above ground
			attachP=AttachPoints[math.min(indexP,#AttachPoints)]
			indexP=indexP+1
			
			x,y,z=Spring.GetUnitPiecePosDir(untid,attachP)
			for i=1,#allSub do
				
				ux,uy,uz=Spring.GetUnitPosition(allSub[i])
				if (ux-x) *(uy-y)* (uz-z) < 50 then --integrate it into the Avatara
					if not GG.BoundToThee[allSub[i]] then
						StartThread(partOfShipPartOfCrew, attachP, allSub[i],unitid)
					end
				else
					Spring.SetUnitMoveGoal(allSub[i],x,y,z)	
				end
			end
		end
		
	end
	
	GG.BoundToThee[unitid]=nil 
	MoveCtrl.Enable(unitID,false)
	GG.InfoTable[unitid].boolBuildEnded=true
	boolComplete=true
	Move(center,y_axis,0,12)
	showT(piecesTable)
	return true
end