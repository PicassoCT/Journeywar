-- dirt

return {
  ["darkgatesfx"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
        colormap           = [[0.35 0.30 0.30 0.05	0 0 0 0.0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 15,
        particlelifespread = 5,
        particlesize       = [[22]],
        particlesizespread = 10,
        particlespeed      = 1,
        particlespeedspread = 6,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 1.2,
        sizemod            = 1.0,
        texture            = [[laserendblue]],
        useairlos          = false,
      },
    },
	
	electroplasma = {
      air                = true,
      class              = [[explspike]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.03,
        color              = [[0.19,0.9,0.9]],
        dir                = [[0,-15 r30,0]],
        length             = 1,
        width              = 6,
      },
    },	
	

	
  bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
              colormap           = [[  0.5 0.9 0.9 0.001   0.5 0.9 0.9  0.003   0.1 0.3 0.5 0.004   0.1 0.3 0.5 0.004        0.1 0.3 0.5 0.001  ]],
            dir                = [[0, 1,0]],
            frontoffset        = 0,
            fronttexture       = [[Accreationdisk]],
            length             = 0,
            sidetexture        = [[]],--outRay
            size               = 320,
            sizegrowth         = 0.6,
            ttl                = 30,
			alwaysvisible=true,
          },
        },
	 
	
	
	
    dirtw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
        colormap           = [[0.35 0.30 0.30 0.05	0 0 0 0.0]],
        directional        = true,
        emitrot            = 90,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 2,
        particlelife       = 15,
        particlelifespread = 20,
        particlesize       = [[45]],
        particlesizespread = 10,
        particlespeed      = 1,
        particlespeedspread = 6,
        pos                = [[r-0.5 r0.5, 1 r2, r-0.5 r0.5]],
        sizegrowth         = 1.3,
        sizemod            = 1.0,
        texture            = [[novabg]],
        useairlos          = false,
      },
    },
	
  },

}

