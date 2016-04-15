
function widget:GetInfo()
	return {
		name = "gui_ability_window",
		desc = "Displays Special Abilitys",
		author = "PicassoCT",
		date = "2011-6-2",
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

local boolShowUpgrade = false
local onOffButtonImage
local onOffButton = {}
local SpecialAbilityButton = {}
local upgradeGrid = {}
local AmmoBar = {}
local ExpBar = {}
local stack_main = {}
local activeButtons = {}

local imageDirComands = 'luaui/images/commands/'
local onoffTexture = {imageDirComands .. 'states/off.png', imageDirComands .. 'states/on.png'}
local selectedUnits = {}
local ability_window
local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits
 updateCommandsSoon = false

ability_window_height = 180
ability_window_width = 115
ability_window_positionX = "20%"
ability_window_positionY = "83%"

--subConstructors


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
	
		
	local function Create_UpgradeButton()
		SpecialAbilityButton = Button:New{
			name = unitDefID,
			x = 5,
			y = 100,
			caption = 'UPGRADE',
			width = 100,
			height = 60,
			backgroundColor = {0.1,0.8,0.8,1}, 
			textColor = {0.8,1,1,1},
			OnClick = {
				inflateUpgradeMenue
			},
		}
		
		
		
		stack_main:AddChild(SpecialAbilityButton)
		
		SpecialAbilityButton:Hide()
		
	end
	
	function Create_OnOffButton()
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
			name = "onOffButton",
			--tooltip = tooltip,
			x = 15,
			y = 90,
			caption = 'Ability',
			width = buttonsize,
			height = buttonsize,
			backgroundColor = {0.1,0.8,0.8,1}, 
			textColor = {0.8,1,1,1},
			OnClick = { onOffFunction },
			parent = stack_main	
		}
		
		onOffButtonImage = Image:New { 
			width = "90%";
			height = "90%";
			bottom = nil;
			y = "5%"; x = "15%";
			keepAspect = true,
			file = onoffTexture[1],
			parent = onOffButton,
		}
		
		if onOffButton then
		activeButtons["default"]=onOffButton
			onOffButton:Hide()
		end
	end
	

	
	local function CreateUpgradeMenue ()
		
		upgradeGrid = Chili.Grid:New{
			name = 'UpgradeGrid',
			width = 440,
			height = 330,
			color = {0,0,0,1},
			parent= screen0,
			
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
				Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "", OnClick = {function () end}},
				
				Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "EJECTPOD", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EJECTPOD") end}},
				Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "AMMOFAC", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AMMOFAC") end}},
				Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "STEALTH", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."STEALTH") end}},
				Chili.Button:New{backgroundColor = {0.1,0.5,0.6,1}, textColor = {0.8,1,1,1}, caption = "RADAR", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."RADAR") end}},
			},
			
		}
	
		if upgradeGrid then 
			upgradeGrid:Hide()	
		end
	end
	
	local function Create_UpgradeGrid()
		
		upgradeButton = 	Chili.Window:New{
			name = 'upgradeButton',
			caption = "UPGRADES ",
			textColor = {0.9,1,1,0.7},
			fontSize = 24,
			fontShadow = false,
			x = "65%",
			y = "25%",
			resizable = false,
			draggable = false,
			parent = stack_main,
			clientWidth = 430,
			clientHeight = 320,
			children = 
			{
				inflateComEndUpdateMenue()
			},
			
		}
		if upgradeButton then
			upgradeButton:Hide()
		end
		
	end
	
	
	local function inflateUpgradeMenue()	
		
		if boolShowUpgrade == false then
			boolShowUpgrade = true
			upgradeGrid.Show()
			
		else 
			boolShowUpgrade = false
			if upgradeGrid then
				upgradeGrid:Hide()
			end
		end
	end

	
	
	

	
	
	function HideAllActiveButtons()
		for k,v in pairs(activeButtons) do
			activeButtons[k]:Hide()
		end
	end
	
	function createAllButtons()
		Create_OnOffButton()
		Create_UpgradeButton()
		CreateUpgradeMenue()
	end
	
	
	
	--Actual initialisatioin Code
	stack_main = Grid:New{
		y = 20,
		padding = {0,0,0,0},
		itemPadding = {0, 0, 0, 0},
		itemMargin = {0, 0, 0, 0},
		width = '100%',
		height = '100%',
		resizeItems = false,
		orientation = 'horizontal',
		centerItems = false,
		columns = 2,
	}
	
	ability_window = Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		caption = 'Abilities',
		textColor = {0.9,1,1,0.7},
		name = "facpanel",
		x = ability_window_positionX, 
		y = ability_window_positionY,
		width = ability_window_width,
		height = ability_window_height,
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
			stack_main,			
		},
	}
	
	createAllButtons()
	
	
	
end

	function widget:CommandsChanged()
			Spring.Echo("Selction changed")
		updateCommandsSoon = true
		
	end

--update functions
function widget:GameFrame(f)
	
	local function updateAmmo()
		
		
	end
	
	local function updateExp()
		
	end
	
	local function Create_ExpBar()
		
		ExpBar = 			Chili.Progressbar:New
		{
			name = "ExpBar",
			x = 10,
			y = 60,
			width = 90,
			height = 35,
			value = 0,
			parent = stack_main,
			textColor = {0.8,1,1,1},
			color = {0.3,0.85,0.95,1},
			backgroundColor = {0.15,0.3,0.35,1},
			caption = "EXP ",
			OnChange = {updateExp},
		}	
		
	end
	
	
	local function ShowOnOffButton(typeString)

	
		activeButtons[typeString].Show()
		
	end
	

	local function ShowSpecialAbilityButton()
		onOffButton.Show()
		activeButtons[#activeButtons+1]= onOffButton	
	end
	
	local function Create_AmmoBar()
		AmmoBar = Chili.Progressbar:New
		{
			name = "AmmoBar",
			x = 10,
			y = 20,
			width = 90,
			height = 35,
			textColor = {0.8,1,1,1},
			color = {0.8,0.5,0.25,1},
			backgroundColor = {0.1,0.2,0.2,1},
			caption = "AMMO ",
			OnChange = {updateAmmo},
		}	
		
	end
	


		local unitTypeButtonMap = {
		--unitname --> Function Showing Button
		["ccomender"]	 = ShowSpecialAbilityButton,
		["default"] = ShowOnOffButton
	}
	
	function UpdateAbilitiesWindow()
		--	upgradeGrid.ClearChildren()
		selectedUnits = spGetSelectedUnits()
		
		if not selectedUnits then 
			Spring.Echo("No Unit selected")
			HideAllActiveButtons()
			return 
		end
		
		local unitID = selectedUnits[1]
		if not unitID then 
			Spring.Echo("No Unit selected")
			HideAllActiveButtons()
			return 
		end
		
		local udid = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[udid]
		
		--empty the upgrade Grid
		
		--adapt the button to unit
		if unitTypeButtonMap[ud.name] then
			--generate the Gui Specific by unittype
			unitTypeButtonMap[ud.name]()
			
		else
			unitTypeButtonMap["default"]("default")
		end
		
		
	end
	
	
	
	if updateCommandsSoon == true and (f % 16 == 0) then
		Spring.Echo("updateCommandsSoon")	
		updateCommandsSoon = false
		UpdateAbilitiesWindow()	
	end
end