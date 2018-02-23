-- missile_explosion

return {
  ["jswspout"] = {
      bitmapmuzzleflame = {
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
        length             = 75,
        sidetexture        = [[spawnpointside]],
        size               = 2,
        sizegrowth         = 4,
        ttl                = 125,
      },
    },     
	
	}

}