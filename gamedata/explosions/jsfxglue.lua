-- blood_spray

return {
  ["sfxglue"] = {

		

    bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 3,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[0.7 0.7 0.7 .39  		0 0 0 0.0001  ]],
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
		
	
			
	
	
	
  },

}
