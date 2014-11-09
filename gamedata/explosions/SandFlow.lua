-- blood_spray

return {
  ["sandflow"] = {
	blooddrops = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.8 0.65 0.35 .1   0.8 0.65 0.35 .01		0.85 0.7 0.3 0.01]],
		
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 10,
        emitvector         = [[0,-1,0]],
        gravity            = [[0, -0.035, 0]],
        numparticles       = 15,
        particlelife       = 39,
        particlelifespread = 14,
        particlesize       = 0.5,
        particlesizespread = 2,
        particlespeed      = 0.5,
        particlespeedspread = 1,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[bloodsplat]],
        useairlos          = false,
      },
    },
		
	
	
	blooddrops = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
		colormap           = [[0.4 0.25 0.175 .1   0.4 0.225 0.175 .01		 0.4 0.225 0.175 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 15,
        emitvector         = [[0,-1,0]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 12,
        particlelife       = 29,
        particlelifespread = 22,
        particlesize       = 0.75,
        particlesizespread = 1,
        particlespeed      = 1,
        particlespeedspread = 0.5,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[gunshot]],
        useairlos          = false,
      },
    },
		
	
	
  },

}
