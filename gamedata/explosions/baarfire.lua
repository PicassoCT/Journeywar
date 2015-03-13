-- beamimpact

return {
  ["baarestfire"] = {
    
	

    
	

   
 aexpand = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
		
          underwater         = 0,
          water              = false,
		    
          properties = {
		    alwaysvisible      = true,
		    useairlos          = false,
			colormap           = [[1 1 1 .004 	1 0.5 0.25 .004 1 0.5 0.25 .01   1 0.3 0.05 .01		1 0.3 0.05 .004		]],
			dir                = [[0r0.01r-0.01,0.2r1,0r0.01r-0.01]],
            frontoffset        = 0,
            fronttexture       = [[fire]],
            length             = 80,
            sidetexture        = [[]],
            size               = 32,
            sizegrowth         = 0.995,
            ttl                = 32,
          },
        },
  
        bcontract = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
		
          underwater         = 0,
          water              = false,
		    
          properties = {
		    alwaysvisible      = true,
		    useairlos          = false,
			colormap           = [[1 1 1 .001 	1 1 1 .001 	1 1 1 .01   1 1 1 .01		1 1 1 .005		]],
			dir                = [[0r0.01r-0.01,0.2r1,0r0.01r-0.01]],
            frontoffset        = 0,
            fronttexture       = [[fireyexplo]],
            length             = 80,
            sidetexture        = [[]],
            size               = 32,
            sizegrowth         = 1.001,
            ttl                = 32,
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
        colormap           = [[0.25 0.20 0.10 0.1	1 0.8 0 0.05  1 0.5 0 0.005]],
        directional        = true,
        emitrot            = 32,
        emitrotspread      = 15,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 22,
        particlelifespread = 20,
        particlesize       = [[8]],
        particlesizespread = 7.5,
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

