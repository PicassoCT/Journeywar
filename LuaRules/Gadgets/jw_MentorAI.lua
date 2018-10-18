-- In-game, type /luarules kpai in the console to toggle the ai debug messages

function gadget:GetInfo()
    return {
        name = "Mentor AI:  Tutorial",
        desc = "Loads and runs a Tutorial",
        author = "Picassora",
        date = "around since last tuesday",
        license = "Licensed under the Recursive License: "..
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
	tutorialMapName = "Ravenholm"
   startscript = ""

    function gadget:Initialize()
		if not Game.mapName == tutorialMapName then
			Spring.Reload (startscript)
		end
	
    end
	
	function missionStateMachine(frame, framesSinceLastCall)
	
	
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