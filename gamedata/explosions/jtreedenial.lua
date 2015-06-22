-- blood_spray

return {
  ["jtreedenial"] = {
   
	
	 spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 5,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0.0 0.9 0.4 0.01  	0.1 0.3 0 0.01]],
        directional        = true,
        emitrot            = 35,
        emitrotspread      = 40,
        emitvector         = [[0r0.05r-0.05,0.05,0r0.05r-0.05]],
        gravity            = [[0, -0.007, 0]],
        numparticles       = 3,
        particlelife       = 270,
        particlelifespread = 0,
        particlesize       = 42,
        particlesizespread = 22.5,
        particlespeed      = 6,
        particlespeedspread = 8,
        pos                = [[0r20r-20, 0, 0r20r-20]],
        sizegrowth         = 1.0000000000000001,
        sizemod            = 0.92000000000,
        texture            = [[laserendyellow]],
        useairlos          = false,
      },
    },
	 test = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0.0 0.9 0.4 0.01  	0.1 0.3 0 0.01]],
        directional        = true,
        emitrot            = 35,
        emitrotspread      = 40,
        emitvector         = [[0r0.05r-0.05,0.05,0r0.05r-0.05]],
        gravity            = [[0, -0.007, 0]],
        numparticles       = 3,
        particlelife       = 270,
        particlelifespread = 0,
        particlesize       = 50.5,
        particlesizespread = 12,
        particlespeed      = 6,
        particlespeedspread = 8,
        pos                = [[0r20r-20, 0, 0r20r-20]],
        sizegrowth         = 1.0000000000000001,
        sizemod            = 0.99000000000,
        texture            = [[lensflareCenter]],
        useairlos          = false,
      },
    },
	

	
  },

}
