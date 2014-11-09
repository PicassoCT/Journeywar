-- redlight

return {
  ["flare"] = {
  
   moredots = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.65,
        alwaysvisible      = true,
        colormap           = [[1.0 0.5 0.0 0.1  1.0 0.5 0.0 0.05 ]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = 1,
        particlelife       = 32,
        particlelifespread = 0,
        particlesize       = 4,
        particlesizespread = 0,
        particlespeed      = 300,
        particlespeedspread = 3,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0.05,
        sizemod            = 1,
        texture            = [[flake]],
        useairlos          = false,
      },
    },
  },

}

