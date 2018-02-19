include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"
include "lib_jw.lua"



turnerpoint = piece "turnerpoint"
energyorb = piece "energyorb"
truster1 = piece "truster1"
truster2 = piece "truster2"
truster3 = piece "truster3"
truster4 = piece "truster4"
center = piece "center"

turret1 = piece "turret1"
turret2 = piece "turret2"
turret3 = piece "turret3"
turret4 = piece "turret4"
Ground = {}
CHARGE_TOTAL = UnitDefNames["jtree1"].metalCost + UnitDefNames["jtree1"].energyCost or 4200
ChargeUp = 0
SIG_DELAY= 2
for i = 1, 6, 1 do
    Ground[i] = {}
    name = "grd" .. i
    Ground[i] = piece(name)
end


function landSequoia()
    Turn(turnerpoint, x_axis, math.rad(0), 3)
    --Move(center,y_axis,-165,2)
    WaitForTurn(turnerpoint, x_axis)
    --WaitForMove(center,y_axis)

    local x, y, z = Spring.GetUnitPosition(unitID)
    local teamID = Spring.GetUnitTeam(unitID)
    mexID = Spring.CreateUnit("jsettledsequoia", x, y, z, 0, teamID)
    health = Spring.GetUnitHealth(unitID)
    Spring.SetUnitHealth(mexID, health)
    Spring.DestroyUnit(unitID, false, true)

    --now we replace it with a flyingSequoia
end


boolOnlyOnce = true
function script.Activate()
    --Spring.Echo("Activated")
    if boolOnlyOnce == false then
        boolOnlyOnce = true
        StartThread(landSequoia)
    end

    return 1
end

function script.Deactivate()

    --SetUnitValue(COB.MAX_SPEED,340787)--sets the speed to 5,2 *65533

    return 0
end

function destroyedUnit(dUIDefID)
    MetallCost = UnitDefs[dUIDefID].metalCost  or 250 --TODO getUnitType dependant costs
    EnergyCost = UnitDefs[dUIDefID].energyCost or 250 --TODO getUnitType dependant costs
    Show(energyorb)
    Total = (MetallCost + EnergyCost) 
    ChargeUp = ChargeUp + Total
end

function emitLight()
    Spin(energyorb, y_axis, math.rad(42), 12)
    Spin(energyorb, z_axis, math.rad(22), 12)
    Spin(energyorb, x_axis, math.rad(-22), 12)
    while (true) do

        while ChargeUp > 0 do
            Sleep(25)
            EmitSfx(energyorb, 1026)
        end
        Sleep(1000)
    end
end

function activator()
    Sleep(2000)
    boolOnlyOnce = false
end


function script.Create()
	 StartThread(rampUpSpeed)
    Hide(energyorb)
    Turn(turnerpoint, x_axis, math.rad(-91), 0)
    for i = 1, 6, 1 do
        Hide(Ground[i])
    end
    StartThread(emitLight)
    StartThread(activator)
end


function script.Killed(recentdamage, _)
    Spring.PlaySoundFile("sounds/jEtree/tree.wav")
    Sleep(2000)


    return 1
end

function logUpToXInMSec(x,msec,targmsec)
fact=math.max(0,math.min(1.718281828459045,msec/targmsec))
return math.log(1+fact)*x
end

function rampUpSpeed()
internalSpeed=0.1
setSpeedEnv(unitID,internalSpeed)
	while true do
	oldHeading= Spring.GetUnitHeading(unitID)
	Sleep(100)
	newHeading= Spring.GetUnitHeading(unitID)
	timeElapsed=0
		while boolMoving==true and absDistance(oldHeading,newHeading) < 10 do
			newHeading= Spring.GetUnitHeading(unitID)
			setSpeedEnv(unitID,internalSpeed)
			factor = logUpToXInMSec(0.025, timeElapsed,15000)
			internalSpeed=math.min(1,internalSpeed+ factor)
			Sleep(100)
			timeElapsed=timeElapsed+100
		end

	internalSpeed=0.1
	setSpeedEnv(unitID,internalSpeed)

	end
end

boolMoving=false
function script.StartMoving()
boolMoving=true
Signal(SIG_DELAY)
    --Spring.Echo("Jseq_Starting to move")
end
function delayedStop()
Signal(SIG_DELAY)
SetSignalMask(SIG_DELAY)
Sleep(300)
boolMoving=false
end
function script.StopMoving()
StartThread(delayedStop)
    --Spring.Echo("Jseq_STOP")
end

-- The copypastated towers of the citadell


function script.AimFromWeapon1()
    return podturret0
end




function script.QueryWeapon1()
    return turret1
end

function script.AimWeapon1(heading, pitch)
    return true
end

function script.FireWeapon2()
    return true
end

--------------------------------------------------------------------------
-- turret + two turret emiter
function script.AimFromWeapon2()
    return turret2
end




function script.QueryWeapon2()
    return turret2
end

function script.AimWeapon2(heading, pitch)
    return true
end

function script.FireWeapon2()
    return true
end

--------------------------------------------------------------------------
-- turret + two turret emiter
function script.AimFromWeapon3()
    return turret3
end




function script.QueryWeapon3()
    return turret3
end

function script.AimWeapon3(heading, pitch)


    return true
end

function script.FireWeapon3()
    return true
end

-------------------------------------------------------------------------
-- turret + two turret emiter
function script.AimFromWeapon4()
    return turret4
end

function script.QueryWeapon4()
    return turret4
end

function script.AimWeapon4(heading, pitch)

    return true
end

function script.FireWeapon4()
    return true
end


function script.AimFromWeapon5()
    return energyorb
end

function script.QueryWeapon5()
    return energyorb
end

function script.AimWeapon5(heading, pitch)

    return (ChargeUp / CHARGE_TOTAL) > 1
end

function script.FireWeapon5()
    Hide(energyorb)
    ChargeUp = ChargeUp-1
    return true
end
