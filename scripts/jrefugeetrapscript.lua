include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

piecesTable={}
center = piece"center" 
piecesTable[#piecesTable+1]= center
Station = piece"Station" 
piecesTable[#piecesTable+1]= Station
ShedTown = piece"ShedTown" 
piecesTable[#piecesTable+1]= ShedTown
Crane = piece"Crane" 
piecesTable[#piecesTable+1]= Crane
Car = piece"Car" 
piecesTable[#piecesTable+1]= Car
Observator = piece"Observator" 
piecesTable[#piecesTable+1]= Observator
RadarDish = piece"RadarDish" 
piecesTable[#piecesTable+1]= RadarDish
local TRAPRANGE=400
TIMETILLREVENGE=24000

function script.Create()
Hide(ShedTown)
Spin(RadarDish,y_axis,math.rad(42),0)
Spin(Car,y_axis,math.rad(0.42),0)
StartThread(randomRotate,Observator,y_axis, 1/3, -80,270)
StartThread(randomRotate,Crane,y_axis, 1/66, -10,15)
StartThread(randomRotate,Car,y_axis, 1/122, -350,350)
StartThread(CountPassingByEnemys)
end

--Keytable containing 
AllreadyPassingUnits={}
carcount=0
infcount=0
GoingBoom=false
function CountPassingByEnemys()
	x,y,z=Spring.GetUnitPosition(unitID)
	while true do
	T=grabEveryone(unitID,x,z, TRAPRANGE)
	T=filterTableByTable(T,AllreadyPassingUnits,function (element,T2) return T2[element]== nil end )
	AllreadyPassingUnits=insertKeysIntoTable(T,AllreadyPassingUnits)
	Sleep(300)

	count=countKey(AllreadyPassingUnits)

		if count > 1 and GoingBoom==false then
		GoingBoom=true
		StartThread(spawnUprising, TIMETILLREVENGE)
		end
	end
end

function countByType(Keytable)


end

function spawnUprising(RestTime)
Sleep(RestTime)
teamID=Spring.GetUnitTeam(unitID)
Spring.Echo("SpawningUprising")
	
	px,py,pz=Spring.GetUnitPiecePosDir(unitID,Car)
	for i=1,carcount do
	Show(Car)
		if px and UnitDefNames["jmadmax"] then 
		GG.UnitsToSpawn:PushCreateUnit("jmadmax",px,py,pz,0,teamID)
		Hide(Car)
		end
	Sleep(1000)
	end
	
	for i=1,infcount do
	px,py,pz=Spring.GetUnitPiecePosDir(unitID,Car)
		if px and UnitDefNames["jresistancewarrior"] then 
		GG.UnitsToSpawn:PushCreateUnit("jresistancewarrior",px,py,pz,0,teamID)
		end
	Sleep(500)
	end

end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
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

function script.QueryBuildInfo() 
  return center 
end

function script.QueryNanoPiece()
     return center
end

