
     
    return {
      ["crosepetals"] = {
	  
	roses = {
      air                = true,
      class              = [[CSimpleParticleSystem]] ,	
	  
      count              = 4,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.5  0	0  0.3   0.5  0	0  1 		0.5  0	0  1   0.5  0	0  1  0.5  0	0  0.25 	]],	
		
        directional        = true,
        emitrot            = 25,
        emitrotspread      = 40,
        emitvector         = [[0r0.05r-0.05,0.1,0r0.05r-0.05]],	
       gravity            = [[0, -0.0032r-0.001r0.001, 0]] , 
        numparticles       = 1,
        particlelife       = 300,
        particlelifespread = 250,
        particlesize       = 1.5,
        particlesizespread = 2,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0r-5, 0]],
		 
        sizegrowth         = [[0.0 ]] ,
        sizemod            = 1.0,
        texture            = [[rosepetals]] ,
		
        useairlos          = false,
      },
    }
	  
    },
    }
