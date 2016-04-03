-- blood_spray

return {
  ["bghdexplode"] = {
	
  spatter = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 1,
			  ground             = true,
			  water              = false,
			  properties = {
				airdrag            = 1,
				colormap           = [[0.8 0.1 0.3 0.09 		0.8 0.1 0.2 0.05	0.8 0.1 0.1 0.03	 0 0 0 0.0  0 0 0 0.0  0 0 0 0.0]],
				directional        = true,
				emitrot            = 5,
				emitrotspread      = 90,
					emitvector         = [[0r0.1r-0.1,1,0r0.1r-0.1]],
				gravity            = [[0, -0.24, 0]],
				numparticles       = 3,
				particlelife       = 35,
				particlelifespread = 11,
				particlesize       = 3.2,
				particlesizespread = 8,
				particlespeed      = 0.02,
				particlespeedspread = 1.005,
				pos                = [[0, -50, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[firesparks]],--burstside --bubbles
				useairlos          = false,
			  },
			},
  blooddropsone = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 1,
			  ground             = true,
			  water              = false,
			  properties = {
				airdrag            = 1,
				colormap           = [[0.8 0.1 0.3 0.09 		0.8 0.1 0.2 0.05	0.8 0.1 0.1 0.03	 0 0 0 0.0  0 0 0 0.0  0 0 0 0.0]],
				directional        = true,
				emitrot            = 5,
				emitrotspread      = 90,
					emitvector         = [[0r0.1r-0.1,1,0r0.1r-0.1]],
				gravity            = [[0, -0.24, 0]],
				numparticles       = 3,
				particlelife       = 35,
				particlelifespread = 11,
				particlesize       = 3.2,
				particlesizespread = 8,
				particlespeed      = 0.02,
				particlespeedspread = 1.005,
				pos                = [[0, -50, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[blooddrops]],--burstside --bubbles
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
				colormap           = [[0.8 0.1 0.3 0.09 		0.8 0.1 0.2 0.05	0.8 0.1 0.1 0.03	 0 0 0 0.0  0 0 0 0.0  0 0 0 0.0]],
				directional        = true,
				emitrot            = 5,
				emitrotspread      = 90,
					emitvector         = [[0r0.1r-0.1,1,0r0.1r-0.1]],
				gravity            = [[0, -0.24, 0]],
				numparticles       = 3,
				particlelife       = 35,
				particlelifespread = 11,
				particlesize       = 3.2,
				particlesizespread = 8,
				particlespeed      = 0.02,
				particlespeedspread = 1.005,
				pos                = [[0, -50, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[burstside]],--burstside --bubbles
				useairlos          = false,
			  },
			},			
	
	
	
  },

}
