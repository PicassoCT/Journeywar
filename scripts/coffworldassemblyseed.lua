include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


function script.Create()
StartThread(buildDistanceReached)
end

function script.Killed(recentDamage,_)

return 1
end



SIG_CROUCH=2
function script.StartMoving()
StartThread(crouch)
end

function script.StopMoving()
Signal(SIG_CROUCH)		
		
end
local c3=piece"c3"
local c2=piece"c2"
local c1=piece"c1"

function crouch()
SetSignalMask(SIG_CROUCH)
	while true do
	Move(c2,z_axis,13,6)
	Move(c1,z_axis,0,6)
	WaitForMove(c2,z_axis)
	Move(c3,z_axis,0,6)
	Move(c2,z_axis,26,6)
	Move(c1,z_axis,-13,6)
	WaitForMove(c1,z_axis)
	Move(c1,z_axis,-26,6)
	Move(c3,z_axis,12,6)
	WaitForMove(c1,z_axis)
	end

end
x,y,z=Spring.GetUnitPosition(unitID)

boolSetActive=false
boolChange=false
function buildDistanceReached()
tx,ty,tz=0,0,0
	while math.sqrt(tx*tx+ty*ty+tz*tz) < 200 do
	Sleep(200)
	nx,ny,nz=Spring.GetUnitPosition(unitID)
	tx,ty,tz=x-nx,y-ny,z-nz
	end
boolSetActive=true
	while boolChange==false do
	Sleep(200)
	end

x,y,z=Spring.GetUnitPosition(unitID)
teamid=Spring.GetUnitTeam(unitID)
Spring.CreateUnit("coffworldassembly",x,y,z,1,teamid)
Spring.DestroyUnit(unitID,true,false)
end

function script.Activate()
	if boolSetActive==true  then
	boolChange=true
	end
return 1
end

function script.Deactivate()

return 1
end

