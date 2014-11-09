-- dirt

return {

	  ["cwaterextOrange"] = {
	agentOrange = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
   
        alwaysvisible      = true,
        colormap           = [[0.1 0.1 0.9 0.1	0.1 0.1 0.1 0.1		0 0 0 0.0]],
				texture=[[sparkcloud]],
				--colormap           = [[0.2 0.2 0.2 0.6		0.5 0.5 0.5 0.5		0 0 0 0.01]],
			

				 pos                = [[0 , 0, 0 ]],
				gravity            = [[0, 0.0000001, 0]],
				emitvector         = [[0.1, 0.1, 0.1]],
				  emitRot		= 42,
				 emitRotSpread	= 12.824,


				sizeGrowth	= 0.09,
				sizeMod		= 1.0,

		
				airdrag			= 0.55,
				particleLife		=175,
				particleLifeSpread	= 6,
				numParticles		= 2,
				particleSpeed		= 12.9,
				particleSpeedSpread	= 0.012,
				particleSize		= 0.008,
				particleSizeSpread	= 2,
      },
    },
	
	
  },

}

