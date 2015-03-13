    -- trail_ar2
     
    return {
      ["bonkermuzzle"] = {
     fakelight = {
          air                = false,
          class              = [[CSimpleGroundFlash]],
          count              = 1,
          ground             = true,
          water              = false,
          properties = {
            colormap           = [[1 0.4 0.7 1  1 0.6 0.12 1    0 0 0 0.1]],
            size               = [[18 r5]],
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
            colormap           = [[   	0.06 0.4 0.95  0.01 	0.06 0.4 0.95  0.01       0 0 0 0]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[flash3]],
            length             = -25,
            sidetexture        = [[flashside2muzz]],
            size               = 9,
            sizegrowth         = 1.5,
            ttl                = 8,
          },
        },
   
     
    },
    }
