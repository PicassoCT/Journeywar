include "suddenDeath.lua"


--unitPieces


function script.Activate()
				       --activates the secondary weapon 

					return 1
					end

		function script.Deactivate()
		  --deactivates the secondary weapon 

				--return 0
				return 0
		end


 

 


function script.StartMoving()

    
end

function script.StopMoving()



end





function script.Create()
--test


end

function script.HitByWeapon(damage)
hp=Spring.GetUnitHealth(unitID)
if hp-damage < 0 then 
Spring.SetUnitCrashing(unitID, true)
Spring.SetUnitNeutral(unitID,true)
Spring.SetUnitCOBValue(unitID, COB.CRASHING, 1)
end

end

function script.Killed()


return 0
end
center=piece"center"

	function script.AimFromWeapon1() 	
		
	--	EmitSfx(frontAppendixTable[1],1025)	
	return center
	end
		

		
		function script.AimWeapon1( heading, pitch )
		
		   return true
		end
		

	function script.FireWeapon1()

	   end




