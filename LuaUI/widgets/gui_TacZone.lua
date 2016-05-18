
function widget:GetInfo()
	local version = "v0.002"
	
	return {
		name = "gui_tacZone",
		desc = version .. " - JourneyWar GUI Cortex",
		author = "PicassoCT",
		date = "2013-08-22",
		license = "GNU GPL, v2 or later",
		layer = 255,
		enabled = true -- loaded by default?
	}
end


local Chili
local Button
local Label
local Window
local Panel
local Image
local Progressbar
local screen0

imageDir = "luaui/images/"
classname= "taczone"
caption = 'button'
local LastCommandStack={}

--action of the GUI

boolStackNotEmpty=false

local echo = Spring.Echo

-------------------------------------------------------------------------------

tacZone_window_height = "25%"
tacZone_window_width = "4%"
tacZone_window_positionX= "15%"
tacZone_window_positionY= "75%"

-------------------------------------------------------------------------------

--Create 
function widget: Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end
	
	Chili = WG.Chili
	Button = Chili.Button
	Label = Chili.Label
	Window = Chili.Window
	StackPanel = Chili.StackPanel
	Grid = Chili.Grid
	TextBox = Chili.TextBox
	Image = Chili.Image
	Progressbar = Chili.Progressbar
	Panel = Chili.Panel
	screen0 = Chili.Screen0
	
	azTex = {imageDir .. 'taczone/action.png'}
	rzTex = {imageDir .. 'taczone/reservoire.png'}
	tzTex = {imageDir .. 'taczone/trigger.png'}
	--TacZone ButtonGrid
	button_rack = Grid:New{
		--		y=42,
		padding = {5,3,3,5},
		itemPadding = {0, 0, 0, 0},
		itemMargin = {0, 0, 0, 0},
		width='90%',
		height = '100%',
		y=10,
		resizeItems = false,
		orientation = 'vertical',
		centerItems = false,
		columns=1,
		children = 
		{ 
			TacZoneButton,
			ActionZoneButton,
			ReservoirZoneButton,
		},
		
	}
	
	--TacZone Button
	TacZoneButton=Chili.Button:New{
		backgroundColor = {0.1,0.8,0.8,1},
		textColor = {0.8,1,1,1}, 			
		caption = "", 
		
		isDisabled=false,
		parent=button_rack,
		width="60%",
		height= "33%",
		x = 29,
		y = 35,
		minWidth =48,
		minHeight =48,
		OnClick = {function () push("DEA|TZ|") end}
	}
	
	TacZoneButtonImage = Image:New {
		width="100%",
		height= "100%",
		bottom = nil,
		y="0%", 
		x="0%",
		keepAspect = true,
		file = tzTex[1],
		parent = TacZoneButton,			
	}
	--ActionZone Button					
	ActionZoneButton=Chili.Button:New
	{
		backgroundColor = {0.1,0.8,0.8,1}, 
		textColor = {0.8,1,1,1}, 
		caption = "", 
		parent=button_rack,
		width="50%",
		height= "33%",
		x = 91,
		y = 35,
		minWidth =48,
		minHeight =48,
		OnClick = {function () push("DEA|AZ|") end}
	}
	
	ActionZoneButtonImage = Image:New {
		width="90%",
		height= "90%",
		bottom = nil,
		y="0%", 
		x="0%",
		keepAspect = true,
		file = azTex[1],
		parent = ActionZoneButton,			
	}
	--Reservoir Zone Button	
	ReservoirZoneButton=Chili.Button:New
	{
		backgroundColor = {0.1,0.8,0.8,1}, 
		textColor = {0.8,1,1,1}, 
		caption = "",
		parent=button_rack,
		width="50%",
		height= "33%",
		x = 145,
		y = 35,
		minWidth =48,
		minHeight =48,
		OnClick = {function () push("DEA|RZ|") end}
	}
	
	ReservoirZoneButtonImage = Image:New {
		width="90%",
		height= "90%",
		bottom = nil,
		y="0%",
		x="0%",
		keepAspect = true,
		file = rzTex[1],
		parent = ReservoirZoneButton,			
	} 
	
	
	TacZone_main = Window:New{
		padding = {5,5,5,5,},
		dockable = true,
		caption = 'TacZone',
		--textColor = {0.45,0.8,0.98,0.9},
		textColor = {0.6,0.8,0.91,0.9},
		name = "TacZonePanel",
		x = tacZone_window_positionX,
		y = tacZone_window_positionY,
		width = tacZone_window_width,
		height =tacZone_window_height,
		parent = Chili.Screen0,
		draggable = false,
		tweakDraggable = true,
		tweakResizable = true,
		--clientWidth = 200,
		--clientHeight = 96,
		resizable = false,
		dragUseGrip = false,		
		color = {0.1,0.1,0.15,1},		
		backgroundColor = {0.35,0.61,0.8,0.8},
		children = 
		{ 
			button_rack,
		}
	}
	
	
end

-- callins
function widget:MousePress(x,y,button)	
	if button== 1 and boolStackNotEmpty ==true then
		_,World=Spring.TraceScreenRay(x,y,true)
		if World then
			pop(World[1],World[3])
		end 
	end	
end	

function pop(xCoords,zCoords)
	if #LastCommandStack> 0 then
		t= LastCommandStack[#LastCommandStack]
		table.remove( LastCommandStack,#LastCommandStack)
		if table.getn( LastCommandStack) == 0 then boolStackNotEmpty=false end
		--Get a ScreenRay and Attach the coords
		Spring.SendLuaRulesMsg(t..xCoords.."|"..zCoords)
	end
end


function push(Command)
	boolStackNotEmpty=true
	LastCommandStack[# LastCommandStack+1]=Command	
end