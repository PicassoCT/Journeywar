

-- dirt

return {
  ["firecolumn"] = {
    frontalFire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 5,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,

 		colormap           = [[1 0.61 0.27 0.01 	1 0.61 0.27 0.01	0.97 0.23 0.13 0.01  0.97 0.23 0.13 0.01 	 0.64 0.10 0.17 0.01]],
        directional        = true,
        emitrot            = 1,
        emitrotspread      = 1,
        emitvector         = [[0,0.5r3,0]],
        gravity            = [[0, r0.01r-0.005,0]],
        numparticles       = 1,
        particlelife       = 30,
        particlelifespread = 20,
        particlesize       = 5.23,
        particlesizespread = 8.23,
        particlespeed      = 0.1,
        particlespeedspread = 0.2,
        pos                = [[r5r-5,r10r-10, r5r-5]],
		sizegrowth         = 0.01,
        sizemod            = 0.9978,
        texture            = [[fire8]],
        useairlos          = false,
      },
    }, 

sideFire = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
          
		    colormap           = [[1 0.61 0.27  0.01	1 0.61 0.27  0.01	 0.20 0.10 0.01]],
        directional        = true,
        emitrot            = 1,
        emitrotspread      = 1,
        emitvector         = [[0,0.5r3,0]],
        gravity            = [[0, r0.01r-0.005,0]],
        numparticles       = 1,
        particlelife       = 30,
        particlelifespread = 20,
        particlesize       = 5.23,
        particlesizespread = 8.23,
        particlespeed      = 0.1,
        particlespeedspread = 0.2,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
		sizegrowth         = 0.01,
        sizemod            = 0.9978,
        texture            = [[fire8]],
        useairlos          = false,
      },
    },
    fire22 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        airdrag            =1,
 		colormap           = [[1 0.61 0.27 0.01 	1 0.61 0.27 0.01	0.97 0.23 0.13 0.01  0.97 0.23 0.13 0.01 	 0.64 0.10 0.17 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[0,0.5r3,0]],
        gravity            = [[0, r0.01r-0.005,0]],
        numparticles       = 1,
        particlelife       = 30.3,
        particlelifespread = 20,
        particlesize       = 5.23,
        particlesizespread = 8.23,
        particlespeed      = 0.1,
        particlespeedspread = 0.2,
        pos                = [[0 r18 r-18, 15, 0 r18 r-18]],
        sizegrowth         = 0.01,
        sizemod            = 0.9978,
        texture            = [[fire3]],
      },
    },
  

 

  
  
  },

}


-- trail_ar2


