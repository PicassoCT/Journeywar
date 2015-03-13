-- beamimpact

return {
  ["bigfoorestfire"] = {
    
	
       

      aexpand = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
		
          underwater         = 0,
          water              = false,
		    
          properties = {
		    alwaysvisible      = true,
		    useairlos          = false,
			colormap           = [[1 1 1 .005 	1 0.5 0.25 .001 1 0.5 0.25 .005   1 0.3 0.05 .005		1 0.3 0.05 .005	 1 0.3 0.05 .001		]],
			dir                = [[0r0.01r-0.01,0.2r1,0r0.01r-0.01]],
            frontoffset        = 0,
            fronttexture       = [[fire]],
            length             = 80,
            sidetexture        = [[]],
            size               = 64,
            sizegrowth         = 0.995,
            ttl                = 35,
          },
        },
  
        bcontract = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
		
          underwater         = 0,
          water              = false,
		    
          properties = {
		    alwaysvisible      = true,
		    useairlos          = false,
			colormap           = [[1 1 1 .005 	1 1 1 .005 	1 1 1 .005   1 1 1 .005		1 1 1 .005	1 1 1 .001		]],
			dir                = [[0r0.01r-0.01,0.2r1,0r0.01r-0.01]],
            frontoffset        = 0,
            fronttexture       = [[fireyexplo]],
            length             = 80,
            sidetexture        = [[]],
            size               = 75,
            sizegrowth         = 1.001,
            ttl                = 42,
          },
        },
  
  },

}

