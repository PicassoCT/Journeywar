-- snipercooloff

return {
  ["gamasteam"] = {
    greytowhitepuff = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0.2 0.2 0.2 0.6		0.5 0.5 0.5 0.5		0 0 0 0.01]],
        directional        = true,
        emitrot            = 45,
        emitrotspread      = 25,
        emitvector         = [[dir]],
        gravity            = [[0.0, 0, .0]],
        numparticles       = 5,
        particlelife       =19,
        particlelifespread = 5,
        particlesize       = 1,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 3,
        pos                = [[0.0, 1, 0.0]],
        sizegrowth         = 1,
        sizemod            = 1,
        texture            = [[dirt]],
        useairlos          = false,
      },
    },
    
   
    whitepuff = {
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[1 1 1 0.5		0 0 0 0.01]],
        directional        = true,
        emitrot            = 35,
        emitrotspread      = 48,
        emitvector         = [[dir]],
		gravity            = [[0, 0.00000007, 0]],
        numparticles       = 1,
        particlelife       = 16,
        particlelifespread = 8,
        particlesize       = 1,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 3,
        pos                = [[0.0, 1, 0.0]],
        sizegrowth         = 1,
        sizemod            = 1,
        texture            = [[dirt]],
        useairlos          = false,
      },
    },
  },

}

