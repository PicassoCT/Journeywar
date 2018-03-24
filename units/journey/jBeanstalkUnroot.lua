local unitName = "jbeanstalkunroot"
local unitDef = {
	name = "unroot",
	Description = "transforms if fed with units into a Heighborn DNA-weaver <Upgrade>",
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