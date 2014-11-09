-- 330rlexplode

return {
  ["cnukering"] = {
   

 groundflash = {
      circlealpha        = 1,
      circlegrowth       = 4,
      flashalpha         = 0.9,
      flashsize          = 450,
      ttl                = 120,
      color = {
        [1]  = 0.9,
        [2]  = 0.5,--0.1
        [3]  = 0,
      },
    },
    
				
				pop1 = {
				  air                = true,
				  class              = [[heatcloud]],
				  count              = 2,
				  ground             = true,
				  water              = true,
				  properties = {
				  
					alwaysvisible      = true,
					heat               = 10,
					heatfalloff        = 0.1,
					maxheat            = 15,
					pos                = [[r-2 r2, 5, r-2 r2]],
					size               = 3,
					sizegrowth         = 4.1,
					speed              = [[0, 1 0, 0]],
					texture            = [[nuke]],
				  },
				},
				pop2 = {
				  air                = true,
				  class              = [[heatcloud]],
				  count              = 1,
				  ground             = true,
				  water              = true,
				  properties = {
					alwaysvisible      = true,
					heat               = 10,
					heatfalloff        = 1.3,
					maxheat            = 15,
					pos                = [[r-2 r2, 5, r-2 r2]],
					size               = 3,
					sizegrowth         = 25,
					speed              = [[0, 1 0, 0]],
					texture            = [[flare]],
				  },
				},
	
	},

}

