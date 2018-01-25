--lowest part of the fire

return {
	["delayedportal"]= {  
	
HolesInTheground = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap = [[
							0 0.1 0.09 0.01	
							0.5 0.25 0 0.01
							0.5 0.25 0  0.01
							0.5 0.25 0 0.01	
							0 0 0 0.01]],
				dir = [[0,-1,0]],
				frontoffset = 10,
				fronttexture = [[]],
				length = 150,
				sidetexture = [[citdronegrad]],
				size = 22,
				sizegrowth = 1,
				ttl = 120,
			},
				alwaysvisible=true,
		},
		
	Closing = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
              colormap           = [[  0.5 0.9 0.9 0.001   0.5 0.9 0.9  0.0125       0.5 0.9 0.9  0.00125          0.5 0.9 0.9  0.00  ]],
            dir                = [[0,-1,0]],
            frontoffset        = 0,
            fronttexture       = [[bluenovaexplo]],
            length             = 0,
            sidetexture        = [[]],--outRay
            size               =50,
            sizegrowth         = 3.993,
            ttl                = 250,
			alwaysvisible=true,
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
              colormap           = [[  0.5 0.9 0.9 0.001   0.25 0.6 0.6 0.225      0.5 0.5 0.5 0.525         0.1 0.3 0.5 0.001  ]],
            dir                = [[0,-1,0]],
            frontoffset        = 0,
            fronttexture       = [[inGateTex]],
            length             = 0,
            sidetexture        = [[]],--outRay
            size               = 45,
            sizegrowth         = 0.0003,
            ttl                = 125,
			alwaysvisible=true,
          },
        },
		cloudring = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 6,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
				colormap = [[0 0 0 1 	0 0 0 0.9 		0 0 0 1 	0 0 0 0.8 	0 0 0 0.01]],
            dir                = [[r0.5r-0.5,-1.0,r0.5r-0.5]],
            frontoffset        = 0,
            fronttexture       = [[comend_nukering]],
            length             = 0,
            sidetexture        = [[]],--outRay
            size               = 100,
            sizegrowth         = 0.15,
            ttl                = 150,
			alwaysvisible=true,
          },
        }
	},
	["portable"] = {

	  
    boom = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              =  85,
        explosiongenerator = [[custom:delayedportal]],
        pos                = [[0,250,0]],
		},
	
	},	
	
		
		
		
	lowPortal = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap = [[
							0.5 0.25 0 0.01	
							0 0.1 0.09 0.01
							0 0.1 0.09 0.01
							0.5 0.25 0 0.01	
							0 0 0 0.01]],
				dir = [[0,1,0]],
				frontoffset = 0.3,
				fronttexture = [[Flake]],
				length = 15,
				sidetexture = [[Flake]],
				size = 3,
				sizegrowth = 50,
				ttl = 120,
			},
		},
		
	explosionsphere1 = {
      air                = true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      ground             = true,
      properties = {
        alpha              = 3.0,
        alwaysvisible      = true,
			pos = [[0 , 65, 0 ]],
        color              = [[0.5, 0.25, 0]],
        expansionspeed     = [[0.8]],
        ttl                = 50,
      },
    },	
	explosionsphere2 = {
      air                = true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      ground             = true,
      properties = {
        alpha              = 3.0,
        alwaysvisible      = true,
			pos = [[0 , 100, 0 ]],
        color              = [[0.5, 0.25, 0]],
        expansionspeed     = [[0.8]],
        ttl                = 60,
      },
    },
	explosionsphere3 = {
      air                = true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      ground             = true,
      properties = {
        alpha              = 3.0,
        alwaysvisible      = true,
				pos = [[0 , 150, 0 ]],
        color              = [[0.5, 0.25, 0]],
        expansionspeed     = [[0.9]],
        ttl                = 70,
      },
    },
	explosionsphere4 = {
      air                = true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      ground             = true,
      properties = {
        alpha              = 3.0,
        alwaysvisible      = true,
				pos = [[0 , 200, 0 ]],
        color              = [[0.5, 0.25, 0]],
        expansionspeed     = [[0.9]],
        ttl                = 85,
      },
    },
		
		
		
		
		
	},
	
	
}