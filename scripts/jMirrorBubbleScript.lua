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
			if Spring.GetUnitIsDead(id) == false and not newT[id] then
			missingUnits[id]=id 
			end
		end
		)
return missingUnits
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
		mirroredUnits=createMirroredTeam(T)
	else
		pairAndMorph(T)
	end
	--if none of my team- create mirror units
	T= getAllInSphere(x,y,z,Radius,unitID)
	OldT= T
	while ContainsSeveralSides(T)==true do
		Radius= Radius+1/1000
		Sleep(30)
	
		T = getAllInSphere(x,y,z,Radius,unitID)

		
		newOnes = extractNewEntrys(T)
		addInhabitants(newOnes)
		mirroredOnes=mirrorAddUnits(newOnes)
		addInhabitants(mirroredOnes)
		missingOnes = filterOutMissing(T,OldT)		
		resetEscapees(missingOnes)
		
	end
	
	T= getAllInSphere(x,y,z,Radius,unitID)
	doubleSurvivors(T)
	Spring.DestroyUnit(unitID,true,true)
end


function doubleSurvivors(T)
if T and #T > 0 then
teamID= Spring.GetUnitTeam(T[1])

process(T,
	function (id)
		createUnitAtUnit(teamID, Spring.GetUnitDefID(id), id,math.random(10,25)*randSign(),0,math.random(10,25)*randSign())
	end
	)
end
end



function killMirrorBubble()

end

function watchCreator()
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

	StartThread(watchCreator)
end

function script.Create()
	Move(Quader01,x_axis, 50, 0)
	Spin(emptyNessy,y_axis,math.rad(42),0)
	Spring.SetUnitNeutral(unitID,true)
	Spring.SetUnitBlocking(unitID,true)
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

