
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
swingCenter=piece"swingCenter"
diamond=piece"diamond"

function script.Create()
Hide(diamond)
Turn(center,y_axis,y_axis,math.rad(math.random(-360,360)),0)
Turn(swingCenter,y_axis,math.rad(-90),0)
Turn(swingCenter,y_axis,math.rad(0),32)
StartThread(Sfx)
WaitForTurn(swingCenter,y_axis)
StartThread(Impact)
end

boolSFX=true

function Sfx ()
	while boolSFX==true do 
	EmitSfx(diamond,1024)
	EmitSfx(diamond,1025)
	Sleep(50)
	end

--ImpactSfx

	for i=1,20 do
	EmitSfx(diamond,1026)
	Sleep(i*10)
	end
	
end

function Impact()
x,y,z=Spring.GetUnitPosition(unitID)
 T= grabEveryone(unitID,x,z,75)
 process(T, function(element) Spring.DestroyUnit(element)  end)

end


function script.Killed(recentDamage,_)
return 1
end

