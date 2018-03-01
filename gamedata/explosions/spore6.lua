    -- trail_ar2
     
    return {
      ["spore6"] = {
	  
 greenSparks = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[ 0.225 0.225 0 .05   
								0.45 0.225 0  .05   
								0 0.225 0.225 .025		
								0 0.225 0.45  0.025
								0 0.225 0.225 0.025
								0 0.225 0.225 0.025
								0.45 0.225 0  0.025 
								0 0.225 0.225 0.025
								0 0 0 0.025
			
								]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.003, 0]],
        numparticles       = 1,
        particlelife       = 150,
        particlelifespread = 200,
        particlesize       = 4,
        particlesizespread = 2,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 0.1]],
        sizemod            = 1.000000001,
        texture            = [[spore6]],
        useairlos          = false,
      },
    },
		
	 
		  
    },
    }
