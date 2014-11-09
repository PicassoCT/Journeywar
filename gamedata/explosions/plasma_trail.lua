-- plasma_trail

return {
  ["plasma_trail"] = {
    lines = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[1 1 1 0.1	1 1 0 0.1   0.2 1 0 0.1   0 0 0 0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 5,
        particlelifespread = 5,
        particlesize       = 10,
        particlesizespread = 5,
        particlespeed      = 0,
        particlespeedspread = 0.1,
        pos                = [[-3 r6, -3 r6, -3 r6]],
        sizegrowth         = -1,
        sizemod            = 1,
        texture            = [[gunshot_alpha]],
      },
    },
  },

}

