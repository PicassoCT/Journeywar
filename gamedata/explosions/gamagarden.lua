-- missile_explosion

return {
	["gamagarden"] = {
		
		groundflash = {
			air = true,
			alwaysvisible = true,
			circlealpha = 0.5,
			circlegrowth = 7,--6
			flashalpha = 0.01,
			flashsize = 210,
			ground = true,
			ttl = 53,--53
			water = true,
			color = {
				[1] = 0,
				[2] = 0.5,
				[3] = 0.5,
			},
		},
		lightshape = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = true,
			water = true,
			properties = {
				colormap = [[
				0 0.5 0.5 0	 
				0 0.5 0.5 0.01	
				0 0.5 0.5 0	 				
				0.8 0.96 0.28 0.01	 
				0 0.5 0.5 0	 
				0 0.5 0.5 0.01	 
				0 0.5 0.5 0 								
				]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[AtomZone]],
				length = 0,
				sidetexture = [[]],
				size = 25,
				sizegrowth = 6.66,
				ttl = 75,
			},
		},
		
		
	},
	
}