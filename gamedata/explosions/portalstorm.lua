return {
["portalstorm"] = {  
	glowing = {
      air                = true,
      class              = [[explspike]],
      count              = 5,
      ground             = true,
      water              = true,
 properties = {
		alpha              = 1,
        alphadecay         = 0.19,
        alwaysvisible      = true,
        color              = [[0.0, 0.3, 1]],
        dir                = [[-45 r90,-45 r90,-45 r90]],
	  
	  
    
        length             = 2,--2,
        width              = 22,--22,
      },
   },
   
      
    pop1 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 10,
        heatfalloff        = 10,
        maxheat            = 10,
        pos                = [[r-2 r2, 5, r-2 r2]],
        size               = 0.1,
        sizegrowth         = 1.00015,
		
        sizemod            = 1.01,
		
        speed              = [[0, 3, 0]],
        texture            = [[portalbackground]],
      },
     },
   
   
	explosionsphere = {
      air                = true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      ground             = true,
      properties = {
        alpha              = 0.4,
        alwaysvisible      = true,
        color              = [[0.0, 0.3, 1]],
        expansionspeed     = [[10 r3]],
        ttl                = 2,
      },
	},



	
  }
}