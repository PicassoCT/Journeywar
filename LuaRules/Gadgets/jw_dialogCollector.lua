
function gadget:GetInfo()
	return {
		name = "Dialog",
		desc = "Draws DialogLines of Units ",
		author = "PicassoCT",
		date = "3rd of May 2010",
		license = "Free",
		layer = 0,
		version = 1,
		enabled = true
	}
end

----------------------------------------------------------

	
-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then

		function gadget:GameFrame(frame)
			if frame % 5== 0 and GG.Dialog then

			itterator=#dialog
				for k,v in pairs(GG.Dialog) do	
					if v.frames <= 0 then 
					GG.Dialog[k]= nil 
					end
				end
				--Send to Unsynced
				_G.Dialog = GG.Dialog
			end
		end
else --UNSYNCED

local glText = gl.Text


	function widget:DrawScreenEffects()		
		if SYNCED and SYNCED.Dialog then

			for _,id in ipairs(Spring.GetAllUnits()) do	
				if SYNCED.Dialog[id] then 
				local dialog = _G.Dialog[id]			
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
end

