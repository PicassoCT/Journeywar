-- dirt

return {
  ["vbuildwarp"] = {
  alwaysvisible = true,
  		arcinwards = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 8,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap           = [[ 0.7 0.9 0.1 0.01	 0.7 0.9 0.1 0.01	0.0 0.0 0.0 0.01]],
				dir = [[0.1r0.9r-0.9,0.2r0.8,0.1r0.9r-0.9]],
				frontoffset = 0,
				fronttexture = [[outerspira]],
				length = 256,
				sidetexture = [[lightening]],
				size = 128,
				sizegrowth = -1,
				ttl = 55,
			},
		},
  
shockwave = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap           = [[
				0.0 0.0 0.0 0.01
				0.0 0.0 0.0 0.01
				0.7 0.9 0.1 0.01	 
				0.7 0.9 0.1 0.01	 
				0.7 0.9 0.1 0.01	
				0.0 0.0 0.0 0.01]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[ActionZone]],
				length = 1,
				sidetexture = [[]],
				size = 1,
				sizegrowth =320,
				ttl = 110,
			},
		},
		
		collapsewave = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap           = [[
				0.0 0.0 0.0 0.01
				0.0 0.0 0.0 0.01
				0.0 0.0 0.0 0.01	 
				0.7 0.9 0.1 0.01	 
				0.7 0.9 0.1 0.01	
				0.0 0.0 0.0 0.01]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[novabg]],
				length = 1,
				sidetexture = [[]],
				size = 1200,
				sizegrowth =-1,
				ttl = 220,
			},
		},
		
  		latearcinwards = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 8,
			ground = true,
			underwater = 1,
			water = true,
			properties = {
				colormap           = [[ 
				0.0 0.0 0.0 0.01
				0.0 0.0 0.0 0.01
				0.0 0.0 0.0 0.01
				0.7 0.9 0.1 0.01	
				0.7 0.9 0.1 0.01	
				0.0 0.0 0.0 0.01]],
				dir = [[0.1r0.9r-0.9,0.2r0.8,0.1r0.9r-0.9]],
				frontoffset = 0,
				fronttexture = [[outerspira]],
				length = 256,
				sidetexture = [[lightening]],
				size = 600,
				sizegrowth = -0.5,
				ttl = 220,
			},
		},
  
}
}

