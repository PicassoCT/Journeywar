-- dirt

return {
  ["tiglilSparks"] = {
       poof02 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
		  properties = {
			airdrag            = 0.1,
			alwaysvisible      = true,
			colormap           = [[0.1 0.8 0.8 0.01	0.2 0.7 0.9 0.01	0.0 0.0 0.0 0.01]],
			directional        = false,
			emitrot            = 45,
			emitrotspread      = 32,
			emitvector         = [[0, 1, 0]],
			gravity            = [[0, -0.005, 0]],
			numparticles       = 1,
			particlelife       = 3,
			particlelifespread = 8,
			particlesize       = 2,
			particlesizespread = 0,
			particlespeed      = 1,
			particlespeedspread = 3,
			pos                = [[0, 2, 0]],
			sizegrowth         = 0.8,
			sizemod            = 1.0,
			texture            = [[randdots]],
			useairlos          = false,
					},
				},
  
  
  },

}

