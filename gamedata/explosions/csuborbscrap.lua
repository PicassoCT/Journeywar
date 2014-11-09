-- dirt

return {
  ["csuborbscrap"] = {
    dirtgw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[0.21 0.10 0.01 1.0	0.2 0.14 0.01 0.1]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.03, 0]],
        numparticles       = 2,
        particlelife       = 3,
        particlelifespread = 3,
        particlesize       = [[5]],
        particlesizespread = 15,
        particlespeed      = 8,
        particlespeedspread = 2,
        pos                = [[0, -7 , 0]],
        sizegrowth         = 0.99,
        sizemod            = 0.9,
        texture            = [[csuborbscrap]],
        useairlos          = false,
      },
    },
  
  },

}

