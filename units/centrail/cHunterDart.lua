local unitName = "chunterdart"
local unitDef = {
name = "dart",
Description = " 3.. 2... 1 <Projectile>",
objectName = "cHunterdart.s3o",
script = "jhunterdart_script.lua",
buildPic = "placeholder.png",
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
Category = [[NOTARGET]],
 sfxtypes = {
				explosiongenerators = {				  
	   		    "custom:antimatter",
					 "custom:antimatter"
				  
				   
				},
				},
 
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
 

}
return lowerkeys({ [unitName] = unitDef })