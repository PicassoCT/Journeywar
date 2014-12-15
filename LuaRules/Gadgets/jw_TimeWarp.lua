--naja nicht so perfekt
function gadget:GetInfo()
  return {
    name      = "TimeWarp!",
    desc      = "adds a button to a unit so it can teleport to a previous position",
    author    = "knorke",
    date      = "Mar 2011",
    license   = "gooooooooooodbye horses",
    layer     = 1,
    enabled   = true,
  }
end
 
--include("LuaRules/Configs/tp_CMDID.lua")
 
if (not gadgetHandler:IsSyncedCode()) then return end
 
local EditUnitCmdDesc = Spring.EditUnitCmdDesc
local FindUnitCmdDesc = Spring.FindUnitCmdDesc
local InsertUnitCmdDesc = Spring.InsertUnitCmdDesc
local GiveOrderToUnit = Spring.GiveOrderToUnit
local SetUnitNeutral = Spring.SetUnitNeutral
local GetUnitMoveTypeData = Spring.GetUnitMoveTypeData
local SetGroundMoveTypeData = Spring.MoveCtrl.SetGroundMoveTypeData
local SetGunshipMoveTypeData = Spring.MoveCtrl.SetGunshipMoveTypeData
 
local timeWarperNames = {
--  [UnitDefNames["tpjeep"].id] = true,
  [UnitDefNames["gfreeman"].id] = true,
  [UnitDefNames["jshroudshrike"].id] = true,
}
local timeWarpers = {} --[unitid][frame] .x .y .z
local timewarpUpdateRate = 30   --how often a new position is saved
local nWarpPoints = 10          --how far back the warp goes
local gameframe = 0
local randoVal=math.random(3200,9200)
 
local turnCmd = {
      id      = CMD_DO_TIMEWARP,
      name    = " Time\nWarp ",
      action  = "timeWarp",
      type    = CMDTYPE.ICON_MODE,
      tooltip = "do the timewarp",
      params  = { 'do it!'}
}
 
function gadget:Initalize()
        Spring.Echo ("timewarp initalize()")
end
 
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
        --Spring.Echo ("tp_timewarping.lua: unit created" .. CMD_DO_TIMEWARP)
        if timeWarperNames[unitDefID] then
                InsertUnitCmdDesc(unitID, turnCmd)
                local tr = UnitDefs[unitDefID].turnRate
                local ms = UnitDefs[unitDefID].speed    
                --Spring.Echo ("command added")
                timeWarpers[unitID] = {}
                --timeWarpers[unitID].x, timeWarpers[unitID].y, timeWarpers[unitID].z = Spring.GetUnitPosition (unitID)
                updateTimeWarpersPos ()
        end
end
 
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
  timeWarpers[unitID] = nil
end
 
function TimeWarp()
						randoVal=math.random(800,3200)
						local f = saveFrame (gameframe)+1
                        if (f > nWarpPoints) then f = 0 end
                        --Spring.Echo ("time warping to saveFrame " .. f)
                        if (timeWarpers[unitID] and timeWarpers[unitID][f]) then
                                Spring.SetUnitPosition (unitID, timeWarpers[unitID][f].x, timeWarpers[unitID][f].y, timeWarpers[unitID][f].z,0)
                                timeWarpers[unitID] = {}
                        end

end
 
function gadget:GameFrame (f)
        
        --Spring.Echo (f .."->" .. saveFrame (f))
        if (f%timewarpUpdateRate==0) then updateTimeWarpersPos () end
        if ((f-1)%timewarpUpdateRate==0) then showTimeWarpersPath () end
		if (f% randoVal==0 ) then TimeWarp() end
end
 
function updateTimeWarpersPos ()
        for unitID in pairs(timeWarpers) do
                f = saveFrame(gameframe)
                --Spring.Echo ("updateTimeWarpersPos gameframe="..gameframe .." saveFrame="..f)
                timeWarpers[unitID][f] ={}
                timeWarpers[unitID][f].x, timeWarpers[unitID][f].y, timeWarpers[unitID][f].z = Spring.GetUnitPosition (unitID)
        end
end
 
function showTimeWarpersPath ()
        for unitID in pairs(timeWarpers) do
                for sF in pairs(timeWarpers[unitID]) do
                        local x = timeWarpers[unitID][sF].x
                        local y = timeWarpers[unitID][sF].y
                        local z = timeWarpers[unitID][sF].z
                        Spring.SpawnCEG ("mech_electric_discharge",x,y,z)
                end
        end
end
 
function grainFrame (f, updateRate)
        return math.floor(f/updateRate)--*updateRate
end
 
function saveFrame (frame)
        return grainFrame(frame,timewarpUpdateRate) % nWarpPoints
        --return grainFrame (frame, timewarpUpdateRate)
        --return grainFrame (gameframe-frame, timewarpUpdateRate)%nWarpPoints
end