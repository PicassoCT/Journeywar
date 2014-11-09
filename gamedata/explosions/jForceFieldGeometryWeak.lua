-- dirt

return {
  ["jforcefieldgeomweak"] = {

		    jsnine = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.55 0.6 0.15  0.01   0.8 0.9 0.1 0.01   0.9 1 0 0.02 	 0.8 0.9 0.1 0.02 	0.55 0.6 0.15  0.01 	0 0 0 0.0]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 0,
        emitvector         = [[0, -0.03 r0.035 , 0]],
        gravity            = [[-0.03 r0.03, 0.0001, -0.03 r0.03]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 40,
        particlesize       = [[240 r9]],
        particlesizespread = 42,
        particlespeed      = 0.2,
        particlespeedspread = 5,
        pos                = [[0, 50 r22,0]],
        sizegrowth         = 0.99999999999999,
        sizemod            =  0.994,
        texture            = [[jshieldgeom9]],
        useairlos          = false,
      },
    },
    jsten = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.55 0.6 0.15  0.01  0.8 0.9 0.1 0.01   0.9 1 0 0.01 	 0.8 0.9 0.1 0.01 	0.55 0.6 0.15  0.01 	0 0 0 0.0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, -0.03 r0.035 , 0]],
        gravity            = [[-0.03 r0.03, 0.0001, -0.03 r0.03]],
        numparticles       = 2,
        particlelife       = 150,
        particlelifespread = 150,
        particlesize       = [[242 r9]],
        particlesizespread = 13,
        particlespeed      = 0.2,
        particlespeedspread = 5,
        pos                = [[0, 50 r22,0]],
        sizegrowth         = 0.99999999999999,
        sizemod            =  0.994,
        texture            = [[jshieldgeom10]],
        useairlos          = false,
      },
    }

  },

}

