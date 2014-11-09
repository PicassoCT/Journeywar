local weaponName="jglowproj"
local weaponDef={
name="Glowworm",
weaponType=[[MissileLauncher]],

Accuracy=1000,

--Physic/flight path
range=1200,
reloadtime=3,
weaponVelocity=250,
startVelocity=50,
weaponAcceleration=50,
flightTime=18.5,
BurnBlow=0,
FixedLauncher=false,
dance=120,
wobble=60,
turnrate=12200,
tolerance=16000,
tracks=true,
Turnrate=32000,
collideFriendly=true,

----APPEARANCE
model="jGlowProj.s3o",
smokeTrail=false,
--explosionGenerator="custom:redsmoke",
CegTag="jglowwormsfx",

----TARGETING
turret=true,
CylinderTargeting=1.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=450,
heavyarmor=350,
},
areaOfEffect=100,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
soundHit="",
soundStart="",
}

return lowerkeys ({[weaponName]=weaponDef})