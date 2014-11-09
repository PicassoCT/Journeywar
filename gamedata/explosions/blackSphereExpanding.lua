-- blood_spray

return {
  ["blacksphereexpanding"] = {
--taylored for the sphere to grow along

	trap = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
       colormap           = [[ 0.3 0.7 0.9 0.003  0.3 0.7 0.9 0.002  0.03 0.7 0.9 0.001  ]],--1 1 1 0.5 0.9 0.9 0.9 0.3  0.5 0.5 0.9 0.3	 0.1 0.1 0.3 0.3  ]], 
 
		directional        = false,
        emitrot            = 90,
        emitrotspread      = 35,
        emitvector         = [[0,0,0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 6000,
        particlelifespread = 0,
        particlesize       = 22,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0.001,
        sizemod            = 1.0409,
        texture            = [[bluedot]],
        useairlos          = false,
      },
    },
	 outside = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
       colormap           = [[   0.003 0.85 0.91 0.98  0.003  0.3 0.7 0.9 0.003  0.3 0.7 0.9 0.002  0.03 0.7 0.9 0.001   ]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 15,
        emitvector         = [[0,0.1,0]],
        gravity            = [[0,0, 0]],
        numparticles       = 0,
        particlelife       = 6000,
        particlelifespread = 0,
        particlesize       = 122,
        particlesizespread = 15,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                =[[0, 0, 0]],
        sizegrowth         = 0.000000000000000001,
        sizemod            = 1.000000000000000000001,
        texture            = [[nuke]],
        useairlos          = false,
      },
    },	

		
	
  },

}
