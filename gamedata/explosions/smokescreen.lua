-- smokescreen

return {
  ["smokescreen"] = {
    poof01 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.75,
        colormap           = [[0.9 0.9 0.9 1.0	0 0 0 0.0]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 10,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.0, 0]],
        numparticles       = 3,
        particlelife       = 20,
        particlelifespread = 20,
        particlesize       = 10,
        particlesizespread = 20,
        particlespeed      = 5,
        particlespeedspread = 5,
        pos                = [[r-5 r5, r-5 r5, r-5 r5]],
        sizegrowth         = 5,
        sizemod            = 1.0,
        texture            = [[new_dirtb]],
        useairlos          = false,
      },
    },
  },

}

