--lowest part of the fire

return {
  ["flames"] = {
  
 
   glow = {
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
        size               = [[0.5]],
        sizegrowth         = [[1.04]],
        speed              = [[0, 1 0, 0]],
        texture            = [[flame]],
      },
    },
 

	fire1={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=1,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[firehd]],

				colormap           = [[1 0.5 0.25 .01   1 0.3 0.05 .01		0 0 0 0.01]],
			

				 pos                = [[0,0,0]],
				gravity            = [[0.0, 1, 0.0]],
				emitvector         = [[0, -1, 0]],
				emitrot		= 45,
				emitrotspread	= 32.35,


				sizeGrowth	= 1,
				sizeMod		= 1.01,

				airdrag			= 0.5,
				particleLife		= 8,
				particleLifeSpread	= 15,
				numParticles		= 4,
				particleSpeed		= 0.2,
				particleSpeedSpread	= 0.4,
				particleSize		= 0.02,
				particleSizeSpread	= 0.06,

				directional		= 1, 
				useAirLos		= 0,
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
		
 sparkredX = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[1 0.5 0.25 .01   1 0.3 0.05 .01		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 3,
        particlelife       = 19,
        particlelifespread = 11,
        particlesize       = 0.5,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[gunshot]],
        useairlos          = false,
      },
    },
		
					

	
				

},

}