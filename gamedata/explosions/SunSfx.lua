-- dirt

return {
  ["sunfx"] = {
	--Sun
	

		sunball = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.3 0.7 0.9 0.01   1.0 0.1 0.0 0.01        0.4 0.0 0.1 0.002  ]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[0,0.000001,0]],
        gravity            = [[0,0, 0]],
        numparticles       = 1,
        particlelife       = 15,
        particlelifespread = 0,
        particlesize       = 5.3,
        particlesizespread = 1.9,
        particlespeed      = 0.0000001,
        particlespeedspread = 0.0000001,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.00000000000001,
        sizemod            = 1.0,
        texture            = [[nuke]],
        useairlos          = false,
      },
    },
	sunballs = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.7 0.7 0.7 0.1   0.7 0.7 0.7 0.1  0.7 0.7 0.7 0.1   0.7 0.7 0.7 0.1   0.7 0.7 0.7 0.1     ]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[0,0.000001,0]],
        gravity            = [[0,0, 0]],
        numparticles       = 1,
        particlelife       = 15,
        particlelifespread = 0,
        particlesize       = 5.3,
        particlesizespread = 1.9,
        particlespeed      = 0.0000001,
        particlespeedspread = 0.0000001,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.00000000000001,
        sizemod            = 1.0,
        texture            = [[firehd]],
        useairlos          = false,
      },
    }
	
  },

}

