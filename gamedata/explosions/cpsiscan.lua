return {
	["cpsiscan"] = {
		
		alwaysvisible = true,
		usedefaultexplosions = false,
		
		outberbolt = {
			
			
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = true,
			water = true,
			properties = {
				colormap = [[
				0.1 0.3 0.7 .005								
				0.3 0.3 0.8 .01		
				0.4 0.3 0.9 .015	
				0.1 0.3 0.7 .005 									
				0.1 0.3 0.7 0.0001 ]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[empty]],
				length = 64,
				sidetexture = [[shot]],
				size = 4,
				sizegrowth = 4,
				ttl = 100,
			}
		},
		
	}
}