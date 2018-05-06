include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}
emptyNessy=piece"emptyNessy"
Quader01=piece"Quader01"
function script.HitByWeapon(x, z, weaponDefID, damage)
end

boolCreatorIdentifyied=false
CreatorID = {}


function creatorIdentifyCall(creatorID)
boolCreatorIdentifyied=true
CreatorID= creatorID

end

function addInhabitants(T)
for k,v in pairs(T) do
	inhabitants[k]={}
	inhabitants[k].x,inhabitants[k].y,inhabitants[k].z = Spring.GetUnitPosition(v)
end

end

function ReleaseAllInside()



end

function extractNewEntrys(T)
return process(T,
					function (id)
						if inhabitants[id] then return end
					
					defID= Spring.GetUnitDefID(id)
						if 	not inhabitants[id] and 
							not nonRessurectabbleTypes[defID] and
							not buildingTypes[defID]
							then
							x,y,z =Spring.GetUnitPosition(id)
						inhabitants[id]={
											ox=x,
											oy=y,
											oz=z,
											defID= defID				
										}
							return id
						end
					end)
end
					
function ContainsSeveralSides(T)
Teams={}
process(T,
		function(id)
		teamID= Spring.GetUnitTeam(id)
		Teams[teamID]=true
		end
		)
return count(Teams) > 1 
end

function filterOutMissing(newT, oldT)
missingUnits={}
process(oldT,
		function(id)
			if not newT[id] then
			missingUnits[id]=id 
			end
		end
		)
return missingUnits
end

function getRecentSuicidees(T)




return T
end

function resetEscapees(T)
	process(T,
			function(id)
				boolUnitIsDead= Spring.GetUnitIsDead(id)
					if boolUnitIsDead and boolUnitIsDead== false then
						px,py,pz= Spring.GetUnitPosition(id)
						px,py,pz= px-x,py-y,pz-z 
						t= normN(px,py,pz)
						Spring.SetUnitPosition(id, 
						x+t[1]*Radius ,
						y+t[2]*Radius ,
						y+t[3]*Radius )
					end
				end
			)
end

OrgRadius= 900
Radius=OrgRadius
inhabitants={
--[id] = {ox,oy,oz}

}
x,y,z=Spring.GetUnitPosition(unitID)
nonRessurectabbleTypes= mergeDict( getAbstractTypes(UnitDefNames),getJourneyCorpseTypeTable(UnitDefNames))
buildingTypes= getAllBuildingTypes()
mirrorBubbleTransformationTable= getMirrorBubbleTransformationTable()
equivalentUnitTransformTypeTable= getEquivalentMirrorTransformTypeTable()
boolRestStarted=false

function mirrorBubble()
	Command(unitID,"setactive",{},{0})
	T= getAllInSphere(x,y,z,Radius,unitID)
	if not T then destroyMirrorBubble() end
	mirroredUnits={}
	
	if ContainsSeveralSides(T) == false then
		if fairRandom("jmirrorbubble"..Spring.GetUnitTeam(unitID), 0.5)==false then
			createSoleSurvivor()
		else
			mirroredUnits=createMirroredTeam(T)
		end
	end
	--if none of my team- create mirror units
	T= getAllInSphere(x,y,z,Radius,unitID)
	OldT= T
	while ContainsSeveralSides(T)==true do
		Radius= Radius+1/1000
		Sleep(30)
	
		T = getAllInSphere(x,y,z,Radius,unitID)
		if not T or #T < 1 then
			killMirrorBubble()
		end
		
		newOnes = extractNewEntrys(T)
		addInhabitants(newOnes)
		missingOnes = filterOutMissing(T,OldT)		
		resetEscapees(missingOnes)
		
		if #newOnes > 0 and boolResetStarted == false then
			boolResetStarted=true
			StartThread(startReset)
			while boolResetStarted== true do
				Sleep(1000)
			end
		end
	--Check for
		
			-- Währendessen bildet die Bubble eine Skulptur
		
		
		--Stirbt das projezierende Shrike getötet oder Abgelenkt, entsteht eine Skulptur, die solange existiert,
		--wie die Bubble existiert hat
		--Einheiten die in einer Timebubble sind, können diese nicht verlassen, solange
		--Ein Shroudshrike kann in  seiner eigenen Blase gefangen sein
		
		--Skulptur ist eine Einheit die a)entweder in einem Orbit schwebt
									--  b) Stillsteht
									

	end
end
TOTAL_SCULPTURE_TIME= 20000
function startReset()
	-- reset whole bubble and build a sculpture for the time		
			restoreTheDeadExceptGaia(inhabitants)
			restTime=TOTAL_SCULPTURE_TIME
			makeASculpture(inhabitants)		
			while restTime > 0 do
				newOnes = extractNewEntrys(getAllInSphere(x,y,z,Radius,unitID))
				addInhabitants(newOnes)
				if #newOnes > 0 then
					restTime = TOTAL_SCULPTURE_TIME
					makeASculpture(newOnes)	
				else
					restTime=restTime-100				
				end
				Sleep(1000)
			end			
		
				sendUnitsBackToStartPosition()
				process(T,
						function(id)
								transformUnitInto(
									id,
									mirrorBubbleTransformationTable[Spring.GetUnitDefID(id)]
									)
						end
						)
			
	boolResetStarted= false
end

function cycleCenterReset(center, uID,  radius, startNumber, total,  speedInFramesForFullCircle, xOffset, ResetPosition)
	Spring.MoveCtrl.Enable(uID)
	startPos= {x=0,y=center.y,z=0}
	startPos.x,startPos.z= drehMatrix(center.x+radius,center.y, (startNumber/total)*math.pi*2)
	currPos=startPos
	startFrame= Spring.GetGameFrame()

	while boolResetStarted do
		currentFrame= Spring.GetGameFrame()
		currDegInRad=  ((((currentFrame-startFrame))%speedInFramesForFullCircle)/speedInFramesForFullCircle)*math.pi*2
		currPos.x,currPos.z=	drehMatrix(startPos.x,startPos.z, currDegInRad)
	   Spring.MoveCtrl.SetPosition(uID, currPos.x, currPos.y, currPos.z)
		Sleep(33)
	end
	
	Spring.MoveCtrl.SetPosition(uID, ResetPosition.x, ResetPosition.y, ResetPosition.z)
	Spring.MoveCtrl.Disable(uID)
end

--> Forms a Ring like strucuture
function formARing(center, members, distribution, x_offset )
	for i=1, #members do
		StartThread(cycleCenterReset,
		{x=center.x+math.random(-50,50),y=center.y, z= =center.z + math.random(-50,50)},
		members[i],
		math.random(50,	350),
		i,
		#members,
		math.random(15,40)* 30,
		math.random(-10,10),
		inhabitants[members[i]]
		)
	end


end


-- a sculpture consist of  rings of orbiting
function makeASculpture(T)
ringNumber = math.random(2,7)





end

function killMirrorBubble()

endfunction watchCreator()
while boolCreatorIdentifyied== false do Sleep(100) end

	while Spring.GetUnitIsDead(CreatorID)== false do
	Sleep(100)

	end
	ReleaseAllInside()
	killAnimation()
	Spring.DestroyUnit(unitID,true,false)

end
function initStartThread()
	DelayTillComplete(unitID)
	Command()
	StartThread(watchCreator)
end

function script.Create()
	Move(Quader01,x_axis, 50, 0)
	Spin(emptyNessy,y_axis,math.rad(42),0)
	Spring.SetUnitNeutral(unitID,true)
	Spring.SetUnitNoBlocking(unitID,true)
	Spring.MoveCtrl.Enable(unitID,true)
	
	StartThread(initStartThread)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)

end


function killAnimation()


end
function script.Killed(recentDamage, _)
	killAnimation()
    
    return 1
end



function script.StartMoving()
end

function script.StopMoving()
end

function script.Activate()

    return 1
end

function script.Deactivate()

    return 0
end

