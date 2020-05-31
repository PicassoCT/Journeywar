function widget:GetInfo()
  return {
    name      = "Hides the default interface ",
    desc      = "",
    author    = "gajop, Bluestone",
    date      = "",
    license   = "GPL-v2",
    layer     = 0,
    enabled   = true,
   
    -- hidden    = true, -- don't show in the widget selector
     api       = true; -- load before all others?
  }
end
 
 local handler = (widget and widgetHandler)
 local function dummylayouthandler(xIcons, yIcons, cmdCount, commands) --gets called on selection change
    widgetHandler.commands = commands
    widgetHandler.commands.n = cmdCount
    widgetHandler:CommandsChanged() --call widget:CommandsChanged()
    local iconList = {[1337]=9001}
    local custom_cmdz = widgetHandler.customCommands
    return "", xIcons, yIcons, {}, custom_cmdz, {}, {}, {}, {}, {}, iconList
  end
    
 local function hijacklayout()

  handler:ConfigLayoutHandler(dummylayouthandler) --override default build/ordermenu layout
  
  handler:RegisterGlobal("LayoutButtons", dummylayouthandler)
 
  Spring.ForceLayoutUpdate()
end
 
function widget:Initialize() 

  Spring.SendCommands("Console 0")
  Spring.SendCommands("ResBar 0")
  Spring.SendCommands("ToolTip 0")
  Spring.SendCommands("Clock 0")
  Spring.SendCommands("Info 0")
  Spring.SendCommands("Fps 0")


  -- gl.SlaveMiniMap(true)
  -- gl.ConfigMiniMap(-1,-1,-1,-1)
end


 

function widget:GameSetup()
  hijacklayout()
  -- sets status instantly to ready & hides the pre-game UI
  -- you might want/need to change this part & integrate it into your spawning gadget!
  return true, true
end