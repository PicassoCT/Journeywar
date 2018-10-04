--this animation library contains functions to animate biologicial seeming units (Mainly Journeyman)


--function bow (listOfPieces,degree, direction, posOrNeg,speed, boolWait)
function bow(ArrayOfPieces, degreeAsAWhole, dirActionXYZ, speed, boolWait, napTime)
    NumberOfPieces = table.getn(ArrayOfPieces)
    partDegree = degreeAsAWhole / NumberOfPieces
    axis = ""

    if dirActionXYZ == "x_axis" or dirActionXYZ == "x" or dirActionXYZ == "X" or dirActionXYZ == "X_axis" then
        axis = x_axis
    elseif dirActionXYZ == "y_axis" or dirActionXYZ == "y" or dirActionXYZ == "Y" or dirActionXYZ "Y_axis" then
        axis = "y_axis"
    else
        axis = z_axis
    end

    for i = 1, NumberOfPieces, 1 do
        Turn(ArrayOfPieces[i], axis, math.rad(partDegree), speed)
    end
    if boolWait == true then
        WaitForTurn(ArrayOfPieces[NumberOfPieces], axis)
    else
        Sleep(napTime)
    end
end

function moduluRemains(NumberOfPieces, NrOfRipples)
    return NumberOfPieces % NrOfRipples
end

function divByFour(NumberOfPieces)
    result = math.floor(NumberOfPieces / 4)
    return result
end

function negInvert(value)
    if value < 0 then
        return value * -1
    else
        return value
    end
end

function divideDegree(nrOfPiece, Pieces, degree)
    if Pieces % 2 == 0 then
        numberOfIterations = Pieces / 2
        generation = numberOfIterations - nrOfPiece
        generation = negInvert(generation)

        degreePercentage = 0.5

        for i = 1, generation, 1 do
            degreePercentage = degreePercentage / 2
        end
        --Spring.Echo(degreePercentage)
        reSult = degreePercentage * degree
        return reSult


    else
        maxpiece = math.floor(Pieces / 2) + 1

        numberOfIterations = (Pieces - 1) / 2
        generation = numberOfIterations - nrOfPiece
        generation = negInvert(generation) - 1
        degreePercentage = 0.25
        for i = 1, generation, 1 do
            degreePercentage = degreePercentage / 2
        end

        --Spring.Echo(degreePercentage)
        reSult = degreePercentage * degree
        return reSult
    end
end

function moduLater(nr)
    nr = nr - (nr % 1)
    return nr
end

--function ripple(listOfPieces,degree, direction, NrOfRipples speed, boolWait)
-- every WaveRipple consists of a beginn at Zero, a Depression, the actual Ripple plus the Return to Zero.
-- the number of pieces should be modulate 
function ripple(ArrayOfPieces, maxInDegree, dirActionXYZ, NrOfRipples, speed, boolWait, napTime)
    --Preparation Stage
    NumberOfPieces = table.getn(ArrayOfPieces)
    RemainingPieces = moduluRemains(NumberOfPieces, NrOfRipples)
    NumberOfPiecesPerRipple = (NumberOfPieces - moduluRemains(NumberOfPieces, NrOfRipples)) / NrOfRipples



    if dirActionXYZ == "x_axis" or dirActionXYZ == "x" or dirActionXYZ == "X" or dirActionXYZ == "X_axis" then
        axis = x_axis
    elseif dirActionXYZ == "y_axis" or dirActionXYZ == "y" or dirActionXYZ == "Y" or dirActionXYZ "Y_axis" then
        axis = y_axis
    else
        axis = z_axis
    end
    fourRoarPieces = divByFour(NumberOfPiecesPerRipple)
    pDeeGree = maxInDegree / fourRoarPieces * 10
    --Spring.Echo("Rippley Here")
    --Execution Stage
    for out = 1, NrOfRipples, 1 do
        --for the nr of ripples

        --iterate through the nr of pieces attached to the ripple
        for rip = moduLater(out * NumberOfPiecesPerRipple), moduLater((out + 1) * NumberOfPiecesPerRipple), 1 do
            -- first part of the wave - negative an sinking
            for i = rip, fourRoarPieces, 1 do

                Turn(ArrayOfPieces[i], axis, math.rad((360 - divideDegree(i, fourRoarPieces, maxInDegree))), speed)
            end




            -- second Part of the wave, rising to zero
            for i = moduLater(rip + fourRoarPieces), moduLater(fourRoarPieces * 2), 1 do
                Turn(ArrayOfPieces[i], axis, math.rad((divideDegree(i, fourRoarPieces, maxInDegree))), speed)
            end


            --third part of the wave, rising to positive
            for i = rip + 2 * fourRoarPieces, fourRoarPieces * 3, 1 do
                Turn(ArrayOfPieces[i], axis, math.rad((divideDegree(i, fourRoarPieces, maxInDegree))), speed)
            end

            --fourth falling to zero
            for i = moduLater(rip + 3 * fourRoarPieces), moduLater(fourRoarPieces * 4), 1 do
                Turn(ArrayOfPieces[i], axis, math.rad((360 - divideDegree(i, fourRoarPieces, maxInDegree))), speed)
            end
        end
        --Waiting Stage
        if boolWait == true then
            WaitForTurn(ArrayOfPieces[NumberOfPieces], axis)
        else
            Sleep(napTime)
        end
    end
end