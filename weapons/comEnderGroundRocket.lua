local weaponName="grocket"
local weaponDef={
name="Long Range Ground Rocket",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=4095,
reloadtime=0.001,
weaponVelocity=1500,
startVelocity=300,
weaponAcceleration=250,
flightTime=10.5,
BurnBlow=2,
FixedLauncher=false,
dance=1,
wobble=4,

tolerance=16000,
tracks=false,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="cComEunguidedRProj.s3o",
smokeTrail=true,
--explosionGenerator="custom:redsmoke",
--CegTag="conairexaust",

----TARGETING
	turret=true,
	cylinderTargeting=55.0,
	avoidFeature=true,
	avoidFriendly=true,
	burst=12,
	burstrate=0.02,
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