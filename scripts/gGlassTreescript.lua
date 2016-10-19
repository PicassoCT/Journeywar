--include "createCorpse.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

function spawnGrassDecals()
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
Sleep(25000)
	GG.UnitsToSpawn:PushCreateUnit("gdecgrass",x,0,z,0,teamID)
	
	while true do
	xplus=math.ceil(math.random(-75,75))
	zplus=math.ceil(math.random(-75,75))
	GG.UnitsToSpawn:PushCreateUnit("gdecgrass",x+xplus,0,z+zplus,0,teamID)
	Sleep(35000)
	end

end

gtree=piece"gtree"
treetop=piece"treetop"
center=piece"center"

function script.Create()
 Spring.SetUnitAlwaysVisible(unitID,true)
dice=math.random(-15,15)
Turn(center,y_axis,math.rad(dice),0)
StartThread(spawnGrassDecals)
StartThread(timeDelayedDestroy)
end

function timeDelayedDestroy()
time=30000*math.ceil(math.random(0,4))
Sleep(time)
Move(center,y_axis,-100,0.01)
WaitForMove(center,y_axis)
Spring.DestroyUnit(unitID,false,true)

end

function script.Killed(recentDamage,_)
Explode(gtree,  SFX.FIRE+SFX.SHATTER)
Move(treetop,y_axis,-32,96)
Sleep(300)
Explode(treetop, SFX.FIRE+SFX.SHATTER)
--createCorpseCUnitGeneric(recentDamage)
return 0
end




function script.StartMoving()

end

function script.StopMoving()
		
		
end

