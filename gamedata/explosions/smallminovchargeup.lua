-- smallminovchargeup

return {
  ["smallminovchargeup"] = {
    poof02 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
        colormap           = [[0.8 0.8 0.2 0.01	0.8 0.5 0.2 0.01	0.0 0.0 0.0 0.01]],
        directional        = false,
        emitrot            = 40,
        emitrotspread      = 5,
        emitvector         = [[dir]],
        gravity            = [[0, -0.005, 0]],
        numparticles       = 3,
        particlelife       = 5,
        particlelifespread = 8,
        particlesize       = 5,
        particlesizespread = 0,
        particlespeed      = 3,
        particlespeedspread = 1,
        pos                = [[0, 2, 0]],
        sizegrowth         = -0.3,
        sizemod            = 1.0,
        texture            = [[randdots]],
        useairlos          = false,
      },
    },
    pop1 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 10,
        heatfalloff        = 5,
        maxheat            = 15,
        pos                = [[0, 0, 0]],
        size               = 3,
        sizegrowth         = 7,
        speed              = [[0, 0, 0]],
        texture            = [[laserendyellow]],
      },
    },
  },

}

