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
			

				 pos                = [[0 r-13 r13, 26, 0 r-13 r13]],
				gravity            = [[0, 1 r-0.5 r0.75, 0]],
				emitvector         = [[0, -1, 0]],
				  emitRot		= 42,
				 emitRotSpread	= 12.824,


				sizeGrowth	= 0.45,
				sizeMod		= 1.0,

		
				airdrag			= 0.55,
				particleLife		=175,
				particleLifeSpread	= 36,
				numParticles		= 1,
				particleSpeed		= 0.09,
				particleSpeedSpread	= 0.012,
				particleSize		= 0.008,
				particleSizeSpread	= 3,

				directional		= true, 
				useAirLos		= 0,
				},

	
		
	
		},
  
  
  
  

  
  
	
	},

}

