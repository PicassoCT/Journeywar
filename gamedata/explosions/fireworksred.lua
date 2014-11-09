-- redlight

return {
  ["fireworksred"] = {
  
   moredots = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
        colormap           = [[1.0 0.5 0.0 0.05   	0.9 0.1 0.1 0.01  	0.9 0.1 0.1 0.00]],
        directional        = true,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.5, 0]],
        numparticles       = 8,
        particlelife       = 45,
        particlelifespread = 36,
        particlesize       = 25,
        particlesizespread = 0,
        particlespeed      = 10,
        particlespeedspread = 3,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0.5,
        sizemod            = 1,
        texture            = [[fireSparks]],
        useairlos          = false,
      },
    },
  },

}

