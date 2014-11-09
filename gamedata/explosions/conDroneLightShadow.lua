-- dirt

return {
  ["conDroneLightShadow"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
          colormap           = [[0.9 0.9 0.9 1.0	0.9 0.9 0.9 1.0		0 0 0 0.0]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, -0.0001, 0]],
        numparticles       = 3,
        particlelife       = 25,
        particlelifespread = 15,
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

