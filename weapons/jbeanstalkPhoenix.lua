local weaponName="jbeanstalkPhoenix"
local weaponDef={
				name="jbeanstalkPhoenix",
				weaponType=[[MissileLauncher]],


			
				burst = 6,
				burstrate = 0.11999999731779,
				craterboost = 0,
				cratermult = 0,
				dance = 30,
				edgeeffectiveness = 0.5,
				
			--	explosiongenerator = "custom:MEDMISSILE_EXPLOSION",
				firestarter = 70,
	
				impulseboost = 0.12300000339746,
				impulsefactor = 0.12300000339746,
				metalpershot = 0,
	
				movingaccuracy = 600,

				noselfdamage = true,
				proximitypriority = -1,
				range = 1350,
				reloadtime = 15,
		
		

	
				trajectoryheight = 1,
				turnrate = 0,
			
			
				weapontimer = 3,

				
				wobble = 2000,
				
				



				Accuracy=1000,

				--Physic/flight path

				reloadtime=5,
				weaponVelocity=500,
				startVelocity=150,
				weaponAcceleration=150,
				flightTime=18.5,
				BurnBlow=0,
				FixedLauncher=false,

				--wobble=0,

				tolerance=16000,
				tracks=true,
				--Turnrate=32000,
				collideFriendly=true,

				----APPEARANCE
				model="warpbirdproj.s3o",
				smokeTrail=false,
				--explosionGenerator="custom:redsmoke",
				CegTag="jbeanstalkphoenix",

				----TARGETING
				turret=true,
				cylindertargeting=1.0,
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

				soundStart="jbeanstalk/phoenixstart.wav",
				soundHit="jbeanstalk/phoeniximpact.wav",
}

return lowerkeys ({[weaponName]=weaponDef})