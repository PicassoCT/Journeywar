return {
  ["cpsitail"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,

	outberbolt = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = true,
      water              = true,
      properties = {
		colormap           = [[
									0.1 0.3 0.7 .005								
									0.3 0.3 0.8 .01		
									0.4 0.3 0.9 .015	
									0.1 0.3 0.7 .005 									
									0 0 0 0.0001  ]],
			dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -32,
        sidetexture        = [[jshieldgeom5]],
        size               = 16,
        sizegrowth         = -1,
        ttl                = 16,
      }
    },
	
	}
}
