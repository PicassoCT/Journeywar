return {
	["jeliahbirth"] = {
			rainbow = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 12,
			ground = true,
			properties = {
				airdrag = 0.8,
				alwaysvisible = true,
				colormap = [[
				0.1 0.8 0.9 0.01
				0.9 0.1 0.1 0.05
				0.7 0.5 0.1 0.05
				0.1 0.8 0.9 0.05
				0.1 0.1 0.1 0.001]],
				directional = true,
				emitrot = 1,
				emitrotspread = 1,
				emitvector = [[r0.5r-1,r0.3,r0.5r-1]],
				gravity = [[r0.15r-0.15, r0.01r-0.005, r0.15r-0.15]],
				numparticles = 1,
				particlelife = 50,
				particlelifespread = 150,
				particlesize = 6,
				particlesizespread = 12,
				particlespeed = 10,
				particlespeedspread = 5,
				pos = [[0, 2, 0]],
				sizegrowth = [[0.0 0.0000000000000000001]],
				sizemod = 0.99999999,
				texture = [[jeliahbutterfly]],
				useairlos = false,
			},
		},
		firstWave = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
			
				colormap = [[
				0.1 0.8 0.9 0.01
				0.9 0.1 0.1 0.05
				0.7 0.5 0.1 0.05
				0.1 0.8 0.9 0.05
				0.1 0.1 0.1 0.001]],
				dir = [[r1r-1,r1,r1r-1]],
				frontoffset = 2,
				fronttexture = [[jeliahbutterfly]],
				length = 50,
				sidetexture = [[]],
				size = 25,
				sizegrowth = -0.75,
				ttl = 100,
			},
			alwaysvisible = true,
			useairlos = true,
		},		
		firstWave2 = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
			
				colormap = [[
				0.1 0.8 0.9 0.01
				0.9 0.1 0.1 0.05
				0.7 0.5 0.1 0.05
				0.1 0.8 0.9 0.05
				0.1 0.1 0.1 0.001]],
				dir = [[r1r-1,r1,r1r-1]],
				frontoffset = 6,
				fronttexture = [[jeliahbutterfly]],
				length = 50,
				sidetexture = [[]],
				size = 35,
				sizegrowth = -0.95,
				ttl = 100,
			},
			alwaysvisible = true,
			useairlos = true,
		},	

		secWave = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 12,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
			
						colormap = [[
				0.9 0.1 0.1 0.01
				0.1 0.1 0.9 0.05
				0.5 0.3 0.5 0.05
				0.9 0.1 0.1 0.05
				0.1 0.1 0.1 0.001]],
				dir = [[r1r-1,r0.5,r1r-1]],
				frontoffset = 2.5,
				fronttexture = [[jeliahbutterfly]],
				length = 50,
				sidetexture = [[]],
				size = 32,
				sizegrowth = -0.75,
				ttl = 120,
			},
			alwaysvisible = true,
			useairlos = true,
		},	
		secWave2 = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 12,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
			
						colormap = [[
				0.9 0.1 0.1 0.01
				0.1 0.1 0.9 0.05
				0.5 0.3 0.5 0.05
				0.9 0.1 0.1 0.05
				0.1 0.1 0.1 0.001]],
				dir = [[r1r-1,r0.5,r1r-1]],
				frontoffset = 3.5,
				fronttexture = [[jeliahbutterfly]],
				length = 50,
				sidetexture = [[]],
				size = 42,
				sizegrowth = -0.95,
				ttl = 120,
			},
			alwaysvisible = true,
			useairlos = true,
		},
		
		thirdWave = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
			
						colormap = [[
				0.9 0.1 0.1 0.01
				0.1 0.6 0.9 0.05
				0.7 0.5 0.1 0.05
				0.9 0.1 0.1 0.05
				0.1 0.1 0.1 0.001]],
				dir = [[r1r-1,r0.5,r1r-1]],
				frontoffset = 3.14,
				fronttexture = [[jeliahbutterfly]],
				length = 50,
				sidetexture = [[]],
				size = 40,
				sizegrowth = -0.80,
				ttl = 130,
			},
			alwaysvisible = true,
			useairlos = true,
		},
		
		thirdWave = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
			
						colormap = [[
				0.9 0.1 0.1 0.01
				0.1 0.6 0.9 0.05
				0.7 0.5 0.1 0.05
				0.9 0.1 0.1 0.05
				0.1 0.1 0.1 0.001]],
				dir = [[r1r-1,r0.5,r1r-1]],
				frontoffset = 4.14,
				fronttexture = [[jeliahbutterfly]],
				length = 50,
				sidetexture = [[]],
				size = 40,
				sizegrowth = -0.90,
				ttl = 130,
			},
			alwaysvisible = true,
			useairlos = true,
		},
		
		
		
		
	}		
}