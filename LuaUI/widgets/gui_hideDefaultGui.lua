function widget:GetInfo()
  return {
    name      = "Hides the default interface (classic handler version)",
    desc      = "",
    author    = "gajop, Bluestone",
    date      = "",
    license   = "GPL-v2",
    layer     = math.huge;
    enabled   = true,
   
    hidden    = true; -- don't show in the widget selector
    api       = true; -- load before all others?
  }
end
 
function widget:Initialize()
  --widgetHandler:RegisterGlobal("LayoutButtons", DummyLayoutHandler)
  widgetHandler:ConfigLayoutHandler(DummyLayoutHandler)
  Spring.ForceLayoutUpdate()
 
  Spring.SendCommands("Console 0")
  Spring.SendCommands("ResBar 0")
  Spring.SendCommands("ToolTip 0")
  Spring.SendCommands("Clock 0")
  Spring.SendCommands("Info 0")
  Spring.SendCommands("Fps 0")
 
  gl.SlaveMiniMap(true)
  gl.ConfigMiniMap(-1,-1,-1,-1)
end
 
local function DummyLayoutHandler(xIcons, yIcons, cmdCount, commands)
  widhetHandler.commands   = commands
  widhetHandler.commands.n = cmdCount
  widhetHandler:CommandsChanged()
  return "", xIcons, yIcons, {}, {}, {}, {}, {}, {}, {}, {}
end
 
function widget:GameSetup()
  -- sets status instantly to ready & hides the pre-game UI
  -- you might want/need to change this part & integrate it into your spawning gadget!
  return true, true
end