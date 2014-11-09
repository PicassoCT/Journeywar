-- dirt

return {
  ["orgbigbang"] = {

  glow = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
      colormap           = [[  1.0 1.0 1.0 0.002  1.0 1.0 1.0 0.002   0.85 0.91 0.98  0.003 0.85 0.91 0.98  0.004   0.3 0.7 0.9 0.004   1.0 0.1 0.0 0.003        0.4 0.0 0.1 0.003  ]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 45,
        emitvector         = [[dir]],
        gravity            = [[0,0, 0]],
        numparticles       = 1,
        particlelife       = 15,
        particlelifespread = 0,
        particlesize       = 0.3,
        particlesizespread = 0.2,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[r22, r42, r22]],
        sizegrowth         = 0.000000000000000001,
        sizemod            = 1.000000000000000000001,
        texture            = [[glow]],
        useairlos          = false,
      },
    },
	
	
		glowball = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[  1.0 1.0 1.0 0.002  1.0 1.0 1.0 0.002   0.85 0.91 0.98  0.003 0.85 0.91 0.98  0.004   0.3 0.7 0.9 0.004   1.0 0.1 0.0 0.003        0.4 0.0 0.1 0.003  ]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 45,
        emitvector         = [[dir]],
        gravity            = [[0,0, 0]],
        numparticles       = 5,
        particlelife       = 95,
        particlelifespread = 80,
        particlesize       = 2,
        particlesizespread = 2,
        particlespeed      = 3,
        particlespeedspread = 2,
        pos                = [[r22, r42, r22]],
        sizegrowth         = .000001,
        sizemod            = 1.00000001,
        texture            = [[glowballred]],
        useairlos          = false,
      },
    },
	
  },

}

