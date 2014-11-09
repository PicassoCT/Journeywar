-- dirt

return {
  ["jmomgeom"] = {
   jsten = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
         colormap           = [[0.55 0.6 0.15  0.01  0.8 0.9 0.1 0.01   0.9 1 0 0.01 	 0.8 0.9 0.1 0.01 	0.55 0.6 0.15  0.01 	0 0 0 0.0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[-0.03 r0.03, 0.0001, -0.03 r0.03]],
        numparticles       = 2,
        particlelife       = 150,
        particlelifespread = 150,
        particlesize       = [[120 r9]],
        particlesizespread = 13,
        particlespeed      = 0.2,
        particlespeedspread = 0.1,
        pos                = [[0, 50 r22,0]],
        sizegrowth         = 0.99999999999999,
        sizemod            =  0.994,
        texture            = [[jshieldgeom9]],
        useairlos          = false,
      },
    },
	      
		
  
  	        exaust = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 0,
          water              = true,
          properties = {
			colormap           = [[0.55 0.6 0.15  0.01   0.8 0.9 0.1 0.01   0.9 1 0 0.01 	 0.8 0.9 0.1 0.01 	0.55 0.6 0.15  0.01 	0 0 0 0.0]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[jshieldgeomhypcube]],
            length             = -3,
            sidetexture        = [[jshieldgeom9]],
            size               = [[12 r42]],
            sizegrowth         = 1,
            ttl                = [[90 r90]],
          },
        },
  
  
   
 


  },

}

