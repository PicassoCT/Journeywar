local weaponName="cnukegrenadelvl1"
local weaponDef={
name="GrenadeLauncher Lvl2",
weaponType=[[Cannon]],

highTrajectory =1,


--

weapontimer=12,
--
--Physic/flight path
range=900,
reloadtime=19,
weaponVelocity=400,
startVelocity=250,
weaponAcceleration=200,
flightTime=12.5,
BurnBlow=0,
FixedLauncher=true,
dance=0,
wobble=0,
trajectoryheight=25.8,
accuracy = 4200,
tolerance=16000,
tracks=false,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="fatman.s3o",
smokeTrail=true,
--explosionGenerator="xamelimpact",
--CegTag="smoketrail",

----TARGETING
turret=true,
--CylinderTargetting=true,
avoidFeature=false,
avoidFriendly=false,

explosionGenerator=	"custom:330rlexplode",	
--commandfire=true,

----DAMAGE
damage={
default=150,
heavyarmor=50,
},
areaOfEffect=25,
craterMult=0,

--?FIXME***
lineOfSight=false,


--sound
soundHit="cart/arthchit",
soundStart="cart/artfire",
}

return lowerkeys ({[weaponName]=weaponDef})