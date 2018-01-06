

    return {
      ["healtrain"] = {
		  
	  ants2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
		
            colormap           = [[1 0.1 0.1   0.01   1 0.13 0.15   0.01		0 0 0   0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
            emitvector         = [[0,0.45,0]],
        gravity            = [[0, 0.00000007, 0]],
        numparticles       = 1,
        particlelife       = 110,
        particlelifespread = 11,
        particlesize       = 22.2,
        particlesizespread = 4,
        particlespeed      = 0.02,
        particlespeedspread = 1.005,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 0]],
        sizemod            = 0.999995,
        texture            = [[expandingstrobe]],
        useairlos          = false,
      },
    },
	
			upcross = {			
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = false,
			water = true,
			properties = {
				colormap = [[ 0.0 0.1 0.1 0.01  0.1 0.1 0.5 0.05 0 0 0.7 0.05 0 0.9 1 0.05	]],
				dir = [[0,1,0]],
				frontoffset = 0.5,
				fronttexture = [[cross]],
				length = 25,
				sidetexture = [[cross]],
				size = 12.5,
				sizegrowth = 0.125,
				ttl = 75,
			},			
		}
		
		
	  
				 
				 
				 
    },
    }
