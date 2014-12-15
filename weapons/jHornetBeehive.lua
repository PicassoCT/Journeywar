local weaponName="jhornetbeehive"
local weaponDef={
name="jhornet",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=600,
reloadtime=0.1,
weaponVelocity=1000,
startVelocity=150,
weaponAcceleration=250,
flightTime=5.5,
BurnBlow=0,
FixedLauncher=false,
dance=22,
wobble=82,

tolerance=16000,
tracks=true,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="jHornetProj.s3o",
--smokeTrail=true,
--explosionGenerator="custom:redsmoke",
--CegTag="smoketrail",

----TARGETING
turret=true,
cylinderTargeting=75.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=15,
heavyarmor=15,
},
areaOfEffect=10,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
soundHit="jbeehive/sting.wav",
--soundStart="skinfantry/birdrocketstart.wav",
}

return lowerkeys ({[weaponName]=weaponDef})