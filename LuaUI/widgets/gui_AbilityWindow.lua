
--

local onOffButtonImage
local onOffButton
local SpecialAbilityButton
local upgradeGrid
local AmmoBar
local ExpBar
local imageDirComands = 'luaui/images/commands/'
local onoffTexture = {imageDirComands .. 'states/off.png', imageDirComands .. 'states/on.png'}

local function inflateUpgradeMenue()	
	if boolShowUpgrade== false then
	boolShowUpgrade=true

	Chili.Screen0:RemoveChild(upgradeGrid)
	
	else 
	boolShowUpgrade=false
	
	Chili.Screen0:AddChild(upgradeGrid)
	end
end


function updateAmmo()


end

function updateExp()

end

local function Create_ExpBar()
	
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
					OnChange = {updateExp},
							}	
end



local function Create_AmmoBar()
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
					OnChange = {updateAmmo},
							}	 						 
end

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
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "TANGLE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."TANGLE") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "AROCKET", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AROCKET") end}},
			Chili.Button:New{backgroundColor = {0.3,0.6,0.8,1}, textColor = {0.8,1,1,1}, caption = "GROCKET", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."GROCKET") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "EATER", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EATER") end}},	
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "", OnClick = {function ()  end}},
	
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "EJECTPOD", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EJECTPOD") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "AMMOFAC", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AMMOFAC") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "STEALTH", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."STEALTH") end}},
			Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "RADAR", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."RADAR") end}},
				},

		}
	

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
	
	
		ShowSpecialAbilityButton()
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


local function Create_UpgradeGrid()

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

local function Create_SpecialAbilityButton()
	SpecialAbilityButton = Button:New{
		name = unitDefID,
		x=5,
		y=100,
		caption='UPGRADE',
		width = 100,
		height = 60,
		backgroundColor = {0.1,0.8,0.8,1}, 
		textColor = {0.8,1,1,1},
		OnClick = {
			inflateUpgradeMenue
		},
	}
end



local function Create_OnOffButton()
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
function Create_AbilityButton()
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

end
local function ShowOnOffButton(texture)
	window_main:AddChild(onOffButton)
	onOffButtonImage.file = texture
	onOffButtonImage:Invalidate()
end

local function ShowSpecialAbilityButton(texture)
	window_main:AddChild(SpecialAbilityButton)
	window_main:AddChild(AmmoBar)
	window_main:AddChild(ExpBar)


end