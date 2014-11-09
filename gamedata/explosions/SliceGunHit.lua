return {
  ["slicegunhit"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,

	backwards = {
    

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
        sidetexture        = [[TriggerZone]],--[[citdronegrad]]
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 48,
      }
    },
	forwards = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0.9 0.1 0.1 0.01  	0.9 0.1 0.1  0.008 	0.9 0.1 0.1  0.007  	0.2 0.9 0.9 0.001]],
        dir                = [[dir]],
        frontoffset        = 10,
        fronttexture       = [[empty]],
        length             = -32,
        sidetexture        = [[TriggerZone]],
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 48,
      }
    },
	    flare = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      ground             = false,
      water              = true,
      properties = {
        colormap           = [[1 1 1 1   1 1 1 1   0 0 0 0]],
        dir                = [[-1 r2, -1 r2, -1 r2]],
        frontoffset        = 0,
        fronttexture       = [[bloodsplat]],
        length             = 2,
        sidetexture        = [[bloodsplat]],
        size               = 2,
        sizegrowth         = 16,
        ttl                = 18,
      },
    },
	
	}
}
