-- trail_ar2
redSunColourString= [[	
0.9 0.3 0.3 	 0.005
0.8 0.25 0.35 0.0045		
0.5 0.3 0.3 0.0045
0.8 0.25 0.35 0.004	
0.9 0.3 0.3 0.0045
]]..
[[	0.9 0.3 0.3 0.004
0.8 0.25 0.35 0.0045		
0.5 0.3 0.3 0.004
0.8 0.25 0.35 0.0045	
0.9 0.3 0.3 0.004
]]

coronaColourString= [[	
0.9 0.3 0.3 	 0.005
0.8 0.25 0.35 0.0045		
0.5 0.3 0.3 0.0045
0.8 0.25 0.35 0.004	
0.9 0.3 0.3 0.004
]]..
[[	0.9 0.3 0.3 0.004
0.8 0.25 0.35 0.004		
0.5 0.3 0.3 0.004
0.8 0.25 0.35 0.004	
0.9 0.3 0.3 0.0039
0 0 0 0
]]
return {
	["jsupernovaprep"] = {
		--redSunStage
		--12 Seconds
		--4 to compression Red Giant Collapse
		corona = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = coronaColourString,
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 90,
				particlelifespread = 0,
				particlesize = 250,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 1.01301,
				texture = [[burn]],
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
				colormap = redSunColourString
				,
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 150,
				particlelifespread = 0,
				particlesize = 980,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 0.9957,
				texture = [[Galaxy5]],
				useairlos = false,
			},
		}, 
		redsun = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = redSunColourString
				,
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 90,
				particlelifespread = 0,
				particlesize = 350,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 0.995752,
				texture = [[Flake]],
				useairlos = false,
			},
		}, 
		
		surface = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = redSunColourString
				,
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 100,
				particlelifespread = 0,
				particlesize = 4
				,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod = 0.995752,
				texture = [[Actionzone]],
				useairlos = false,
			},
		},
		
		gasinterior = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 1,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = redSunColourString
				
				,
				directional = false,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 120,
				particlelifespread = 0,
				particlesize = 350,
				particlesizespread = 0,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod =0.995752,
				texture = [[bigexplosmoke]],
				useairlos = false,
			},
		},
		
		orangeball = {
			air = true,
			class = [[CSimpleParticleSystem]],
			count = 6,
			ground = true,
			water = true,
			properties = {
				airdrag = 1,
				colormap = [[
				0 0 0 0
				0 0 0 0
				0 0 0 0
				0.9 0.45 0.45 0.0042
				0.9 0.45 0.45 0.0042
				0.9 0.45 0.45 0.0042
				]]
				
				,
				directional = true,
				emitrot = 0,
				emitrotspread = 0,
				emitvector = [[0,0,0]],
				gravity = [[0, 0, 0]],
				numparticles = 1,
				particlelife = 180,
				particlelifespread = 0,
				particlesize = 180,
				particlesizespread = 70,
				particlespeed = 0.00,
				particlespeedspread = 0,
				pos = [[0, 0, 0]],
				sizegrowth = [[ 0.0000000000001]],
				sizemod =1.000000005,
				texture = [[Actionzone]],
				useairlos = false,
			},
		},	
		
	},
}