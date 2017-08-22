----Globallos
include "neverEndingPartyAnimation.lua"
--General Public License goes in all fields

testCenter = piece "testCenter"

numberOfActors = 10
dramatisPersona = {}

--This is the neverending Party Script



----------------------------------------------------
-- globallos

maxDist = 13
minIdle = 4000
maxIdle = 19000

----------------------------------------------------
forbMap = {}

--a forbidden Zone consists at its most basic established of 4 values - two degrees (upper and lower bound) - and two distancevalues (upper and lower bound)
updegree = 273
lowdegree = 225
updist = 9
dowdist = 2
boolunitDead = false


------------------------------------------------------------------------------------------------------------------------------------------


--personObjects

person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter1 = piece "swingCenter1"
table.insert(person, 1, swingCenter1) --swingCenter always atfirstPlace 1

abTusM1 = piece "abTusM1" -- the persons centerpiece 2
table.insert(person, 2, abTusM1)

piecetable = {} --contains the remaining pieces 3
piecetable[#piecetable + 1] = piece "abTUarR1"
piecetable[#piecetable + 1] = piece"abTUarR1"
piecetable[#piecetable + 1] = piece"abTLarR1"
piecetable[#piecetable + 1] = piece"abTUarL1"
piecetable[#piecetable + 1] = piece"abTLarL1"
piecetable[#piecetable + 1] = piece"glasprop1"
piecetable[#piecetable + 1] = piece"abTULeg1"
piecetable[#piecetable + 1] = piece"abTLLegL1"
piecetable[#piecetable + 1] = piece"abTLLegR1"
piecetable[#piecetable + 1] = piece"abTHead1"


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
typeDef = 3
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.1
table.insert(person, 10, speedPerson)
--numberOfPieces
numberOfPieces = 8
table.insert(person, 11, numberOfPieces)
table.insert(person, 12, 1)

table.insert(dramatisPersona, 1, person)
--------------------------------------------------------------------------------------------------------------------------------------
-- 2
person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter2 = piece "swingCenter2"
table.insert(person, 1, swingCenter2) --swingCenter always atfirstPlace 1

abAdvmain2 = piece "abAdvmain2" -- the persons centerpiece 2
table.insert(person, 2, abAdvmain2)

piecetable = {} --contains the remaining pieces 3


piecetable[#piecetable + 1] =  piece "abadvarmR2"
piecetable[#piecetable + 1] = piece "abadvarmL2"


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
typeDef = 4
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.2
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 2
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 2, person)



--------------------------------------------------------------------------------------------------------------------------------------

person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter3 = piece "swingCenter3"
table.insert(person, 1, swingCenter3) --swingCenter always atfirstPlace 1

abTusM3 = piece "abTusM3" -- the persons centerpiece 2
table.insert(person, 2, abTusM3)

piecetable = {} --contains the remaining pieces 3

piecetable[#piecetable + 1] = piece "abTUarR3"
piecetable[#piecetable + 1] = piece "abTLarR3"
piecetable[#piecetable + 1] = piece "abTUarL3"
piecetable[#piecetable + 1] = piece "abTLarL3"
piecetable[#piecetable + 1] = piece "glasprop3"
piecetable[#piecetable + 1] = piece "abTULegL3"
piecetable[#piecetable + 1] = piece "abTLLegL3"
piecetable[#piecetable + 1] = piece "abTLLegR3"
piecetable[#piecetable + 1] = piece "abTHead3"



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
typeDef = 3
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.1
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 9
table.insert(person, 11, numberOfPieces)
table.insert(person, 12, 3)


table.insert(dramatisPersona, 3, person)

--------------------------------------------------------------------------------------------------------------------------------------

person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter4 = piece "swingCenter4"
table.insert(person, 1, swingCenter4) --swingCenter always atfirstPlace 1

abTMmain4 = piece "abTMmain4" -- the persons centerpiece 2
table.insert(person, 2, abTMmain4)

piecetable = {} --contains the remaining pieces 3


piecetable[#piecetable + 1] = piece "abTMhandL"
piecetable[#piecetable + 1] = piece "abTMarmL"
piecetable[#piecetable + 1] = piece "Plate"
piecetable[#piecetable + 1] = piece "abTMarmR"
piecetable[#piecetable + 1] = piece "abTMhandR"
piecetable[#piecetable + 1] = piece "abTMuplR"
piecetable[#piecetable + 1] = piece "abTMlowR"
piecetable[#piecetable + 1] = piece "abTMFeedR"
piecetable[#piecetable + 1] = piece "abTMuplL"
piecetable[#piecetable + 1] = piece "abTMlowL"
piecetable[#piecetable + 1] = piece "abTMFeedL"


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
typeDef = 5
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.2
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 11
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 4, person)

--------------------------------------------------------------------------------------------------------------------------------------

person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter5 = piece "swingCenter5"
table.insert(person, 1, swingCenter5) --swingCenter always atfirstPlace 1

abTusM5 = piece "abTusM5" -- the persons centerpiece 2
table.insert(person, 2, abTusM5)

piecetable = {} --contains the remaining pieces 3


piecetable[#piecetable + 1]  = piece "abTUarR5"
piecetable[#piecetable + 1]  = piece "abTLarR5"
piecetable[#piecetable + 1] = piece "glasprop5"
piecetable[#piecetable + 1]  = piece "abTusHead5"
piecetable[#piecetable + 1] = piece "abTULegR5"
piecetable[#piecetable + 1] = piece "abTLLegR5"
piecetable[#piecetable + 1]  = piece "abTULegL5"
piecetable[#piecetable + 1] = piece "abTLLegL5"
piecetable[#piecetable + 1] = piece "abTUarL5"
piecetable[#piecetable + 1] = piece "abTLarL5"



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
numberOfPieces = 10
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 5, person)

--------------------------------------------------------------------------------------------------------------------------------------

person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter6 = piece "swingCenter6"
table.insert(person, 1, swingCenter6) --swingCenter always atfirstPlace 1

abAdvmain6 = piece "abAdvmain6" -- the persons centerpiece 2
table.insert(person, 2, abAdvmain6)

piecetable = {} --contains the remaining pieces 3
abadvarmR6 = piece "abadvarmR6"
abadvarmL6 = piece "abadvarmL6"

piecetable[#piecetable + 1] = abadvarmR6
piecetable[#piecetable + 1] = abadvarmL6




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
typeDef = 4
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.3
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 2
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 6, person)

--------------------------------------------------------------------------------------------------------------------------------------

person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter7 = piece "swingCenter7"
table.insert(person, 1, swingCenter7) --swingCenter always atfirstPlace 1

abTusM7 = piece "abTusM7" -- the persons centerpiece 2
table.insert(person, 2, abTusM7)

piecetable = {} --contains the remaining pieces 3

piecetable[#piecetable + 1] = piece "abTUarL7"
piecetable[#piecetable + 1] = piece "abTLarL7"
piecetable[#piecetable + 1] = piece "abTHead7"
piecetable[#piecetable + 1] = piece "abTUarR7"
piecetable[#piecetable + 1] = piece "abTLarR7"
piecetable[#piecetable + 1]  = piece "glasprop7"





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
typeDef = 2
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.04
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 6
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 7, person)

--------------------------------------------------------------------------------------------------------------------------------------
-- 8
person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter8 = piece "swingCenter8"
table.insert(person, 1, swingCenter8) --swingCenter always atfirstPlace 1

abBuMain = piece "abBuMain" -- the persons centerpiece 2
table.insert(person, 2, abBuMain)

piecetable = {} --contains the remaining pieces 3

piecetable[#piecetable + 1]= piece "abBuArmR"
piecetable[#piecetable + 1]= piece "abBuLegR"
piecetable[#piecetable + 1]= piece "abBuLegL"
piecetable[#piecetable + 1]= piece "abBuArmL"
piecetable[#piecetable + 1] = piece "glasprop8"


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
typeDef = 6
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.2
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 5
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 8, person)

--------------------------------------------------------------------------------------------------------------------------------------
-- 9
person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter9 = piece "swingCenter9"
table.insert(person, 1, swingCenter9) --swingCenter always atfirstPlace 1

fucAbuTop = piece "fucAbuTop" -- the persons centerpiece 2
table.insert(person, 2, fucAbuTop)

piecetable = {} --contains the remaining pieces 3


piecetable[#piecetable + 1] = piece "fucAbuAL"
piecetable[#piecetable + 1] = piece "fucAbuR"
piecetable[#piecetable + 1] = piece "fucAbuM"
piecetable[#piecetable + 1] = piece "fucAbuLR"
piecetable[#piecetable + 1]  = piece "fucAbuLL"
piecetable[#piecetable + 1]  = piece "abTusM9"
piecetable[#piecetable + 1]  = piece "abTHead9"
piecetable[#piecetable + 1] = piece "abTUarR9"
piecetable[#piecetable + 1]  = piece "abTLarR9"
piecetable[#piecetable + 1] = piece "abTULegR9"
piecetable[#piecetable + 1] = piece "abTLLegR9"
piecetable[#piecetable + 1] = piece "abTULegL9"
piecetable[#piecetable + 1]  = piece "abTLLegL9"
piecetable[#piecetable + 1] = piece "abTUarL9"
 piecetable[#piecetable + 1] = piece "abTLarL9"




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
typeDef = 7
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.2
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 14
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 9, person)
--------------------------------------------------------------------------------------------------------------------------------------------------
person = {}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter10 = piece "swingCenter10"
table.insert(person, 1, swingCenter10) --swingCenter always atfirstPlace 1

abBuMain10 = piece "abBuMain10" -- the persons centerpiece 2
table.insert(person, 2, abBuMain10)

piecetable = {} --contains the remaining pieces 3

piecetable[#piecetable + 1] =piece "abBuArmR10"
piecetable[#piecetable + 1] =piece "abBuLegR10"
piecetable[#piecetable + 1] =piece "abBuLegL10"
piecetable[#piecetable + 1] =piece "abBuArmL10"
piecetable[#piecetable + 1] =piece "glasprop10"


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
typeDef = 6
table.insert(person, 8, typeDef)
--boolean on its way (has a thread, even if it is just to idle)
boolOnItsWay = false
table.insert(person, 9, boolOnItsWay)
-- speedvalue of the the person
speedPerson = 0.1
table.insert(person, 10, speedPerson)

--numberOfPieces
numberOfPieces = 5
table.insert(person, 11, numberOfPieces)


table.insert(dramatisPersona, 10, person)


function faceValue2Degree(personNr, dramatisPersona)
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

function degreeCompare(targetdegree, personNr, dramatisPersona)
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
function PartyManager()
    Ragdolls = {}
    for i = 1, 8, 1 do
        Ragdolls[i] = {}
        rag = "Rag" .. i
        Ragdolls[i] = piece(rag)
    end
    Ragdolls[9] = {}
    rag = "Rag10"
    Ragdolls[9] = piece(rag)
    for i = 1, 9, 1 do
        Hide(Ragdolls[i])
    end





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
                if (PartyMyAuthoritaeRespectIt(i, degreeRand, moveInOut) == true or dramatisPersona[i][8] == 4) then
                    ------ Spring.Echo(i.."PersonNr Made it this far")

                    --check (if not advisor) or way is free
                    if (dramatisPersona[i][8] == 4 or PartyisWayfree(degreeRand, moveInOut, dramatisPersona[i][4], dramatisPersona[i][5], dramatisPersona[i][6]) == true) then --FixMe
                        dramatisPersona[i][9] = true
                        StartThread(PartySenderJobFunc, i, degreeRand, moveInOut)

                        --Start SenderThread(+roll jobtoFullFill when arriving)
                    end

                elseif dramatisPersona[i][9] == false then
                    dramatisPersona[i][9] = true
                    StartThread(PartyIdleFunc, i)

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
function PartyMyAuthoritaeRespectIt(personNr, degreeRand, moveInOut)

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
function PartyWayCheckerInsideOutside(orgDistance, moveInOut, orgDegree)
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
function PartyWayCheckerClockWise(orgDegree, moveInOut, orgDistance)
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
function PartyisWayfree(degreeRand, moveInOut, orgDegree, orgDistance, FaceIng)
    --Enum: inside is 1,
    --		outside is 2,
    --		clockwise is 4,
    --      counterclockwise its 8


    if FaceIng == 1 then -- we want to check the way inside fromt he current
        return PartyWayCheckerInsideOutside(orgDistance, moveInOut, orgDegree)
    end

    if FaceIng == 2 then -- we want to check the way inside fromt he current
        return PartyWayCheckerInsideOutside(orgDistance, moveInOut, orgDegree)
    end

    if FaceIng == 4 then -- we want to check the way inside fromt he current
        return PartyWayCheckerInsideOutside(orgDegree, moveInOut, orgDistance)
    end

    if FaceIng == 8 then -- we want to check the way inside fromt he current
        return PartyWayCheckerClockWise(orgDegree, moveInOut, orgDistance)
    end

    return true
end


function PartySenderJobFunc(personNr, targetdegree, targetDist)
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
    PartyTypeDependedWalkAnimation(personNr, dramatisPersona[personNr][8])

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
        PartyTypeDependedWalkAnimation(personNr, dramatisPersona[personNr][8])
        spendTime = spendTime + 4000
        Sleep(50)
    end
    -- we return the random direction

    --finally we set the unit back into jobless mode, so the partymanager can grab it again, and send it on its way
    dramatisPersona[personNr][9] = false
end


function PartyTypeDependedWalkAnimation(personNr, personTypeNr)
    --Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7, testbrick=8

    if personTypeNr == 1 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation1(personNr, dramatisPersona)
        end
    elseif personTypeNr == 2 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation2(personNr, dramatisPersona)
        end
    elseif personTypeNr == 3 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation3(personNr, dramatisPersona)
        end
    elseif personTypeNr == 4 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation4(personNr, dramatisPersona)
        end
    elseif personTypeNr == 5 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation5(personNr, dramatisPersona)
        end
    elseif personTypeNr == 6 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation6(personNr, dramatisPersona)
        end
    elseif personTypeNr == 7 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation7(personNr, dramatisPersona)
        end
    elseif personTypeNr == 8 then
        while (stillMoving(personNr, dramatisPersona)) do
            walkAnimation8(personNr, dramatisPersona)
        end
    else
        ------ Spring.Echo("Error in the typeDependedWalkAnimation")
    end
end

function PartyTypeDependedIdleAnimation(personNr, personTypeNr,dramatisPersona)
    --Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7,

    if personTypeNr == 1 then
        idleAnimation1(personNr, dramatisPersona)
        return
    elseif personTypeNr == 2 then
        idleAnimation2(personNr, dramatisPersona)
        return
    elseif personTypeNr == 3 then
        idleAnimation3(personNr, dramatisPersona)
        return

    elseif personTypeNr == 4 then
        idleAnimation4(personNr, dramatisPersona)
        return

    elseif personTypeNr == 5 then
        idleAnimation5(personNr, dramatisPersona)
        return

    elseif personTypeNr == 6 then
        idleAnimation6(personNr, dramatisPersona)
        return

    elseif personTypeNr == 7 then
        idleAnimation7(personNr, dramatisPersona)
        return
    else
        ------ Spring.Echo("Error in the typeDependedWalkAnimation")
        return
    end
end





function partyIdleFunc(personNr,dramatisPersona)
    ------ Spring.Echo("Idling in the function")
    Sleep(4000)
    dramatisPersona[personNr][9] = false
end
