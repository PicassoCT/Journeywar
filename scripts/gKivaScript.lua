--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center = piece "center"



function script.Create()
    StartThread(Emit)
    Move(center, y_axis, -110, 0)
    Move(center, y_axis, 0, 0.6)
end

function Emit()
    local emitor = piece "emitor"
    while true do
        EmitSfx(emitor, 1024)
        Sleep(10)
    end
end

function script.Killed(recentDamage, _)
end

gaiaTeam = Spring.GetUnitTeam(unitID)

x, y, z = Spring.GetUnitPosition(unitID)
function script.HitByWeapon(x, z, weaponDefID, damage)
    if damage > 10 and math.random(0, 13) == 5 then
        deci = -1
        if math.random(0, 1) then deci = math.abs(deci) end
        deci = deci * 150
        Spring.CreateUnit("grewardbox", x + deci, 0, z - (deci * math.random(-1, 1)), 1, gaiaTeam)
    end
end