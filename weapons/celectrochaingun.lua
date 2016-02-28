local weaponName="celetrochain"
local weaponDef={

name="EletrocChaingLightning",
weaponType=[[Cannon]],
name="Rod",
highTrajectory =0,

--Physic/flight path
range=1220,
reloadtime=18,
weaponVelocity=600,
startVelocity=450,
weaponAcceleration=400,
flightTime=12.5,

FixedLauncher=false,

trajectoryheight=25.8,
accuracy = 4200,
tolerance=16000,

collideFriendly=true,

----APPEARANCE
model="cChaingLightningGunProj.s3o",
smokeTrail=false,

CegTag="ccitdronetail",

----TARGETING
turret=true,
--CylinderTargetting=true,
avoidFeature=true,
avoidFriendly=true,


----DAMAGE
damage={
default=10,
},
areaOfEffect=3,
craterMult=0,

--?FIXME***
lineOfSight=false,


--sound
soundHit="sounds/ccrabsynth/clightning1.ogg",
soundStart="sounds/ccrabsynth/magnetGun.ogg",
}

return lowerkeys ({[weaponName]=weaponDef})