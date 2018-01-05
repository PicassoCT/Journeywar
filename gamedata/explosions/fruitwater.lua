-- redlight

return {
  ["fruitwater"] = {
 		alwaysvisible = true,
		
		
		bubbles = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 16,
			ground = true,
			water = true,
			properties = {
				airdrag = 0.8,
				alwaysvisible = true,
				colormap = [[0.9 0.1 0.0 0.04	0.8 0.1 0.0 0.04	0.7 0.05 0 0.04
				0.6 0.1 0.1 0.02	0.2 0.05 0.05 0.03	0.1 0 0.0 0.0]],
				directional = false,
				emitrot = 45,
				emitrotspread = 32,
				emitvector = [[0, 1, 0]],
				gravity = [[0, -0.05r-0.15r0.2, 0]],
				numparticles = 1,
				particlelife = 45,
				particlelifespread = 30,
				particlesize = 5,
				particlesizespread = 15,
				particlespeed = 8,
				particlespeedspread = 3,
				pos = [[0r-15r15, 2, 0r-15r15]],
				sizegrowth = 0,
				sizemod = 1.0,
				texture = [[ActionZone]],
				useairlos = false,
			},
		},
	}

}

