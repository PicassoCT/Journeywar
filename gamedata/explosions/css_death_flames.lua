--lowest part of the fire

return {
  ["cssdeathflames"] = {
  
   groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.99,
      flashsize          = 150,
      ttl                = 15,
      color = {
        [1]  = 1,	
        [2]  = 0.5,
        [3]  = 0.10000001192093,
      },
    },
 
 
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
     pos                = [[0r-5r10,0r-5r10,0r-5r10]],
     size               = [[0.5]],
     sizegrowth         = [[1.04]],
     speed              = [[0, 1 0, 0]],
     texture            = [[fireyexplo]],
   },
 },
     dirt1 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
      	colormap           = [[1 1 1 .01  	1 1 1 .01  	1 0.3 0.05 .01		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 25,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 6,
        particlelife       = 18.5,
        particlelifespread = 5,
        particlesize       = 1.5,
        particlesizespread = 7,
        particlespeed      = 0,
        particlespeedspread = 19,
        pos                = [[0, 2, 0]],
        sizegrowth         = 3,
        sizemod            = 1.0,
        texture            = [[Fire4]],
      },
    },
  


	fire1={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=4,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[firehd]],

				colormap           = [[1 1 1 .01  	1 1 1 .01  	1 0.3 0.05 .01		0 0 0 0.01]],
			

				 pos                = [[0 r-5 r5,0 r15,0 r-5 r5]],
				gravity            = [[0.0, 1r0.5, 0.0]],
				emitvector         = [[0r0.1 r-0.1, -1, 0 r0.1 r-0.1]],
				emitrot		= 45,
				emitrotspread	= 32.35,


				sizeGrowth	= 1,
				sizeMod		= 1.01,

				airdrag			= 0.5,
				particleLife		= 8,
				particleLifeSpread	= 45,
				numParticles		= 1,
				particleSpeed		= 0.2,
				particleSpeedSpread	= 3.4,
				particleSize		= 0.02,
				particleSizeSpread	= 0.12,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  
		
	fire2={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=2,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[Fire3]],

				colormap           = [[1 1 1 .01 1 0.5 0.25 .01   1 0.3 0.05 .01		0 0 0 0.01]],
			

				 pos                = [[0,0r5,0]],
				gravity            = [[0.0, 1r0.3 r-0.3, 0.0]],
				emitvector         = [[0r0.01 r-0.01, -1, 0r0.01 r-0.01]],
				emitrot		= 45,
				emitrotspread	= 62.3,


				sizeGrowth	= 1,
				sizeMod		= 1.01,

				airdrag			= 0.5,
				particleLife		=6,
				particleLifeSpread	= 33,
				numParticles		= 1,
				particleSpeed		= 0.3,
				particleSpeedSpread	= 1.4,
				particleSize		= 0.02,
				particleSizeSpread	= 0.09,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  
		
	fire3={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=2,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[Fire6]],

				colormap           = [[1 1 1 .01 1	 0.5 0.25 .01  ]],
			

				 pos                = [[0,0r5,0]],
				gravity            = [[0.0, 1 r0.9 r-0.3, 0.0]],
				emitvector         = [[0r0.01 r-0.01, -1, 0r0.01 r-0.01]],
				emitrot		= 45,
				emitrotspread	= 62.3,


				sizeGrowth	= 1,
				sizeMod		= 1.01,

				airdrag			= 0.5,
				particleLife		=6,
				particleLifeSpread	= 42,
				numParticles		= 1,
				particleSpeed		= 0.3,
				particleSpeedSpread	= 1.4,
				particleSize		= 0.02,
				particleSizeSpread	= 0.18,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  	
		
 sparkredX = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[1 0.5 0.25 .01   1 0.3 0.05 .01		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.001, 0]],
        numparticles       = 1,
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