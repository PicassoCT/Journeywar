-- trail_ar2

return {
  ["machinegunproj"] = {
 
            Flash2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.12 0.9 0.9 0.0025         0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 2,
        particlelife       = 6,
        particlelifespread = 0,
        particlesize       = 0.5,
        particlesizespread = 1,
        particlespeed      = 0.1,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.6 r.35]],
        sizemod            = 1.0,
        texture            = [[pulseshot]],--pulseshot
        useairlos          = false,
      },
    },
 
       
 
       
  },
 
}