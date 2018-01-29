-- blood_spray

return {
  ["infantrydissolve"] = {

	       
     	body = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 1,
			  ground             = true,
			  water              = false,
			  properties = {
				airdrag            = 1,
				colormap           = [[ 0.3 0.55 0.9 0.05	 
										0.3 0.55 0.9 0.04
										0.3 0.3 0.9  0.03
										0.3 0.3 0.9  0.0		
										0.3 0.3 0.55 0.0	]],		
				directional        = true,
				emitrot            = 0,
				emitrotspread      = 0,
					emitvector         = [[0,1,0]],
				gravity            = [[0, 0.001, 0]],
				numparticles       = 1,
				particlelife       = 150,
				particlelifespread = 50,
				particlesize       = 12,
				particlesizespread = 5,
				particlespeed      = 0.08,
				particlespeedspread = 0,
				pos                = [[0, 1, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[human]],
				useairlos          = false,
			  },
			},	       
    
	
		
 
	first = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 5,
			  ground             = true,
			  water              = false,
			  properties = {
				airdrag            = 1,
				colormap           = [[ 
										0.3 0.3 0.55 0.03
										0.3 0.3 0.55 0.03
										0.3 0.3 0.55 0.03	 
										0.3 0.55 0.9 0.0
										0.3 0.55 0.9 0.0
										0.3 0.55 0.9 0.0
										0.3 0.3 0.55 0.0	]],		
				directional        = true,
				emitrot            = 0,
				emitrotspread      = 0,
					emitvector         = [[  r-0.4 r0.4,0, r-0.4 r0.4]],
				gravity            = [[0, 0.015, 0]],
				numparticles       = 1,
				particlelife       = 100,
				particlelifespread = 20,
				particlesize       = 1.2,
				particlesizespread = 5,
				particlespeed      = 0.8,
				particlespeedspread = 0.3,

				    pos                = [[r-15 15, 5, r-15 r15]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[Flake]],
				useairlos          = false,
			  },
			},
	flares = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 35,
			  ground             = true,
			  water              = false,
			  properties = {
				airdrag            = 1,
				colormap           = [[ 0.3 0.55 0.9 0.0	 
										0.3 0.55 0.9 0.0
										0.3 0.55 0.9 0.0
										0.3 0.55 0.9 0.0
										0.3 0.3 0.55 0.03
										0.3 0.3 0.55 0.03
										0.3 0.3 0.55 0.0	]],		
				directional        = true,
				emitrot            = 0,
				emitrotspread      = 0,
					emitvector         = [[0r-0.1r0.1,-1,0r-0.1r0.1]],
				gravity            = [[0, 0.025, 0]],
				numparticles       = 1,
				particlelife       = 100,
				particlelifespread = 20,
				particlesize       = 1.2,
				particlesizespread = 5,
				particlespeed      = 0.8,
				particlespeedspread = 0.3,

				    pos                = [[r-15 15, 5, r-15 r15]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[Flake]],
				useairlos          = false,
			  },
			},
			
	
	
	
  },

}
