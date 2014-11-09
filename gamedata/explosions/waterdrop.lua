-- blood_spray

return {
  ["waterdrop"] = {
   
	
	 spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0.2 0.8 1 0.01   0.8 0.8 1 0.01  	0 0 0 0.01]],
        directional        = true,
        emitrot            = 15,
        emitrotspread      = 40,
        emitvector         = [[0,0.3,0]],
        gravity            = [[0, -0.27 r0.17, 0]],
        numparticles       = 5,
        particlelife       = 27,
        particlelifespread = 17,
        particlesize       = 0.000015,
        particlesizespread = 0.05,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1.000000000000000,
        sizemod            = 0.8,
        texture            = [[blueexplo]],
        useairlos          = false,
      },
    },
	

	
  },

}
