-- blood_spray

return {
  ["watergatesfx"] = {
   
	
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
	

	
  },

}
