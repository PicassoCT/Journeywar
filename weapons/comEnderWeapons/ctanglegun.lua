local weaponName="ctanglegun"
local weaponDef={
	
	
	
	name="Tangle Gun",
	alphaDecay = 0.12,
	areaOfEffect = 16,	
	
	--cegTag = [[ctanglegunstrip]],
	craterBoost = 0,
	craterMult = 0,
	
	damage = {
		default = 1,
		planes = 1,
		subs = 1,
	},
	
	explosionGenerator = [[custom:cRailSparks]],

	impactOnly = true,
	impulseBoost = 0,
	impulseFactor = 1,
	interceptedByShieldType = 0,
	tolerance  = 3000,
	noExplode = true,
	
	range = 350,
	reloadtime = 3,
	rgbColor = [[0.5 1 1]],
	separation = 0.5,

	--soundHit = "sounds/cRailgun/railGunHit.wav",
	
	sprayangle = 800,
	stages = 1,
	fireStarter  = 35,
	turret = true,

	weaponType = [[Cannon]],
	weaponVelocity = 700,
	
}

return lowerkeys ({[weaponName]=weaponDef})