-- dirt

return {
  ["portalflares"] = {
    dirtgw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[0.69 0.99 0.99 0.1		0.36 0.57 0.87 0.05		0.36 0.57 0.87 0.0125]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.03, 0]],
        numparticles       = 1,
        particlelife       = 3,
        particlelifespread = 9,
        particlesize       = [[5]],
        particlesizespread = 15,
        particlespeed      = 8,
        particlespeedspread = 2,
        pos                = [[0, -7 , 0]],
        sizegrowth         = 0.99,
        sizemod            = 0.9,
        texture            = [[strips]],
        useairlos          = false,
      },
    },
  
  },

}

