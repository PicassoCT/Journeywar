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
        colormap           = [[0 0 0 0		0.9 0.9 0.9 0.01		0 0 0 0]],
        dir                = [[dir]],
        frontoffset        = 0.05,
        fronttexture       = [[pulseshot]],
        length             = 225,
        sidetexture        = [[bluedot]],
        size               = 7,
        sizegrowth         = 1.125,
        ttl                = 125,
      },
    },     
	
	}

}