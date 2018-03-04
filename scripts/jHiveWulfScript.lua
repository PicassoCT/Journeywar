include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_OS.lua"


RIP_DAMAGE= 350
RIP_TIME = 12000

local boolCommenceCloseCombat=false
local SIG_WALK = 1 --Signal for the walk animation thread
local SIG_AIM = 2 --Signal for the weapon aiming thread
local SIG_RESET = 4 --Signal for the weapon aiming thread
local SIG_IDLE = 8 --Signal for the weapon aiming thread
local SIG_DEACTIVATE_CLOSE_COMBAT = 16 --Signal for the weapon aiming thread
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
LegTable[3].up= fUpR

LegTable[4].down=bfootR
LegTable[4].up= bUpR




Head= piece"Head"
pieces[#pieces+1]={}
pieces[#pieces]=Head

jaw= piece"jaw"
pieces[#pieces+1]={}
pieces[#pieces]=jaw

aimspot= piece"aimspot"
pieces[#pieces+1]={}
pieces[#pieces]=aimspot

jumprotor = piece"jumprotor"
pieces[#pieces+1] = piece"jumprotor"

---- i know the api.. its all in my Head... brb, have to see doctor freeman
--throws the unit grabbed by the elephant appendix
function delayedEndWalk()
	Sleep(500)
	Signal(SIG_WALK)

end

function legsDown()
	
	SetSignalMask(SIG_IDLE)
	

	while true do
		breathOS(body,1, 3, LegTable,4, 25, 900,iRand(12,22))
		Sleep(500)
		howl()
	end
	
end


function walkAnimation()

	Turn(Tail,x_axis,math.rad(0),1)
	tP(body,0,0,0,12)
	mP(body,0,0,0,12)
	
	orgHeading= Spring.GetUnitHeading(unitID)
	newHeading= orgHeading
	SetSignalMask(SIG_WALK)
	
	Sleep(100)

	reset(rotor,2)
	reset(rotor2,3)
	
	Turn(fUpR,z_axis,math.rad(-16),1)
	Turn(bUpR,z_axis,math.rad(-16),1)
	Turn(fUpL,z_axis,math.rad(16),1)
	Turn(bUpL,z_axis,math.rad(16),1)
	Time= 0
	while true do
		Signal(SIG_IDLE)
		Time = Time +350
		factor= math.sin(Time/3500)
		bodyfactor= 3*factor
		invBFac = bodyfactor *-1
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

function delayedCloseCombatDeactivation()
SetSignalMask(SIG_DEACTIVATE_CLOSE_COMBAT)
	Sleep(1000)
	boolCommenceCloseCombat= false
end

function script.StartMoving()
	

	StartThread(walkAnimation) 
	StartThread(delayedCloseCombatDeactivation)
end

function script.StopMoving()
	Turn(Tail,x_axis,math.rad(-25),1)
	Signal(SIG_DEACTIVATE_CLOSE_COMBAT)
	StartThread(delayedEndWalk)
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



oldVictim= nil
biteVictim= nil
boolNewVictim = false
function takeABite(victim)
	if boolCommenceCloseCombat == false then
		oldVictim= biteVictim		
		biteVictim= victim
		boolNewVictim = true
	end
end
shakeSpot = piece"shakeSpot"

function detachOnDeath(victim)
	if not victim or Spring.GetUnitIsDead(victim)==true then
		Spring.UnitDetach(unitID)
		return true
		
	end
	return false
end

function setSpeedAttached(biteVictim)
		attachedT= Spring.GetUnitIsTransporting( biteVictim)
			numberOfAttached = 1
			if attachedT then numberOfAttached= #attachedT  end		
			setSpeedEnv(biteVictim,1/numberOfAttached)

end

function biteLoop()
	while true do
		
		if boolNewVictim == true then
			--find biggestPiece
			--Attach to Victim
			validExVictim= Spring.ValidUnitID(oldVictim)
			if validExVictim and validExVictim == true then Spring.UnitDetach(unitID); boolBiting= false end
			pieceBig = getUnitBiggestPiece(biteVictim)

			Spring.UnitAttach(biteVictim, unitID, pieceBig)
			setSpeedAttached(biteVictim)
			boolBiting= true
			--Shake Piece Out
			mP(shakeSpot,3.5, -11,-25, 55)
			
			dirAction= -1
			xDegree=0
			boolVictimIsDead=false
			boolFullTime= true
			
			Signal(SIG_WALK)
		
			startHP= Spring.GetUnitHealth(unitID)
			for i=1, RIP_TIME, 750 do
				tSyncIn(fUpR,-49, 0,0,250)
				tSyncIn(fUpL,-49, 0,0,250)	
				tSyncIn(bUpL,57, 0,0,250)
				tSyncIn(bfootL,58, 0,0,250)
				tSyncIn(bUpR,57, 0,0,250)
				tSyncIn(bfootR,57, 0,0,250)
				tSyncIn(shakeSpot,xDegree, -25*dirAction,0,math.random(250,600))
				tSyncIn(Tail,0, 25*dirAction,0,math.random(250,600))
				px,py,pz= Spring.GetUnitPiecePosDir(unitID,Tail)
				
				if isPieceAboveGround(unitID,Tail) == true then
					xDegree = clamp(xDegree -5, -90,90)
				else
					xDegree = clamp(xDegree +5, -90,90)
				end
				Spring.AddUnitDamage(biteVictim,math.ceil(RIP_DAMAGE/(RIP_TIME/750)))
				dirAction= dirAction*-1
				WaitForTurns(shakeSpot,Tail)
				nowHP= 	Spring.GetUnitHealth(unitID)
				if nowHP < startHP then 
					boolFullTime=false; break; end
				end
				boolVictimIsDead = detachOnDeath(biteVictim)
				
				if boolVictimIsDead == true then boolFullTime = false; break; end
			end
			reset(shakeSpot,25)
			boolBiting= false
			Spring.UnitDetach(unitID)
				
			if victimIsDead == false then
				setSpeedAttached(biteVictim)
			end
			
			--replace oneself with a jmeathivewulf
			--setParentInjmeathivewulf
			if boolFullTime== true then
				x,y,z = Spring.GetUnitPosition(unitID)
				teamID = Spring.GetUnitTeam(unitID)
				jhiveHoundMeatID = Spring.CreateUnit("jmeathivewulf",x,y,z, 0,teamID)
				if jhiveHoundMeatID then
					transferUnitStatusToUnit(unitID, jhiveHoundMeatID)
					setMeatHiveHoundParent(unitID, jhiveHoundMeatID)
					Spring.DestroyUnit(unitID, true, true)
				end
			end
			
			boolNewVictim = false
		end 
		Sleep(50)
	end
end

function setMeatHiveHoundParent(unitID, jhiveHoundMeatID)
myTeam=Spring.GetUnitTeam(unitID)
	for mom, data in pairs( GG.HiveHoundTable[myTeam]) do
		for i=1,#data do
			if type(data)=="table" and data[i][1] == unitID then
			GG.HiveHoundTable[myTeam][mom][i][1] = jhiveHoundMeatID
			end
		end

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
	resetT(pieces)
	
end

function inLimit(value,altVal,limit)
	if value < altVal-limit or value > altVal+limit then return false end
	return true 
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
	boolFlying=false
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

function landing()
	
	Sleep(200)
	resetT(pieces)
	
end


-----------------------------------------WEAPON ONE ----------------------------
function script.AimFromWeapon1()
	return Head
end

function script.QueryWeapon1()
	return Head
end


boolBiting = false
function script.AimWeapon1( Heading, pitch )

	if boolCloseCombatInProgress ==false and 
	boolBiting== false and
	boolFlying == false then
		Turn(body,y_axis,-Heading,12)
		WaitForTurn(body,y_axis)
		getReadyJump() 
		return true
	else 
		return false
	end
	
end


boolFlying=false
function script.FireWeapon1()
	boolFlying=true
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

	return  boolBiting == false
end

function biteMe()
	tSyncIn(jaw,36,0,0,100)		
	WaitForTurns(jaw)
	tSyncIn(jaw,0,0,0,50)
	WaitForTurns(jaw)
end

function timeDelayedCloseCombatDeActivate()
	SetSignalMask(SIG_RESET)
	Sleep(3500)
	boolCommenceCloseCombat=false
end

function jump()
speed= 0.3/90
Turn(jumprotor,x_axis,math.rad(90),14)
Turn(body,x_axis,math.rad(90),14)
Turn(Tail,x_axis,math.rad(-20),12)
end
function land()
Turn(jumprotor,x_axis,math.rad(0),25)
Turn(body,x_axis,math.rad(0),25)
Turn(Tail,x_axis,math.rad(20),12)

end

boolCloseCombatInProgress=false
function closeCombatMotion()
		boolCloseCombatInProgress= true
		resetAll(unitID)
		Turn(Tail,x_axis,math.rad(-25),19)
		StartThread(walkAnimation)
		Spin(littleWulf,y_axis,math.rad(3),3)
		crotor=rotor
		boolBody=true
		tSyncIn(body,0,180,0,250)	
		
		while(boolCommenceCloseCombat==true ) do
			echo("closeCombatMotion")
			
			Turn(crotor,y_axis,math.rad(0),0)
			
			if boolBody==true then	
			Turn(body,y_axis,math.rad(180),0)			
				crotor= rotor
				csign=-1
				boolBody=false
			else
			Turn(body,y_axis,math.rad(180),0)	
				crotor =rotor2
				csign= 1
				boolBody=true
			end
			WaitForTurns(crotor,body)
			Turn(Tail,y_axis,math.rad(-37*csign),12)
			tSyncIn(crotor,0,90*csign,0,150)
	
			tSyncIn(Head,-15,-22*csign,-34,150)
			WaitForTurns(crotor,body)
			
			closer=math.random(-12,12)
			tSyncIn(crotor,0,180*csign,0,150)
			tSyncIn(Head,closer,-22*csign,-34,150)
			WaitForTurns(crotor,body)

			tSyncIn(Head,closer,0,0,500)
			land()
			tSyncIn(crotor,0,270*csign,0,150)
			WaitForTurns(crotor,body,jumprotor)
			
			StartThread(biteMe)
			tSyncIn(Head,-15,-22*csign,-34,150)
			tSyncIn(crotor,0,360*csign,0,150)
			if maRa() == true then jump() end
			WaitForTurns(crotor,body)

			StartThread(biteMe)
			
		end
		
		Signal(SIG_WALK)
		StopSpin(littleWulf,y_axis)
		Turn(littleWulf,y_axis,math.rad(0),0)
		Turn(rotor,x_axis,math.rad(0),0)
		Turn(rotor,y_axis,math.rad(0),35)
		WTurn(rotor2,y_axis,math.rad(0),35)
		WTurn(body,y_axis,math.rad(0),35)
		WTurn(body,x_axis,math.rad(0),0)
		resetT(pieces)	
		
		boolCloseCombatInProgress= false
end

function script.FireWeapon2()
	Signal(SIG_IDLE)
	Signal(SIG_RESET)
	Signal(SIG_DEACTIVATE_CLOSE_COMBAT)
	boolCommenceCloseCombat=true
	StartThread(timeDelayedCloseCombatDeActivate)
	if boolCloseCombatInProgress == false then
		StartThread(closeCombatMotion)
	end

end


function script.Create()
	resetAll(unitID)
	Spring.UnitDetach(unitID)
	StartThread(biteLoop)
	--StartThread(biteTest)

end