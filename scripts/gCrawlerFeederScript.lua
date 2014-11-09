include "suddenDeath.lua"
include "toolKit.lua"

EverythingIsBetterWithWheels={}

bWheel1 = piece"bWheel1"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= bWheel1
bWheel2 = piece"bWheel2"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= bWheel2
bWheel3 = piece"bWheel3"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= bWheel3
bWheel4 = piece"bWheel4"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= bWheel4
bWheel5 = piece"bWheel5"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= bWheel5
bWheel6 = piece"bWheel6"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= bWheel6

SIG_DELAY=2

piecesTable={}
center = piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
SandCrawler3DS = piece"SandCrawler.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandCrawler3DS
Crawler = piece"Crawler"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Crawler

SandEmit1 = piece"SandEmit1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit1
SandEmit2 = piece"SandEmit2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit2
SandEmit3 = piece"SandEmit3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit3
SandEmit4 = piece"SandEmit4"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit4
SandEmit5 = piece"SandEmit5"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit5
SandEmit6 = piece"SandEmit6"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit6
SandEmit7 = piece"SandEmit7"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit7
SandEmit8 = piece"SandEmit8"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit8
SandEmit9 = piece"SandEmit9"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= SandEmit9

id=nil

function biggerThenDrive()
while true do
x1,y1,z1,_,_,_=Spring.GetUnitPiecePosDir(unitID,Earth1)
x2,y2,z2,_,_,_=Spring.GetUnitPiecePosDir(unitID,Earth2)
h1=Spring.GetGroundHeight(x1,z1)
h2=Spring.GetGroundHeight(x2,z2)

if h1-y1  < 2 then Show(Earth1) else Hide(Earth1) end
if h2-y2  < 2 then Show(Earth2) else Hide(Earth2) end

Sleep(1000)
end

end

function iGotIt()
Sleep(100)
local spSetUnitMoveGoal=Spring.SetUnitMoveGoal
local spGetUnitIsDead=Spring.GetUnitIsDead
local spGetUnitPositon=Spring.GetUnitPosition
x,y,z=spGetUnitPositon(unitID)
teamID=Spring.GetUnitTeam(unitID)

id=Spring.CreateUnit("gCrawler",math.abs(x-250),y,math.abs(z-250),3,teamID)
Spring.SetUnitNoSelect(id,true)
Spring.SetUnitAlwaysVisible(id,true)
	while spGetUnitIsDead(id)==false do
	x,y,z=spGetUnitPositon(unitID)
	spSetUnitMoveGoal(id,x,y,z)
	Sleep(500)
	end
	
Spring.DestroyUnit(unitID,true,true)
end


function script.Create()
StartThread(iGotIt)
StartThread(onTheMove)
StartThread(biggerThenDrive)

end

boolMoving=false

function onTheMove()

	while true do

		while boolMoving==false do
		Turn(Crawler,x_axis,math.rad(-1),0.03)
		Sleep(250)
		Turn(Crawler,x_axis,math.rad(1),0.03)
		Sleep(250)
		end
		Sleep(200)
		if boolMoving==true then
		Signal(SIG_DELAY)
		StartThread(spinArray,EverythingIsBetterWithWheels,x_axis, 12,0)
		Spin(Earth1,x_axis,math.rad(-25),0.2)
		Spin(Earth2,x_axis,math.rad(-25),0.2)
		Move(Earth1,y_axis,0,3)
		Move(Earth2,y_axis,0,3)
		Show(Earth1)
		Show(Earth2)
		end
		while boolMoving==true do
		
		
		Turn(Crawler,x_axis,math.rad(7),0.03)
				for i=1,5, 1 do
				if i%2==0 then 
				EmitSfx(SandEmit2,1024)
				EmitSfx(SandEmit1,1024)
				else
				EmitSfx(SandEmit2,1024)
				EmitSfx(SandEmit1,1024)
				EmitSfx(SandEmit3,1024)
				EmitSfx(SandEmit4,1024)
				EmitSfx(SandEmit5,1024)
				EmitSfx(SandEmit6,1024)
				EmitSfx(SandEmit7,1024)
				EmitSfx(SandEmit8,1024)
				EmitSfx(SandEmit9,1024)
				EmitSfx(SandEmit9,1026)
				EmitSfx(SandEmit9,1026)
				end
				Sleep(15)
				end
		Turn(Crawler,x_axis,math.rad(3),0.03)
		rand=math.ceil(math.random(100,400))
		Sleep(rand)
		end
		Sleep(200)
		if boolMoving==false then
		Signal(SIG_DELAY)
		StartThread(stopSpinArray,EverythingIsBetterWithWheels,x_axis,0)
		StopSpin(Earth1,x_axis,0.2)
		StopSpin(Earth2,x_axis,0.2)
		Move(Earth1,y_axis,-10,0)
		Move(Earth2,y_axis,-10,0)
		Hide(Earth1)
		Hide(Earth2)
		end
	end
end

function spinArray(Array,axis,radius,speed)
for i=1,table.getn(Array),1 do
Spin(Array[i],axis,math.rad(radius),speed)
end
end
	
function stopSpinArray(Array,axis,radius,speed)
for i=1,table.getn(Array),1 do
StopSpin(Array[i],axis,math.rad(radius),speed)
end
end	
	
function turnArray(Array,axis,radius,speed,waitForIt)
for i=1,table.getn(Array),1 do
Turn(Array[i],axis,math.rad(radius),speed)
end
	if waitForIt==true then
	WaitForTurn(Array[table.getn(Array)],axis)
	end
end

function script.Killed(h,k)
local unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
Spring.SpawnCEG("330RLexplode",unitx,unity,unitz,0,1,0,50,0)

suddenDeathVM(recentDamage)
return 0
end


Earth1=piece"Earth1"
Earth2=piece"Earth2"

	
function script.StartMoving()

boolMoving=true
end

boolOnlyOnce=true
function delayedStop()
if boolOnlyOnce==false then return end
Sleep(1500)
	
	boolMoving=false
	
boolOnlyOnce=true
end

function script.StopMoving()
StartThread(delayedStop)
end

			
		
		
