local unitName = "jtyrion"

local unitDef = {
name = "All is allowed in love and war",
Description = "Press Activate to turn this units allegiance",
objectName = "emptyObjectIsEmpty.s3o",
script = "jytrion.lua",
buildPic = "placeholderj.png",
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
activateWhenBuilt= false,
onoffable=true,
reclaimable=false,
Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false,



 
 
 

   

Category = [[NOTARGET]],





}

return lowerkeys({ [unitName] = unitDef })