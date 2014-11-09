--http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
-- local weaponName = "crestrictorthumper"
-- local weaponDef = {
	      -- name                    = "cRestricTorThumper",
	      -- weaponType              = [[Cannon]],
	      --damage
		  -- damage = {
				-- default = 1,
				-- HeavyArmor = 1,
				-- },	      
				
		  -- ImpulseBoost=1.2,
		  -- ImpulseFactor=6,
	      -- areaOfEffect            = 450,
		--  physics
		  -- noSelfDamage            = true,
       --  paralyzer               = true,
	--	 paralyzeTime            = 45,
		  -- weaponVelocity          = 500,
		  -- reloadtime              = 0.9,
		  -- range                   = 210,
		  -- sprayAngle              = 0,
	      -- tolerance               = 8000,
		  -- lineOfSight             = false,	      
	      -- turret                  = true,
		  -- craterMult              = 0,	      
		     -- explosionGenerator = "custom:dirt",
--		  apperance



					
          
-- }	
-- return lowerkeys({[weaponName] = weaponDef})

local weaponName = "crestrictorthumper"
local weaponDef = {
	      name                    = "cRestricTorThumper",
	      weaponType              = [[Cannon]],
	    
		 damage = {
				default = 3000,
				HeavyArmor = 70,
				},	      
				
		  ImpulseBoost=0.01,
		  ImpulseFactor=0.1,
	      areaOfEffect            = 450,
		
		  noSelfDamage            = true,
  
		  weaponVelocity          = 500,
		  reloadtime              = 0.9,
		  range                   = 210,
		  sprayAngle              = 0,
	      tolerance               = 8000,
		  lineOfSight             = false,	      
	      turret                  = true,
		  craterMult              = 0,	     
		  paralyzer=true,
		  ParalyzeTime=25,
		     explosionGenerator = "custom:dirt",
	
		  	  	      
          
}	
return lowerkeys({[weaponName] = weaponDef})		  
