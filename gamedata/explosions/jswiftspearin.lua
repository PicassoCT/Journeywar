-- missile_explosion

return {
  ["jswspin"] = {
       retract = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0 0 0 0	
								0.9 0.9 0.9 0.01	
								0.9 0.9 0.9 0.01	
								0.9 0.9 0.9 0.02	
								0.9 0.9 0.9 0.01	
								0.9 0.9 0.9 0.01	
								0 0 0 0]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[flake]],
        length             = 250,
        sidetexture        = [[spawnpointside]],
        size               = 2,
        sizegrowth         = -4,
        ttl                = 125,
      },  
	  unfold = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0 0 0 0	
								0.9 0.9 0.9 0.01	
								0.9 0.9 0.9 0.01	
								0.9 0.9 0.9 0.02	
								0.9 0.9 0.9 0.01	
								0.9 0.9 0.9 0.01	
								0 0 0 0]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[flake]],
        length             = 50,
        sidetexture        = [[spawnpointside]],
        size               = 2,
        sizegrowth         = 4,
        ttl                = 125,
      },

}
}