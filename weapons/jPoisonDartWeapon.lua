local weaponName="jpoisondartweapon"
local weaponDef={
	--weaponType=[[Cannon]],
	rendertype=0,
	
	name="Suicidal",
	reloadtime=19,
	
	CameraShake=6,
	accuracy = 10,
	explosionGenerator="custom:poisonteal",
	avoidFeature=false,
	avoidFriendly=false,
	ImpulseBoost=0.2,
	ImpulseFactor=1,
	
	damage={
		default=1,
	},
	areaOfEffect=250,
	craterMult=0,
	lineOfSight=true,
	soundHit = 	"sounds/jPoisondart/jPoisonDartImpact.ogg"
	--
	
	
	ballistic=true,
	turret=true,
	range=70,
	weaponvelocity=250,
	
	
	
	
	
}
return lowerkeys ({[weaponName]=weaponDef})