    -- trail_ar2
     
    return {
      ["orangespores"] = {
	  
 greenSparks = {
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
        texture            = [[sparkcloud]],--bigExploSmoke
        useairlos          = false,
      },
    },
	 tendrils = {
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
        emitvector         = [[0,0.5,0]],
        gravity            = [[0r-0.003r0.003, 0r-0.001r0.001, 0r-0.003r0.003]],
        numparticles       = 1,
        particlelife       = 150,
        particlelifespread = 100,
        particlesize       = 1,
        particlesizespread = 2,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0r200r-200, 0, 0r200r-200]],
        sizegrowth         = [[0.0 r0.1]],
        sizemod            = 0.99999991,
        texture            = [[jgalateatendrils]],--bigExploSmoke
        useairlos          = false,
      },
    },	
	 
		  
    },
    }
