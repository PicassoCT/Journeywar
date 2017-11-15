
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
local activeBuildElements={}
local exp_bar= {}
local ammo_bar	= {}

local imageDirComands = 'luaui/images/commands/'
local onoffTexture = {imageDirComands .. 'states/off.png', imageDirComands .. 'states/on.png'}
local selectedUnits = {}
local ability_window
local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits
updateCommandsSoon = false

defaultCaptionByUnitType = VFS.Include('LuaUI/ressources/ability_captions.lua')

local ability_window = {}
local upgrade_window = {}
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
			x = 5,
			y = 100,
			width = 100,
			height = 60,
			caption = 'ABILITY',
			
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
	indexVarVal=1
	
	function createNewBuildButton(buttonwidth,buttonheigth,BaseCol, texCol, name, uDID)
		buttonwidth= buttonwidth..'%'
		buttonheigth=buttonheigth..'%'
		
	local cmd ={id = -uDID}
    local unitDef = UnitDefs[uDID] 
    local name = unitDef.name
    
    local image = Chili.Image:New{
        name   = "unitImage_" .. name,
        height = '100%', 
        width = '100%',
        file   = '#'..unitDef.id,
        -- flip = false,
    }
    local button = Chili.Button:New{
        name = "unitButton_" .. name,
        cmdID = cmd.id,
        caption = "",
        children = {image},
        padding = {0,0,0,0},
        margin = {0,0,0,0},
        OnMouseUp = {ActionCommand},
		width=buttonwidth,
		height = buttonheigth, 
		}	
		
		return button
	end

	function unitCanBuild(unitDefID)
	assert(UnitDefs)

		if unitDefID and UnitDefs[unitDefID]  then		
			return UnitDefs[unitDefID].buildOptions 
		else
				return {}
		end
	end

	
	function addTypeDependentBuildOptions(defID)
	buildOptions = getUnitCanBuild(defID)
	local T={}
		for num,defID in pairs(buildOptions) do
			name = UnitDefs[defID].name
			T[#T+1]	= createNewBuildButton(100,100, BaseCol, texCol, name, defID)
		end
		
	return T
	end
	
	function CreateBuildMenue (defID)
		
		build_window = Window:New{
			padding = {3,3,3,3,},
			dockable = true,
			textColor = {0.9,1,1,0.7},
			name = "build_window",
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
			--minWidth = math.ceil(upgrade_window.width_numeric*0.75),
			--minHeight = math.ceil(upgrade_window.height_numeric*0.75),
			color = {0.1,0.7,0.85,0.42},
			backgroundColor= {0.1,0.2,0.6,0.32},
			children = {},
		}
		
		BaseCol={0.1,0.8,0.8,1}
		WeapCol={0.3,0.6,0.8,1}
		UpgCol={0.1,0.5,0.6,1}
		texCol={0.8,1,1,1}
		build_grid = Grid:New{
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
			name = 'build_grid',
			width = 630,
			height = 140,
			
			minItemHeight =	 '21%',
			maxItemHeight =	 '32%',
			
			color = {0,0,0,1},
			
			children = addTypeDependentBuildOptions(defID)
			
				
		}
		build_window:AddChild(build_grid)
		
		if build_window then 
			build_window:Hide()	
		end
	end

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
			textColor = {0.9,1,1,0.7},
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
		
		BaseCol={0.1,0.8,0.8,1}
		WeapCol={0.3,0.6,0.8,1}
		UpgCol={0.1,0.5,0.6,1}
		texCol={0.8,1,1,1}
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
	
	function HideAllActiveBuildElements()
		for k,element in pairs(activeBuildElements) do
			element:Hide()
		end
		activeBuildElements={}
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
		CreateBuildMenue()
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
		backgroundColor = {0.1,0.8,0.8,1}, 
	}
	
	ammo_bar	= Progressbar:New{
		x=0,
		y=0,
		width = '100%',
		height = '50%',
		caption = "Ammonition",
		value =0,
		color = {0.2,0.85,0.85,0.5},
		backgroundColor = {0.1,0.8,0.8,1}, 
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
			exp_bar,
			
		}
		
	}
	
	
	
	ability_window = Window:New{
		padding = {3,3,3,3,},
		dockable = true,
		caption = 'Abilities',
		textColor = {0.9,1,1,0.7},
		name = "facpanel",
		x = ability_window.positionX, 
		y = ability_window.positionY,
		width = ability_window.width,
		height = ability_window.height,
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
	
	createAllButtons()		
end

--subConstructors
function widget:CommandsChanged()		
	updateCommandsSoon = true		
end

--update functions
function widget:GameFrame(f)
	
	
	function ShowOnOffButton(typeString)
		if  not ButtonsTable[typeString] then typeString = "defaultOnOff" end
		if  not ButtonsTable[typeString] then return end
		
		Spring.Echo("Pre Error")
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
		
		
		--adapt the button to unit
		if unitTypeButtonMap[ud.name] then
			--generate the Gui Specific by unittype
			--Spring.Echo("Show typespeicific acitivty button")
			unitTypeButtonMap[ud.name]()		
			
		elseif isUnitOnOffable(ud.name)== true then
			--Spring.Echo("Show dfault acitivty button")
			unitTypeButtonMap["default"]("default")
			--Check for captionReplacement
			if defaultCaptionByUnitType[ud.name] then
				if onOffButton.caption== defaultCaptionByUnitType[ud.name].active then
					onOffButton.caption = defaultCaptionByUnitType[ud.name].passive 
				else
					onOffButton.caption = defaultCaptionByUnitType[ud.name].active 
				end
			else
				onOffButton.caption = "ABILITY"
			end
		else
			--Spring.Echo("Hide all Buttons")
			--default no button
			onOffButton.caption = "ABILITY"
			HideAllActiveAbilityElements()
		end
	end
		
	function UpdateBuildWindow()
		
		selectedUnits = spGetSelectedUnits()
		
		if not selectedUnits then 
			HideAllActiveBuildElements()
			resetStatusbars()
			return 
		end
		
		local unitID = selectedUnits[1]
		if not unitID then 
			HideAllActiveAbilityElements()
			resetStatusbars()
			return 
		end
		
		local udid = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[udid]
		
		--update Unit Experience
		xp= Spring.GetUnitExperience(unitID)
		if xp then
			updateExperienceBar(xp)
		end
		
		updateAmmonitionBar(unitID)
		
		
		--adapt the button to unit
		if unitTypeButtonMap[ud.name] then
			--generate the Gui Specific by unittype
			--Spring.Echo("Show typespeicific acitivty button")
			unitTypeButtonMap[ud.name]()		
			
		elseif isUnitOnOffable(ud.name)== true then
			--Spring.Echo("Show dfault acitivty button")
			unitTypeButtonMap["default"]("default")
			--Check for captionReplacement
			if defaultCaptionByUnitType[ud.name] then
				if onOffButton.caption== defaultCaptionByUnitType[ud.name].active then
					onOffButton.caption = defaultCaptionByUnitType[ud.name].passive 
				else
					onOffButton.caption = defaultCaptionByUnitType[ud.name].active 
				end
			else
				onOffButton.caption = "ABILITY"
			end
		else
			--Spring.Echo("Hide all Buttons")
			--default no button
			onOffButton.caption = "ABILITY"
			HideAllActiveAbilityElements()
		end
	end
	
	if updateCommandsSoon == true and (f % 16 == 0) then
		updateCommandsSoon = false
		UpdateAbilitiesWindow()	
		UpdateBuildWindow()
	end
end