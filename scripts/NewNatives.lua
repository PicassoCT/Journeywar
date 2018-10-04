function walkAnimation1(personNr)
    Turn(ALM, x_axis, math.rad(5), 4)
    Turn(AFR, x_axis, math.rad(15), 4)
    Turn(AFL, x_axis, math.rad(-36), 7)

    Turn(AR, x_axis, math.rad(30), 6)
    Turn(AR, z_axis, math.rad(-21), 6)
    Turn(AL, z_axis, math.rad(0), 6)
    Turn(AL, z_axis, math.rad(-42), 6)

    Turn(AL2, x_axis, math.rad(-42), 6)
    Turn(AL2, z_axis, math.rad(25), 6)

    Turn(AR2, x_axis, math.rad(23), 6)
    Turn(AR2, z_axis, math.rad(0), 6)


    Sleep(450)
    Turn(ALM, x_axis, math.rad(15), 4)
    Turn(AFL, x_axis, math.rad(15), 4)
    Turn(AFR, x_axis, math.rad(-36), 7)

    Turn(AL, x_axis, math.rad(30), 6)
    Turn(AL, z_axis, math.rad(-21), 6)
    Turn(AR, z_axis, math.rad(0), 6)
    Turn(AR, z_axis, math.rad(-42), 6)

    Turn(AR2, x_axis, math.rad(-42), 6)
    Turn(AR2, z_axis, math.rad(25), 6)

    Turn(AL2, x_axis, math.rad(23), 6)
    Turn(AL2, z_axis, math.rad(0), 6)

    Sleep(450)
end

function idleAnimation1(personNr)
    Turn(ALM, x_axis, math.rad(0), 4)
    Turn(AFR, x_axis, math.rad(0), 4)
    Turn(AFL, x_axis, math.rad(0), 7)

    Turn(AL, x_axis, math.rad(0), 6)
    Turn(AL, z_axis, math.rad(0), 6)
    Turn(AR, z_axis, math.rad(0), 6)
    Turn(AR, z_axis, math.rad(0), 6)

    Turn(AR2, x_axis, math.rad(0), 6)
    Turn(AR2, z_axis, math.rad(0), 6)

    Turn(AL2, x_axis, math.rad(0), 6)
    Turn(AL2, z_axis, math.rad(0), 6)

    if math.random(0, 1) == 1 then
        Turn(AR, x_axis, math.rad(-34), 6)
        Move(ALM, y_axis, -1.6, 2.25)
        Turn(ALM, x_axis, math.rad(-20), 4)
        Turn(AFR, x_axis, math.rad(104), 7)
        Turn(AFL, x_axis, math.rad(104), 7)
        Sleep(12000)
        Move(ALM, y_axis, 0, 12)
        Turn(AFR, x_axis, math.rad(0), 7)
        Turn(AFL, x_axis, math.rad(0), 7)
    end
end




