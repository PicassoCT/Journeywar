include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}
heightOfAsteroidsOverMap= 250
degreeOfAsteroidBelt= math.random(-42,42)

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"


function script.Create()
	Spring.SetUnitAlwaysVisible(unitID,true)
	Spring.SetUnitNeutral(unitID,true)
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	Move(center,y_axis,heightOfAsteroidsOverMap,0)
	Turn(center,y_axis,math.rad(degreeOfAsteroidBelt),0)
	StartThread(releaseAnimationThreads)
end
function loopMovement(pieceID,offset,speed)
	while true do
	Hide(pieceID)
	Move(pieceID,x_axis,-1*offset,0)
	Show(pieceID)
	Move(pieceID,x_axis,offset,speed)
	WaitForMove(pieceID,x_axis)
	Sleep(10)
	end
end

function releaseAnimationThreads()
asteroid=TablesOfPiecesGroups["asteroid"]
bolderorbit=TablesOfPiecesGroups["boldorbit"]
process(asteroid,
		function(id)
		if maRa()== true then
		Show(id)
		else 
		Hide(id)
		end
		return id
		end
		,
		function(id)
		--Position
		yOffset=math.random(0,250)
		Move(id,y_axis,yOffset,0)
		
		--Movement
		offset=math.random(360,900)
		speed=math.random(3,7)
		StartThread(loopMovement,id,offset,speed)
		
		--Spin
		Spin(id,y_axis,math.rad(math.random(-42,42)),0.1)
		if maRa()==true then 
			Spin(id,z_axis,math.rad(math.random(-42,42)),0.1)
		end
		end
		)

process(bolderorbit,
		function(id)
			Move(id,x_axis,math.random(0,50),0)
			Spin(id,y_axis,math.rad(math.random(-42,42)),0)
		end
		)

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
