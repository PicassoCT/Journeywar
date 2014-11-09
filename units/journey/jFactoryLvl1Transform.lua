local unitName = "jfactorylvl1transform"
local unitDef = {
name = "Cocoon",
Description = "transforms if fed with units into a Heighborn DNA-weaver",
objectName = "jConcon.s3o",
script = "jfactorylvl1transformscript.lua",
buildPic = "placeholderj.png",
--cost
	maxdamage=1050,
nanocolor=[[0 0.9 0.9]],
	  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
	FootprintX = 10,
	FootprintZ = 10,
	
	  customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:cbuildCubeDisolveSfx",
	   		
				  
				   
				},
				},
 

}
return lowerkeys({ [unitName] = unitDef })