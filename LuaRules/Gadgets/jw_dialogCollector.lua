
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
		local dialog=GG.Dialog
		itterator=#dialog
			while itterator > 0 do
			dialog[itterator].frames=		dialog[itterator].frames-5
			if dialog[itterator].frames < 1 then
			dialog[itterator]=nil
			end
			itterator=itterator-1
			
		
		end
		end
	
		end
end
