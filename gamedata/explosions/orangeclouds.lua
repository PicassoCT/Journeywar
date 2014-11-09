-- dirt

return {
  ["orangeclouds"] = {
  

  
dirtglkf = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 4,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[1 0.6 0.3 0.2	0 0 0 0.0]],
        --colormap           = [[1 0.35 0.05 0.5	0 0 0 0.0]],
     
        directional        = false,
        emitrot            = 32,
        emitrotspread      = 22,
              emitvector         = [[0,dir,0]],
        gravity            = [[0, 0.0018, 0]],
        numparticles       = 1,
        particlelife       = 45,
        particlelifespread = 45,
        particlesize       = 1,
        particlesizespread = 9.5,
        particlespeed      = 0.22,
    
        
        sizegrowth         = 0.94,
        texture            = [[SmokeAshCloud]],
		particlespeedspread = 0.03,
        pos                = [[r-1 r1, 1, r-1 r1]],
 
        sizemod            = 0.95,
		
		
        useairlos          = false,
      },
      },
  
  
  
dirtgewrf = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
       -- colormap           = [[1 0.6 0.3 0.8	0 0 0 0.0]],
        colormap           = [[1 0.35 0.05 0.5	0 0 0 0.0]],
     
        directional        = false,
        emitrot            = 22,
        emitrotspread      = 32,
              emitvector         = [[0,dir,0]],
        gravity            = [[0, 0.0018, 0]],
        numparticles       = 1,
        particlelife       = 25,
        particlelifespread = 55,
        particlesize       = 1,
        particlesizespread = 15.5,
        particlespeed      = 0.22,
    
        
        sizegrowth         = 0.94,
        texture            = [[new_dirta]],
		particlespeedspread = 0.05,
        pos                = [[r-1 r1, 1, r-1 r1]],
 
        sizemod            = 0.95,
		
		
        useairlos          = false,
      },
      },
	
	},

}

