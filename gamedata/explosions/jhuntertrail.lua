return {
  ["jhuntertrail"] = {
  
	alwaysvisible      = true,
	usedefaultexplosions = false,


    outberbolt = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
     airdrag            = 1,
               colormap           = [[
									0.2 0.9 1   0.02
									0.1 0.1 0.6 0.02
									0.1 0.1 0.6 0.01
									0.1 0.1 0.1 0.01
									0 0 0 0.0]],
									
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0.01r-0.01, 0.01r-0.01, 0.01r-0.01]],
        numparticles       = 1,
        particlelife       = 24,
        particlelifespread = 0,
        particlesize       = 12,
        particlesizespread = 3,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0r1r-1, 0r1r-1, 0r1r-1]],
        sizegrowth         = [[0.32r0.5r-0.5]],
        sizemod            = 1.0,
        texture            = [[huntertrail]],
        useairlos          = false,
      },
    },
	
	}
}
