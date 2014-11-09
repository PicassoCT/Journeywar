--lowest part of the fire

return {
  ["disolveFire"] = {
  	 dirtgw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[0.21 0.10 0.01 0.5	0.2 0.14 0.01 0.2]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.03, 0]],
        numparticles       = 3,
        particlelife       = 42,
        particlelifespread = 23,
        particlesize       = [[2]],
        particlesizespread = 3,
        particlespeed      = 0.5,
        particlespeedspread = 0.75,
        pos                = [[0, -7 , 0]],
        sizegrowth         = 1.0000001,
        sizemod            = 1.0000001,
        texture            = [[disolvefx]],
        useairlos          = false,
      },
    },
	
fire2={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=1,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[flame]],

				colormap           = [[1 0.5 0.25 .01   1 0.3 0.05 .01		0 0 0 0.01]],
			

				 pos                = [[0,0,0]],
				gravity            = [[0.0, 1, 0.0]],
				emitvector         = [[0, -1, 0]],
				emitrot		= 45,
				emitrotspread	= 62.3,


				sizeGrowth	= 1,
				sizeMod		= 1.01,

				airdrag			= 0.5,
				particleLife		=8,
				particleLifeSpread	= 12,
				numParticles		= 2,
				particleSpeed		= 0.3,
				particleSpeedSpread	= 0.4,
				particleSize		= 0.07,
				particleSizeSpread	= 0.09,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  	
		
		
					

	
				

},

}