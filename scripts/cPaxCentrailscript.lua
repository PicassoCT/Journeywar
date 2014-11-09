
piecesTable={}
deathpivot = piece"deathpivot"

piecesTable[#piecesTable+1]= deathpivot
Body = piece"Body"

piecesTable[#piecesTable+1]= Body
AL = piece"AL"

piecesTable[#piecesTable+1]= AL
Weapon2 = piece"Weapon2"

piecesTable[#piecesTable+1]= Weapon2
podturret4 = piece"podturret4"

piecesTable[#piecesTable+1]= podturret4
Weapon4 = piece"Weapon4"

piecesTable[#piecesTable+1]= Weapon4
AUL = piece"AUL"

piecesTable[#piecesTable+1]= AUL
Shield2 = piece"Shield2"

piecesTable[#piecesTable+1]= Shield2
podturret3 = piece"podturret3"

piecesTable[#piecesTable+1]= podturret3
Weapon6 = piece"Weapon6"

piecesTable[#piecesTable+1]= Weapon6
AR = piece"AR"

piecesTable[#piecesTable+1]= AR
Weapon1 = piece"Weapon1"

piecesTable[#piecesTable+1]= Weapon1
podturret1 = piece"podturret1"

piecesTable[#piecesTable+1]= podturret1
Weapon3 = piece"Weapon3"

piecesTable[#piecesTable+1]= Weapon3
AUR = piece"AUR"

piecesTable[#piecesTable+1]= AUR
podturret0 = piece"podturret0"

piecesTable[#piecesTable+1]= podturret0
Weapon5 = piece"Weapon5"

piecesTable[#piecesTable+1]= Weapon5
Shield1 = piece"Shield1"

piecesTable[#piecesTable+1]= Shield1
Shield4 = piece"Shield4"

piecesTable[#piecesTable+1]= Shield4
Shield3 = piece"Shield3"

piecesTable[#piecesTable+1]= Shield3
Head = piece"Head"

piecesTable[#piecesTable+1]= Head
Core = piece"Core"

piecesTable[#piecesTable+1]= Core
LL = piece"LL"

piecesTable[#piecesTable+1]= LL
podturret5 = piece"podturret5"

piecesTable[#piecesTable+1]= podturret5
Weapon8 = piece"Weapon8"

piecesTable[#piecesTable+1]= Weapon8
Shield6 = piece"Shield6"

piecesTable[#piecesTable+1]= Shield6
LUL = piece"LUL"

piecesTable[#piecesTable+1]= LUL
SR4 = piece"SR4"

piecesTable[#piecesTable+1]= SR4
SR5 = piece"SR5"

piecesTable[#piecesTable+1]= SR5
SR6 = piece"SR6"

piecesTable[#piecesTable+1]= SR6
Shield8 = piece"Shield8"

piecesTable[#piecesTable+1]= Shield8
LR = piece"LR"

piecesTable[#piecesTable+1]= LR
Shield5 = piece"Shield5"

piecesTable[#piecesTable+1]= Shield5
podturret2 = piece"podturret2"

piecesTable[#piecesTable+1]= podturret2
Weapon7 = piece"Weapon7"

piecesTable[#piecesTable+1]= Weapon7
LUR = piece"LUR"

piecesTable[#piecesTable+1]= LUR
SR1 = piece"SR1"

piecesTable[#piecesTable+1]= SR1
SR2 = piece"SR2"

piecesTable[#piecesTable+1]= SR2
SR3 = piece"SR3"

piecesTable[#piecesTable+1]= SR3
Shield7	 = piece"Shield7"

piecesTable[#piecesTable+1]= Shield7	



include "suddenDeath.lua"
include "toolKit.lua"
function HitByWeapon ( x, z, weaponDefID, damage ) 
--Turn Shielding 
if boolBattle== false then StartThread(battleReseter) end
boolBattle=true
end

function battleReseter()
Sleep(3000)
boolBattle=false
end


function script.Create()
Spring.PlaySoundFile("sounds/cPaxCentrail/PaxCentrailSound.wav",1.0)
StartThread(move)
StartThread(underPressure)
end

local ListedPieces={Body,LR,LL,LUR,LUL}
function resetStance()
for i=1,#ListedPieces do
Turn(ListedPieces[i],x_axis,0,12)
Turn(ListedPieces[i],y_axis,0,12)
Turn(ListedPieces[i],z_axis,0,12)
end

end


function script.Killed(recentDamage,_)
    --the Centrail knows no mercy
	if Spring.ValidUnitID(hostageid) ==true then
	Spring.DestroyUnit(hostageid,true,false,unitID)
	end
fooward=1
--if math.random(false,true) then Spring.Echo("Math.random accepts false/true as true in cPaxCentrail/PaxCentrailSound") end 
if math.random(0,1)==1 then  fooward=-1 end
y_val=math.random(-46,46)

resetStance()
Turn(deathpivot,y_axis,math.rad(y_val),8.9)
Turn(deathpivot,x_axis,math.rad(57*fooward),1.9)
Turn(Body,x_axis,math.rad(-80),2.6)
Turn(AL,x_axis,math.rad(-51),1.7)
Turn(AUL,x_axis,math.rad(-35),1)
Turn(AR,x_axis,math.rad(-71),2)
Turn(AR,y_axis,math.rad(-166),5.5)
Turn(AR,z_axis,math.rad(-136),4.5)

Turn(AUR,x_axis,math.rad(-23),0.9)
Turn(AUR,y_axis,math.rad(-43),1.4)
Turn(AUR,z_axis,math.rad(22),0.7)

Turn(LL,x_axis,math.rad(28),1)
Turn(LUL,x_axis,math.rad(85),2.8)

Turn(LR,x_axis,math.rad(12),0.4)
Turn(LUR,x_axis,math.rad(79),2.6)
WaitForTurn(Body,x_axis)
Turn(deathpivot,x_axis,math.rad(87*fooward),20)
resetStance()
suddenDeathV(recentDamage)
return 0
end

boolMoving=false
function move()
	while true do
		if boolMoving==true then
		moveAnimation()
		else
		resetStance()
		idle()
		end
	Sleep(200)
	end

end


function hammerclawin(boolleft)
	if boolleft==true then
	Move(SR4,y_axis,-9,35)
	Move(SR5,y_axis,-9,35)
	Move(SR6,y_axis,-9,35)
	Move(SR4,z_axis,5,35)
	else               
	Move(SR1,y_axis,-9,35)
	Move(SR2,y_axis,-9,35)
	Move(SR3,y_axis,-9,35)
	Move(SR1,z_axis,5,35)
	end
end

function retractclaw(boolleft)
	if boolleft==true then
	Move(SR4,y_axis,0,15)
	Move(SR5,y_axis,0,15)
	Move(SR6,y_axis,0,15)
	Move(SR4,z_axis,0,15)
	else              
	Move(SR1,y_axis,0,15)
	Move(SR2,y_axis,0,15)
	Move(SR3,y_axis,0,15)
	Move(SR1,z_axis,0,15)
	end
end

gheading,gpitch=0,0

function turnTorso(xis,bodyt,uarml,arml,uarmr,armr,time, boolWaitForIt)
speed=math.min(bodyt,math.min(uarml,math.min(arml,math.min(uarmr,armr))))/time
speed=math.abs(speed)
 Turn(Body,xis,math.rad	(bodyt)	 ,bodyt*speed )
	if boolBattle==false then
	 Turn(AL,xis,math.rad	(uarml  ),uarml*speed )
	 Turn(AR,xis,math.rad	(uarmr  ),uarmr*speed )
	 Turn(AUL,xis,math.rad	(arml   ),arml *speed )
	 Turn(AUR,xis,math.rad	(armr   ),armr *speed )
	else
	 Turn(AL,y_axis,-gheading,2.5 )
	 Turn(AR,y_axis,-gheading,2.5 )
	 Turn(AUL,x_axis,pitch,5 )
	 Turn(AUR,x_axis,pitch,5 )
	
	end
	if boolWaitForIt then
	 WaitForTurn(Body,xis	)
	 WaitForTurn(AL,xis		)
	 WaitForTurn(AR,xis		)
	 WaitForTurn(AUL,xis	)
	 WaitForTurn(AUR,xis	)
	end
end

function turnLegs(xis, uplegl,lowlegl,uplegr, lowlegr,time, boolWaitForIt)
speed=math.max(math.abs(uplegl),math.max(math.abs(lowlegl),math.max(math.abs(uplegr),math.abs(lowlegr))))/time


 Turn(LL,xis,math.rad(uplegl ) ,(uplegl /time)*speed*25)
 Turn(LR,xis,math.rad(uplegr ) ,(uplegr /time)*speed*25)
 Turn(LUL,xis,math.rad(lowlegl),(lowlegl/time)*speed*25)
 Turn(LUR,xis,math.rad(lowlegr),(lowlegr/time)*speed*25)

	if boolWaitForIt then
	Sleep(time)
	end
end


function mturnTorso(axis,bodyt,uarml,arml,uarmr,armr,time, boolWaitForIt)
turnTorso(axis,bodyt,uarmr,armr,uarml,arml,time, boolWaitForIt)
end

function mturnLegs(axis, uplegl,lowlegl,uplegr, lowlegr,time, boolWaitForIt)
turnLegs(axis,uplegr, lowlegr,lowlegl,uplegr,time,boolWaitForIt)
end
--tur(axis,bodyt,uarml,uarmr,arml,armr,--[[]] uplegl,uplegr,lowlegl,lowlegr,speedt)
function moveAnimation()

hammerclawin(true)
retractclaw(false)

turnLegs(x_axis,-14,18,-30,23,1500,true)
Turn(Head,y_axis,math.rad(2),0.5)
Turn(deathpivot,y_axis,math.rad(-3),0.2)
--turnTorso(x_axis,10,-21,-13,8,-22,1500)
turnLegs(x_axis,-35,41,20, 0 ,1500,true)--
Turn(Head,y_axis,math.rad(7),0.5)
Turn(deathpivot,y_axis,math.rad(-8),0.2)
--turnTorso(x_axis,20,-37,-28,35,-60,1500)
turnLegs(x_axis,-30,23,23,35 ,1500,true)--
Turn(deathpivot,y_axis,math.rad(-5),0.2)
Turn(Head,y_axis,math.rad(12),0.5)
--turnTorso(x_axis,15,-47,-39,41,-41,1000)
turnLegs(x_axis,20, 0 ,-16,70,500,true)--
Turn(deathpivot,y_axis,math.rad(0),0.2)
Turn(Head,y_axis,math.rad(5),0.5)
--turnTorso(x_axis,10,0,-18,15,-31,3000)

turnLegs(x_axis,23,35 ,-14,18,1500,true)
--

turnLegs(x_axis,-16,70,-35,41,500,true)

--hammerclawin(true)
--retractclaw(false)
--
--mturnLegs(x_axis,-35,23,14,-24,1500)
--Sleep(1500)
--Turn(Head,y_axis,math.rad(2),0.5)
--Turn(deathpivot,y_axis,math.rad(-3),0.2)
----mturnTorso(x_axis,10,-21,-13,8,-22,1500)
--mturnLegs(x_axis,-13,0,-48,58,1500)
--Sleep(1500)
--
--Turn(Head,y_axis,math.rad(7),0.5)
--Turn(deathpivot,y_axis,math.rad(-8),0.2)
----mturnTorso(x_axis,20,-37,-28,35,-60,1500)
--mturnLegs(x_axis,-9,-16,-59,24,1500)
--Sleep(1500)
--
--Turn(deathpivot,y_axis,math.rad(-5),0.2)
--Turn(Head,y_axis,math.rad(12),0.5)
----mturnTorso(x_axis,15,-47,-39,41,-41,1000)
--mturnLegs(x_axis,0,-16,-47,25,1000)
--Sleep(1000)
--
--Turn(deathpivot,y_axis,math.rad(0),0.2)
--Turn(Head,y_axis,math.rad(5),0.5)
----mturnTorso(x_axis,10,0,-18,15,-31,3000)
--mturnLegs(x_axis,9,-16,-38,25,3000)
--Sleep(3000)
--
--mturnLegs(x_axis,0,0,0,0,3000)
--
StartThread(OhLawd)

end

boolBattle=false


TableOfSoundPathStrings={
			[1]={path="sounds/cPaxCentrail/ghospell1.ogg", time=2500},
			[2]={path="sounds/cPaxCentrail/ghospell2.ogg", time=3500},
			[3]={path="sounds/cPaxCentrail/ghospell3.ogg", time=3000},
			[4]={path="sounds/cPaxCentrail/ghospell4.ogg",time=2500},
			[5]={path="sounds/cPaxCentrail/ghospell5.ogg", time=2500},
			[5]={path="sounds/cPaxCentrail/ghospell6.ogg", time=4500},
	
}

 unitdefID=Spring.GetUnitDefID(unitID)
counter=1
function OhLawd()
tcounter=(counter%(#TableOfSoundPathStrings+1))+1
	if TableOfSoundPathStrings[tcounter] and TableOfSoundPathStrings[tcounter].path and TableOfSoundPathStrings[tcounter].time then
	success=PlaySoundByUnitType(unitdefID,TableOfSoundPathStrings[tcounter].path,1,TableOfSoundPathStrings[tcounter].time,1)
	end

if success==true then counter=tcounter end
end


numberTable={"one","two","three","four","five"}
function NotYetProperlyMotivated()

PlaySoundByUnitType(unitdefID,"sounds/cPaxCentrail/number.ogg",1,1000,1)
PlaySoundByUnitType(unitdefID,"sounds/cPaxCentrail/"..(numberTable[math.random(1,#numberTable)])..".ogg",1,1000,1)
PlaySoundByUnitType(unitdefID,"sounds/cPaxCentrail/motivation.ogg",1,14000,1)
end

function idle()
end

function script.StartMoving()
boolMoving=true
end

function delayedStop()
SetSignalMask(SIG_STOP)
Sleep(1000)
	if math.abs(Spring.GetUnitHeading(unitID)-startHeading)< 25 then
	boolMoving=false
	end
end

startHeading=0
local SIG_STOP=2
function script.StopMoving()
Signal(SIG_STOP)
startHeading=Spring.GetUnitHeading(unitID)
StartThread(delayedStop)		
		
end

hostageid=""
function underPressure()
while hostageid== "" do
Sleep(500)
end
boolUnderPressure=true
	while Spring.GetUnitIsDead(hostageid)==false do
	Sleep(1000)
	end

eid=Spring.GetUnitNearestEnemy(unitID)
	eteam=Spring.GetUnitTeam(eid)
	if eteam then
	Spring.TransferUnit(unitID,eteam,true)
	end	
end

boolUnderPressure=false
function script.Activate()
	if boolUnderPressure==false then

	x,y,z=Spring.GetUnitPosition(unitID)
	teamid=Spring.GetUnitTeam(unitID)
	hostageid=Spring.CreateUnit("choblock",x,y,z, 0, teamid) 
		if hostageid then
		
		end
	end
return 1
end

function script.Deactivate()

return 0
end

aimWeapFunc= function (Heading, pitch,nr)
if nr ~=7 then
					Turn(WeaponTable[nr].piece,y_axis,-Heading,1.8)
					Turn(WeaponTable[nr].piece,x_axis,pitch,1.8)
					WaitForTurn(WeaponTable[nr].piece,y_axis)
					WaitForTurn(WeaponTable[nr].piece,x_axis)
					return true
				else
				piecename=""

					if math.random(0,1)==1 then piecename= Weapon1 else piecename= Weapon2 end
					Turn(piecename,y_axis,-Heading,1.8)
					Turn(piecename,x_axis,pitch,1.8)
					WaitForTurn(piecename,y_axis)
					WaitForTurn(piecename,x_axis)
					return true
				end
end

 WeaponTable={
[1]={ 
	aimfromPiece=podturret0,
	piece=podturret0,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	},
[2]={
	aimfromPiece=podturret1,
	piece=podturret1,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	},
[3]={
	aimfromPiece=podturret2,
	piece=podturret2,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	},
[4]={
	aimfromPiece=podturret3,
	piece=podturret3,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	},
[5]={
	aimfromPiece=podturret4,
	piece=podturret4,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	},
[6]={
	aimfromPiece=podturret5,
	piece=podturret5,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	},
[7]={
	aimfromPiece=Head,
	piece=Head,
	aimweapon= aimWeapFunc,
	fireweapon=function() return true end
	}
}
--Weapon1

function script.AimFromWeapon1() 
	return WeaponTable[1].aimfromPiece 
end

function script.QueryWeapon1() 
	return WeaponTable[1].piece
end

function script.AimWeapon1( Heading ,pitch)	
gheading,gpitch=Heading,pitch
	return WeaponTable[1].aimweapon(Heading,pitch,1)
end
 

function script.FireWeapon1()	
	return WeaponTable[1].fireweapon()
end


function script.AimFromWeapon2() 
	return WeaponTable[2].aimfromPiece 
end

function script.QueryWeapon2() 
	return WeaponTable[2].piece
end

function script.AimWeapon2( Heading ,pitch)	
	return WeaponTable[2].aimweapon(Heading,pitch,2) and boolUnderPressure==true
end
 

function script.FireWeapon2()	
	return WeaponTable[2].fireweapon()
end


function script.AimFromWeapon3() 
	return WeaponTable[3].aimfromPiece 
end

function script.QueryWeapon3() 
	return WeaponTable[3].piece
end

function script.AimWeapon3( Heading ,pitch)	
	return WeaponTable[3].aimweapon(Heading,pitch,3)and boolUnderPressure==true
end
 

function script.FireWeapon3()	
	return WeaponTable[3].fireweapon()
end



function script.AimFromWeapon4() 
	return WeaponTable[4].aimfromPiece 
end

function script.QueryWeapon4() 
	return WeaponTable[4].piece
end

function script.AimWeapon4( Heading ,pitch)	
	return WeaponTable[4].aimweapon(Heading,pitch,4)and boolUnderPressure==true
end
 

function script.FireWeapon4()	
	return WeaponTable[4].fireweapon()
end


function script.AimFromWeapon5() 
	return WeaponTable[5].aimfromPiece 
end

function script.QueryWeapon5() 
	return WeaponTable[5].piece
end

function script.AimWeapon5( Heading ,pitch)	
	return WeaponTable[5].aimweapon(Heading,pitch,5)and boolUnderPressure==true
end
 

function script.FireWeapon5()	
	return WeaponTable[5].fireweapon()
end



function script.AimFromWeapon6() 
	return WeaponTable[6].aimfromPiece 
end

function script.QueryWeapon6() 
	return WeaponTable[6].piece
end

function script.AimWeapon6( Heading ,pitch)	
	return WeaponTable[6].aimweapon(Heading,pitch,6)and boolUnderPressure==true
end
 

function script.FireWeapon6()	
	return WeaponTable[6].fireweapon()
end


function script.AimFromWeapon7() 
	return WeaponTable[7].aimfromPiece 
end

function script.QueryWeapon7() 
	return WeaponTable[7].piece()
end

function script.AimWeapon7( Heading ,pitch)	
	return WeaponTable[7].aimweapon(Heading,pitch,7)and boolUnderPressure==true
end
 

function script.FireWeapon7()	
	return WeaponTable[7].fireweapon()
end


