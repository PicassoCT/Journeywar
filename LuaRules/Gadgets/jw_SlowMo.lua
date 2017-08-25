function gadget:GetInfo()
    return {
        name = "SlowMotion",
        desc = "This gadget coordinates gamespeed sets by hiveMinds and AI-Nodes",
        author = "PicassoCT",
        date = "Juli. 2017",
        license = "GNU GPL, v2 or later",
        layer = 966,
			version = 1,		
        enabled = true

    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_OS.lua")
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_Build.lua")
    VFS.Include("scripts/lib_jw.lua")
    
	
	function gadget:Initialize()
		SendToUnsynced("Initialize")
	end

    --check for active HiveMinds and AI Nodes
    function areHiveMindsActive()
        if not GG.HiveMind then GG.HiveMind = {}; return false, {} end
        tableTeamsActive = {}
        boolActive = false
        for team, uTab in pairs(GG.HiveMind) do
            if uTab then
                for unit, data in pairs(uTab) do
                    if type(data) ~= "boolean" then
                        if data.boolActive == true then
                            tableTeamsActive[team] = unit
                            boolActive = true
                        end
                    end
                end
            end
        end

        return boolActive, tableTeamsActive
    end

    -- if active ones, find others that could be active
    function activateOtherHiveminds(tableTeamsActive)
        if not GG.HiveMind then GG.HiveMind = {} end

        for team, uTab in pairs(GG.HiveMind) do
            if not tableTeamsActive[team] then
                for unit, data in pairs(uTab) do
                    if data.rewindMilliSeconds > 0 then
                        env = Spring.UnitScript.GetScriptEnv(unit)
                        if env then
                            Spring.UnitScript.CallAsUnit(unit, env.setActive)
                            tableTeamsActive[team] = unit
                        end
                        break
                    end
                end
            end
        end
        return tableTeamsActive
    end

    oldGameSpeed = 1.0
    effectOffset = 30 * 4
    DurationInSeconds = 30 * 10
    --set SlowMotion effect

    function slowMotion(frame, startFrame, endFrame)
        currentSpeed = 0

        if frame == startFrame then
            Spring.PlaySoundFile("sounds/HiveMind/StartLoop.ogg", 1.0)
            return
        end

        --Slow Down
        if frame > startFrame and frame < startFrame + effectOffset then
            factor = math.ceil(10 * ((frame - startFrame) / effectOffset)) / 10

            currentSpeed = mix(0.1, 1.0, factor)
            if Game.gameSpeed > currentSpeed then
                echo("slowdown to " .. factor)
                Spring.SendCommands("slowdown")
            end
            return
        end

        --SlowMoPhase
        if frame >= startFrame + effectOffset and frame < endFrame then

            if Game.gameSpeed > 0.1 then
                Spring.SendCommands("slowdown")
            end

            if frame - startFrame % 210 == 0 then
                Spring.PlaySoundFile("sounds/HiveMind/journeyloop.ogg", 1.0)
            end
            return
        end

        --Speed up phase
        if frame == endFrame then
            Spring.PlaySoundFile("sounds/HiveMind/EndLoop.ogg", 1.0)
            return
        end

        if frame >= endFrame and frame <= endFrame + effectOffset and Game.gameSpeed < 1.0 then
            factor = (frame - endFrame) / effectOffset
            currentSpeed = mix(oldGameSpeed, 0.1, factor)
            if Game.gameSpeed < currentSpeed then
                echo("speedup to " .. factor)
                Spring.SendCommands("speedup ")
            end
            return
        end
    end


    --for teams without a active node or no node at all - hide the cursor during the slowMotionPhase
    function deactivateCursorForNormalTeams(tableTeamsActive)
        deactivatedTeams = {}
        allTeams = Spring.GetTeamList()
        process(allTeams,
            function(team)
                if not tableTeamsActive[team] then
                    deactivatedTeams[team] = true
					SendToUnsynced("hideCursor", team)
                end
            end)
    end

    --restore Cursor for non-active teams
    function restoreCursorNonActiveTeams(tableTeamsActive)
        allTeams = Spring.GetTeamList()
        process(allTeams,
            function(team)
                if not tableTeamsActive[team] then
					SendToUnsynced("restoreCursor", team)
                end
            end)
    end

    boolPreviouslyActive = false
    endFrame = -math.huge
    startFrame = -math.huge

    function gadget:GameFrame(n)

        boolActive, activeHiveMinds = areHiveMindsActive()
        if boolActive == true then
		    
            if boolPreviouslyActive == false then
				SendToUnsynced("ActivateSlowMoShadder", true)
                boolPreviouslyActive = true
                startFrame = n
            end

            activeHiveMinds = activateOtherHiveminds(activeHiveMinds)
            deactivateCursorForNormalTeams(activeHiveMinds)

            endFrame = n + DurationInSeconds
        elseif boolActive == false and endFrame == n then
			SendToUnsynced("ActivateSlowMoShadder", false)
            restoreCursorNonActiveTeams(activeHiveMinds)
            boolPreviouslyActive = false
        end

        slowMotion(n, startFrame, endFrame)
    end



else --Unsynced



    formerCommandTable = {}
    alt, ctrl, meta, shift, left, right = 0, 0, 0, 0


   -- deactivate mouse icon
    boolLameDuck = false
	boolDraw = false
	
    local function restoreCursor(_, team)
        myTeam = Spring.GetMyTeamID()
        if myTeam == team then
            boolLameDuck = true
            oldCommand = Spring.GetActiveCommand()
            formerCommandTable[team] = oldCommand

            alt, ctrl, meta, shift = GetModKeys()
            local _, _, left, _, right = Spring.GetMouseState()
        end
    end

    function gadget:GameFrame(n)
        if boolLameDuck == true then
            Spring.SetActiveCommand(Spring.GetCmdDescIndex(CMD.WAIT), 1, left, right, alt, ctrl, meta, shift)
        end
    end

    local function hideCursor(_, team)
        myTeam = Spring.GetMyTeamID()
        if myTeam == team then
            boolLameDuck = false
            Spring.SetActiveCommand(formerCommandTable[team], 1, left, right, alt, ctrl, meta, shift)
        end
    end   

	local function ActivateSlowMoShadder(_, boolActivate)
		WG.boolDrawSlowMoVision = boolActivate;
    end


	
    gadgetHandler:AddSyncAction("Initialize", Initialize)
    gadgetHandler:AddSyncAction("ActivateSlowMoShadder", ActivateSlowMoShadder)
    gadgetHandler:AddSyncAction("restoreCursor", restoreCursor)
    gadgetHandler:AddSyncAction("hideCursor", hideCursor)
end
