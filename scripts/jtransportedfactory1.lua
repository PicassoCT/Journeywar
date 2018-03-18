--Define the wheel pieces
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "createCorpse.lua"
include "lib_Build.lua"

--Define the pieces of the weapon

local SIG_RESET = 2
local SIG_UPGRADE = 4
teamID = Spring.GetUnitTeam(unitID)

Kugel01 = piece "Kugel01"
Kugel02 = piece "Kugel02"

function getDistance(cmd, x, z)
    val = ((cmd.params[1] - x) ^ 2 + (cmd.params[3] - z) ^ 2) ^ 0.5

    return val
end

function transferCommands()

    while true do
        if GG.JFactorys and GG.JFactorys[unitID] and GG.JFactorys[unitID][1] then
            CommandTable = Spring.GetUnitCommands(unitID)

            first = false

            for _, cmd in pairs(CommandTable) do
                if #CommandTable ~= 0 then
                    if first == false then
                        first = true
                        x, y, z = Spring.GetUnitPosition(unitID)
                        if cmd.id == CMD.MOVE and getDistance(cmd, x, z) > 165 then
                            Spring.GiveOrderToUnit(GG.JFactorys[unitID][1], cmd.id, cmd.params, {})
                        end
                    else
                        Spring.GiveOrderToUnit(GG.JFactorys[unitID][1], cmd.id, cmd.params, { "shift" })
                    end
                else
                    Spring.GiveOrderToUnit(GG.JFactorys[unitID][1], CMD.STOP, {}, {})
                end
            end
        end
        Sleep(250)
    end
end

function script.Create()
	hideAll(unitID)
    StartThread(transferCommands)
    StartThread(whileMyThreadGentlyWeeps)
    StartThread(delayedUpgrade)

    if GG.JFactorys == nil then GG.JFactorys = {} end
    GG.JFactorys[unitID] = {}
end


function script.QueryBuildInfo()
    return Kugel02
end

Spring.SetUnitNanoPieces(unitID, { Kugel01 })

local defID = Spring.GetUnitDefID(unitID)
local firstbornDefID = UnitDefNames["jtrafactory"].id
local upgradeDefID = UnitDefNames["jupgradefactory1"].id

function delayedUpgrade()


    while true do
        Sleep(2500)
        id = Spring.GetUnitIsBuilding(unitID)

		
        if (id and Spring.ValidUnitID(id) == true) then
		defIDChild= Spring.GetUnitDefID(id)
            if defIDChild and defIDChild == upgradeDefID then
                x, y, z = Spring.GetUnitPosition(unitID)
                if y < -5 then
                    defIDChild = Spring.GetUnitDefID(id)
					
                    x, y, z = Spring.GetUnitPosition(unitID)

                    GG.UnitsToSpawn:PushCreateUnit("jfactorylvl1transform", x, y, z, 0, teamID)
                    Spring.DestroyUnit(GG.JFactorys[unitID][1], false, true)
                    Spring.DestroyUnit(unitID, false, true)

                else
                    hp, mh, pd, cp, buildProgress = Spring.GetUnitHealth(id)
                    Spring.SetUnitHealth(id, { ["build"] = 0 })
                end
            end
        end
    end
end


function script.Activate()
    SetUnitValue(COB.YARD_OPEN, 1)
    SetUnitValue(COB.INBUILDSTANCE, 1)
    SetUnitValue(COB.BUGGER_OFF, 1)
    return 1
end


function script.Deactivate()
    Signal(SIG_UPGRADE)
    SetUnitValue(COB.YARD_OPEN, 0)
    SetUnitValue(COB.INBUILDSTANCE, 0)
    SetUnitValue(COB.BUGGER_OFF, 0)
    return 0
end


function delayedBuildEnd()
    SetSignalMask(SIG_RESET)
    Sleep(1500)
    if GG.JFactorys[unitID] then
        GG.JFactorys[unitID][2] = false
    end
end


function script.StartBuilding()
    --Spring.Echo("JW:TransportedFactory starting to build")
    --animation
    Signal(SIG_RESET)
    if GG.JFactorys[unitID] then
        GG.JFactorys[unitID][2] = true
    end
end

boolDoIt = false
function whileMyThreadGentlyWeeps()
    while true do
        if boolDoIt == true then
            boolDoIt = false
            StartThread(delayedBuildEnd)
        end
        Sleep(150)
    end
end

function script.StopBuilding()
    boolDoIt = true
end

function script.Killed(endh, _)
    GG.JFactorys[unitID] = nil -- check for correct syntax
    return 1
end