
function widget:GetInfo()
	return {
		name = "gui_controllwindow",
		desc = "Displays BasicCommands",
		author = "PicassoCT",
		date = "2016-6-2",
		license = "GNU GPL, v2 or later",
		layer = math.huge,
		enabled = true,
	}
end


--Shared Data
local Chili
local Button
local Label
local Window
local Panel
local Image
local Progressbar
local screen0

local testIrregular

local imageDirComands = 'luaui/images/commands/'
local onoffTexture = {imageDirComands .. 'states/off.png', imageDirComands .. 'states/on.png'}
local selectedUnits = {}
local controllCommand_window

local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits
 updateCommandsSoon = false

controllCommand_window_height = 255
controllCommand_window_width =  310
controllCommand_window_positionX = 0
controllCommand_window_positionY = "75%"


extendedCommand_window_positionX = "0%" 
extendedCommand_window_positionY= "45%"
extendedCommand_window_width= 220
extendedCommand_window_height= 220
--main Constructors
function widget:Initialize()
	
	
	-- setup Chili
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

	extendedCommand_window = Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		textColor = {0.9,1,1,0.7},
		name = "extendedCommandWindow",
		x = extendedCommand_window_positionX, 
		y = extendedCommand_window_positionY,
		width = extendedCommand_window_width,
		height =extendedCommand_window_height,
		parent = screen0,
		draggable = false,
		tweakDraggable = false,
		tweakResizable = false,
		resizable = false,
		dragUseGrip = false,
		minWidth = math.ceil(extendedCommand_window_width*0.75),
		minHeight = math.ceil(extendedCommand_window_height*0.75),
		color = {0.1,0.7,0.85,0.42},
		backgroundColor= {0.1,0.2,0.6,0.32},
		children = {},
	}

	BaseCol={0.1,0.8,0.8,1}
	WeapCol={0.3,0.6,0.8,1}
	UpgCol={0.1,0.5,0.6,1}
	texCol={0.8,1,1,1}
	extendedCommand_Grid = Grid:New{
				x= 0,
				y = 0,
				padding = {5,5,5,5},
				itemPadding = {0, 0, 0, 0},
				itemMargin = {0, 0, 0, 0},
				--autosize =true,
				--weightedResize  =true,
				resizeItems = true,		
				orientation = 'horizontal',
				centerItems = true,
				columns = 3,	
				rows = 3,
				name = 'UpgradeGrid',
				width = 630,
				height = 140,

				  minItemHeight =	 '21%',
				  maxItemHeight =	 '32%',
				
				color = {0,0,0,1},
			
				children = {},		
		}
		extendedCommand_window:AddChild(extendedCommand_Grid)
		
		
	testIrregular= 	Chili.Irregular:New{
						nGone={
						{x= 2*35, y = 2*35},
						{x= 2*15, y = 2*15},
						{x= 0, y = 2*30},
						{x= 2*-15, y = 2*-15},
						{x= 2*-15, y = 2*15},
						{x= 0, y = 2*-30}
		
						},
						caption= "WTF",
						
								backgroundColor = BaseCol,
								textColor = texCol, 

								OnClick = {function () Spring.Echo("The first nGone was pressed") end}
					}
					
	testIrregular.GetSizeFromNGone()	
	
	base_stack = Grid:New{
		y = 20,
		padding = {5,5,5,5},
		itemPadding = {0, 0, 0, 0},
		itemMargin = {0, 0, 0, 0},
		width = '100%',
		height = '100%',
		resizeItems = true,	
		autosize=true,		
		orientation = 'vertical',
		centerItems = false,
		columns = 3,
		rows= 3,
		children={Chili.Button:New{
								
								width=buttonwidth,
								height = buttonheigth, 
								backgroundColor = BaseCol,
								textColor = texCol, 
								caption = "11", 								
								},
								Chili.Button:New{
								
								width=buttonwidth,
								height = buttonheigth, 
								backgroundColor = BaseCol,
								textColor = texCol, 
								caption = "12", 
								
								},
								Chili.Button:New{
								
								width=buttonwidth,
								height = buttonheigth, 
								backgroundColor = BaseCol,
								textColor = texCol, 
								caption = "13", 
							
								},
								testIrregular
								
								}
		
	}
	
	

	controllCommand_window = Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		caption = 'BaseCommands',
		textColor = {0.9,1,1,0.7},
		name = "controllCommand_window",
		x = controllCommand_window_positionX, 
		y = controllCommand_window_positionY,
		width = controllCommand_window_width,
		height = controllCommand_window_height,
		parent = screen0,
		draggable = false,
		tweakDraggable = true,
		tweakResizable = true,
		resizable = false,
		dragUseGrip = false,
		minWidth = 50,
		minHeight = 50,
		color = {0,0,0,1},
		
		
		children = {			
			base_stack,			
		},
	}
		

end

--subConstructors
function widget:CommandsChanged()
end

--update functions
function widget:GameFrame(f)
	

end