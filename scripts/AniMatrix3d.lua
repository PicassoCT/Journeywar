--TODO
--Car Animatrix: Contains the AnimMatrix expanded into the third Dimension



--needs a expansion on the forbidden zones 

-- either going in a big circle or crossroads.. - or small circle and landing
-- if move out of a certain range Math.random(0,1,2,3) 

-- direction decision (up-down //with a spiraling corresponding animations)

--animation (start/landing) (kein Stop)

--landing anim nur at certain points (with vannishing off the vehicles ) typeCheck on the building

-- collision avoidance, jedes vehicel setzt seine eigene forbidden Zone






--Globallos
--General Public License goes in all fields
testCenter = piece "testCenter"

numberOfActors = 15
dramatisPersona3d = {}








----------------------------------------------------
-- globallos

M3dmaxDist = 45
M3dminDist = 0
M3dmaxHeight = 100
M3dminHeight = 0


minIdle = 500
maxIdle = 1000




----------------------------------------------------
M3dforbMap = {}
--forbidden Zones
M3dforbZone = {}
M3dnrOfforbZones = 1
--a forbidden Zone consists at its most basic established of 4 values - two degrees (upper and lower bound) - and two distancevalues (upper and lower bound)
M3dfbupdegree = 360
M3dfblowdegree = 0
M3dfbupdist = 90
M3ddowdist = 20
M3dfbmaxHeight = 0
M3dfbminHeight = 0

boolunitDead = false

table.insert(M3dforbZone, 1, M3dfbupdegree)
table.insert(M3dforbZone, 2, M3dfblowdegree)
table.insert(M3dforbZone, 3, M3dfbupdist)
table.insert(M3dforbZone, 4, M3ddowdist)
table.insert(M3dforbZone, 5, M3dfbmaxHeight)
table.insert(M3dforbZone, 6, M3dfbminHeight)

table.insert(M3dforbMap, 1, M3dforbZone)

-----------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter1 = piece "swingCenter1"
person[1] = swingCenter1 --swingCenter always atfirstPlace 1

car1 = piece "car1" -- the persons centerpiece 2
person[2] = car1








person[3] = piecetable

-- a person is defined by the following values:
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread, even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1
--its height in the 3dmatrixgrid
height = 0
person[13] = height



dramatisPersona3d[1] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter2 = piece "swingCenter2"
person[1] = swingCenter2 --swingCenter always atfirstPlace 1

car2 = piece "car2" -- the persons centerpiece 2
person[2] = car2








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid

-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1
height = 0
person[13] = height

dramatisPersona3d[2] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter3 = piece "swingCenter3"
person[1] = swingCenter3 --swingCenter always atfirstPlace 1

car3 = piece "car3" -- the persons centerpiece 2
person[2] = car3








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[3] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter4 = piece "swingCenter4"
person[1] = swingCenter4 --swingCenter always atfirstPlace 1

car4 = piece "car4" -- the persons centerpiece 2
person[2] = car4








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread, even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[4] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter5 = piece "swingCenter5"
person[1] = swingCenter5 --swingCenter always atfirstPlace 1

car5 = piece "car5" -- the persons centerpiece 2
person[2] = car5








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread, even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[5] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter6 = piece "swingCenter6"
person[1] = swingCenter6 --swingCenter always atfirstPlace 1

car6 = piece "car6" -- the persons centerpiece 2
person[2] = car6








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread, even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[6] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter7 = piece "swingCenter7"
person[1] = swingCenter7 --swingCenter always atfirstPlace 1

car7 = piece "car7" -- the persons centerpiece 2
person[2] = car7








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[7] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy]= swingCenter beeing the Center
swingCenter8 = piece "swingCenter8"
person[1] = swingCenter8 --swingCenter always atfirstPlace 1

car8 = piece "car8" -- the persons centerpiece 2
person[2] = car8








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[8] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter9 = piece "swingCenter9"
person[1] = swingCenter9 --swingCenter always atfirstPlace 1

car9 = piece "car9" -- the persons centerpiece 2
person[2] = car9








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(0.4, 1.2)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[9] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy]= swingCenter beeing the Center
swingCenter10 = piece "swingCenter10"
person[1] = swingCenter10 --swingCenter always atfirstPlace 1

car10 = piece "car10" -- the persons centerpiece 2
person[2] = car10








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(0.4, 1.2)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[10] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter11 = piece "swingCenter11"
person[1] = swingCenter11 --swingCenter always atfirstPlace 1

car11 = piece "car11" -- the persons centerpiece 2
person[2] = car11








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread, even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[11] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter12 = piece "swingCenter12"
person[1] = swingCenter12 --swingCenter always atfirstPlace 1

car12 = piece "car12" -- the persons centerpiece 2
person[2] = car12








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[12] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter13 = piece "swingCenter13"
person[1] = swingCenter13 --swingCenter always atfirstPlace 1

car13 = piece "car13" -- the persons centerpiece 2
person[2] = car13








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1]=
--		outside is 2]=
--		clockwise is 4]=
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1]= woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces

person[12] = 1

dramatisPersona3d[13] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter14 = piece "swingCenter14"
person[1] = swingCenter14 --swingCenter always atfirstPlace 1

car14 = piece "car14" -- the persons centerpiece 2
person[2] = car14








person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread]= even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[14] = person
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter15 = piece "swingCenter15"
person[1] = swingCenter15 --swingCenter always atfirstPlace 1

car15 = piece "car15" -- the persons centerpiece 2
person[2] = car15


person[3] = piecetable

-- a person is defined by the following values:   --its height in the 3dmatrixgrid
height = 0
person[13] = height
-- its position in degree and distance
degree = 0
person[4] = degree
dist = 0
person[5] = dist
-- its facing value --all units start facing .. outside
--Enum: inside is 1,
--		outside is 2,
--		clockwise is 4,
--      counterclockwise its 8

faceValue = 2
person[6] = faceValue

-- the attached boolean (is the char attached to another in some animation
boolIndyChar = false
person[7] = boolIndyChar

-- the type of char (a intvalue that represents the diffrent purposes
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef = 7
person[8] = typeDef
--boolean on its way (has a thread, even if it is just to idle
boolOnItsWay = false
person[9] = boolOnItsWay
-- speedvalue of the the person
speedPerson = math.random(1.1, 2.4)
person[10] = speedPerson
--numberOfPieces
numberOfPieces = 1
person[11] = numberOfPieces
person[12] = 1

dramatisPersona3d[15] = person


-----------------------------------------------------------------------------------------------------------------------------------------------
function faceValue2Degree(personNr)
    if dramatisPersona3d[personNr][6] == 1 then
        return 0
    elseif dramatisPersona3d[personNr][6] == 2 then
        return 180
    elseif dramatisPersona3d[personNr][6] == 4 then
        return 90
    elseif dramatisPersona3d[personNr][6] == 8 then
        return 270
    else
        --Spring.Echo("Error in faceValue2Degree")
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------
-- This is the PartyManager - this function decides were everyone goes
function PartyManager()
    --Spring.Echo("PartyManager Activated")

    --FixMe



    while (true) do
        for i = 1, numberOfActors, 1 do

            if dramatisPersona3d[i][9] == false then --else the piece is a standaloner on the neverending party allready busy


                moveInOut = 1
                degreeRand = 2 --0*360 in 45 degree Steps

                StartThread(senderJobFunc, i, degreeRand, moveInOut)
            end
        end

        Sleep(250)
    end
end





function senderJobFunc(personNr, targetdegree, targetDist)
    dramatisPersona3d[personNr][9] = true
    targetDist = 800
    targetdegree = 90
    targetHeight = 120
    --if car views inside
    if dramatisPersona3d[personNr][6] == 1 and dramatisPersona3d[personNr][13] <= 0 then
        --move it through the center  move along center axis -lower Axis
        Turn(dramatisPersona3d[personNr][2], y_axis, math.rad(0), 4)
        WaitForTurn(dramatisPersona3d[personNr][2], y_axis)
        dramatisPersona3d[personNr][5] = targetDist
        Move(dramatisPersona3d[personNr][2], z_axis, targetDist, dramatisPersona3d[personNr][10] * 6)
        x = (dramatisPersona3d[personNr][6])
        y = (dramatisPersona3d[personNr][13])
        --assert(x)
        --assert(y)

    elseif dramatisPersona3d[personNr][6] == 2 and dramatisPersona3d[personNr][13] > 0 then
        --if car views outside beeing high, turn right, turn along radiant via SwingCenter - +down

        Turn(dramatisPersona3d[personNr][2], y_axis, math.rad(90), 4) --FixMe
        WaitForTurn(dramatisPersona3d[personNr][2], y_axis)
        dramatisPersona3d[personNr][4] = targetdegree
        Move(dramatisPersona3d[personNr][2], y_axis, 0, dramatisPersona3d[personNr][10] * 1.4)
        dramatisPersona3d[personNr][13] = 0
        Turn(dramatisPersona3d[personNr][1], y_axis, math.rad(targetdegree), dramatisPersona3d[personNr][10])
    elseif dramatisPersona3d[personNr][6] == 4 then

        --if car turned right nach innen drehen, move along the uper axis

        Turn(dramatisPersona3d[personNr][2], y_axis, math.rad(180), 4)
        WaitForTurn(dramatisPersona3d[personNr][2], y_axis)
        dramatisPersona3d[personNr][5] = targetDist
        Move(dramatisPersona3d[personNr][2], z_axis, m(targetDist), dramatisPersona3d[personNr][10] * 6)

    elseif dramatisPersona3d[personNr][6] == 8 then

        Turn(dramatisPersona3d[personNr][2], y_axis, math.rad(270), 4) --FixMe
        WaitForTurn(dramatisPersona3d[personNr][2], y_axis)
        dramatisPersona3d[personNr][4] = targetdegree
        Move(dramatisPersona3d[personNr][2], y_axis, targetHeight, dramatisPersona3d[personNr][10] * 1.4)
        dramatisPersona3d[personNr][13] = targetHeight
        Turn(dramatisPersona3d[personNr][1], y_axis, math.rad(m(targetdegree)), dramatisPersona3d[personNr][10])
    end


    --if car views outside beeing beeing low turn  turn left

    --Enum: inside is 1,
    --		outside is 2,
    --		clockwise is 4,
    --      counterclockwise its 8
    --Person turned into the direction it is going to walk

    --send the person on its way.
    typeDependedWalkAnimation(personNr, dramatisPersona3d[personNr][8],dramatisPersona3d)

    --now we update the current position




    -- we turn the persona into a random direction
    --randomTurn=math.random(0,360)
    --Turn(dramatisPersona3d[personNr][1],y_axis,math.rad(randomTurn),dramatisPersona3d[personNr][10])

    -- now we need a Time, and a idleanimation so the person arriving at the ways end, doesent just stands around

    -- we return the random direction

    --finally we set the unit back into jobless mode, so the partymanager can grab it again, and send it on its way
    dramatisPersona3d[personNr][9] = false
end

function stillMoving(personNr,dramatisPersona3d)
    --Spring.Echo("Move0")
    piece2 = dramatisPersona3d[personNr][2]
    assert(piece2)
    --Spring.Echo("Move1")
    piece1 = dramatisPersona3d[personNr][1]
    assert(piece1)
    --Spring.Echo("Move2")
    if true == Spring.UnitScript.IsInMove(piece2, z_axis) or true == Spring.UnitScript.IsInTurn(piece1, y_axis) then
        return true
    end
    --Spring.Echo("Move3")

else
return false
--Spring.Echo("Move4")
end



function typeDependedWalkAnimation(personNr, personTypeNr,dramatisPersona3d)
--Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7, testbrick=8
--Spring.Echo("Enter")
while stillMoving(personNr, dramatisPersona3d) do
Turn(dramatisPersona3d[personNr][2], x_axis, math. rad(5), 2)
WaitForTurn(dramatisPersona3d[personNr][2], x_axis)
Turn(dramatisPersona3d[personNr][2], x_axis, math. rad(2), 2)
WaitForTurn(dramatisPersona3d[personNr][2], x_axis)
end
Turn(dramatisPersona3d[personNr][2], x_axis, math. rad(0), 2)
--- -Spring.Echo("Error in the typeDependedWalkAnimation")
end








