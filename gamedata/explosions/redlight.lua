-- redlight

return {
  ["redlight"] = {
    glow = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 2,
        heatfalloff        = 0.1,
        maxheat            = 2,
        pos                = [[0,0,0]],
        size               = [[1 r1]],
        sizegrowth         = [[ 1 r1]],
        speed              = [[0, 1 0, 0]],
        texture            = [[laserendred]],
      },
    },
  },

}

