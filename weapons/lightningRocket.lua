local weaponName="lightningrocket"
local weaponDef={
				name="lightning",
				weaponType=[[MissileLauncher]],


			
				burst =9,
				burstrate = 0.11999999731779,
				craterboost = 0,
				cratermult = 0,
				dance = 60,
				edgeeffectiveness = 0.5,
				
			--	explosiongenerator = "custom:MEDMISSILE_EXPLOSION",
				firestarter = 100,
	
				impulseboost = 0.12300000339746,
				impulsefactor = 0.12300000339746,
				metalpershot = 0,
	
				movingaccuracy = 600,

				noselfdamage = true,
				proximitypriority = -1,
				range = 350,
	
				trajectoryheight = 1,
				turnrate = 0,
			
			
				weapontimer = 0.01,

				
				wobble = 200,
				
				



				Accuracy=1000,

				--Physic/flight path

				reloadtime=5,
				weaponVelocity=1000,
				startVelocity=800,
				weaponAcceleration=150,
				flightTime=18.5,
				BurnBlow=0,
				FixedLauncher=false,

				--wobble=0,

				tolerance=5000,
				tracks=true,
				--Turnrate=32000,
				collideFriendly=false,

				----APPEARANCE
				model="emptyObjectIsEmpty.s3o",
				smokeTrail=false,
				--explosionGenerator="custom:redsmoke",
				CegTag="lightningrocket",

				----TARGETING
				turret=true,
				cylindertargeting=1.0,
				avoidFeature=true,
				avoidFriendly=true,


				--commandfire=true,

				----DAMAGE
				damage={
				default=1,
				heavyarmor=1,
				},
				areaOfEffect=1,
				craterMult=0,

				--?FIXME***
				lineOfSight=true,


				--sound

				--soundStart="jbeanstalk/phoenixstart.wav",
				--soundHit="jbeanstalk/phoeniximpact.wav",
}

return lowerkeys ({[weaponName]=weaponDef})