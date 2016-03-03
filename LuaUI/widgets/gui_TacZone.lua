
TacZone = {
  classname= "taczone",
  caption  = 'button', 
  LastCommandStack={},
  boolStackNotEmpty = false
}

local this = TacZone
local inherited = this.inherited
--action of the GUI

	function TacZone: pop(xCoords,zCoords)
		if #self.LastCommandStack> 0 then
		t=self.LastCommandStack[#self.LastCommandStack]
		table.remove(self.LastCommandStack,#self.LastCommandStack)
			if table.getn(self.LastCommandStack) == 0 then self.boolStackNotEmpty=false end
		--Get a ScreenRay and Attach the coords
		Spring.SendLuaRulesMsg(t..xCoords.."|"..zCoords)
		end
	end


	function TacZone: push(Command)
	self.boolStackNotEmpty=true
	self.LastCommandStack[#self.LastCommandStack+1]=Command	
	end


--Create 
function TacZone: Create_TacZoneWindow()

 azTex = {WG.imageDir .. 'taczone/action.png'}
 rzTex = {WG.imageDir .. 'taczone/reservoire.png'}
 tzTex = {WG.imageDir .. 'taczone/trigger.png'}

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
	
	--TacZone Button
	TacZoneButton=Chili.Button:New{
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
			
			TacZoneButtonImage = Image:New {
			width="100%";
			height= "100%";
			bottom = nil;
			y="0%"; 
			x="0%";
			keepAspect = true,
			file = tzTex[1];
			parent = TacZoneButton;			
				}
		--ActionZone Button					
		ActionZoneButton=Chili.Button:New
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
		 	 ActionZoneButtonImage = Image:New {
			width="90%";
			height= "90%";
			bottom = nil;
			y="0%"; 
			x="0%";
			keepAspect = true,
			file = azTex[1];
			parent = ActionZoneButton;			
				}
			--Reservoir Zone Button	
			ReservoirZoneButton=Chili.Button:New
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
			
			ReservoirZoneButtonImage = Image:New {
			width="90%";
			height= "90%";
			bottom = nil;
			y="0%"; x="0%";
			keepAspect = true,
			file = rzTex[1];
			parent = ReservoirZoneButton;			
				} 
		--TacZone ButtonGrid
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
		TacZoneButton,
		ActionZoneButton,
		ReservoirZoneButton,
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