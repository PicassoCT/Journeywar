local weaponName="jflyingfish"
local weaponDef={
name="Torpedius Scolare MementoMortemius",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=1800,
reloadtime=3,
weaponVelocity=250,
startVelocity=150,
weaponAcceleration=150,
flightTime=7.5,
BurnBlow=0,
FixedLauncher=false,
dance=1,
wobble=4,

tolerance=16000,
tracks=true,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="jFishTorpProj.s3o",
smokeTrail=false,
--explosionGenerator="custom:redsmoke",
--CegTag="smoketrail",

----TARGETING
turret=true,
cylinderTargeting=66,
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
soundHit="sounds/jfishswarm/jFishSwarmAttack.wav",
soundStart="sounds/jfishswarm/jFishSwarmFlyingAttack.wav",

}

return lowerkeys ({[weaponName]=weaponDef})