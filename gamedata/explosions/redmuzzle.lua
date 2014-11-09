-- redmuzzle

return {
  ["redmuzzle"] = {
    bitmapmuzzleflame = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1 1 1 0.01	1 0.9 0.36 0.01		0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0.05,
        fronttexture       = [[flash3]],
        length             = 30,
        sidetexture        = [[shot]],
        size               = 10,
        sizegrowth         = 1,
        ttl                = 7,
      },
    },
    whiteglow = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 10,
        heatfalloff        = 3.5,
        maxheat            = 15,
        pos                = [[0, 0, 0]],
        size               = 9,
        sizegrowth         = 40,
        speed              = [[0, 0, 0]],
        texture            = [[glow]],
      },
    },
  },

}

