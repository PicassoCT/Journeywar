return {
  ["psiimpact"] = {
  
 
			risingglobes = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 6,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[
									0.1 0.3 0.7 .0   
									0.1 0.3 0.7 .01   
									0.3 0.3 0.8 .02		
									0.4 0.3 0.9 .03	
									0.1 0.3 0.7 .01 									
									0 0 0 0.0001  ]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[0r0.1r-0.1,1r-0.2,0r0.1r-0.1]],
        gravity            = [[0, r-0.02r0.023, 0]],
        numparticles       = 1,
        particlelife       = 10,
        particlelifespread = 40,
        particlesize       = 5,
        particlesizespread = 50,
        particlespeed      = 0.2,
        particlespeedspread = 2,
        pos                = [[r20r-20, 0, r20r-20]],
        sizegrowth         = [[0.0r.55]],
        sizemod            = 1.0,
        texture            = [[fireSparks]],
        useairlos          = false,
      },
    },
		
				},
}

