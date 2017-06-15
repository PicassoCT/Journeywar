-- missile_explosion

return {
  ["tangeldceg"] = {
      bitmapmuzzleflame = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0 0 0 0.01		0 0.5 1 0.01		0 0 0 0.01]],
        dir                = [[0r0.1r-0.1, 1, 0r0.1r-0.1]],
        frontoffset        = 0.05,
        fronttexture       = [[Accreationdisk]],
        length             = 25,
        sidetexture        = [[bluedot]],
        size               = 15,
        sizegrowth         = 1,
        ttl                = 25,
      },
    }, 
	}

}