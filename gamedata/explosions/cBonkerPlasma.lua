-- trail_ar2

return {
  ["cbonkerplasma"] = {
  
  fakelightx = {
      air                = false,
      class              = [[CSimpleGroundFlash]],
      count              = 0,
      ground             = true,
      water              = false,
      properties = {
        colormap           = [[1 0.4 0.7 1  1 0.6 0.12 1    0 0 0 0.1]],
        size               = [[8 r-5]],
        sizegrowth         = [[2 r-3]],
        texture            = [[ar2groundflash]],
        ttl                = [[9 r4 r-4]],
      },
    },
  
	  Flashsfx = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
          colormap           = [[1 1 1 1   1 1 1 1]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 6,
        particlelifespread = 0,
        particlesize       = 0.5,
        particlesizespread = 1,
        particlespeed      = 0.05,
        particlespeedspread = 0.05,
        pos                = [[0, 0, 0]],
        sizegrowth         = [[0.22s0.22]],
        sizemod            = 1.0,
        texture            = [[plasma]],
        useairlos          = false,
      },
    },
 
  


               
    
      
 
       
 
       
  },
 
}