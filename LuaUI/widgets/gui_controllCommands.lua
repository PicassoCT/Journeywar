
function widget:GetInfo()
	return {
		name = "gui_controllwindow",
		desc = "Displays BasicCommands",
		author = "PicassoCT",
		date = "2016-6-2",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
		hidden= false,
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
local activeCommand = 0

VFS.Include("LuaUI/widgets/guiEnums.lua")
VFS.Include("LuaUI/widgets/gui_libs/gui_helper.lua")
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------

local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits


if not WG.SelectedCommand then WG.SelectedCommand ={} end
playerID= Spring.GetMyPlayerID()
if not WG.SelectedCommand[playerID] then WG.SelectedCommand[playerID] ={} end
boolQueueOverride = false

BaseCol={0.1,0.8,0.8,1}
WeapCol={0.3,0.6,0.8,1}
BeanCol={0.3,0.6,0.8,0.6}
UpgCol={0.1,0.5,0.6,1}
texCol={0,0,0,1}
extHoloTexCol={200/255, 239/255, 253/255, 1}	
holoCommandCol={163/255, 229/255, 243/255, 0.75}	
holoTextCol={200/255, 239/255, 253/255, 1}	
backgroundColExtended={58/255, 172/255, 226/255, 0.75}	

extendedCommands={}
	extendedMenue={[CMD.RECLAIM] ={},
	[CMD.LOAD_UNITS]={},
	[CMD.UNLOAD_UNITS]={},
	[CMD.CLOAK]={},
	[CMD.RESTORE] ={},
	[CMD.OPT_SHIFT]={}
}

extendedMenue[CMD.RECLAIM] ={		
		triStrip={{x= 0, y = 0},			
		{x= 160, y = 40},
	{x= 0, y = 80}},
	backgroundCol=backgroundColExtended,
	caption="RECLAIM",
	callbackFunction=function()
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player]  =  CMD.RECLAIM 	
	end
}

extendedMenue[CMD.LOAD_UNITS] ={
		triStrip={{x= 160, y = 0},
		{x= 160, y = 80},			
	{x= 0, y = 40}	},
	backgroundCol=backgroundColExtended,
	caption=	"LOAD",
	callbackFunction=function()
			player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player] = CMD.LOAD_UNITS 			
	end
}
extendedMenue[CMD.UNLOAD_UNITS] ={
	triStrip={
		{x= 160, y = 40},
		{x= 160, y = 80},			
		{x= 0, y = 0},
	{x= 0, y = 40}	},
	backgroundCol=backgroundColExtended,
	caption=	"DROP",
	callbackFunction=function()
	player= Spring.GetMyPlayerID()
	WG.SelectedCommand[player]  =  CMD.UNLOAD_UNITS 
	end
}

extendedMenue[CMD.CLOAK] ={
		triStrip={	{x= 0, y = 0},			
		{x= 160, y = 40},
	{x= 0, y = 80}},
	backgroundCol=backgroundColExtended,
	caption= "CLOAK",
	callbackFunction=function()
		Spring.Echo("Cloaking")
		selectedUnits=spGetSelectedUnits();
		if selectedUnits and #selectedUnits > 0 then
				commandTable= getCommandTable(boolQueueOverride)			
			for i=1,#selectedUnits do
				state = Spring.GetUnitStates(selectedUnits[i])
				paramTable={}
				if state.cloak == true then paramTable={[1]=0};	else paramTable={[1]=1};	end
				Spring.GiveOrderToUnit(selectedUnits[i], CMD.CLOAK, paramTable, commandTable)
			end
		end		
	end
}	

extendedMenue[CMD.RESTORE] ={		
		triStrip={	{x= 100	, y = 15},
		{x= 100	, y = 70},			
	{x= 0	, y = 40}},
	backgroundCol=backgroundColExtended,
	caption= "RESTORE",
	callbackFunction=function()
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player] =  CMD.RESTORE 
	end
}	
extendedMenue[CMD.OPT_SHIFT] ={
		triStrip={	{x= 0, y = 0},			
		{x= 100, y = 30},
		{x= 0, y = 80},
	{x= 100, y = 80}},
	backgroundCol=backgroundColExtended,
	caption= "QUEUE",
	callbackFunction=function(self,...)
		self.backgroundCol ={163/255, 229/255, 243/255, 0.75} 
		boolQueueOverride = not boolQueueOverride
	end
}

MainMenue={
	[CMD.ATTACK]={},
	[CMD.STOP]={},
	[CMD.MOVE]={},
	[CMD.FIRE_STATE]={},
	[CMD.REPEAT]={},
	[CMD.MOVE_STATE]={},
	[CMD.REPAIR]={},
	[CMD.PATROL]={}		
}


function getCommandTarget()
	x,z=Spring.GetMouseState()
	return Spring.TraceScreenRay(x,z)
end

MainMenue[CMD.ATTACK] ={		
		triStrip={{x= 80, y = 0},			
		{x= 0, y = 0},
		{x= 80, y = 70},						
		{x= 0, y = 70},
	{x= 0, y = 100}}	,
	backgroundCol={163/255, 229/255, 243/255, 0.75},
	caption=	"|ATTAC",
}

MainMenue[CMD.STOP] ={
		triStrip={	{x= 70, y = -15},
		{x= 0, y = 10},			
		{x= 80, y = -5},
		
		{x= 0, y = 70},
		{x= 80, y = 80},
	{x= 70, y = 90}},
	backgroundCol={58/255, 172/255, 226/255, 0.75}	,
	caption="|STOP",	
}			

MainMenue[CMD.MOVE] ={
		triStrip={		{x= 0, y = -20},			
		{x= 80, y = 2.5},
		{x= 0, y = 70},
	{x= 80, y = 70}},
	backgroundCol={35/255, 124/255, 166/255, 0.75}		,
	caption=upByRow("|MOVE",2),
}	

MainMenue[CMD.FIRE_STATE] ={		
		triStrip={		{x= 0, y = 0},	
		{x= 80, y =0},
		{x= 0, y = 70},
	{x= 80, y = 70}},
	backgroundCol={52/255, 167/255, 222/255, 0.75},
	caption=upByRow("|FIRE\nSTATE",3),
}	

MainMenue[CMD.REPEAT] ={
		triStrip={		{x= 0, y = -15},			
		{x= 70, y =-15},
		{x= 0, y = 90},
	{x= 70, y = 110}},
	backgroundCol={52/255, 167/255, 222/255, 0.75}	,
	caption="|REPEAT ",
}	

MainMenue[CMD.MOVE_STATE] ={
		triStrip={		{x= 0, y = 5},			
		{x= 80, y =25},
		{x= 0, y = 70},
	{x= 80, y = 70}},
	backgroundCol={35/255, 124/255, 166/255, 0.75},
	caption= "MANOVEUR ",
}	

MainMenue[CMD.REPAIR] ={
		triStrip={		{x= 0, y = 0},			
		{x= 80, y = 0},
		{x= 0, y = 70},
	{x= 80, y = 48}},
	backgroundCol={163/255, 229/255, 243/255, 0.75},
	caption= upByRow("|REPAIR ",4),
}	

MainMenue[CMD.PATROL] ={
		triStrip={		{x= 0, y = -20},			
		{x= 70, y = -40},			
		{x= -10, y = -10},			
		{x= 80, y = -35},
		{x= -10, y = 95},
	{x= 80, y = 60}},
	backgroundCol={52/255, 167/255, 222/255, 0.75},
	caption=upByRow("|PATROL",4),
}	


MainMenue[CMD.GUARD] ={
		triStrip={		{x= 0, y = 5},			
		{x= 80, y = -25},
		{x= 0, y = 70},
	{x= 80, y = 70}},
	backgroundCol={52/255, 167/255, 222/255, 0.75},
	caption="|GUARD",
}	

MainMenue[CMD.ATTACK].callbackFunction= function()
		Spring.Echo("Selected Attack")
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player] =  CMD.ATTACK 

end
MainMenue[CMD.STOP].callbackFunction= function()
		Spring.Echo("Selected STOP")
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player]   =  CMD.STOP 
end
MainMenue[CMD.MOVE].callbackFunction= function() 
		Spring.Echo("Selected Move")
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player] =  CMD.MOVE 
end
MainMenue[CMD.FIRE_STATE].callbackFunction= function() 
		selectedUnits =Spring.GetSelectedUnits()
		if selectedUnits then
		states = Spring.GetUnitStates(selectedUnits[1])
		Spring.GiveOrderToUnitArray(selectedUnits, CMD.FIRE_STATE, {states.firestate % 3 + 1}, {})
		end
end
MainMenue[CMD.REPEAT].callbackFunction= function() 
		selectedUnits =Spring.GetSelectedUnits()
		if selectedUnits and selectedUnits[1] and Spring.GetUnitStates then
		states = Spring.GetUnitStates(selectedUnits[1])
		boolRepeatActive = not states["repeat"]
		Spring.GiveOrderToUnitArray(selectedUnits, CMD.REPEAT, {boolRepeatActive}, {})
		end
end

MainMenue[CMD.MOVE_STATE].callbackFunction= function()
	selectedUnits =Spring.GetSelectedUnits()
		if selectedUnits then
		states = Spring.GetUnitStates(selectedUnits[1])
		Spring.GiveOrderToUnitArray(selectedUnits, CMD.MOVE_STATE, {states.movestate % 3 + 1}, {})
		end
 end
MainMenue[CMD.REPAIR].callbackFunction= function() 
		Spring.Echo("Selected Repair")
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player]  =  CMD.REPAIR 
end
MainMenue[CMD.GUARD].callbackFunction= function() 	
		Spring.Echo("Selected Guard")	
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player] = CMD.GUARD
end

MainMenue[CMD.PATROL].callbackFunction= function() 	
		Spring.Echo("Selected Patrol")	
		player= Spring.GetMyPlayerID()		
		WG.SelectedCommand[player] = CMD.PATROL
end



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
	end
	
	
	for commandID,Option in pairs(extendedMenue) do
		extendedCommands[commandID] = createHabanero(Option.triStrip,
		Option.caption,
		Option.backgroundCol,
		extHoloTexCol,
		Option.callbackFunction		
		)		
		extendedCommands[commandID].Init()
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
			extendedCommands[CMD.RECLAIM],
			extendedCommands[CMD.LOAD_UNITS],
			extendedCommands[CMD.UNLOAD_UNITS],
			extendedCommands[CMD.CLOAK],
			extendedCommands[CMD.RESTORE],
			extendedCommands[CMD.OPT_SHIFT]
		},		
	}
	
	extendedCommand_window:AddChild(extendedCommand_Grid)
	
	Habaneros={ }
	
	for comandID,MenueOption in pairs(MainMenue) do
		Habaneros[comandID] = createHabanero(MenueOption.triStrip,
		MenueOption.caption,
		MenueOption.backgroundCol,
		holoTextCol,
		MenueOption.callbackFunction	
		)		
		Habaneros[comandID].Init()
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
			Habaneros[CMD.ATTACK],
			Habaneros[CMD.STOP],
			Habaneros[CMD.MOVE],
			Habaneros[CMD.FIRE_STATE],
			Habaneros[CMD.REPEAT],
			Habaneros[CMD.MOVE_STATE	],
			Habaneros[CMD.REPAIR],
			Habaneros[CMD.PATROL],
			Habaneros[CMD.GUARD],
			
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



function widgetHandler:MouseRelease(x, y, button)
	local mo = self.mouseOwner
	local mx, my, lmb, mmb, rmb = Spring.GetMouseState()
			Spring.Echo("MouseRelease active")
	if (not (lmb or mmb or rmb)) then
		return false
	end

	if lmb then
			alt, ctrl, meta, shift =GetModKeys()
			local _, _, left, _, right = Spring.GetMouseState()
			Spring.Echo("Command active")
			Spring.SetActiveCommand(WG.SelectedCommand[mo], 1, left, right, alt, ctrl, meta, shift)
			return true
	end
	
	if rmb and rmb == true then
		if WG.SelectedCommand[mo] then
			for command, active in pairs(WG.SelectedCommand[mo]) do
				if active == true then
					selectedUnits=Spring.GetSelectedUnits();
					if selectedUnits and #selectedUnits > 0 then
						commandTable= getCommandTable(boolQueueOverride)
						typeParam, param = getCommandTarget()
						Spring.Echo("Giving Command " .. command)
						Spring.GiveOrderToUnitArray(selectedUnits, command, param, commandTable)
						
						WG.SelectedCommand[mo] = nil
						break
					end
				end
			end
		end
		
		return true
	end
	
	return -1
end