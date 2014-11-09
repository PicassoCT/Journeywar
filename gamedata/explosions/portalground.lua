return {
["portalground"] = {
groundflash = {
      air                = true,
      alwaysvisible      = true,
      circlealpha        = 0.5,
      circlegrowth       = 3,--6
      flashalpha         = 0.4,
      flashsize          = 620,
      ground             = true,
      ttl                = 15,--53
      water              = true,
      color = {
        [1]  = 0,
        [2]  = 0.30000001192093,
        [3]  = 1,
      },
    },



		-- groundflash = {
      -- air                = true,
      -- alwaysvisible      = true,
      -- circlealpha        = 1,
      -- circlegrowth       = 12,
      -- flashalpha         = 1,
      -- flashsize          = 620,
      -- ground             = true,
      -- ttl                = 1,
      -- water              = true,
        -- color = {
        -- [1]  = 0,
        -- [2]  = 0.30000001192093,
        -- [3]  = 1,
      -- },

      -- },

	  poof02 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
        colormap           = [[0.1 0.8 0.8 0.01	0.2 0.7 0.9 0.01	0.0 0.0 0.0 0.01]],
        directional        = false,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.005, 0]],
        numparticles       = 8,
        particlelife       = 5,
        particlelifespread = 8,
        particlesize       = 10,
        particlesizespread = 0,
        particlespeed      = 8,
        particlespeedspread = 3,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0.8,
        sizemod            = 1.0,
        texture            = [[randdots]],
        useairlos          = false,
      },
    },
	
	 pop1 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 10,
        heatfalloff        = 1.1,
        maxheat            = 15,
        pos                = [[r-2 r2, 5, r-2 r2]],
        size               = 19,
        sizegrowth         = 15,
        speed              = [[0, 1 0, 0]],
     	  texture=[[portalstorm]],
      },
    },

	
	
	
	
	 pop2 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 10,
        heatfalloff        = 1.3,
        maxheat            = 15,
        pos                = [[r-2 r2, 5, r-2 r2]],
        size               = 6,
        sizegrowth         = 25,
        speed              = [[0, 1 0, 0]],
        texture            = [[bluedot]],
      },
    },
  
 


	
  }
}