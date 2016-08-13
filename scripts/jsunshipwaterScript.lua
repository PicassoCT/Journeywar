include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}
MAXFORCELOOP=7
function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

Main= piece"Main"
circDanceCenter= piece"circDanceCenter"
crysCenter= piece"crysCenter"

function script.Create()
	--generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	StartThread(releaseTimer)
	hideAllNonVitalPieces()
	StartForceRotators()
	StartThread(CrystallAnimations)
	StartThread(sunCycle)
	
end

function CrystallAnimations()
	Spin(Main,y_axis,math.rad(math.random(-math.pi,math.pi)))
	value=math.random(-math.pi,math.pi)
	Spin(circDanceCenter,y_axis,math.rad(value))
	Spin(crysCenter,y_axis,math.rad(value*-1))
	while true do
	WMove (crysCenter,y_axis, math.random(-10,10),0.5)
	Sleep(100)	
	end
end

function releaseTimer()
_,_,_,_,BuildProgress  = Spring.GetUnitHealth(unitID)
	while BuildProgress < 1 do
		_,_,_,_,BuildProgress = Spring.GetUnitHealth(unitID)
		Sleep(1000)
	end

	boolSunshipActivateable=true
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

function script.StartMoving()

end

function script.StopMoving()
		
		
end

boolSunshipActivateable=false
function script.Activate()
	if boolSunshipActivateable == true then
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID= Spring.GetUnitTeam(unitID)
		if x and teamID then
		Spring.Echo("Give birth")
		id=Spring.CreateUnit("jsunshipfire", x, y, z, 1, teamID)
			if id then
			Spring.Echo("Die off")
			Spring.DestroyUnit(unitID,true,true) end
		end
	end
return 1
end

function script.Deactivate()


return 0
end

function script.QueryBuildInfo() 
  return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})

function StartForceRotators()
	for i=1, MAXFORCELOOP,1 do
	Turn(TablesOfPiecesGroups["lopRot"][i],y_axis,math.random(-math.pi,math.pi),0,true)
	Spin(TablesOfPiecesGroups["lopRot"][i],y_axis, math.rad(math.random(-55,55)))
	Spin(TablesOfPiecesGroups["forceLoop"][i],z_axis, math.rad(math.random(-55,-35)))
	Spin(TablesOfPiecesGroups["outRot"][i],y_axis, math.rad(math.random(75,155)*randSign()))
		if math.random(0,1)==1 then Spin(TablesOfPiecesGroups["gate"][i],y_axis, math.rad(math.random(75,155)*randSign())) end
	end
	StartThread(hideAndSeek)
end

function hideAndSeek()
	while true do
		for i=1, MAXFORCELOOP,1 do
		x,y,z=Spring.GetUnitPiecePosDir(unitID,TablesOfPiecesGroups["outRot"][i])
		gh= Spring.GetGroundHeight(x,z)

			if gh > y  then
				Hide(TablesOfPiecesGroups["outRot"][i])
				Hide(TablesOfPiecesGroups["forceLoop"][i])
				Hide(TablesOfPiecesGroups["gate"][i])

			else
				Show(TablesOfPiecesGroups["outRot"][i])
				Show(TablesOfPiecesGroups["forceLoop"][i])
				Show(TablesOfPiecesGroups["gate"][i])
			end
		end
	Sleep(100)
	end
end

function sunCycle(liveTime)
spinT(TablesOfPiecesGroups["Sun"],y_axis,math.random(-22,22))
hideT(TablesOfPiecesGroups["Sun"])
for i=1,#TablesOfPiecesGroups["Sun"] do
Show(TablesOfPiecesGroups["Sun"][i])
Sleep(math.ceil(liveTime/#TablesOfPiecesGroups["Sun"]))
if TablesOfPiecesGroups["Sun"][i-1] then
Hide(TablesOfPiecesGroups["Sun"][i-1])
end

end

end

function hideAllNonVitalPieces()
hideT(TablesOfPiecesGroups["Sun"])
hideT(TablesOfPiecesGroups["water"])

end