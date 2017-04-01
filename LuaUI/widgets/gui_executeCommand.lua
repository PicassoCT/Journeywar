
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


undoSelectionButton		=0
selectSelectionButton	=1
function widget:MouseRelease(x, y, button)
	if button == undoSelectionButton then
		for k,v in pairs(WG.SelectedCommand[playerID]) do
			WG.SelectedCommand[playerID][k]=false
		end
	end
	
	if WG.AtLeastOneSelection== true and button == selectSelectionButton then
		commandID=0
		for key,value in pairs(WG.SelectedCommand[playerID]) do
				if value== true then
				commandID= key
				break
				end
			end

		playerID=Spring.GetMyPlayerID()
		playerTeamID= Spring.GetMyTeamID
		T =getSelectedUnits(playerID)
		T =filterUnits(T, commandID, playerID, playerTeamID, true) 
		issueCommand(T,commandID, playerID, playerTeamID,x,y)		
		
	end
		
end
		