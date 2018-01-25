initializeRaiderWeapons = function ()
	local T= {}
		
	for i=1, 11 do
		if i ==3 or i== 4 then
			T[i] = {
				name = "raiderarrow",
				onlyTargetCategory = [[ LAND ]],
			}
		
		elseif i == 8 or i==9 then
			T[i] = {
				name = "raiderflak",
				onlyTargetCategory = [[ AIR ]],
			}
			elseif i >9  then
			T[i] = {
				name = "raidercannon",
				onlyTargetCategory = [[ LAND ]],
			}
		
		else
		T[i] = {
				name = "raidermg",
				onlyTargetCategory = [[ LAND ]],
			}		
		end
	end
		return T
end

local unitName = "jmadmax"
local unitDef = {
	name = "Rebellraiders",
	Description = " rowdily ravaging in Revenge <Assault Harass Unit>",
	objectName = "jmadMax.s3o",
	script = "jmadmaxscript.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 350,
	buildCostEnergy = 150,
	buildTime = 15,
	--Health
	maxDamage = 50,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 1,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 15,
	
	MaxVelocity = 4.4,
	MaxWaterDepth = 2000,
	MovementClass = "Default2x2",
	TurnRate = 450,
	mass=10,


	sightDistance = 500,
	upright=true,
	Builder = false,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = false, 


	   
		weapons = initializeRaiderWeapons(),
		
		

	Category = [[LAND]],
	  customParams = {},
	 sfxtypes = {
		explosiongenerators = {
				"custom:bloodspray",
				"custom:dirt",
							  },
		
					},



					
			
}

return lowerkeys({ [unitName] = unitDef })




