-- redlight

return {
  ["citlightpillar"] = {
  	  alwaysvisible      = true,
	  usedefaultexplosions = false,

		bitmapmuzzleflamess = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 1,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = {
									colormap           = [[0.5 0.6 0.9 0.005	  0.5 0.6 0.9 0.004	 0.4 0.5 0.9 0.003  0.3 0.4 0.9  0.001	]],
									dir                = [[0, 1,0]],
									frontoffset        = 0,
									fronttexture       = [[]],
									length             = 1500,
									--sidetexture        = [[TouchGround]],
									sidetexture        = [[pulseshot]],
									size               = 100,
									sizegrowth         = 0.01,
									ttl                = 300,
								  },
								}, 
		
	

		glow = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 1,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = {
									colormap           = [[0.5 0.6 0.9 0.005	  0.5 0.6 0.9 0.004	 0.4 0.5 0.9 0.003  0.3 0.4 0.9  0.001	]],
									dir                = [[0, 1,0]],
									frontoffset        = 0,
									fronttexture       = [[laserendblue]],
									length             = 1500,
									sidetexture        = [[]],
									size               = 150,
									sizegrowth         = 0.01,
									ttl                = 300,
								  },
								},
  
		

		

		oldbolt = {
			
			
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = true,
			water = true,
			properties = {
				colormap = [[0.05 0.35 0.95 0.01	0.05 0.35 0.95 0.01 	0.05 0.35 0.95 0.01	0.05 0.35 0.95 0.001		 ]],
				dir = [[0 1 -1]],
				frontoffset = 0,
				fronttexture = [[flash3]],--glow
				length = 25,
				sidetexture = [[megaparticle]],
				size = 9,
				sizegrowth = 7.18,
				ttl = 200,
			}
		} ,
			backbolt = {
			
			
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = true,
			water = true,
			properties = {
				colormap = [[0.05 0.35 0.95 0.01	0.05 0.35 0.95 0.01 	0.05 0.35 0.95 0.01	0.05 0.35 0.95 0.001		 ]],
						dir = [[0 1 -1]],
				frontoffset = 0,
				fronttexture = [[]],
				length = 256,
				sidetexture = [[glow]],
				size = 44,
				sizegrowth = 1.18,
				ttl = 200,
			}
		},
				fakelight = {
			air = false,
			class = [[CSimpleGroundFlash]],
			count = 1,
			ground = true,
			water = false,
			properties = {
				colormap = [[1 0.4 0.7 1 1 0.6 0.12 1 0 0 0 0.1]],
				size = [[8 r-5]],
				sizegrowth = [[2 r-3]],
				texture = [[ar2groundflash]],
				ttl = [[180 r4 r-4]],
			},
		},
		
		
	
  

	
	}
  }


