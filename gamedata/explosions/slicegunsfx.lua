return {
  ["slicegunsfx"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,

	fieldbackwards = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0.2 0.9 0.9 0.006  	0.2 0.9 0.9 0.005 	0.2 0.9 0.9 0.003  	0.2 0.9 0.9 0.001 ]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[ReservoirZone]],
        length             = 6,
        sidetexture        = [[flashside3alpha]],
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 24,
      }
    },
	fieldforwards = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0.2 0.9 0.9 0.006  	0.2 0.9 0.9 0.003  	0.2 0.9 0.9 0.001 ]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[ReservoirZone]],
        length             = -12,
        sidetexture        = [[huntertrail]],
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 24,
      }
    },
	
	
	}
}
