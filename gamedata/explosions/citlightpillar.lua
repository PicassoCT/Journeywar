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
									fronttexture       = [[laserendblue]],
									length             = 1500,
									sidetexture        = [[TouchGround]],
									size               = 150,
									sizegrowth         = 0.01,
									ttl                = 15,
								  },
								},
  
	
  

	
	}
  }


