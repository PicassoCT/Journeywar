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
CreatorID
function creatorIdentifyCall(creatorID)
boolCreatorIdentifyied=true
CreatorID= creatorID

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

OrgRadius= 900
Radius=OrgRadius
inhabitants={}
x,y,z=Spring.GetUnitPosition(unitID)
nonRessurectabbleTypes= mergeDict( getAbstractTypes(UnitDefNames),getJourneyCorpseTypeTable(UnitDefNames))
buildingTypes= getAllBuildingTypes(),
function mirrorBubble()
	Command(unitID,"setactive",{},{0})
	T= getAllInSphere(x,y,z,Radius,unitID)
	if ContainsSeveralSides(T) == false then
	
	end
	--if none of my team- create mirror units

	while ContainsSeveralSides()==true do
	Radius= Radius+1/1000
	Sleep(30)
	
	T= getAllInSphere(x,y,z,Radius,unitID)
	newOnes= extractNewEntrys(T)
	--Check for
		
		--Sie wächst langsam aber kontinuierlich, mit jedem darauf abgefeuerten Projektil (wirkt als Schild)
		--Begeht eine Einheit Selbstmord in einer Mirrorbubble, so wird die Bubble zurückgesetzt, alle Einheiten werden wiederhergestellt und transformiert
			-- Währendessen bildet die Bubble eine Skulptur
		
		
		--Stirbt das projezierende Shrike getötet oder Abgelenkt, entsteht eine Skulptur, die solange existiert,
		--wie die Bubble existiert hat
		--Einheiten die in einer Timebubble sind, können diese nicht verlassen, solange
		--Ein Shroudshrike kann in  seiner eigenen Blase gefangen sein
		
		--Skulptur ist eine Einheit die a)entweder in einem Orbit schwebt
									--  b) Stillsteht
									

	end
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

