--include "AniMatrix3d.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

include "jVitalFunctions.lua"
include "createCorpse.lua"
--Alarm SystemPieces
TheNews= piece "spinTheNews"
AlarmOne={}
AlarmTwo={}
AlarmThree={}
Alarm1=piece "Alarm1"
AlarmOne[1]=Alarm1
Alarm2=piece "Alarm2"
AlarmTwo[1]=Alarm2
arco2 = piece"arco2"

for i=1,4,1 do
	stringOfStrings= "Alarm2Fly"..i
	AlarmTwo[i+1]= piece (stringOfStrings)
end

AlarmThree[1]= piece "Alarm3"
AlarmThree[2]= piece "Alarm3Arm"
AlarmThree[3]= piece "Alarm3Arm2"
AlarmThree[4]= piece "Alarm3Flag2"
AlarmThree[5]= piece "Alarm3Flag1"

for i=0,9,1 do
	stringII="Alarm3Fla"..i
	AlarmThree[i+6]=piece (stringII)
end

flagTable1={}
for i=5,9,1 do
	stringII="Alarm3Fla"..i
	flagTable1[i-4]=piece (stringII)
end
flagTable2={}
for i=0,4,1 do
	stringII="Alarm3Fla"..i
	flagTable2[i]=piece (stringII)
end
--Globallos
--General Public License goes in all fields
testCenter= piece "testCenter"

numberOfActors=15
dramatisPersona3d={}








----------------------------------------------------
--globallos

M3dmaxDist=45
M3dminDist=0
M3dmaxHeight=100
M3dminHeight=0






----------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter1 = piece "swingCenter1"
person[1]=swingCenter1 --swingCenter always atfirstPlace 1

car1 = piece "car1" -- the persons centerpiece 2
person[2]=car1 








person[3]=piecetable 

-- a person is defined by the following values: 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread, even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(1.9,8)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 
--its height in the 3dmatrixgrid
height=0
person[13]=height



table.insert(dramatisPersona3d,1,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter2 = piece "swingCenter2"
person[1]=swingCenter2 --swingCenter always atfirstPlace 1

car2 = piece "car2" -- the persons centerpiece 2
person[2]=car2 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid

-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(1.9,9)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1
height=0
person[13]=height

table.insert(dramatisPersona3d,2,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter3 = piece "swingCenter3"
person[1]=swingCenter3 --swingCenter always atfirstPlace 1

car3 = piece "car3" -- the persons centerpiece 2
person[2]=car3 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(1.9,11)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,3,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter4 = piece "swingCenter4"
person[1]=swingCenter4 --swingCenter always atfirstPlace 1

car4 = piece "car4" -- the persons centerpiece 2
person[2]=car4 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread, even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,4,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter5 = piece "swingCenter5"
person[1]=swingCenter5 --swingCenter always atfirstPlace 1

car5 = piece "car5" -- the persons centerpiece 2
person[2]=car5 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread, even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,5,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter6 = piece "swingCenter6"
person[1]=swingCenter6 --swingCenter always atfirstPlace 1

car6 = piece "car6" -- the persons centerpiece 2
person[2]=car6 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread, even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,6,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter7 = piece "swingCenter7"
person[1]=swingCenter7 --swingCenter always atfirstPlace 1

car7 = piece "car7" -- the persons centerpiece 2
person[2]=car7 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,7,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy]= swingCenter beeing the Center
swingCenter8 = piece "swingCenter8"
person[1]=swingCenter8 --swingCenter always atfirstPlace 1

car8 = piece "car8" -- the persons centerpiece 2
person[2]=car8 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,8,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter9 = piece "swingCenter9"
person[1]=swingCenter9 --swingCenter always atfirstPlace 1

car9 = piece "car9" -- the persons centerpiece 2
person[2]=car9 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,9,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy]= swingCenter beeing the Center
swingCenter10 = piece "swingCenter10"
person[1]=swingCenter10 --swingCenter always atfirstPlace 1

car10 = piece "car10" -- the persons centerpiece 2
person[2]=car10 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,10,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter11 = piece "swingCenter11"
person[1]=swingCenter11 --swingCenter always atfirstPlace 1

car11 = piece "car11" -- the persons centerpiece 2
person[2]=car11 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread, even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(1.9,12)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,11,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter12 = piece "swingCenter12"
person[1]=swingCenter12 --swingCenter always atfirstPlace 1

car12 = piece "car12" -- the persons centerpiece 2
person[2]=car12 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2]= woman(halfSkirt =3]= advisor=4]= thinman=5]= man=6]= aircar= 7]= airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,12,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter13 = piece "swingCenter13"
person[1]=swingCenter13 --swingCenter always atfirstPlace 1

car13 = piece "car13" -- the persons centerpiece 2
person[2]=car13 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1]= 
--		outside is 2]= 
--		clockwise is 4]= 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1]= woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 

person[12]=1 

table.insert(dramatisPersona3d,13,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter14 = piece "swingCenter14"
person[1]=swingCenter14 --swingCenter always atfirstPlace 1

car14 = piece "car14" -- the persons centerpiece 2
person[2]=car14 








person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread]= even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,14,person)
--------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


--personObjects



person={}
--traditional pieces hiearchy, swingCenter beeing the Center
swingCenter15 = piece "swingCenter15"
person[1]=swingCenter15 --swingCenter always atfirstPlace 1

car15 = piece "car15" -- the persons centerpiece 2
person[2]=car15 


person[3]=piecetable 

-- a person is defined by the following values: --its height in the 3dmatrixgrid
height=0
person[13]=height 
-- its position in degree and distance 
degree=0
person[4]=degree 
dist=0
person[5]=dist 
-- its facing value --all units start facing .. outside 
--Enum: inside is 1, 
--		outside is 2, 
--		clockwise is 4, 
-- counterclockwise its 8

faceValue=2
person[6]=faceValue 

-- the attached boolean (is the char attached to another in some animation 
boolIndyChar=false
person[7]=boolIndyChar 

-- the type of char (a intvalue that represents the diffrent purposes 
--Enum: Woman(NoSkirt =1, woman(Skirt =2, woman(halfSkirt =3, advisor=4, thinman=5, man=6, aircar= 7, airtruck=8
typeDef=7
person[8]=typeDef 
--boolean on its way (has a thread, even if it is just to idle 
boolOnItsWay=false
person[9]=boolOnItsWay 
-- speedvalue of the the person
speedPerson=math.random(7.9,22)
person[10]=speedPerson 
--numberOfPieces
numberOfPieces=1
person[11]=numberOfPieces 
person[12]=1 

table.insert(dramatisPersona3d,15,person)


-----------------------------------------------------------------------------------------------------------------------------------------------

function randomFlyBySound()
	while (true) do
		
		Spring.PlaySoundFile("sounds/cbuibaiarc/buibaiarc.wav")
		Sleep(5000)
		
		randSlept=math.random(0,6000)
		Sleep(randSlept)
		
		
		
	end
	
	
end





------------------------------------------------------------------------------------------------------------------------------------------------


function stillMoving(personNr)
	if (true==Spring.UnitScript.IsInMove(dramatisPersona3d[personNr][2], z_axis) or true== Spring.UnitScript.IsInTurn(dramatisPersona3d[personNr][1], y_axis)) then 
		return true
		
	else 
		return false
	end
	
end




function typeDependedWalkAnimation(personNr)
	--Enum: Woman(NoSkirt)=1, woman(Skirt)=2, woman(halfSkirt)=3, advisor=4, thinman=5, man=6, womanwithfuckdoll= 7, testbrick=8
	
	while stillMoving(personNr)==true do
		Turn(dramatisPersona3d[personNr][2],x_axis,math.rad(0.5),0.02)
		WaitForTurn(dramatisPersona3d[personNr][2],x_axis)
		Turn(dramatisPersona3d[personNr][2],x_axis,math.rad(-0.25),0.02)
		WaitForTurn(dramatisPersona3d[personNr][2],x_axis)
	end
	Turn(dramatisPersona3d[personNr][2],x_axis,math.rad(0),2)
	----Spring.Echo("Error in the typeDependedWalkAnimation")
end




function senderJobFunc(personNr)
	
	targetDist=500
	NtargetDist=-500
	targetdegree=90
	Ntargetdegree=0
	targetHeight=120
	luckOne=0
	if math.random(0,1)==1 then
		luckOne=math.random(1.2,5)
	end
	tempDirAction=1
	tempSpeed=dramatisPersona3d[personNr][10]
	--if car views inside 
	if dramatisPersona3d[personNr][6]== 1 then
		--move it through the center move along center axis -lower Axis
		Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(0),4)
		WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
		
		dramatisPersona3d[personNr][5]=targetDist
		
		Move(dramatisPersona3d[personNr][2],z_axis,targetDist,(tempSpeed*6)+luckOne)
		tempDirAction=8
		
		
	elseif dramatisPersona3d[personNr][6]== 2 then
		--if car views outside beeing high, turn right, turn along radiant via SwingCenter - +down
		
		Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(270),4) --FixMe90
		WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
		
		dramatisPersona3d[personNr][4]=targetdegree	
		Move(dramatisPersona3d[personNr][2],y_axis,0,tempSpeed*1.4)
		dramatisPersona3d[personNr][13]=0
		Turn(dramatisPersona3d[personNr][1],y_axis,math.rad(targetdegree),((dramatisPersona3d[personNr][10])/100)+0.1)--0.3
		tempDirAction=1
		
	elseif dramatisPersona3d[personNr][6]== 4 then
		
		--if car turned right nach innen drehen, move along the uper axis
		
		Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(180),4)
		WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
		dramatisPersona3d[personNr][5]=NtargetDist
		Move(dramatisPersona3d[personNr][2],z_axis,NtargetDist,(tempSpeed*6)+luckOne)
		tempDirAction=2
	elseif dramatisPersona3d[personNr][6]== 8 then
		
		Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(-90),4) --FixMe270
		WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
		dramatisPersona3d[personNr][4]=Ntargetdegree	
		Move(dramatisPersona3d[personNr][2],y_axis,targetHeight,tempSpeed*1.4)
		dramatisPersona3d[personNr][13]=targetHeight
		Turn(dramatisPersona3d[personNr][1],y_axis,math.rad(Ntargetdegree),((dramatisPersona3d[personNr][10])/100)+0.1) --0.3
		tempDirAction=4
		
	end
	
	dramatisPersona3d[personNr][6]=tempDirAction
	Sleep(1000)
	--if car views outside beeing beeing low turn turn left
	
	--Enum: inside is 1, 
	--		outside is 2, 
	--		clockwise is 4, 
	-- counterclockwise its 8
	--Person turned into the direction it is going to walk
	
	--send the person on its way.
	typeDependedWalkAnimation(personNr)
	
	--now we update the current position 
	
	if personNr ~=11 and personNr ~= 1 and personNr ~= 2 and personNr ~= 3 then
		dramatisPersona3d[personNr][10]=math.random(7.9,22)
	end
	
	-- we turn the persona into a random direction
	--randomTurn=math.random(0,360)
	--Turn(dramatisPersona3d[personNr][1],y_axis,math.rad(randomTurn),dramatisPersona3d[personNr][10])
	
	-- now we need a Time, and a idleanimation so the person arriving at the ways end, doesent just stands around
	
	-- we return the random direction
	
	--finally we set the unit back into jobless mode, so the partymanager can grab it again, and send it on its way
	dramatisPersona3d[personNr][9]=false
end

function starterKid()
	for i=1,15,1 do
		dramatisPersona3d[i][9]=false
		sleeper=math.random(2000,25000)
		Sleep(sleeper)
		Show((dramatisPersona3d[i][2]))
	end
	
	
end

--This is the PartyManager - this function decides were everyone goes
function PartyManager()
	for i=1,15,1 do
		dramatisPersona3d[i][9]=true
		Hide((dramatisPersona3d[i][2]))
	end
	--Spring.Echo("PartyManager Activated")
	
	--FixMe
	StartThread(starterKid)
	
	
	while(true) do
		for i=1, numberOfActors,1 do
			
			if dramatisPersona3d[i][9] == false then --else the piece is a standaloner on the neverending party allready busy
				dramatisPersona3d[i][9]=true
				
				moveInOut=1
				degreeRand=2--0*360 in 45 degree Steps
				
				StartThread(senderJobFunc,i)
				
				
			end
		end
		
		Sleep(120)
	end
	
	
	
end















--List of emitpieces
emitArray={}

for i=1,63,1 do
	subfolder={}
	
	for b=1,4,1 do
		--Spring.Echo(b)
		subfolder[b]={}
		emitString="flameEmit"..i
		local emitpiece= emitString..b
		subfolder[b]=piece (emitpiece)
	end
	table.insert(emitArray,i,subfolder)
	
end

buibaicity=piece"buibaicity"

flameEmit11= piece"flameEmit11"
flameEmit12= piece"flameEmit12"
flameEmit13= piece"flameEmit13"
flameEmit14= piece"flameEmit14"
--List of Fire Related Variables
local hp2reducePerSecond=5
local boolBurning=false
local boolUnitRepaired=false
local nrOfFires=0
maxNrOfFires=63

SIG_BURN=2


currentHitPoints=Spring.GetUnitHealth(unitID)
hitPointsASecondAgo=currentHitPoints
startHitpoints=Spring.GetUnitHealth(unitID)

--Economics
totalEnergyConsumed=0
totalMetallConsumed=0
insuranceRate=1.5
-- oh, noes doing insurrance math for a game.
--so we have a total of startHitpoints and want to return the stored Values*insuranceRate
--so 
nrOfSteps= startHitpoints/hp2reducePerSecond
returnOfInvestmentE =0
returnOfInvestmentM=0
function getRetE()
	returnOfInvestmentE=(totalEnergyConsumed*insuranceRate)/nrOfSteps
	return returnOfInvestmentE
end

function getRetM()
	returnOfInvestmentM=(totalMetallConsumed*insuranceRate)/nrOfSteps
	return returnOfInvestmentM
end



energyConsumedPerSecond=15
metallConsumedPerSecond=15


teamId=Spring.GetUnitTeam(unitID)
-- the 3d animatrix array
carArray={}
--function checks whos team the last attacker was on
attackerOfOld=-1
boolLastDecision=false
function lastAttackerEnemyTeam()
	attacId=Spring.GetUnitLastAttacker(unitID)
	if attacId == nil then
		return false
	end
	
	attackerTeamId=Spring.GetUnitTeam(attacId)
	assert(attackerTeamId)
	if attackerTeamId == teamId then
		return false
	else 
		return true
	end
end

--function:really.. you need a explanation.. fuckin read the title
function getHealth()
	return Spring.GetUnitHealth(unitID)
end

--turns all given firepoints to the winDirX
function turnAllthePoints(x,z)
	x=(x%100)*0.25
	z=(z%100)*0.25
	target=(table.getn(emitArray))%4
	for i=1, target,1 do
		dada=x+math.random(-4,4)
		
		Turn((emitArray[i][1]),x_axis,math.rad(dada),0.2)
		dodo=z+math.random(-3,3)
		Turn((emitArray[i][1]),z_axis,math.rad(dodo),0.2)
	end
	
	
end
--func: calcs how many fires show up
function howManyFires ()
	-- testExample: 1400 /2500=0.4 *40 =10 Fire
	reSaltoMortale=math.floor(((startHitpoints-currentHitPoints)/startHitpoints)*maxNrOfFires)
	if reSaltoMortale >=64 then
		reSaltoMortale=63
	end
	return reSaltoMortale
	
end
--function: Increments the given Variable


--function: displays the damage to the Arcology based upon its health Stat
local durchLaufErhitzer=0
function fireAndFlames()
	
	
	while (true) do
		if durchLaufErhitzer== 3 then
			currentHitPoints=getHealth()
			nrOfFires=howManyFires()
			durchLaufErhitzer=0
		end
		durchLaufErhitzer=durchLaufErhitzer+1
		
		--activates particlespawn over a 3D point table (every point has three subpoints-- knows three diffrent levels of fire.. smoldering.. outburst.. lichterloh 
		if nrOfFires ~= 0 then
			dirX, dirY, dirZ, strength, normDirX, normDirY, normDirZ=Spring.GetWind()
			
			winDirX=dirX*strength
			winDirZ=dirZ*strength
			
			turnAllthePoints(winDirX,winDirZ)
			--Spring.Echo("NrOfFires:",nrOfFires)
			for i=1,nrOfFires,1 do
				EmitSfx(emitArray[i][1], 1025)
				EmitSfx(emitArray[i][2], 1026)
				EmitSfx(emitArray[i][3], 1027)
				EmitSfx(emitArray[i][4], 1028)
			end
		end
		
		
		Sleep(256)
	end
	
	
end


function reWardProcess()
	SetSignalMask(SIG_REWARD)
	returnOfInvestmentM=getRetM()
	returnOfInvestmentE=getRetE()
	while(true) do
		
		
		Spring.AddTeamResource(teamId,"metal",returnOfInvestmentM)
		Spring.AddTeamResource(teamId,"energy",returnOfInvestmentE)
		
		
		
		
		
		
		Sleep(1000)
	end
	
end

function burnDownAnimations()
	Spin(TheNews,y_axis,0.42,0.03)
	Spin(AlarmTwo[3],x_axis,0.52,0.03)
	Spin(AlarmTwo[5],x_axis,0.32,0.03)
	Spin(AlarmTwo[2],z_axis,0.32,0.03)
	Spin(AlarmTwo[4],z_axis,0.32,0.03)
	while(true) do
		x=math.random(-60,14)
		Turn(AlarmThree[2],z_axis,math.rad(x*-1),6)
		Turn(AlarmThree[3],z_axis,math.rad(x),5)
		WaitForTurn(AlarmThree[2],z_axis)
		WaitForTurn(AlarmThree[1],z_axis)
		Turn(AlarmThree[4],y_axis,math.rad(0),28)
		Turn(AlarmThree[5],y_axis,math.rad(0),28)
		WaitForTurn(AlarmThree[4],y_axis)
		WaitForTurn(AlarmThree[5],y_axis)
		Turn(AlarmThree[4],x_axis,math.rad(-45),3)
		Turn(AlarmThree[5],x_axis,math.rad(-45),3)
		ripple (flagTable1, 17, "x_axis", 1,3, true, 0)
		ripple (flagTable2, 14, "x_axis", 1,3, true, 0)
		WaitForTurn(AlarmThree[4],x_axis)
		WaitForTurn(AlarmThree[5],x_axis)
		Turn(AlarmThree[4],x_axis,math.rad(45),3)
		Turn(AlarmThree[5],x_axis,math.rad(45),3)
		Turn(AlarmThree[4],y_axis,math.rad(180),28)
		Turn(AlarmThree[5],y_axis,math.rad(180),28)
		WaitForTurn(AlarmThree[4],y_axis)
		WaitForTurn(AlarmThree[5],y_axis)
		WaitForTurn(AlarmThree[4],x_axis)
		WaitForTurn(AlarmThree[5],x_axis)
		Turn(AlarmThree[2],z_axis,math.rad(0),5.5)
		Turn(AlarmThree[3],z_axis,math.rad(0),4.2)
		WaitForTurn(AlarmThree[2],z_axis)
		WaitForTurn(AlarmThree[1],z_axis)
	end
end

function burnDown()
	SetSignalMask(SIG_BURN)
	
	
	StartThread(reWardProcess)
	StartThread(fireAndFlames)
	StartThread(burnDownAnimations)
	modulu3=1
	while(boolBurning==true) do
		if modulu3==3 then
			modulu3=0
			
			--Hide all Stages
			for i=1,table.getn(AlarmOne),1 do
				Hide(AlarmOne[i])
			end
			for i=1,table.getn(AlarmTwo),1 do
				Hide(AlarmTwo[i])
			end
			for i=1,table.getn(AlarmThree),1 do
				Hide(AlarmThree[i])
			end
			x=math.random(0,2)
			if x==0 then
				for i=1,table.getn(AlarmOne),1 do
					Show(AlarmOne[i])
				end
			elseif x==1 then
				for i=1,table.getn(AlarmTwo),1 do
					Show(AlarmTwo[i])
				end
			else
				for i=1,table.getn(AlarmThree),1 do
					Show(AlarmThree[i])
				end
			end
		end
		modulu3=modulu3+1
		health=currentHitPoints-hp2reducePerSecond*2
		Spring.SetUnitHealth(unitID,health)
		
		Sleep(2000)
		
	end
	
	
end

function hideThemAll()
	for i=1,table.getn(AlarmOne),1 do
		Hide(AlarmOne[i])
	end
	for i=1,table.getn(AlarmTwo),1 do
		Hide(AlarmTwo[i])
	end
	for i=1,table.getn(AlarmThree),1 do
		Hide(AlarmThree[i])
	end
end


function healthCheck()
	while(true) do
		--update Health
		currentHitPoints=Spring.GetUnitHealth(unitID)
		
		--if unit doesent burn
		if boolBurning==false then
			--substract costs
			boolMetallUsed=Spring.UseUnitResource(unitID,"m",metallConsumedPerSecond)
			boolEnergyUsed=Spring.UseUnitResource(unitID,"e",energyConsumedPerSecond)
			
			if boolEnergyUsed==true then
				totalEnergyConsumed=totalEnergyConsumed+energyConsumedPerSecond
			else
				totalEnergyConsumed=totalEnergyConsumed-energyConsumedPerSecond
			end
			
			if boolMetallUsed==true then
				totalMetallConsumed=totalMetallConsumed+metallConsumedPerSecond
			else
				totalMetallConsumed=totalMetallConsumed-metallConsumedPerSecond
			end
			
			
			--if currentHitPoints has decreased --> Start a burning Thread
			if currentHitPoints < hitPointsASecondAgo and lastAttackerEnemyTeam()==true then
				boolBurning=true
				Signal(SIG_BURN)
				StartThread(burnDown)
			end
			
			
			
			
		else
			--if unit is burning 
			
			if currentHitPoints > hitPointsASecondAgo then
				--case baitBuilding gets repaired -- burning stops
				Signal(SIG_BURN)
				boolBurning=false
				hideThemAll()
			end
			
		end
		hitPointsASecondAgo=currentHitPoints
		Sleep(1000)
	end
end

function SideEffects()
	if not 	GG.BuiLuxUpgrade then 	GG.BuiLuxUpgrade={}end
	
	IdTable={[UnitDefNames["builux"].id]=true}
	while true do
		--get builux nearby
		x,y,z=Spring.GetUnitPosition(unitID)
		T=getAllInCircle(x,z,512,unitID)
		if #T then 
			T=filterUnitTableforDefIDTable(T,IdTable)
			if #T then 
				
				for i=1,#T do
					GG.BuiLuxUpgrade[T[i]]=true
				end
			end
		end
		Sleep(1000)
	end
end



function script.Create()
	StartThread(randomFlyBySound)
	--<buildanimationscript>
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	
	if maRa()==true then
	Hide(arco2)
	Show(buibaicity)
	else
	Show(arco2)
	Hide(buibaicity)
	end
	
	
	if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
	GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
	--if nil ~= Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)
	-- then Spring.Echo ("GeoHive::Success")
	-- end
	
	--</buildanimationscript>
	
	StartThread(healthCheck)		
	StartThread(PartyManager)
	for i=1,table.getn(AlarmOne),1 do
		Hide(AlarmOne[i])
	end
	for i=1,table.getn(AlarmTwo),1 do
		Hide(AlarmTwo[i])
	end
	for i=1,table.getn(AlarmThree),1 do
		Hide(AlarmThree[i])
	end
	
		StartThread(SideEffects)
end


function script.Killed(recentDamage, maxHealth)
	for i=1,63,1 do
		EmitSfx(emitArray[i][1], 1025)
	end
	Sleep(400)
	for i=1,63,1 do
		EmitSfx(emitArray[i][1], 1025)
		
	end
	Sleep(400)
	
	for i=1,63,1 do
		EmitSfx(emitArray[i][1], 1025)
		EmitSfx(emitArray[i][2], 1026)
		
	end
	
	Sleep(300)
	x=63
	while x> 0 do
		for i=1,63,1 do
			EmitSfx(emitArray[i][1], 1025)
			EmitSfx(emitArray[i][2], 1026)
			EmitSfx(emitArray[i][3], 1027)
			EmitSfx(emitArray[i][4], 1028)
			
		end
		Sleep(250)
		x=x-1
	end 		 
	for i=1,numberOfActors,1 do
		randYSpin=math.random(0.2,0.7)	
		randZSpin=math.random(0.2,0.7)	
		Spin(dramatisPersona3d[i][2],y_axis,math.rad(randYSpin),0.1)
		Spin(dramatisPersona3d[i][2],z_axis,math.rad(randZSpin),0.01)
		Move(dramatisPersona3d[i][2],y_axis,-140,0.7)
	end
	
	quiteSomeTime=17	 
	for x=0,quiteSomeTime,1 do	 
		for i=1,numberOfActors,1 do					
			EmitSfx(dramatisPersona3d[15][2], 1025)
			EmitSfx(dramatisPersona3d[15][2], 1027)
		end
		Sleep(150) 
	end
	for i=1,numberOfActors,1 do
		randy=math.random(100,350)
		Explode(dramatisPersona3d[i][2],SFX.FIRE+SFX.SMOKE +SFX.FALL +SFX.EXPLODE_ON_HIT)
		Hide(dramatisPersona3d[i][2])
		Sleep(randy)
	end	
	
	
	Sleep(100)
	EmitSfx(buibaicity, 1024)
	Move(buibaicity,y_axis,-50,7)
	EmitSfx(buibaicity, 1024)
	Sleep(800)
	Hide(buibaicity)
	
	createCorpseCBuilding(unitID,recentDamage)
	return 0
end



--------BUILDING---------