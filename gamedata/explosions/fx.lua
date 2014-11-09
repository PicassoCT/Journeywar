-- vernier
-- zakuhighbooster

return {
  ["vernier"] = {
    pop2 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 10,
        heatfalloff        = 0.6,
        maxheat            = 15,
        pos                = [[0, 0, 0]],
        size               = [[10 r-1.5]],
        sizegrowth         = -0.9,
        speed              = [[0, r-1.5, 0]],
        texture            = [[flare]],
      },
    },
  },

  ["zakuhighbooster"] = {
    thrust = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = .7,
        colormap           = [[.9 .7 0 .01   .3 .3 .3 .5   .3 .3 .3 .5   0 0 0 0]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 15,
        emitvector         = [[0, -1, 0]],
        gravity            = [[0,0,0]],
        numparticles       = 3,
        particlelife       = 15,
        particlelifespread = 6,
        particlesize       = 3,
        particlesizespread = 0,
        particlespeed      = 8,
        particlespeedspread = 2,
        pos                = [[0,0,0]],
        sizegrowth         = 1,
        sizemod            = 1,
        texture            = [[dirt]],
        useairlos          = true,
      },
    },
  },

}

