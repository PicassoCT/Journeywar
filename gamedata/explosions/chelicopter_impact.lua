--lowest part of the fire
return { 
["chelicopterimpact"] = {

    dirt1 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        colormap           = [[1 0.5 0.3 0.3  0.45 0.37 0.3 1  0.45 0.37 0.3 1	 0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 25,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 8,
        particlelifespread = 5,
        particlesize       = 1.5,
        particlesizespread = 3,
        particlespeed      = 0,
        particlespeedspread = 1,
        pos                = [[0, 2, 0]],
        sizegrowth         = 1,
        sizemod            = 1.0,
        texture            = [[dirtplosion2]],
      },
    },
 
  },

}
