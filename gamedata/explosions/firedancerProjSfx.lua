-- dirt

return {
  ["firedancerprojsfx"] = {
     

  
  sparkredX2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[1 0.5 0.25 .01   1 0.3 0.05 .01		0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[dir]],
        gravity            = [[0, -0.07, 0]],
        numparticles       = 3,
        particlelife       = 19,
        particlelifespread = 11,
        particlesize       = 0.5,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.0 r.35]],
        sizemod            = 1.2,
        texture            = [[gunshot]],
        useairlos          = false,
      },
    },
  
  
  },

}