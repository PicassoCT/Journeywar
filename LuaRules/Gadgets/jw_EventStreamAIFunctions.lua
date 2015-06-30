--EventStreamFunctions for the SubAIs
--[[
                           +-----------------------------------------+ 
                           |                                         | 
                           | SubAI: Trades with the other Sub_AI and a 
                           | ssigns there Tasks with Priority        | 
                           |  Updates Heatmaps, Buildplans		     | 
                           |                                         | 
                           +--------------------+--------------------+ 
+---------------------+                         |                      
|                     +--------+                |                      
|  UnitPool:          |    +---v----------------v--------------------+ 
|  UnTasked Units     |    |                                         | 
|                     |    |   TaskManager Automaton:                | 
|                     |    |   Assigns Tasks based on Prioritylist   | 
|                     |    |                                         | 
|                     |    |                                         | 
|                     |    +--------------------+--------------------+ 
+-------^-------------+                         |                      
        |                                       |                      
        |                                       |                      
        |                  +--------------------v---------------------+
        |                  |  Event Stream obsessed with completing   |
        |                  |  a single Task                           |
        |                  |                                          |
        +------------------+                                          |
                           |                                          |
                           |                                          |
                           +------------------------------------------+
--]]
--BaseBuildingAutomaton
--FinancedBuildTasks -> {DefID, BuilderDefID, Pos, Priority, boolMonoTask}
function BaseBuildAutomaton(State, AITabel)

--One Unit is 0.1	
	
	for i=1,#State.FinancedBuildTasks do
	local Task=State.FinancedBuildTasks[i]
		--Position
		Position={}
			if Task.Pos then 
				Position=Task.Pos 
			else --determinate Position
				Position={x=x,y=y,z=z}
			end
		
		if Task.boolMonoTask ==true then --find a single unit able to complete the task
			--get the Unit whos job it will be
		BuilderID= GetUnitFromPoolByDefID(Task.BuilderDefID,AITabel.UnitPool)
		
			--StartEventStream
		--eventstreamID= 	GG.EventStream:CreateEvent({action=BuildUnitBuilding, 
												persPack={unitid=BuilderID,targetDefid=Task.DefID, Pos=Position})
			
		else --asign capable Units to the Task
			Prio=0
				for k=1,#AITabel.UnitPool do
					if Prio < Task.Priority then
					--StartEventStream	
				--	eventstreamID= 	GG.EventStream:CreateEvent({action=BuildUnitBuilding, 
													persPack={unitid=BuilderID,targetDefid=Task.DefID, Pos=Position})
					--Store ID and Prio in TaskPool
					Prio=Prio+0.1
					end 
				end 
		end
	end
end

--BaseBuilding
--[[Eventstream Function]]
--PersPackage expects unitid, defid, Pos={x,y,z} Coordinates for Building 
function BuildUnitBuilding(id, frame, PersPackage)
--Optimal Base Layout in Package
local unitid=PersPackage.unitid
local Pos=PersPackage.Pos
local BuildTargetDefID=PersPackage.defid
local hp= PersPackage.hp or Spring.GetUnitHealth(unitid)
local spGetDefID=Spring.GetUnitDefID
PersPackage.hp=hp --To be sure

x,y,z=Spring.GetUnitPosition(unitid)
	if dist2Vec (x,y,z,Pos.x,Pos.y,Pos.z) < 150  then
	--Does Building allready exist--
	UnitsAtSpot=Spring.GetUnitsInCylinder(x,z,125)
	Building={}
	for i=1,#UnitsAtSpot do
		if spGetDefID(UnitsAtSpot[i])==BuildTargetDefID then
			Building[#Building+1]=UnitsAtSpot[i]
		end
	end
	
	--are we building it allready?
	
	if #Building > 0 then
	local buildID=Building[1]
		--is it getting builded -- support
	_,_,_,_,bP= Spring.GetUnitHealth(buildID)
		if bP >= 1 then 
		-- we are done here  
		return 
		else 
		--Give CommandToUnit
		Command(unitid,"assist",buildID)
		return frame+90 ,PersPackage
		end
	else -- the building is not yet existant
		Command(unitid,"build",BuildTargetDefID)
		frame+90 ,PersPackage
	end


	else
	--was unit attacked or is in danger (abort)
		if Spring.GetUnitHealth(unitid)* (2/3) < hp then
		return RetreatHarasss(id, frame, PersPackage)
		else
		--how long did we spend timewise to accomplish the mission
			--if too long abort (mapsize/velocity 
		Spring.SetUnitMoveGoal(unitid,Pos.x,Pos.y,Pos.z)
		return frame+50,PersPackage
		end
	end
end


--Agressor
--[[Eventstream Function]]
--targetid
function ProtectGoal(id, frame, PersPackage)
local targetid=PersPackage.targetid
boolDoesUnitExist=Spring.GetUnitIsDead(targetid)
	if not  boolDoesUnitExist or boolDoesUnitExist ==false then
	return
	end
end

--[[Eventstream Function]]
--PersPackage expects unitid, [|target], Pos={x,y,z}
function controlledAgression(id, frame, PersPackage)
--Optimal Base Layout in Package
local unitid=PersPackage.unitid
local Pos=PersPackage.Pos
local BuildTargetDefID=PersPackage.defid
local hp= PersPackage.hp or Spring.GetUnitHealth(unitid)
local spGetDefID=Spring.GetUnitDefID
PersPackage.hp=hp --To be sure
PersPackage.armrange=PersPackage.armrange or GetMaxArmRange(Spring.GetUnitDefID(unitid))

x,y,z=Spring.GetUnitPosition(unitid)
	if dist2Vec (x,y,z,Pos.x,Pos.y,Pos.z) < PersPackage.armrange  then
	--We are nearby

	
	else
	--was unit attacked or is in danger (abort).y,Pos.z)
		return frame+50,PersPackage
		end
	



end

--[[Eventstream Function]]
--PersPackage needs Retreat Goal
function RetreatHarasss(id, frame, PersPackage)

end

--=====================================================HELPER FUNCTIONS

function GetMaxArmRange(defid)
--TODO Previous Definition
return 300
end

function GenericFinalize(id,frame,PersPackage)
teamid=Spring.GetUnitTeam(PersPackage.unitid)
unitid=PersPackage.unitid
assignedSubAI="Base"
father=unitid

returnUnitToPool(teamid,unitid, assignedSubAI,father)
end

function isUnitArmed(id)
vx=Spring.GetUnitWeaponVectors(id)
return vx ~= nil 
end