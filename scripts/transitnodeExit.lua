include "createCorpse.lua"

Wheel1 = piece "Wheel1"
Wheel2 = piece "Wheel2"
Low1 = piece "Low1"
Low2 = piece "Low2"


LED = {}


DecoderArray = {}


DecoderArray[0] = {	1, 	1	,1	,1	,1	,1	,0}
DecoderArray[1] = {	0, 	1 	,1 	,0 	,0 	,0 	,0}
DecoderArray[2] = {	1, 	1 	,0 	,1 	,1 	,0 	,1}
DecoderArray[3] = {	1, 	1 	,1 	,1 	,0 	,0 	,1}
DecoderArray[4] = {	0, 	1 	,1 	,0 	,0 	,1 	,1}
DecoderArray[5] = {	1, 	0 	,1 	,1 	,0 	,1 	,1}
DecoderArray[6] = {	1, 	0 	,1 	,1 	,1 	,1 	,1}
DecoderArray[7] = {	1, 	1 	,1 	,0 	,0 	,0 	,0}
DecoderArray[8] = {	1, 	1 	,1 	,1 	,1 	,1 	,1}
DecoderArray[9] = {	1, 	1 	,1 	,1 	,0 	,1 	,1}


function binary(num)
    -- returns a table of bits, least significant first.
    local t = {} -- will contain the bits
    while num > 0 do
        rest = math.fmod(num, 2)
        t[#t + 1] = rest
        num = (num - rest) / 2
    end
    return t
end


function littleCarsGoingBackAndForth()
    while true do
        Move(Low1, z_axis, 120, 45)
        Move(Low2, z_axis, -110, 45)
        WaitForMove(Low2, z_axis)
        WaitForMove(Low1, z_axis)
        Move(Low1, z_axis, 0, 0)
        Move(Low2, z_axis, 0, 0)
        rand = math.ceil(math.random(10, 1000))
        Sleep(rand)
    end
end


function sound()
    while (true) do
        Spring.PlaySoundFile("sounds/ctransithub/traffic.wav", 0.8)
        Sleep(3500)
        dice = math.random(1, 128)
        if dice == 99 then
            Spring.PlaySoundFile("sounds/ctransithub/trafficnodepolice.wav", 0.8)
            Sleep(4000)
        end
    end
end

function display7DigitNumber(number)

    firstDigit = number % 11
    if firstDigit == 10 then firstDigit = 0 end
    secondDigit = math.floor(number / 10)


    tx = DecoderArray[firstDigit]
    ty = DecoderArray[secondDigit]

    for i = 1, 7, 1 do
        if tx[i] == 0 then Hide(LED[i]) else Show(LED[i]) end
    end

    for i = 8, 14, 1 do
        if ty[i] == 0 then Hide(LED[i]) else Show(LED[i]) end
    end
end


function script.Create()
	TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
	LED = TablesOfPiecesGroups["LED"]
	hideT(LED)

    StartThread(sound)
    StartThread(littleCarsGoingBackAndForth)

    Spin(Wheel1, z_axis, math.rad(-70), 0)
    Spin(Wheel2, z_axis, math.rad(70), 0)
    --StartThread(main)
	display7DigitNumber(GG.TransitHubNumber[unitID] or 0)
end

function script.Killed(recentDamage, _)
    createCorpseCBuilding(unitID, recentDamage)
    return 0
end