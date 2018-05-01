-- dirt

return {
	["cawilduniverseappearsgalaxys"] = {
		
		gal1 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],	
				directional = false,
				emitrot = 0, 
				emitrotspread = 0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.05r0.05,0.02 r0.03, r-0.05r0.05]],		
				numparticles = 3,
				particlelife = 1200,
				particlelifespread = 400,
				particlesize = 12,
				particlesizespread = 13,
				particlespeed = 12,
				particlespeedspread = 22,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[Galaxy1]],
				useairlos = false,
			},
		},	
		
		gal2 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 3,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],		
				directional = false,
				emitrot = 0, 
				emitrotspread = 0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.05r0.05,0.02 r0.03, r-0.05r0.05]],	

				numparticles = 3,
				particlelife = 1200,
				particlelifespread = 350,
				particlesize = 6,
				particlesizespread = 5,
				particlespeed = 22,
				particlespeedspread = 2,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[Galaxy2]],
				useairlos = false,
			},
		},	
		
		gal3 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 3,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],					directional = false,
				emitrot = 0, 
				emitrotspread = 0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.05r0.05,0.02 r0.03, r-0.05r0.05]],			numparticles = 3,
				particlelife = 1200,
				particlelifespread = 350,
				particlesize = 6,
				particlesizespread = 9,
				particlespeed = 22,
				particlespeedspread = 2,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[Galaxy3]],
				useairlos = false,
			},
		},	
		
		gal5 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 3,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],						directional = false,
				emitrot = 0, 
				emitrotspread = 0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.01r0.01, r0.02, r-0.01r0.01]],
				numparticles = 3,
				particlelife = 1200,
				particlelifespread = 350,
				particlesize = 12,
				particlesizespread = 13,
				particlespeed = 22,
				particlespeedspread = 2,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[Galaxy5]],
				useairlos = false,
			},
		},	
		stars = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 2,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],						directional = false,
				emitrot = 0, 
				emitrotspread =0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.05r0.05,0.02 r0.03, r-0.05r0.05]],			numparticles = 4,
				particlelife = 1200,
				particlelifespread = 350,
				particlesize = 2,
				particlesizespread = 3,
				particlespeed = 22,
				particlespeedspread = 2,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[shotgunflare]],
				useairlos = false,
			},
		},	
		starstwo = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],				directional = false,
				emitrot = 0, 
				emitrotspread = 0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.05r0.05,0.02 r0.03, r-0.05r0.05]],		
				numparticles = 4,
				particlelife = 1200,
				particlelifespread = 350,
				particlesize = 2,
				particlesizespread = 3,
				particlespeed = 5,
				particlespeedspread = 3,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.000000000000000000001,
				texture = [[flash1]],
				useairlos = false,
			},
		},
		gal5 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			properties = {
				airdrag = 0.7,
				alwaysvisible = true,
colormap = [[ 1.0 1.0 1.0 0.002 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004 
				0.85 0.91 0.98 	0.004
				0.85 0.7 0.6 	0.004 
				1.0 0.1 0.0 	0.004 
				0.4 0.0 0.1 	0.003 ]],					
				directional = false,
				emitrot = 0, 
				emitrotspread = 0,
				emitvector = [[r-1r1, r0.5, r-1r1]],
				gravity = [[r-0.05r0.05,0.02 r0.03, r-0.05r0.05]],		
				numparticles = 3,
				particlelife = 900,
				particlelifespread = 900,
				particlesize = 12,
				particlesizespread = 13,
				particlespeed = 22,
				particlespeedspread = 2,
				pos =[[0, 0, 0]],
				sizegrowth = 0.000000000000000001,
				sizemod = 1.0,
				texture = [[fireSparks]],
				useairlos = false,
			},
		},	
		
		
		
	},
}