    -- trail_ar2
     
    return {
      ["cBuildCubeDisolveSfx"] = {
	  
   
	electroplasma = {
      air                = true,
      class              = [[explspike]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.1,
        color              = [[0.19,0.9,0.9]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 1,
        width              = 6,
      },
    },	
	
    Flash = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,--          0,25			--0,01
         colormap           = [[0.5 0.9 1 0.0025         0 0 0 0.01  0 0 0 0.0]],
        directional        = true,
        emitrot            = 7,
        emitrotspread      = 12,
        emitvector         = [[0,-0.4,0]],
        gravity            = [[0, -0.0002, 0]],
        numparticles       = 1,
        particlelife       = 40,
        particlelifespread = 12,
        particlesize       = 3.5,
        particlesizespread = 15,
        particlespeed      = 0.009,
        particlespeedspread = 1.05,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1.00000000001,
        sizemod            = 1.000000000000000001,
        texture            = [[bbs]],
        useairlos          = false,
      },
    },

	 

	
	
	
	
	  
    },
    }
