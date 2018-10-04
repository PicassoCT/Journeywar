-- dirt

return {
	["orgbigbang"] = {
		bigbang = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			properties = {
				airdrag = 0.8,
				alwaysvisible = true,
				colormap = [[1 1 1 0.01	
				1 1 1 0.03	
				1 1 1 0.01
				1 1 1 0]],
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0, 0, 0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 50,
				particlelifespread = 0,
				particlesize = 1,
				particlesizespread = 0,
				particlespeed = 0,
				particlespeedspread = 0,
				pos = [[0, 2, 0]],
				sizegrowth = 1,
				sizemod = 1.00000000001,
				texture = [[Flake]],
				useairlos = false,
			},
		},
		star1 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 10,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
				colormap = [[ 
				0.8 1.0 1.0 0.005 
				0.4 0.2 1.0 0
				0.4 0.2 1.0 0.005 
				0.85 0.9 1.0 0.003
				0.85 0.9 1.0 0.005 
				0.9 0.8 1.0 0
				0.9 0.8 1.0 0.005 
				1 0.75 0.1 0.003
				1 0.75 0.1 0.005 
				1 0.4 0 0.005 
				1 0.1 0 0.005 
				]],
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[r0.5r-0.5,0.3r0.6,r0.5r-0.]],
				gravity = [[r0.03r-0.03,0.01, r0.03r-0.03]],
				numparticles = 1,
				particlelife = 7*30,
				particlelifespread = 12*30,
				particlesize = 0.6,
				particlesizespread = 2,
				particlespeed = 0,
				particlespeedspread = 0,
				pos = [[r-5r5, r5, r-5r5]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[greynovaexplo]],
				useairlos = false,
			},
		}, 
		
		suns = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 10,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
				colormap = [[ 
				0.8 1.0 1.0 0.005 
				0.4 0.2 1.0 0.003
				0.4 0.2 1.0 0.005 
				0.85 0.9 1.0 0 
				0.85 0.9 1.0 0.005 
				0.9 0.8 1.0 0
				0.9 0.8 1.0 0.005 
				1 0.75 0.1 0.003
				1 0.75 0.1 0.005 
				1 0.4 0 0.005 
				1 0.1 0 0.005 
				]],
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[r0.5r-0.5,0.3r0.6,r0.5r-0.]],
				gravity = [[r0.03r-0.03,0.01, r0.03r-0.03]],
				numparticles = 1,
				particlelife = 7*30,
				particlelifespread = 12*30,
				particlesize = 0.6,
				particlesizespread = 2,
				particlespeed = 0,
				particlespeedspread = 0,
				pos = [[r-5r5, r5, r-5r5]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[laserendorange]],
				useairlos = false,
			},
		},
		
		accreation = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 10,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
				colormap = [[ 
				0.8 1.0 1.0 0.005 
				0.4 0.2 1.0 0.003
				0.4 0.2 1.0 0.005 
				0.85 0.9 1.0 0 
				0.85 0.9 1.0 0.005 
				0.9 0.8 1.0 0.003
				0.9 0.8 1.0 0.005 
				1 0.75 0.1 0
				1 0.75 0.1 0.005 
				1 0.4 0 0.005 
				1 0.1 0 0.005 
				]],
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[r0.5r-0.5,0.3r0.6,r0.5r-0.]],
				gravity = [[r0.03r-0.03,0.01, r0.03r-0.03]],
				numparticles = 1,
				particlelife = 7*30,
				particlelifespread = 12*30,
				particlesize = 0.6,
				particlesizespread = 2,
				particlespeed = 0,
				particlespeedspread = 0,
				pos = [[r-5r5, r5, r-5r5]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[lensflareCenter]],
				useairlos = false,
			},
		},
		
		starsparks = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 11,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
				colormap = [[ 
				0.8 1.0 1.0 0.005 
				0.4 0.2 1.0 0.005 
				0.85 0.9 1.0 0.005 
				0.9 0.8 1.0 0.005 
				1 0.75 0.1 0.005 
				1 0.4 0 0.005 
				1 0.1 0 0.005 
				1 0.1 0 0.004 
				1 0.1 0 0.003 
				1 0.1 0 0.002 
				]],
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[r0.5r-0.5,0.3r0.6,r0.5r-0.]],
				gravity = [[r0.03r-0.03,0.01, r0.03r-0.03]],
				numparticles = 1,
				particlelife = 10*30,
				particlelifespread = 17*30,
				particlesize = 0.6,
				particlesizespread = 2,
				particlespeed = 0,
				particlespeedspread = 0,
				pos = [[r-5r5, r5, r-5r5]],
				sizegrowth = 0.00000000000000001,
				sizemod = 1.005,
				texture = [[fireSparks]],
				useairlos = false,
			},
		},
		
		clouds = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 22,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
				-- colormap = [[ 
				-- 0.4 0.2 1.0 		1 
				-- 0.7 0.5 1.0			1 
				-- 0.9 0.8 1.0 		1 
				-- 1 0.65 0.1 			1 
				-- 1 0.4 0 			1 
				-- 1 0.1 0 			1 
				-- 1 0.1 0				1 
				-- 1 0.1 0 			1 
				-- 0.5 0.5 1 			1
				-- ]],
				colormap = [[ 
				0 0 0 		0 
				0 0 0 		0 
				0.4 0.2 1.0 		1 
				 0.7 0.5 1.0			1 
				 0.9 0.8 1.0 		1 
				0.5 0.35 0.05		1 
				0.5 0.2 0 			1 
				0.5 0.05 0			1 
				0.5 0.35 0.1		1 
				0.5 0.4 0.2 		1 
				0.5 0.5 0.5			1
				]],
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[r0.5r-0.5,0.3r0.6,r0.5r-0.]],
				gravity = [[r0.04r-0.04,0.01, r0.04r-0.04]],
				numparticles = 1,
				particlelife = 17*30
				,
				particlelifespread = 9*30,
				particlesize = 0.6,
				particlesizespread = 2,
				particlespeed = 0,
				particlespeedspread = 0,
				pos = [[r-15r15, r5, r-15r15]],
				sizegrowth = 0.00000000000000001,
				sizemod = 1.004,
				texture = [[new_dirtb]],
				useairlos = false,
			},
		},
		
	},
	
}