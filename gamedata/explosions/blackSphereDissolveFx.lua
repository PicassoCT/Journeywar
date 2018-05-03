-- Internal Quality Assurance was here.. found code messy

return {
	["blackspheredissolvefx"] = {
		
		
		mingw = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 12,
			ground = true,
			properties = {
				airdrag = 1,
				alwaysvisible = true,
				colormap = [[
				0.85 0.91 0.98 0.01	
				1 0.25 0.8 0.01
				1 0.25 0.8 0.001]],
				directional = true,
				emitrot = 5,
				emitrotspread = 5,
				emitvector = [[0r0.01r-0.01, -0.1,0r0.01r-0.01]],
				gravity = [[r0.02r-0.02, 0.025,r0.02r-0.02]],
				numparticles = 1,
				particlelife = 42,
				particlelifespread = 50,
				particlesize = [[2]],
				particlesizespread = 9,
				particlespeed = 0.5,
				particlespeedspread = 0.75,
				pos = [[r5, -7 ,r5]],
				sizegrowth = 0.0000001,
				sizemod = 1.00000001,
				texture = [[portalstorm]],
				useairlos = false,
			},
		},
		
		lightening= {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 3,
			ground = true,
			water = true,
			properties = {
				airdrag = 0.8,
				alwaysvisible = true,
				colormap = [[
				0 0 0 0
				0.85 0.91 0.98 	0.04
				0 0 0 0
				0.85 0.91 0.98	0.04
				0 0 0 0
				0 0 0 0
				0 0 0 0
				0 0 0 0
				0 0 0 0
				]],
				directional = true,
				emitrot = 45,
				emitrotspread = 32,
				emitvector = [[0r1r-1, 1, 0r1r-1]],
				gravity = [[0, 0.005, 0]],
				numparticles = 1,
				particlelife = 1,
				particlelifespread = 90,
				particlesize = 10,
				particlesizespread = 0,
				particlespeed = 4,
				particlespeedspread = 1,
				pos = [[0, 2, 0]],
				sizegrowth = 0.8,
				sizemod = 0.9999,
				texture = [[vortw]],
				useairlos = false,
			},
		},
		
		
		
		
		
		
	},
	
}