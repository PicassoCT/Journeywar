    return {
      ["sentrynellimpact"] = {

		
	 electric2 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 11,
        heatfalloff        = 1.5,
        maxheat            = 5,
        pos                = [[0, 0, 0]],
        size               =0.5,
        sizegrowth         = 2,
        speed              = [[0, 0, 0]],
        texture            = [[laserendblue]],
      },
    },	
	

                sparkxs = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          water              = false,
          properties = {
            airdrag            = 1,
            colormap           = [[0.2 0.8 1 0.01   0 0 0 0.01]],
            directional        = true,
            emitrot            = 5,
            emitrotspread      = 15,
            emitvector         = [[0, -1, 0]],
            gravity            = [[0, -0.0001, 0]],
            numparticles       = 15,
            particlelife       = 5,
            particlelifespread = 10,
            particlesize       = 3,
            particlesizespread = 1,
            particlespeed      = 1,
            particlespeedspread = 3,
            pos                = [[0, 0, 0]],
            sizegrowth         = [[0.0 r.25]],
            sizemod            = 1.0,
            texture            = [[gunshot]],
            useairlos          = false,
          },
        },
     	
				 
    },
    }
