-- smallgreymuzzle

return {
  ["smallgreymuzzle"] = {
    bitmapmuzzleflame = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1.0 1.0 1.0 0.01	1.0 0.8 0.4 0.01	1 0.2 0.2 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[flash3]],
        length             = 3,
        sidetexture        = [[burstside]],
        size               = 1,
        sizegrowth         = 3,
        ttl                = 4,
      },
    },
    poof = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 6,
        heatfalloff        = 2,
        maxheat            = 6,
        pos                = [[0, 0, 0]],
        size               = 5,
        sizegrowth         = 1,
        speed              = [[0, 0, 0]],
        texture            = [[greynovaexplo]],
      },
    },
  },

}

