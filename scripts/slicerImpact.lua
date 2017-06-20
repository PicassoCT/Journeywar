include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
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
	return 1
end

function getAttackVector(victimid)
	dx,dy,dz=math.random(-100,100)/100, math.random(-100,100)/100, math.random(-100,100)/100
	attacker=Spring.GetUnitLastAttacker(victimid)
	
	if attacker then
		attackVector=vectorUnitToUnit(victimid,attacker)*-1
		return attackVector.x,attackVector.y,attackVector.z
	end
	return dx,dy,dz
end

function ThreadStarter()
existenceCounter=0
	while (not GG.SlicerTable or not GG.SlicerTable[unitID]) and existenceCounter < 50 do
		existenceCounter=existenceCounter+1
		Sleep(100)
	end
	if existenceCounter== 50 then Spring.DestroyUnit(unitID,false,true) end
	
	victimid= GG.SlicerTable[unitID]

	Sleep(100)
	x,y,z=Spring.GetUnitPosition(vicID)
	dx,dy,dz= getAttackVector(victimid)
	Turn(rotaryCenter,y_axis,math.rad(dy),0)
	Turn(rotaryCenter,x_axis,math.rad(dx),0)
	Show(DropOut)
	Show(SliceCylin)
	Move(DropOut,y_axis,-35.5,12)
	Hide(DropOut)
	
	for i=1,22 do
		EmitSfx(DropOut,1025)
		Time=math.ceil(math.random(10,125))
		Sleep(Time)
	end
		WaitForMove(DropOut,y_axis)
	Spring.DestroyUnit(vicID,false,true)
	 GG.SlicerTable[unitID]=nil
	Spring.DestroyUnit(unitID,false,true)
	

end

