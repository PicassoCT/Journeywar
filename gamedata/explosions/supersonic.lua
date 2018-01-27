--lowest part of the fire

return {
	["supersonic"] = {
		
	alwaysvisible = true,
				
front = {
			
			class = [[CSimpleParticleSystem]],
			count = 5,
			air = true,
			ground = true,
			water = true,
			properties = {
				      emitrot            = 15,
					emitrotspread      = 12,
				alwaysvisible = true,
				colormap = [[
				0.9 0.9 0.9 0
				0.9 0.9 0.9 1

				0 0 0 0.0]],
				
				texture=[[new_dirta]],
				
				pos = [[1r-1 , 0, 1r-1 ]],
				gravity = [[0, 0, 0]],
				
				emitvector = [[dir]],
				

				
				
				airdrag			= 0.55,
				particleLife		=70,
				particleLifeSpread	= 70,
				numParticles		= 1,
				particleSpeed		= 0,
				particleSpeedSpread	= 0,
				particleSize		= 0.125,
				particleSizeSpread	= 2,
				 sizegrowth         = 1,
				sizemod            = 1.0,
			},
		},

					
shockwae = {
			
			class = [[CSimpleParticleSystem]],
			count = 3,
			air = true,
			ground = true,
			water = true,
			properties = {
				      emitrot            = 15,
					emitrotspread      = 12,
				alwaysvisible = true,
						colormap = [[	0.9 0.9 0.9 	0.02
										0.8 0.8 0.8 	0.03	
										0.2 0.2 0.2		0.03						
										0.2 0.2 0.2		0.03	
										0.2 0.2 0.2 	0.02	
										0.1 0 0.0 		0.0]],
				
				texture=[[ActionZone]],
				
				pos = [[1r-1 , 0, 1r-1 ]],
				gravity = [[0, 0, 0]],

				emitvector = [[dir]],
				

				
				
				airdrag			= 0.55,
				particleLife		= 80,
				particleLifeSpread	= 10,
				numParticles		= 1,
				particleSpeed		= 0,
				particleSpeedSpread	= 0,
				particleSize		= 0.000000125,
				particleSizeSpread	= 3,
				 sizegrowth         = 0.95,
				sizemod            = 1.0000000000000001,
			},
		},

	
cone =  {
		air                = true,
		class              = [[CBitmapMuzzleFlame]],
		count              = 1,
		ground             = true,
		underwater         = 1,
		water              = true,
		properties = {
			colormap           = [[	
									1 1 1 0.02
									1 1 1 0.02									
									1 1 1 0.00	]],

									
			dir                = [[dir]],
			frontoffset        = 0 ,
			fronttexture       = [[Accreationdiskalpha]],
			length             = 50,
			sidetexture        = [[gunshot]],
			size               = 35,
			sizegrowth         = 2.1,
			ttl                = 80,
		},
		},
							   
							  



		
	}		
}		