    -- trail_ar2
     
    return {
      ["ctanglegunstrip"] = {
     fakelight = {
          air                = false,
          class              = [[CSimpleGroundFlash]],
          count              = 1,
          ground             = true,
          water              = false,
          properties = {
            colormap           = [[1 0.4 0.7 1  1 0.6 0.12 1    0 0 0 0.1]],
            size               = [[48 r5]],
            sizegrowth         = [[1 r1]],
            texture            = [[ar2groundflash]],
            ttl                = [[9 r4 r4]],
          },
        },
           
     
        bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.2 0.1 0.4 .01 	 1  0.6 0 .01  0.9 0.2 0.8 .01]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[]],--redexplo
            length             = -45,
            sidetexture        = [[flashside1]],
            size               = 4.4,
            sizegrowth         = -0.8,
            ttl                =20,
          },
        },
		
		
		    bitmapmuzzleflame2 = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[0.2 0.1 0.4 .01  1  0.6 0 .01   0.9 0.2 0.8 .01]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[]],--redexplo
            length             = 45,
            sidetexture        = [[flashside1]],
            size               = 2.4,
            sizegrowth         = 0.8,
            ttl                =20,
          },
        },		 
   
     
    },
    }
