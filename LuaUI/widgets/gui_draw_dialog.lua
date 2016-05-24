function widget:GetInfo()
	return {
		name = "draw Dialog",
		desc = "Show all ID of units, features, projectiles",
		author = "zwzsg, knorke",
		date = "August 2010",
		license = "Free",
		layer = 0,
		enabled = true,
	}
end

local glText = gl.Text


----------------------------------------------------------

	
function widget:DrawScreenEffects()
	
		
		if G_ and G_.Dialog then
		for _,id in ipairs(Spring.GetAllUnits()) do
				local x,y=Spring.WorldToScreenCoords(Spring.GetUnitPosition(id))
				local FontSize=16
				gl.Text("U:"..id,x,y,16,"od")
		end
		
			if GG.Dialog[id] then 
			local dialog = GG.Dialog[id]			
			x,y,z =Spring.GetUnitPosition(id)
			local FontSize=12
			for i, elements in pairs(dialog) do		
				--offset =((elements.y/elements.frames)*elements.y)+(#dialog)*i*FontSize
				local x,y=Spring.WorldToScreenCoords(Spring.GetUnitPosition(id))
				glText(elements.line,x,y,FontSize,"od")
			end
			end
		end
		end		
end		
		
