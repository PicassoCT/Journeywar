
function gadget:GetInfo()
	return {
		name = "j Plague",
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
local 	doneFor={}

	function allreadyDoneFor(id)
	if doneFor==nil or table.getn(doneFor)== 0 then return false end
		for i=1,#doneFor, 1 do
			if doneFor[i]== id then return true end
		end
	return false
	end
	

	-- Configuration:
	
	local spValidUnitID=Spring.ValidUnitID
	local spGetUnitPosition=Spring.GetUnitPosition
	local spCreateUnit=Spring.CreateUnit

	local spGetUnitDEFID=Spring.GetUnitDefID
	local		teamID=Spring.GetGaiaTeamID() 

	function gadget:GameFrame(frame)
	
		if frame % 250 == 0 then
		
			if GG.Spore~=nil then
			max=table.getn(GG.Spore)
			hash=GG.Spore[i]
		
				for i=1,max,1 do
				if GG.Spore[i]~=nil  then
				--make sure the unit still exists
				tempID=nil
					if spValidUnitID(GG.Spore[i])== true and allreadyDoneFor(GG.Spore[i])==false then
						-- get DefID to make sure i aint a spore
							tempDefID=spGetUnitDEFID(GG.Spore[i])
							if tempDefID~= nil and tempDefID ~= UnitDefNames["jspore"].id and tempDefID ~= UnitDefNames["jfungiforrest"].id then 
								--get location to spawn the jspore
								tx,ty,tz=spGetUnitPosition(GG.Spore[i])
									--spawn the spore nearby with the units team
									tempID=spCreateUnit("jspore",tx,ty,tz,0,teamID)
										--now lets get the units Table
												env = Spring.UnitScript.GetScriptEnv(tempID)
											  if env then
											  Spring.UnitScript.CallAsUnit(tempID, env.handsUpAhemDown, GG.Spore[i] )		
											  end
					
							end
					end
				
				doneFor[#doneFor+1]={}
				doneFor[#doneFor]=GG.Spore[i]
					if tempID~= nil then
					doneFor[#doneFor+1]={}
					doneFor[#doneFor]=tempID
					end
				GG.Spore[i]=nil
				
				end
				
				end	
			end
		end
	end	
end
