-- blood_spray

return {
  ["bluebloodspray"] = {


    bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = true,
          water              = true,
          properties = {
        colormap           = [[0.3 0.3 0.9 .025   0.05 0.1 0.8 .025		0 0 0 0.0001  ]],
             dir                = [[-1 r2, -1 r2, -1 r2]],
            frontoffset        = 0,
            fronttexture       = [[bigexplosmoke]],--redexplo
            length             = 10,
            sidetexture        = [[burstside]],
            size               = 4,
            sizegrowth         = 3,
            ttl                = 20,
          },
        },
	
		
		blooddrops2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.3 0.3 0.9 .025   0.05 0.1 0.8 .025		0 0 0 0.0001  ]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 5,
        emitvector         = [[dir]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 2,
        particlelife       = 19,
        particlelifespread = 22,
        particlesize       = 1,
        particlesizespread = 1,
        particlespeed      = 1,
        particlespeedspread = 0.5,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.0,
        texture            = [[fireSparks]],
        useairlos          = false,
      },
    },
	
  },

}
