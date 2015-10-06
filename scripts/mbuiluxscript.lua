include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 


local mbuilux = piece "mbuilux"
local bldoor1  = piece  "bldoor1"
local bldoor2 = piece "bldoor2"
local blground= piece"blground"
local mbuiluxcenter=piece"mbuiluxcenter"
local SIG_Activate=2
local SIG_InActivate=4
local SIG_WIND=8
local SIG_IDLE=16
curtain={}
for i=1, 80, 1 do
curtain[i]={}
temp="Curtain"..i
curtain[i]=piece(temp)
end

function idle(negset,target)

target=target%35
SetSignalMask(SIG_IDLE)


for i=target,target+5, 1 do
Speeddiffy=(math.random(1,2))/(((i+1)*5)-target)
Turn(curtain[i],x_axis,math.rad(0),Speeddiffy)
end
WaitForTurn(curtain[target],x_axis)
randElay=math.random(350,650)
Sleep(randElay)


	while(true) do
		for i=target,target+5, 1 do
		Speeddiffy=(math.random(1,2))/(((i+1)*5)-target)
		val=math.random(-4.2,0.25)
		Turn(curtain[i],x_axis,math.rad(val*negset),Speeddiffy/10)
		end
	WaitForTurn(curtain[target],x_axis)
	Sleep(100)
	end

end


function windStoss(delaytime,StartVal, StrengthInDegree, StrenghtOfWind,length,negset)

SetSignalMask(SIG_WIND)
Sleep(delaytime)
boolFlipFlop=false
local pieight= 3.145159/8
local pifourth= 3.145159/4

--Tongue rolled
if math.random(0,1)==1 then
Turn(curtain[StartVal],x_axis,math.rad(35*negset),1.89)
WaitForTurn(curtain[StartVal],x_axis)
		for i=1, 4 do
		val=-60*negset
		Turn(curtain[StartVal+i],x_axis,math.rad(val),1.26)
		end
Turn(curtain[StartVal],x_axis,math.rad(62*negset),1.89)
WaitForTurn(curtain[StartVal],x_axis)
		for i=1, 4 do
		Turn(curtain[StartVal+i],x_axis,math.rad(0),2.26)
		if i%2==0 then 	Sleep(450) end
		end
end


for i=1,length,1 do
if boolFlipFlop== false then boolFlipFlop=true else boolFlipFlop=false end

MaxDegree=(math.random(42,62))


	if boolFlipFlop==true then
	Turn(curtain[StartVal],x_axis,math.rad(MaxDegree*negset-12),0.65)
		for i=1, 4 do
		val=(math.cos(i*pifourth)*-25*negset)
		Turn(curtain[StartVal+i],x_axis,math.rad(val),0.34)
		end
	else
	Turn(curtain[StartVal],x_axis,math.rad(MaxDegree*negset+12),0.85)
		for i=1, 4 do
		val=(math.sin(i*pifourth)*-25*negset)
		Turn(curtain[StartVal+i],x_axis,math.rad(val),0.57)
		end
	end
	
WaitForTurn(curtain[StartVal],x_axis)

end

Sleep(250) --Return down

		Turn(curtain[StartVal],x_axis,math.rad(20),0.85)	
		for i=1, 4 do
		val=(math.cos(i*pifourth)*-25*negset)
		Turn(curtain[StartVal+i],x_axis,math.rad(val),0.67)
		end
		WaitForTurn(curtain[StartVal],x_axis)
		
		Turn(curtain[StartVal],x_axis,math.rad(0),0.85)
		for i=1, 4 do
		Turn(curtain[StartVal+i],x_axis,math.rad(0),0.97)
		end
		WaitForTurn(curtain[StartVal],x_axis)
		
	
	while(true) do

		for i=StartVal,StartVal+4, 1 do
	Speeddiffy=(math.random(3,5))/(5-(i-StartVal))
	val=math.random(-1.2,0.25)
			Turn(curtain[i],x_axis,math.rad(val*negset),Speeddiffy/100)
		end
	WaitForTurn(curtain[StartVal],x_axis)
	Sleep(100)
	end
end

function windyS()
	while(true) do
	Signal(SIG_IDLE)
	--windburst
	howLongRand=math.random(1,25)
	StarStrenght=35
	windStrenght=math.random(1,3)
	longusLonger=math.random(4,12)
		for i=1,table.getn(curtain)-4,5 do
		StarStrenght=(StarStrenght+math.random(-5,5)) %50
		delayDice=math.random(200,800)
			negset=-1
			if i < 20 or i>40 and i < 60  or i > 90 and i < 100 then
			negset=1
			end
		templ=longusLonger+math.random(-1,1)
		                    --(delaytime,StartVal, StrengthInDegree, StrenghtOfWind,length,negset)
		StartThread(windStoss,delayDice,i, StarStrenght, windStrenght,templ,negset)
		end
	Sleep(12000)
	Signal(SIG_WIND)
	--randomidletime
	for i=1,table.getn(curtain)-4,5 do
		
			negset=1
			if i < 20 or i>40 and i < 60  or i > 90 and i < 100 then
			negset=-1
			end
		StartThread(idle,negset,i)
		end
	randSleep=math.random(12000,34000)
	Sleep(randSleep)

	end
end
  -- globalCityWideAlarm=0
--local boolAllreadyAlarmed=false 

		 numberOfActors=6
		dramatisPersona3d={}



LastDamage=0

	function script.HitByWeapon ( x, z, weaponDefID, damage )
	LastDamage=damage
	return damage
	end


function costlyUnderAttack()

	while true do

		if LastDamage> 0  then
			LastDamage=0
			Spring.UseUnitResource(unitID,"e",50)
			Spring.UseUnitResource(unitID,"m",5)
		
		end
	Sleep(500)
	end
end






----------------------------------------------------
--globallos

M3dmaxDist=45
M3dminDist=0
M3dmaxHeight=400
M3dminHeight=0






----------------------------------------------------


 -----------------------------------------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------------------


--personObjects


		
		  person={}
		--traditional pieces hiearchy, swingCenter beeing the Center
		  swingCenter1 = piece "swingCenter1"
		person[1]=swingCenter1  --swingCenter always atfirstPlace 1

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
					--      counterclockwise its 8

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
		person[1]=swingCenter2  --swingCenter always atfirstPlace 1

		  car2 = piece "car2" -- the persons centerpiece 2
		person[2]=car2 


		

		

		
		
		person[3]=piecetable 

		-- a person is defined by the following values:   --its height in the 3dmatrixgrid
	
		-- its position in degree and distance 
		  degree=0
		person[4]=degree 
		  dist=0
		person[5]=dist 
		-- its facing value --all units start facing .. outside 
					--Enum: inside is 1, 
					--		outside is 2, 
					--		clockwise is 4, 
					--      counterclockwise its 8

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
		person[1]=swingCenter3  --swingCenter always atfirstPlace 1

		  car3 = piece "car3" -- the persons centerpiece 2
		person[2]=car3 


		

		

		
		
		person[3]=piecetable 

		-- a person is defined by the following values:   --its height in the 3dmatrixgrid
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
					--      counterclockwise its 8

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
		person[1]=swingCenter4  --swingCenter always atfirstPlace 1

		  car4 = piece "car4" -- the persons centerpiece 2
		person[2]=car4 


		

		

		
		
		person[3]=piecetable 

		-- a person is defined by the following values:   --its height in the 3dmatrixgrid
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
					--      counterclockwise its 8

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
		person[1]=swingCenter5  --swingCenter always atfirstPlace 1

		  car5 = piece "car5" -- the persons centerpiece 2
		person[2]=car5 


		

		

		
		
		person[3]=piecetable 

		-- a person is defined by the following values:   --its height in the 3dmatrixgrid
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
					--      counterclockwise its 8

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
		person[1]=swingCenter6  --swingCenter always atfirstPlace 1

		  car6 = piece "car6" -- the persons centerpiece 2
		person[2]=car6 


		

		

		
		
		person[3]=piecetable 

		-- a person is defined by the following values:   --its height in the 3dmatrixgrid
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
					--      counterclockwise its 8

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



function instclose()

--	boolAllre
	Move(mbuilux,y_axis,-304,0)

	Show(bldoor1)
	Show(bldoor2)
	Move(bldoor1,y_axis,56,0)
	Move(bldoor2,y_axis,57,0)
 	Turn(bldoor1,z_axis,math.rad(-90),0)
	Turn(bldoor2,z_axis,math.rad(90),0)
	
end






------------------------------------------------------------------------------------------------------------------------------------------------


function stillMoving(personNr)
	if (true==Spring.UnitScript.IsInMove(dramatisPersona3d[personNr][2], z_axis) or true== Spring.UnitScript.IsInTurn(dramatisPersona3d[personNr][1], y_axis))  then 
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
targetHeight=240
luckOne=0
if math.random(0,1)==1 then
luckOne=math.random(1.2,5)
end
tempDirAction=1
tempSpeed=dramatisPersona3d[personNr][10]
--if car views inside                           
if dramatisPersona3d[personNr][6]== 1  then
	--move it through the center  move along center axis -lower Axis
	Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(0),4)
	WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
	
	dramatisPersona3d[personNr][5]=targetDist
	
	Move(dramatisPersona3d[personNr][2],z_axis,targetDist,(tempSpeed*6)+luckOne)
	tempDirAction=8
	
	
			elseif dramatisPersona3d[personNr][6]== 2  then
			--if car views outside beeing high, turn right, turn along radiant via SwingCenter - +down

								Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(270),4) --FixMe90
								WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
								
								dramatisPersona3d[personNr][4]=targetdegree	
								Move(dramatisPersona3d[personNr][2],y_axis,0,tempSpeed*1.4)
								dramatisPersona3d[personNr][13]=0
								Turn(dramatisPersona3d[personNr][1],y_axis,math.rad(targetdegree),((dramatisPersona3d[personNr][10])/100)+0.1)--0.3
								tempDirAction=1
								
						elseif dramatisPersona3d[personNr][6]== 4  then

						--if car turned right nach innen drehen, move along the uper axis

							Turn(dramatisPersona3d[personNr][2],y_axis,math.rad(180),4)
							WaitForTurn(dramatisPersona3d[personNr][2],y_axis)
							dramatisPersona3d[personNr][5]=NtargetDist
							Move(dramatisPersona3d[personNr][2],z_axis,NtargetDist,(tempSpeed*6)+luckOne)
							tempDirAction=2
						elseif dramatisPersona3d[personNr][6]== 8  then

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
--if car views outside beeing beeing low turn  turn left

					--Enum: inside is 1, 
					--		outside is 2, 
					--		clockwise is 4, 
					--      counterclockwise its 8
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

		-- now we need a time, and a idleanimation so the person arriving at the ways end, doesent just stands around
	
-- we return the random direction

--finally we set the unit back into jobless mode, so the partymanager can grab it again, and send it on its way
dramatisPersona3d[personNr][9]=false
end

function starterKid()
for i=1,numberOfActors,1 do
dramatisPersona3d[i][9]=false
sleeper=math.random(2000,25000)
Sleep(sleeper)
Show((dramatisPersona3d[i][2]))
end


end

--This is the PartyManager - this function decides were everyone goes
function PartyManager()
for i=1,numberOfActors,1 do
dramatisPersona3d[i][9]=true
Hide((dramatisPersona3d[i][2]))
end
--Spring.Echo("PartyManager Activated")

--FixMe
StartThread(starterKid)


		while(true) do
					for i=1, numberOfActors,1 do
								
							if dramatisPersona3d[i][9] == false  then  --else the piece is a standaloner on the neverending party allready busy
								dramatisPersona3d[i][9]=true
							
							 moveInOut=1
							degreeRand=2--0*360 in 45 degree Steps
						
																	StartThread(senderJobFunc,i)
																
																
							end
					end

		Sleep(120)
		end



end

















--this function opens the bunkerdoor -pushes the building up
local function open()
Spring.PlaySoundFile("sounds/cbuil/cbuilrise.wav")
	--boolAllreadyAlarmed=false
	--globalCityWideAlarm=0	

    SetSignalMask(SIG_Activate)
	
	Turn(bldoor1,z_axis,math.rad(-15),0.5)
	Turn(bldoor2,z_axis,math.rad(-15),0.5)
	Sleep(50)
	WaitForTurn(bldoor1,z_axis)
	WaitForTurn(bldoor2,z_axis)
	Turn(bldoor1,z_axis,math.rad(0),1.5)
	Turn(bldoor2,z_axis,math.rad(0),1.5)
	Sleep(50)
	WaitForTurn(bldoor1,z_axis)
	WaitForTurn(bldoor2,z_axis)
	Move(bldoor1,y_axis,-52,1.55)
	Move(bldoor2,y_axis,-54,1.75)
	WaitForMove(bldoor2,y_axis)
	WaitForMove(bldoor1,y_axis)
	Move(mbuilux,y_axis,0,1.5)
	WaitForMove(mbuilux,y_axis)
	Hide(bldoor1)
	Hide(bldoor2)
	--while(globalCityWideAlarm==0) do
	while(true) do
	Sleep(4192)
	end
	
end

function test()
while(true) do
Turn(curtain[1],x_axis,math.rad(-5),1)
WaitForTurn(curtain[1],x_axis)
Turn(curtain[2],x_axis,math.rad(-2.5),1)
WaitForTurn(curtain[2],x_axis)
Turn(curtain[3],x_axis,math.rad(-1.25),1)
WaitForTurn(curtain[3],x_axis)
Turn(curtain[4],x_axis,math.rad(-0.625),1)
WaitForTurn(curtain[4],x_axis)
for i=1,5,1 do
Turn(curtain[i],x_axis,math.rad(0),0.25)
end
Sleep(1000)
end
end


--this function retracts the building, closes the bunker doors
function close()

--	boolAllreadyAlarmed=true 
--	globCityWideAlarm=1
	Spring.PlaySoundFile("sounds/cbuil/cbuilretr.wav")
    SetSignalMask(SIG_InActivate)
	
	Move(mbuilux,y_axis,-304,3.5)
	WaitForMove(mbuilux,y_axis)
	Show(bldoor1)
	Show(bldoor2)
	
	Move(bldoor1,y_axis,40,8)
	Move(bldoor2,y_axis,40,8)
	WaitForMove(bldoor2,y_axis)
	WaitForMove(bldoor1,y_axis)
	Move(bldoor1,y_axis,56,1.85)
	Move(bldoor2,y_axis,57,1.85)
 	Turn(bldoor1,z_axis,math.rad(-90),0.24)
	Turn(bldoor2,z_axis,math.rad(90),0.24)
	Spring.PlaySoundFile("sounds/cComon/cBunkerShut.wav")
	WaitForMove(bldoor2,y_axis)
	WaitForMove(bldoor1,y_axis)
	
	

	Sleep(50)

	WaitForTurn(bldoor1,z_axis)
	WaitForTurn(bldoor2,z_axis)
	
	

	--while(globalCityWideAlarm==1) do

end

teamID=Spring.GetUnitTeam(unitID)


function script.Create()

--StartThread(test)
--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)

if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)

--</buildanimationscript>


		fourFeather=math.random(0,3)
		if fourFeather==0 then
		Turn(mbuiluxcenter,y_axis,math.rad(90),0)
		elseif fourFeather==1 then
		Turn(mbuiluxcenter,y_axis,math.rad(180),0)
		elseif fourFeather==2 then
		Turn(mbuiluxcenter,y_axis,math.rad(270),0)
		end


Hide(bldoor2)
Hide(bldoor2)
--instclose()
--boolAllreadyAlarmed=false 
--StartThread(alarmCheck)
--StartThread(open)
StartThread(PartyManager)
StartThread(windyS)
StartThread(alarmCheck)--
StartThread(playSoundByUnitTypOS,unitID,0.7,{
												{name="sounds/cbuilux/neverendingparty.ogg",time=15000},
												{name="sounds/cbuilux/neverendingpartyup.ogg",time=15000},
												{name="sounds/cbuilux/neverendingpartyup2.ogg",time=15000},
												{name="sounds/cbuilux/neverendingpartyup3.ogg",time=10000},
												})
end


-- function script.Killed(recentDamage,_)
-- Explode(mbuilux,SFX.SHATTER)
-- Explode(bldoor1,SFX.FIRE)
-- Explode(bldoor2,SFX.FIRE)
-- suddenDeath(unitID,recentDamage)
-- return 0
-- end



function script.Activate()
if teamID and GG.Alarm== nil then 
GG.Alarm={}
GG.Alarm[teamID]={}
GG.Alarm[teamID]=false
end
GG.Alarm[teamID]=false
	return 1
end

function script.Deactivate()
if teamID and GG.Alarm== nil then 
GG.Alarm={}
GG.Alarm[teamID]={}
GG.Alarm[teamID]=true
end
GG.Alarm[teamID]=true
	return 0
end


--------BUILDING---------
statusOfOld=nil

function alarmCheck()
if teamID and GG.Alarm== nil then 
GG.Alarm={}
GG.Alarm[teamID]={}
GG.Alarm[teamID]=false
end


if GG.Alarm[teamID]==true then
statusOfOld=true
else 
statusOfOld=false
end
	  
		while(true) do
				if GG.Alarm[teamID] == true and GG.Alarm[teamID] ~= statusOfOld then
				--case Alarm and building is still open
				statusOfOld=true
		
				Signal(SIG_Activate)
				Signal(SIG_InActivate)
				
				StartThread(close)
				end
				
					if GG.Alarm[teamID] == false  and GG.Alarm[teamID] ~= statusOfOld then
					--case no Alarm and building is still retracted
						Signal(SIG_Activate)
						Signal(SIG_InActivate)
						StartThread(open)		
						statusOfOld=false
			
					end
					
				Sleep(4095)
					--nothing
					
				


	
		end
end



