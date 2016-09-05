return {
	["miniverrsetail"] = {	
		pop1 = {
			air = true,
			class = [[heatcloud]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				alwaysvisible = true,
				heat = 10,
				heatfalloff = 1,
				maxheat = 10,
				pos = [[0, 0, 0]],
				size = 0.2,
				sizegrowth = 8,
				speed = [[0, 0, 0]],
				texture = [[firenovaexplo]],
			},
		},
		
		
		
		tail = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,

			properties = {
				
				colormap = [[0.5 0.6 0.9 0.006125	 0.67 0.45 0.9 0.00306125	 0.67 0.45 0.9 0.002 	0.67 0.45 0.9 0.000	]],
				dir = [[dir]],
			frontoffset = 0,
				fronttexture = [[Accreationdisk]],
				length = 150,
				--sidetexture = [[TouchGround]],
				sidetexture = [[citdronegrad]],
				size = 20,
				
				sizegrowth = 0.01,
				ttl = 60,
			},
		},
		suckin = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 2,
			ground = true,
			water = false,
			properties = {
				airdrag = 1,
				
				colormap = [[0.5 0.6 0.9 0.01 0.67 0.45 0.9 0.01		0 0 0 0.01]],
				directional = true,
				emitrot = 22,
				emitrotspread = 5,
				emitvector = [[0, 1, 0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 80,
				particlelifespread = 40,
				particlesize = 44.2,
				particlesizespread = 4,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = 0,
				sizemod = 0.8999,
				texture = [[expandingstrobe]],
				useairlos = false,
			},
		},		
	},
	
}