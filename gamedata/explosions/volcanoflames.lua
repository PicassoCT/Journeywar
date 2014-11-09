--lowest part of the fire

return {
  ["volcanoflames"] = {
  
 
   volcaNosstra = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 3,
        heatfalloff        = 1.0,
        maxheat            = 3,
        pos                = [[0,0,0]],
        size               = [[0.0005]],
        sizegrowth         = [[0.04]],
        speed              = [[0, 10, 0]],
        texture            = [[flame]],
      },
    },
 
 

  
 
  
		itshotHotHOT={	
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
				particleLife		=6,
				particleLifeSpread	= 12,
				numParticles		= 2,
				particleSpeed		= 0.3,
				particleSpeedSpread	= 0.4,
				particleSize		= 0.02,
				particleSizeSpread	= 0.09,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  	
			
	
					

	
				

},

}