center = piece "center"
body = piece "body"
wings1 = piece "wings1"
wings2 = piece "wings2"
wings = {}
for i = 1, 8, 1 do
    wings[i] = {}
    temp = "wing" .. i
    wings[i] = piece(temp)
end

function script.Activate()
    --activates the secondary weapon

    return 1
end

function script.Deactivate()
    --deactivates the secondary weapon


    return 0
end

boolMoving = false

wingSpeed = 1
function wingsClap()
    while true do
        up = math.random(9, 22)
        Turn(wings1, z_axis, math.rad(up), wingSpeed * 2)
        Turn(wings2, z_axis, math.rad(-up), wingSpeed * 2)
        WaitForTurn(wings2, z_axis)
        Turn(wings1, z_axis, math.rad(-up), wingSpeed)
        Turn(wings2, z_axis, math.rad(up), wingSpeed)
        WaitForTurn(wings2, z_axis)
    end
end

function upAndDown()
    while true do
        centerUp = math.random(2, 12)
        Move(center, y_axis, centerUp, 1.234)
        wingSpeed = math.random(2.13, 3.14)
        WaitForMove(center, y_axis)
        centerDown = math.random(-12, -2)
        Move(center, y_axis, centerDown, 2.8)
        wingSpeed = math.random(1.41, 2.4)
        WaitForMove(center, y_axis)
    end
end



function script.StartMoving()
    boolMoving = true
end

function script.StopMoving()
    boolMoving = false
end





function script.Create()
    for i = 1, 8, 1 do
        Hide(wings[i])
    end
    x = math.random(1, 4)
    x = x * 2
    Show(wings[x])
    Show(wings[x - 1])


    StartThread(upAndDown)
    StartThread(wingsClap)
end

function script.Killed()

    return 0
end