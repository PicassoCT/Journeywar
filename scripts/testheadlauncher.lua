walls = {}
for i = 1, 3, 1 do
    walls[i] = {}
    walls[i][1] = {}
    walls[i][1] = piece "Wall" .. i
    walls[i][2] = {}
    walls[i][2] = false
end

function damageProhibitor()
    oldHealth = Spring.GetUnitHealth(unitID)
    newHealth = oldHealth
    while (true) do
        newHealth = Spring.GetUnitHealth(unitID)
        if boolVurnerable == true and newHealth ~= oldHealth then
            --allow Damage
            newHealth = oldHealth
        else
            Spring.SetUnitHealth(unitID, oldHealth) --TODO
        end
        Sleep(150)
    end
end

boolVurnerable = false
function invinCible()

    while (true) do
        tempBool = true
        for i = 1, 3, 1 do
            if walls[i][2] == false then tempBool = false end
        end
        boolVurnerable = tempBool

        Sleep(50)
    end
end

function getFreeWall()
    for i = 4, 6, 1 do
        if walls[i][2] == false then return i - 3 end
    end
    return nil
end

--insert Function into HitBy Call
function rotateWallsDependingUponHit(degree)
    temPiece = getFreeWall()
    if temPiece ~= nil then
        Turn(walls[temPiece][1], y_axis, math.rad(degree), 90)
        Move(walls[temPiece][1], y_axis, 0, 12)
        Show(walls[temPiece][1])
        walls[temPiece][2] = true
    end
end