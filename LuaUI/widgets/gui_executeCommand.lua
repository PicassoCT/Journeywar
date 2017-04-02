
function widget:GetInfo()
	return {
		name = "gui_execute Command",
		desc = "Gets selected Units - fitting to a command",
		author = "PicassoCT",
		date = "2016-6-2",
		license = "GNU GPL, v2 or later",
		layer = 254,
		enabled = true,
		hidden= true,
	}
end

VFS.Include("scripts/lib_UnitScript.lua")
include("LuaUI/widgets/guiEnums.lua")

  -- +-------------------------------+
  -- |       Selected GUI/Mode       |
  -- |       -Attack                 |
  -- |       |Move                   |
  -- |       -Patrol                 |
  -- +-------------------------------+
  -- +-------------------------------+
  -- |                               |
  -- |    Left Click or Right Click  |
  -- |                               |
  -- +-------------------------------+

  -- +-------------------------------+
  -- |  Unit selected:               |
  -- |  Filter out                   |
  -- +-------------------------------+
  -- +------------------------------+
  -- |Get Target                    |
  -- +------------------------------+
  -- +--------------------------------+
  -- |  Apply Command                 |
  -- +--------------------------------+
  
undoSelectionButton		=3
selectSelectionButton	=1
function widget:MousePress(x, y, button)
	Spring.Echo("Button released"..button)
	if button== selectSelectionButton or button== undoSelectionButton then
		return true
	end

end

function widget:Initialize()
		
			playerID=Spring.GetMyPlayerID()
			playerTeamID= Spring.GetMyTeamID()	
			if not WG.SelectedCommand then WG.SelectedCommand ={} end
			if not WG.SelectedCommand[playerID] then WG.SelectedCommand[playerID]={} end
			
for key,value in pairs(targetCommands)do
WG.SelectedCommand[playerID][key]=false
end

end


function widget:MouseRelease(x, y, button)

	if button == undoSelectionButton then
		for k,v in pairs(WG.SelectedCommand[playerID]) do
			WG.SelectedCommand[playerID][k]=false
		end
	end
	
	if  button == selectSelectionButton then
		commandID=0
		for key,value in pairs(WG.SelectedCommand[playerID]) do
				if value== true then
				commandID= key
				break
				end
			end
			
			playerID=Spring.GetMyPlayerID()
			playerTeamID= Spring.GetMyTeamID()	
			T =getSelectedUnits(playerID)
			T =filterUnits(T, commandID, playerID, playerTeamID, true) 			
		if not nonTargetCommands[commandID] then
			issueCommand(T,commandID, playerID, playerTeamID,x,y,false)		
		else
			issueCommand(T,commandID, playerID, playerTeamID,x,y,true)		
		end
	end
		
end
		