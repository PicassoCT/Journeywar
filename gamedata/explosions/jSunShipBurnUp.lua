--lowest part of the fire

return {
	["jsunshipburnup"] = {
		
		
		

		
	
		
		sparkredX = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 8,
			ground = true,
			water = false,
			properties = {
				airdrag = 1,
				colormap = [[1 0.5 0.25 .005	 1 0.3 0.05 .005		 1 0.1 0.1 .005	 0 0 0 0]],
				directional = true,
				emitrot = 0,
				emitrotspread = 10,
				emitvector = [[dir]],
				gravity = [[0r0.001r-0.001, -0.001, 0r0.001r-0.001]],
				numparticles = 2,
				particlelife = 39,
				particlelifespread = 25,
				particlesize = 9.5,
				particlesizespread = 9,
				particlespeed = 1,
				particlespeedspread = 2.5,
				pos = [[0, 0, 0]],
				sizegrowth = [[0.0 r.35]],
				sizemod = 1.0,
				texture = [[gunshot]],
				useairlos = false,
			},
		},
		
		
			
	
		
		burnscrap = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 6,
			ground = true,
			water = false,
			properties = {
				airdrag = 1,
				colormap = [[1 1 1 1
							1 0.75 0.55 .5	 
							1 0.65 0.35 .15	 
							1 0.5 0.25 .005	 
							1 0.3 0.05 .005		
							1 0.1 0.1 .005	
							0 0 0 0]],
				directional = true,
				emitrot = 0,
				emitrotspread = 10,
				emitvector = [[dir]],
				gravity = [[0, -0.001, 0]],
				numparticles = 2,
				particlelife = 26,
				particlelifespread = 25,
				particlesize = 7.5,
				particlesizespread = 7,
				particlespeed = 2,
				particlespeedspread = 3,
				pos = [[0, 0, 0]],
				sizegrowth         = [[0.0 0.0000000000001]],
				sizemod = 1.0,
				texture = [[csuborbscrap]],
				useairlos = false,
			},
		},
		
			fireswoard = {
								  air                = true,
								  class              = [[CBitmapMuzzleFlame]],
								  count              = 1,
								  ground             = true,
								  underwater         = 1,
								  water              = true,
								  properties = {
									colormap = [[1 0.5 0.25 .005	 1 0.3 0.05 .005		 1 0.1 0.1 .005	 0 0 0 0]],
									dir                = [[dir]],
									frontoffset        = 0.025,

									fronttexture       = [[bigexplo]],
									length             = 25,
									sidetexture        = [[burstside]],
									size               = 5,
									sizegrowth         = 9.01,
									ttl                = 80,
								  },
								},
				
	},
	
}