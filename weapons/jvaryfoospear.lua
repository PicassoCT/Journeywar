local weaponName="varyfoospear"
local weaponDef={
name="Practical Exitenzialism",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=960,
reloadtime=50,
weaponVelocity=500,
startVelocity=160,
weaponAcceleration=150,
flightTime=12.5,
BurnBlow=0,
FixedLauncher=false,
dance=0,
wobble=0,

tolerance=2000,
tracks=false,
Turnrate=0,
collideFriendly=true,

----APPEARANCE
model="ghostdancerprojectile.s3o",
smokeTrail=false,
--explosionGenerator="custom:redsmoke",
--CegTag="smoketrail",

----TARGETING
turret=true,
cylinderTargeting=100,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=160,
heavyarmor=5,
},
areaOfEffect=0,
craterMult=0,

--?FIXME***
lineOfSight=false,


--sound
--soundHit="skinfantry/birdrockethit.wav",
--soundStart="skinfantry/birdrocketstart.wav",
}

return lowerkeys ({[weaponName]=weaponDef})