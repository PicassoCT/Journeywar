--Globallos
--General Public License goes in all fields


numberOfActors = 1
dramatisPersona = {}




--This is the neverending Party Script



----------------------------------------------------
-- globallos

maxDist = 49
minIdle = 4000
maxIdle = 19000




----------------------------------------------------
forbMap = {}
--forbidden Zones
forbZone = {}
nrOfforbZones = 1
--a forbidden Zone consists at its most basic established of 4 values - two degrees (upper and lower bound) - and two distancevalues (upper and lower bound)
updegree = 180
lowdegree = -180
updist = 15
dowdist = 0
boolunitDead = false

forbZone[1] = updegree
forbZone[2] = lowdegree
forbZone[3] = updist
forbZone[4] = dowdist

forbMap[1] = forbZone


------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter1 = piece "SwingCenter1"
table.insert(person, 1, swingCenter1) --swingCenter always atfirstPlace 1

ALM = piece "ALM" -- the persons centerpiece 2
table.insert(person, 2, ALM)



AFL = piece "AFL"
AFR = piece "AFR"
AL = piece "AL"
AL2 = piece "AL2"
AR = piece "AR"
AR2 = piece "AR2"
piecetable = {} --contains the remaining pieces 3

piecetable[#piecetable + 1] = AFL

piecetable[#piecetable + 1] = AFR

piecetable[#piecetable + 1] = AL

piecetable[#piecetable + 1] = AL2

piecetable[#piecetable + 1] = AR

piecetable[#piecetable + 1] = AR2







table.insert(person, 3, piecetable)

-- a person is defined by the following values:
-- its position in degree and distance
degree = 0
table.insert(person, 4, degree)
dist = 0
table.insert(person, 5, dist)
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
table.insert(person, 6, faceValue)

-- the attached boolean (is the char attached to another in some animation)
boolIndyChar = false
table.insert(person, 7, boolIndyChar)

-- the type of char (a intvalue that represents the diffrent purposes)
--Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7, testbrick=8
typeDef = 1
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.3
table.insert(person, 10, speedPerson)
--numberOfPieces
numberOfPieces = 6
table.insert(person, 11, numberOfPieces)
table.insert(person, 12, 1)

table.insert(dramatisPersona, 1, person)




function faceValue2Degree(personNr)
    if dramatisPersona[personNr][6] == 1 then
        return 0
    elseif dramatisPersona[personNr][6] == 2 then
        return 180
    elseif dramatisPersona[personNr][6] == 4 then
        return 90
    elseif dramatisPersona[personNr][6] == 8 then
        return 270
    else
        --- -Spring.Echo("Big Mistake in faceValue2Degree")
    end
end

function degreeCompare(targetdegree, PersonNr)
    destinationdegree = dramatisPersona[PersonNr][4]
    if destinationdegree - targetdegree == 180 then
        return false
    end

    if targetdegree > destinationdegree then
        remains = targetdegree - destinationdegree
        if remains <= 180 then
            return false --counterclockwise
        else
            return true --clockwise
        end
    else
        remains = destinationdegree - targetdegree
        if remains >= 180 then
            return false --counterclockwise
        else
            return true --clockwise
        end
    end
end




------------------------------------------------------------------------------------------------------------------------------------------------
-- This is the PartyManager - this function decides were everyone goes
function NativePartyManager()





    while (true) do
        for i = 1, numberOfActors, 1 do

            if dramatisPersona[i][9] == false then --else the piece is a standaloner on the neverending party allready busy
                --determinate new Position (0 move, 1 inside, 2 outside, plus, minus) -- or idling
                were2go = math.random(0, 3)
                moveInOut = math.random(1.9, maxDist)
                --- -Spring.Echo("DegreeOfOld",dramatisPersona[i][4])
                degreeRand = math.random(0, 360) --0*360
                --- -Spring.Echo("NewDegree",degreeRand)
                if were2go == 0 or were2go == 1 then --moves in or out on the circle

                    --Enum: inside is 1,
                    --		outside is 2,
                    --		clockwise is 4,
                    --      counterclockwise its 8
                    if moveInOut < dramatisPersona[i][5] then --move out
                        ------ Spring.Echo("Moving Out")
                        dramatisPersona[i][6] = 2 --set the vacefalue up to date
                    else -- move in
                        dramatisPersona[i][6] = 1
                        ------ Spring.Echo("Moving In")
                    end
                else --moves along the circle

                    if degreeCompare(degreeRand, i) == true then --move counterclockwise

                        dramatisPersona[i][6] = 8 --bringing faceValue uptodate
                        --- -Spring.Echo("Counterclockwise")
                    else --move clockwise
                        dramatisPersona[i][6] = 4 --bringing faceValue uptodate
                        --- -Spring.Echo(" Clockwise")
                    end
                end

                --check if new position is within forbidden Territory
                if (myAuthoritaeRespectIt(i, degreeRand, moveInOut) == true or dramatisPersona[i][8] == 4) then
                    ------ Spring.Echo(i.."PersonNr Made it this far")

                    --check (if not advisor) or way is free
                    if (dramatisPersona[i][8] == 4 or isWayfree(degreeRand, moveInOut, dramatisPersona[i][4], dramatisPersona[i][5], dramatisPersona[i][6]) == true) then --FixMe
                        dramatisPersona[i][9] = true
                        StartThread(senderJobFunc, i, degreeRand, moveInOut)

                        --Start SenderThread(+roll jobtoFullFill when arriving)
                    end

                elseif dramatisPersona[i][9] == false then
                    dramatisPersona[i][9] = true
                    StartThread(idleFunc, i)

                    --Start a IdleSender
                end
            else
                -- standaloners skip the party..
            end
        end

        Sleep(500)
    end
end





----------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- check if new position is within forbidden Territory

--  forbMap={}
--forbidden Zones
--  forbZone={}
--  nrOfforbZones=1
--a forbidden Zone cons

--function returns true if the targetzone is free
function myAuthoritaeRespectIt(personNr, degreeRand, moveInOut)

    --if the person faces in or out we have to check the way from current pers pos to the move in or move out position
    if dramatisPersona[personNr][5] == 1 or dramatisPersona[personNr][5] == 2 then --the person moves in or out
        --- -Spring.Echo("PersonNr:",personNr.."moves in or out")
        for i = 1, nrOfforbZones, 1 do

            if withinBoundaries(forbMap[i][1], forbMap[i][2], dramatisPersona[personNr][4]) == true then --if the person is within the degreecone of a forbidden zone it needs to check further

                if withinBoundaries(forbMap[i][3], forbMap[i][4], moveInOut) == true then

                    --- -Spring.Echo("TryingTo Enter Forbidden Zone - moving in or out")
                    return false
                end
            end
        end
        -- if the person faces clockwise or counterclockwise we have to check
    else
        for i = 1, nrOfforbZones, 1 do
            if withinBoundaries(forbMap[i][3], forbMap[i][4], dramatisPersona[personNr][4]) == true then
                if withinBoundaries(forbMap[i][1], forbMap[i][2], degreeRand) == true then
                    --- -Spring.Echo("TryingTo Enter Forbidden zone clockwise or counterclockwise")
                    return false
                end
            end
        end
    end
    -- if  terrain is passable
    return true
    --					return false -- if destination is blocked
end




--checks if a value is between to bordervalues
--returns true if value is inside
function withinBoundaries(boundarie1, boundarie2, checkvalue)
    upperBound = 0
    lowerBoundarie = 0
    if boundarie1 > boundarie2 then
        upperBound = boundarie1
        lowerBoundarie = boundarie2
    else
        upperBound = boundarie2
        lowerBoundarie = boundarie1
    end

    if checkvalue < upperBound and checkvalue > lowerBoundarie then
        return true
    else
        return false
    end
end

--function returns true if the way doesent lead through a forbidden Zone					
function wayCheckerInsideOutside(orgDistance, moveInOut, orgDegree)
    for i = 1, nrOfforbZones, 1 do
        --check if the Zone is within the orgDegree - if yes proceed - else continue with another zone
        if withinBoundaries(forbMap[i][1], forbMap[i][2], orgDegree) == true then
            --check for every single value if its within the zones boundaries
            if withinBoundaries(forbMap[i][3], forbMap[i][4], orgDistance) == true then
                return false
            end

        else
        end
    end

    return true
end


--function: checks if the way leads to any forbidden Zone
function wayCheckerClockWise(orgDegree, moveInOut, orgDistance)
    for i = 1, nrOfforbZones, 1 do
        --check if the Zone is within the orgDegree - if yes proceed - else continue with another zone
        if withinBoundaries(forbMap[i][3], forbMap[i][4], orgDistance) == true then
            --check for every single value if its within the zones boundaries
            if withinBoundaries(forbMap[i][3], forbMap[i][4], orgDegree) == true then
                return false
            end

        else
        end
    end

    return true
end

--function checks if the way leads through any forbidden zone - warning, this checks all the zones.		
function isWayfree(degreeRand, moveInOut, orgDegree, orgDistance, FaceIng)
    --Enum: inside is 1,
    --		outside is 2,
    --		clockwise is 4,
    --      counterclockwise its 8


    if FaceIng == 1 then -- we want to check the way inside fromt he current
        return wayCheckerInsideOutside(orgDistance, moveInOut, orgDegree)
    end

    if FaceIng == 2 then -- we want to check the way inside fromt he current
        return wayCheckerInsideOutside(orgDistance, moveInOut, orgDegree)
    end

    if FaceIng == 4 then -- we want to check the way inside fromt he current
        return wayCheckerClockWise(orgDegree, moveInOut, orgDistance)
    end

    if FaceIng == 8 then -- we want to check the way inside fromt he current
        return wayCheckerClockWise(orgDegree, moveInOut, orgDistance)
    end

    return true
end


function senderJobFunc(personNr, targetdegree, targetDist)
    --Enum: inside is 1,
    --		outside is 2,
    --		clockwise is 4,
    --      counterclockwise its 8
    --Person turned into the direction it is going to walk
    if dramatisPersona[personNr][6] == 1 then
        Turn(dramatisPersona[personNr][2], y_axis, math.rad(0), 4)
        WaitForTurn(dramatisPersona[personNr][2], y_axis) --fixMe
        dramatisPersona[personNr][5] = targetDist
        Move(dramatisPersona[personNr][2], z_axis, targetDist, dramatisPersona[personNr][10] * 6)

    elseif dramatisPersona[personNr][6] == 2 then
        Turn(dramatisPersona[personNr][2], y_axis, math.rad(180), 4)
        WaitForTurn(dramatisPersona[personNr][2], y_axis)
        dramatisPersona[personNr][5] = targetDist
        Move(dramatisPersona[personNr][2], z_axis, targetDist, dramatisPersona[personNr][10] * 6)

    elseif dramatisPersona[personNr][6] == 4 then
        Turn(dramatisPersona[personNr][2], y_axis, math.rad(90), 4)
        WaitForTurn(dramatisPersona[personNr][2], y_axis)
        dramatisPersona[personNr][4] = targetdegree
        Turn(dramatisPersona[personNr][1], y_axis, math.rad(targetdegree), dramatisPersona[personNr][10])

    elseif dramatisPersona[personNr][6] == 8 then
        Turn(dramatisPersona[personNr][2], y_axis, math.rad(270), 4)
        WaitForTurn(dramatisPersona[personNr][2], y_axis)
        dramatisPersona[personNr][4] = targetdegree
        Turn(dramatisPersona[personNr][1], y_axis, math.rad(targetdegree), dramatisPersona[personNr][10])
    end
    Sleep(2)
    --send the person on its way.
    typeDependedWalkAnimation(personNr, dramatisPersona[personNr][8],dramatisPersona3d)

    --now we update the current position
    if dramatisPersona[personNr][6] == 1 or dramatisPersona[personNr][6] == 2 then
        dramatisPersona[personNr][5] = targetDist
    else
        dramatisPersona[personNr][4] = targetdegree
    end



    -- we turn the persona into a random direction
    --randomTurn=math.random(0,360)
    --Turn(dramatisPersona[personNr][1],y_axis,math.rad(randomTurn),dramatisPersona[personNr][10])

    -- now we need a Time, and a idleanimation so the person arriving at the ways end, doesent just stands around
    idleTime = math.random(minIdle, maxIdle)
    spendTime = 0
    while (spendTime < idleTime) do
        typeDependedIdleAnimation(personNr, dramatisPersona[personNr][8])
        spendTime = spendTime + 4000
        Sleep(50)
    end
    -- we return the random direction

    --finally we set the unit back into jobless mode, so the partymanager can grab it again, and send it on its way
    dramatisPersona[personNr][9] = false
end

function stillMoving(personNr, dramatisPersona3d)
    if (true == Spring.UnitScript.IsInMove(dramatisPersona[personNr][2], z_axis) or true == Spring.UnitScript.IsInTurn(dramatisPersona[personNr][1], y_axis)) then
        return true
    else
        return false
    end
end

function typeDependedWalkAnimation(personNr, personTypeNr,dramatisPersona3d)
    --Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7, testbrick=8

    if personTypeNr == 1 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation1(personNr)
        end
    elseif personTypeNr == 2 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation2(personNr)
        end
    elseif personTypeNr == 3 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation3(personNr)
        end
    elseif personTypeNr == 4 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation4(personNr)
        end
    elseif personTypeNr == 5 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation5(personNr)
        end
    elseif personTypeNr == 6 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation6(personNr)
        end
    elseif personTypeNr == 7 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation7(personNr)
        end
    elseif personTypeNr == 8 then
        while (stillMoving(personNr, dramatisPersona3d)) do
            walkAnimation8(personNr)
        end
    else
        ------ Spring.Echo("Error in the typeDependedWalkAnimation")
    end
end

function typeDependedIdleAnimation(personNr, personTypeNr)
    --Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7,

    if personTypeNr == 1 then
        idleAnimation1(personNr)
        return

    elseif personTypeNr == 2 then
        idleAnimation2(personNr)
        return

    elseif personTypeNr == 3 then
        idleAnimation3(personNr)
        return

    elseif personTypeNr == 4 then
        idleAnimation4(personNr)
        return

    elseif personTypeNr == 5 then
        idleAnimation5(personNr)
        return

    elseif personTypeNr == 6 then
        idleAnimation6(personNr)
        return

    elseif personTypeNr == 7 then
        idleAnimation7(personNr)
        return


    else
        ------ Spring.Echo("Error in the typeDependedWalkAnimation")
        return
    end
end





function idleFunc(personNr)
    ------ Spring.Echo("Idling in the function")
    Sleep(4000)
    dramatisPersona[personNr][9] = false
end
