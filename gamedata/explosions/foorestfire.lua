-- beamimpact

return {
  ["foorestfire"] = {
    
	

      aoceanofflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
		
          underwater         = 1,
          water              = false,
		    
          properties = {
		    alwaysvisible      = true,
		    useairlos          = false,
			colormap           = [[1 1 1 .004 	1 0.5 0.25 .004 	1 0.5 0.25 .004  	 1 0.3 0.05 .004		1 0.3 0.05 .004		1 0.3 0.05 .002	]],
			dir                = [[0r0.1,0.2r1,0r0.1]],
            frontoffset        = 0,
            fronttexture       = [[fire]],
            length             = 80,
            sidetexture        = [[fireside]],
            size               = 42,
            sizegrowth         = 0.995,
            ttl                = 32,
          },
        },

  
	

   
  },

}

