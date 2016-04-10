include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


function script.Create()
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitAlwaysVisible(unitID,true)
StartThread(timeTillBoom)
end

blink=piece"blink"
emitspot=piece"grenade"

local BOOM=3000

function timeTillBoom()
			Show(blink)
			for i=1,15, 1 do
			EmitSfx(blink,1025)
			Sleep(64)
			end

Spring.PlaySoundFile("sounds/bgmtw/grenade.ogg",1.0)
	Hide(blink)
	it=true
	period=512
	
		while BOOM > 0 do 
		BOOM=math.max(0,BOOM-period)
			if BOOM==0 then break end
		
		if it==true then 
		it =false 
		Show(blink)
			for i=1,8, 1 do
			EmitSfx(blink,1025)
			Sleep(64)
			end
		else 
		it=true 
		Hide(blink)
		Sleep(period)
		end
		
	
	end
	

	x,y,z=Spring.GetUnitPosition(unitID)
	T=getAllInCircle(x,z,100,unitID)
	for i=1,#T do
	Spring.AddUnitDamage(T[i],90) 
	end
	
	Spring.SpawnCEG("tess",x,y+25,z,0,1,0,50,0)
	Spring.DestroyUnit(unitID,false,true)
end

function script.Killed(recentDamage,_)
return 1
end


