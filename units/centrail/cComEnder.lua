local unitName = "ccomender"
local unitDef = {
name = "ComEnder",
Description = "You in a armoured Suit - Memento Mori",
objectName = "cComEnder.s3o",
script = "cComEnderScript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 1100,
buildCostEnergy = 560,
buildTime = 46,
--Health
maxDamage = 7500,
idleAutoHeal = 2,
--Movement
Acceleration = 0.5,
BrakeRate = 0.3,
FootprintX = 5,
FootprintZ = 5,
MaxSlope = 4,
MaxVelocity = 5.0,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 300,
nanocolor=[[0 0.9 0.9]],
radardistance=150,
sightDistance = 700,

explodeAs = "defaultweapon",
EnergyStorage = 200,
	EnergyUse = 35,
	MetalStorage = 0,
	EnergyMake = 13, 
	MakesMetal = 0, 
	MetalMake = 0,	
	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat", 
CanBeAssisted = false,	
mass=8096,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
CanCloak= true,
cloakCost = 5.0,
LeaveTracks = true,
  trackType ="comend",
  trackStrength=32,
  trackWidth =64,
  trackOffset =0,

onoffable=true, --used for turning the electricity on/off

Builder = true,
ShowNanoSpray = true,
CanBeAssisted = false,
pushResistant=true,
nanocolor=[[0.5 0.9 0.5]], --
CanReclaim=false,	
workerTime = 0.1,
buildDistance = 75,
terraformSpeed = 350,
SelfDestructAs="electric_explosion",
showPlayerName =true,
unitRestricted =1,
buildoptions = 
	{
	--"crazordrone","chopper",
	},
	

explodeAs = "factory_explosion",
	 customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:factory_explosion",
	   "custom:dirt",
	   "custom:electric_explosion",
	   "custom:AR2Muzzle",				--1027
	   	"custom:ccssfxcontract",
		"custom:ccssfxexpand",
		"custom:shells"  --1030
						  },
	
				},


weapons = {

--GrenadeLaunchers
[1]={name  = "cnukegrenadelvl1",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "cnukegrenadelvl2",
	onlyTargetCategory = [[LAND]],
	},		
[3]={name  = "cnukegrenadelvl3",
	onlyTargetCategory = [[LAND]],
	},
[4]={name  = "comendsniper",--do not change
	onlyTargetCategory = [[LAND]],
	},
[5]={name  = "comendsmg",
	onlyTargetCategory = [[LAND AIR]],
	},
[6]={name  = "ceater",
	onlyTargetCategory = [[LAND AIR WATER]],
	},
[7]={name  = "shotgunnogamble",
 onlyTargetCategory = [[LAND AIR]],
	},
[8]={name  = "tractorbeam",
	onlyTargetCategory = [[LAND AIR]],
	},
[9]={name  = "flaregun",
	onlyTargetCategory = [[LAND]],
	},	
[10]={name  = "slicergun",
	onlyTargetCategory = [[LAND]],
	},	
[11]={name  = "crazorgrenade",
	onlyTargetCategory = [[LAND]],
	},
[12]={name  = "ctanglegun",
	onlyTargetCategory = [[LAND]],
	},
[13]={name  = "aarocket",
	onlyTargetCategory = [[AIR]],
	},	
[14]={name  = "grocket",
	onlyTargetCategory = [[LAND WATER]],
	},	
	
-- [7]={name  = "aarocket",
	-- onlyTargetCategory = [[AIR]],
	-- },



			--//1 MaschineGun
			--//3 Lvl1 Shotun
			--//4 Lvl2 Shotgun
			--//5 Lvl3 Shotgun
		},
Category = [[LAND]],
		
}
return lowerkeys({ [unitName] = unitDef })