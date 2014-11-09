return {
  ["jbeanstalkphoenix"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,
 
    flame = {

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1 0.8 0.2 0.01  1 0.8 0.2 0.01 	0.9 0.3 0 0.01  0.9 0.3 0 0.01	 0.9 0 0 0.01 0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[firehd]],
        length             = -32,
        sidetexture        = [[fire4]],
        size               = -6,
        sizegrowth         = 0.75,
        ttl                = 14,
      }
    },

	
	fire = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1 0.8 0.2 0.01  1 0.8 0.2 0.01 	0.9 0.3 0 0.01  0.9 0.3 0 0.01	 0.9 0 0 0.01 0.9 0 0 0.01	0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[Flake]],
        length             = -42,
        sidetexture        = [[fireside]],
        size               = -6,
        sizegrowth         = 0.75,
        ttl                = 12,
      }
    },
	
	}
}
