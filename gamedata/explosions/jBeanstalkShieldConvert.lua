-- 330rlexplode

return {
  ["jbeanstalkshieldconvert"] = {
  
 	tend = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.81 0.93 0.13 0.35 
									0.2 0.95 0.15 0.5
									0.05 0.5 0.2 0.15]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[smoke]],--redexplo
            length             = 25,
            sidetexture        = [[InvertedTenderTendrils]],
            size               = 9,
            sizegrowth         = 1.95,
            ttl                =20,
          },
        },	
		
		backtend = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.81 0.93 0.13 0.35 
									0.2 0.95 0.15 0.5
									0.05 0.5 0.2 0.15]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[smoke]],--redexplo
            length             = -42,
            sidetexture        = [[InvertedTenderTendrils]],
            size               = 9,
            sizegrowth         = -0.95,
            ttl                =20,
          },
        },
		
		
		    tendrils = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 4,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.81 0.93 0.13 0.35 
									0.2 0.95 0.15 0.5
									0.05 0.5 0.2 0.15]],
            dir                = [[0r-1r1,0.1r-0.9r0.9,0r-1r1]],
            frontoffset        = 0,
            fronttexture       = [[smoke]],--redexplo
            length             = 35,
            sidetexture        = [[InvertedTenderTendrils]],
            size               = 10,
            sizegrowth         = -3.15,
            ttl                =20,
          },
        },
		
		tendrils = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 4,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.81 0.93 0.13 0.35 
									0.2 0.95 0.15 0.5
									0.05 0.5 0.2 0.15]],
            dir                = [[0r-1r1,0.1r-0.9r0.9,0r-1r1]],
            frontoffset        = 0,
            fronttexture       = [[smoke]],--redexplo
            length             = -35,
            sidetexture        = [[InvertedTenderTendrils]],
            size               = 5,
            sizegrowth         = 0.55,
            ttl                =20,
          },
        },
	}

}

