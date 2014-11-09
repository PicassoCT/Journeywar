    -- trail_ar2
     
    return {
      ["factorysfx"] = {
              
    
                spark = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          water              = false,
          properties = {
            airdrag            = 1,
            colormap           = [[0 0.5 1 0.1 0.2 0.8 1 0.01 ]],
            directional        = true,
            emitrot            = 0,
            emitrotspread      = 5,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, 0, 0]],
            numparticles       = 5,
            particlelife       = 17,
            particlelifespread = 47,
            particlesize       = 1,
            particlesizespread = 0,
            particlespeed      = 1,
            particlespeedspread = 3,
            pos                = [[0, 0, 0]],
            sizegrowth         = [[1s1.1]],
            sizemod            = 1.0,
            texture            = [[gunshot]],
            useairlos          = false,
          },
        },
     
	 
	               spark2 = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          water              = false,
          properties = {
            airdrag            = 1,
            colormap           = [[0 0.8 1 0.1     0 0.5 1 0. 1 ]],
            directional        = true,
            emitrot            = 0,
            emitrotspread      = 0,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, 0, 0]],
            numparticles       = 5,
            particlelife       = 47,
            particlelifespread = 17,
            particlesize       = 1,
            particlesizespread = 0,
            particlespeed      = 1,
            particlespeedspread = 3,
            pos                = [[0, 0, 0]],
            sizegrowth         = [[0s0.1]],
            sizemod            = 1.0,
            texture            = [[gunshot]],
            useairlos          = false,
          },
        },
     
    },
    }
