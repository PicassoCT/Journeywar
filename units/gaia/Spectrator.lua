local unitName = "Spectrator"

local unitDef = {
name = "JustLookingAtThings",
Description = "LookingAtMap",
objectName = "emptyObjectIsEmpty.s3o",
script = "spectratorscript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime =1,
--Health
maxDamage = 1200,
idleAutoHeal = 0,
--Movement



--MaxVelocity = 0.5,
MaxWaterDepth =10000,
--MovementClass = "Default2x2",--


sightDistance = 2000,

reclaimable=false,
Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false,


	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
 
 
 
 

   

Category = [[NOTARGET]],





}

return lowerkeys({ [unitName] = unitDef })