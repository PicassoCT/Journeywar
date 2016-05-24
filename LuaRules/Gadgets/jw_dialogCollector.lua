
function gadget:GetInfo()
	return {
		name = "on Fi",
		desc = "Kills the infected ",
		author = "zwzsg",
		date = "3rd of May 2010",
		license = "Free",
		layer = 0,
		version = 1,
		enabled = true
	}
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then

		function gadget:GameFrame(frame)
			if frame % 5== 0 and GG.Dialog then

			itterator=#dialog
				for k,v in pairs(_G.Dialog) do	
					if v.frames <= 0 then 
					GG.Dialog[k]= nil 
					end
				end
			end
	
		end
end
