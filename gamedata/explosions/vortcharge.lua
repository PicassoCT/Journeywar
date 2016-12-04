-- dirt

return {
	["vortcharge"] = {
		
		
		electricarcs1 = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap = [[ 0.7 0.9 0.1 0.01	 0.7 0.9 0.1 0.01	0.0 0.0 0.0 0.01]],
				dir = [[0.1r0.9r-0.9,0.2r0.8,0.1r0.9r-0.9]],
				frontoffset = 0,
				fronttexture = [[]],
				length = 16,
				sidetexture = [[lightening]],
				size = 2,
				sizegrowth = 12.01,
				ttl = 35,
			},
		},
		electricarcs2 = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap = [[ 0.7 0.9 0.1 0.01	 0.7 0.9 0.1 0.01	0.0 0.0 0.0 0.01]],
				dir = [[0.1r0.9r-0.9,0.2r0.8,0.1r0.9r-0.9]],
				frontoffset = 0,
				fronttexture = [[]],
				length = 128,
				sidetexture = [[lightening]],
				size = 16,
				sizegrowth = -0.5,
				ttl = 35,
			},
		},
		
		
		groundflash = {
			air = true,
			alwaysvisible = true,
			circlealpha = 0.6,
			circlegrowth = 6,
			flashalpha = 0.9,
			flashsize = 220,
			ground = true,
			ttl = 13,
			water = true,
			color = {
				[1] = 0.7,
				[2] = 0.9,
				[3] = 0.1,
			},
		},
		},
	
	
}