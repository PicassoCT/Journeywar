-- trail_ar2

return {
  ["AR2Impact"] = {
   pop2 = {
      air                = true,
      class              = [[heatcloud]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = true,
        heat               = 10,
        heatfalloff        = 2,
        maxheat            = 15,
        pos                = [[r-3 r3, 5, r-3 r3]],
        size               = 0.2,
        sizegrowth         = 4,
        speed              = [[0, 1, 0]],
        texture            = [[groundflash]],
      },
    },
  
    
  
	
      fakelight = {
      air                = false,
      class              = [[CSimpleGroundFlash]],
      count              = 4,
      ground             = true,
      water              = false,
      properties = {
        colormap           = [[1 1 1 1  0.2 0.6 1 1    0 0 0 0.1]],
        size               = [[8 r-5]],
        sizegrowth         = [[2 r-3]],
        texture            = [[ar2groundflash]],
        ttl                = [[12 r4 r-4]],
      },
    },
  
  
	
	--[[

	    spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]]--,	
	  --[[
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        airdrag            = 1,
        colormap           = [[0.2 0.8 1 0.01  	0 0 0 0.01]]--,	
		--[[
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 40,
        emitvector         = [[0,1,0]]--,	--[[
    --    gravity            = [[0, -0.17, 0]]--, 
    --[[    numparticles       = 5,
        particlelife       = 17,
        particlelifespread = 17,
        particlesize       = 0.5,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 3,
        pos                = [[0, 0, 0]]--,
		--[[
        sizegrowth         = [[0.0 r.35]]--,
        --[[sizemod            = 1.0,
        texture            = [[gunshot]]--,
		--[[
        useairlos          = false,
      },
    },
	   ]]
	
	
  },

}