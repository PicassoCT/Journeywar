--lowest part of the fire

return {
	["jtree2trans"] = {		
		groundflash = {
			circlealpha = 1,
			circlegrowth = 0,
			flashalpha = 0.99,
			flashsize = 150,
			ttl = 15,
			color = {
				[1] = 0.6,	
				[2] = 0.9,
				[3] = 0.10000001192093,
			},
		},
		
		glow = {
			air = true,
			class = [[heatcloud]],
			count = 1,--1
			ground = true,
			water = true,
			properties = {
				alwaysvisible = true,
				heat = 3,
				heatfalloff = 0.05,
				maxheat = 3,
				pos = [[0r-5r10,0r-5r10,0r-5r10]],
				size = [[0.5]],
				sizegrowth = [[1.04]],
				speed = [[0, 1 0, 0]],
				texture = [[greennovaexplo]],
			},
		},
		
		fire1={	
			air=true,
			class=[[CSimpleParticleSystem]],
			count=4,
			ground=true,
			water=false,
			
			properties={
				
				texture=[[lensflareCenter]],
				
				colormap = [[0.7 0.9 0 .01 	0.8 0.65 0 .01	0.9 0.5 0.05 .01		0 0 0 0.01]],
				
				
				pos = [[0 r-5 r5,0 r15,0 r-5 r5]],
				gravity = [[0.0, 1r0.5, 0.0]],
				emitvector = [[0r0.1 r-0.1, -1, 0 r0.1 r-0.1]],
				emitrot		= 45,
				emitrotspread	= 32.35,
				
				
				sizeGrowth	= 1,
				sizeMod		= 1.000001,
				
				airdrag			= 0.5,
				particleLife		= 40,
				particleLifeSpread	= 45,
				numParticles		= 1,
				particleSpeed		= 0.2,
				particleSpeedSpread	= 3.4,
				particleSize		= 0.02,
				particleSizeSpread	= 0.02,
				
				directional		= 1, 
				useAirLos		= 0,
			},
		},
		muzzle = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap = [[0.7 0.9 0 .01 	0.8 0.65 0 .01	0.9 0.5 0.05 .01		0 0 0 0.01]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[innerswirl]],
				length = 25,
				--sidetexture = [[TouchGround]],
				sidetexture = [[huntertrail]],
				size = 5,
				sizegrowth = 3.1,
				ttl = 80,
			},
		}, 
		
		
	}, 
	
}