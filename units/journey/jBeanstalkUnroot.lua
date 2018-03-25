local unitName = "jbeanstalkunroot"
local unitDef = {
	name = "Unroot Beanstalk",
	Description = " the beanstalk rips its root out of the ground to travell along the surface. <Ability>",
	objectName = "emptyObjectIsEmpty.s3o",
	script = "placeholder.lua",
	buildPic = "jupgrade.png",
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