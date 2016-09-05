--lowest part of the fire

return {
	["holeinthesky"] = {
		


HoleInTheSky = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap = [[
							0.5 0.25 0 0.01	
							0 0.1 0.09 0.01
							0 0.1 0.09 0.01
							0.5 0.25 0 0.01	
							0 0 0 0.01]],
				dir = [[0,-1,0]],
				frontoffset = 10,
				fronttexture = [[]],
				length = 150,
				sidetexture = [[citdronegrad]],
				size = 22,
				sizegrowth = 1,
				ttl = 120,
			},
		},
		
		
		
		
		upPortal = {
			
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
				gravity = [[0, -0.1, 0]],
				emitvector = [[0, -0.1 , 0]],
				
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

	dubPortal = {
			
			class = [[CSimpleParticleSystem]],
			count = 1,
			air = true,
			ground = true,
			water = true,
			properties = {
				
				alwaysvisible = true,
				colormap = [[1 1 1 0.01	0.5 0.25 0 0.01	 0 0.1 0.09 0.01 0 0.1 0.09 0.01	 0 0 0 0.01]],
				texture=[[4explo]],
				
				pos = [[0 , 0, 0 ]],
				gravity = [[0, -0.1, 0]],
				emitvector = [[0, -0.1 , 0]],
				
				sizeGrowth	= 0.003,
				sizeMod		= 1.01,
				
				
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
		
		
	},
	
}		