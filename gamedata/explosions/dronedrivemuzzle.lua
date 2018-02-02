-- 100rlexplode

return {
  ["dronedrivemuzzle"] = {
   
    groundflash = {
      air                = true,
      alwaysvisible      = true,
      circlealpha        = 0,
      circlegrowth       = 8,
      flashalpha         = 0.6,
      flashsize          = 50,
      ground             = true,
      ttl                = 5,
      water              = true,
      color = {
        [1]  = 0,
        [2]  = 0.5,
        [3]  = 1,
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
									colormap           = [[ 0 0.55 0.9 0.005	 
															0 0.55 0.9 0.004	
															0.1 0.3 0.55 0.005 
															0.1 0.3 0.55 0.001	]],
									dir                = [[0,-1,0]],
									frontoffset        = 0,
									fronttexture       = [[bluenovaexplo]],
									length             = 15,
									sidetexture        = [[beamrifle]],
									size               = 5.,
									sizegrowth         = 0.3,
									ttl                = 1,
								  },
								        useairlos          = true,
								},
							   
	
  },

}

