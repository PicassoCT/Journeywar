--action of the GUI
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

if not _G.imageDir  then _G.imageDir = 'luaui/images/' end

local azTex = {_G.imageDir .. 'taczone/action.png'}
local rzTex = {_G.imageDir .. 'taczone/reservoire.png'}
local tzTex = {_G.imageDir .. 'taczone/trigger.png'}

--Create 
function Create_TacZones()

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
			file = azTex[1];
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

end	