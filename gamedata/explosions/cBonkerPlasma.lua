-- trail_ar2

return {
  ["cbonkerplasma"] = {
  
  fakelightx = {
      air                = false,
      class              = [[CSimpleGroundFlash]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        colormap           = [[0.6 1 1 0.045  0.6 1 1 0.035  0.5 0.9 1 0.035  ]],
        size               = [[8 r-5]],
        sizegrowth         = [[2 r-3]],
        texture            = [[ar2groundflash]],
        ttl                = [[59 r4 r-4]],
      },
    },
  

	 plasmachannel = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
          colormap           = [[0.6 1 1 0.0045  0.6 1 1 0.0045   0.5 0.9 1 0.0045    0.1 0.05 0.8 0.0045  ]],
	  --  colormap           = [[0 1 0.5 0.03    0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = -50,
        fronttexture       = [[]],
        length             = 450,
		emitrot            = 0,
        emitrotspread      = 0,
        sidetexture        = [[pulseshot]],
	    particlesizespread = 1.2,
        size               = 15.5,
		sizemod            = 1.0,
        sizegrowth         = 0,
        ttl                = 15,
      },
    },
	
       
  },
 
}