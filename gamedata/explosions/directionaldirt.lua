-- dirt

return {
  ["directionaldirt"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
        colormap           = [[0.25 0.20 0.10 1.0	0 0 0 0.0]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, -0.7, 0]],
        numparticles       = 3,
        particlelife       = 45,
        particlelifespread = 20,
        particlesize       = 5,
        particlesizespread = 0,
        particlespeed      = 1,
        particlespeedspread = 3,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 1.0001,
        sizemod            = 1.0,
        texture            = [[new_dirta]],
        useairlos          = false,
      },
    },
  
  },

}

