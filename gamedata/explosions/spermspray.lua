-- blood_spray

return {
  ["spermspray"] = {
	proLife = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.9 0.9 0.9 .01   0.1 0.1 0.1 .01		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[dir]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 2,
        particlelife       = 19,
        particlelifespread = 4,
        particlesize       = 0.5,
        particlesizespread = 1,
        particlespeed      = 1,
        particlespeedspread = 0.5,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[sperm]],
        useairlos          = false,
      },
    },
		
	ladyJuice = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.9 0.9 0.9 .01   0.9 0.9 0.9 .01		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[dir]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 2,
        particlelife       = 19,
        particlelifespread = 22,
        particlesize       = 0.5,
        particlesizespread = 1,
        particlespeed      = 1,
        particlespeedspread = 0.5,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[gunshot]],
        useairlos          = false,
      },
    },
		
	
	
  },

}
