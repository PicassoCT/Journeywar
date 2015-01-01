    function widget:GetInfo()
            return {
                            name    = "draw Dialog",
                            desc    = "Show all ID of units, features, projectiles",
                            author  = "zwzsg, knorke",
                            date    = "August 2010",
                            license = "Free",
                            layer   = 0,
                            enabled = true,
                    }
    end
     
     
function widget:DrawScreenEffects()
	
	if _G and  _G.Dialog then
	local dialog=_G.Dialog
		for i=1,#dialog do
			local element=dialog[i]
			local x,y=Spring.WorldToScreenCoords(element.x,element.y,element.z)
			gl.Text(element.txt,x,y,16,"od")	
		end
		
	
	end


end