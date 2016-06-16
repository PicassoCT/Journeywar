    return {
      ["jlessants"] = {
		  
	  ants2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.25 0.20 0.10 1.0	0 0 0 0.0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, 0.00000007, 0]],
        numparticles       = 25,
        particlelife       = 50,
        particlelifespread = 11,
        particlesize       = 0.5,
        particlesizespread = 0,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 0.0000000000000000001]],
        sizemod            = 0.99999999,
        texture            = [[JANT]],
        useairlos          = false,
      },
    },
	-- stripe = {
    

      -- air                = true,
      -- class              = [[CBitmapMuzzleFlame]],
      -- count              = 1,
      -- ground             = true,
      -- underwater         = false,
      -- water              = true,
      -- properties = {
        -- colormap           = [[0.8 1 0.2 0.01  	0.8 1 0.2 0.01 		0.8 1 0.2 0.01  	0.8 1 0.2 0.01 	]],
        -- dir                = [[dir]],
        -- frontoffset        = 0,
        -- fronttexture       = [[empty]],
        -- length             = -12,
        -- sidetexture        = [[citdronegrad]],
        -- size               = -3,
        -- sizegrowth         = 0.18,
        -- ttl                = 24,
      -- }
    -- },	

	stripe = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = false,
      water              = true,
      properties = {
        colormap           = [[0.8 1 0.2 0.01  	0.8 1 0.2 0.01 		0.8 1 0.2 0.01  	0.8 1 0.2 0.01 	]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -12,
        sidetexture        = [[citdronegrad]],
        size               = -6,
        sizegrowth         = 0,
        ttl                = 94,
      }
    },	
		
	  
				 
				 
				 
    },
    }
