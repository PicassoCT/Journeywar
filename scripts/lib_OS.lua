

--[[
   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
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
--> jobfunc header jobFunction(unitID,x,y,z, Previousoutcome)  --> checkFuncHeader  checkFunction(unitID,x,y,z,outcome)
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

if not  GG[fname] then  GG[fname]={} end
if not GG[fname][teamID] then GG[fname][teamID] ={} end

local heuraTable= GG[fname][teamID] 
ArgumentCounter=1
	for k,v in pairs(arg) do
	if not heuraTable[ArgumentCounter]then heuraTable[ArgumentCounter]={}end
	if not heuraTable[ArgumentCounter][v] then heuraTable[ArgumentCounter][v]=1 else heuraTable[v]=heuraTable[ArgumentCounter][v]+1  end
	ArgumentCounter=ArgumentCounter+1
	end

results=fooNction(args)

	if not results  then
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

-->denies a tree - withdraw percentage of helath of the invested ressources
function deactivateAndReturnCosts(boolJustOnceDeny,UnitDef)
	if boolJustOnceDeny==true then

	 -- metalMake,   metalUse,  energyMake,   energyUse=Spring.GetUnitResources(unitID)
	
	defID=Spring.GetUnitDefID(unitID)
	if not defID then return end
	health,maxhealth=Spring.GetUnitHealth(unitID)
	if not health then return end
	ecosts=UnitDef[defID].energyMake*(health/maxhealth)
	mcosts =UnitDef[defID].metalMake*(health/maxhealth)
	
	teamID=Spring.GetUnitTeam(unitID)
	if not teamID then return end

	Spring.AddTeamResource(teamID,"m",mcosts)
	Spring.AddTeamResource(teamID,"e",ecosts)
	x,y,z=Spring.GetUnitPosition(unitID)
	
	Spring.SetUnitResourcing(unitID,"ume",0)
	Spring.SetUnitResourcing(unitID,"umm",0)
	Spring.SetUnitResourcing(unitID,"uue",1)

	x,y,z=Spring.GetUnitPosition(unitID)
	Spring.SpawnCEG("jtreedenial" ,x,y+150,z,0,1,0,50,0)
	Spring.PlaySoundFile("sounds/jtree/denial.ogg",1.0)
	end


end