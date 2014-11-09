-- dirt

return {
  ["fog"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
          colormap           = [[0.9 0.9 0.9 1.0	0.9 0.9 0.9 0.5		0 0 0 0.0]],
        directional        = true,
        emitrot            = 1,
        emitrotspread      = 2,
        emitvector         = [[dir]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = 1,
        particlelife       = 120,
        particlelifespread = 60,
        particlesize       = 4,
        particlesizespread = 19,
        particlespeed      = 15,
        particlespeedspread = 36,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 1.000000005,
        sizemod            = 0.999,
        texture            = [[new_dirta]],
        useairlos          = false,
      },
    },

  },

}

