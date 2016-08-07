-- dirt

return {
	["fireDisolveFx"] = {
		fireballs = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			properties = {
				airdrag = 1,
				alwaysvisible = true,
				
				colormap = [[0.25 0.20 0.10 0.2	 	1 0.8 0 0.5		 1 0.8 0 0.12	 0 0 0 0.0]],
				directional = false,
				emitrot = 0,
				emitrotspread = 4,
				emitvector = [[0,0.1,0]],
				gravity = [[0, -0.0000000003, 0]],
				numparticles = 1,
				particlelife = 20,
				particlelifespread = 20,
				particlesize = 0.5,
				particlesizespread = 1.6,
				particlespeed = 3.7,
				
				
				sizegrowth = 1.000005,
				texture = [[firehd]],
				particlespeedspread = 1.1,
				pos = [[r-1 r1, 1, r-1 r1]],
				
				sizemod = 1.0000000003,
				
				
				useairlos = false,
			},
		},
		
		flamez = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			properties = {
				airdrag = 1,
				alwaysvisible = true,
				-- colormap = [[0.25 0.20 0.10 0.02	0.9 0.7 0.1 0.5]],
				colormap = [[0.25 0.20 0.10 0.2 0.9 0.7 0.1 0.5	 0.9 0.7 0.1 0.25	0 0 0 0.0]],
				directional = false,
				emitrot = 0,
				emitrotspread = 8,
				emitvector = [[0,0.2,0]],
				gravity = [[0, -0.0000000003, 0]],
				numparticles = 1,
				particlelife = 40,
				particlelifespread = 15,
				particlesize = 1,
				particlesizespread = 1.1,
				particlespeed = 3.7,
				
				
				sizegrowth = 1.00000125,
				texture = [[fire3]],
				particlespeedspread = 1.1,
				pos = [[r-1 r1, 1, r-1 r1]],
				
				sizemod = 1.0000000003,
				
				
				useairlos = false,
			},
		}, 
		
		dirtgw = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 3,
			ground = true,
			properties = {
				airdrag = 1,
				alwaysvisible = true,
				colormap = [[0.21 0.10 0.01 1.0	0.2 0.14 0.01 0.1]],
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0, 0.1r0.1, 0]],
				gravity = [[0, -0.03, 0]],
				numparticles = 1,
				particlelife = 15,
				particlelifespread = 15,
				particlesize = [[10]],
				particlesizespread = 10,
				particlespeed = 8,
				particlespeedspread = 2,
				pos = [[0, -7 , 0]],
				sizegrowth = 0.99,
				sizemod = 0.9,
				texture = [[csuborbscrap]],
				useairlos = false,
			},
		},
		sparks = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 3,
			ground = true,
			properties = {
				airdrag = 1,
				alwaysvisible = true,
				colormap = [[0.9 0.4 0.0 0.01	0.9 0.2 0.0 0.01	0.0 0.0 0.0 0.01]],
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0, 0.1r0.1, 0]],
				gravity = [[0, -0.03, 0]],
				numparticles = 1,
				particlelife = 40,
				particlelifespread = 15,
				particlesize = [[10]],
				particlesizespread = 10,
				particlespeed = 8,
				particlespeedspread = 2,
				pos = [[0, -7 , 0]],
				sizegrowth = 0.99,
				sizemod = 0.9,
				texture = [[fireSparks]],
				useairlos = false,
			},
		},
		smoke = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 12,
			ground = true,
			water = true,
			properties = {
				airdrag = 0.75,
				alwaysvisible = true,
				colormap = [[0.1 0.2 0.6 0.25	0.3 0.1 0.3 0.22	0.1 0.1 0.3 0.19 0.1 0.1 0.3 0.12]],
				--colormap = [[1 0.4 0.25 1 .02 .02 .02 0.01 .004 .004 .004 0.02		0 0 0 0.01]],
				directional = false,
				
				emitrot = 45,--45
				emitrotspread = 17,--12
				emitvector = [[0r-0.1r0.1, 1r0.3r-0.3, 0r-0.1r0.1]],
				
				gravity = [[0, 0.4r0.15r-0.15 , 0]],
				
				
				
				numparticles = 1,
				particlelife = 65,
				particlelifespread = 102,
				
				particlesize = 1.5,
				particlesizespread = 8,
				
				particlespeed = 0.35,
				particlespeedspread = 0.00004,
				pos = [[0, 26, 0]],
				sizeGrowth	= 0.3,
				sizeMod		= 0.99999977,
				texture = [[smokeSwirls]],
				useairlos = false,
			},
		},
		
		
		
	}
	
}