local weaponName="cchainlightning"
local weaponDef={
name="LightninBolt",
weaponType=[[MissileLauncher]],

Accuracy=1000,

--Physic/flight path
range=1200,
reloadtime=3,
weaponVelocity=250,
startVelocity=5,
weaponAcceleration=50,
flightTime=18.5,
BurnBlow=0,
FixedLauncher=false,
dance=6,
wobble=5,
turnrate=3500,
tolerance=16000,
tracks=true,
collideFriendly=false,

----APPEARANCE
model="emptyObjectIsEmpty.s3o",
smokeTrail=false,
--explosionGenerator="custom:redsmoke",
CegTag="cchainlightning",

----TARGETING
turret=true,
CylinderTargeting=222.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=450,
heavyarmor=350,
},
areaOfEffect=20,
craterMult=0,
--?FIXME***
lineOfSight=false,
 noSelfDamage       = true,

--sound
--soundHit="null",
--soundStart="citadell/dronelaunch",
}

return lowerkeys ({[weaponName]=weaponDef})