include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}
_,heightOfAsteroidsOverMap= Spring.GetGroundExtremes()
degreeOfAsteroidBelt= math.random(0,12)

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"


function script.Create()
	Spring.SetUnitAlwaysVisible(unitID,true)
	Spring.SetUnitNeutral(unitID,true)
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	 Spring.MoveCtrl.Enable(unitID,true)
	 x,y,z=Spring.GetUnitPosition(unitID)
	Spring.MoveCtrl.SetPosition(unitID,x,heightOfAsteroidsOverMap,z)
	Turn(center,y_axis,math.rad(degreeOfAsteroidBelt),0)
	StartThread(releaseAnimationThreads)
end
function loopMovement(pieceID,offset,speed,delay,startOffset)
	while true do
	
	Hide(pieceID)
	Sleep(delay)
	Move(pieceID,z_axis,-1*offset - startOffset,0)
	Show(pieceID)
	Move(pieceID,z_axis,offset + startOffset,speed)
	WaitForMove(pieceID,z_axis)
	Sleep(10)
	end
end

function releaseAnimationThreads()
asteroid=TablesOfPiecesGroups["asteroid"]
bolderorbit=TablesOfPiecesGroups["boldorbit"]
bolder=TablesOfPiecesGroups["bolder"]
process(asteroid,
		function(id)
		if math.random(0,1)== 1 then
		Show(id)
		else 
		Hide(id)
		return 
		end


		--Position
		yOffset=math.random(0,150)
		Move(id,y_axis,yOffset,0)
		
		--Movement
		offset=1800
		speed=math.random(3,7)
		delay=math.random(100,8000)
		startOffset= math.random(-600,600)
		StartThread(loopMovement,id,offset,speed, delay,startOffset)
		
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
		
process(bolder,
		function(id)
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
