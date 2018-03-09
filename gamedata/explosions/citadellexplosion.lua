return {
	  ["citadellexplosion"] = {
	 explosionsphere = {
       ground             = true,
       air                = true,
		water			=true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      properties = {
        alpha              = 0.4,
        alwaysvisible      = true,
        color              = [[0, 0.4, 1]],
        expansionspeed     = [[8 r2]],
        ttl                = 170,
      },
    },
	 
	 whiteWall = {
       ground             = true,
       air                = true,
		water			=true,
      class              = [[CSpherePartSpawner]],
      count              = 1,
      properties = {
        alpha              = 1.0,
        alwaysvisible      = true,
        color              = [[1, 1, 1]],
        expansionspeed     = [[3 r1]],
        expansionspeed     = [[3 r1]],
        ttl                = 150,
      },
    },
	
	  dirtgw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.5
							0.2 0.14 0.01 1 
							0.3 0.14 0.01 1 
							0.4 0.14 0.01 1 
							0.4 0.14 0.01 0.5
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r-0.6, 0r-1r1]],
        gravity            = [[0, 0.06, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 30,
        particlespeed      = 7,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
      sizegrowth         = 0.3,
	  sizemod            = 1.000001,
        texture            = [[csuborbscrap]],
        useairlos          = false,
      },
    },
    triangw = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.5
							0.2 0.14 0.01 1 
							0.3 0.14 0.01 1 
							0.4 0.14 0.01 1 
							0.4 0.14 0.01 0.5
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r-0.6, 0r-1r1]],
        gravity            = [[0, 0.06, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 5,
        particlespeed      = 7,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
      sizegrowth         = 0.3,
	  sizemod            = 0.990000001,
        texture            = [[triang]],
        useairlos          = false,
      },
    },
   disolvefx = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.5
							0.2 0.14 0.01 1 
							0.3 0.14 0.01 1 
							0.4 0.14 0.01 1 
							0.4 0.14 0.01 0.5
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r-0.6, 0r-1r1]],
        gravity            = [[0, 0.06, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 5,
        particlespeed      = 7,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
      sizegrowth         = 0.3,
	  sizemod            = 0.990000001,
        texture            = [[disolvefx]],
        useairlos          = false,
      },
    },   
	
	debris2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.5
							0.2 0.14 0.01 1 
							0.3 0.14 0.01 1 
							0.4 0.14 0.01 1 
							0.4 0.14 0.01 0.5
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r-0.6, 0r-1r1]],
        gravity            = [[0, 0.06, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 5,
        particlespeed      = 7,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
      sizegrowth         = 1,
	  sizemod            = 0.990000001,
        texture            = [[debris2]],
        useairlos          = false,
      },
    },
	shardfx = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 5,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.5
							0.2 0.14 0.01 1 
							0.3 0.14 0.01 1 
							0.4 0.14 0.01 1 
							0.4 0.14 0.01 0.5
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r-0.6, 0r-1r1]],
        gravity            = [[0, 0.06, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 5,
        particlespeed      = 8,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
      sizegrowth         = 0.3,
		sizemod            = 0.990000001,
        texture            = [[shard]],
        useairlos          = false,
      },
    },
	jshieldgeom = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.5
							0.2 0.14 0.01 1 
							0.3 0.14 0.01 1 
							0.4 0.14 0.01 1 
							0.4 0.14 0.01 0.5
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r0.6r-0.6, 0r-1r1]],
        gravity            = [[0, 0.01, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 5,
        particlespeed      = 7,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
        sizegrowth         = 0.3,
        sizemod            = 0.990000001,
        texture            = [[jshieldgeom7]],
        useairlos          = false,
      },
    },
  jshieldgeomhypcube = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 1,
        alwaysvisible      = true,
        colormap           = [[
						    0.21 0.10 0.01 0	
							0.2 0.14 0.01 0.3
							0.2 0.14 0.01 0.3 
							0.3 0.14 0.01 0.3
							0.4 0.14 0.01 0.3
							0.4 0.14 0.01 0.3
							0.3 0.14 0.01 0.1 
							1 1 1 0.1
							1 1 1 0							
							]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0r-1r1, 0r-0.6, 0r-1r1]],
        gravity            = [[0, 0.06, 0]],
        numparticles       = 1,
        particlelife       = 90,
        particlelifespread = 5,
        particlesize       = [[1]],
        particlesizespread = 5,
        particlespeed      = 7,
        particlespeedspread = 0,
        pos                = [[0,0, 0]],
        sizegrowth         = 0.3,
        sizemod            = 0.990000001,
        texture            = [[jshieldgeomhypcube]],
        useairlos          = false,
      },
    },
  
 
	  

	}
}
