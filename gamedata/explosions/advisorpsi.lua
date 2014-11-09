-- dirt

return {

	  ["advisorpsi"] = {
	agentOrange = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
   
        alwaysvisible      = true,
        colormap           = [[0.01 0.01 0.09 0.01  	0.01 0.01 0.01 0.01		0 0 0 0.0]],
				texture=[[sparkcloud]],
				--colormap           = [[0.2 0.2 0.2 0.6		0.5 0.5 0.5 0.5		0 0 0 0.01]],
			

				 pos                = [[0 , 0, 0 ]],
				gravity            = [[0, -0.0001, 0]],
				emitvector         = [[0.1, 0.1, 0.1]],
				  emitRot		= 42,
				 emitRotSpread	= 25.824,


				sizeGrowth	= 0.09,
				sizeMod		= 1.0,

		
				airdrag			= 0.55,
				particleLife		=25,
				particleLifeSpread	= 6,
				numParticles		= 2,
				particleSpeed		= 12.9,
				particleSpeedSpread	= 22.12,
				particleSize		= 1.008,
				particleSizeSpread	= 42,
      },
    },
	
	
  },

}

