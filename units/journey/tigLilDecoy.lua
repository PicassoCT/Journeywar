local unitName = "tiglildecoy"

local unitDef = {
	name = "Tiger Lily",
	Description = "close Combatant with nano-structure solvent drenched Blades <Assault>",
	objectName = "tigLil.s3o",
	script = "tiglilscript.lua",
	buildPic = "jtiglil.png",
	decoyFor = "jtiglil",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 0,
	buildTime = 5,
	--Health
	maxDamage = 420,
	AutoHeal=22,
	idleAutoHeal = 30,
	idletime=1200,
	maxWaterdepth= 200,
	--Movement
	Acceleration = 0.7,
	BrakeRate = 0.5,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 83,
	MaxVelocity = 2.5,
	
	MovementClass = "jinfantry",
	TurnRate = 450,
	mass=420,
	
	--cloaking
	canCloak =true,
	cloakCost=0.01,
	cloakCostMoving =999,
	minCloakDistance =15,
	onoffable=true,
	
	selfDestructAs= [[NOWEAPON]],
	explodeAs = [[NOWEAPON]],
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:tiglilSparks" --comata removed
			
		},
		
	},
	
	corpse="jbiocorpse",
	sightDistance = 500,
	
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	smoothAnim = true,
	useSmoothMesh = true,
	Category = [[LAND]],
	nanocolor=[[0.6 0.9 0.5]],

}

return lowerkeys({ [unitName] = unitDef })