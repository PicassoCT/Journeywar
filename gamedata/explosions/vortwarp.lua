    -- trail_ar2
     
    return {
      ["vortwarp"] = {
  alwaysvisible = true,
	
	    bitmapmuzzleflame = {	
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
	  colormap           = [[ 0.7 0.9 0.1 0.01	 0.7 0.9 0.1 0.01	0.0 0.0 0.0 0.01]],
        dir                = [[0,1,0]],
        frontoffset        = 1,
        fronttexture       = [[Accreationdiskalpha]],
        length             = 50,
        sidetexture        = [[antimatertwo]],
        size               = 45,
        sizegrowth         = 0.66,
        ttl                = 150,
      },
    },
		warparcs = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 6,
			ground = true,
			underwater = true,
			water = true,
			properties = {
				colormap = [[ 0.7 0.9 0.1 0.01	 0.7 0.9 0.1 0.01	0.0 0.0 0.0 0.01]],
				dir = [[0.9r-2,0.2r0.5,0.9r-2]],
				frontoffset = 0,
				fronttexture = [[lensflareCenter]],
				length = 24,
				sidetexture = [[lightening]],
				size = 2,
				sizegrowth = 4,
				ttl = 165,
			},
		},

		shrinkarcs = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 6,
			ground = true,
			underwater = true,
			water = true,
			properties = {
				colormap = [[ 0.7 0.9 0.1 0.01	 0.7 0.9 0.1 0.01	0.0 0.0 0.0 0.01]],
				dir = [[0.9r-2,0.2r0.5,0.9r-2]],
				frontoffset = 0,
				fronttexture = [[lensflareCenter]],
				length = 160,
				sidetexture = [[lightening]],
				size = 120,
				sizegrowth = 0.5,
				ttl = 165,
			},
		},	
	  
    },
    }
