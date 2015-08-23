local unitName = "cmtwgrenade"
local unitDef = {
name = "Grenade",
Description = " 3.. 2... 1",
objectName = "cmtwgrenade.s3o",
script = "cmtwgrenade_script.lua",
buildPic = "placeholder.dds",
--cost
buildCostMetal = 100,
buildCostEnergy = 25,
buildTime = 5,
--Health
maxDamage = 50,
idleAutoHeal = 3,
--Movement
Acceleration = 0,
BrakeRate = 0,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
MaxVelocity = 0,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 5,
mass=950,
nanocolor=[[0 0.9 0.9]],
sightDistance = 450,
selfDestructAs= [[NOWEAPON]],
Builder = false,
CanAttack = true,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 
levelGround =false,
Category = [[LAND]],
 sfxtypes = {
				explosiongenerators = {				  
	   		         "custom:tess",
					 "custom:redlight"
				  
				   
				},
				},
 
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
 

}
return lowerkeys({ [unitName] = unitDef })