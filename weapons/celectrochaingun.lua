local weaponName="celetrochain"
local weaponDef={

name="EletrocChaingLightning",
weaponType=[[Cannon]],
description="Rod",
highTrajectory =0,


--


--
--Physic/flight path
range=320,
reloadtime=12,
weaponVelocity=300,
startVelocity=250,
weaponAcceleration=200,
flightTime=7.5,
BurnBlow=0,
FixedLauncher=false,

dance=0,
wobble=0,
trajectoryheight=25.8,
accuracy = 4200,
tolerance=16000,
tracks=false,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="jgluegunproj.s3o",
smokeTrail=true,

CegTag="redstripe",

----TARGETING
turret=true,
--CylinderTargetting=true,
avoidFeature=true,
avoidFriendly=true,

--explosionGenerator=	"custom:330rlexplode",	
--commandfire=true,

----DAMAGE
damage={
default=1,
},
areaOfEffect=3,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
--soundHit="null",
--soundStart="null",
}

return lowerkeys ({[weaponName]=weaponDef})