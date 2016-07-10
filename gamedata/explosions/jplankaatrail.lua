-- dirt

return {
	["jplankaatail"] = {		
		glowsmoke={	
			air=true,
			class=[[CSimpleParticleSystem]],
			count=1,
			ground=true,
			water=true,
			
			properties={
				
				texture=[[lensflareCenter]],
				
				colormap = [[0.36 0.85 0.9 0.03  0.05 0.2 0.5 0.015 0 0 0 0.01]],				
				
				pos = [[0, 0,0]],
				gravity = [[0 , 0, 0]],
				emitvector = [[dir]],
				emitrot = 0,
				emitrotspread = 0,
				
				
				sizeGrowth	= 0.3,
				sizeMod		= 1,
				
				
				airdrag			= 0.7,
				particleLife		= 30,
				particleLifeSpread	= 0,
				numParticles		= 1,
				particleSpeed		= 0.01,
				particleSpeedSpread	= 0.08,
				particleSize		= 1.14,
				particleSizeSpread	= 14,
				
				directional		= 1, 
				useAirLos		= 0,
			},
			
			
			
			
		},
		
		
		
		
		
	}
	
}