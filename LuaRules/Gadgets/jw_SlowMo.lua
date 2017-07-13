function gadget:GetInfo()
    return {
        name = "SlowMotion",
        desc = "This gadget coordinates gamespeed sets by hiveMinds and AI-Nodes",
        author = "PicassoCT",
        date = "Sep. 2008",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_OS.lua")
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_Build.lua")
    VFS.Include("scripts/lib_jw.lua")

	--check for active HiveMinds and AI Nodes
	function isHiveMindActive()
		if not GG.HiveMind then GG. HiveMind = {} end
		tableTeamsActive={}
		boolActive=false
		for team, uTab in pairs(GG.HiveMind) do
			for unit, data in pairs(utab) do
				if data.boolActive == true then
				tableTeamsActive[team]=unit
				boolActive =true
			end
		end
		
		return boolActive, tableTeamsActive
	end
	
	-- if active ones, find others that could be active
	function activateOtherHiveminds(tableTeamsActive)
		if not GG.HiveMind then GG. HiveMind = {} end
		
		for team, uTab in pairs(GG.HiveMind) do
			if not tableTeamsActive[team] then
			for unit, data in pairs(utab) do
				if data.rewindMilliSeconds > 0 then
				env = Spring.UnitScript.GetScriptEnv(unit)
					if env then
						Spring.UnitScript.CallAsUnit(unit, env.setActive)
						tableTeamsActive[team] =unit
					end
				break
				end		
			end
			end
		end
	return tableTeamsActive	
	end

	
	--for teams without a active node or no node at all - hide the cursor during the slowMotionPhase
	function deactivateCursorForNormalTeams(tableTeamsActive)
	deactivatedTeams={}
	allTeams = Spring.GetTeamList()
	process(allTeams,
			function (team)
				if not tableTeamsActive[team] then
					deactivatedTeams[team] = true
					deactivateCursorForTeam(team)
				end
			end
			)	
	end

	
	function gadget:GameFrame(n)
	
	
	end
	
else --Unsynced


	
	
	
end