
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
local elementsToHide={}
local onOffButtonImage
local onOffButton = {}
local SpecialAbilityButton = {}
local upgrade_Grid = {}
local upgrade_window={}
local AmmoBar = {}
local ExpBar = {}
local stack_main = {}
local ButtonsTable = {}
local activeElements={}

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
upgrade_window_height= 180
upgrade_window_width= 880
upgrade_window_positionX = "28%"
upgrade_window_positionY = "83%"


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
	
		
	function Create_UpgradeButton()
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
				showComEndUpgradeMenue
			},
		}
			
		stack_main:AddChild(SpecialAbilityButton)
		if SpecialAbilityButton then
		ButtonsTable["ability"]=SpecialAbilityButton
		SpecialAbilityButton:Hide()
		end
	
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
			parent= stack_main,
			OnClick = { onOffFunction },
		}
	
		stack_main:AddChild(onOffButton)
		
		if onOffButton then
			ButtonsTable["defaultOnOff"]=onOffButton
			onOffButton:Hide()
		end
	end
	 
	function CreateUpgradeMenue ()

	upgrade_window = Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		textColor = {0.9,1,1,0.7},
		name = "upgrade_window",
		x = upgrade_window_positionX, 
		y = upgrade_window_positionY,
		width = upgrade_window_width,
		height = upgrade_window_height,
		parent = screen0,
		draggable = false,
		tweakDraggable = false,
		tweakResizable = false,
		resizable = false,
		dragUseGrip = false,
		minWidth = math.ceil(upgrade_window_width*0.75),
		minHeight = math.ceil(upgrade_window_height*0.75),
		color = {0.1,0.7,0.85,0.42},
		backgroundColor= {0.1,0.2,0.6,0.32},
		children = {},
	}

	BaseCol={0.1,0.8,0.8,1}
	WeapCol={0.3,0.6,0.8,1}
	UpgCol={0.1,0.5,0.6,1}
	texCol={0.8,1,1,1}
	upgrade_Grid = Grid:New{
				x= 200,
				y = 200,
				padding = {0,0,0,0},
				itemPadding = {0, 0, 0, 0},
				itemMargin = {0, 0, 0, 0},
				width = '100%',
				height = '100%',
				resizeItems = true,		
				orientation = 'horizontal',
				centerItems = false,
				columns = 8,		
				name = 'UpgradeGrid',
				width = 880,
				height = 180,
				color = {0,0,0,1},
			
			children = {
				Chili.Button:New{backgroundColor = BaseCol, textColor = texCol, caption = "SPEED", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SPEED") end}},
				Chili.Button:New{backgroundColor = BaseCol, textColor = texCol, caption = "ARMOR", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."ARMOR") end}},
				Chili.Button:New{backgroundColor = BaseCol, textColor = texCol, caption = "STABILITY", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."STABILITY") end}},
				Chili.Button:New{backgroundColor = BaseCol, textColor = texCol, caption = "AMMO", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AMMO") end}},
				Chili.Button:New{backgroundColor = BaseCol, textColor = texCol, caption = "SENSORS", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SENSORS") end}},
				
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "SHOTGUN", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SHOTGUN") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "SUBMG", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SUBMG") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "SNIPER", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SNIPER") end}},
								
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "GRENADE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."GRENADE") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "SLICER",OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."SLICER") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "FLARE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."FLARE") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "TANGLE", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."TANGLE") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "AROCKET", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AROCKET") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "GROCKET", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."GROCKET") end}},
				Chili.Button:New{backgroundColor = WeapCol, textColor = texCol, caption = "EATER", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EATER") end}},	
				
				Chili.Button:New{backgroundColor = UpgCol, textColor = texCol, caption = "EJECTPOD", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."EJECTPOD") end}},
				Chili.Button:New{backgroundColor = UpgCol, textColor = texCol, caption = "AMMOFAC", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."AMMOFAC") end}},
				Chili.Button:New{backgroundColor = UpgCol, textColor = texCol, caption = "STEALTH", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."STEALTH") end}},
				Chili.Button:New{backgroundColor = UpgCol, textColor = texCol, caption = "RADAR", OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|".."RADAR") end}},
			},		
		}
		upgrade_window:AddChild(upgrade_Grid)
		
		if upgrade_window  then 
			upgrade_window:Hide()	
		end
	end
	
	function Create_UpgradeGrid()
		
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
				showComEndUpgradeMenue()
			},
			
		}
		if upgradeButton then
			upgradeButton:Hide()
		end
		
	end
local 	function HideAllActiveElements()
		for k,element in pairs(activeElements)  do
			element.Hide()
		end
	end
		
	function showComEndUpgradeMenue()	
		
		if boolShowUpgrade == false then
			boolShowUpgrade = true
			upgrade_window:Show()
			activeElements["ComEndUpgradeMenue"]  = upgrade_window
			
		else 
			boolShowUpgrade = false
			if upgrade_Grid then
				HideAllActiveElements()
			end
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
		columns = 1,
		
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

--subConstructors
function widget:CommandsChanged()
		Spring.Echo("Update is coming")
		updateCommandsSoon = true		
	end

--update functions
function widget:GameFrame(f)
	
	local function ShowOnOffButton(typeString)
	if not ButtonsTable[typeString] then typeString = "defaultOnOff" end
	
		ButtonsTable[typeString]:Show()
		activeElements[typeString]=ButtonsTable[typeString]
	end
	
	local function ShowSpecialAbilityButton()
		ButtonsTable["ability"]:Show()
		activeElements["ability"]=ButtonsTable["ability"]
	end

	local unitTypeButtonMap = {
		--unitname --> Function Showing Button
		["ccomender"]	 	= ShowSpecialAbilityButton,
		["default"] 		= ShowOnOffButton
	}
	
	function isUnitOnOffable(unitDefID_T)
		local index = Spring.GetCmdDescIndex(CMD.ONOFF)
			if index then
				return true
			end
		return false
	end
	
	function UpdateAbilitiesWindow()
	
		selectedUnits = spGetSelectedUnits()
		
		if not selectedUnits then 
			HideAllActiveElements()
			return 
		end
		
		local unitID = selectedUnits[1]
		if not unitID then 
			HideAllActiveElements()
			return 
		end
		
		local udid = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[udid]
		
		--empty the upgrade Grid
		
		--adapt the button to unit
		if unitTypeButtonMap[ud.name] then
			--generate the Gui Specific by unittype
			unitTypeButtonMap[ud.name]()		
		elseif isUnitOnOffable(ud.name)== true then
			unitTypeButtonMap["default"]("default")
		else
			--default no button
			HideAllActiveElements()
		end
	end
	
	if updateCommandsSoon == true and (f % 16 == 0) then
		Spring.Echo("updateCommandsSoon")	
		updateCommandsSoon = false
		UpdateAbilitiesWindow()	
	end
end