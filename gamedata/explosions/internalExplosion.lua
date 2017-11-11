-- missile_explosion

return {
  ["internalexplosion"] = {
    dirt = {
      count              = 4,
      ground             = true,
      properties = {
        alphafalloff       = 2,
        alwaysvisible      = true,
        color              = [[0.05, 0.1, 0.2]],
        pos                = [[r-10 r10, 0, r-10 r10]],
        size               = 20,
        speed              = [[r1.5 r-1.5, 2, r1.5 r-1.5]],
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
        color              = [[1, 0.6, 0]],
        expansionspeed     = [[10 r3]],
        ttl                = 11,
      },
    },
    explosionspikes = {
      air                = true,
      class              = [[explspike]],
      count              = 5,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 1,
        alphadecay         = 0.19,
        alwaysvisible      = true,
        color              = [[1, 0.6, 0]],
        dir                = [[-45 r90,-45 r90,-45 r90]],
        length             = 0.4,
        width              = 4,
      },
    }
   
  }

}

