    return {
		  ["cnanotics"] = {
	 
		  blub = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 1,
			  ground             = true,
			  water              = true,
			  properties = {
				airdrag            = 1,
				colormap           = [[
									0.1 0.1 0.1 0.01
									0.1 0.1 0.6 0.015
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.015
									0.1 0.1 0.1 0.01
									
									0.1 0.1 0.1 0.01
									0.1 0.1 0.6 0.015
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.015
									0.1 0.1 0.1 0.01
									
									0.1 0.1 0.1 0.01
									0.1 0.1 0.6 0.015
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.015
									0.1 0.1 0.1 0.01

				0 0 0 0.0]],
				directional        = true,
				emitrot            = 1,
				emitrotspread      = 1,
					emitvector         = [[dir]],
				gravity            = [[0, 0, 0]],
				numparticles       = 15,
				particlelife       = 100,
				particlelifespread = 300,
				particlesize       = 0.2,
				particlesizespread = 0.1,
				particlespeed      = 0.5,
				particlespeedspread = 0.2,
				pos                = [[0, 0, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[cnanoharvesters]],
				useairlos          = false,
			  },
			},
		 sparks = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 3,
			  ground             = true,
			  water              = true,
			  properties = {
				airdrag            = 1,
								colormap           = [[
									0.1 0.1 0.1 0.01
									0.1 0.1 0.6 0.015
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.015
									0.1 0.1 0.1 0.01
									
									0.1 0.1 0.1 0.01
									0.1 0.1 0.6 0.015
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.015
									0.1 0.1 0.1 0.01
									
									0.1 0.1 0.1 0.01
									0.1 0.1 0.6 0.015
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.015
									0.1 0.1 0.1 0.01

				0 0 0 0.0]],
				directional        = true,
				emitrot            = 1,
				emitrotspread      = 1,
					emitvector         = [[dir]],
				gravity            = [[0, 0, 0]],
				numparticles       = 1,
				particlelife       = 50,
				particlelifespread = 300,
				particlesize       = 2.2,
				particlesizespread = 3,
				particlespeed      = 0.5,
				particlespeedspread = 0.0,
				pos                = [[0, 0, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[fireSparks]],
				useairlos          = false,
			  },
			},	
			
		},
    }
