local unitName = "jfactorylvl2transform"
local unitDef = {
name = "Cocoon",
Description = "transforms if fed with units into a Infinitys Craddle <Upgrade Building>",
objectName = "jConcon.s3o",
script = "jfactorylvl2transformscript.lua",
buildPic = "placeholderj.png",
--cost
	maxdamage=1050,
nanocolor=[[0 0.9 0.9]],
	  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
	FootprintX = 1,
	FootprintZ = 1,
	
	  customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:cbuildCubeDisolveSfx",
	   		
				  
				   
				},
				},
 

}
return lowerkeys({ [unitName] = unitDef })