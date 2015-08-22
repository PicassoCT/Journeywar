return {
  ["cchainlightning"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,

	outberbolt = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 3,
      ground             = true,
      underwater         = true,
      water              = true,
      properties = {
       colormap           = [[0.05 0.35 0.95  0.01	0.05 0.35 0.95  0.01 	0.05 0.35 0.95  0.01	0.05 0.35 0.95  0.001		  ]],
        dir                = [[0.1r-0.8r0.8,0.1r-0.8r0.8,0.1r-0.8r0.8]],
        frontoffset        = 0,
        fronttexture       = [[glow]],
        length             = 44,
        sidetexture        = [[lightening]],
        size               = 42,
        sizegrowth         = 0.88,
        ttl                = 8,
      }
    },	
	
	
	backbolt = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = true,
      water              = true,
      properties = {
       colormap           = [[0.05 0.35 0.95  0.01	0.05 0.35 0.95  0.01 	0.05 0.35 0.95  0.01	0.05 0.35 0.95  0.001		  ]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[glow]],
        length             = -122,
        sidetexture        = [[lightening]],
        size               = 16,
        sizegrowth         = 1.18,
        ttl                = 22,
      }
    },
	
		trail = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0.05 0.35 0.95 0.01  0.05 0.35 0.95 0.01 0  0.2 0.5 0.01   0 0 0.6 0.01 	 0 0 0.6 0.01 	0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -32,
        sidetexture        = [[citdronegrad]],
        size               = -6,
        sizegrowth         = 0.18,
        ttl                = 48,
      }
    },
	
	}
}
