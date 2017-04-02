
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
include("LuaUI/widgets/guiEnums.lua")
include("LuaUI/widgets/gui_helper.lua")

--Localisations
local spGetUnitTeam =	Spring.GetUnitTeam
local spGetUnitDefID = Spring.GetUnitDefID

--gets All Units selected by a Player
function getSelectedUnits(playerID)
	T=Spring.GetSelectedUnits()
	return T or {}
end

filterFunctionTable={
	[CMD.ATTACK]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canAttack or UnitDefs[defID].canFight then
				return id
			end 						
		end
		) or {}	
	end,
	
	[CMD.MOVE]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canMove then
				return id
			end 						
		end
		) or {}	
	end,
	
	[CMD.FIRE_STATE]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].noAutoFire then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.STOP]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canStop == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.FIGHT]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canFight == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.PATROL]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canPatrol == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.CLOAK]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canCloak == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.GUARD]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canGuard == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.SELFD]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canSelfDestruct == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.RESTORE]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canRestore == true then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.MOVE_STATE]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].moveState then
				return id
			end 						
		end
		) or {}	
	end,
	[CMD.REPEAT]= function(T,filterID,playerID,playerTeamID)
		return process(T,
		function(id)		
			defID=spGetUnitDefID(id)
			if defID and UnitDefs[defID].canRepeat then
				return id
			end 						
		end
		) or {}	
	end,
	
	[CMD.RECLAIM]= function(T,filterID,playerID,playerTeamID)
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



function issueCommand(T, commandID, playerID, playerTeamID,mouseX,mouseY,boolNoTarget)
	
	if boolNoTarget== true then
		Spring.GiveOrderToUnitArray(T,commandID,{},params) 
	else
		targetType,target= Spring.TraceScreenRay(mouseX,mouseY,false,true)
		params= getCommandTable()
		
		if targetType then
			if targetType=="unit" 	 then 
				Spring.GiveOrderToUnitArray(T,commandID,{target},params) 
			end
			if targetType=="feature" then 
				Spring.GiveOrderToUnitArray(T,commandID,{target},params) 
			end
			if targetType=="ground"	 then 
				Spring.GiveOrderToUnitArray(T,commandID,target,params) 
			end
		end
	end
end