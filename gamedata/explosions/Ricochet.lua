-- trail_ar2

return {
  ["Ricochet"] = {
  
	  bulletcomingback = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.1 0.8 0.8 0.01	0.2 0.7 0.9 0.01	0.0 0.0 0.0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[dir]],
        gravity            = [[0, -0.17, 0]],
        numparticles       = 63,
        particlelife       = 4,
        particlelifespread = 3,
        particlesize       = 2.2,
        particlesizespread = 0.2,
        particlespeed      = 7,
        particlespeedspread = 5,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[gunshot]],
        useairlos          = false,
      },
    },
	
	sparkcore = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.2,
        alwaysvisible      = true,
          colormap           = [[0.1 0.8 0.8 0.01	0.2 0.7 0.9 0.01	0.0 0.0 0.0 0.01]],
        directional        = true,
        emitrot            = 45,
        emitrotspread      = 60,
        emitvector         = [[dir]],
        gravity            = [[0, -0.017, 0]],
        numparticles       = 2,
        particlelife       = 2,
        particlelifespread = 3,
        particlesize       = 2,
        particlesizespread = 4,
        particlespeed      = 0.1,
        particlespeedspread = 0.1,
        pos                = [[0, 2, 0]],
        sizegrowth         = 1,
        sizemod            = 1.0,
        texture            = [[ricochet]],
        useairlos          = false,
      },
    },  
	
	
  },

}