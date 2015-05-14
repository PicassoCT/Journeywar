include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 


rotaryCenter=piece"rotaryCenter"
DropOut=piece"DropOut"
SliceCylin=piece"SliceCylin"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


function script.Create()
Hide(rotaryCenter)
Hide(DropOut)
Hide(SliceCylin)
StartThread(ThreadStarter)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

function ThreadStarter()
while boolKillHim==false do

	Sleep(100)
end
Sleep(100)
x,y,z=Spring.GetUnitPosition(vicID)
	Spring.MoveCtrl.SetPosition(unitID,x,y,z)

Turn(rotaryCenter,y_axis,math.rad(math.random(-360,360)),0)
Turn(rotaryCenter,x_axis,math.rad(math.random(-160,-95)),0)
Show(DropOut)
Show(SliceCylin)
Move(DropOut,y_axis,-35.5,12)
WaitForMove(DropOut,y_axis)
Hide(DropOut)

	for i=1,22 do
	EmitSfx(DropOut,1025)
	time=math.ceil(math.random(10,125))
	Sleep(time)
	end
Spring.DestroyUnit(vicID,false,true)
Spring.DestroyUnit(unitID,false,true)
	

end
vicID=0
boolKillHim=false
function youAreFuckingDead(victimid)
Spring.MoveCtrl.Enable(victimid,true)
Spring.MoveCtrl.Enable(unitID,true)
Spring.SetUnitBlocking(unitID,false)
Spring.SetUnitNoSelect(unitID,true)

vicID=victimid
boolKillHim=true
end




