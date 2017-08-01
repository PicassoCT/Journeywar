
function widget:GetInfo()
	return {
		name = "gui_unitSelector",
		desc = "Gets selected Units - fitting to a command",
		author = "PicassoCT",
		date = "2016-6-2",
		license = "GNU GPL, v2 or later",
		layer = 254,
		enabled = true,
		hidden= true,
	}
end
include("ressoures/guiEnums.lua")

--Localisations
local spGetUnitTeam =	Spring.GetUnitTeam
local spGetUnitDefID = Spring.GetUnitDefID

--gets All Units selected by a Player
function getSelectedUnits(playerID)
	T=Spring.GetSelectedUnits()
	return T or {}
end



filterFunctionTable={
	[eAttac]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canAttack or UnitDefs[defID].canFight then
				return id
			end 						
		end
		) or {}	
	end,
	
	[eMove]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canStop then
				return id
			end 						
		end
		) or {}	
	end,
	
	[eFireState]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].noAutoFire then
				return id
			end 						
		end
		) or {}	
	end,
	[eStop]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canStop == true then
				return id
			end 						
		end
		) or {}	
	end,
	[eFight]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canFight == true then
				return id
			end 						
		end
		) or {}	
	end,
	[ePatrol]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canPatrol == true then
				return id
			end 						
		end
		) or {}	
	end,
	[eCloak]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canCloak == true then
				return id
			end 						
		end
		) or {}	
	end,
	[eGuard]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canGuard == true then
				return id
			end 						
		end
		) or {}	
	end,
	[eSelfDestruct]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canSelfDestruct == true then
				return id
			end 						
		end
		) or {}	
	end,
	[eRestore]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canRestore == true then
				return id
			end 						
		end
		) or {}	
	end,
	[eMoveState]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].moveState then
				return id
			end 						
		end
		) or {}	
	end,
	[eRepeat]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canRepeat then
				return id
			end 						
		end
		) or {}	
	end,
	
	[eReclaim]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canReclaim then
				return id
			end 						
		end
		) or {}	
	end
}


--filters Out Units to whom the Commands dont apply
function filterUnits(T, filterID, playerID, playerTeamID, boolFilterTeam)
	if boolFilterTeam and boolFilterTeam == true then
	T=process(T,
				function(id)
					if spGetUnitTeam(id)== playerTeamID then
						return id 
					end
				end
				)
	end

	if filterFunctionTable[filterID] then
		return filterFunctionTable[filterID](T, filterID, playerID, playerTeamID)
	else
		Spring.Echo("api_selector:filterUnits: Not known filterType")
	end	
end