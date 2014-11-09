-- bluemuzzle

return {
  ["bluemuzzle"] = {
    bitmapmuzzleflame = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1 1 1 0.01	0.0 0.55 0.5 0.01	0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[flash3]],
        length             = 30,
        sidetexture        = [[shot]],
        size               = 10,
        sizegrowth         = 1,
        ttl                = 3,
      },
    },
  },

}

