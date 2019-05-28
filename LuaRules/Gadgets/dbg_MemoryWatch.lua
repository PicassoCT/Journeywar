function gadget:GetInfo()
	return {
		name = "Memory Watch - extremely expensive to run",
		desc = "Observes MemoryAllocation in GG and Units",
		author = "Picasso",
		date = "12.02.1983",
		version = "",
		license = "GPL4 ",
		layer = 1,
		handler = true,
		enabled = false
	}
end

if gadgetHandler:IsSyncedCode() then
	TimeOfExecutionInMinutes= 3
	TimeOfExecutionInFrames= TimeOfExecutionInMinutes*60*30
	-------------------------------------
	-- Includes
	VFS.Include('scripts/lib_UnitScript.lua')
	VFS.Include('scripts/lib_jw.lua')
	
	--CodeMan could let it run without building units
	-- Either specific units or gadgets related to units
	
	growthRate ={} --Key--SizeOfOld  ,GrowthRelativeToPreviousFrame
	growthRateEnv ={} --Key--SizeOfOld  ,GrowthRelativeToPreviousFrame
	function watchGG()
		for k,v in pairs(GG) do
			if not growthRate[k] then --first Time
				newSize= getSizeInByte(v)
				growthRate[k] = {oldSize= newSize, factor=1.0 }				
			else
				newSize= getSizeInByte(v)
				growthRate[k].factor =  (newSize/growthRate[k].oldSize)-1
				growthRate[k].oldSize =  newSize			
			end		
		end	
	end	
	
	function watchEnv()
	AllUnits= Spring.GetAllUnits()
		for k,v in pairs(AllUnits) do
			env = Spring.UnitScript.GetScriptEnv(v)
			if env then					
				if not growthRateEnv[k] then --first Time
					newSize= getSizeInByte(env)
					growthRateEnv[k] = {oldSize= newSize, factor=1.0 }					
				else
					newSize= getSizeInByte(env)
					growthRateEnv[k].factor =  (newSize/growthRateEnv[k].oldSize)-1
					growthRateEnv[k].oldSize =  newSize			
				end		
			end	
		end	
	end
	
	function gadget:GameFrame(frame)
		if frame % 100 == 0 and GG then
			watchGG()
		end	
		
		if frame % 200 == 0 and GG then
			watchEnv()
		end
	
	
		if frame % TimeOfExecutionInFrames  == 0 and GG then
			echStats({"GG.Key", "Increase Percent"}, growthRate, 24, false)
		end
		if frame % TimeOfExecutionInFrames  == 1 and GG then
			echStats({"Unit.id", "Increase Percent"}, growthRateEnv, 24, false)
		end
	end


end