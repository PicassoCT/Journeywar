-- dirt

return {
  ["conDroneShadow"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
          colormap           = [[0.1 0.2 0.6 1.0	0.1 0.1 0.3 1.0		0 0 0 0.0]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, 0.0001, 0]],
        numparticles       = 4,
        particlelife       = 15,
        particlelifespread = 20,
        particlesize       = [[12 r4]],
        particlesizespread = 5,
        particlespeed      = 1,
        particlespeedspread = 6,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 1.05,
        sizemod            = 0.999,
        texture            = [[SmokeAshCloud]],
        useairlos          = true,
      },
    },

  },

}

