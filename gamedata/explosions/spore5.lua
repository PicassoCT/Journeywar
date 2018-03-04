    -- trail_ar2
     
    return {
      ["spore5"] = {
	  
 greenSparks = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
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
        particlesize       = 1,
        particlesizespread = 2,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0, 0, 0]],
      sizegrowth         = [[0.0 0.05]],
          sizemod            = 0.9999995,
        texture            = [[spore5]],
        useairlos          = false,
      },
    },
		
	background = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
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
								0 0.225 0.225 0.02			
								0 0 0 0.03			
								]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.003, 0]],
        numparticles       = 1,
        particlelife       = 150,
        particlelifespread = 200,
        particlesize       = 6,
        particlesizespread = 18,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 0.1]],
        sizemod            = 1.0000009,
        texture            = [[fireSparks]],--bigExploSmoke
        useairlos          = false,
      },
    }, 
		 
		  
    },
    }
