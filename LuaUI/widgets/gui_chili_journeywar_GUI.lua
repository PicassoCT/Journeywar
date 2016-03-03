-------------------------------------------------------------------------------


function widget:GetInfo()
local version = "v0.002"

  return {
    name      = "Journeywar GUI",
    desc      = version .. " - JourneyWar GUI Cortex",
    author    = "PicassoCT",
    date      = "2013-08-22",
    license   = "GNU GPL, v2 or later",
    layer     = math.huge,
	handler   = true,
    enabled   = true,
  }
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


local Chili
local Button
local Label
local Window
local StackPanel
local Grid
local TextBox
local Image
local Progressbar
local Panel
local screen0

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local jwGui ={}

local includes = {
  "gui_TacZone.lua",
  "gui_AbilityWindow.lua"
}


for _, file in ipairs(includes) do
  VFS.Include("luaui/widgets/" .. file, jwGui, VFS.RAW_FIRST)
end


if jwGui and not jwGui.imageDir then
jwGui.imageDir = 'luaui/images/'
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
boolStackNotEmpty=false
local boolShowUpgrade=false
local stack_main
local echo = Spring.Echo

local spGetUnitDefID      = Spring.GetUnitDefID
local spGetSelectedUnits  = Spring.GetSelectedUnits

local selectedUnits = {}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- callins
function widget:MousePress(x,y,button)	
	if button== 1 and boolStackNotEmpty ==true then
	_,World=Spring.TraceScreenRay(x,y,true)
	if World then
		pop(World[1],World[3])
	end 
	end	
end	
	
	
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- callins

local updateCommandsSoon = false
function widget:CommandsChanged()
	updateCommandsSoon = true
	
end


--update functions
function widget:GameFrame(f)
	if updateCommandsSoon and (f % 16 == 0) then
		selectedUnits = spGetSelectedUnits()
		updateCommandsSoon = false
		UpdateAbilitiesWindow()	
	end
end

--Loads the Gui Elements
function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		Spring.Echo("JW: Gui Initialize Shutdown")
		return
	end
	local chili = WG.Chili
	--Element Constructors 
	tacZoneWindow = jwGui.TacZone
	tacZoneWindow.Create_TacZoneWindow(chili)
	
	jwGui.Create_SpecialAbilityButton()	
	Create_OnOffButton()	
	Create_ExpBar()
	Create_AmmoBar()
	Create_UpgradeGrid()
	--Todo
	Create_MoveComandos()
	Create_ContextComandos()
	
end
