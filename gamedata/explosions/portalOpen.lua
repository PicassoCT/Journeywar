--lowest part of the fire

return {
	["portable"] = {
		
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
				length = 150,
				sidetexture = [[Flake]],
				size = 30,
				sizegrowth = 1,
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