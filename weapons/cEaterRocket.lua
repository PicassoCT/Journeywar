local weaponName="ceater"
local weaponDef={
name="Eater Drone",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=1800,
reloadtime=3,
weaponVelocity=250,
startVelocity=150,
weaponAcceleration=250,
flightTime=12.5,
BurnBlow=0,
FixedLauncher=false,
dance=42,
wobble=12,

tolerance=16000,
tracks=true,
Turnrate=32000,
collideFriendly=true,

----APPEARANCE
model="cEaterProj.s3o",
smokeTrail=false,
explosionGenerator="custom:bloodslay",
--CegTag="smoketrail",
CegTag="eaterstrip",
----TARGETING
turret=true,
cylinderTargeting=100,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=325,
heavyarmor=150,
},
areaOfEffect=1,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
soundHit="cweapons/eaterImpact.ogg",
soundStart="cweapons/eaterlaunch.ogg",
}

return lowerkeys ({[weaponName]=weaponDef})