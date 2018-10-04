-- trail_ar2




return {
	["cawilduniversecorona"] = {
		top = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			alwaysvisible = true,
			
			properties = {
				colormap = [[
				1 0.25 0.8 0.005	
				1 0.25 0.8 0.005	
				1 0.55 0.9 0.004	
				1 0.55 0.9 0.004	
				1 0.55 0.8 0.04]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[nuke]],
				length			 = 6,
				sidetexture = [[]],
				size = 128,
				sizegrowth = 1.41,
				ttl = 30*15,
			},
		}	,	
		
		shrink = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 1,
			ground = true,
			underwater = 1,
			water = true,
			alwaysvisible = true,
			
			properties = {
				colormap = [[
				1 0.3 0.55 0 
				1 0.3 0.55 0 
				1 0.3 0.55 0.002 
				1 0.55 0.9 0.004
				1 0.55 0.9 0.004																	
				1 0.25 0.8 0.005	
				1 0.25 0.8 0.005	
				]],
				dir = [[0,1,0]],
				frontoffset = 0,
				fronttexture = [[nuke]],
				length			 = 6,
				sidetexture = [[]],
				size = 1000,
				sizegrowth = -0.8,
				ttl = 30*30,
			},
		}	,	
	},
	
}