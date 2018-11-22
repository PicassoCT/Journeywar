
function widget:GetInfo()
	return {
		name = "gui_controllwindow",
		desc = "Displays BasicCommands",
		author = "PicassoCT",
		date = "2016-6-2",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
		hidden = false
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
local	base_stack 
updateRequired = false
local ignoreCMDs = {
	timewait=true,
	deathwait=true,
	squadwait=true,
	gatherwait=true,
	loadonto=true,
}
targetCommands = VFS.Include("LuaUI/ressources/guiEnums.lua")
VFS.Include("LuaUI/ressources/gui_helper.lua")
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
holoCommandCol={163/255, 229/255, 243/255, 0.65}	
holoTextCol={200/255, 239/255, 253/255, 1}	
backgroundColExtended={0.2, 0.2, 0.4, 0.6} 
genericFocusColor={163/255, 229/255, 243/255, 0.75}
stateTriColor = {{245/255,64/255,9/255, 0.6},
				{24/255,238/255,191/255, 0.6},
				{27/255,234/255,31/255, 0.6}
				}

function ActionCommand(self, x, y, button, mods) 
	local index = Spring.GetCmdDescIndex(self.cmdID)
	if index then
		local left, right = (button == 1), (button == 3)
		local alt, ctrl, meta, shift = mods.alt, mods.ctrl, mods.meta, mods.shift
		Spring.SetActiveCommand(index, button, left, right, alt, ctrl, meta, shift)
	end
end

function StateCommand(self,  x, y, button, mods)

--
--state out of how many States
--Get Majority State of all seleceted Units, up that state by one and show
-- update caption
--Set Colour

if self.name == "statebutton_cloak" then
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
	
if self.name == "statebutton_fire" then
	if selectedUnits and #selectedUnits > 0 then
			commandTable= getCommandTable(boolQueueOverride)			
			for i=1,#selectedUnits do
				state = Spring.GetUnitStates(selectedUnits[i])
				paramTable={}
				if state.cloak == true then paramTable={[1]=0};	else paramTable={[1]=1};	end
				Spring.GiveOrderToUnit(selectedUnits[i], CMD.CLOAK, paramTable, commandTable)
			end
		end		
	self.caption = "|FIRE_STATE\n".. self.cmd.params[self.cmd.params[1] + 2]
end	

if self.name == "statebutton_move" then
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

if self.name == "statebutton_optshift" then

end	

if self.name == "statebutton_repeat" then

end	



end


extendedCommands={}
extendedMenue={
	[CMD.RECLAIM] ={},
	[CMD.LOAD_UNITS]={},
	[CMD.UNLOAD_UNITS]={},
	[CMD.CLOAK]={},
	[CMD.RESTORE] ={},
	[CMD.OPT_SHIFT]={}
}


extendedMenue[CMD.LOAD_UNITS] ={
		triStrip={	{x= 160, y = 0},
		{x= 160, y = 80},			
	{x= 0, y = 40}	},
	
	caption=	"LOAD",
	active =false,
	name= "orderbutton_load",
	cmdID = CMD.LOAD_UNITS,
	OnMouseUp = {ActionCommand}
}
extendedMenue[CMD.UNLOAD_UNITS] ={
	triStrip={
		{x= 0, y = 0},
		{x= 160, y = 40},			
		{x= 0, y = 80},
	},
	
	caption=	"DROP",
	active =false,
	cmdID = CMD.UNLOAD_UNITS ,
	name= "orderbutton_unload",
	OnMouseUp = {ActionCommand}
	
}

extendedMenue[CMD.CLOAK] ={
	triStrip={	
		{x= 100, y = 5},			
		{x= 0, y = 35},
		{x= 100, y = 85},
	{x= 0, y = 55}},
	name = "statebutton_cloak",
	caption= "CLOAK",
	OnMouseUp = {StateCommand}
	
}	

extendedMenue[CMD.RECLAIM] ={		
	triStrip={
		{x= 0, y = 10},			
		{x= 160, y = 60},
		{x= 0, y = 70},
		{x= 160, y = 70}		
	},
	
	caption="RECLAIM",
	active =false,
	cmdID = CMD.RECLAIM ,
	name= "orderbutton_reclaim",
	OnMouseUp = {ActionCommand}
}

extendedMenue[CMD.RESTORE] ={		
	triStrip={	
		{x= 0	, y = 20},
		{x= 160	, y = 20},			
		{x= 0	, y = 60},
		{x= 160	, y = 60}		
	},
	
	caption= "RESTORE",
	active =false,
	cmdID = CMD.RESTORE ,
	name= "orderbutton_restore",
	OnMouseUp = {ActionCommand}
}	
extendedMenue[CMD.OPT_SHIFT] ={
	triStrip={	
		{x= 0, y = 0},			
		{x= 100, y = 25},
		{x= 0, y = 80},
	{x= 100, y = 50}},
	
	caption= "QUEUE",
	active = false,
	cmdID = CMD.OPT_SHIFT ,
	name= "statebutton_optshift",
	OnMouseUp= {StateCommand}
	
	
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
	triStrip={
		{x= 80, y = 0},			
		{x= 0, y = 0},
		{x= 80, y = 70},						
		{x= 0, y = 70},
	{x= 0, y = 100}}	,
	focusColor={163/255, 229/255, 243/255, 0.75},
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption=	"|ATTAC",
	active =false,
	cmdID = CMD.ATTACK ,
	name= "orderbutton_attack",
	OnMouseUp = {ActionCommand}
}

MainMenue[CMD.STOP] ={
	triStrip={	
		{x= 70, y = -15},
		{x= 0, y = 10},			
		{x= 80, y = -5},		
		{x= 0, y = 70},
		{x= 80, y = 80},
	{x= 70, y = 90}},
	focusColor={58/255, 172/255, 226/255, 0.75}	,
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption="|STOP",	
	active =false,
	cmdID = CMD.STOP ,
	name= "orderbutton_stop",
	OnMouseUp = {ActionCommand}
}			

MainMenue[CMD.MOVE] ={
	triStrip={		
		{x= 0, y = -40},			
		{x= 80, y = -10},
		{x= 0, y = 70},
	{x= 80, y = 70}},
	focusColor={35/255, 124/255, 166/255, 0.75}		,
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption=upByRow("|MOVE",2),
	active =false,
	cmdID = CMD.MOVE ,
	name= "orderbutton_move",
	OnMouseUp = {ActionCommand}
}	

MainMenue[CMD.FIRE_STATE] ={		
	triStrip={		
		{x= 0, y = 0},	
		{x= 80, y =0},
		{x= 0, y = 70},
	{x= 80, y = 70}},
	focusColor={52/255, 167/255, 222/255, 0.75},
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption=upByRow("|FIRE\nSTATE",3),
	active =false,
	cmdID = CMD.MOVE ,
	name= "statebutton_fire",
	OnMouseUp = {StateCommand}
}	

MainMenue[CMD.REPEAT] ={
	triStrip={		
		{x= 0, y = -15},			
		{x= 70, y =-15},
		{x= 0, y = 90},
	{x= 70, y = 110}},
	focusColor={52/255, 167/255, 222/255, 0.75}	,
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption="|REPEAT ",
	active =false,
	cmdID = CMD.REPEAT ,
	name= "statebutton_repeat",
	OnMouseUp = {StateCommand}
}	

MainMenue[CMD.MOVE_STATE] ={
	triStrip={		
		{x= 0, y = -20},			
		{x= 80, y =5},
		{x= 0, y = 45},
	{x= 80, y = 75}},
	focusColor={35/255, 124/255, 166/255, 0.75},
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption= "|MOVE\nMODE ",
	active =false,
	cmdID = CMD.MOVE_STATE ,
	name= "statebutton_move",
	OnMouseUp = {ActionCommand}
}	

MainMenue[CMD.REPAIR] ={
	triStrip={		
		{x= 0, y = 0},			
		{x= 80, y = 0},
		{x= 0, y = 90},
		{x= 80, y = 60}},
	focusColor={163/255, 229/255, 243/255, 0.75},
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption= upByRow("|REPAIR ",4),
	active =false,
	cmdID = CMD.REPAIR ,
	name= "orderbutton_repair",
	OnMouseUp = {ActionCommand}
}	

MainMenue[CMD.PATROL] ={
	triStrip={		
		{x= 0, y = 0},			
		{x= 80, y = 0},			
		{x= 0, y = 90},			
		{x= 80, y = 90}		
	},
	focusColor={52/255, 167/255, 222/255, 0.75},
	backgroundColor = {0.1, 0.2, 0.3, 0.5},
	caption=upByRow("|PATROL",4),
	active =false,
	cmdID = CMD.PATROL ,
	name= "orderbutton_patrol",
	OnMouseUp = {ActionCommand}
}	


MainMenue[CMD.GUARD] ={
		triStrip={		{x= 0, y = 5},			
		{x= 80, y = -25},
		{x= 0, y = 70},
	{x= 80, y = 70}},

	caption="|GUARD",
	active =false,
	cmdID = CMD.GUARD ,
	name= "orderbutton_guard",
	OnMouseUp = {ActionCommand}
}	


controllCommand_window_height = "30%"
controllCommand_window_width = "15%"
controllCommand_window_positionX = "0%"
controllCommand_window_positionY = "70%"


extendedCommand_window_positionX = "0%" 
extendedCommand_window_positionY= "36%"
extendedCommand_window_width= "9%"
extendedCommand_window_height= "35%"

function widget:Initialize()
	
	--Spring.SendCommands("hideinterface 1")
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
	
	function createHabanero(HabaneroDescriptor,  Parent )
		
		
		
		functionOnClick = 	 function () Spring.Echo("The HabaneroButton"..HabaneroDescriptor.caption .." is pressed into service") end
		
		return 	Chili.HabaneroButton:New{
			triStrip=	HabaneroDescriptor.triStrip	,
			name= HabaneroDescriptor.name,
			caption= HabaneroDescriptor.caption,
			parent= Parent,
			backgroundColor = HabaneroDescriptor.backgroundColor,
			activeColor = HabaneroDescriptor.activeColor,
			focusColor = HabaneroDescriptor.focusColor,
			textColor = HabaneroDescriptor.textColor, 
			OnClick= { functionOnClick}
		}
		
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
		draggable = true,
		tweakDraggable = true,
		tweakResizable = true,
		resizable = true,
		dragUseGrip = true,
		dockable = true,
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
		name = 'extended Comand Grid',
		width = '100%',
		height = '100%',
		parent =extendedCommand_window,
		minItemHeight =	 '21%',
		maxItemHeight =	 '32%',
		
		color = {0,0,0,1},
		
		children = {
		},		
	}

	
	--generic attributes
	for commandID,HabaneroDescriptor in pairs(extendedMenue) do
		HabaneroDescriptor.backgroundColor= HabaneroDescriptor.backgroundColor or 	backgroundColExtended
		HabaneroDescriptor.passiveColor =	 HabaneroDescriptor.passiveColor or	 	backgroundColExtended
		HabaneroDescriptor.numberOfStates =	 HabaneroDescriptor.numberOfStates or	 	 0
		HabaneroDescriptor.currentState = 	 HabaneroDescriptor.currentState or 	 	0
		HabaneroDescriptor.textColor=		 HabaneroDescriptor.textColor or		 	extHoloTexCol
		HabaneroDescriptor.focusColor=		 HabaneroDescriptor.focusColor or		 		genericFocusColor
	end
	
	for commandID,HabaneroDescriptor in pairs(extendedMenue) do
		extendedCommands[commandID] = createHabanero(
		HabaneroDescriptor,
		extendedCommand_Grid		
		)		
		extendedCommands[commandID]:Init()
	end
	
	
	extendedCommand_Grid:AddChild(extendedCommands[CMD.RECLAIM])
	extendedCommand_Grid:AddChild(extendedCommands[CMD.LOAD_UNITS])
	extendedCommand_Grid:AddChild(extendedCommands[CMD.UNLOAD_UNITS])
	extendedCommand_Grid:AddChild(extendedCommands[CMD.CLOAK])
	extendedCommand_Grid:AddChild(extendedCommands[CMD.RESTORE])
	extendedCommand_Grid:AddChild(extendedCommands[CMD.OPT_SHIFT])
	
	extendedCommand_window:AddChild(extendedCommand_Grid)
	
	Habaneros={ }
	
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
		draggable = true,
		tweakDraggable = true,
		tweakResizable = true,
		resizable = true,
		dragUseGrip = true,
		dockable = true,
		--minWidth = 50,
		--minHeight = 50,
		color = {0,0,0,1},
		
		children = {			
		},
	}
	
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
		parent =controllCommand_window,
		children={			
		}
	}
	
	--defaults
	for comandID,MenueDescriptor in pairs(MainMenue) do
		MenueDescriptor.focusColor = 	MenueDescriptor.focusColor  or	{52/255, 167/255, 222/255, 0.75}
		MenueDescriptor.backgroundColor = 	MenueDescriptor.backgroundColor  or	 {0.1, 0.2, 0.3, 0.5}
	end	
	
	for comandID,MenueDescriptor in pairs(MainMenue) do
		Habaneros[comandID] = createHabanero(
		MenueDescriptor,
		base_stack
		)		
		Habaneros[comandID]:Init()
	end
	
	base_stack:AddChild(Habaneros[CMD.ATTACK])
	base_stack:AddChild(Habaneros[CMD.STOP])
	base_stack:AddChild(Habaneros[CMD.MOVE])
	base_stack:AddChild(Habaneros[CMD.FIRE_STATE])
	base_stack:AddChild(Habaneros[CMD.REPEAT])
	base_stack:AddChild(Habaneros[CMD.MOVE_STATE])
	base_stack:AddChild(Habaneros[CMD.REPAIR])
	base_stack:AddChild(Habaneros[CMD.PATROL])
	base_stack:AddChild(Habaneros[CMD.GUARD])	
end




function widgetHandler:MouseRelease(x, y, button)
	local mo = self.mouseOwner
	Spring.Echo("Mouse Owner: "..mo)
	
	local mx, my, lmb, mmb, rmb = Spring.GetMouseState()
	Spring.Echo("MouseRelease active")
	if (not (lmb or mmb or rmb)) then
		return false
	end
	
	if lmb then
		alt, ctrl, meta, shift =GetModKeys()
		local x, y, lmb, mmb, rmb, outsideSpring = Spring.GetMouseState()
		command = 1
		if WG.SelectedCommand[mo] then
			command = Spring.GetCmdDescIndex(WG.SelectedCommand[mo])
		end
		Spring.SetActiveCommand(command, 1, lmb, rmb, alt, ctrl, meta, shift)
		
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
	
	return true
end

function TraverseCmd(cmd)
	for i= 1, #extendedCommand_Grid.children do
     if cmd.id == command then
		
		end
	end	
	
	for i= 1, #base_stack.children do
		if cmd.id == command then
		
		end
	end
	
	
end

function setAllHabanerosPassive()
	for i= 1, #extendedCommand_Grid.children do
      extendedCommand_Grid.children[i].passive = true
	end	
	
	for i= 1, #base_stack.children do
		base_stack.children[i].passive = true
	end
end

function widget:CommandsChanged()
	updateRequired = true -- the active cmd descs haven't changed yet; wait until the next widget:Update
end

function ParseCmds()
	setAllHabanerosPassive()
	-- go over all menuebuttons and find them inside the active cmds 
	--set either
	--active
	-- passive
	--selected
	--updateStateButtonsColoursAndCaption
	
	local cmds = Spring.GetActiveCmdDescs()
	for _,cmd in ipairs(cmds) do
		if cmd.name ~= '' and not (ignoreCMDs[cmd.name] or ignoreCMDs[cmd.action]) then
			TraverseCmd(cmd)
		end
	end
	
end


function widget:Update()
	if updateRequired then
		ParseCmds()
		updateRequired = false
	end
end

function widget:Shutdown()
	Spring.SendCommands("hideinterface 0")
end