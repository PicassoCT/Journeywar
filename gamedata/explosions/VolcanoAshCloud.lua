-- dirt

return {
	["volcanoashcloud"] = {
	tex1vers={	
			air=true,
			class=[[CSimpleParticleSystem]],
			count=3,
			ground=true,
			water=true,
			
			properties={
				
				texture="SmokeAshCloud",
				colormap = [[
							0.6 0.2 0.1  0.2 
							0.6 0.2 0.1  0.2 
							0.6 0.2 0.1  0.6 
							0.6 0.2 0.1  0.6 
							0.25 0.12 0.1  0.85 
							0.25 0.12 0.1  0.85 
							0.25 0.12 0.1  0.85 
							0.25 0.12 0.1  0.85 
							0.6 0.2 0.1  0.6 
							0.25 0.2 0.2   0.9 
							0.25 0.2 0.2   0.9 
							0.25 0.2 0.2   0.9 
							0.25 0.2 0.2   0.9 
							0.3 0.25 0.25  0.9 							
							0.3 0.25 0.25  0.7 							
							0.3 0.25 0.25 0.5
							0.6 0.2 0.1  0.3 
							0.3 0.25 0.25  0.7
							0.5 0.5 0.5 0.141
							]],
			
				
				--pos = [[0r-42r42 , r42 + i15, 0r-42r42 ]],
				pos = [[0r-42r42 , r42 , 0r-42r42 ]],
				gravity = [[0r-0.05r0.05, 0r0.5s1 , 0r-0.05r0.05]],
				emitvector = [[0r0.1r-0.1, s-1, 0r0.1r-0.1]],
				emitrot = 3,
				emitrotspread = 25,
				
				
				sizeGrowth	= 0.45,
				sizeMod		= 1.000000000001,
				
				
				airdrag			= 0.55,
				particleLife		=150,
				particleLifeSpread	= 90,
				numParticles		= 1,
				particleSpeed		= 0.09,
				particleSpeedSpread	= 0.12,
				particleSize		= 3.5,
				particleSizeSpread	= 4,
				
				directional		= true, 
				useAirLos		= true,
			},			
		},
		tex2vers={	
			air=true,
			class=[[CSimpleParticleSystem]],
			count=1,
			ground=true,
			water=true,
			
			properties={
				
				texture="sparkcloud",
				colormap = [[
							0.6 0.2 0.1  0.2 
							0.6 0.2 0.1  0.2 
							0.6 0.2 0.1  0.6 
							0.6 0.2 0.1  0.6 
							0.25 0.12 0.1  0.85 
							0.25 0.12 0.1  0.85 
							0.25 0.12 0.1  0.85 
							0.25 0.12 0.1  0.85 
							0.6 0.2 0.1  0.6 
							0.25 0.2 0.2   0.9 
							0.25 0.2 0.2   0.9 
							0.25 0.2 0.2   0.9 
							0.25 0.2 0.2   0.9 
							0.3 0.25 0.25  0.9 							
							0.3 0.25 0.25  0.7 							
							0.3 0.25 0.25 0.5
							0.6 0.2 0.1  0.3 
							0.3 0.25 0.25  0.4
							0.5 0.5 0.5 0.141
							]],
			
				
				--pos = [[0r-42r42 , r42 + i15, 0r-42r42 ]],
				pos = [[0r-42r42 , r42 , 0r-42r42 ]],
				gravity = [[0r-0.05r0.05, 0r0.5s1 , 0r-0.05r0.05]],
				emitvector = [[0r0.1r-0.1, s-1, 0r0.1r-0.1]],
				emitrot = 3,
				emitrotspread = 25,
				
				
				sizeGrowth	= 0.45,
				sizeMod		= 1.000000000001,
				
				
				airdrag			= 0.55,
				particleLife		=90,
				particleLifeSpread	= 150,
				numParticles		= 1,
				particleSpeed		= 0.09,
				particleSpeedSpread	= 0.12,
				particleSize		= 3.5,
				particleSizeSpread	= 2,
				
				directional		= true, 
				useAirLos		= true,
			},			
		},

		
		
	},	
}