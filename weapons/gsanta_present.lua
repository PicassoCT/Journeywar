local weaponName="gsanta_present"
local weaponDef={
name="present",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=800,
reloadtime=30,
weaponVelocity=1000,
startVelocity=150,
weaponAcceleration=250,
flightTime=2.5,
BurnBlow=0,
FixedLauncher=false,
dance=1,
wobble=4,

tolerance=16000,
tracks=true,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="gsanta_present.s3o",
smokeTrail=false,
explosionGenerator="custom:Flames",
--CegTag="blackerThenSmoke",

----TARGETING
turret=true,
cylinderTargeting=80.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=800,
heavyarmor=150,
},
areaOfEffect=100,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
soundHit="Santa/santa1.ogg",
soundStart="Santa/santa2.ogg",
}

return lowerkeys ({[weaponName]=weaponDef})