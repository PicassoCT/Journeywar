--lowest part of the fire

return {
	["supersonic"] = {
		

				
front = {
			
			class = [[CSimpleParticleSystem]],
			count = 1,
			air = true,
			ground = true,
			water = true,
			properties = {
				
				alwaysvisible = true,
				colormap = [[0 0 0 1 	0 0 0 0.9 		0 0 0 1 	0 0 0 0.8 	0 0 0 0.01]],
				texture=[[BlackOrb]],
				
				pos = [[0 , 0, 0 ]],
				gravity = [[0, 1, 0]],
				emitvector = [[dir]],
				
				sizeGrowth	= 0.001,
				sizeMod		= 1.0,
				
				
				airdrag			= 0.55,
				particleLife		=125,
				particleLifeSpread	= 6,
				numParticles		= 1,
				particleSpeed		= 12.9,
				particleSpeedSpread	= 22.12,
				particleSize		= 50.008,
				particleSizeSpread	= 0,
			},
		},

	
cone = {
			
			class = [[CSimpleParticleSystem]],
			count = 1,
			air = true,
			ground = true,
			water = true,
			properties = {
				
				alwaysvisible = true,
				colormap = [[0 0 0 1 	0 0 0 0.9 		0 0 0 1 	0 0 0 0.8 	0 0 0 0.01]],
				texture=[[BlackOrb]],
				
				pos = [[0 , 0, 0 ]],
				gravity = [[0, 1, 0]],
				emitvector = [[dir]],
				
				sizeGrowth	= 0.001,
				sizeMod		= 1.0,
				
				
				airdrag			= 0.55,
				particleLife		=125,
				particleLifeSpread	= 6,
				numParticles		= 1,
				particleSpeed		= 12.9,
				particleSpeedSpread	= 22.12,
				particleSize		= 50.008,
				particleSizeSpread	= 0,
			},
		},

		
}		