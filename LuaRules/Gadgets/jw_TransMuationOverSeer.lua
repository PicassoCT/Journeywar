

function gadget:GetInfo()
	return {
		name = "TransMuationOverSeer",
		desc = "",
		author = "jK - always jk is there anyhting lua, that he didnt do long before you, making you look like a idiot in his fathers shoes. Oh, yeah, there it is, inferiority_complex.lua, author.. jk. of course. :(",
		date = "Sep. 2008",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
	}
end

--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts






if (gadgetHandler:IsSyncedCode()) then
	--Spring.Echo("TransMuationOverSeer Loaded by default")
	local ZOMBO = "anything at all"
	--This part sends them too hell
	
	--config for killer,victim,zombie relation
	local zomba = {
		--when a scorpion kill a dude, the dude dies so hard he turns into a helicopter and converts to your team:
		[UnitDefNames["hc"].id] = {[UnitDefNames["gjmedbiogwaste"].id] = {unit=UnitDefNames["gzombiehorse"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["gjbigbiowaste"].id] = {unit=UnitDefNames["gzombiehorse"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["ghohymen"].id] = {unit=UnitDefNames["gzombiehorse"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["bg"].id] = {unit=UnitDefNames["zombie"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["tiglil"].id] = {unit=UnitDefNames["zombie"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["css"].id] = {unit=UnitDefNames["zombie"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["skinfantry"].id] = {unit=UnitDefNames["zombie"].id, killerTeam=true,}, } ,
		[UnitDefNames["hc"].id] = {[UnitDefNames["gcivillian"].id] = {unit=UnitDefNames["zombie"].id, killerTeam=true,}, } ,
		
		--when a tank is destroyed (no matter by what) a dude escapes from it, like the technicans in C&C:
		[ZOMBO] = {[UnitDefNames["restrictor"].id] = {unit=UnitDefNames["bg"].id, killerTeam=false,}, } ,
		[ZOMBO] = {[UnitDefNames["mtw"].id] = {unit=UnitDefNames["bg"].id, killerTeam=false,}, } ,
		--[ZOMBO] = {[UnitDefNames["ampro"].id] = {unit=UnitDefNames["bg"].id, killerTeam=false,}, } ,
		
		--jeep turns everything it kills into a new jeep (for its team)
		--[UnitDefNames["tpjeep"].id] = {unit=UnitDefNames["tpjeep"].id, killerTeam=true,} ,
		
		--headcrab creates new headcrab when killing a dude:
		-- [UnitDefNames["hc"].id] = {[UnitDefNames["dude"].id] = {unit=UnitDefNames["headcrab"].id, killerTeam=true,}, } ,
	}
	
	
	
	local finishedUnits = {}
	gaiaTeamID=Spring.GetGaiaTeamID()
	function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
		if (not finishedUnits[unitID]) then return end
		
		local result = nil
		if (zomba[attackerDefID]) then
			if zomba[attackerDefID][unitDefID] then
				result = zomba[attackerDefID][unitDefID] 
			else
				result = zomba[attackerDefID]
			end
		end
		
		if (result==nil and zomba[ZOMBO]) then
			result = zomba[ZOMBO][unitDefID]
		end
		
		if (result) then
			local x,y,z = Spring.GetUnitPosition (unitID)
			if (result.killerTeam) then
				teamID = gaiaTeamID
			end
			Spring.CreateUnit (result.unit, x,y,z, 0, teamID)
		end
	end
	
	--THis part watches for shell
	
	
	
	
	
	function gadget:UnitFinnished(unitID, unitDefID, teamID)
		finishedUnits[unitID] = true
	end
	
	
	
	
	
end