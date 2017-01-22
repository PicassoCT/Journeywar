---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jeliahbeam"
local weaponDef = {
	
	name = "eliah",
	weaponType = [[BeamLaser]],
	
	beamweapon=1,
	-- beamlaser=1,
	-- WeaponAcceleration=0,
	accuracy = 0,
	
	laserflaresize = 3,--0.3
	beamTtl= 0.05,--0.01
	movingaccuracy=5000,
	predictBoost=1.5,
	areaOfEffect = 1,
	avoidFriendly = true,
	soundtrigger = false,
	
	collideFriendly = true,
	
	beamtime = 2,--0.01
	
	FireSubmersed=0,	
	--impulseFactor = 0.025,
	largeBeamLaser = true,
	lineOfSight = false,
	
	--explosiongenerator = "custom:smallblueburn",
	targetMoveError=0.5,
	noSelfDamage = true,
	range = 400,
	reloadtime = 0.42,
	renderType = 0,	
	
	turret 	 = false,
	--	soundHit = "null",
	--soundStart = "null",
	FireStarter = 0,
	coreThickness=1.3,
	thickness = 9.5,
	
	rgbColor =[[0.2 0.4 0.5]],
	rgbColor2 =[[0.1 0.4 0.1]],
	HardStop=1,--test It
	Intensity=1.4,--test It
	scrollspeed=0.3,
	SweepFire=1,
	explosionGenerator="custom:smallblueburn",
	tolerance = 1000,
	
	damage = {
		default = 10,
		HeavyArmor =20,
	},
	
	
}
return lowerkeys({[weaponName] = weaponDef})