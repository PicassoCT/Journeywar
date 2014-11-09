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
        length             = 22,
        sidetexture        = [[TriggerZone]],
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 48,
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
        fronttexture       = [[empty]],
        length             = -12,
        sidetexture        = [[TriggerZone]],
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 48,
      }
    },
	
	
	}
}
