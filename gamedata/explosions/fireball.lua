--lowest part of the fire

return {
  ["fireball"] = {
  
 



	fire1={	
				air=true,
				class=[[CSimpleParticleSystem]],
				count=4,
				ground=true,
				water=false,
				
				properties={
				
				texture=[[firehd]],

				colormap           = [[1 1 1 .01  	1 1 1 .01  	1 0.3 0.05 .01		0 0 0 0.01]],
			

				 pos                = [[0 r-5 r5,0 r15,0 r-5 r5]],
				gravity            = [[0.0, 1r0.5, 0.0]],
				emitvector         = [[0r0.1 r-0.1, -1, 0 r0.1 r-0.1]],
				emitrot		= 45,
				emitrotspread	= 32.35,


				sizeGrowth	= 1,
				sizeMod		= 0.99999999999999999,

				airdrag			= 0.5,
				particleLife		= 42,
				particleLifeSpread	= 5,
				numParticles		= 1,
				particleSpeed		= 0.2,
				particleSpeedSpread	= 3.4,
				particleSize		= 0.04,
				particleSizeSpread	= 0.04,

				directional		= 1, 
				useAirLos		= 0,
				},

	
		
	
		},  
	
					

	
				

},

}