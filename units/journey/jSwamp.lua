local unitName = "jswamp"

local unitDef = {
name = "Deadly Swamp",
Description = "swallows Units. For every Unit the creating glowworm is revived once. <Trap>",
objectName = "jGlowSwamp.s3o",
script = "jGlowSwampScript.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime = 1,
--Health
maxDamage = 6666,
idleAutoHeal = 12,
--Movement


FootprintX = 6,
FootprintZ = 6,
MaxSlope = 15,

MaxWaterDepth = 200,



  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



sightDistance = 600,
upright=true,
Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false, 

Category = [[LAND]],
	YardMap ="oooooo oooooo oooooo oooooo oooooo oooooo",
  


  levelGround            = false,
  mass                   = 30000,

  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:fog",
				   "custom:leaves", --1028

				   --
				    --Bulletof The Cannon
				},
  }
  
  ------------------------




}

return lowerkeys({ [unitName] = unitDef })