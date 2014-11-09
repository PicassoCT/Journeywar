local weaponName="jacidants"
local weaponDef={
name="Accidic Ant Wedding",

description="Hive Sweet Hive",

weaponType=[[MissileLauncher]],
--vlaunch=1,


--Physic/flight path
range=2000,
reloadtime=9,
weaponVelocity=1000,
startVelocity=250,
weaponAcceleration=200,
flightTime=5.5,

cameraShake=12;
FixedLauncher=true,
dance=2,
wobble=3.5,
trajectoryheight=0.4,
accuracy = 1200,
tolerance=3000,
tracks=false,
Turnrate=16000,
collideFriendly=true,
WeaponTimer=4,
BurnBlow=1,

--


--
--Physic/flight path







----APPEARANCE
model="jantbull.s3o",
smokeTrail=false,
--explosionGenerator="xamelimpact",
--CegTag="smoketrail",

----TARGETING
turret=true,
--CylinderTargetting=true,
avoidFeature=false,
avoidFriendly=false,


--commandfire=true,
explosionGenerator=[[custom:jantseverywhere]], 
CegTag="jlessants",
----DAMAGE
damage={
default=250,
heavyarmor=50,
},
areaOfEffect=30,
craterMult=0,

--?FIXME***
lineOfSight=false,


--sound
soundHit="jantart/jantimpactor",
soundStart="jantart/jantartlaunch",
}

return lowerkeys ({[weaponName]=weaponDef})