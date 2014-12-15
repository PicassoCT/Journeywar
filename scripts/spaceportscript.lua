include "suddenDeath.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

  piecesTable={}
  center = piece"center"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= center
  Port = piece"Port"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Port
  Elevator2 = piece"Elevator2"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Elevator2
  Elevator1 = piece"Elevator1"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Elevator1
  FireSphere = piece"FireSphere"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= FireSphere
  Tower = piece"Tower"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Tower
  shipBay02 = piece"shipBay02"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipBay02
  ship02 = piece"ship02"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= ship02
  shipBay03 = piece"shipBay03"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipBay03
  ship03 = piece"ship03"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= ship03
  shipBay04 = piece"shipBay04"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipBay04
  ship04 = piece"ship04"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= ship04
  shipBay05 = piece"shipBay05"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipBay05
  ship05 = piece"ship05"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= ship05
  shipBay06 = piece"shipBay06"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipBay06
  swingCenter = piece"swingCenter"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= swingCenter
  shipbody01 = piece"shipbody01"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipbody01
  Prop21 = piece"Prop21"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop21
  Prop22 = piece"Prop22"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop22
  Prop23 = piece"Prop23"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop23
  Prop24 = piece"Prop24"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop24
  shipBay01 = piece"shipBay01"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipBay01
  shipbody = piece"shipbody"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= shipbody
  Prop11 = piece"Prop11"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop11
  Prop12 = piece"Prop12"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop12
  Prop13 = piece"Prop13"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop13
  Prop14 = piece"Prop14"
  piecesTable[#piecesTable+1]={}
  piecesTable[#piecesTable]= Prop14

function randDeg()
return math.random(-360,360)
end


teamID=Spring.GetGaiaTeamID()




function ElevatorScript()
Show(Elevator1)
Show(Elevator2)
speed=math.random(9.14,22)
boolElveator1GotJob=false
boolElveator2GotJob=false
	while true do
	if boolElveator1GotJob== false then
	factor=math.ceil(math.random(0,1)*420)
	factor=factor -(factor%25)
	Move(Elevator1,y_axis,factor,speed)
	boolElveator1GotJob=true
	end


	if boolElveator2GotJob== false then
	factor=math.ceil(math.random(0,1)*420)
	factor=factor -(factor%25)
	Move(Elevator2,y_axis,factor,speed)
	boolElveator2GotJob=true
	end


	rand=math.ceil(math.random(5000,22000))
	Sleep(rand)
		if math.random(0,3)==1 then
		 Move(Elevator1,y_axis,-50,speed) 
		 boolElveator2GotJob=true
		 end
			if math.random(0,5)==1 then 
			Move(Elevator2,y_axis,-50,speed) 
			boolElveator2GotJob=true
			end
	if  (false==Spring.UnitScript.IsInMove (Elevator2, y_axis)) then boolElveator2GotJob=false end
	if  (false==Spring.UnitScript.IsInMove (Elevator1, y_axis)) then boolElveator1GotJob=false end
	end

end

SIG_THRUST=2
thrust={}
for i=1,4,1 do
thrust[i]={}
name="thrust"..i
thrust[i]=piece(name)
end

function emitThrust()
SetSignalMask(SIG_THRUST)
	while(true) do
		for i=1,4,1 do
		EmitSfx(thrust[i],1025)
		end
		Sleep(50)


	end
end

function landAShip()
Signal(SIG_THRUST)
StartThread(emitThrust)
Turn(shipbody01,y_axis,math.rad(180),0)
rand=math.random(-3000,-1900)
Move(shipbody01,z_axis,rand,0)
Spin(shipbody01,y_axis,math.rad(2),0.1)
Move(shipbody01,y_axis,2000,0)
Turn(swingCenter,y_axis,math.rad(randDeg()),0)

Turn(swingCenter,y_axis,0,0.03)
Move(shipbody01,z_axis,0,35)
Move(shipbody01,y_axis,500,25)
WaitForMove(shipbody01,y_axis)
StopSpin(shipbody01,y_axis,0.03)
Turn(swingCenter,y_axis,0,0.09)
Turn(shipbody01,y_axis,math.rad(0),0.9)
Move(shipbody01,y_axis,100,20)
WaitForTurn(swingCenter,y_axis)
WaitForTurn(shipbody01,y_axis)
Move(shipbody01,y_axis,0,15)
WaitForMove(shipbody01,y_axis)
Signal(SIG_THRUST)
end

function hardReset()
Move(shipBay01,y_axis,0,0)
Move(shipBay02,y_axis,0,0)
Move(shipBay03,y_axis,0,0)
Move(shipBay04,y_axis,0,0)
Move(shipBay05,y_axis,0,0)
Move(shipBay06,y_axis,0,0)
Turn(Prop11,x_axis,math.rad(0),0)
Turn(Prop12,x_axis,math.rad(0),0)
Turn(Prop13,x_axis,math.rad(0),0)
Turn(Prop14,x_axis,math.rad(0),0)
Move(shipbody,z_axis,0,0)
Show(shipbody)
Show(Prop11)
Show(Prop12)
Show(Prop13)
Show(Prop14)

end
function floatingTower()
while true do
Move(Tower,y_axis,-10,1)
WaitForMove(Tower,y_axis)
Move(Tower,y_axis,10,1)
WaitForMove(Tower,y_axis)

Sleep(50)
end
end
function silentcleanup()

Hide(shipbody)
Hide(Prop11)
Hide(Prop12)
Hide(Prop13)
Hide(Prop14)
Move(shipBay01,y_axis,393,15)
Move(shipBay02,y_axis,-73,15)
Move(shipBay03,y_axis,-63,15)
Move(shipBay04,y_axis,-78,15)
Move(shipBay05,y_axis,-87,15)
Move(shipBay06,y_axis,-90,15)
WaitForMove(shipBay01,y_axis)
Turn(shipBay01,x_axis,math.rad(0),0.3)
Move(Tower,x_axis,0,22)
Move(Tower,z_axis,0,22)
WaitForTurn(shipBay01,x_axis)

hardReset()



end

function startAShip()
if math.random(0,1)==1 then Move(Tower,x_axis,-190,22) else  Move(Tower,z_axis,-190,22) end
Move(shipBay01,y_axis,-43,25)
Turn(shipBay01,x_axis,math.rad(90),0.1)
WaitForTurn(shipBay01,x_axis)
Turn(Prop11,x_axis,math.rad(-90),0.4)
Turn(Prop12,x_axis,math.rad(-90),0.4)
Turn(Prop13,x_axis,math.rad(-90),0.4)
Turn(Prop14,x_axis,math.rad(-90),0.4)
WaitForTurn(Prop14,x_axis)
	Show(FireSphere)
	Hide(FireSphere)
Move(shipbody,z_axis,-2200,780)
for i=1,800,5 do
EmitSfx(shipbody,1026)
EmitSfx(Prop11,1026)
EmitSfx(Prop12,1026)
Sleep(10)
end
WaitForMove(shipbody,z_axis)
silentcleanup()
end

function shipLanding()
Spin(FireSphere,y_axis,math.rad(280),0)
	while true do
	landAShip()
	Sleep(20000)
	startAShip()

	end

end


function script.Create()
Hide(FireSphere)

Turn(center,y_axis,math.rad(randDeg()),0)
StartThread(ElevatorScript)
StartThread(shipLanding)
StartThread(floatingTower)
	
	
end


function script.Killed(recentDamage,_)

xrand=math.random(-2,2)
yrand=math.random(-12,12)
zrand=math.random(-3,3)
Turn(center,x_axis,math.rad(xrand),0.02)
Turn(center,y_axis,math.rad(yrand),0.2)
Turn(center,z_axis,math.rad(zrand),0.02)
Move(center,y_axis,-180,11)
Timer=0
	while(true==Spring.UnitScript.IsInMove (center, y_axis)) do
	EmitSfx(center,1024)
	Sleep(120)
	Timer=Timer+1
			if Timer== 20 then
			Move(center,y_axis,-180,22)
			end
		if Timer== 28 then

		Move(center,y_axis,-180,44)
		end


	end
x,y,z=Spring.GetUnitPosition(unitID)
	if math.random(0,2)==1 then
	for i=1, 3,1 do
	Spring.CreateUnit("jresistancewarrior",x+25,y,z-25,0,teamID)
	end
end
suddenDeath(unitID,recentDamage)
return 0
end




