function gadget:GetInfo()
    return {
        name = "SlowMotion",
        desc = "This gadget coordinates gamespeed sets by hiveMinds and AI-Nodes",
        author = "PicassoCT",
        date = "Juli. 2017",
        license = "GNU GPL, v2 or later",
		layer = math.huge,
		handler = true,
        enabled = true
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_OS.lua")
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_Build.lua")
    VFS.Include("scripts/lib_jw.lua")

	--check for active HiveMinds and AI Nodes
	function areHiveMindsActive()
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
	
	oldGameSpeed = Game.Gamespeed
	effectOffset= 30 * 4
	--set SlowMotion effect
	
	function slowMotion(frame, startFrame, endFrame)
		if frame < startFrame or frame > endFrame + effectOffset then 
			return 
		end
	
		if frame == startFrame then
		oldGameSpeed = Game.Gamespeed
		Spring.PlaySoundFile("sounds/hivemind/slowMoStart.ogg",1.0)
		end
		
		--SlowMoPhase
		if frame > startFrame and frame < endFrame then
			factor = math.ceil(10 *((frame - startFrame)/ effectOffset))/10
			currentSpeed = mix(oldGameSpeed, 0.1, math.min(1.0,factor))
			Spring.SendCommand("speed "..currentSpeed)
		end
		
		--Speed up phase
		if frame == endFrame then
			Spring.PlaySoundFile("sounds/hivemind/slowMoStop.ogg",1.0)
		end
		
		if frame >= endFrame and frame <= endFrame + effectOffset then
			factor= (frame - endFrame)/ effectOffset
			currentSpeed = mix(0.1, oldGameSpeed, factor)
			Spring.SendCommand("speed "..currentSpeed)
		end	
	
	end

	
	--for teams without a active node or no node at all - hide the cursor during the slowMotionPhase
	function deactivateCursorForNormalTeams(tableTeamsActive)
		deactivatedTeams={}
		allTeams = Spring.GetTeamList()
		process(allTeams,
				function (team)
					if not tableTeamsActive[team] then
						deactivatedTeams[team] = true
					    SendToUnsynced("hideCursor", team)
					end
				end
				)	
	end
	
	--restore Cursor for non-active teams
	function restoreCursorNonActiveTeams(tableTeamsActive)
		allTeams = Spring.GetTeamList()
		process(allTeams,
				function (team)
					if not tableTeamsActive[team] then
					    SendToUnsynced("restoreCursor", team)
					end
				end
				)	
	end

	boolPreviouslyActive =false
	endFrame=Spring.GetGameFrame()
	startFrame =Spring.GetGameFrame()
	
	function gadget:GameFrame(n)
			boolActive, activeHiveMinds = areHiveMindsActive()
			if boolActive == true then
				if boolPreviouslyActive == false then 
					boolPreviouslyActive =true
					startFrame = n
				end				
			
				activeHiveMinds =	activateOtherHiveminds(activeHiveMinds)
				deactivateCursorForNormalTeams(activeHiveMinds)
				
				endFrame = n + 1
			elseif endFrame == n then 
				restoreCursorNonActiveTeams(activeHiveMinds)
			end
			
			slowMotion(n, startFrame, endFrame)
	end
	
else --Unsynced
	VFS.Include("LuaUI/widgets/gui_lib/gui_helper.lua")

	formerCommandTable={}
	alt, ctrl, meta, shift,left,right =0,0,0,0
	
	--deactivate mouse icon
	boolLameDuck= false
	local function restoreCursor(_, team )
		myTeam = Spring.GetMyTeamID()
		if myTeam == team then 		
			boolLameDuck= true
			oldCommand = Spring.GetAct	iveCommand()
			formerCommandTable[team] = oldCommand			
			
			alt, ctrl, meta, shift =GetModKeys()
			local _, _, left, _, right = Spring.GetMouseState()
		
		end

	end

	function gadget:GameFrame(n)
		if boolLameDuck == true then
			Spring.SetActiveCommand(CMD.WAIT, 1, left, right, alt, ctrl, meta, shift)	
		end	
	end	
	
	local function hideCursor(_, team )
		myTeam = Spring.GetMyTeamID()
		if myTeam == team then 
			boolLameDuck = false
			Spring.SetActiveCommand(formerCommandTable[team], 1, left, right, alt, ctrl, meta, shift)
		end
	end
	
	gadgetHandler:AddSyncAction("restoreCursor", restoreCursor)
	gadgetHandler:AddSyncAction("hideCursor", hideCursor)
end