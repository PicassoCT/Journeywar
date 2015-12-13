-------------------------------------------------------------------------------

local version = "v0.002"

function widget:GetInfo()
  return {
    name      = "Journeywar GUI",
    desc      = version .. " - GUI.",
    author    = "CarRepairer",
    date      = "2013-08-22",
    license   = "GNU GPL, v2 or later",
    layer     = 1000,
	handler   = true,
    enabled   = false,
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



local guiPath='luaui/wdigets/'
local imageDir = 'luaui/images/'

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
boolStackNotEmpty=false
VFS.Include(guiPath.."gui_TacZone.lua", VFS.RAW_FIRST)
VFS.Include(guiPath.."gui_AbilityWindow.lua", VFS.RAW_FIRST)

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


function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end
	
	--Element Constructors 
	Create_TacZones()
	Create_OnOffButton()
	Create_SpecialAbilityButton()	
	Create_ExpBar()
	Create_AmmoBar()
	Create_UpgradeGrid()
	--Todo
	Create_MoveComandos()
	Create_ContextComandos()
	
end
