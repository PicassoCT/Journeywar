-- redlight

return {
  ["cflakimpact"] = {
  	 


	 lensflare = {
	 
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
         colormap           = [[0.5 0.5 0.95  0.01 	0.06 0.4 0.95  0.01 	0.07 0.5 0.9  0.01	0.12 0.9 0.9  0.001		  ]],
        directional        = true,
        emitrot            = 1,
        emitrotspread      = 5,
        emitvector         = [[dir]],
        gravity            = [[0, 0   , 0]],
        numparticles       = 1,
        particlelife       = 15,
        particlelifespread = 35,
        particlesize       = 15 ,
        particlesizespread = 7,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1.000000000000001,
        sizemod            =  0.99	,
        texture            = [[Flake]],
        useairlos          = false,
      },
    },

	
	}
  }


