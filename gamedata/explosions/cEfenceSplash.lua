return {
["cEfenceSplash"] = {
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 50,
      ttl                = 10,
      color = {
        [1]  = 0.5,
        [2]  = 0.3,
        [3]  = 1,
      },
    },    
	electroplasma = {
      air                = true,
      class              = [[explspike]],
      count              = 5,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.1,
        color              = [[0.5,0.2,1]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 5,
        width              = 20,
      },
    },	
  }
}