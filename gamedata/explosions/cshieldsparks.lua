-- dirt

return {
  ["cshieldsparks"] = {
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
			numparticles       = 3,
			particlelife       = 3,
			particlelifespread = 18,
			particlesize       = 4,
			particlesizespread = 12,
			particlespeed      = 1,
			particlespeedspread = 3,
			pos                = [[0, 2, 0]],
			sizegrowth         = 0.8,
			sizemod            = 1.0,
			texture            = [[randdots]],
			useairlos          = false,
					},
				},
  
  glowing = {
      air                = true,
      class              = [[explspike]],
      count              = 5,
      ground             = true,
      water              = true,
		properties = {
		alpha              = 1,
        alphadecay         = 0.19,
        alwaysvisible      = true,
        color              = [[0.0, 0.3, 1]],
        dir                = [[-45 r90,-45 r90,-45 r90]],
	  
	  
    
        length             = 2,--2,
        width              = 22,--22,
      },
   },
   

  },

}

