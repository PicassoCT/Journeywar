	include "createCorpse.lua"
	include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

	--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 
	dart    =piece"dart"
	unfold  =piece"unfold"
	hatch   =piece"hatch"
	minebody=piece"minebody"
	center=piece"center"

	function script.Create()
	StartThread(retract)
	end

	function retract()
	Turn(dart,x_axis,math.rad(0),65)
	WaitForTurn(dart,x_axis)
	Move(unfold,y_axis,-15.6,12)
	WaitForMove(unfold,y_axis)
	Move(hatch,y_axis,-3,12)
	Move(minebody,y_axis,-75,19)
	WaitForMove(hatch,y_axis)
	WaitForMove(minebody,y_axis)
	Hide(minebody)
	Hide(hatch)
	Hide(dart)
	Hide(unfold)

	Spring.SetUnitAlwaysVisible(unitID,false)
	end

	function unFold()
	Spring.SetUnitAlwaysVisible(unitID,true)
	Show(minebody)
	Show(hatch)
	Show(dart)
	Show(unfold)
	Move(minebody,y_axis,-5,59)
	Move(hatch,y_axis,0,12)
	WaitForMove(hatch,y_axis)

	Move(unfold,y_axis,0.6,12)
	WaitForMove(unfold,y_axis)

	Turn(dart,x_axis,math.rad(-90),65)
	WaitForTurn(dart,x_axis)
	end

	function script.Killed(recentDamage,_)

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
		unFold()
		return true

	end
	 
	teamid=Spring.GetUnitTeam(unitID)
	function script.FireWeapon1()	
	x,y,z=Spring.GetUnitPiecePosDir(unitID,dart)
					id=Spring.CreateUnit("cdefusordart",x,y,z, 0, teamid)
					Hide(dart)
					ed=Spring.GetUnitNearestEnemy(id)
					ex,ey,ez=Spring.GetUnitPosition(ed)
					Spring.SetUnitMoveGoal(id,ex,ey,ez)

	retract()


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

	Spring.SetUnitNanoPieces(unitID,{ center})

