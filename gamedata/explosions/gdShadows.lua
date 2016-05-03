-- dirt

return {
  ["gdShadows"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
          colormap           = [[0.1 0.2 0.6 0.5	0.1 0.1 0.3 0.6 0.1 0.1 0.3 0.4 	0.1 0.1 0.3 0.2	      0 0 0 0.0]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.3 r0.3, 0]],
        numparticles       = 4,
        particlelife       = 15,
        particlelifespread = 10,
        particlesize       = [[12 r8]],
        particlesizespread = 5,
        particlespeed      = 1,
        particlespeedspread = 6,
        pos                = [[r-2 r2, 1 r2, r-2 r2]],
        sizegrowth         = 1.05,
        sizemod            = 0.999,
        texture            = [[SmokeAshCloud]],
        useairlos          = false,
      },
    },

  },

}

