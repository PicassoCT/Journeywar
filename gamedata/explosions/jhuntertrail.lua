return {
  ["jhuntertrail"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,

	outberbolt = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[
									0.2 0.9 1   0.03
									0.1 0.1 0.6 0.025
									0.2 0.9 1   0.02
									0.1 0.1 0.1 0.025
									0.1 0.1 0.6 0.02
									0.1 0.1 0.1 0.01
									0.1 0.1 0.1 0.01
									0.1 0.1 0.1 0.01
									0 0 0 0.0]],

			dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -22,
        sidetexture        = [[huntertrail]],
        size               = -12,
        sizegrowth         = 0.32,
        ttl                = 44,
      }
    },
	
	}
}
