-- blood_spray

return {
  ["bgbloodslay"] = {

		

    bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 3,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[0.7 0.1 0.1 .39   0.8 0.1 0.05 .39		0 0 0 0.0001  ]],
            dir                = [[0.1 r-0.8 r0.8,0.1 r-0.8 r0.8,0.1 r-0.8 r0.8 ]],
            frontoffset        = 0,
            fronttexture       = [[bloodsplat]],--redexplo
            length             = 15,
            sidetexture        = [[bloodsplat]],
            size               = 3,
            sizegrowth         = 1,
            ttl                = 20,
          },
        },
		
		
  flare = {
			  air                = true,
			  class              = [[CSimpleParticleSystem]],
			  count              = 2,
			  ground             = true,
			  water              = false,
			  properties = {
				airdrag            = 1,
				colormap           = [[0.8 0.6 0.1 1.0	 0.8 0.6 0.1 1.0	0.8 0.6 0.1 1.0	 0 0 0 0.0  0 0 0 0.0  0 0 0 0.0]],
				directional        = true,
				emitrot            = 5,
				emitrotspread      = 90,
					emitvector         = [[0,1,0]],
				gravity            = [[0, 0.00000007, 0]],
				numparticles       = 5,
				particlelife       = 35,
				particlelifespread = 11,
				particlesize       = 1.2,
				particlesizespread = 5,
				particlespeed      = 0.02,
				particlespeedspread = 1.005,
				pos                = [[0, -50, 0]],
				sizegrowth         = [[0.0 0.0000000000000000001]],
				sizemod            = 0.99999999,
				texture            = [[watersplat.tga]],
				useairlos          = false,
			  },
			},
			
	
	
	
  },

}
