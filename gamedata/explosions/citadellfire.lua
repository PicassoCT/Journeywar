 cloudRandDir=[[r0.35r-0.35,0.25r0.5,r0.35r-0.35]]
 
 blackSmokePropertys ={
					   	colormap           = [[			
										0 0 0 0.0					
										0 0 0 0.0					
										0 0 0 0.0	
										0 0 0 0

										1 1 1 	0.8							
										1 1 1 	0.8							
										1 1 1 	0.8							
										1 1 1 	0.8							
										0 0 0 0
																	
										]],				
									dir         = cloudRandDir,	
									frontoffset        = 0,
									fronttexture       = [[SmokeGlowinWeaker]],
									length             = 0,
									sidetexture        = [[]],
									size               = 42,
									sizegrowth         = 0.998,
									ttl                = 150,
								  }
								
corefireproperties={
								
									colormap           = [[
										0 0 0 0.0
										1 0.5 0.2 	0.04
										0.9 0.2 0.1 0.04
										1 0.3 0.2 	0.04
										1 0.5 0.2 	0.04
										0.9 0.2 0.1 0.04
										0.6 0.2 0.1 0.04	
										0 0 0 0.0]],			
									dir         =   cloudRandDir,
									frontoffset        = 0,
									fronttexture       = [[firenovaexplo]],
									length             = 0,
									sidetexture        = [[]],
									size               = 50,
									sizegrowth         = 0,
									ttl                = 50,
								  }
firecloudproperties= {
					   	colormap           = [[			
										0 0 0 		0
										0.9 0.2 0.1 0.8
										1 0.5 0.2 	0.7					
										1 0.5 0.2 	0.7
										0.9 0.2 0.1 0.8
										1 0.5 0.2 	0.7
										0.9 0.2 0.1 0.8
										1 0.3 0.2 	0.7
										1 0.5 0.2 	0.6
										0.9 0.2 0.1 0.8
										0.8 0.2 0.1 0.6									
										1 0.3 0.1 0.5
										0 0 0 0
										0 0 0 0
										0 0 0 0
										0 0 0 0
										]],				
									dir       = cloudRandDir,
									frontoffset        = 0,
									fronttexture       = [[SmokeAshCloud]],
									length             = 0,
									sidetexture        = [[]],
									size               = 50,
									sizegrowth         = 0.99999999999999999999,
									ttl                = 100,
								  }

cegtable={
  ["citadellfire"] = {
	  
				corefire = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 6,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = corefireproperties,
								},
				
								
				darkcloud = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 6,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = firecloudproperties,
								},	
			
								
								
			blacksmoke = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 6,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = blackSmokePropertys,
								},	
			



	explosions = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
      colormap           = [[
	  0 0 0 0
	   1 0.5 0.2 	0.04
	  0 0 0 0
	 1 0.5 0.2 	0.04
	  0 0 0 0
	  0 0 0 0
	  0 0 0 0
	  0 0 0 0
	  0 0 0 0
	  ]],
        directional        = false,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[0r1r-1, 1, 0r1r-1]],
        gravity            = [[0, 0.005, 0]],
        numparticles       = 1,
        particlelife       = 1,
        particlelifespread = 90,
        particlesize       = 10,
        particlesizespread = 0,
        particlespeed      = 4,
        particlespeedspread = 1,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0.8,
        sizemod            = 0.9999,
        texture            = [[jsunshipcorona]],
        useairlos          = false,
      },
    },
	spark = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
      colormap           = [[
	 	  0 0 0 0
	   1 0.5 0.2 	0.04
	  0 0 0 0
	 1 0.5 0.2 	0.04
	  0 0 0 0
	  0 0 0 0
	  0 0 0 0
	  0 0 0 0
	  0 0 0 0
	  ]],
        directional        = false,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[0r1r-1, 1, 0r1r-1]],
        gravity            = [[0, 0.005, 0]],
        numparticles       = 1,
        particlelife       = 1,
        particlelifespread = 90,
        particlesize       = 10,
        particlesizespread = 0,
        particlespeed      = 4,
        particlespeedspread = 1,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0.8,
        sizemod            = 0.9999,
        texture            = [[vortw]],
        useairlos          = false,
      },
    },
	
	DriftCloud = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 3,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        alwaysvisible      = true,
      colormap           = [[
	  0 0 0 0
	  0 0 0 0
	  0.9 0.2 0.1 0.3
	  0.9 0.2 0.1 0.7
	  0.9 0.2 0.1 0.9
	  0.9 0.2 0.1 0.3
	  ]],
        directional        = false,
        emitrot            = 45,
        emitrotspread      = 32,
        emitvector         = [[dir]],
        gravity            = [[0, 0.005, 0]],
        numparticles       = 1,
        particlelife       = 300,
        particlelifespread = 75,
        particlesize       = 4,
        particlesizespread = 15,
        particlespeed      = 1,
        particlespeedspread = 2,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0.42,
        sizemod            = 0.9999,
        texture            = [[smokeSmall]],
        useairlos          = false,
      },
    },


	  
	  
	  
	  

	}
}

return cegtable