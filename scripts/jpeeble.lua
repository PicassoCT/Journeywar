
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

jpeeble=piece("jpeeble")

function script.Create()


Spring.SetUnitNeutral(unitID,true)
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitAlwaysVisible(unitID,true)
StartThread(delayedRising)
end

function script.Killed(recentDamage,_)

return 1
end


function delayedRising()
Hide(jpeeble)
Move(jpeeble,y_axis,-25,0)
delay=math.ceil(math.random(100,900))
Sleep(delay)
Show(jpeeble)
Move(jpeeble,y_axis,65,49.35)
local d=1
	EmitSfx(jpeeble,1025)
	while (true==Spring.UnitScript.IsInMove (jpeeble, y_axis)) do
	d=d+1
	EmitSfx(jpeeble,1024)
	
	Sleep(50)
	end
	EmitSfx(jpeeble,1025)
Spin(jpeeble,y_axis,math.random(-42,42),0.001)
Move(jpeeble,y_axis,400,39.35)

	WaitForMove(jpeeble,y_axis)

Spring.DestroyUnit(unitID,true,true)
end
