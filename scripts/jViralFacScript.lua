include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


local piecesTable={}
center = piece"center"
piecesTable[#piecesTable+1]= center
P1 = piece"P1"
piecesTable[#piecesTable+1]= P1
SLIM6 = piece"SLIM6"
piecesTable[#piecesTable+1]= SLIM6
EMIT4 = piece"EMIT4"
piecesTable[#piecesTable+1]= EMIT4
ProdPod11 = piece"ProdPod11"
piecesTable[#piecesTable+1]= ProdPod11
ProdPod12 = piece"ProdPod12"
piecesTable[#piecesTable+1]= ProdPod12
ProdPod21 = piece"ProdPod21"
piecesTable[#piecesTable+1]= ProdPod21
ProdPod22 = piece"ProdPod22"
piecesTable[#piecesTable+1]= ProdPod22
ProdPod23 = piece"ProdPod23"
piecesTable[#piecesTable+1]= ProdPod23
ProdPod26 = piece"ProdPod26"
piecesTable[#piecesTable+1]= ProdPod26
ProdPod46 = piece"ProdPod46"
piecesTable[#piecesTable+1]= ProdPod46
ProdPod8 = piece"ProdPod8"
piecesTable[#piecesTable+1]= ProdPod8
DropEgg = piece"DropEgg"
piecesTable[#piecesTable+1]= DropEgg
P2 = piece"P2"
piecesTable[#piecesTable+1]= P2
SLIM7 = piece"SLIM7"
piecesTable[#piecesTable+1]= SLIM7
EMIT5 = piece"EMIT5"
piecesTable[#piecesTable+1]= EMIT5
EMIT6 = piece"EMIT6"
piecesTable[#piecesTable+1]= EMIT6
ProdPod14 = piece"ProdPod14"
piecesTable[#piecesTable+1]= ProdPod14
ProdPod37 = piece"ProdPod37"
piecesTable[#piecesTable+1]= ProdPod37
ProdPod38 = piece"ProdPod38"
piecesTable[#piecesTable+1]= ProdPod38
ProdPod39 = piece"ProdPod39"
piecesTable[#piecesTable+1]= ProdPod39
ProdPod45 = piece"ProdPod45"
piecesTable[#piecesTable+1]= ProdPod45
P4 = piece"P4"
piecesTable[#piecesTable+1]= P4
SLIM8 = piece"SLIM8"
piecesTable[#piecesTable+1]= SLIM8
ProdPod27 = piece"ProdPod27"
piecesTable[#piecesTable+1]= ProdPod27
ProdPod36 = piece"ProdPod36"
piecesTable[#piecesTable+1]= ProdPod36
ProdPod40 = piece"ProdPod40"
piecesTable[#piecesTable+1]= ProdPod40
ProdPod41 = piece"ProdPod41"
piecesTable[#piecesTable+1]= ProdPod41
ProdPod44 = piece"ProdPod44"
piecesTable[#piecesTable+1]= ProdPod44
P6 = piece"P6"
piecesTable[#piecesTable+1]= P6
SLIM9 = piece"SLIM9"
piecesTable[#piecesTable+1]= SLIM9
EMIT7 = piece"EMIT7"
piecesTable[#piecesTable+1]= EMIT7
ProdPod28 = piece"ProdPod28"
piecesTable[#piecesTable+1]= ProdPod28
ProdPod33 = piece"ProdPod33"
piecesTable[#piecesTable+1]= ProdPod33
ProdPod42 = piece"ProdPod42"
piecesTable[#piecesTable+1]= ProdPod42
ProdPod43 = piece"ProdPod43"
piecesTable[#piecesTable+1]= ProdPod43
P8 = piece"P8"
piecesTable[#piecesTable+1]= P8
SLIM10 = piece"SLIM10"
piecesTable[#piecesTable+1]= SLIM10
EMIT8 = piece"EMIT8"
piecesTable[#piecesTable+1]= EMIT8
ProdPod29 = piece"ProdPod29"
piecesTable[#piecesTable+1]= ProdPod29
ProdPod30 = piece"ProdPod30"
piecesTable[#piecesTable+1]= ProdPod30
P10 = piece"P10"
piecesTable[#piecesTable+1]= P10
SLIM11 = piece"SLIM11"
piecesTable[#piecesTable+1]= SLIM11
ProdPod31 = piece"ProdPod31"
piecesTable[#piecesTable+1]= ProdPod31
ProdPod32 = piece"ProdPod32"
piecesTable[#piecesTable+1]= ProdPod32
ProdPod34 = piece"ProdPod34"
piecesTable[#piecesTable+1]= ProdPod34
ProdPod35 = piece"ProdPod35"
piecesTable[#piecesTable+1]= ProdPod35
ProdPod47 = piece"ProdPod47"
piecesTable[#piecesTable+1]= ProdPod47
P3 = piece"P3"
piecesTable[#piecesTable+1]= P3
SLIM5 = piece"SLIM5"
piecesTable[#piecesTable+1]= SLIM5
EMIT3 = piece"EMIT3"
piecesTable[#piecesTable+1]= EMIT3
ProdPod10 = piece"ProdPod10"
piecesTable[#piecesTable+1]= ProdPod10
ProdPod13 = piece"ProdPod13"
piecesTable[#piecesTable+1]= ProdPod13
ProdPod20 = piece"ProdPod20"
piecesTable[#piecesTable+1]= ProdPod20
P5 = piece"P5"
piecesTable[#piecesTable+1]= P5
SLIM4 = piece"SLIM4"
piecesTable[#piecesTable+1]= SLIM4
ProdPod15 = piece"ProdPod15"
piecesTable[#piecesTable+1]= ProdPod15
ProdPod16 = piece"ProdPod16"
piecesTable[#piecesTable+1]= ProdPod16
ProdPod19 = piece"ProdPod19"
piecesTable[#piecesTable+1]= ProdPod19
ProdPod25 = piece"ProdPod25"
piecesTable[#piecesTable+1]= ProdPod25
ProdPod9 = piece"ProdPod9"
piecesTable[#piecesTable+1]= ProdPod9
P7 = piece"P7"
piecesTable[#piecesTable+1]= P7
SLIM3 = piece"SLIM3"
piecesTable[#piecesTable+1]= SLIM3
EMIT2 = piece"EMIT2"
piecesTable[#piecesTable+1]= EMIT2
ProdPod17 = piece"ProdPod17"
piecesTable[#piecesTable+1]= ProdPod17
ProdPod18 = piece"ProdPod18"
piecesTable[#piecesTable+1]= ProdPod18
ProdPod24 = piece"ProdPod24"
piecesTable[#piecesTable+1]= ProdPod24
ProdPod5 = piece"ProdPod5"
piecesTable[#piecesTable+1]= ProdPod5
P9 = piece"P9"
piecesTable[#piecesTable+1]= P9
SLIM2 = piece"SLIM2"
piecesTable[#piecesTable+1]= SLIM2
EMIT1 = piece"EMIT1"
piecesTable[#piecesTable+1]= EMIT1
ProdPod1 = piece"ProdPod1"
piecesTable[#piecesTable+1]= ProdPod1
ProdPod2 = piece"ProdPod2"
piecesTable[#piecesTable+1]= ProdPod2
P11 = piece"P11"
piecesTable[#piecesTable+1]= P11
SLIM1 = piece"SLIM1"
piecesTable[#piecesTable+1]= SLIM1
ProdPod3 = piece"ProdPod3"
piecesTable[#piecesTable+1]= ProdPod3
ProdPod4 = piece"ProdPod4"
piecesTable[#piecesTable+1]= ProdPod4
ProdPod6 = piece"ProdPod6"
piecesTable[#piecesTable+1]= ProdPod6
ProdPod7 = piece"ProdPod7"
piecesTable[#piecesTable+1]= ProdPod7

local ProdPods={}
for i=1, 47, 1 do
	temp="ProdPod"..i
	ProdPods[#ProdPods+1]= piece(temp)
end

EMITORS={}
for i=1, 8, 1 do
	temp="EMIT"..i
	EMITORS[#EMITORS+1]= piece(temp)
end
local chain={piece("P10"),piece("P8"),piece("P6"),piece("P4"),piece("P2"),piece("P1"),piece("P3"),piece("P5"),piece("P7"),piece("P9"),piece("P11")}
--1== -Pi*1.5 11= Pi*1.5

function translateInterVal(lue)
	if lue < 5 then
		return -0.942477*(6-lue)
	else
		return 0.942477*(lue-6)
	end
end

SIG_BUILD=2
SIG_WALK=4
Slime={}
for i=1, 11, 1 do
	temp="SLIM"..i
	Slime[#Slime+1]= piece(temp)
end

AdaptTable={}
for i=1, 11, 1 do
	temp="P"..i
	AdaptTable[#AdaptTable+1]={}
	AdaptTable[#AdaptTable][1]= 	piece(temp)
	temp="S"..i
	AdaptTable[#AdaptTable][2]= 	piece(temp)
	AdaptTable[#AdaptTable][3]= 	0
end

function script.Create()
	
	StartThread(wiggleProdPods)
	retractThe(0)
	for i=1,#EMITORS,1 do StopSpin(EMITORS[i],y_axis,0) end
	StartThread(adapt)
	StartThread(buildLoop)
	Turn(center,y_axis,math.rad(90),0)
end

function worm()
	local ltransVal=translateInterVal
	SetSignalMask(SIG_WALK)
	
	while true do
		for i=1,#chain, 1 do
			Turn(chain[i],y_axis,math.rad(-8*math.sin(ltransVal(i))),0.02)
		end
		WaitForTurn(chain[1],y_axis)
		WaitForTurn(chain[11],y_axis)
		for i=1,#chain, 1 do
			Turn(chain[i],y_axis,math.rad(-8*math.cos(ltransVal(i))),0.02)
		end
		WaitForTurn(chain[1],y_axis)
		WaitForTurn(chain[11],y_axis)
		Sleep(100)
	end
	
end


function wiggleProdPods()
	i=1
	local lProdPods=ProdPods
	while(true) do
		i=(i%#lProdPods)+1
		if math.random(0,1)==1 then 
			r,p,y=math.random(-12,12),math.random(-8,8),math.random(-12,12)
			speed=math.random(0.2,5)
			Turn(lProdPods[i],x_axis,math.rad(r),speed)
			Turn(lProdPods[i],y_axis,math.rad(p),speed)
			Turn(lProdPods[i],z_axis,math.rad(y),speed)
		else
			i=math.ceil(math.random(1,#lProdPods-1))
		end
		Sleep(50)
		
	end
	
end
local fVal={{M=-100,T=90},{M=-150,T=0},{M=-120,T=0},{M=-225,T=0},{M=-150,T=0},{M=-65,T=0},{M=-150,T=0},{M=-40,T=0}}

function unfoldThe(m)
	for i=1,#EMITORS,1 do
		Move(EMITORS[i],y_axis, 0,m)
		del=math.random(-10,10)
	Spin(EMITORS[i],y_axis, math.rad(del),m/20)	end
	
end

function retractThe(m)
	for i=1,#EMITORS,1 do
		Move(EMITORS[i],y_axis, fVal[i].M,m)
		if fVal[i].T then
			Turn(EMITORS[i],y_axis, fVal[i].T,m)
		end
		del=math.random(-10,10)
		Spin(EMITORS[i],y_axis, math.rad(del),m/20)
	end
end

function script.Killed(recentDamage,_)
	
	suddenDeathjBuildCorpse(unitID, recentDamage)
end

function script.StartMoving()
	Signal(SIG_WALK)
	StartThread(worm)
end

function script.StopMoving()
	Signal(SIG_WALK)		
	
end

--The funcy Part keeping the Worm close to the Ground
-----------------
local spGetGroundHeight=Spring.GetGroundHeight
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir

function HowHighIsTheTireMama(i,piecename)
	x,y,z,_,_,_=spGetUnitPiecePosDir(unitID,piecename)
	h=spGetGroundHeight(x,z)
	return y,h
end

function randomizeSlime(i)
	val=math.random(-22,22)
				if i<10 then
					Spin(Slime[i],y_axis,math.rad(val),0.001)
				else
					Spin(Slime[i],x_axis,math.rad(val),0.001)
				end
				if math.random(0,1)==1 then
					rx,ry,rz=math.random(-3,3),math.random(-3,3),math.random(-3,3)
					Move(Slime[i],x_axis,rx,0.0001)
					Move(Slime[i],y_axis,ry,0.0001)
					Move(Slime[i],z_axis,rz,0.0001)
				end
end


function adapt()
	local lHowHighIsTheTireMama=HowHighIsTheTireMama

	lal=math.random(-22,22)		
	Spin(Slime[1],y_axis,math.rad(lal),0.001)
	
	while true do
		for i=2,11,1 do
			--Meassuring
			y,h=lHowHighIsTheTireMama(i,AdaptTable[i][2])
			
			if randSign()== true then
				randomizeSlime(i)
			end
			
	
			boolAboveGround=false
			
			if i%2==0 then
				boolAboveGround = (h-y > 5)
			else
				boolAboveGround = (h-y < 5)
			end
				
				if boolAboveGround == true then 
					Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]-1),0.0125)
					AdaptTable[i][3]=AdaptTable[i][3]-1
				else
					Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]+1),0.025)
					AdaptTable[i][3]=AdaptTable[i][3]+1
				end			
			
			
		end
		Sleep(1050)
	end
end



-----------------
change=0

function buildLoop()
	while true do	
		if change>0 then
			if boolbuilding==true then
				change=0		
				unfoldThe(5)
				Sleep(600)
				for i=1,#EMITORS,1 do StopSpin(EMITORS[i],y_axis,0.001) end
				
			elseif boolbuilding==false then
				change=0
				retractThe(5)
				Sleep(600)
				for i=1,#EMITORS,1 do StopSpin(EMITORS[i],y_axis,0.001) end
			end
		end	
		Sleep(400)
		
	end
end


function building()
	SetSignalMask(SIG_BUILD)
	while(boolbuilding==true) do
		
		--expand Tentacles
		nano=math.floor(math.random(1,8))
		
		Sleep(125)
	end
	
end

function script.StopBuilding()
	
	boolbuilding=false
	change=change+1
	Signal(SIG_BUILD)
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)
	--Spring.PlaySoundFile("sounds/jroach/roachbuild2.wav") 
	boolbuilding=true
	change=change+1
	Signal(SIG_BUILD)
	StartThread(building)
	
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

local nano=1
function script.QueryNanoPiece()
	temp=EMITORS[nano]
	return temp
end