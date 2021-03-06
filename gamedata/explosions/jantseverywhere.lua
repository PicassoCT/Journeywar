    -- trail_ar2
     
    return {
      ["jantseverywhere"] = {
	  	   alwaysvisible      = true,
	  ants1 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
         colormap           = [[0.25 0.20 0.10 1.0	0 0 0 0.0]],

        directional        = true,
        emitrot            = 0,
        emitrotspread      = 90,
        emitvector         = [[0,1,0]],
        gravity            = [[0, 0.00000007, 0]],
        numparticles       = 42,
        particlelife       = 70,
        particlelifespread = 15,
        particlesize       = 2.7,
        particlesizespread = 0.2,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0, 10, 0]],
        sizegrowth         = [[0.0 0.0000000000000000001]],
        sizemod            = 0.99999999,
        texture            = [[JANT]],
        useairlos          = false,
      },
    },
	
	spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
      colormap           = [[0.8 1 0.2 0.025		0.8 1 0.2 0.0125]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.005, 0]],
        numparticles       = 1,
        particlelife       = 55,
        particlelifespread = 8,
        particlesize       = 15,
        particlesizespread = 0,
        particlespeed      =0,
        particlespeedspread = 0,
        pos                = [[0, 10, 0]],
        sizegrowth         = 0.8,
        sizemod            = 1.000001,
        texture            = [[laserend]],
        useairlos          = false,
      },
    },
	
	
	 
		
	  
    },
    }
