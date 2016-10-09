return {
  ["cssfirejet"] = {
  
	alwaysvisible      = true,
	usedefaultexplosions = false,


	  bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
          	colormap = [[1 1 1 .01  	1 0.3 0.05 .01		0 0 0 0.01]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[flash1]],
            length             = 12,
            sidetexture        = [[fireside]],
            size               = 1,
            sizegrowth         = 1.25,
            ttl                = 25,
          },
        },
		
		jet = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
          	colormap = [[1 1 1 .01  	1 0.3 0.05 .01		0 0 0 0.01]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[fireyexplo]],
            length             = 12,
            sidetexture        = [[Fire4]],
            size               = 1,
            sizegrowth         = 1.5,
            ttl                = 25,
          },
        },		
		
		stream = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
          	colormap = [[1 1 1 .01  	0.8 0.3 0.05 .01	]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[fireyexplo]],
            length             = 8,
            sidetexture        = [[Fire2]],
            size               = 0.25,
            sizegrowth         = 3,
            ttl                = 45,
          },
        },
	
	
	}
}
