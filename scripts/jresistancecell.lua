Tire = {}
for i = 1, 6, 1 do
    Tire[i] = {}
    temp = "Tire" .. i
    Tire[i] = piece(temp)
end

Armed = piece "Armed"

Torso = {}
for i = 1, 4, 1 do
    Torso[i] = {}
    temp = "TorsoRota" .. i
    Torso[i] = piece(temp)
end

rotor = piece "rotor"


local boolIsActive = false
local range = 180

local SIG_WALK = 1 --signal for the walk animation thread


function spinTires()

    for i = 1, 6, 1 do
        Spin(Tire[i], x_axis, math.rad(62), 0.1)
    end
end

--definitiv verdachtsunabh�ngige Kontrolle
function isUnitAGangsta(BigAndBlack)
    sirMayISeeYourIdPlease = nil
    sirMayISeeYourIdPlease = Spring.GetUnitDefID(BigAndBlack)

    if sirMayISeeYourIdPlease == nil then
        return false
    else
        if sirMayISeeYourIdPlease == UnitDefNames["cdistrictnone"].id or sirMayISeeYourIdPlease == UnitDefNames["cscumslum"].id then
            return true
        else
            return false
        end
    end
end

function spawnAResistanceOutpost()
    local x, y, z = Spring.GetUnitPosition(unitID)
    local teamID = Spring.GetUnitTeam(unitID)
    --create Outpost
    mexID = Spring.CreateUnit("jresistanceoutpost", x, y, z, 0, teamID)
    --set Unit Invisible to other teams
    Spring.SetUnitBlocking(mexID, false, false, false)

    if (Spring.ValidUnitID(mexID)) == true then

        Spring.DestroyUnit(unitID, false, true)
    else
        --Spring.Echo("You tried so tard, and yet you phailed, but in the end, it doesent really beta!")
    end
end


function buildingWatcher()
    while (true) do
        if boolIsActive == true then
            unitsNearby = {}
            x, y, z = Spring.GetUnitPosition(unitID)
            if x ~= nil then
                unitsNearby = Spring.GetUnitsInCylinder(x, z, range)
                table.remove(unitsNearby, unitID)
                if unitsNearby ~= nil and table.getn(unitsNearby) ~= 0 then
                    boolCanActivate = false
                    for i = 1, table.getn(unitsNearby), 1 do
                        booltemp = isUnitAGangsta(unitsNearby[i])
                        if booltemp == true then
                            boolCanActivate = true
                        end
                    end
                    if boolCanActivate == true then
                        spawnAResistanceOutpost()
                    end
                end
            end
        end


        Sleep(100)
    end
end

function script.Activate()

    boolIsActive = true

    return 1
end

function script.Deactivate()
    boolIsActive = false

    return 0
end

function spinRotor()
    Turn(rotor, y_axis, math.rad(-8), 0)
    Spin(rotor, z_axis, math.rad(182), 0)
end

function script.Create()
    spinRotor()
    StartThread(buildingWatcher)
end

function anfahren()
    SetSignalMask(SIG_WALK)
    Turn(Torso[3], x_axis, math.rad(13), 9)
    Turn(Torso[2], z_axis, math.rad(10), 9)
    Turn(Torso[1], x_axis, math.rad(14), 9)
    Turn(Torso[4], x_axis, math.rad(12), 9)
    Sleep(800)
    Turn(Torso[3], x_axis, math.rad(0), 5)
    Turn(Torso[2], z_axis, math.rad(0), 6)
    Turn(Torso[1], x_axis, math.rad(0), 7)
    Turn(Torso[4], x_axis, math.rad(0), 2)
end


function abbremsen()
    SetSignalMask(SIG_WALK)
    Turn(Torso[3], x_axis, math.rad(-13), 9)
    Turn(Torso[2], z_axis, math.rad(-10), 9)
    Turn(Torso[1], x_axis, math.rad(-14), 9)
    Turn(Torso[4], x_axis, math.rad(-12), 9)
    Sleep(800)
    Turn(Torso[3], x_axis, math.rad(0), 5)
    Turn(Torso[2], z_axis, math.rad(0), 2)
    Turn(Torso[1], x_axis, math.rad(0), 5)
    Turn(Torso[4], x_axis, math.rad(0), 6)
end

--http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units

function mundanianToTheBeach()
    SetSignalMask(SIG_WALK)
    while (true) do
        y = math.random(-26, 52)
        x = math.random(-82, 31)
        s = math.random(5, 22)
        Turn(Armed, y_axis, math.rad(y), s)
        Turn(Armed, x_axis, math.rad(x), s)
        WaitForTurn(Armed, x_axis)
        randSleep = math.random(1, 600)
        Sleep(randSleep)
    end
end

function script.Killed(recentDamage, maxHealth)


    return 1
end



function script.StartMoving()
    Signal(SIG_WALK)
    spinTires()
    StartThread(anfahren)
    StartThread(mundanianToTheBeach)
end

function script.StopMoving()
    Signal(SIG_WALK)

    for i = 1, 6, 1 do
        StopSpin(Tire[i], x_axis)
    end
    StartThread(abbremsen)
end

