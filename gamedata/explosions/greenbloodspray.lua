-- blood_spray

return {
  ["greenbloodspray"] = {
   	 spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[1 0.2 0 0.01  	0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]],
        gravity            = [[0, -0.17, 0]],
        numparticles       = 2,
        particlelife       = 27,
        particlelifespread = 17,
        particlesize       = 0.5,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1.001,
        sizemod            = 1.0,
        texture            = [[bubble]],
        useairlos          = false,
      },
    },
	
	    flare = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      ground             = false,
      water              = true,
      properties = {
        colormap           = [[1 1 1 1   1 1 1 1   0 0 0 0]],
        dir                = [[-1 r2, -1 r2, -1 r2]],
        frontoffset        = 0,
        fronttexture       = [[greenbloodsplat]],
        length             = 2,
        sidetexture        = [[greenbloodsplat]],
        size               = 2,
        sizegrowth         = 16,
        ttl                = 18,
      },
    },
	
  },

}
