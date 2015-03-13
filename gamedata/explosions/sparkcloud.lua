-- dirt

return {
  ["sparkcloud"] = {
    sparkcloudg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = false,
      properties = {
        airdrag            = 0.4,
        alwaysvisible      = true,
	
        colormap           = [[0.0 0.3 1 0.003	 0.0 0.3 1 0.003	 0.0 0.3 1 0.002  0.0 0.3 1  0.001	]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 25,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.0 0.0, 0]],
        numparticles       = 12,
        particlelife       = 45,
        particlelifespread = 20,
        particlesize       = [[12 r32]],
        particlesizespread = 10,
        particlespeed      = 5,
        particlespeedspread = 6,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 1.2,
        sizemod            = 1.0,
        texture            = [[sparkcloud]],
        useairlos          = true,
      },
    },
    		bitmapmuzzleflamess = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 1,
								  ground             = true,
								  underwater         = 0,
								  water              = true,
								  properties = {
									colormap           = [[0.5 0.6 0.9 0.005	  0.5 0.6 0.9 0.004	 0.4 0.5 0.9 0.003  0.3 0.4 0.9  0.001	]],
									dir                = [[0 r0.5 r-0.5, 1,r0.5 r-0.5]],
									frontoffset        = 0,
									fronttexture       = [[laserendblue]],
									length             = 600,
									sidetexture        = [[vortw]],
									size               = 242,
									sizegrowth         = 0.01,
									ttl                = 45,
								  },
								},
			striplight = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 1,
								  ground             = true,
								  underwater         = 0,
								  water              = true,
								  properties = {
									colormap           = [[0.5 0.6 0.9 0.005	  0.5 0.6 0.9 0.004	 0.4 0.5 0.9 0.003  0.3 0.4 0.9  0.001	]],
									dir                = [[0, 3,0]],
									frontoffset        = -100,
									fronttexture       = [[]],
									length             = 300,
									sidetexture        = [[strips]],
									size               = 242,
									sizegrowth         = 0.2,
									ttl                = 20,
								  },
								},
								
								
  },

}

