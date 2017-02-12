local weaponName="sentrynellAA"
local weaponDef={
	name="sentrynellAA",
	
	weaponType = [[BeamLaser]],
	
	beamweapon=1,
	-- beamlaser=1,
	-- WeaponAcceleration=0,
	accuracy = 0,
	
	laserflaresize = 3,--0.3
	beamTtl= 0.15,--0.01
	movingaccuracy=5000,
	predictBoost=1.5,
	areaOfEffect = 1,
	avoidFriendly = true,
	soundtrigger = true,
	
	collideFriendly = false,
	
	beamtime = 1,--0.01
	
	FireSubmersed=0,
	
	impulseFactor = 0.1,
	largeBeamLaser = true,
	lineOfSight = false,
	
	--explosiongenerator = "custom:smallblueburn",
	targetMoveError=0.5,
	noSelfDamage = true,
	range = 2350,
	reloadtime = 2.0,
	renderType = 0,
	
	sweepfire=false,
	
	turret 	 =true,
	soundHit = "sounds/sentry/sentryAAHit.wav",
	soundStart = "sounds/sentry/sentryAAFire.wav",
	FireStarter = 0,
	coreThickness=0.3,
	thickness = 2.5,
	--rgbColor = [[1 0.4 0.25]],
	rgbColor = [[0 1 0.9]],
	rgbColor2 = [[0.1 1 1]],
	HardStop=1,--test It
	Intensity=1.4,--test It
	scrollspeed=0.3,
	
	explosionGenerator="custom:sentrynellimpact",
	tolerance = 1000,
	
	damage = {
		default = 350,
		HeavyArmor =25,
	},
	
	
	
	
}

return lowerkeys ({[weaponName]=weaponDef})