
function widget:GetInfo()
	return {
		name = "Abilitys, Upgrade & Build Gui",
		desc = "Displays Special Abilitys & Buildoptions",
		author = "PicassoCT",
		date = "2011-6-2",
		license = "GNU GPL, v2 or later",
		layer = 256,
		hidden= true,
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
local activeAbilityElements={}
local exp_bar= {}
local ammo_bar	= {}

local imageDirComands = 'luaui/images/commands/'
local onoffTexture = {imageDirComands .. 'states/off.png', imageDirComands .. 'states/on.png'}
local selectedUnits = {}

local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits
updateCommandsSoon = false

defaultCaptionByUnitType = VFS.Include('LuaUI/ressources/ability_captions.lua')

local ability_window = {}

ability_window.height = "23%"--180
ability_window.height_numeric =180
ability_window.width = "7%"--115
ability_window.width_numeric = 115
ability_window.positionX = "19%"
ability_window.positionY = "77%"

upgrade_window.height= "25%"
upgrade_window.height_numeric= 300
upgrade_window.width= "40%"
upgrade_window.width_numeric= 300
upgrade_window.positionX = "36%"
upgrade_window.positionY = "80%"

local CentrailButtonBackground = {0.1,0.8,0.8,1}
local CentrailTextColour = {0.8,1,1,1}
local AbilityWindowTextColour = {0.9,1,1,0.7}

local JourneyButtonBackground = {0.1,0.8,0.8,1}
local JourneyTextColour = {0.8,1,1,1}

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
			backgroundColor = CentrailButtonBackground, 
			textColor = CentrailTextColour,
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
	
	function Create_OnOffButton(side)
		local buttonsize = 80
		
		local onOffFunction = function()
			local _,_,left,_,right = Spring.GetMouseState()
			local alt,ctrl,meta,shift = Spring.GetModKeyState()
			local index = Spring.GetCmdDescIndex(CMD.ONOFF)
			if index then
				Spring.SetActiveCommand(index,1,left,right,alt,ctrl,meta,shift)
			end
		end
		
		if not side or side == "centrail" then
		
			onOffButton = Button:New{
			name = "onOffButton",
			--tooltip = tooltip,
			x = 5,
			y = 100,
			width = 100,
			height = 60,			
			backgroundColor = CentrailButtonBackground, 
			textColor = CentrailTextColour,
			parent= stack_main,
			OnClick = { onOffFunction },
		}
		else 
			onOffButton = 	Chili.HabaneroButton:New{
			triStrip= Chili.HabaneroButton:Spiral(
			{x=20,y=5}, 
			{x=2,y=5}, 
			{x=0,y=0}, 
			50, 
			0.3,
			32
			)	,
			x = 5,
			y = 100,
			width = 100,
			height = 60,			
			backgroundColor = JourneyButtonBackground,
			textColor = JourneyTextColour, 
			OnClick= { onOffFunction}
			}	

		end

		onOffButton.name = "onOffButton"
		onOffButton.caption = "ABILITY"
		
		if stack_main.children[onOffButton] then 
			stack_main.children[onOffButton] = onOffButton 
		else
			stack_main:AddChild(onOffButton)
		end
		
		if onOffButton then
			ButtonsTable["defaultOnOff"]=onOffButton						
			onOffButton:Hide()
		end
	end
	indexVarVal=1
	
	function createNewUpgradeButton(buttonwidth,buttonheigth,BaseCol, texCol, name)
		buttonwidth= buttonwidth..'%'
		buttonheigth=buttonheigth..'%'
		
		return Chili.Button:New{								
			width=buttonwidth,
			height = buttonheigth, 
			backgroundColor = BaseCol,
			textColor = texCol, 
			caption = name, 
			OnClick = {function () Spring.SendLuaRulesMsg("UPG".."|"..name) end}
		}
	end
	
	function CreateUpgradeMenue ()
		
		upgrade_window = Window:New{
			padding = {3,3,3,3,},
			dockable = true,
			textColor = AbilityWindowTextColour,
			name = "upgrade_window",
			x = upgrade_window.positionX, 
			y = upgrade_window.positionY,
			width = upgrade_window.width,
			height = upgrade_window.height,
			parent = screen0,
			draggable = false,
			tweakDraggable = false,
			tweakResizable = false,
			resizable = false,
			dragUseGrip = false,
			color = {0.1,0.7,0.85,0.42},
			backgroundColor= {0.1,0.2,0.6,0.32},
			children = {},
		}
		
		BaseCol=CentrailButtonBackground
		WeapCol={0.3,0.6,0.8,1}
		UpgCol={0.1,0.5,0.6,1}
		texCol=CentrailTextColour
		upgrade_Grid = Grid:New{
			x= 0,
			y = 0,
			padding = {5,5,5,5},
			itemPadding = {0, 0, 0, 0},
			itemMargin = {0, 0, 0, 0},
			--autosize =true,
			--weightedResize =true,
			resizeItems = true,		
			orientation = 'horizontal',
			centerItems = true,
			columns = 7,	
			rows = 3,
			name = 'UpgradeGrid',
			width = 630,
			height = 140,
			
			minItemHeight =	 '21%',
			maxItemHeight =	 '32%',
			
			color = {0,0,0,1},
			parent= upgrade_window,
			children = {
				createNewUpgradeButton(100,90, BaseCol, texCol, "SPEED"),
				createNewUpgradeButton(100,90, BaseCol, texCol, "ARMOR"),
				createNewUpgradeButton(100,90, BaseCol, texCol,"STABILITY"),
				createNewUpgradeButton(100,90, BaseCol, texCol,"AMMO"),
				createNewUpgradeButton(100,90, BaseCol, texCol,"SENSORS"),
				createNewUpgradeButton(100,90, UpgCol, texCol,"EJECTPOD"), 
				createNewUpgradeButton(100,90, UpgCol, texCol,"AMMOFAC"), 				
				
				createNewUpgradeButton(100,90, WeapCol, texCol, "SHOTGUN"), 
				createNewUpgradeButton(100,90, WeapCol, texCol, "SUBMG"), 
				createNewUpgradeButton(100,90, WeapCol, texCol, "SNIPER"),			
				createNewUpgradeButton(100,90, WeapCol, texCol, "GRENADE"), 
				createNewUpgradeButton(100,90, WeapCol, texCol, "SLICER"),
				createNewUpgradeButton(100,90, UpgCol, texCol,"STEALTH"),
				createNewUpgradeButton(100,90, UpgCol, texCol,"RADAR"),

				
				createNewUpgradeButton(100,90, WeapCol, texCol,"RAZOR"),				
				createNewUpgradeButton(100,90, WeapCol, texCol, "FLARE"), 
				createNewUpgradeButton(100,90, WeapCol, texCol, "TANGLE"),
				createNewUpgradeButton(100,90, WeapCol, texCol, "AROCKET"), 
				createNewUpgradeButton(100,90, WeapCol, texCol, "GROCKET"),
				createNewUpgradeButton(100,90, WeapCol, texCol, "EATER"),
				createNewUpgradeButton(100,90, UpgCol, texCol,	"LAZARUS"),				
			},		
		}
		upgrade_window:AddChild(upgrade_Grid)
		
		if upgrade_window then 
			upgrade_window:Hide()	
		end
	end
	
	function Create_UpgradeGrid()
		
		upgradeButton = 	Chili.Window:New{
			name = 'upgradeButton',
			caption = "UPGRADES ",
			textColor = AbilityWindowTextColour,
			fontSize = 24,
			fontShadow = false,
			x = "65%",
			y = "25%",
			resizable = true,
			draggable = true,
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
	
	function showComEndUpgradeMenue()	
		
		if boolShowUpgrade == false then
			boolShowUpgrade = true
			upgrade_window:Show()
			activeAbilityElements["ComEndUpgradeMenue"] = upgrade_window
			
		else 
			boolShowUpgrade = false
			if upgrade_Grid then
				upgrade_window:Hide()
			end
		end
	end
	

		
	function HideAllActiveAbilityElements()
		for k,element in pairs(activeAbilityElements) do
			element:Hide()
		end
		activeAbilityElements={}
	end
	
	function createAllButtons()
		Create_OnOffButton()
		Create_UpgradeButton()
		CreateUpgradeMenue()
		
	end
	
	--Actual initialisatioin Code
	exp_bar= Progressbar:New{
		x=0,
		y=0,
		width = '100%',
		height = '70%',
		caption = "EXP:",
		value =50,
		color = {0.05,0.93,0.95,1},
		backgroundColor = CentrailButtonBackground, 
	}
	
	ammo_bar	= Progressbar:New{
		x=0,
		y=0,
		width = '100%',
		height = '50%',
		caption = "Ammonition",
		value =0,
		color = {0.2,0.85,0.85,0.5},
		backgroundColor = CentrailButtonBackground, 
	}
	
	stack_main = Grid:New{
		x=20,
		y = 0,
		padding = {0,0,0,0},
		itemPadding = {0, 0, 0, 0},
		itemMargin = {0, 0, 0, 0},
		width = '100%',
		height = '100%',
		resizeItems = false,		
		orientation = 'horizontal',
		centerItems = false,
		columns = 1,
		rows= 1,
		
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
		columns = 1,
		rows= 3,
		children={stack_main,
			ammo_bar,
			exp_bar			
		}		
	}
	
	ability_window =  Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		caption = 'Abilities',
		textColor = AbilityWindowTextColour,
		name = "facpanel",
		x = ability_window.positionX, 
		y = ability_window.positionY,
		width = ability_window.width,
		height = ability_window.height,
		parent = screen0,
		draggable = true,
		tweakDraggable = true,
		tweakResizable = true,
		resizable = true,
		dragUseGrip = true,
		--minWidth = 50,
		--minHeight = 50,
		color = {0,0,0,1},
		
		
		children = {			
			base_stack,			
		},
	}
	
	createAllButtons()		
end

--subConstructors
function widget:MouseRelease()
	updateCommandsSoon = true	
end

function widget:CommandsChanged()		
	updateCommandsSoon = true		
end

--update functions
function widget:GameFrame(f)
	
	
	function ShowOnOffButton(typeString)
		if  not ButtonsTable[typeString] then typeString = "defaultOnOff" end
		if  not ButtonsTable[typeString] then return end
		

		ButtonsTable[typeString]:Show()
		activeAbilityElements[typeString]=ButtonsTable[typeString]
	end
	
	local function ShowSpecialAbilityButton()

		ButtonsTable["ability"]:Show()
		activeAbilityElements["ability"]=ButtonsTable["ability"]
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
	
	function resetStatusbars()
		exp_bar.caption="EXP: -"
		exp_bar.value= 0	
		ammo_bar.value= 0
	end
	
	function updateExperienceBar(xp)
		Relative= xp - math.floor(xp)
		Total= math.ceil(xp - Relative)
		
		exp_bar.caption="EXP: "..Total
		exp_bar.value= math.ceil(Relative*100)		
	end
	
	function updateAmmonitionBar(unitID)
		val=Spring.GetUnitRulesParams(unitID,"Ammonition")		
	
		if val and val.Ammonition then
			ammo_bar.value = math.ceil(val.Ammonition)
		else 
			ammo_bar.value = 0
		end		
	end
	
	function UpdateAbilitiesWindow()
		
		selectedUnits = spGetSelectedUnits()
		
		if not selectedUnits then 
			onOffButton.caption = "-"
			HideAllActiveAbilityElements()
			resetStatusbars()
			return 
		end
		
		local unitID = selectedUnits[1]
		if not unitID then 
			onOffButton.caption = "ABILITY"
			HideAllActiveAbilityElements()
			resetStatusbars()
			return 
		end
		
		local udid = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[udid]
		if not ud then Spring.Echo("No Unitdef for Unit: "..unitID); return end
		--update Unit Experience
		xp= Spring.GetUnitExperience(unitID)
		if xp then
			updateExperienceBar(xp)
		end
		
		updateAmmonitionBar(unitID)
		onOffButton.caption = "ABILITY"
		
		--adapt the button to unit commender
		if unitTypeButtonMap[ud.name] then
			--generate the Gui Specific by unittype
			--Spring.Echo("Show typespeicific acitivty button")
			unitTypeButtonMap[ud.name]()		
			
		elseif isUnitOnOffable(ud.name)== true then
		unitTypeButtonMap["default"]("default")
		
		
			--Check for captionReplacement
			if defaultCaptionByUnitType[ud.name] then
				if onOffButton.caption == defaultCaptionByUnitType[ud.name].active then
					onOffButton.caption = defaultCaptionByUnitType[ud.name].passive 
				else
					onOffButton.caption = defaultCaptionByUnitType[ud.name].active 
				end
			end
		else			
			HideAllActiveAbilityElements()
		end
	end
		

	if updateCommandsSoon == true and (f % 16 == 0) then
		updateCommandsSoon = false
		UpdateAbilitiesWindow()	

	end
end