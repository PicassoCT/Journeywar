include "suddenDeath.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

function PositionChecked()
x,y,z=Spring.GetUnitPosition(unitID)
boolMeasure=true
	while boolMeasure==true do

	tx,ty,tz=Spring.GetUnitPosition(unitID)

		if math.abs(x-tx)+math.abs(z-tz) > 120 then boolMeasure=false end

	end
if GG.Convoy== nil then 
GG.Convoy={} 
end
GG.Convoy=GG.Convoy+1
rand=math.ceil(math.random(1400,2500))

Sleep(rand)
	if GG.Convoy == 1 then
		Spring.PlaySoundFile("sounds/Missions/shant1.wav",0.9)
		elseif GG.Convoy == 2 then
			Spring.PlaySoundFile("sounds/Missions/shant2.wav",0.9)
			else
				Spring.PlaySoundFile("sounds/Missions/shant3.wav",0.9)
			table.remove(GG,Convoy)
			end
	
end


function script.Create()
StartThread(PositionChecked)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
end




function script.StartMoving()

end

function script.StopMoving()
		
		
end

