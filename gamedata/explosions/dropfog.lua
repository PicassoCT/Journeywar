-- dirt

return {
	["dropfog"] = {
		       dropfog = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 5,
      ground             = true,
      water              = true,
		  properties = {
			airdrag            = 0.1,
			alwaysvisible      = true,
				colormap = [[
				0 0 0 0.0		
				0.9 0.9 0.9 0.1125	
				0.9 0.9 0.9 0.1525	
				0.9 0.9 0.9 0.1125	
				0.9 0.9 0.9 0.100	
				0.9 0.9 0.9 0.1125	
				0.9 0.9 0.9 0.1525	
				0.9 0.9 0.9 0.1125	
				0 0 0 0.0]],
			directional        = false,
			emitrot            = 90,
        emitrotspread      = 32,
        emitvector         = [[0r-0.5r0.5, 1r0.25, 0r-0.5r0.5]],
        gravity            = [[0r-0.01r0.01,0r-1.5r1.5, 0r-0.01r0.01]],
			numparticles       = 1,
			particlelife       = 128,
			particlelifespread = 164,
			particlesize       = 32,
			particlesizespread = 64,
			particlespeed      = 200.0,
			particlespeedspread = 2.0,
			pos                = [[0, 0, 0]],
			sizegrowth         = 0.9999,
     sizemod            = 0.995,
			texture            = [[new_dirtb]],
			useairlos          = false,
					},
				}
				
	
		
	}
	
}