-- trail_ar2

return {
  ["cheadlaunch"] = {
  
	
	bitmapmuzzleflame = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 3,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = {
								colormap           = [[1.0 1.0 1.0 0.04
								0.2 0.5 0.9 0.01	
								0.1 0.5 0.7 0.01]],
									dir                = [[dir]],
									frontoffset        = 0,
									fronttexture       = [[innerswirl]],
									length             = 12,
									sidetexture        = [[vortw]],
									size               = 3,
									sizegrowth         = 1.31,
									ttl                = 25,
								  },
								},

	electricarcs12x = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
        colormap           = [[1.0 1.0 1.0 0.04
								0.2 0.5 0.9 0.01	
								0.1 0.5 0.7 0.01]],
        directional        = false,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[r1r-1, 1, r1r-1]],
        gravity            = [[0, -0.17, 0]],
        numparticles       = 1,
        particlelife       = 7,
        particlelifespread = 25,
        particlesize       = 0.5,
        particlesizespread = 1,
        particlespeed      = 0.01,
        particlespeedspread = 0.02,
        pos                = [[0, 2, 0]],
        sizegrowth         = 1,
        sizemod            = 1.0,
        texture            = [[fireSparks]],
        useairlos          = false,
      },
    },   
	
	
  },

}