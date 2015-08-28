local weaponName="aarocket"
local weaponDef={
name="AirAir Rocket",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=4095,
reloadtime=3,
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
model="cComEunguidedRProj.s3o",
smokeTrail=true,
--explosionGenerator="custom:redsmoke",
CegTag="conairexaust",

----TARGETING
turret=true,
cylinderTargeting=55.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=150,
heavyarmor=150,
},
areaOfEffect=100,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
--soundHit="skinfantry/birdrockethit.wav",
--soundStart="skinfantry/birdrocketstart.wav",
}

return lowerkeys ({[weaponName]=weaponDef})