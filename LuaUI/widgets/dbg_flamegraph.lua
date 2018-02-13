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
local Chili 
local numberOfRows=16
local numberOfColumns = 8
function widget:Initialize()
	Chili = WG.Chili

	-- we need a container that supports margin if the control inside uses margins
	selection = Chili.ComboBox:New{items = { bg, bg2 }}
	
local	flameGraph = Chili.Grid:New{
		parent = selectGridAndDisplay,
		x = 450,
		y = 450,
		rows          = numberOfRows,
		columns       = numberOfColumns,
		orientation   = "vertical", --// "horizontal" or "vertical"
		autoArrangeH  = false, --FIXME rename
		autoArrangeV  = false, --FIXME rename
		clientWidth = 450,
		clientHeight = 450,
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
	
								-- [functionname]= {
												-- callEntered
												-- callLeft (or no Arguments)
												-- totalTimeSpend = 0,
												-- numberOfCalls=0
												--calledFrom = {}
												-- name= "functionname"
								-- }


	function getTestData()
		return {			
				["me"]={
						totalTimeSpend = 42,
						numberOfCalls = 52,
						calledFrom={"Context"}						
						},
				["myself"]={
						totalTimeSpend = 32,
						numberOfCalls = 32,
						calledFrom={"me"}		
						},
				["i"]={
						totalTimeSpend = 12,
						numberOfCalls = 22,
						calledFrom={"myself"}	
						}		
				}
	end						

	function prepareData(T)
	whoCalledWhoTable= {}
		for name,data in pairs(T) do
			for i=1, #data.calledFrom do
				callingFunction = data.calledFrom[i]
				whoCalledWhoTable[callingFunction][name] = whoCalledWhoTable[callingFunction][name] or 0)
			end
		end
	end
	
	--recursive function einfügen							
	function updateFlameGraph(T)
	currentGameFrame = Spring.GetGameFrame()
		if currentGameFrame % 2 == 0 then
			T= getTestData()
			flameGraph.children = {}
			colIndex = 0.5
			index=1
		
			--for functionsname,fData in pairs(T) do
			for k,v in pairs(T) do
			colIndex = math.min(1,colIndex+0.1)
					
			flameGraph.children[numberOfRows-index]= Chili.Progressbar:New{
						parent= flameGraph,
						x = 0,
						y = index*50,
						width = "100%",
						height =  '100%',
						caption = k,
						value = v.numberOfCalls,
						color = {colIndex,0.25,0.25,1},
						backgroundColor = {0.1,0.1,0.1,1}, 
					}
					index=index+1
			end
		end
	end
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

	updateFlameGraph()

end

function widget:Shutdown()

	flameGraphWindow:Dispose()
end
