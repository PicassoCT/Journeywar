return {
["CARTDM_STARFX"] = {  
	glowing = {
      air                = true,
      class              = [[explspike]],
      count              = 2,
      ground             = true,
      water              = true,

	  
      properties = {
        alpha              = 0.8,
        alphadecay         = 0.08,
           color              = [[0.19,0.9,0.9]],
	   -- colormap           = [[0.9 0.8 0.4 0.04	 0.9 0.5 0.0 0.01	0 0 0 0.00]],
        dir                = [[-15 r50,-15 r50,-15 r50]],
        length             = 2,
        width              = 22,
      },
    },	
	
	bluestripe = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = false,
      water              = true,
      properties = {
        colormap           = [[0.1 0.9  0.9   0.01  	0.1 0.9  0.9   0.01 	0.1 0.9  0.9   0.01   0.1 0.9  0.9   0.01 	]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -12,
        sidetexture        = [[citdronegrad]],
        size               = -3,
        sizegrowth         = 0.18,
        ttl                = 24,
      }
    },
	
  }
}