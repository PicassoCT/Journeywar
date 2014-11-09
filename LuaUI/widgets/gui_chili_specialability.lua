-------------------------------------------------------------------------------

local version = "v0.001"

function widget:GetInfo()
  return {
    name      = "TacZone & Special Abilitys",
    desc      = version .. " - Control Unit Abilities.",
    author    = "CarRepairer",
    date      = "2013-08-22",
    license   = "GNU GPL, v2 or later",
    layer     = 1000,
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




local imageDir = 'LuaUI/Images/'
local AZTex = {imageDir .. 'taczone/action.png'}
local rzTex = {imageDir .. 'taczone/reservoire.png'}
local tzTex = {imageDir .. 'taczone/trigger.png'}
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
boolStackNotEmpty=false


local boolShowUpgrade=false
local window_main, stack_main
local echo = Spring.Echo

local spGetUnitDefID      = Spring.GetUnitDefID
local spGetSelectedUnits  = Spring.GetSelectedUnits

local push        = table.insert

local selectedUnits = {}

local onOffButtonImage
local onOffButton
local comenderButton
local upgradeGrid
local AmmoBar
local ExpBar
local imageDir = 'LuaUI/Images/commands/'
local onoffTexture = {imageDir .. 'states/off.png', imageDir .. 'states/on.png'}



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--functions


local function inflateControllGrid ()




	return Chili.Grid:New{
		--name = 'foogrid',
		width = 440,
		height = 330,
		color = {0,0,0,1},
		
		
		children = {
			Chili.Button:New{backgroundColor = {0.1,0.8,0.8,1}, textColor = {0.8,1,1,1}, caption = "SPEED", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SPEED") end}},
			Chili.Button:New{backgroundColor = {0.1,0.8,0.8,1}, textColor = {0.8,1,1,1}, caption = "ARMOR", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."ARMOR") end}},
			Chili.Button:New{backgroundColor = {0.1,0.8,0.8,1}, textColor = {0.8,1,1,1}, caption = "STABILITY", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."STABILITY") end}},
			Chili.Button:New{backgroundColor = {0.1,0.8,0.8,1}, textColor = {0.8,1,1,1}, caption = "AMMO", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AMMO") end}},
			Chili.Button:New{backgroundColor = {0.1,0.8,0.8,1}, textColor = {0.8,1,1,1}, caption = "SENSORS", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SENSORS") end}},
			
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "SHOTGUN", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SHOTGUN") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "SUBMG", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SUBMG") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "SNIPER", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SNIPER") end}},

			
		
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "GRENADE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."GRENADE") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "SLICER",OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SLICER") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "FLARE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."FLARE") end}},
		    Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "SUNBURST", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SUNBURST") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "TANGLE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."TANGLE") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "AROCKET", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AROCKET") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "GROCKET", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."GROCKET") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "EATER", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EATER") end}},
	
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "EJECTPOD", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EJECTPOD") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "AMMOFAC", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AMMOFAC") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "STEALTH", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."STEALTH") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "RADAR", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."RADAR") end}},
				},

		}
	

	end

--functions

	
	LastCommandStack={}
	function pop(xCoords,zCoords)
		if #LastCommandStack> 0 then
		t=LastCommandStack[#LastCommandStack]
		table.remove(LastCommandStack,#LastCommandStack)
			if table.getn(LastCommandStack) == 0 then boolStackNotEmpty=false end
		--Get a ScreenRay and Attach the coords
		Spring.SendLuaRulesMsg(t..xCoords.."|"..zCoords)
		end
	end
	
	function push(Command)
	boolStackNotEmpty=true
	LastCommandStack[#LastCommandStack+1]=Command	
	end

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
	
	
function addGrid()

end	

function removeGrid()

end	
	
local function ShowComenderMenu()
	echo 'ShowComenderMenu'
	
		

	
	if boolShowUpgrade== false then
	boolShowUpgrade=true

	Chili.Screen0:RemoveChild(upgradeGrid)
	
	else 
	boolShowUpgrade=false
	
	Chili.Screen0:AddChild(upgradeGrid)
--	Chili.Screen0:UpdateClientArea()

	end


	
end

local function MakeUpgradeGrid()

upgradeGrid =	Chili.Window:New{
		
				caption="UPGRADES                                  ",
				textColor = {0.9,1,1,0.7},
				fontSize=24,
				fontShadow = false,
				x = "65%",
				y = "25%",
				resizable = false,
				draggable = false,
			
				clientWidth = 430,
				clientHeight = 320,
				children = 
				{
				inflateControllGrid()
				},
		
		}

end

local function MakeComenderButton()
	comenderButton = Button:New{
		name = unitDefID,
		x=5,
		y=100,
		caption='UPGRADE',
		width = 100,
		height = 60,
		backgroundColor = {0.1,0.8,0.8,1}, 
		textColor = {0.8,1,1,1},
		OnClick = {
			ShowComenderMenu
		},
	}
end

local function MakeAmmoBar()
	AmmoBar=Chili.Progressbar:New
							{
					x     = 10,
					y     = 20,
					width= 90,
					height=35,
					textColor = {0.8,1,1,1},
					color = {0.8,0.5,0.25,1},
					backgroundColor = {0.1,0.2,0.2,1},
					caption = "AMMO ",
					OnChange = {OnChange},
							}	 
							 
					 
							 
end

local function MakeExpBar()
	
	ExpBar=			Chili.Progressbar:New
							{
					x     = 10,
					y     = 60,
					width= 90,
					height=35,
					value=0,
					textColor = {0.8,1,1,1},
					color = {0.3,0.85,0.95,1},
					backgroundColor = {0.15,0.3,0.35,1},
					caption = "EXP ",
					OnChange = {OnChange},
							}	
end

local function MakeOnOffButton()
	local buttonsize = 80
	
	local onOffFunction = function()
		local _,_,left,_,right = Spring.GetMouseState()
		local alt,ctrl,meta,shift = Spring.GetModKeyState()
		local index = Spring.GetCmdDescIndex(CMD.ONOFF)
		if index then
			Spring.SetActiveCommand(index,1,left,right,alt,ctrl,meta,shift)
		end
	end
	
	onOffButton = Button:New{
		name = unitDefID,
		--tooltip=tooltip,
		x=15,
		y=90,
		caption='',
		width = buttonsize,
		height = buttonsize,
		backgroundColor = {0.1,0.8,0.8,1}, 
		textColor = {0.8,1,1,1},
		OnClick = { onOffFunction },
	}
	onOffButtonImage = Image:New {
		width="90%";
		height= "90%";
		bottom = nil;
		y="5%"; x="5%";
		keepAspect = true,
		file = onoffTexture[1];
		parent = onOffButton;
	}
end

local function ShowOnOffButton(texture)
	window_main:AddChild(onOffButton)
	onOffButtonImage.file = texture
	onOffButtonImage:Invalidate()
end

local function ShowComenderButton(texture)
	window_main:AddChild(comenderButton)
	window_main:AddChild(AmmoBar)
	window_main:AddChild(ExpBar)


end



local function UpdateAbilitiesWindow()
	window_main:ClearChildren()

	
	
	local unitID = selectedUnits[1]
	if not unitID then 
	Chili.Screen0:RemoveChild(upgradeGrid)
	return 
	end

	local udid = spGetUnitDefID(unitID)
	local ud = UnitDefs[udid]
	
	if ud.name == 'ccomender' then
	
	
		ShowComenderButton()
		return
	end
	
	local commands = widgetHandler.commands
	for i = 1, #commands do
		local cmd = commands[i]
		if cmd.id == CMD.ONOFF then
			local texture = onoffTexture[cmd.params[1]+1]
			ShowOnOffButton(texture)
		end
	
	boolShowUpgrade=true
	Chili.Screen0:RemoveChild(upgradeGrid)
	
	
	end
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- callins

local updateCommandsSoon = false
function widget:CommandsChanged()
	updateCommandsSoon = true
	
end



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

	stack_main = Grid:New{
		y=20,
		padding = {0,0,0,0},
		itemPadding = {0, 0, 0, 0},
		itemMargin = {0, 0, 0, 0},
		width='100%',
		height = '100%',
		resizeItems = false,
		orientation = 'horizontal',
		centerItems = false,
		columns=2,
	}

	window_main = Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		caption = 'Abilities',
		textColor = {0.9,1,1,0.7},
		name = "facpanel",
		right = '-10%', y = "30%",
		width  = 115,
		height = 180,
		parent = Chili.Screen0,
		draggable = false,
		tweakDraggable = true,
		tweakResizable = true,
		resizable = false,
		dragUseGrip = false,
		minWidth = 50,
		minHeight = 50,
		color = {0,0,0,1},
		
		
		
		children = {
			
					stack_main,
			
	
		
		},
	}
	
	
	TZButton=Chili.Button:New{
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
			
			TZButtonImage = Image:New {
			width="100%";
			height= "100%";
			bottom = nil;
			y="0%"; 
			x="0%";
			keepAspect = true,
			file = tzTex[1];
			parent = TZButton;			
				}
							
		AZButton=Chili.Button:New
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
		 	 AZButtonImage = Image:New {
			width="90%";
			height= "90%";
			bottom = nil;
			y="0%"; 
			x="0%";
			keepAspect = true,
			file = AZTex[1];
			parent = AZButton;			
				}
				
			RZButton=Chili.Button:New
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
			
			RZButtonImage = Image:New {
			width="90%";
			height= "90%";
			bottom = nil;
			y="0%"; x="0%";
			keepAspect = true,
			file = rzTex[1];
			parent = RZButton;			
				} 

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
		TZButton,
		AZButton,
		RZButton,
		},
		
		}
	
	TacZone_main = Window:New{
		padding = {5,5,5,5,},
		dockable = true,
		caption = 'TacZone',
		--textColor = {0.45,0.8,0.98,0.9},
		textColor = {0.6,0.8,0.91,0.9},
		name = "TacZonePanel",
		right = '-10%', 
		y = "10%",
		width  = 72,
		height =182,
		parent = Chili.Screen0,
		draggable = false,
		tweakDraggable = true,
		tweakResizable = true,
		--clientWidth = 200,
		--clientHeight = 96,
		resizable = false,
		dragUseGrip = false,
		minWidth = 72,
		minHeight = 182,
		color = {0.1,0.1,0.15,1},
		backgroundColor = {0.35,0.61,0.8,0.8},
		children = 
		{ 
		button_rack,
		}
	}
		
	TacZone_deco = Window:New{
		padding = {0,0,0,0,},
		dockable = true,
		caption = '',
		--textColor = {0.45,0.8,0.98,0.9},
		textColor = {0.6,0.8,0.91,0.9},
		name = "TacDeco",
		right = '4.2%', 
		y = "23%",
		width  = 15,
		height =15,
		parent = Chili.Screen0,
		draggable = false,
		tweakDraggable = true,
		tweakResizable = true,
		--clientWidth = 200,
		--clientHeight = 96,
		resizable = false,
		dragUseGrip = false,
		minWidth = 10,
		minHeight = 65,
		color = {0.1,0.1,0.15,1},
		backgroundColor = {0.35,0.61,0.8,0.8},
	
	}
	
	TacZone_deco2 = Window:New{
		padding = {0,0,0,0,},
		dockable = true,
		caption = '',
		--textColor = {0.45,0.8,0.98,0.9},
		textColor = {0.6,0.8,0.91,0.9},
		name = "TacDeco2",
		right = '0%', 
		y = "42%",
		width  = 5,
		height =5,
		parent = Chili.Screen0,
		draggable = false,
		tweakDraggable = true,
		tweakResizable = true,
		--clientWidth = 200,
		--clientHeight = 96,
		resizable = false,
		dragUseGrip = false,
		minWidth = 10,
		minHeight = 265,
		color = {0.1,0.1,0.15,1},
		backgroundColor = {0.35,0.61,0.8,0.8},
	
	}

	
	
	MakeOnOffButton()
	MakeComenderButton()
	MakeExpBar()
	MakeAmmoBar()
	MakeUpgradeGrid()
end
