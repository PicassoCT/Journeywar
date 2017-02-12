-- artillery_explosion
-- factory_explosion

return {
	["ccatapultexpl"] = {
		boom = {
			class = [[CSimpleGroundFlash]],
			air = true,
			alwaysvisible = true,
			circlealpha = 0.1,
			circlegrowth = 6,
			flashalpha = 0.1,
			flashsize = 128,
			ground = true,
			ttl = 15,
			water = true,
			color = {
				[1] = 0.19,--1,
				[2] = 0.8,--0.20000000298023,
				[3] = 1.0,--0.10000000149012,
			},
		},
		
		poof01 = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 0.95,
				alwaysvisible = true,
				colormap = [[0.1 0.1 0.2 0.9	0.0 0.9 1.0 1.0		0.0 0.15 1.0 1.0	
				0.05 0.1 0.4 0.9	0.0 0.15 0.1 0.9		0.0 0.15 0.1 0.8
				0 0 0 0.0]],
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0, 0.15, 0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 50,
				particlelifespread = 10,
				particlesize = 8,
				particlesizespread = 5,
				particlespeed = 1,
				particlespeedspread = 10,
				pos = [[r-1 r1, 5, r-1 r1]],
				sizegrowth = 1.2,
				sizemod = 1.0,
				texture = [[dirt]],
				useairlos = true,
			},
		},
		
		pop1 = {
			air = true,
			class = [[heatcloud]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				alwaysvisible = true,
				
				heat = 10,
				heatfalloff = 0.8,
				maxheat = 15,
				pos = [[r-2 r2, 5, r-2 r2]],
				size = 5,
				sizegrowth = 15,
				speed = [[0, 1 0, 0]],
				texture = [[novabg]],
			},
		},
		
		pop2 = {
			air = true,
			class = [[heatcloud]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				alwaysvisible = true,
				heat = 1,
				heatfalloff = 0.8,
				maxheat = 5,
				pos = [[r-2 r2, 5, r-2 r2]],
				size = 5,
				sizegrowth = 28,
				speed = [[0, 1 0, 0]],
				texture = [[flare]],
			},
		},
		
	},
	
}