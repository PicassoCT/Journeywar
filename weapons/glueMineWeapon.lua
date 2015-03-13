local weaponName="gluemineweapon"
local weaponDef={
--weaponType=[[Cannon]],
rendertype=4,

name="Stickerbumper",
reloadtime=19,

CameraShake=6,
accuracy = 10,
explosionGenerator="custom:bigbulletimpact",
avoidFeature=false,
avoidFriendly=false,
ImpulseBoost=1.2,
ImpulseFactor=3,

damage={
		default=800,
		},
areaOfEffect=250,
craterMult=2,
lineOfSight=true,
--soundHit           = "jhoney/jhoney.ogg",
--


ballistic=true,
	turret=true,
	range=70,
	weaponvelocity=250,
	




}
return lowerkeys ({[weaponName]=weaponDef})