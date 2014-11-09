-- redlight

return {
  ["jshshrikptreet"] = {
  	  alwaysvisible      = false,
	  losvisible=true,
	  usedefaultexplosions = false,

	

		bitmapmuzzleflamess = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 1,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = {
									colormap           = [[0.7 1 0.0 0.005	  0.7 1 0.0 0.004	0.7 1 0.0 0.003  0.7 1 0.0  0.001	]],
									dir                = [[0, 1,0]],
									pos				   = [[0, 0,15]],
								
									frontoffset        = 0,
									fronttexture       = [[laserendgreen]],
									length             = 16,
									sidetexture        = [[ptree2]],
									size               = 16,
									sizegrowth         = 0.01,
									ttl                = 45,
								  },
								},
  
		
  

	
	}
  }


