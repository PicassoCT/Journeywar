-- electric_explosion

return {
  ["cviolentvehicledeath"] = {

   
    groundflash = {
      air                = true,
      alwaysvisible      = true,
      circlealpha        = 0.6,
      circlegrowth       = 6,
      flashalpha         = 0.9,
      flashsize          = 220,
      ground             = true,
      ttl                = 13,
      water              = true,
      color = {
        [1]  = 0,
        [2]  = 0.5,
        [3]  = 1,
      },
    },
    
  eas = {
      air                = true,
      class              = [[explspike]],
      count              = 15,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.1,
        color              = [[0.19,0.9,0.9]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 6,
        width              = 3,
      },
    },	
  
  
  },

}

