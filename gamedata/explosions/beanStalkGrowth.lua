-- dirt

return {
  ["beanstalkgrowth"] = {
    dirtgw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[0.25 0.20 0.10 1.0	0.1 0.2 0.1 0.1]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 675,
        particlelifespread = 20,
        particlesize       = [[1]],
        particlesizespread = 0,
        particlespeed      = 1,
        particlespeedspread = 0,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 0.99,
        sizemod            = 0.9,
        texture            = [[bubbles]],
        useairlos          = false,
      },
    },
  
  },

}

