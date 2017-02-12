-- artillery_explosion
-- factory_explosion

return {
	["cgateopen"] = {
		gateopen = {
			air = true,
			class = [[CBitmapMuzzleFlame]],
			count = 4,
			ground = true,
			water = true,
			properties = {
				colormap = [[0.6 1 1 0.0045 0.6 1 1 0.0045 0.5 0.9 1 0.0045 0.1 0.05 0.8 0.0045 ]],
				dir = [[r-1r1,r-1r1,r-1r1]],
				frontoffset = 1,
				fronttexture = [[blueexplo]],
				length = 5,

				sidetexture = [[blueexplo]],
				particlesizespread = 1.2,
				size = 15.5,
				sizemod = 2.65,
				sizegrowth = 1.1,
				ttl = 75,
			},
		},
		
	}
	
}