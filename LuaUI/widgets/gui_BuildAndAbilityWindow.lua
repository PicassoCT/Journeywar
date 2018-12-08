
function widget:GetInfo()
	return {
		name = "Abilitys, Upgrade & Build GUI",
		desc = "Displays Special Abilitys & Buildoptions",
		author = "PicassoCT",
		date = "2011-6-2",
		license = "GNU GPL, v2 or later",
		layer = 256,
		hidden= false,
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
local build_grid

local boolShowUpgrade = false
local elementsToHide={}
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
local unitImageDir = 'unitpics/'

local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits
updateCommandsSoon = false

defaultCaptionByUnitType = VFS.Include('LuaUI/ressources/ability_captions.lua')

local ability_window = {}
local build_window = {}

local ignoreCMDs = {
    timewait=true,
    deathwait=true,
    squadwait=true,
    gatherwait=true,
    loadonto=true,
}

ability_window.height = "23%"--180
ability_window.height_numeric =180
ability_window.width = "7%"--115
ability_window.width_numeric = 115
ability_window.positionX = "19%"
ability_window.positionY = "77%"

upgrade_window.height= "20%"
upgrade_window.height_numeric= 300
upgrade_window.width= "35%"
upgrade_window.width_numeric= 300
upgrade_window.positionX = "26%" -- addPercent(ability_window.positionX, ability_window.width) -- "36%"
upgrade_window.positionY = "85%"

build_window.height= "12.5%"
build_window.height_numeric= 300
build_window.width= "50%"
build_window.width_numeric= 300
build_window.positionX = upgrade_window.positionX
build_window.positionY = "87.5%"
build_window.rows = 2
build_window.columns= 34 /build_window.rows

local CentrailButtonBackground = {0.1,0.8,0.8,1}
local CentrailTextColour = {0.8,1,1,1}
local AbilityWindowTextColour = {0.9,1,1,0.7}

local JourneyButtonBackground = {0.1,0.8,0.8,1}
local JourneyTextColour = {0.8,1,1,1}

function ActionCommand(self, x, y, button, mods) 
    local index = Spring.GetCmdDescIndex(self.cmdID)
    if index then
        local left, right = (button == 1), (button == 3)
        local alt, ctrl, meta, shift = mods.alt, mods.ctrl, mods.meta, mods.shift
        Spring.SetActiveCommand(index, button, left, right, alt, ctrl, meta, shift)
    end
end

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

	
	local	Ability_Upgrade_Function =function ()
		
	function onOffFunction ()
			local _,_,left,_,right = Spring.GetMouseState()
					local alt,ctrl,meta,shift = Spring.GetModKeyState()
					local index = Spring.GetCmdDescIndex(CMD.ONOFF)
					if index then
						Spring.SetActiveCommand(index,1,left,right,alt,ctrl,meta,shift)
					end
			end

				selectedUnits = Spring.GetSelectedUnits()
				
				if not selectedUnits then return end
						
				local unitID = selectedUnits[1]
				
				if not unitID then 	return end
				
				local udid = Spring.GetUnitDefID(unitID)
				local ud = UnitDefs[udid]
				
				boolIsOnOffable =  isUnitOnOffable(ud.name) 			
				
					if ud.name == "ccomender" then
						showComEndUpgradeMenue()
					elseif boolIsOnOffable == true then
						onOffFunction()
					end			
		end

	
	
	function Create_UpgradeButton()
		SpecialAbilityButton = Button:New{
			name = unitDefID,
			x = 5,
			y = 100,
			caption = 'ABILITY',
			width = 100,
			height = 60,
			backgroundColor = CentrailButtonBackground, 
			textColor = CentrailTextColour,
			OnClick = {
				Ability_Upgrade_Function
			},
		}
		
		stack_main:AddChild(SpecialAbilityButton)

		
		build_grid = Chili.Grid:New{
        name = "build_grid",
        x = '0%',
        y = '0%',
        width = '100%',
        height = '100%',
        rows = build_window.rows,
        columns = build_window.columns,        
        padding = {0,0,0,0},
    }
	
	build_window = Window:New{
				padding = {3,3,3,3,},
				dockable = true,
				textColor = AbilityWindowTextColour,
				name = "build_window",
				x = build_window.positionX, 
				y = build_window.positionY,
				width = build_window.width,
				height = build_window.height,
				parent = screen0,
				draggable = false,
				tweakDraggable = false,
				tweakResizable = false,
				resizable = false,
				dragUseGrip = false,
				color = {0.1,0.7,0.85,0.42},
				backgroundColor= {0.1,0.2,0.6,0.32},
				children = {build_grid},
			}
		
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
	
	function UnitButton(cmd)
    local uDID = -cmd.id
    local unitDef = UnitDefs[uDID] 
    local name = unitDef.name
    
    local image = Chili.Image:New{
        name   = "unitImage_" .. name,
        height = '100%', 
        width = '100%',
		   color ={1,1,1,0.75},
        file   = unitImageDir..(unitDef.name..".png" or 'placeholder.png'),
         flip = false,
    }
    local button = Chili.Button:New{
        name = "unitButton_" .. name,
        cmdID = cmd.id,
        caption = "",
        children = {image},
			backgroundColor = CentrailButtonBackground, 
        padding = {0,0,0,0},
        margin = {0,0,0,0},	
		
        OnMouseUp = {ActionCommand},
    }
    build_grid:AddChild(button)
end

function ParseCmd(cmd)
    if UnitDefNames[cmd.name] then
        -- unit
        UnitButton(cmd)
    end
end

	function ParseBuildCmds()
		-- clean out the grids & repopulate
		build_grid:ClearChildren()
		
		local cmds = Spring.GetActiveCmdDescs()
		local haveCmd = false
		for _,cmd in ipairs(cmds) do
			if cmd.name ~= '' and not (ignoreCMDs[cmd.name] or ignoreCMDs[cmd.action]) then
				haveCmd = true
				ParseCmd(cmd)
			end
		end
		
		if haveCmd and build_window.hidden then build_window:Show() elseif not haveCmd and build_window.visible then build_window:Hide() end
	end
	
	
	function updateBuildMenue ()

		
		ParseBuildCmds()
	
	
	end
	
	function CreateUpgradeMenue ()
		if not screen0.upgrade_window then
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
		else
			screen0.upgrade_window:Show()
		end
		
		
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
			name = 'upgrade_Grid',
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
			children = {},			
		}
		if upgradeButton then
			upgradeButton:Hide()
		end		
	end
	
	function showComEndUpgradeMenue()	
		
		if boolShowUpgrade == false then			
			upgrade_window:Show()			
		else 
			if upgrade_window then
				upgrade_window:Hide()
			end
		end		
		boolShowUpgrade = not true
	end
	


	
	function createAllButtons()
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
		
		if not selectedUnits and upgrade_window then 
			upgrade_window:Hide()
			resetStatusbars()
			SpecialAbilityButton:Invalidate()
			return 
		end
		
		local unitID = selectedUnits[1]
		if not unitID then 
			SpecialAbilityButton.caption = "ABILITY"
			SpecialAbilityButton:Hide()
			SpecialAbilityButton:Invalidate()
			upgrade_window:Hide()
			resetStatusbars()
			
			return 
		end
		
		local udid = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[udid]
		if not ud then return end
		--update Unit Experience
		xp= Spring.GetUnitExperience(unitID)
		if xp then
			updateExperienceBar(xp)
		end
		
		updateAmmonitionBar(unitID)
	
		
		if isUnitOnOffable(ud.name)== true then
		SpecialAbilityButton:Show()
		
			if defaultCaptionByUnitType[ud.name] then
			boolUnitIsActive =	Spring.GetUnitIsActive (unitID)
				if boolUnitIsActive == true then
					SpecialAbilityButton.caption = defaultCaptionByUnitType[ud.name].passive 
				else
					SpecialAbilityButton.caption = defaultCaptionByUnitType[ud.name].active 
				end
			end
		else
			SpecialAbilityButton:Hide()		
		end
		--Redraw
		SpecialAbilityButton:Invalidate()
	end
		

--update functions
function widget:GameFrame(f)	
	
	if updateCommandsSoon == true and (f % 16 == 0) then
		updateCommandsSoon = false
		UpdateAbilitiesWindow()	
	end
	
	if (f % 16 == 0 ) then
		updateBuildMenue()
	end
end