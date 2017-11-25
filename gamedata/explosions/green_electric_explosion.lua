-- electric_explosion

return {
  ["green_electric_explosion"] = {
  
    electric1 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 20,
        heatfalloff        = 1.1,
        maxheat            = 30,
        pos                = [[r-2 r2, 5, r-2 r2]],
        size               = 2,
        sizegrowth         = 5,
        speed              = [[0, 1 0, 0]],
        texture            = [[greennovaexplo]],
      },
    },
    electric2 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 20,
        heatfalloff        = 1.3,
        maxheat            = 15,
        pos                = [[r-2 r2, 5, r-2 r2]],
        size               = 3,
        sizegrowth         = 5,
        speed              = [[0, 0, 0]],
        texture            = [[flare]],
      },
    },
 
    groundflash = {
      air                = true,
      alwaysvisible      = true,
      circlealpha        = 0.6,
      circlegrowth       = 6,
      flashalpha         = 0.9,
      flashsize          = 120,
      ground             = true,
      ttl                = 13,
      water              = true,
      color = {
        [1]  = 0.4,
        [2]  = 1,
        [3]  = 0.1,
      },
    },
    
    whiteglow = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 10,
        heatfalloff        = 1.1,
        maxheat            = 15,
        pos                = [[0, 5, 0]],
        size               = 5,
        sizegrowth         =10,
        speed              = [[0, 1 0, 0]],
        texture            = [[laserendgreen]],
      },
    },
  },

}

