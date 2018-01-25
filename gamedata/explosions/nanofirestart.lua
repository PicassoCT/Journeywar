-- blood_spray

return {
  ["nanofirestart"] = {

	
	    bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[1 0.1 0.3  .05   0.9 0.05 0.2  .075		0.7 0.3 0.3 0.0001  ]],
             dir                = [[0, 1, 0]],
            frontoffset        = 0,
            fronttexture       = [[ActionZone]],--redexplo
            length             = 8,
            sidetexture        = [[fireside]],
            size               = 2,
            sizegrowth         = 8,
            ttl                = 80,
          },
        },
	
   flameon = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 3,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[1 0.1 0.3  .05   0.9 0.05 0.2  .075		0.7 0.3 0.3 0.0001  ]],
             dir                = [[0.5r-0.5, r1, 0.5r-0.5]],
            frontoffset        = 0,
            fronttexture       = [[fireyexplo]],--redexplo
            length             = 8,
            sidetexture        = [[lightening]],
            size               = 6,
            sizegrowth         = 6,
            ttl                = 80,
          },
        },
		
   retract = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 10,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[1 0.1 0.3  .075   0.9 0.05 0.2  .075		0.7 0.3 0.3 0.01  ]],
             dir                = [[r1r-1, r1, r1r-1]],
            frontoffset        = 0,
            fronttexture       = [[fireyexplo]],--redexplo
            length             = 250,
            sidetexture        = [[lightening]],
            size               = 30,
            sizegrowth         = -0.95,
            ttl                = 80,
          },
        },	
   groundplate = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 3,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[0.7 0.3 0.3 0.0001  1 0.1 0.3  .05   0.9 0.05 0.2  .05		0.7 0.3 0.3 0.0001  ]],
             dir                = [[r0.1r-0.1, 1, r0.1r-0.1]],
            frontoffset        = 0,
            fronttexture       = [[firenovaexplo]],--redexplo
            length             = 0,
            sidetexture        = [[]],
            size               = 300,
            sizegrowth         = -0.975,
            ttl                = 80,
          },
        },
	sparks = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 5,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[0.7 0.3 0.3 0.001  1 0.1 0.3  .025   0.9 0.05 0.2  .025		0.7 0.3 0.3 0.0001  ]],
             dir                = [[r0.1r-0.1, r0.5r0.5, r0.1r-0.1]],
            frontoffset        = 0,
            fronttexture       = [[fireSparks]],--redexplo
            length             = 0,
            sidetexture        = [[]],
            size               = 250,
            sizegrowth         = -0.925,
            ttl                = 40,
          },
        }
		

}
}
