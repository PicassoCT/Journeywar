    -- trail_ar2
     
    return {
      ["helioloadaurora"] = {
	shrink = {
	air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
    		colormap = [[
				0.1 0.3 0.7 0.0001 
				0.1 0.3 0.7 .005								
				0.3 0.3 0.8 .01		
				0.4 0.3 0.9 .015	
				0.1 0.3 0.7 .005 									
				0.1 0.3 0.7 .01 
				0.1 0.3 0.7 .005 	
				0.3 0.3 0.8 .01	
				0.1 0.3 0.7 0.0001 
				]],
		directional        = true,
        emitrot            = 10,
        emitrotspread      = 10,
        emitvector         =  [[r1r-1,r1,r1r-1]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 120,
        particlelifespread = 0,
        particlesize       = [[75]],
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.9999999,
        sizemod            =  0.975,
        texture            = [[Accreationdiskalpha]],
        useairlos          = false,
      },
	
	
        },
	expand = {
	air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
    		colormap = [[
				0.1 0.3 0.7 0.0001 
				0.1 0.3 0.7 .005								
				0.3 0.3 0.8 .01		
				0.4 0.3 0.9 .015	
				0.1 0.3 0.7 .005 									
				0.1 0.3 0.7 .01 
				0.1 0.3 0.7 .005 	
				0.3 0.3 0.8 .01	
				0.1 0.3 0.7 0.0001 
				]],
		directional        = true,
        emitrot            = 10,
        emitrotspread      = 10,
        emitvector         =  [[r1r-1,r1,r1r-1]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 120,
        particlelifespread = 0,
        particlesize       = [[75]],
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.9999999,
        sizemod            =  0.985,
        texture            = [[Galaxy2]],
        useairlos          = false,
      },
	
    
         
        },	
		
	outerspiral = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
    		colormap = [[
				0.1 0.3 0.7 0.0001 
				0.1 0.3 0.7 .005								
				0.3 0.3 0.8 .01		
				0.4 0.3 0.9 .015	
				0.1 0.3 0.7 .005 									
				0.1 0.3 0.7 .01 
				0.1 0.3 0.7 .005 	
				0.3 0.3 0.8 .01	
				0.1 0.3 0.7 0.0001 
				]],
		directional        = true,
        emitrot            = 10,
        emitrotspread      = 10,
        emitvector         =  [[r1r-1,r1,r1r-1]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 0,
        particlesize       = [[150]],
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.9999999,
        sizemod            =  0.95,
        texture            = [[outerspira]],
        useairlos          = false,
      },
    },
	
		
    },
    }
