
     
    return {
      ["civilbuildingdamage"] = {
	  
  papers = {
      air                = true,
      class              = [[CSimpleParticleSystem]] ,	
	  
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.8  0.8  0.8  0.3   0.8  0.8  0.8  1 	0.8  0.8  0.8  1   	]],	
		
        directional        = true,
        emitrot            = 25,
        emitrotspread      = 40,
        emitvector         = [[0,0.3,0]],	
       gravity            = [[0, -0.0027, 0]] , 
        numparticles       = 3,
        particlelife       = 80,
        particlelifespread = 227,
        particlesize       = 2.5,
        particlesizespread = 3,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0r26 r-26, 0]],
		 
        sizegrowth         = [[0.0 ]] ,
        sizemod            = 1.0,
        texture            = [[paper]] ,
		
        useairlos          = false,
      },
    },
	    glassshards = {
      air                = true,
      class              = [[CSimpleParticleSystem]] ,	
	  
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.8  0.8  0.8  0.05   0.2 0.8 1 0.05   	0 0 0 0.01]],	
		
        directional        = true,
        emitrot            = 25,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],	
       gravity            = [[0, -0.27, 0]] , 
        numparticles       = 1,
        particlelife       = 80,
        particlelifespread = 27,
        particlesize       = 3,
        particlesizespread = 9,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0r26 r-26, 0]],
		 
        sizegrowth         = [[0.0 ]] ,
        sizemod            = 1.0,
        texture            = [[shard]] ,
		
        useairlos          = false,
      },
    },   
	
	dropout = {
      air                = true,
      class              = [[CSimpleParticleSystem]] ,	
	  
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[1  1  1  1  	1  1  1  1  	1  1  1  1 	  ]],	
		
        directional        = true,
        emitrot            = 25,
        emitrotspread      = 75,
        emitvector         = [[0,-0.1,0]],	
       gravity            = [[0, -0.1, 0]] , 
        numparticles       = 5,
        particlelife       = 80,
        particlelifespread = 0,
        particlesize       = 9.5,
        particlesizespread = 3,
        particlespeed      = 1,
        particlespeedspread = 0,
        pos                = [[0, 0r26 r-26, 0]],
		 
        sizegrowth         = [[0.0 ]] ,
        sizemod            = 1.0,
        texture            = [[dropout.tga]] ,
		
        useairlos          = false,
      },
    },
	   
	  journeysoul = {
      air                = false,
      class              = [[CSimpleParticleSystem]] ,	
	  
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[1 0.2 0 0.025  1 0.2 0 0.035  1 0.2 0 0.065  1 0.2 0 0.095    ]],	
		
        directional        = true,
        emitrot            = 25,
        emitrotspread      = 40,
        emitvector         = [[0,-1,0]],	
       gravity            = [[0, 0.035, 0]] , 
        numparticles       = 1,
        particlelife       = 300,
        particlelifespread = 27,
        particlesize       = 0.01,
        particlesizespread = 9,
        particlespeed      = 2,
        particlespeedspread = 1,
        pos                = [[0, 0r26 r-26, 0]],
		 
        sizegrowth         = [[0.0001 ]] ,
        sizemod            = 1.0,
        texture            = [[bluedot]] ,
		
        useairlos          = false,
      },
    },
	   	
	  
    },
    }
