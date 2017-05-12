--<pieces>

teamID = Spring.GetUnitTeam(unitID)
pieces = {}
fourRay = {}
boats = {}
afloat = piece "afloat"

for i = 1, 8, 1 do
    boats[i] = {}
    temp = "boat" .. i
    boats[i] = piece(temp)
end

for i = 1, 13, 1 do
    if i == 4 then
        for j = 1, 5, 1 do
            fourRay[j] = {}
            temp = i .. j
            fourRay[j] = piece(temp)
        end
    end
    pieces[i] = {}
    temp = "" .. i
    pieces[i] = piece(temp)
end

function builder()
    HideArray(boats)
    HideArray(pieces)
    HideArray(fourRay)

    x, y, z = Spring.GetUnitPosition(unitID)
    y = Spring.GetGroundHeight(x, z)

    if y < -7 then
        ShowArray(boats)
        randDegAry(boats)
        Move(afloat, y_axis, -1 * y, 0)
    else

        if GG.MasterBuilder == nil or GG.MasterBuilder >= table.getn(pieces) then
            GG.MasterBuilder = 1
        else
            GG.MasterBuilder = GG.MasterBuilder + 1
        end
        if GG.MasterBuilder == 6 then

            GG.UnitsToSpawn:PushCreateUnit("gdecbordell", x, 0, z, 0, teamID)
        end

        Show(pieces[GG.MasterBuilder])
        if GG.MasterBuilder == 4 then
            ShowArray(fourRay)
            spinArray(fourRay)
        end
    end
end

function HideArray(ar)
    for i = 1, #ar, 1 do
        Hide(ar[i])
    end
end

function randDegAry(ar)
    for i = 1, #ar, 1 do
        rand = math.random(-80, 90)
        Turn(ar[i], y_axis, math.rad(rand), 0)
    end
end

function spinArray(ar)
    for i = 1, #ar, 1 do
        rand = math.random(-80, 90)
        Spin(ar[i], y_axis, math.rad(rand), 0)
    end
end

function ShowArray(ar)
    for i = 1, #ar, 1 do
        Show(ar[i])
    end
end

center = piece "center"



function script.Create()


    builder()
    d = math.random(0, 3)
    Turn(center, y_axis, math.rad(90 * d), 0)
end

function script.Killed(recentDamage, _)

    --</ciVillian>
    return 1
end

--</RubbleScript>
	
	



