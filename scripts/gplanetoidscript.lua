include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
orbit1=piece"orbit1"
Moon=piece"Moon"


function script.Create()
		Move(center,y_axis,1200,0)
		Turn(center,z_axis,math.rad(math.random(-92,92)),0)
		Spin(Moon,y_axis,math.rad(math.random(-12,12)),0)
		Spin(orbit1,z_axis,math.rad(math.random(-1,1)),0)
		Spin(orbit1,y_axis,math.rad(math.random(-12,12)),0)
	Turn(orbit1,x_axis,math.rad(math.random(-12,12)),0)

	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	process(TablesOfPiecesGroups["ring"],
	function (id)
	Spin(id,y_axis,math.rad(math.random(-4,4)),0)
	Turn(id,x_axis,math.rad(math.random(-12,12)),0)
	end
	)
	Turn(TablesOfPiecesGroups["ring"][6],z_axis,math.rad(90),0)
	StopSpin(TablesOfPiecesGroups["ring"][6],y_axis)	
		Spin(TablesOfPiecesGroups["ring"][6],x_axis,math.rad(math.random(-4,4)),0)
end

function script.Killed(recentDamage,_)

return 1
end

