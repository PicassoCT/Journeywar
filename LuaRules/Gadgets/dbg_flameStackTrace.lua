
-- TODO: fix parting Code for 16 pieces -- also distribute maploading over same period --integrate mapparts created



--- - file: Land_Lord.lua
-- brief: spawns start unit and sets storage levels
-- author: Andrea Piras
--
-- Copyright (C) 2010,2011.
-- Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function gadget:GetInfo()
    return {
        name = "Flame Graph ",
        desc = "Provides Data & Draws a Flame Graph",
        author = "PicassoCT",
        date = "7 b.Creation",
        license = "GNU GPL, v2 its goes in all fields",
        layer = 0,
        enabled = false -- loaded by default?
    }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

	-- synced only
if  gadgetHandler:IsSyncedCode() then
 

VFS.Include('scripts/lib_UnitScript.lua', nil, VFSMODE)

	GG.FlameGraph= {
				--	[unitDefID]= {
								-- [functionname]= {
												-- callEntered
												-- callLeft (or no Arguments)
												-- totalTimeSpend = 0,
												-- numberOfCalls=0
												--calledFrom = {}
												-- name= "functionname"
								-- }

					--			}
					}
					
	GG.UnitStack= {}
	
		--constant distortion at beginn of measurement			
		function checkInit(unitDefID, func, name)
		if not GG.FlameGraph[unitDefID] then GG.FlameGraph[unitDefID] = {} end
		if not GG.FlameGraph[unitDefID][name] then 
				GG.FlameGraph[unitDefID][name] = {
												unitName= UnitDefs[unitDefID].name,
												boolCallEntered= false,
												boolCallLeft = false,												
												numberOfCalls=0,
												name= name,
												calledFrom={},
												source = string.dump(func)
				}
				end

		
		end
		
	function stackPushing(unitID,unitDefID, func, name)
					if not GG.UnitStack[unitID][#GG.UnitStack[unitID]] then GG.UnitStack[unitID][#GG.UnitStack[unitID]] = "[Context]" end
					stackname = "[Context]"
					if GG.UnitStack[unitID][#GG.UnitStack[unitID]] then stackname = GG.UnitStack[unitID][#GG.UnitStack[unitID]]  end
					local stackIndex= #GG.UnitStack[unitID] or 1
					if not GG.FlameGraph[unitDefID][name].calledFrom[stackname] then GG.FlameGraph[unitDefID][name].calledFrom[stackname]= 0 end
					GG.FlameGraph[unitDefID][name].calledFrom[stackname]=GG.FlameGraph[unitDefID][name].calledFrom[stackname] + 1 
					GG.UnitStack[unitID][#GG.UnitStack[unitID]+1] = name		
					return stackIndex
	end	
		
	function wrapFunction(unitID, unitDefID, func, name)
	if name then

	--	Spring.Echo("Wrapping function "..name)
		local retFunc= function(...)
	
				if not GG.UnitStack[unitID] then GG.UnitStack[unitID] ={[1]="[Context]"}end
				index = #GG.UnitStack[unitID]
				Spring.Echo("Wrapped Function called:"..GG.UnitStack[unitID][index].."::"..Name)
				local arguments = {...}
					--measure time
					--register call 
					GG.FlameGraph[unitDefID][name].boolCallLeft= false
					GG.FlameGraph[unitDefID][name].boolCallEntered= true
					--Stack pushed
					stackIndex= stackPushing(unitID, unitDefID, func, name)
					--hand down arguments and actual call					
					retArguments = table.pack(func(unpack(arguments)))
					
					--Stack popped
					if GG.UnitStack[unitID][#GG.UnitStack[unitID]] and stackIndex > 1 then
						table.remove(GG.UnitStack[unitID],stackIndex)
					end				

					--pack handed back arguments
					--register call returned
					GG.FlameGraph[unitDefID][name].numberOfCalls= 1 + GG.FlameGraph[unitDefID][name].numberOfCalls
					GG.FlameGraph[unitDefID][name].boolCallLeft= true
					GG.FlameGraph[unitDefID][name].boolCallEntered= false
					--return arguments		

				return unpack(retArguments)
				end
		return retFunc
	else 
		return func
	end	
	end	
	
	function driveHooksIntoUnitsEnv(unitID,unitDefID)
	
	env = {}
	env = Spring.UnitScript.GetScriptEnv(unitID)
		
		if env then
			for k, v in pairs(env) do
				typeV= type(v)
				
				if typeV == "function" then
					checkInit(unitDefID, v, k)
					if not k then echo("dbg_FlameGraph::Unit "..UnitDefs[unitDefID].name.." has a nil keyed function") end
					if k then
						env[k]= wrapFunction(unitID, unitDefID, v,k )
					end
				end
				
				if typeV == "table" then
					for key,value in pairs(v) do
						if type(value)== "function" then
							checkInit(unitDefID, value, key)
							v[key]= wrapFunction(unitDefID, value,key)
						end
					end
				end				
			end
		end
	end	
	
	delayedHookDriving={}
	
	function gadget:UnitCreated(unitID, unitDefID)
		Spring.Echo("dbg_FlameGraph::"..UnitDefs[unitDefID].name.." created")
		GG.UnitStack[unitID] = {[1]="[Context]"}
		gameFramePlus = Spring.GetGameFrame()+1
		if not delayedHookDriving[gameFramePlus] then delayedHookDriving[gameFramePlus] = {} end
		delayedHookDriving[gameFramePlus][#delayedHookDriving[gameFramePlus]+1]= {
											id=unitID,
											defID= unitDefID
											}
	end
	
	function gadget:GameFrame(frame)
		if delayedHookDriving[frame] then
			echo("dbg_FlameGraph::Frame exists for "..frame)
			for i=1,table.getn(delayedHookDriving[frame]) do
				echo("dbg_FlameGraph::Id exists for "..delayedHookDriving[frame][i].id)
				driveHooksIntoUnitsEnv(delayedHookDriving[frame][i].id, delayedHookDriving[frame][i].defID)
			end
		end
		
	end

	function gadget:UnitDestroyed(unitID)
		GG.UnitStack[unitID] = nil
	end

	--Send To Unsynced Display Widget
	function serializeFlamegraph()
		Spring.SetGameRulesParam("SerializedFlameGraphTable", toString(GG.FlameGraph))	
	end
	
end