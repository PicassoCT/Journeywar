-- redlight

return {
  ["fireworksblue"] = {
  
   moredots = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
        colormap           = [[1.0 1.0 1.0 0.05	0.2 0.5 0.9 0.01	0.1 0.1 0.8 0.00]],
        directional        = true,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = 16,
        particlelife       = 5,
        particlelifespread = 16,
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

