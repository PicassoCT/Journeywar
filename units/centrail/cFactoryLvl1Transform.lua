local unitName = "cfactorylvl1transform"
local unitDef = {
	name = "Nanoforge",
	Description = "transforms if supplied in time into a Lvl2 Factory",
	objectName = "cUpgrBlox.s3o",
	script = "cfactorylvl1transformscript.lua",
	buildPic = "placeholder.png",
	--cost
	maxdamage=3000,
	nanocolor=[[0 0.9 0.9]],
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	FootprintX = 12,
	FootprintZ = 12,
	
	  customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:cbuildCubeDisolveSfx",
	   		
				  
				   
				},
				},
 

}
return lowerkeys({ [unitName] = unitDef })