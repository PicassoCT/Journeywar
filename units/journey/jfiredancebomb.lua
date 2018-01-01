local unitName = "jfiredancebomb"

local unitDef = {
name = "Flaming Firebomb",
Description = "growing towards the enemy <Anti Building Unit>",
objectName = "emptyObjectIsEmpty.s3o",
script = "jfirebombscript.lua",
buildPic = "placeholderj.png",
--floater = true,
maxDamage=900,
  	canattack=true,
	canguard=true,
	canmove=true,
	canpatrol=true,
	canstop=true,
	MovementClass = "Default2x2",
  moveState =2,
  noAutoFire =false,
  footprintX=2,
  footprintZ =2,
     
  upright =true,
  pushResistant =true,
  maxVelocity =0.2,
  acceleration =3.2,
  turnRate =265,

  leaveTracks =false,

 
	shootme=false,
	smoothanim=true,
	steeringmode=true,
  
  
  
  	sightdistance=303,
	radardistance=50,
	radardistancejam=0,
  
  	mass=550,

	


  selfDestructCountdown =0,
  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 150,
Category = [[LAND]],
  
  selfDestructAs ="jhoneypotW",
  explodeAs = "jhoneypotW",
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:firecolumn",
				  
				},
				},

}

return lowerkeys({ [unitName] = unitDef })