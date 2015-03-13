-- dirt

return {
  ["LightUponSmoke"] = {
  
  ashcloud={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=2,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[SmokeAshCloud]],
				colormap           = [[0.2 0.2 0.2 0.6		0.5 0.5 0.5 0.5	 0.5 0.5 0.5 0.75	0.5 0.5 0.5 0.5	 0.5 0.5 0.5 0.5	0.5 0.5 0.5 0.5	 0 0 0 0.0001]],
				--colormap           = [[1 0.4 0.25 .01     .02 .02 .02 0.01 .004 .004 .004 0.01		0 0 0 0.01]],
			

				 pos                = [[0 r-42 r42, 26r14, 0 r-42 r42]],
				gravity            = [[0r-0.05r0.05, 1 r-0.5 r0.75, 0r-0.05r0.05]],
				emitvector         = [[0, -1, 0]],
				 emitrot            = 3,
				emitrotspread      = 25,


				sizeGrowth	= 0.45,
				sizeMod		= 1.0,

		
				airdrag			= 0.55,
				particleLife		=135,
				particleLifeSpread	= 16,
				numParticles		= 1,
				particleSpeed		= 0.09,
				particleSpeedSpread	= 0.012,
				particleSize		= 2.008,
				particleSizeSpread	= 6,

				directional		= true, 
				useAirLos		= true,
				},

	
		
	
		},
  
  
  
  

  
  
	
	},

}

