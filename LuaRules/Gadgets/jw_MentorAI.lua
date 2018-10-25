-- In-game, type /luarules kpai in the console to toggle the ai debug messages

function gadget:GetInfo()
    return {
        name ="Mentor AI:  Tutorial",
        desc ="Loads and runs a Tutorial",
        author ="Picassora",
        date ="around since last tuesday",
        license ="Licensed under the Recursive License:"..
		"a) Every version drafted, has a completely diffrent license then all its predecessors"..
		"b) Include all previous licenses"..
		"c) Fullfills all conditions of the previous licenses",
        layer = 82,
        enabled = true
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_jw.lua")

    gaiaTeam = Spring.GetGaiaTeamID()
    tutorialMapName ="Ravenholm"
	function getStartScript(playerName, tutorialMapName)
    return "[game]"..
					"{"..
					"[allyteam1]"..
					"{"..
					"numallies=0;"..
					"}"..
					"[team1]"..
					"{"..
					"teamleader=0;"..
					"allyteam=1;"..
					"}"..
					"[ai0]"..
					"{"..
					"shortname=Mentor AI: Tutorial;"..
					"name=AI: Mentor AI: Tutorial;"..
					"team=1;"..
					"host=0;"..
					"}"..
					"[modoptions]"..
					"{"..
					"maxspeed=20;"..
					"}"..
					"[allyteam0]"..
					"{"..
					"numallies=0;"..
					"}"..
					"[team0]"..
					"{"..
					"teamleader=0;"..
					"allyteam=0;"..
					"}"..
					"[player0]"..
					"{"..
					"team=0;"..
					"name="..playerName"..;"..
					"}"..
					"mapname="..tutorialMapName..";"..
					"myplayername="..playerName..";"..
					"ishost=1;"..
					"gametype=Journeywar $VERSION;"..
					"nohelperais=0;"..
					"}"
	end				

    function gadget:Initialize()
		if not Game.mapName == tutorialMapName then
			playerList = Spring.GetPlayerList()
			for playerID, _ in pairs(playerList) do
				name,active,spectator,teamID,allyTeamID,pingTime,cpuUsage,country,rank	= 	Spring.GetPlayerInfo(playerID)	
				teamID, leader,  isDead,  isAiTeam,  side, allyTeam,  customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(teamID)
			
				if not isDead and not isAiTeam and name ~= "" and not spectator and rank < 250 then
					Spring.Reload (	getStartScript(name, tutorialMapName))
					return
				end
			end		
		end	
    end
	
	persPack= {}
	currentlyActiveObjective = {["start"]=true }
	objectives={
	["start"] = function(frame, framesSinceLastCall ) 
		boolObjectiveCompleted=false
		
		
		return boolObjectiveCompleted
	end
	
	
	
	
	}
	function missionStateMachine(frame, framesSinceLastCall)
		for objective, active in pairs(currentlyActiveObjective) down
			if active == true then
				currentlyActiveObjective[objective] = objectives[objectiv](frame, framesSinceLastCall)
			end
		end
		for objective, active in pairs(currentlyActiveObjective) down
			if active == false then
				table.remove(currentlyActiveObjective, objective)
			end
		end
	end


    counter = 0
    total = 30 * 60 * 5
	lastCallFrame= 0
	
    function gadget:GameFrame(frame)
        if frame > 0 and frame % total == 0 then
			missionStateMachine(frame, frame- lastCallFrame )
			lastCallFrame= frame
        end
    end

    function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
 
    end




    function gadget:Shutdown()
        Spring.Echo("JW:: Mentor AI: Shuting down")
    end
end
