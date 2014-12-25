-- blood_spray

return {
  ["bgbloodslay"] = {
	blooddrops = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.7 0.1 0.1 .39   0.8 0.1 0.05 .39		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[0,0.1,0]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 1,
        particlelife       = 19,
        particlelifespread = 4,
        particlesize       = 2.5,
        particlesizespread = 2,
        particlespeed      = 0.5,
        particlespeedspread = 0.15,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.25]],
        sizemod            = 1.0,
        texture            = [[bloodsplat]],
        useairlos          = false,
      },
    },
		

	
	
	
  },

}
