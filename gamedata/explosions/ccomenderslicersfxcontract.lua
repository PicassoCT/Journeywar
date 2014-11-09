-- redlight

return {
  ["ccssfxcontract"] = {
  	   alwaysvisible      = true,
	  usedefaultexplosions = false,
	
	lensflare = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.95 0.95 0.95  0.01	0.95 0.95 0.95  0.01 	0.95 0.95 0.95  0.01 	  	0 0 0 0.0]],
        directional        = true,
        emitrot            = 10,
        emitrotspread      = 10,
        emitvector         = [[0, 0 r-0.001 , 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 55,
        particlelifespread = 0,
        particlesize       = [[15]],
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 50, 0]],
        sizegrowth         = 0,
        sizemod            =  0.990,
        texture            = [[lensflareCenter]],
        useairlos          = false,
      },
    },
	contractstrobe = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.95 0.95 0.95  0.01	0.95 0.95 0.95  0.01 	0.95 0.95 0.95  0.01 	  	0 0 0 0.0]],
        directional        = true,
        emitrot            = 10,
        emitrotspread      = 10,
        emitvector         = [[0, 0 r-0.001 , 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 65,
        particlelifespread = 0,
        particlesize       = [[45]],
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 50, 0]],
        sizegrowth         = 0,
        sizemod            =  0.989,
        texture            = [[expandingstrobe]],
        useairlos          = false,
      },
    },	
	collapsingspiral = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.95 0.95 0.95  0.005	0.95 0.95 0.95  0.005 	0.95 0.95 0.95  0.005 	  	0 0 0 0.0]],
        directional        = false,
        emitrot            = 10,
        emitrotspread      = 43,
        emitvector         = [[0, 0 r-0.001 , 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 45,
        particlelifespread = 30,
        particlesize       = [[25]],
        particlesizespread = 20,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 50, 0]],
        sizegrowth         = 0,
        sizemod            =  0.989,
        texture            = [[outerspira]],
        useairlos          = false,
      },
    },
		
	   
	
	
	
	}
  }


