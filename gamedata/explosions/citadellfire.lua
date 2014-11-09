return {
	  ["citadellfire"] = {
	  
	  cdfone = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.15,
        alwaysvisible      = true,
        colormap           = [[0.9 0.2 0.1 1.0	0.9 0.4 0.1 1.0		0 0 0 0.0]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 25,
        emitvector         = [[0, 0.01, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 2,
        particlelife       = 35,
        particlelifespread = 10,
        particlesize       = 3,
        particlesizespread = 5,
        particlespeed      = 1,
        particlespeedspread = 2,
        pos                = [[r-1 r1, 1, r-1 r1]],
        sizegrowth         = 1.0002,
        sizemod            = 1.0,
        texture            = [[texFireCloud]],
        useairlos          = true,
      },
    },
	
    cdftwo = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.55,
        alwaysvisible      = true,
        colormap           = [[0.9 0.1 0.1 1.0	0.9 0.4 0.1 1.0		0 0 0 0.0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 35,
        emitvector         = [[0, 0.2, 0]],
        gravity            = [[0, -0.00002, 0]],
        numparticles       = 1,
        particlelife       = 25,
        particlelifespread = 80,
        particlesize       = 5,
        particlesizespread = 5,
        particlespeed      = 0.5,
        particlespeedspread = 3,
        pos                = [[r-1 r1, 1, r-1 r1]],
        sizegrowth         = 1.2,
        sizemod            = 1.0,
        texture            = [[citadellcloud]],
        useairlos          = true,
      },
    },
	  
	      cdfthree = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        alwaysvisible      = true,
        colormap           = [[0.9 0.1 0.1 1.0	0.9 0.4 0.1 1.0		0 0 0 0.0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 42,
        emitvector         = [[0, 0.3, 0]],
        gravity            = [[0, -0.00002, 0]],
        numparticles       = 2,
        particlelife       = 85,
        particlelifespread = 50,
        particlesize       = 6,
        particlesizespread = 5,
        particlespeed      = 0.3,
        particlespeedspread = 10,
        pos                = [[r-1 r1, 1, r-1 r1]],
        sizegrowth         = 1.000002,
        sizemod            = 1.0,
        texture            = [[SmokeAshCloud]],
        useairlos          = true,
      },
    },
	
	
 ashcloud={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=1,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[SmokeAshCloud]],
				colormap           = [[0.2 0.2 0.2 0.6		0.5 0.5 0.5 0.5		0 0 0 0.01]],
				--colormap           = [[1 0.4 0.25 .01     .02 .02 .02 0.01 .004 .004 .004 0.01		0 0 0 0.01]],
			

				 pos                = [[0 r-13 r13, 26, 0 r-13 r13]],
				gravity            = [[0, -0.2, 0]],
				emitvector         = [[0, 0.3, 0]],
				  emitRot		= 42,
				 emitRotSpread	= 12.824,


				sizeGrowth	= 0.45,
				sizeMod		= 1.0,

		
				airdrag			= 0.55,
				particleLife		=80,
				particleLifeSpread	= 46,
				numParticles		= 2,
				particleSpeed		= 0.09,
				particleSpeedSpread	= 0.012,
				particleSize		= 0.008,
				particleSizeSpread	= 2,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		}
	  
	  
	  

	}
}
