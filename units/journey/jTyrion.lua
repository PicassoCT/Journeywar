local unitName = "jtyrion"

local unitDef = {
name = "Traitor",
Description = "turns its Allegiance to your team upon Activation. <Sabotage>",
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



 
 
 

   

Category = [[NOTARGET TRAITOR]],





}

return lowerkeys({ [unitName] = unitDef })