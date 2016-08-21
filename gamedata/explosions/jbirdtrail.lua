return {
  ["jbirdtrail"] = {
  
	   alwaysvisible      = true,
	  usedefaultexplosions = false,

	outberbolt = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
			--0.45 0.9 0.7
        colormap           =[[ 0.45 0.9 0.7 0.01		0.05 0.5 0.3 0.01 	0.05 0.5 0.3 0.01 	0 0.6 	0	0.01 	0 0.6 	0	0.01 	0 0 	0	0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -32,
        sidetexture        = [[citdronegrad]],
        size               = 6,
        sizegrowth         = 0.18,
        ttl                = 24,
      }
    },
	
	}
}
