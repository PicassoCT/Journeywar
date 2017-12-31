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
local selection
local DataTable ={}

function widget:Initialize()
	Chili = WG.Chili

	-- we need a container that supports margin if the control inside uses margins
	
	selection = Chili.ComboBox:New{items = {  }}

			
		
local	flameGraph = Chili.Grid:New{
		parent = selectGridAndDisplay,
		x = 450,
		y = 450,
		clientWidth = 200,
		clientHeight = 200,
		children = {
			
		},
	}	
	
	local selectGridAndDisplay = Chili.Grid:New{
		name = 'selectGridAndDisplay',
		width = '100%',
		height = '100%',
		children = {			
			selection,
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
dataString= Spring.GetGameRulesParam("SerializedFlameGraphTable")
	if dataString then
	DataTable	= stringToTable(dataString)
	--update Selection
	selection.items= {}
		for k,v in pairs(DataTable) do
			selection.items[#selection.items+1]=UnitDefs[k].name
		end
	end
end

function widget:Shutdown()

	flameGraphWindow:Dispose()
end
