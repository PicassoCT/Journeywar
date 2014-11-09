-- whitetail

return {
  ["whitetail"] = {
    pop2 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 4,
        heatfalloff        = 1,
        maxheat            = 4,
        pos                = [[r2 r-2, r2 r-2, r-2 r2]],
        size               = [[30 r-1.5]],
        sizegrowth         = -0.9,
        speed              = [[0, r-1.5, 0]],
        texture            = [[bluenovaexplo]],
      },
    },
    whiteglow = {
      air                = true,
      class              = [[heatcloud]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        heat               = 5,
        heatfalloff        = 1.1,
        maxheat            = 5,
        pos                = [[r2 r-2, r2 r-2, r2 r-2]],
        size               = 28,
        sizegrowth         = 2,
        speed              = [[0, 1 0, 0]],
        texture            = [[laserend]],
      },
    },
  },

}

