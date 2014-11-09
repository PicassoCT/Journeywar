local unitName = "cBuildAnimation"
local unitDef = {
name = "building in Progress",
Description = "- under Construction",
objectName = "cbuiBlox.s3o",
script = "cBuildAnim.lua",
buildPic = "placeholder.png",
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