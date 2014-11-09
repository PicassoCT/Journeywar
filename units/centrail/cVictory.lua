local unitName = "cVictory"

local unitDef = {
name = "Victory Statue",
Description = "TriumphantStatue",
objectName = "cVictoryStat.s3o",
script = "cVictoryStatue.lua",
buildPic = "placeholder.png",
--cost
	maxdamage=65000,
 EnergyStorage = 0,
	EnergyUse = 25,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 6, 
	MetalMake = 0,	

   NoWeapon=true,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
	
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	nanocolor=[[0 0.9 0.9]],
	
	
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",     
				   "custom:portalground",
				   "custom:fireworksred",
				   "custom:fireworksblue",
				   "custom:fireworksgreen",
				   "custom:fireworksorange",
				   "custom:flare",
				     --electric Sparc
				     --electric Sparc
				   
									},
				},

}

return lowerkeys({ [unitName] = unitDef })