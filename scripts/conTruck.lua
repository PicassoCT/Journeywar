include "suddenDeath.lua"

deathpivot=piece"deathpivot"
dustemit1=piece"dustemit1"
dustemit2=piece"dustemit2"

craneTow= piece"craneTow"
sparkEmit= piece"sparkemit"
cranearmlo=piece"cranearmlo"
cranearmup=piece"cranearmup"
welder=piece"welder"

boolContainerDropInProgress=false

boolcontain1loaded=true
boolcontain2loaded=true
boolcontain3loaded=true
containArray={}

	contain01= piece"contain01"
	contain02= piece"contain02"
	contain03= piece"contain03"
	table.insert(containArray,contain01)
	table.insert(containArray,contain02)
	table.insert(containArray,contain03)
	farout1= piece"farout1"
	containerswing1=piece"containerswing1"
	
	contain07= piece"contain07"
	contain08= piece"contain08"
	contain09= piece"contain09"
	

	farout3= piece"farout3"
	containerswing3=piece"containerswing3"
		
	contain04= piece"contain04"
	contain05= piece"contain05"
	contain06= piece"contain06"
	table.insert(containArray,contain04)
	table.insert(containArray,contain05)
	table.insert(containArray,contain06)
	
	table.insert(containArray,contain07)
	table.insert(containArray,contain08)
	table.insert(containArray,contain09)
	farout2= piece"farout2"
	containerswing2=piece"containerswing2"
globalPitch=0
globalHeading=0
headingOffSet=18
oneFourthHealth=Spring.GetUnitHealth(unitID)


EverythingIsBetterWithWheels={}
for i=1,6,1 do
EverythingIsBetterWithWheels[i]={}
piecename="wheel"..i
EverythingIsBetterWithWheels[i]=piece(piecename)

end
fingers={}
for i=1,6,1 do
fingers[i]={}
piecename="finger0"..i
fingers[i]=piece(piecename)

end

--unitPieces

droppedContainers={}

local boolLongStop=true
local boolMoving=false
local boolShortStop=true
local boolmove=false

local SIG_MOVE=4
local SIG_BUILD=2
local SIG_INDY=8
local SIG_WORK=16
local SIG_WELD=32
local SIG_SOUND=64
local SIG_CONTAIN=128


function getInvertedGlobalHeading()
inverse=360-globalHeading

return inverse
end

function hideContainers()
	if #droppedContainers~= 0 then
		for i=1,table.getn(droppedContainers),1 do
		Hide(droppedContainers[i])
		end
		
		droppedContainers={}
	end
	
end



function timeDelayedThreadStarter()
SetSignalMask(SIG_MOVE)

Sleep(350)

StartThread(emitDustRotateWheels)
end

function emitDustRotateWheels()
SetSignalMask(SIG_INDY)
for i=1,6,1 do
Spin(EverythingIsBetterWithWheels[i],x_axis,math.rad(42),0.6)
end

	while(boolmove==true) do 
	de=math.ceil(math.random(190,360))
	Sleep(de)
	EmitSfx(dustemit1,1024)
	EmitSfx(dustemit2,1024)

	end
for i=1,6,1 do
StopSpin(EverythingIsBetterWithWheels[i],x_axis,math.rad(12),0.2)
end
end

function drivingOnSound()
SetSignalMask(SIG_SOUND)
Sleep(450)
i=math.random(0,15)
	if i==1 then
	Spring.PlaySoundFile("sounds/contruck/drivingOn1.wav")
		elseif i==2 then
		Spring.PlaySoundFile("sounds/contruck/drivingOn2.wav")
			elseif i==3 then
			Spring.PlaySoundFile("sounds/contruck/drivingOn3.wav")
			end


end


function script.StartMoving()
boolmove=true
Signal(SIG_MOVE)
Signal(SIG_SOUND)
	if drivingOnSound then
	StartThread(drivingOnSound)
	StartThread(timeDelayedThreadStarter)
	end
hideContainers()
end

function script.StopMoving()
--Signal(SIG_MOVE)
boolmove=false
end

function moveContainer2()
table.insert(droppedContainers,contain01)
table.insert(droppedContainers,contain02)
table.insert(droppedContainers,contain03)

SetSignalMask(SIG_CONTAIN)
Move(farout1,z_axis,90,0.5)
	while (true==Spring.UnitScript.IsInMove (farout1, z_axis) and boolmove==false) do
	Move(contain01,z_axis,8,0.5)
	Move(contain03,z_axis,0,0.5)
	WaitForMove(contain01,z_axis)
	WaitForMove(contain03,z_axis)
	Move(contain01,z_axis,0,0.5)
	Move(contain03,z_axis,-8,0.5)
	WaitForMove(contain01,z_axis)
	WaitForMove(contain03,z_axis)
	Sleep(10)
	end
	Hide(contain01)
	Hide(contain02)
	Hide(contain03)
	
end

function moveContainer7()
table.insert(droppedContainers,contain07)
table.insert(droppedContainers,contain08)
table.insert(droppedContainers,contain09)
SetSignalMask(SIG_CONTAIN)
Move(farout3,z_axis,90,0.5)
	while (true==Spring.UnitScript.IsInMove (farout3, z_axis) and boolmove==false) do
	Move(contain08,z_axis,8,0.5)
	Move(contain09,z_axis,0,0.5)
	WaitForMove(contain08,z_axis)
	WaitForMove(contain09,z_axis)
	Move(contain08,z_axis,0,0.5)
	Move(contain09,z_axis,-8,0.5)
	WaitForMove(contain08,z_axis)
	WaitForMove(contain09,z_axis)
		Sleep(10)
	end
	Hide(contain07)
	Hide(contain08)
	Hide(contain09)
	
end


function moveContainer4()
table.insert(droppedContainers,contain04)
table.insert(droppedContainers,contain05)
table.insert(droppedContainers,contain06)
SetSignalMask(SIG_CONTAIN)

Move(farout2,z_axis,90,0.5)
	while (true==Spring.UnitScript.IsInMove (farout2, z_axis) and boolmove==false) do
	Move(contain05,z_axis,8,0.5)
	Move(contain06,z_axis,0,0.5)
	WaitForMove(contain05,z_axis)
	WaitForMove(contain06,z_axis)
	Move(contain05,z_axis,0,0.5)
	Move(contain06,z_axis,-8,0.5)
	WaitForMove(contain05,z_axis)
	WaitForMove(contain06,z_axis)
		Sleep(10)
	end
	Hide(contain04)
	Hide(contain05)
	Hide(contain06)
	
end

function dropContainer(nr)
boolContainerDropInProgress=true
Signal(SIG_WELD)
Turn(craneTow,y_axis,math.rad(-180),4)
Turn(cranearmlo,x_axis,math.rad(-3),5)
Turn(cranearmup,x_axis,math.rad(6),5)
Turn(welder,x_axis,math.rad(82),4)
WaitForTurn(cranearmup,x_axis)
WaitForTurn(cranearmlo,x_axis)
WaitForTurn(welder,x_axis)
fingerExpand()
----Spring.Echo("globalInvertedHeading",globalHeading)
	if nr==3 then
	
 boolcontain3loaded=false
	Turn(craneTow,y_axis,math.rad(-173),0.4)
	Turn(cranearmlo,x_axis,math.rad(-95),0.5)
	Turn(cranearmup,x_axis,math.rad(12),0.5)
	Turn(welder,x_axis,math.rad(155),0.4)
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForTurn(welder,x_axis)
	fingerContract()
	Turn(craneTow,y_axis,math.rad(-173),0.4)
	Turn(cranearmlo,x_axis,math.rad(-47),0.5)
	Turn(cranearmup,x_axis,math.rad(25),0.5)
	Turn(welder,x_axis,math.rad(103),0.4)
	Move(contain02,y_axis,22,24)	
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForTurn(welder,x_axis)
	Sleep(350)
	Turn(craneTow,y_axis,math.rad(globalHeading),0.4)
	Turn(containerswing1,y_axis,math.rad(globalHeading+180),0.4)
	WaitForTurn(craneTow,y_axis)
	WaitForTurn(containerswing1,y_axis)
	Move(farout1,z_axis,55,24)
	
	Turn(cranearmlo,x_axis,math.rad(-107),0.5)
	Turn(cranearmup,x_axis,math.rad(74),0.5)
	Turn(welder,x_axis,math.rad(103),0.4)
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForMove(farout1,z_axis)	
	Move(contain02,y_axis,-17,28)
	Turn(cranearmlo,x_axis,math.rad(-142),0.5)
	Turn(cranearmup,x_axis,math.rad(74),0.5)
	Turn(welder,x_axis,math.rad(145),0.4)
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForMove(contain02,y_axis)
	fingerExpand()
	Turn(cranearmlo,x_axis,math.rad(-123),0.5)
	WaitForTurn(cranearmlo,x_axis)
	StartThread(moveContainer2)
		elseif nr==2 then
boolcontain2loaded=false
	Turn(craneTow,y_axis,math.rad(168),0.4)
	Turn(cranearmlo,x_axis,math.rad(-99),0.5)
	Turn(cranearmup,x_axis,math.rad(14),0.5)
	Turn(welder,x_axis,math.rad(155),0.4)
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForTurn(welder,x_axis)
	fingerContract()
	Turn(craneTow,y_axis,math.rad(-173),0.4)
	Turn(cranearmlo,x_axis,math.rad(-47),0.5)
	Turn(cranearmup,x_axis,math.rad(25),0.5)
	Turn(welder,x_axis,math.rad(103),0.4)
	Move(contain04,y_axis,25,22)	
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForTurn(welder,x_axis)
	Sleep(350)
	Turn(craneTow,y_axis,math.rad(globalHeading-3),0.4)
	Turn(containerswing2,y_axis,math.rad(globalHeading+180),0.4)
	WaitForTurn(craneTow,y_axis)
	WaitForTurn(containerswing2,y_axis)
	Move(farout2,z_axis,55,24)
	
	Turn(cranearmlo,x_axis,math.rad(-107),0.5)
	Turn(cranearmup,x_axis,math.rad(74),0.5)
	Turn(welder,x_axis,math.rad(103),0.4)
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForMove(farout2,z_axis)	
	Move(contain04,y_axis,-17,28)
	Turn(cranearmlo,x_axis,math.rad(-142),0.5)
	Turn(cranearmup,x_axis,math.rad(74),0.5)
	Turn(welder,x_axis,math.rad(145),0.5)
	WaitForTurn(cranearmup,x_axis)
	WaitForTurn(cranearmlo,x_axis)
	WaitForMove(contain04,y_axis)
	fingerExpand()
	Turn(cranearmlo,x_axis,math.rad(-123),0.5)
	WaitForTurn(cranearmlo,x_axis)
	StartThread(moveContainer4)
			else
			boolcontain1loaded=false
				Turn(craneTow,y_axis,math.rad(-205),0.4)
				Turn(cranearmlo,x_axis,math.rad(-99),0.5)
				Turn(cranearmup,x_axis,math.rad(14),0.5)
				Turn(welder,x_axis,math.rad(155),0.4)
				WaitForTurn(cranearmup,x_axis)
				WaitForTurn(cranearmlo,x_axis)
				WaitForTurn(welder,x_axis)
				fingerContract()
				Turn(craneTow,y_axis,math.rad(-173),0.4)
				Turn(cranearmlo,x_axis,math.rad(-47),0.5)
				Turn(cranearmup,x_axis,math.rad(25),0.5)
				Turn(welder,x_axis,math.rad(103),0.4)
				Move(contain07,y_axis,27,20)	
				WaitForTurn(cranearmup,x_axis)
				WaitForTurn(cranearmlo,x_axis)
				WaitForTurn(welder,x_axis)
				Sleep(350)
				Turn(craneTow,y_axis,math.rad(globalHeading-3),0.4)
				Turn(containerswing3,y_axis,math.rad(globalHeading+180),0.4)
				WaitForTurn(craneTow,y_axis)
				WaitForTurn(containerswing3,y_axis)
				Move(farout3,z_axis,55,24)
				
				Turn(cranearmlo,x_axis,math.rad(-107),0.5)
				Turn(cranearmup,x_axis,math.rad(74),0.5)
				Turn(welder,x_axis,math.rad(103),0.4)
				WaitForTurn(cranearmup,x_axis)
				WaitForTurn(cranearmlo,x_axis)
				WaitForMove(farout3,z_axis)	
				Move(contain07,y_axis,-10,28)
				Turn(cranearmlo,x_axis,math.rad(-142),0.5)
				Turn(cranearmup,x_axis,math.rad(74),0.5)
				Turn(welder,x_axis,math.rad(145),4)
				WaitForTurn(cranearmup,x_axis)
				WaitForTurn(cranearmlo,x_axis)
				WaitForMove(contain07,y_axis)
				fingerExpand()
				Turn(cranearmlo,x_axis,math.rad(-123),0.5)
				WaitForTurn(cranearmlo,x_axis)
				StartThread(moveContainer7)


			end
boolContainerDropInProgress=false
StartThread(arcWeld,globalHeading,globalPitch)
end



containers=3

local function workInProgress()




							
	
	SetSignalMask(SIG_WORK)
	while(true)do

	actualHealth=Spring.GetUnitHealth (unitID ) 
												if actualHealth == 1 then
												actualHealth=actualHealth-1
												 Spring.SetUnitNoSelect (unitID, true)
												--makes the Unit go home, to the place it was born- west Virginia
											
												
												Spring.SetUnitHealth(unitID,actualHealth)
												end
	actualHealth=actualHealth-1
	Spring.SetUnitHealth(unitID,actualHealth)
	
		if containers~= 0 and actualHealth < containers*oneFourthHealth and boolContainerDropInProgress==false then
		StartThread(dropContainer,containers)
		----Spring.Echo("actual Health:", actualHealth)
		containers=containers-1
		end
		
	Sleep(250)
	
	end
	

end

function setGlobalHeading(heading)
globalHeading=(math.deg(heading))-180
if globalHeading <0 then
globalHeading=360-globalHeading
end
end

function script.Create()
Hide(deathpivot)
oneFourthHealth=(Spring.GetUnitHealth(unitID))/4

birthX,birthY,birthZ=Spring.GetUnitPosition(unitID)
 --updateDelete


Spring.PlaySoundFile("sounds/contruck/drivingOn1.wav")
end

function script.Killed(recentDamage,_)

--needsWreckageFeature
--fixxed
Explode( EverythingIsBetterWithWheels[1], SFX.FIRE + SFX.SMOKE)      
Explode( EverythingIsBetterWithWheels[2], SFX.FIRE + SFX.SMOKE)      
Explode( EverythingIsBetterWithWheels[3], SFX.FIRE + SFX.SMOKE)      
Explode( EverythingIsBetterWithWheels[4], SFX.FIRE + SFX.SMOKE)      

   
  
Sleep(700)
suddenDeathVM(recentDamage)

return 1
end
function fingerContract()
howWide=math.random(25,42)
for i=1,3,1 do
randSpeed=math.random(0.5,1.7)
Turn(fingers[i],y_axis,math.rad(howWide*-1),randSpeed)
end
for i=4,6,1 do
randSpeed=math.random(0.5,1.7)
Turn(fingers[i],y_axis,math.rad(howWide),randSpeed)
end

end

function fingerExpand()
for i=1,6,1 do
randSpeed=math.random(0.5,1.7)
Turn(fingers[i],y_axis,math.rad(0),randSpeed)
end
end

function fingerIdling(iterrator,naptime)
for i=1,iterrator,1 do
fingerContract()
Sleep(naptime)
fingerExpand()
Sleep(naptime)
end

end

function arcWeld(heading,pitch)

Turn(cranearmlo,x_axis,math.rad(-64),0.8)
Turn(cranearmup,x_axis,math.rad(51),0.8)
Turn(welder,x_axis,math.rad(85),2.8)
WaitForTurn(welder,x_axis)
WaitForTurn(cranearmup,x_axis)
WaitForTurn(cranearmlo,x_axis)

SetSignalMask(SIG_WELD)
while(true)do
--randomized Heading
headingOffSetter=math.random(-1*headingOffSet,headingOffSet)
headrad=(math.deg(heading))-180
if headrad < 0 then 
headrad=headrad+360
----Spring.Echo("ConTruckHeading:",heading)
end
Turn(craneTow,y_axis,math.rad(headrad+headingOffSetter),0.7)
WaitForTurn(craneTow,y_axis)
--randomized lower arm
offSet=math.random(-10,10)
lowSet=math.random(-126,-39)
lowSet=lowSet+offSet
Turn(cranearmlo,x_axis,math.rad(lowSet),2.6)

proportionScale=math.sqrt(((lowSet+39)/87)^2)
negProportionScale=1-proportionScale
max=(math.random(80,120))*proportionScale
min=(math.random(3,30))*negProportionScale
final=max+min
Turn(cranearmup,x_axis,math.rad(final),1.2)






--randomized upperArm
offSet=math.random(-10,10)

--randomize Welder
weld=math.random(18,151)
Turn(welder,x_axis,math.rad(weld),0.9)
StartThread(fingerIdling,8,600)
WaitForTurn(cranearmup,x_axis)
WaitForTurn(cranearmlo,x_axis)

	randDuration=math.random(2,12)
	Spring.PlaySoundFile("sounds/contruck/weld.wav")
	for i=1,randDuration,1 do
	EmitSfx(sparkEmit,1026)
	EmitSfx(sparkEmit,1026)
	Sleep(120)
	EmitSfx(sparkEmit,1026)
	end

random=math.random(260,830)
Sleep(random)
end
end

function foldCrane()
Turn(cranearmlo,x_axis,math.rad(0),1.2)
Turn(cranearmup,x_axis,math.rad(0),1.2)
Turn(welder,x_axis,math.rad(0),1.2)
WaitForTurn(cranearmlo,x_axis)
WaitForTurn(cranearmup,x_axis)
Turn(craneTow,y_axis,math.rad(0),3.3)

end



--------BUILDING---------
function script.StopBuilding()

	Signal(SIG_WORK)
	Signal(SIG_WELD)
 lastKnownPosX=0
 lastKnownPosY=0
 lastKnownPosZ=0
 	--
StartThread(foldCrane)	

	SetUnitValue(COB.INBUILDSTANCE, 0)
end


function script.StartBuilding(heading, pitch)
	setGlobalHeading(heading)
	globalPitch=pitch
    Spring.PlaySoundFile("sounds/contruck/weld.wav")	

	Signal(SIG_WORK)
	Signal(SIG_WELD)
	--Signal(SIG_CHECK)
	StartThread(workInProgress)
	StartThread(arcWeld,heading,pitch)
							
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

function script.QueryNanoPiece()
     return sparkEmit
end






