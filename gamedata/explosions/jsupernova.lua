-- trail_ar2
redSunColourString= [[	0.5 0.3 0.3 0.0045
0.8 0.25 0.35 0.0045	

]]
colouredString= [[	0.9 0.3 0.3 	 0.005
0.8 0.25 0.35 0.0045		
0.5 0.4 0.3 0.0045
0.5 0.85 0.35 0.004	
0.4 0.9 0.3 0.0045
]]..
[[0.3	0.9 0.3 0.004
0.3 0.75 0.55 0.0035		
0.3 0.65 0.75 0.0025
0.3 0.4 0.95 0.0015	
0.3 0.7 0.95 0.001
0.3 0.4 0.95 0.0005
]]
retractString= 	[[	0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
]]..
[[
0 0 0 0
0 0 0 0
0 0 0 0 
]].. colouredString

return {
	["jsupernova"] = {
		
		orangeball = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 6,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = [[
				0.9 0.45 0.45 0.0042
				0.9 0.45 0.45 0.0052
				0.9 0.45 0.45 0.0062
				0.9 0.45 0.45 0.0072
				0.9 0.45 0.45 0.0052
				0.9 0.45 0.45 0.0042
				0.9 0.45 0.45 0.004
				0.9 0.45 0.45 0.004
				]]
				
				,
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 240,
				particlelifespread = 0,
				particlesize = 180,
				particlesizespread = 35,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod =1.00719,
				texture = [[Actionzone]],
				useairlos = false, alwaysvisible = true,
			},
		},	
		
		swirlingGas = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = redSunColourString,
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 240,
				particlelifespread = 0,
				particlesize = 280,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 1.00819,
				texture = [[innerswirl]],
				useairlos = false, alwaysvisible = true,
			},
		}, 
		swirlingGasCol = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 9,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = colouredString,
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0r-1r1,0.1r0.9,0r-1r1]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 240,
				particlelifespread = 0,
				particlesize = 220,
				particlesizespread = 100,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 1.00819,
				texture = [[outerspira]],
				useairlos = false, alwaysvisible = true,
			},
		}, 
		colouredSwirlingGas = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = colouredString,
				
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 240,
				particlelifespread = 0,
				particlesize = 200,
				particlesizespread = 80,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 1.00819,
				texture = [[pinknovaexplo]],
				useairlos = false, alwaysvisible = true,
			},
		},
		
		retractingGas = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 5,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = retractString,
				directional = false,
				emitrot = 15,
				emitrotspread = 10,
				emitvector = [[0r-1r1,0.1r0.9,0r-1r1]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 480,
				particlelifespread = 100,
				particlesize = 1600,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 0.9985,
				texture = [[outerspira]],
				useairlos = false, alwaysvisible = true,
			},
		}, 
		retractingGass = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 5,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = retractString,
				directional = false,
				emitrot = 15,
				emitrotspread = 10,
				emitvector = [[0r-1r1,0.1r0.9,0r-1r1]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 480,
				particlelifespread = 100,
				particlesize = 1400,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 0.9985,
				texture = [[innerswirl]],
				useairlos = false, alwaysvisible = true,
			},
		}, 
		
		
	},
}