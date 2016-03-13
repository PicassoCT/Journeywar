	include "suddenDeath.lua"
--	include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

	
	  SIG_AIM=2
	  SIG_WALK=4
	  SIG_TAKEAIM=8
	  SIG_GUARD=16
	  SIG_RESET=32
	  SIG_AIMWEAPON=64
	local pi=3.14159

inHibitorRange=700

local piecesTable={}

center = piece"center"
piecesTable[1]={}
piecesTable[1]= center
LightRefl10 = piece"LightRefl10"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl10
LightRefl1 = piece"LightRefl1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl1
LightRefl2 = piece"LightRefl2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl2
LightRefl3 = piece"LightRefl3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl3
LightRefl4 = piece"LightRefl4"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl4
LightRefl5 = piece"LightRefl5"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl5
LightRefl6 = piece"LightRefl6"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl6
LightRefl7 = piece"LightRefl7"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl7
LightRefl8 = piece"LightRefl8"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl8
LightRefl9 = piece"LightRefl9"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LightRefl9
ballsbebou = piece"ballsbebou"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= ballsbebou
field1 = piece"field1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= field1
field2 = piece"field2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= field2
heavymetal = piece"heavymetal"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= heavymetal
animCenter = piece"animCenter"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= animCenter
tigLil = piece"tigLil"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tigLil
tlarmr01 = piece"tlarmr01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tlarmr01
tllowll = piece"tllowll"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tllowll
tllegUpR = piece"tllegUpR"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tllegUpR
tllegLowR = piece"tllegLowR"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tllegLowR
tllegUpR01 = piece"tllegUpR01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tllegUpR01
tllegLowR0 = piece"tllegLowR0"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tllegLowR0
tlHead = piece"tlHead"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tlHead
tlarmr = piece"tlarmr"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tlarmr
tllowlr = piece"tllowlr"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= tllowlr
gun = piece"gun"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= gun
	
	armrotator=piece"armrotator"
	
	

function upLoop()
oldSpeed=math.random(3.141,19)
	while(true) do
	Turn(field1,y_axis,math.rad(180),0)
	if math.random(0,1)==1 then Turn(field2,y_axis,math.rad(180),0) end
	Move(ballsbebou,y_axis,8,oldSpeed)
	WaitForMove(ballsbebou,y_axis)
	Turn(field1,y_axis,math.rad(0),0)
	Turn(field2,y_axis,math.rad(0),0)
	newSpeed=math.random(3.141,19)
	Move(ballsbebou,y_axis,-3,(newSpeed+oldSpeed*2)/3)
	oldSpeed=newSpeed
	Sleep(30)
	WaitForMove(ballsbebou,y_axis)
	
	end
end


function sideLoop()
	speed=0.9

	while true do
	if math.random(0,1)==0 then	Turn(field1,z_axis,math.rad(180),0)end
	Move(ballsbebou,x_axis,0.9, speed)
	WaitForMove(ballsbebou,x_axis)
	speed=speed+math.random(0.1,0.3)
	Turn(field1,z_axis,math.rad(0),0)
	Move(ballsbebou,x_axis,-0.9, speed)
	WaitForMove(ballsbebou,x_axis)
	speed=speed-math.random(0.1,0.3)
	speed=math.abs(speed%2)+0.01
	
	end

end

	function takeAim(pitch)

	pitch=math.rad(360)-pitch
	----Spring.Echo(pitch)
	SetSignalMask(SIG_TAKEAIM)
    Turn(tigLil,y_axis,math.rad(18),0.028)
	Turn(tllegLowR0,x_axis,math.rad(11),3.141)
	Turn(tllegUpR01,x_axis,math.rad(-17),3.141)
	Turn(tllegUpR,x_axis,math.rad(10),3.141)
	Turn(tllegUpR,y_axis,math.rad(8),3.141)
	Turn(tllegUpR,z_axis,math.rad(-1.5),3.141)
	Turn(tlHead,z_axis,math.rad(14),4)
	Turn(tlHead,x_axis,pitch,4)
	Turn(armrotator,x_axis,-pitch,3.2)
	
	Turn(tlarmr01,x_axis,math.rad(0),1)
	Turn(tlarmr01,y_axis,math.rad(93),15)
	Turn(tlarmr01,z_axis,math.rad(0),38)

	Turn(tllowll,x_axis,math.rad(0),1)
	Turn(tllowll,y_axis,math.rad(5),13)
	Turn(tllowll,z_axis,math.rad(-6),3)
	
	Turn(tlarmr,x_axis,math.rad(6),1)
	Turn(tlarmr,y_axis,math.rad(-97),15)
	Turn(tlarmr,z_axis,math.rad(63),5)

	Turn(tllowlr,x_axis,math.rad(0),1)
	Turn(tllowlr,y_axis,math.rad(0),1)
	Turn(tllowlr,z_axis,math.rad(-96),8)
	
	
	Turn(gun,x_axis,math.rad(0),1)
	Turn(gun,y_axis,math.rad(-8),1)
	Turn(gun,z_axis,math.rad(31),8)
	
	
	WaitForTurn(armrotator,x_axis)
	end
	
	function script.AimWeapon1(heading ,pitch)   
	Signal(SIG_AIMWEAPON)
	Signal(SIG_GUARD)
	Signal(SIG_WALK)
	
	Move(gun,x_axis,math.rad(0),22)
	Move(gun,y_axis,math.rad(0),22)
	Move(gun,z_axis,math.rad(0),22)

	SetSignalMask(SIG_AIMWEAPON)
	if pitch > 48  then return false end
	boolGuardWalking=false
----Spring.Echo("CombinedFeatureScript_AIMWEAPON1")	
	
	Signal(SIG_TAKEAIM)
	
	    boolAiming=true
		
		Turn(tigLil,y_axis,heading)
		takeAim(pitch)
		WaitForTurn(tigLil,y_axis)
		Signal(SIG_RESET)
		StartThread(AimReseter)
		return true
		end
		   
		   
		   
function AimReseter()

SetSignalMask(SIG_RESET)
Sleep(6000)
boolAiming=false
end

	function script.AimFromWeapon1()
			
			return gun  
	end

	function script.QueryWeapon1()
			return gun
	end

	function script.FireWeapon1()


			return true
		   
		   
	end


function T(piecename,degx,speedx,degz,speedz,degz,speedz)
if degx~= nil then Turn(piecename,x_axis,math.rad(degx),speedx) end
if degz~= nil then Turn(piecename,z_axis,math.rad(degz),speedz) end
if degy~= nil then Turn(piecename,y_axis,math.rad(degy),speedy) end
end



boolLoaded=true

function reLoader()
Sleep(3000)
boolLoaded=true
end
	------------------------------------------------------------
	function script.AimWeapon2(heading,pitch)      
			
			return boolLoaded
		   

	end

	function script.AimFromWeapon2()
			return gun
	end

	function script.QueryWeapon2()
			return gun
	end

	function script.FireWeapon2()  
	boolLoaded=false
	StartThread(reLoader)
		Spring.PlaySoundFile("sounds/csniper/csniper.wav")  
	
			return true
	end
	
boolAiming=false
boolGuardWalking=false	
function setUp()
Turn(animCenter,y_axis,math.rad(141),0)
end

function reSume()
takeAim(-math.rad(15))
Turn(tigLil,y_axis,math.rad(0),3)

end
function legsDown()
	T(gun,0,3,0,3,0,3)
	Move(gun,y_axis,0,10)
	Move(gun,x_axis,0,10)


if math.random(0,1)==1 then
	Turn(tllegUpR,x_axis,math.rad(0),1.2)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(0),1.2)
	
	Turn(tllegLowR,x_axis,math.rad(0),1.3)
	Turn(tllegLowR,y_axis,math.rad(0),1.3)
	Turn(tllegLowR,z_axis,math.rad(0),1.2)

	Turn(tllegUpR01,x_axis,math.rad(0),1.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(0),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(0),1.2)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(0),1.2)
elseif math.random(0,1)==0 then
	Turn(tllegUpR,x_axis,math.rad(5),1.2)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(-12),1.2)
	
	Turn(tllegLowR,x_axis,math.rad(0),1.3)
	Turn(tllegLowR,y_axis,math.rad(0),1.3)
	Turn(tllegLowR,z_axis,math.rad(0),1.2)

	Turn(tllegUpR01,x_axis,math.rad(-7),1.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(8),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(0),1.2)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(0),1.2)

else
	Turn(tllegUpR,x_axis,math.rad(5),1.2)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(12),1.2)
	
	Turn(tllegLowR,x_axis,math.rad(0),1.3)
	Turn(tllegLowR,y_axis,math.rad(0),1.3)
	Turn(tllegLowR,z_axis,math.rad(0),1.2)

	Turn(tllegUpR01,x_axis,math.rad(-7),1.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(-8),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(0),1.2)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(0),1.2)





end

end
function walkAnimation(orgDegY)
SetSignalMask(SIG_WALK)


	while true do
	----Spring.Echo("combinedFeatureScript::1")
	--HeadBody
	Turn(tlHead,y_axis,math.rad(17),3)
	Turn(tlHead,z_axis,math.rad(-8),1.2)
	Turn(tigLil,x_axis,math.rad(1.4),1.2)
	Turn(tigLil,z_axis,math.rad(0.5),1)
	--Legs
	Turn(tigLil,y_axis,math.rad(orgDegY-3),0.5)
	Turn(tllegUpR,x_axis,math.rad(20),2.2)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(11),1.8)
	
	Turn(tllegLowR,x_axis,math.rad(-26),0.3)
	Turn(tllegLowR,y_axis,math.rad(-6),0.3)
	Turn(tllegLowR,z_axis,math.rad(0),1.2)

	Turn(tllegUpR01,x_axis,math.rad(-26),1.3)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(-6),0.3)
	
	Turn(tllegLowR0,x_axis,math.rad(-11),1.2)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(-14),1.2)

Sleep(220)
----Spring.Echo("combinedFeatureScript::2")
	--HeadBody
	Turn(tlHead,x_axis,math.rad(-19),1.2)
	Turn(tlHead,y_axis,math.rad(-3),1.2)
	Turn(tlHead,z_axis,math.rad(1),1.2)
	Turn(tigLil,x_axis,math.rad(1.4),0.3)
	Turn(tigLil,z_axis,math.rad(1.4),1.2)
	--Legs
	Turn(tigLil,y_axis,math.rad(orgDegY),0.5)
	Turn(tllegUpR,x_axis,math.rad(8),1.3)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(11),1.5)
	
	Turn(tllegLowR,x_axis,math.rad(-32),1.6)
	Turn(tllegLowR,y_axis,math.rad(0),1.2)
	Turn(tllegLowR,z_axis,math.rad(3),1.2)

	Turn(tllegUpR01,x_axis,math.rad(17),2.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(-2),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(-41),1.8)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(20),1.2)
Sleep(520)
----Spring.Echo("combinedFeatureScript::3")
	--HeadBody
	Turn(tigLil,y_axis,math.rad(orgDegY+1),0.5)
	Turn(tlHead,x_axis,math.rad(-7),1.2)
	Turn(tlHead,y_axis,math.rad(-19),2.2)
	Turn(tlHead,z_axis,math.rad(12),1.2)
	Turn(tigLil,x_axis,math.rad(0),0.3)
	Turn(tigLil,z_axis,math.rad(-1.4),1.2)
	--Legs
	Turn(tllegUpR,x_axis,math.rad(-4),1.2)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(3),1.2)
	
	Turn(tllegLowR,x_axis,math.rad(0),1.2)
	Turn(tllegLowR,y_axis,math.rad(0),1.2)
	Turn(tllegLowR,z_axis,math.rad(0),1.2)

	Turn(tllegUpR01,x_axis,math.rad(20),2.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(-11),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(-26),1.3)
	Turn(tllegLowR0,y_axis,math.rad(-6),1.3)
	Turn(tllegLowR0,z_axis,math.rad(0),1.2)
Sleep(320)

	--HeadBody
	Turn(tlHead,x_axis,math.rad(0),1.2)
	Turn(tlHead,y_axis,math.rad(0),1.2)
	Turn(tlHead,z_axis,math.rad(0),1.2)
	Turn(tigLil,x_axis,math.rad(-1.4),0.3)
	Turn(tigLil,z_axis,math.rad(0),1.2)
	--Legs
	Turn(tigLil,y_axis,math.rad(orgDegY+3),0.5)
	Turn(tllegUpR,x_axis,math.rad(-26),1.3)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(6),0.3)
	
	Turn(tllegLowR,x_axis,math.rad(-11),1.2)
	Turn(tllegLowR,y_axis,math.rad(0),1.2)
	Turn(tllegLowR,z_axis,math.rad(14),1.2)

	Turn(tllegUpR01,x_axis,math.rad(8),1.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(-11),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(-32),1.2)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(-3),1.2)
Sleep(350)
----Spring.Echo("combinedFeatureScript::4")
	--HeadBody
	Turn(tigLil,y_axis,math.rad(orgDegY-1),0.5)
	Turn(tlHead,x_axis,math.rad(-1),1.2)
	Turn(tlHead,y_axis,math.rad(0),1.2)
	Turn(tlHead,z_axis,math.rad(15),1.2)
	Turn(tigLil,x_axis,math.rad(0),0.3)
	Turn(tigLil,z_axis,math.rad(-2),1.2)
	--Legs
	Turn(tllegUpR,x_axis,math.rad(17),2.2)
	Turn(tllegUpR,y_axis,math.rad(0),1.2)
	Turn(tllegUpR,z_axis,math.rad(2),1.2)
	
	Turn(tllegLowR,x_axis,math.rad(-41),1.5)
	Turn(tllegLowR,y_axis,math.rad(0),1.2)
	Turn(tllegLowR,z_axis,math.rad(-20),1.2)

	Turn(tllegUpR01,x_axis,math.rad(-4),1.2)
	Turn(tllegUpR01,y_axis,math.rad(0),1.2)
	Turn(tllegUpR01,z_axis,math.rad(-3),1.2)
	
	Turn(tllegLowR0,x_axis,math.rad(0),1.2)
	Turn(tllegLowR0,y_axis,math.rad(0),1.2)
	Turn(tllegLowR0,z_axis,math.rad(0),1.2)

	Sleep(450)
	
	end

end



function idle(StringThing)

deci=math.random(1,4)
	if StringThing== "start" then
			if deci== 1 then
			--gunRiding 
					elseif deci==2 then
						--waitingPose
					T(armrotator,-30,3,0,3,0,3)
					T(tlarmr01,0,3,75,5,0,3)
					T(tllowll,0,3,35,3,0,3)
					T(tlarmr,0,3,-75,3,0,3)
					T(tllowlr,0,3,-35,3,0,3)
					T(gun,-2.7,3,-5.3,3,-116.8,3)
					Move(gun,y_axis,-5,3)
					Move(gun,x_axis,-2.4,3)

					Sleep(70000)
					end	
		else		
				if deci==3 then
					 --salto
					 T(tigLil,0,3,0,3,0,3)
					 WaitForTurn(tigLil,y_axis)
					 Move(tigLil,y_axis,-5,10)
					 T(tllegUpR,83,7,-12,3,0,5)
					 T(tllegLowR,-150,25,0,3,0,3)
					 T(tllegUpR01,75,5,0,3,0,3)
					 T(tllegLowR0,-115,11,0,3,0,3)
					 T(tlHead,-29,3,0,3,0,3)
					 T(armrotator,-36,6,0,3,0,3)
					 T(tlarmr01,0,3,76,5,0,3)
					 T(tllowll,0,3,21,4,0,3)
					 T(tlarmr,0,3,-71,9,-5,3)
					 WaitForMove(tigLil,y_axis)
					 Move(tigLil,z_axis,-32,6)
					 Move(tigLil,y_axis,22,17)
					 Sleep(450)
					 legsDown()
					 Spin(tigLil,x_axis,math.rad(-190),6)
					 Sleep(350)
					 T(tllegUpR,83,7,-12,3,0,5)
					 T(tllegLowR,-150,25,0,3,0,3)
					 T(tllegUpR01,75,5,0,3,0,3)
					 T(tllegLowR0,-115,11,0,3,0,3)
					 T(tlHead,-29,3,0,3,0,3)
					 T(armrotator,-36,6,0,3,0,3)
					 T(tlarmr01,0,3,76,5,0,3)
					 T(tllowll,0,3,21,4,0,3)
					 T(tlarmr,0,3,-71,9,-5,3)	
					 Sleep(800)
					 StopSpin(tigLil,x_axis)
					 Turn(tigLil,x_axis,math.rad(0),17)
					 WaitForMove(tigLil,y_axis)
					 Move(tigLil,y_axis,0,9)
					 Sleep(300)
					 Move(tigLil,y_axis,0,32)
				
					return true
							elseif deci==4 then
										 --Leaving the Post
										 

							end

					
	end				
end

function walkingTheGuard()
boolGuardWalking=true
SetSignalMask(SIG_GUARD)
	setUp()
	reSume()
	while true do
	--Reseting it
	Move(tigLil,y_axis,0,21)
	StartThread(walkAnimation,0)
		for i=1,56,1 do
		Move(tigLil,z_axis,-i,3.2)
		WaitForMove(tigLil,z_axis)
		end
	
	rand=math.ceil(math.random(600,19000))
	dx=-90
	if math.random(0,1)==1 then dx=math.abs(dx) end
	dx=dx+180

	Signal(SIG_WALK)
	Turn(tigLil,y_axis,math.rad(dx),19)
	legsDown()
	Sleep(rand)		

	Turn(tigLil,y_axis,math.rad(180),19)
	WaitForTurn(tigLil,y_axis)
	boolIDLE=idle("end")
	StartThread(walkAnimation,180)
	
	Move(tigLil,y_axis,0,21)
	
	if boolIDLE== nil or boolIDLE== false then
		for i=56,0,-1 do
		Move(tigLil,z_axis,-i,3.2)
		WaitForMove(tigLil,z_axis)
		end
	else
		for i=32,0,-1 do
		Move(tigLil,z_axis,-i,3.2)
		WaitForMove(tigLil,z_axis)
		end
	end
	
	Move(tigLil,z_axis,0,3.2)

	WaitForMove(tigLil,z_axis)
		Signal(SIG_WALK)
	rand=math.ceil(math.random(600,19000))
	legsDown()
	idle("start")
	legsDown()
	Sleep(rand)
	takeAim(-math.rad(28))
	Turn(tigLil,y_axis,math.rad(0),19)
	WaitForTurn(tigLil,y_axis)
	
	end


end	
	function guardOS()
	setUp()
		while true do
			if boolAiming==false and boolGuardWalking==false then
			Signal(SIG_GUARD)
			StartThread(walkingTheGuard)
			end

			if boolAiming==true then
		
				while boolAiming==true do
					boolGuardWalking=false
					Sleep(500)
				end
			end
		
		Sleep(250)
		end
		
	end

function shieldShine()
------Spring.Echo("shieldShine activated")
	while true do
		for i=1,10,1 do
	
		Move(piecesTable[i+1],x_axis,0.7,0.1)
		end
		
	--	----Spring.Echo("shieldShine activated2")
		Sleep(9000)
	WaitForMove(piecesTable[2],x_axis)
		
		for i=1,10,1 do
		

		Move(piecesTable[i+1],x_axis,0,0.2)
		end
		--	----Spring.Echo("shieldShine activated3")
	WaitForMove(piecesTable[2],x_axis)
	
	end

end
function killEgg(Did)
rand=math.ceil(math.random(1000,3500))
Sleep(rand)
	if Spring.GetUnitIsDead(Did)== false then
	Spring.DestroyUnit(Did,false,false)
	end
end

function KillEggLoop()
local inhibRange=inHibitorRange
local spGetUnitDefID=Spring.GetUnitDefID
	while true do
	Sleep(2000)
	ClarkTable={}
	ClarkTable=Spring.GetUnitsInCylinder(xPos,zPos,inhibRange)
	--Spring.Echo("combinedFeatureScript",table.getn(ClarkTable))
		if ClarkTable~= nil then
			for i=1,table.getn(ClarkTable), 1 do
			res=spGetUnitDefID(ClarkTable[i])
				if res ==UnitDefNames["jtigeggnogg"].id or res == UnitDefNames["jskineggnogg"].id then 	StartThread(killEgg,ClarkTable[i])	end
			end
		end
	end

end
xPos=0
zPos=0
function script.Create()
--generatepiecesTableAndArrayCode(unitID)
xPos,_,zPos=Spring.GetUnitPosition(unitID)
StartThread(guardOS)
StartThread(shieldShine)
StartThread(sideLoop)
StartThread(upLoop)
StartThread(KillEggLoop)
end


	--function is a testloop
	
	function script.Killed(recentDamage,_)
	

	 suddenDeathVM(recentDamage) 
 
 return 0
	end


	------------------------------------------------------------

	
		