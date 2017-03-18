local unitName = "jupgradefactory2"

local unitDef = {
	name = "Upgrade to Infinity Craddle",
	Description = " Needs to be in water and constantly fed to succeed.",
	objectName = "emptyObjectIsEmpty.s3o",
	script = "not_implemented_yet.lua",
	buildPic = "nanoupgrade.dds",
	--floater = true,
	--cost
	buildCostMetal = 0,
	buildCostEnergy = 0,
	buildTime =1,
	--Health
	maxDamage = 1200,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 5,
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
	--MovementClass = "Default2x2",--
	
	
	sightDistance = 300,
	explodeAs="zombieweapon",
	selfDestructAs="zombieweapon",
	
	
	
	Category = [[NONTARGET]],
	
	
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			
			
			
			
		},
		
	},
	
}

return lowerkeys({ [unitName] = unitDef })