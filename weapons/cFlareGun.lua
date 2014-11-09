local weaponName="flaregun"
local weaponDef={
name="FlareGun",
weaponType=[[MissileLauncher]],

Accuracy=1000,

--Physic/flight path
range=420,
reloadtime=3,
weaponVelocity=250,
startVelocity=150,
weaponAcceleration=50,
flightTime=18.5,
BurnBlow=0,
FixedLauncher=false,
dance=0,
wobble=0,
turnrate=0,
tolerance=200,
tracks=false,
Turnrate=32000,
collideFriendly=true,

----APPEARANCE
model="emptyObjectIsEmpty.s3o",
smokeTrail=true,
--explosionGenerator="custom:redsmoke",
CegTag="flaregunsfx",

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