-- dirt

return {
	["unusedslowradar"] = {		
		expandingsphere={	
			air=true,
			class=[[CSimpleParticleSystem]],
			count=1,
			ground=true,
			water=true,
			
			properties={
				
				texture=[[ActionZone]],
				
				colormap = [[ 0.05 0.2 0.5 0.03 	0.36 0.85 0.9 0.015 ]],				
				
				pos = [[0, 0,0]],
				gravity = [[0 , 0, 0]],
				emitvector = [[0,1,0]],
				emitrot = 0,
				emitrotspread = 0,
				
				
				sizeGrowth	= 1.58,
				sizeMod		= 1,
				
				
				airdrag			= 0.7,
				particleLife		= 60,
				particleLifeSpread	= 0,
				numParticles		= 1,
				particleSpeed		= 0.01,
				particleSpeedSpread	= 0.08,
				particleSize		= 5,
				particleSizeSpread	= 0,
				
				directional		= 1, 
				useAirLos		= 0,
			},
			
			
			
			
		},
		shrinkingSphere={	
			air=true,
			class=[[CSimpleParticleSystem]],
			count=1,
			ground=true,
			water=true,
			
			properties={
				
				texture=[[ActionZone]],
				
				colormap = [[0 0 0 0.00 	0 0 0 0.00 	0.36 0.85 0.9  0.03 	 0.05 0.2 0.5 0.015 ]],				
				
				pos = [[0, 0,0]],
				gravity = [[0 , 0, 0]],
				emitvector = [[0,1,0]],
				emitrot = 0,
				emitrotspread = 0,
				
				
				sizeGrowth	= 1.58,
				sizeMod		= 1,
				
				
				airdrag			= 0.7,
				particleLife		= 120,
				particleLifeSpread	= 0,
				numParticles		= 1,
				particleSpeed		= 0.01,
				particleSpeedSpread	= 0.08,
				particleSize		= 5,
				particleSizeSpread	= 0,
				
				directional		= 1, 
				useAirLos		= 0,
			},
			
			
			
			
		}
		
		
		
		
	}
	
}