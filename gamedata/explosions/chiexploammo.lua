-- missile_explosion

return {
  ["chiexploammo"] = {

    groundflash = {
      air                = true,
      alwaysvisible      = true,
      circlealpha        = 0.6,
      circlegrowth       = 6,
      flashalpha         = 0.9,
      flashsize          = 120,
      ground             = true,
      ttl                = 13,
      water              = true,
      color = {
        [1]  = 1,
        [2]  = 0.7,
        [3]  = 0.25,
      },
    },
  
  
    bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 12,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.2 0.6 1 .01   1 0.7 0.25 .01         0 0 0 0]],
            dir                = [[0.1 r-0.8 r0.8,0.1 r-0.8 r0.8,0.1 r-0.8 r0.8 ]],
            frontoffset        = 0,
            fronttexture       = [[crimsonnovaexplo]],--redexplo
            length             = 25,
            sidetexture        = [[megaparticle]],
            size               = 3,
            sizegrowth         = 1,
            ttl                = 15,
          },
        },
		
    bitmapmuzzleflame2 = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 12,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
           colormap           = [[0.001 0.001 0.001 1 0.001 0.001 0.001 0.5	0.001 0.001 0.001 0.25  0.001 0.001 0.001 0.125  0.001 0.001 0.001 0 0.001 0.001 0.001 0 0.001 0.001 0.001 0 0.001 0.001 0.001 0	  ]],
            dir                = [[0.1 r-0.8 r0.8,0.1 r-0.8 r0.8,0.1 r-0.8 r0.8 ]],
            frontoffset        = 1,
            fronttexture       = [[triang]],--redexplo
            length             = 25,
            sidetexture        = [[ ]],
            size               = 0.125,
            sizegrowth         = 42,
            ttl                = 40,
          },
        },
		
	 

  },

}

