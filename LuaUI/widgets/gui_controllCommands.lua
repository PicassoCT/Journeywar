
function widget:GetInfo()
	return {
		name = "gui_controllwindow",
		desc = "Displays BasicCommands",
		author = "PicassoCT",
		date = "2016-6-2",
		license = "GNU GPL, v2 or later",
		layer = 253,
		enabled = false,
		hidden= true,
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
BaseCol={0.1,0.8,0.8,1}
WeapCol={0.3,0.6,0.8,1}
BeanCol={0.3,0.6,0.8,0.6}
UpgCol={0.1,0.5,0.6,1}
texCol={0,0,0,1}

extendedCommands={}
exttriStrip={}
exttriStrip[1] ={		
	{x= 0, y = 0},			
	{x= 160, y = 40},
	{x= 0, y = 80}
}

exttriStrip[2] ={
	{x= 160, y = 0},
	{x= 160, y = 80},			
	{x= 0, y = 40},
	
}

exttriStrip[3] ={
	{x= 0, y = 0},			
	{x= 160, y = 40},
	{x= 0, y = 80}
}	

exttriStrip[4] ={		
	{x= 100	, y = 15},
	{x= 100	, y = 70},			
	{x= 0	, y = 40},
}	
exttriStrip[5] ={
	{x= 0, y = 0},			
	{x= 100, y = 30},
	{x= 0, y = 80},
	{x= 100, y = 80},
}
extHoloTexCol={200/255, 239/255, 253/255, 1}	

triStrip={}
holoCommandCol={163/255, 229/255, 243/255, 0.75}	
holoTextCol={200/255, 239/255, 253/255, 1}	
backgroundCol={}
for i=1, 9 do
	triStrip[i] ={
		{x= 80, y = 0},			
		{x= 0, y = 0},
		{x= 80, y = 70},						
		{x= 0, y = 70},
		{x= 0, y = 100},
		
		
	}
	backgroundCol[i]={35/255, 124/255, 166/255, 0.75}
end
function getCommandTarget()
	x,z=Spring.GetMouseState()
	return Spring.TraceScreenRay(x,z)
end
function getCommandTable()
	returnT={}
	local alt, ctrl, shift, right = Spring.GetModKeyState()
	
	if alt then table.insert(returnT,"alt")end
	if ctrl then table.insert(returnT,"ctrl")end
	if shift then table.insert(returnT,"shift")end
	if right then table.insert(returnT,"right")end
	return returnT
end
triStrip[1] ={		
	{x= 80, y = 0},			
	{x= 0, y = 0},
	{x= 80, y = 70},						
	{x= 0, y = 70},
	{x= 0, y = 100},
}
backgroundCol[1]={163/255, 229/255, 243/255, 0.75}	

triStrip[2] ={
	{x= 70, y = -15},
	{x= 0, y = 10},			
	{x= 80, y = -5},
	
	{x= 0, y = 70},
	{x= 80, y = 80},
	{x= 70, y = 90},
}
backgroundCol[2]={58/255, 172/255, 226/255, 0.75}					

triStrip[3] ={
	{x= 0, y = -20},			
	{x= 80, y = 2.5},
	{x= 0, y = 70},
	{x= 80, y = 70},
}	

backgroundCol[3]={35/255, 124/255, 166/255, 0.75}		

triStrip[4] ={		
	{x= 0, y = 0},	
	{x= 80, y =0},
	{x= 0, y = 70},
	{x= 80, y = 70},
}	

backgroundCol[4]={52/255, 167/255, 222/255, 0.75}	
triStrip[5] ={
	{x= 0, y = -15},			
	{x= 70, y =-15},
	{x= 0, y = 90},
	{x= 70, y = 110},
}	

backgroundCol[5]={52/255, 167/255, 222/255, 0.75}	

triStrip[6] ={
	{x= 0, y = 5},			
	{x= 80, y =25},
	{x= 0, y = 70},
	{x= 80, y = 70},
}	
backgroundCol[6]={35/255, 124/255, 166/255, 0.75}	

triStrip[7] ={
	{x= 0, y = 0},			
	{x= 80, y = 0},
	{x= 0, y = 70},
	{x= 80, y = 48},
}	
backgroundCol[7]={163/255, 229/255, 243/255, 0.75}	

triStrip[8] ={
	{x= 0, y = -20},			
	{x= 70, y = -40},			
	{x= -10, y = -10},			
	{x= 80, y = -35},
	{x= -10, y = 95},
	{x= 80, y = 60},
}	
backgroundCol[8]={52/255, 167/255, 222/255, 0.75}	

triStrip[9] ={
	{x= 0, y = 5},			
	{x= 80, y = -25},
	{x= 0, y = 70},
	{x= 80, y = 70},
}	
backgroundCol[9]={52/255, 167/255, 222/255, 0.75}	

function upByRow(str,num)
	for i=1,num do
		str=str.."\n"
	end
	return str
end
eAttac		=1
eStop		=2
eMove		=3
eFire		=4
eRepeat		=5
eManouver	=6
eRepair		=7
ePatrol		=8
eGuard		=9

caption={
	[1]="|ATTAC",
	[2]="|STOP",
	[3]=upByRow("|MOVE",2),
	[4]=upByRow("|FIRE\nSTATE",3),
	[5]="|REPEAT ",
	[6]="MANOVEUR ",
	[7]=upByRow("|REPAIR ",4),
	[8]=upByRow("|PATROL",4),
	[9]="|GUARD",
}


controllCommand_window_height = "30%"
controllCommand_window_width = "15%"
controllCommand_window_positionX = "0%"
controllCommand_window_positionY = "70%"


extendedCommand_window_positionX = "0%" 
extendedCommand_window_positionY= "41%"
extendedCommand_window_width= "10%"
extendedCommand_window_height= "30%"

		
		
		
		
		
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
	
	
function createHabanero(triStrip, caption, basCol, textCol, functionOnClick )
	functionOnClick = functionOnClick or 	 function () Spring.Echo("The HabaneroButton"..caption .." is pressed into service") end
	
	return 	Chili.HabaneroButton:New{
		triStrip=triStrip	,
		caption=caption,
		
		backgroundColor = basCol,
		textColor = textCol, 
		OnClick= { functionOnClick}
	}
end--main Constructors
	extCallbackFunctions = {
			[1]= function()
				selectedUnits=spGetSelectedUnits();
				if selectedUnits and #selectedUnits > 0 then
					commandTable= getCommandTable()
					typeParam, param = getCommandTarget()
					for i=1,#selectedUnits do
						Spring.GiveOrderToUnit(selectedUnits[i],CMD.RECLAIM, param, commandTable)
					end
				end
			end,
			[2]= function()Spring.Echo("Hi Drop")end,
			[3]= function()Spring.Echo("Hi Cloak")end,
			[4]= function()Spring.Echo("Hi Restore")end,
			[5]= function()Spring.Echo("Hi QUEUE")end,

			
		}
		extcaption={
			[1]="RECLAIM",
			[2]="DROP\nLOAD",
			[3]="CLOAK",		
			[4]="RESTORE",		
			[5]="QUEUE",		
		}
		
	
		for i= 1, 5 do

			extendedCommands[i] = createHabanero(exttriStrip[i],
			extcaption[i],
			backgroundCol[2],
			extHoloTexCol,
			extCallbackFunctions[i]		
			)		
			extendedCommands[i].Init()
		end
	
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
		color = {0.1,0.7,0.85,0.42},
		backgroundColor= {0.1,0.2,0.6,0.32},
		children = {
			
		},
	}
	
	
	extendedCommand_Grid = Grid:New{
		x= 0,
		y = 0,
		padding = {5,5,5,5},
		itemPadding = {0, 0, 0, 0},
		itemMargin = {0, 0, 0, 0},
		--autosize =true,
		--weightedResize =true,
		resizeItems = true,		
		orientation = 'horizontal',
		centerItems = false,
		columns = 1,	
		rows = 6,
		name = 'UpgradeGrid',
		width = '100%',
		height = '100%',
		
		minItemHeight =	 '21%',
		maxItemHeight =	 '32%',
		
		color = {0,0,0,1},
		
		children = {
					extendedCommands[1],
					extendedCommands[2],
					extendedCommands[3],
					extendedCommands[4],
					extendedCommands[5],
					extendedCommands[6]
					},
		
		}
		
extendedCommand_window:AddChild(extendedCommand_Grid)

Habaneros={ }
HabaneroCallbackFunctions={}
HabaneroCallbackFunctions[eAttac]= function () end
HabaneroCallbackFunctions[eStop]= function () end
HabaneroCallbackFunctions[eMove]= function () end
HabaneroCallbackFunctions[eFire]= function () end
HabaneroCallbackFunctions[eRepeat]= function () end
HabaneroCallbackFunctions[eManouver	]= function () end
HabaneroCallbackFunctions[eRepair]= function () end
HabaneroCallbackFunctions[ePatrol]= function () end
HabaneroCallbackFunctions[eGuard]= function () end

for i=1, 9 do
	Habaneros[i] = createHabanero(triStrip[i],
	caption[i],
	backgroundCol[i],
	holoTextCol,
	HabaneroCallbackFunctions[i]		
	)		
	Habaneros[i].Init()
end

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
	children={
		Habaneros[eAttac],
		Habaneros[eStop],
		Habaneros[eMove],
		Habaneros[eFire],
		Habaneros[eRepeat],
		Habaneros[eManouver	],
		Habaneros[eRepair],
		Habaneros[ePatrol],
		Habaneros[eGuard],
		
	}
}



controllCommand_window = Window:New{
	padding = {3,3,3,3,},
	dockable = true,
	caption = '',
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
	--minWidth = 50,
	--minHeight = 50,
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