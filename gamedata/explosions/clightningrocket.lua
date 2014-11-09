return {
  ["lightningrocket"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,
 
    innerbolt = {

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0.2 0.5 0.8 0.01  0.5 0.3 0.85 0.01 	0.2 0.3 0.7 0.01	0.2 0.5 0.8 0.01  0.5 0.3 0.85 0.01 	0.2 0.3 0.7 0.01	 0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[laserendblue]],
        length             = -32,
        sidetexture        = [[pulseshot]],
        size               = -6,
        sizegrowth         = 0.15,
        ttl                = 59,
      }
    },

	
	outberbolt = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[0.1 0.9 0.9 0.01  0.8 1 1 0.01  0.1 0.9 0.9 0.01  0.8 1 1 0.01 	0.3 0.6 0.8 0.01 	0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[laserendblue]],
        length             = -42,
        sidetexture        = [[lightening]],
        size               = -6,
        sizegrowth         = 0.18,
        ttl                = 48,
      }
    },
	
	}
}
