-- blood_spray

return {
  ["jfac2sfx"] = {
   
	
	 spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0.2 0.8 1 0.01  	0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.27, 0]],
        numparticles       = 4,
        particlelife       = 27,
        particlelifespread = 7,
        particlesize       = 0.000025,
        particlesizespread = 0.5,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1.000000000000000,
        sizemod            = 0.8,
        texture            = [[Flake]],
        useairlos          = false,
      },
    },
	
	waterdrop = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.001,
        colormap           = [[0.2 0.8 1 0.01  	0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,0.3,0]],
        gravity            = [[0, -0.67, 0]],
        numparticles       = 2,
        particlelife       = 50,
        particlelifespread = 11,
        particlesize       = 3.25,
        particlesizespread = 15.9,
        particlespeed      = 0.002,
        particlespeedspread = 1.005,
        pos                = [[0, 0, 0]],
        sizegrowth         =  1.0000000001,
        sizemod            = 1.0000000000000002,
        texture            = [[firesparks]],
        useairlos          = false,
      },
    },
	
  },

}
