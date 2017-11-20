local weaponName="comendsmg"
local weaponDef={
    name                    = "Sub Maschine Gun",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 25,
				HeavyArmor = 5,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 0.25,
		  range                   = 450,
		  sprayAngle              = 300,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  
				impulseboost = 0.12300000339746,
				impulsefactor = 0.12300000339746,
		  burst=2,
		  burstrate=0.2,
		  soundStart         = "sounds/cComEnder/submg.ogg",
		  soundtrigger=1,
		  SweepFire=1,
		  --apperance
		  rgbColor                = [[0.12 0.9 0.9]],	
		  cegTag = "machinegunproj",		  
          size                    = 2.25,
	      stages                  = 20,
		  separation              = 3,


}

return lowerkeys ({[weaponName]=weaponDef})