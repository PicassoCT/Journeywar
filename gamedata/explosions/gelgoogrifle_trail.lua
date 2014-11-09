-- gelgoogrifle_trail

return {
  ["gelgoogrifle_trail"] = {
    lines = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0 0 0 0   1 1 0.2 0.1   0 0 0 0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 30,
        particlelifespread = 10,
        particlesize       = 6,
        particlesizespread = 2,
        particlespeed      = 0,
        particlespeedspread = 0.1,
        pos                = [[-3 r6, -3 r6, -3 r6]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[randdots]],
      },
    },
  },

}

