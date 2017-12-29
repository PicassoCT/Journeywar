--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "display Flamegraph",
    desc      = "Renders the FlameGraph per Unit",
    author    = "PicassoCT",
    date      = "Year of the Stallman 2017",
    license   = "GPL",
    layer     = 1,
    enabled   = true  --  loaded by default?
  }
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
VFS.Include('scripts/lib_UnitScript.lua', nil, VFSMODE)

-- gui elements
local flameGraphWindow
local window01
local gridWindow0
local gridWindow1
local windowImageList
local window1
local window2
local window3
local selection

function widget:Initialize()
	Chili = WG.Chili

	-- we need a container that supports margin if the control inside uses margins
	
local	selection = Chili.ComboBox:New{items = { "opt1", "opt2", "opt3", "opt4", "opt5", "opt6", "opt7", "opt8", "opt9", "opt10", "opt11", "opt12", }}

			
		
local	flameGraph = Chili.Window:New{
		parent = selectGridAndDisplay,
		x = 450,
		y = 450,
		clientWidth = 200,
		clientHeight = 200,
		children = {
				Chili.Button:New{caption = "Flamegraph"},
				Chili.Button:New{caption = "Flamegraph"},
				Chili.Button:New{caption = "Flamegraph"},
				Chili.Button:New{caption = "Flamegraph"},
				Chili.Button:New{caption = "Flamegraph"},
				Chili.Button:New{caption = "Flamegraph"},
				Chili.Button:New{caption = "Flamegraph"}
		},
	}	
	
	local selectGridAndDisplay = Chili.Grid:New{
		name = 'selectGridAndDisplay',
		width = '100%',
		height = '100%',
		children = {			
		--	selection,
			flameGraph

			}
		}	
	


	flameGraphWindow = Chili.Window:New{
		x = 200,
		y = 200,
		clientWidth  = 200,
		clientHeight = 200,
		parent = Chili.Screen0,
		 children= {
		 selectGridAndDisplay
		 }
	}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end --Initialize


function widget:Update()
	--	widgetHandler:RemoveCallIn("Update")
	
end


function widget:Shutdown()

	flameGraphWindow:Dispose()
end
