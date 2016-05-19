include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

include "lib_OS.lua"

local boolCloseCombat=false
local SIG_WALK = 1 --Signal for the walk animation thread
local SIG_AIM = 2 --Signal for the weapon aiming thread
local SIG_RESET = 4 --Signal for the weapon aiming thread
local SIG_IDLE = 8 --Signal for the weapon aiming thread
pieces={}
rotor= piece"rotor"
pieces[#pieces+1]={}
pieces[#pieces]=rotor

rotor2= piece"rotor2"
pieces[#pieces+1]={}
pieces[#pieces]=rotor

littleWulf= piece"littleWulf"
pieces[#pieces+1]={}
pieces[#pieces]=littleWulf


body= piece"body"
pieces[#pieces+1]={}
pieces[#pieces]=body

LegTable ={}
for i=1, 4 do
	LegTable[i]={}
end
Tail= piece"Tail"
pieces[#pieces+1]={}
pieces[#pieces]=Tail

bUpL= piece"bUpL"
pieces[#pieces+1]={}
pieces[#pieces]=bUpL




bfootL= piece"bfootL"
pieces[#pieces+1]={}
pieces[#pieces]=bfootL

bUpR= piece"bUpR"
pieces[#pieces+1]={}
pieces[#pieces]=bUpR

bfootR= piece"bfootR"
pieces[#pieces+1]={}
pieces[#pieces]=bfootR

--
fUpL= piece"fUpL"
pieces[#pieces+1]={}
pieces[#pieces]=fUpL

ffootL= piece"ffootL"
pieces[#pieces+1]={}
pieces[#pieces]=ffootL

fUpR= piece"fUpR"
pieces[#pieces+1]={}
pieces[#pieces]=fUpR

ffootR= piece"ffootR"
pieces[#pieces+1]={}
pieces[#pieces]=ffootR

LegTable[1].down= bfootL
LegTable[1].up= bUpL


LegTable[2].down= ffootL
LegTable[2].up= fUpL

LegTable[3].down= ffootR
LegTable[3].up=  fUpR

LegTable[4].down=bfootR
LegTable[4].up=  bUpR




Head= piece"Head"
pieces[#pieces+1]={}
pieces[#pieces]=Head

jaw= piece"jaw"
pieces[#pieces+1]={}
pieces[#pieces]=jaw

aimspot= piece"aimspot"
pieces[#pieces+1]={}
pieces[#pieces]=aimspot

---- i know the api.. its all in my Head... brb, have to see doctor freeman
--throws the unit grabbed by the elephant appendix


function legsDown()
	SetSignalMask(SIG_IDLE)
	reseT(pieces)
	
	while true do
	breathOS(body,1, 3, LegTable,4, 33, 3,iRand(12,22))
		Sleep(500)
		howl()
	end
	
end


function walk()
	Signal(SIG_IDLE)
	Turn(Tail,x_axis,math.rad(0),1)
	Move(body,y_axis,0,12)
	Move(body,z_axis,0,12)
	Move(body,x_axis,0,12)
	orgHeading= Spring.GetUnitHeading(unitID)
	newHeading= orgHeading
	SetSignalMask(SIG_WALK)
	
	Sleep(100)
	boolCloseCombat= false
	resetP(rotor,2)
	resetP(rotor2,3)
	
	Turn(fUpR,z_axis,math.rad(-16),1)
	Turn(bUpR,z_axis,math.rad(-16),1)
	Turn(fUpL,z_axis,math.rad(16),1)
	Turn(bUpL,z_axis,math.rad(16),1)
	time= 0
	while true do
		time = time +350
		factor= math.sin(time/3500)
		bodyfactor= 3*factor
		invBFac = bodyfactor *-1
		Turn(body,x_axis,math.rad(bodyfactor),0.25)
		
		Turn(body,y_axis,math.rad(-3),0.25)
		rand=math.random(-22,-16)
		Turn(fUpR,x_axis,math.rad(invBFac + rand),3.5)
		Turn(ffootR,x_axis,math.rad(-rand),3.5)
		Turn(bUpL,x_axis,math.rad(invBFac + rand),3.5)
		Turn(bfootL,x_axis,math.rad(-rand),3.5)
		rand=math.random(8,22)
		Turn(fUpL,x_axis,math.rad(invBFac + rand),3.5)
		Turn(ffootL,x_axis,math.rad(rand),3.5)
		Turn(bUpR,x_axis,math.rad(invBFac + rand),3.5)
		Turn(bfootR,x_axis,math.rad(rand),3.5)
		WaitForTurn(bfootR,x_axis)
		Sleep(350)
		Turn(body,y_axis,math.rad(0),0.25)
		rand=math.random(-22,-16)
		Turn(fUpL,x_axis,math.rad(invBFac + rand),3.5)
		Turn(ffootL,x_axis,math.rad(-rand),3.5)
		Turn(bUpR,x_axis,math.rad(invBFac + rand),3.5)
		Turn(bfootR,x_axis,math.rad(-rand),3.5)
		rand=math.random(8,22)
		Turn(fUpR,x_axis,math.rad(invBFac + rand),3.5)
		Turn(ffootR,x_axis,math.rad(rand),3.5)
		Turn(bUpL,x_axis,math.rad(invBFac + rand),3.5)
		Turn(bfootL,x_axis,math.rad(rand),3.5) 
		WaitForTurn(bfootR,x_axis)
		Sleep(350)
			newHeading= orgHeading
			orgHeading= Spring.GetUnitHeading(unitID)
			diff= math.abs(math.abs(newHeading)-math.abs(orgHeading))
			diff=diff/1000
			if newHeading - orgHeading < 5 then
				Turn(Tail,y_axis,math.rad(-1* diff*3),3)
				Turn(Head,y_axis,math.rad(diff*1),0.5)

			else
				Turn(Tail,y_axis,math.rad(diff*3),3)
				Turn(Head,y_axis,math.rad(diff*-1),0.5)
			end
			

		
	end
end


function script.StartMoving()
	
	Signal(SIG_WALK)
	StartThread(walk) 
	
end

function script.StopMoving()
	Turn(Tail,x_axis,math.rad(-25),1)
	Signal(SIG_WALK)
	StartThread(legsDown)
	
end
--------------------------------------------------------------------------

function script.Killed()
	Move(rotor,y_axis,math.rad(-25),39)
	Spin(rotor,y_axis,math.rad(42),17)
	for i=1, 5 do
		EmitSfx(body,1025)
		Sleep(250)
	end
	
end




function getReadyJump()
	oneInTwen=math.random(0,20)
	if oneInTwen ==10 then
		oneOrTwo=math.random(0,1)
		if oneOrTwo== 0 then
			Spring.PlaySoundFile("sounds/jhivehound/juniorwulf.wav")
		end
	end
	
	Move(body,y_axis,-3,17)
	Turn(bUpL,x_axis,math.rad(39),17)
	Turn(bUpR,x_axis,math.rad(39),17)
	Turn(bfootL,x_axis,math.rad(-39),17)
	Turn(bfootR,x_axis,math.rad(-39),17)
	Turn(fUpL,x_axis,math.rad(19),17)
	Turn(fUpR,x_axis,math.rad(19),17)
	Sleep(900)
end


-----------------------------------------WEAPON ONE ----------------------------
function script.AimFromWeapon1()
	return aimspot
end

function script.QueryWeapon1()
	return aimspot
end

function landing()
	
	Sleep(200)
	legsDown()
end


function script.AimWeapon1( Heading, pitch )
	
	SetSignalMask(SIG_AIM)
	if boolCloseCombat==false then
		Turn(body,y_axis,-Heading,12)
		WaitForTurn(body,y_axis)
		getReadyJump() 
		
		
		
		return true
	else return false
	end
	
end

function howl()
factor=8
Turn(littleWulf,x_axis,math.rad(-35),35/factor)
Turn(bUpR,x_axis,math.rad(49),49/factor)
Turn(bfootL,x_axis,math.rad(-56),65/factor)
Turn(bUpL,x_axis,math.rad(49),49/factor)
Turn(bfootR,x_axis,math.rad(-56),65/factor)
Turn(Tail,x_axis,math.rad(24),24)

Turn(fUpR,x_axis,math.rad(29),29/factor)
Turn(ffootL,x_axis,math.rad(43),43/factor)
Turn(fUpL,x_axis,math.rad(29),29/factor)
Turn(ffootR,x_axis,math.rad(43),43/factor)
WaitForTurns(ffootL,littleWulf,bUpR)

index=iRand(2,8)
for i=1, index do
Turn(jaw,x_axis,math.rad(17),12/factor)
val=math.random(-40,-30)
WTurn(Head,x_axis,math.rad(val),65)
Sleep(500)
Turn(jaw,x_axis,math.rad(0),12)
WTurn(Head,x_axis,math.rad(-15),5/factor)
Sleep(1200)

if iRand(i,5)==1 then
Spring.PlaySoundFile("sounds/jhivehound/juniorwulf.wav")
end

end
Sleep(1200)
reseT(pieces)

end

function inLimit(value,altVal,limit)
	if value < altVal-limit or value > altVal+limit then return false
else return true end
end

function HideMeWhileNotThere()
	x,y,z=Spring.GetUnitPosition(unitID)
	xt,yt,zt=Spring.GetUnitPosition(unitID)
	Spring.SetUnitNoDraw(unitID,true)
	
	Spring.SetUnitNoSelect(unitID,true)
	Spring.SetUnitBlocking(unitID, false, false,false)
	local inLimits = inLimit
	while(true==inLimits(xt,x,10) and true==inLimits(yt,y,10)and true==inLimits(zt,z,10)) do
		Sleep(100)
		xt,yt,zt=Spring.GetUnitPosition(unitID)
	end
	
	Spring.SetUnitNoDraw(unitID,false)
	Spring.SetUnitNoSelect(unitID,false)
	Spring.SetUnitBlocking(unitID, true, true,true)
	for i=1,15, 1 do
		EmitSfx(body, 1024)
		Sleep(15)
	end
	Sleep(500)
	landing()
end




function timeDelayedCloseCombatDeActivate()
	SetSignalMask(SIG_RESET)
	Sleep(3500)
	boolCloseCombat=false
end


function script.FireWeapon1()
	
	Signal(SIG_IDLE)
	StartThread(HideMeWhileNotThere)
	Turn(body,y_axis,0,0)
	EmitSfx(body, 1024)
	
	
end
-----------------------------------------WEAPON TWO ----------------------------


function script.AimFromWeapon2()
	return aimspot
end

function script.QueryWeapon2()
	return aimspot
end



function script.AimWeapon2( Heading, pitch )
	boolCloseCombat=true
	return true
end

boolOnlyOnce=false 
function closeCombatMotion()
	if boolOnlyOnce==false then
		boolOnlyOnce=true
		
		
		
		
		Turn(Tail,x_axis,math.rad(-25),19)
		StartThread(walk)
		Spin(littleWulf,y_axis,math.rad(3),3)
		while(boolCloseCombat==true) do
			Turn(rotor,y_axis,math.rad(90),3)
			Turn(body,y_axis,math.rad(90),3)
			
			Turn(Head,y_axis,math.rad(0),19)
			Turn(Head,z_axis,math.rad(0),19)
			Turn(jaw,x_axis,math.rad(36),32)
			WaitForTurn(jaw,x_axis)
			Turn(jaw,x_axis,math.rad(0),180)
			WaitForTurn(jaw,x_axis)
			Turn(Head,x_axis,math.rad(-15),19)
			Turn(Head,y_axis,math.rad(-22),19)
			Turn(Head,z_axis,math.rad(-34),19)
			WaitForTurn(Head,x_axis)
			WaitForTurn(rotor,y_axis)
			close=math.random(-12,12)
			Turn(Head,x_axis,math.rad(close),25)
			Turn(rotor,y_axis,math.rad(180),3)
			Turn(body,y_axis,math.rad(180),3)
			WaitForTurn(Head,x_axis)
			WaitForTurn(rotor,y_axis)
			
			Turn(Head,y_axis,math.rad(0),19)
			Turn(Head,z_axis,math.rad(0),19)
			Turn(jaw,x_axis,math.rad(36),32)
			WaitForTurn(jaw,x_axis)
			Turn(jaw,x_axis,math.rad(0),180)
			WaitForTurn(jaw,x_axis)
			Turn(Head,x_axis,math.rad(-15),19)
			Turn(Head,y_axis,math.rad(-22),19)
			Turn(Head,z_axis,math.rad(-34),19)
			Turn(rotor,y_axis,math.rad(359),3)
			Turn(body,y_axis,math.rad(359),3)
			WaitForTurn(Head,x_axis)
			WaitForTurn(rotor,y_axis)
			Turn(rotor,y_axis,math.rad(0),0)
			Turn(body,y_axis,math.rad(0),0)
			Turn(rotor2,y_axis,math.rad(-90),3)-- -
			Turn(body,y_axis,math.rad(90),3)
			close=math.random(-12,12)
			Turn(Head,x_axis,math.rad(close),25)
			Turn(Head,y_axis,math.rad(0),19)
			Turn(Head,z_axis,math.rad(0),19)
			Turn(jaw,x_axis,math.rad(36),32)
			WaitForTurn(jaw,x_axis)
			Turn(jaw,x_axis,math.rad(0),180)
			WaitForTurn(jaw,x_axis)
			Turn(Head,x_axis,math.rad(-15),19)
			Turn(Head,y_axis,math.rad(-22),19)
			Turn(Head,z_axis,math.rad(-34),19)
			WaitForTurn(Head,x_axis)
			WaitForTurn(rotor2,y_axis)
			close=math.random(-12,12)
			Turn(Head,x_axis,math.rad(close),25)
			Turn(rotor2,y_axis,math.rad(-180),3)
			Turn(body,y_axis,math.rad(179),3)
			WaitForTurn(Head,x_axis)
			WaitForTurn(rotor2,y_axis)
			Turn(Head,y_axis,math.rad(0),19)
			Turn(Head,z_axis,math.rad(0),19)
			Turn(jaw,x_axis,math.rad(36),32)
			WaitForTurn(jaw,x_axis)
			Turn(jaw,x_axis,math.rad(0),180)
			WaitForTurn(jaw,x_axis)
			Turn(Head,x_axis,math.rad(-15),19)
			Turn(Head,y_axis,math.rad(-22),19)
			Turn(Head,z_axis,math.rad(-34),19)
			Turn(rotor2,y_axis,math.rad(-359),3)
			Turn(body,y_axis,math.rad(359),3)
			WaitForTurn(Head,x_axis)
			WaitForTurn(rotor2,y_axis)
			Turn(rotor2,y_axis,math.rad(0),0)
			Turn(body,y_axis,math.rad(0),0)
		end
		
		StopSpin(rotor,y_axis)
		StopSpin(littleWulf,y_axis)
		StopSpin(rotor2,y_axis)
		Turn(littleWulf,y_axis,math.rad(0),0)
		Turn(rotor,x_axis,math.rad(0),0)
		Turn(rotor,y_axis,math.rad(0),0)
		Turn(rotor2,y_axis,math.rad(0),0)
		Turn(rotor2,x_axis,math.rad(0),0)
		Turn(body,y_axis,math.rad(0),0)
		Turn(body,x_axis,math.rad(0),0)
		legsDown()
		boolOnlyOnce=false
	else
	end
end
function script.FireWeapon2()
	Signal(SIG_IDLE)
	Signal(SIG_RESET)
	StartThread(timeDelayedCloseCombatDeActivate)
	StartThread(closeCombatMotion)
	
	-- dec=math.random(0,1)
	-- if dec==1 then
	-- Spring.PlaySoundFile("sounds/Headcrab/hc2.wav")
	-- else
	-- Spring.PlaySoundFile("sounds/Headcrab/hc6.wav")
	-- end
end

function script.Create()
	
	
	
end