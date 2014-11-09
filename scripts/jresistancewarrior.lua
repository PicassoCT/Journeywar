--a walking animation using threads
--smoothly aiming the weapon, also using threads

local sleeper=1
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_IDLE=4
local SIG_COUNTER=8
local SIG_FIRE=16
local SIG_ROB=32
local leg_movespeed = 12
local leg_movedistance = 10

submg=piece"submg"
flare01=piece"flare01"
flare02=piece"flare02"
deathpivot=piece"deathpivot"
restorso=piece"restorso"
respelvis=piece"respelvis"

reslowlegl=piece"reslowlegl"
reslowlegr=piece"reslowlegr"
resuplegr=piece"ruplegr"
resuplegl=piece"ruplegl"


resarmupl=piece"resarmleft"
resarmupr=piece"resarmright"

propsTable={}
Kevlar1=piece"Kevlar1"
table.insert(propsTable,Kevlar1)
Kevlar2=piece"Kevlar2"
table.insert(propsTable,Kevlar2)
Kevlar3=piece"Kevlar3"
table.insert(propsTable,Kevlar3)
randprop1=piece"randprop1"
table.insert(propsTable,randprop1)
randprop2=piece"randprop2"
table.insert(propsTable,randprop2)
randprop3=piece"randprop3"
table.insert(propsTable,randprop3)
DecoRPG=piece"DecoRPG"
table.insert(propsTable,DecoRPG)
centero=piece"centero"
launchRPG= piece"launchRPG"
bulletTable={}
for i=1,8,1 do
bulletTable[i]={}
piecename="bullet0"..i
bulletTable[i]=piece(piecename)

end

headTable={}
for i=1,4,1 do
headTable[i]={}
piecename="reshead"..i
headTable[i]=piece(piecename)
end
function turnAndShow(value,nr)
Turn(centero,z_axis,math.rad(value-14),9)
Show(bulletTable[nr])
return value-14
end

function ammo()

Turn(centero,y_axis,math.rad(28),0)
value=turnAndShow(0,8)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,7)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,6)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,5)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,4)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,3)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,2)
WaitForTurn(centero,z_axis)
value=turnAndShow(value,1)
WaitForTurn(centero,z_axis)
Turn(centero,z_axis,math.rad(-95),9)
Move(centero,y_axis,-10.3,32)
WaitForMove(centero,y_axis)
for i=1,table.getn(bulletTable),1 do
Hide(bulletTable[i])
end
Move(centero,y_axis,0,0)
Turn(centero,y_axis,math.rad(0),0)
Turn(centero,z_axis,math.rad(0),0)
boolOnlyOnce=true
end

function script.Create()
Hide(submg)
Show(launchRPG)
for i=1,8,1 do
Hide(bulletTable[i])
end


modulator=math.random(1,3)
	for i=1,table.getn(propsTable),1 do
		if i%modulator==0 then
		Show(propsTable[i])
		else
		Hide(propsTable[i])
		end
	end
	
	for i=1,4,1 do
	Hide(headTable[i])
	end
s=math.random(1,4)
Show(headTable[s])
end

function idle()
Signal(SIG_IDLE)
sleeper=math.random(1024,8192)

SetSignalMask(SIG_IDLE)
	while(true)do
	Sleep(sleeper)

		aynRandValue=math.random(0,12)
			if aynRandValue== 8 then
			Move(respelvis,y_axis,-4,10)
			Turn(resuplegr,x_axis,math.rad(-90),18)
			Turn(reslowlegr,x_axis,math.rad(90),28)
			Turn(reslowlegl,x_axis,math.rad(101),28)

			end
					if aynRandValue== 3 then
					Move(respelvis,y_axis,-4,12)
					Turn(resuplegr,x_axis,math.rad(-90),18)
					Turn(reslowlegl,x_axis,math.rad(90),28)
					Turn(reslowlegr,x_axis,math.rad(101),28)
					end


	Turn(restorso,y_axis,math.rad(35),1)

	Turn(resarmupr,x_axis,math.rad(-24),3)
	Turn(resarmupl,x_axis,math.rad(-24),3)

	Turn(resarmupr,y_axis,math.rad(-10),3)
	Turn(resarmupl,y_axis,math.rad(-10),3)
	WaitForTurn(resarmupr,x_axis)
	WaitForTurn(restorso,y_axis)
	WaitForTurn(resarmupr,y_axis)
	Turn(restorso,y_axis,math.rad(-27),3)

	Turn(resarmupr,y_axis,math.rad(10),3)
	Turn(resarmupl,y_axis,math.rad(10),3)

	Turn(resarmupr,x_axis,math.rad(10),3)
	Turn(resarmupl,x_axis,math.rad(10),3)
	WaitForTurn(resarmupr,x_axis)
	WaitForTurn(restorso,y_axis)
	WaitForTurn(resarmupr,y_axis)
	WaitForTurn(resarmupl,y_axis)
	Sleep(512)
	Turn(restorso,y_axis,math.rad(0),3)
	Turn(resarmupr,x_axis,math.rad(0),3)
	Turn(resarmupl,x_axis,math.rad(0),3)
	Turn(resarmupr,y_axis,math.rad(0),3)
	Turn(resarmupl,y_axis,math.rad(0),3)
	Turn(restorso,y_axis,math.rad(0),3)
	Turn(resarmupr,y_axis,math.rad(0),3)
	Turn(resarmupl,y_axis,math.rad(0),3)
	Turn(resarmupr,x_axis,math.rad(0),3)
	Turn(resarmupl,x_axis,math.rad(0),3)
	WaitForTurn(resarmupr,x_axis)
	WaitForTurn(restorso,y_axis)
	WaitForTurn(resarmupr,y_axis)

	Move(respelvis,y_axis,0,12)
	Turn(resuplegr,x_axis,math.rad(0),18)
	Turn(resuplegr,x_axis,math.rad(0),18)
	Turn(reslowlegr,x_axis,math.rad(0),28)
	Turn(reslowlegl,x_axis,math.rad(0),28)
	Sleep(250)
	end


end
---WALKING---
local function walk()
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	Turn(restorso, x_axis, math.rad(22), 14)
	WaitForTurn(restorso,x_axis)
	
	oneInTwen=math.random(0,20)
			if oneInTwen ==10 then
			oneOrTwo=math.random(0,1)
				if oneOrTwo== 0 then
				Spring.PlaySoundFile("sounds/jresistance/resgogo.wav")
				
					elseif math.random(0,1)==1 then
					Spring.PlaySoundFile("sounds/jresistance/resonroad.wav")
					else
					Spring.PlaySoundFile("sounds/jresistance/resready.wav")
					
					end
				end
			
	
	while (true) do
		--left leg up, right leg down
		Turn(resuplegl, x_axis,math.rad(-16) ,9 )
		WaitForTurn (resuplegl, x_axis)
		
		Turn(reslowlegr,x_axis,math.rad(50), 18)
		Turn(resuplegr, x_axis, math.rad(9), leg_movespeed)
		WaitForTurn (resuplegr, x_axis)	
		WaitForTurn (reslowlegl,x_axis)
		
		Turn(resuplegr, x_axis,math.rad(-33) ,9 )
		Turn(reslowlegl, x_axis, math.rad(24), leg_movespeed)
		Turn(reslowlegr,x_axis,math.rad(50), 18)
		
		WaitForTurn (resuplegr, x_axis)
		WaitForTurn (reslowlegl,x_axis)
		WaitForTurn (reslowlegr, x_axis)
		
		Sleep (25)
		--left leg down, right leg up
		Turn(resuplegr, x_axis,math.rad(-16) ,9 )
		WaitForTurn (resuplegr, x_axis)
		Turn(reslowlegl,x_axis,math.rad(50), 18)
		Turn(resuplegl, x_axis, math.rad(12), leg_movespeed)

		WaitForTurn (reslowlegl, x_axis)	
		WaitForTurn (resuplegl, x_axis)	
		
		
		Turn(resuplegl, x_axis,math.rad(-33) ,9 )
		Turn(reslowlegr, x_axis, math.rad(25), leg_movespeed)
		Turn(reslowlegl,x_axis,math.rad(52), 18)
		
		WaitForTurn ( resuplegl , x_axis)
		WaitForTurn (reslowlegr,x_axis)
		WaitForTurn (reslowlegl, x_axis)
		Sleep (56)
	end
end

function counter()
SetSignalMask(SIG_COUNTER)
napTime=math.ceil(math.random(900,2800))
Sleep(napTime)
oneInThreeHundred=math.random(0,35)
if oneInThreeHundred == 5 then
Spring.PlaySoundFile("sounds/jresistance/resgogo.wav")
end


end



function script.StartMoving()



	Signal(SIG_IDLE)
	Move(respelvis,y_axis,0,12)
    Turn(restorso,y_axis,0,4)
	Signal(SIG_WALK)
	
	StartThread (walk)
	
	
	StartThread(counter)
end

function legs_down()
Turn(respelvis,y_axis,math.rad(0),4)
Turn(restorso,y_axis,math.rad(0),4)
Turn(resuplegl,x_axis,math.rad(0),4)
Turn(resuplegl,y_axis,math.rad(0),4)
Turn(resuplegl,z_axis,math.rad(0),4)
Turn(resuplegr,x_axis,math.rad(0),4)
Turn(resuplegr,y_axis,math.rad(0),4)
Turn(resuplegr,z_axis,math.rad(0),4)

Turn(reslowlegl,x_axis,math.rad(0),4)
Turn(reslowlegl,y_axis,math.rad(0),4)
Turn(reslowlegl,z_axis,math.rad(0),4)
Turn(reslowlegr,x_axis,math.rad(0),4)
Turn(reslowlegr,y_axis,math.rad(0),4)
Turn(reslowlegr,z_axis,math.rad(0),4)

end

function script.StopMoving()

		
		Signal(SIG_COUNTER)
		Turn(restorso, x_axis, math.rad(0), 14)
--    --Spring.Echo ("stopped walking!")
		Signal(SIG_WALK)
		Signal(SIG_ROB)
		legs_down()
		
		
end





---AIMING & SHOOTING---
function script.AimFromWeapon1() 
	return submg 
end

function script.QueryWeapon1() 
	return flare01
end

--must return true to allow the weapon to shot. return false denies the weapon from shooting
--can be used delay the shooting until a "turn turret" animation is completed
boolOnlyOnce=true
function script.AimWeapon1( heading, pitch )

	Signal(SIG_IDLE)
	if boolReloadedRpg==false then
	Show(submg)
	--make sure the aiming animation is only run once
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	
		
	
		
		Turn(respelvis, y_axis, heading, 3)
		Turn(resarmupr, x_axis, -pitch, 3)
		Turn(resarmupl, x_axis, -pitch, 3)
		--Math.Rad(70) ?
		--wait until the weapon is pointed in the right direction
		WaitForTurn (respelvis, y_axis)
		WaitForTurn (resarmupr, x_axis)
		

	return true
	else
	
	return false
	
	end
end

function playSubMGSound()
   di=math.random(1,6)
   soundname="sounds/jresistance/ressubmg"..di..".wav"
	Spring.PlaySoundFile(soundname,0.8)
	
	if di== 1 then
    Sleep(3000)
	elseif di== 2 then
	Sleep(1000)
	elseif di== 3 then 
	Sleep(2000) 
	elseif di==6 then
	Sleep(3400)
	else
	Sleep(800)
	end
	


boolPlaySound=false
end

local boolPlaySound=false
function script.FireWeapon1()
    if boolPlaySound ==false then
	boolPlaySound=true
	StartThread(playSubMGSound)
	end

	if boolOnlyOnce== true then
	boolOnlyOnce=false
	StartThread(ammo)
	end


end

--weapon2 
boolReloadedRpg=true
function reloader()
Sleep(500)
boolReloadedRpg=false
Show(submg)
Hide(launchRPG)
Sleep(32000)
Show(launchRPG)
Hide(submg)
boolReloadedRpg=true
end
---AIMING & SHOOTING---
function script.AimFromWeapon2() 
	return flare02 
end

function script.QueryWeapon2() 
	return flare02
end

--must return true to allow the weapon to shot. return false denies the weapon from shooting
--can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon2( heading, pitch )
	if boolReloadedRpg == true then
	Turn(respelvis,y_axis,heading,1.18)
	Turn(resarmupl,x_axis,-pitch,1.5)
	Turn(resarmupr,x_axis,-pitch,1.5)
	WaitForTurn(respelvis,y_axis)

	return true

	else 
	return false
	end

end


--called after the weapon has fired
function script.FireWeapon2()
 StartThread(reloader)


end

----death animation: fall over & explode
function script.Killed(recentDamage, maxHealth)
	Turn(resuplegl, x_axis,math.rad(-16) ,9 )
		WaitForTurn (resuplegl, x_axis)
		
		Turn(reslowlegr,x_axis,math.rad(50), 18)
		Turn(resuplegr, x_axis, math.rad(9), leg_movespeed)
		WaitForTurn (resuplegr, x_axis)	
		WaitForTurn (reslowlegl,x_axis)
		
		Turn(resuplegr, x_axis,math.rad(-33) ,9 )
		Turn(reslowlegl, x_axis, math.rad(24), leg_movespeed)
		Turn(reslowlegr,x_axis,math.rad(50), 18)
		
		WaitForTurn (resuplegr, x_axis)
		WaitForTurn (reslowlegl,x_axis)
		WaitForTurn (reslowlegr, x_axis)
		
		Sleep (25)
		--left leg down, right leg up
		Turn(resuplegr, x_axis,math.rad(-16) ,9 )
		WaitForTurn (resuplegr, x_axis)
		Turn(reslowlegl,x_axis,math.rad(50), 18)
		Turn(resuplegl, x_axis, math.rad(12), leg_movespeed)

		WaitForTurn (reslowlegl, x_axis)	
		WaitForTurn (resuplegl, x_axis)	
		
		
		Turn(resuplegl, x_axis,math.rad(-33) ,9 )
		Turn(reslowlegr, x_axis, math.rad(25), leg_movespeed)
		Turn(reslowlegl,x_axis,math.rad(52), 18)
		
		WaitForTurn ( resuplegl , x_axis)
		WaitForTurn (reslowlegr,x_axis)
		WaitForTurn (reslowlegl, x_axis)
		Sleep (56)
    
	Turn(deathpivot,x_axis,math.rad(-38),math.rad(375))
	EmitSfx(restorso, 1024)
	Sleep(10)
	EmitSfx(restorso, 1024)
	Turn(resarmupl,y_axis,math.rad(71),12)
	Turn(resarmupr,y_axis,math.rad(-114),19)
	Explode(submg, SFX.FALL+SFX.NO_HEATCLOUD)
	Hide(submg)
	
	
						Sleep(120)
						Turn(restorso,x_axis,math.rad(-14),math.rad(84))
						WaitForTurn(restorso,x_axis)
	Turn(resuplegr,x_axis,math.rad(0),15)
	Turn(resuplegr,x_axis,math.rad(0),15)
	WaitForTurn(resuplegr,x_axis)
	WaitForTurn(resuplegr,x_axis)
	Turn(resarmupr, x_axis, math.rad(-90), math.rad(85))
	Turn(deathpivot,x_axis,math.rad(-90),math.rad(125))
	for i=1,15, 1 do
	EmitSfx(headTable[2], 1024)
	EmitSfx(restorso, 1024)
	EmitSfx(restorso, 1024)
	EmitSfx(restorso, 1024)
	EmitSfx(respelvis, 1024)
	EmitSfx(DecoRPG, 1024)
	Sleep(50)
	end
	WaitForTurn(deathpivot,x_axis)
	Sleep (150)
	--Explode(resarmupr, SFX.FALL+SFX.NO_HEATCLOUD)


		return 1 
end
