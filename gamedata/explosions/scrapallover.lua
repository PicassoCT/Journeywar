-- blood_spray

return {
  ["scrapallover"] = {


	trap = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
       colormap           = [[0.25 0.20 0.10 1.0	0 0 0 0.0]], 
 
		directional        = true,
        emitrot            = 12,
        emitrotspread      = 15,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.09, 0]],
        numparticles       = 5,
        particlelife       = 19,
        particlelifespread = 22,
        particlesize       = 0.15,
        particlesizespread = 2.65,
        particlespeed      = 1,
        particlespeedspread = 0.5,
        pos                = [[0, 0, 0]],
        sizegrowth         =0,
        sizemod            = 0.999999999999999999999999,
        texture            = [[cbss]],
        useairlos          = false,
      },
    },
		
	scrap = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.25 0.20 0.10 1.0	0 0 0 0.0]], 
		directional        = true,
        emitrot            = 12,
        emitrotspread      = 25,
        emitvector         = [[0,0.85,0]],
        gravity            = [[0, -0.09, 0]],
        numparticles       = 5,
        particlelife       = 19,
        particlelifespread = 22,
        particlesize       = 0.15,
        particlesizespread = 3.25,
        particlespeed      = 1.5,
        particlespeedspread = 0.5,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 0.999999999999999999999999,
        texture            = [[bcssalpha]],
        useairlos          = false,
      },
    },
		
	
  },

}
