-- beamimpact

return {
  ["jsunshipceg"] = {
    
	

      aoceanofflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = false,
          properties = {
				colormap           = [[1 1 1 .001 	1 0.5 0.25 .001 1 0.5 0.25 .01   1 0.3 0.05 .01		1 0.3 0.05 .001		]],
			dir                = [[0r0.1,0.2r1,0r0.1]],
            frontoffset        = 0,
            fronttexture       = [[fire]],
            length             = 113,
            sidetexture        = [[fireside]],
            size               = 60,
            sizegrowth         = 0.9,
            ttl                = 25,
          },
        },
   
     
    
	

   
	fire2={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=1,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[fireyexplo]],

				colormap           = [[1 1 1 .01 1 0.5 0.25 .01   1 0.3 0.05 .01	1 0.3 0.05 .001		]],
			

				 pos                = [[0r50r-50,0r15,0r50r-50]],
				gravity            = [[0,0,0]],
				emitvector         = [[0r0.2r-0.2, 0.01, 0r0.2r-0.2]],
				emitrot            = 42,
				emitrotspread      = 15,


				sizeGrowth	= 1,
				sizeMod		= 1.01,

				airdrag			= 0.5,
				particleLife		=12,
				particleLifeSpread	=22,
				numParticles		= 1,
				particleSpeed		= 2.3,
				particleSpeedSpread	= 1.4,
				particleSize		= 0.3,
				particleSizeSpread	= 5.39,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  	
   
   
       dirtgw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[0.25 0.20 0.10 0.1	1 0.8 0 0.5  1 0.8 0 0.001]],
        directional        = true,
        emitrot            = 32,
        emitrotspread      = 15,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 22,
        particlelifespread = 20,
        particlesize       = [[3]],
        particlesizespread = 1.5,
        particlespeed      = 1,
        particlespeedspread = 0.2,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 0.99,
        sizemod            = 0.9,
        texture            = [[fire1]],
        useairlos          = false,
      },
    },
   
  },

}

