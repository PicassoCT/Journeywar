--Script Victory Statue

local dustemit =piece"dustemit"
local cVS_warp06 =piece"cVS_warp06"
local cVS_warp05 =piece"cVS_warp05"
local cVS_warp04 =piece"cVS_warp04"
local cVS_warp03 =piece"cVS_warp03"
local cVS_warp02 =piece"cVS_warp02"
local cVS_warp01 =piece"cVS_warp01"
local cVS_warp =piece"cVS_warp"
local cVSrand1 =piece"cVSrand1"
local cVSrand2 =piece"cVSrand2"
local cVSrand3 =piece"cVSrand3"

local cVictorySt =piece"cVictorySt"

local sfxRand0 =piece"sfxRand0"
local sfxRand1 =piece"sfxRand1"
local sfxSmallRotator =piece"sfxSmallRotator"
local sfxRand2 =piece"sfxRand2"
local sfxRand3 =piece"sfxRand3"
local sfxRand4 =piece"sfxRand4"
local sfxRand5 =piece"sfxRand5"
local sfxRand6 =piece"sfxRand6"
local sfxRotate=piece"sfxRotate"
local SIG_FLICK=2
local SIG_BLITZ=4

local FiWoSpin=piece"FiWoSpin"
local FireWorks=piece"FireWorks"

function fireWorks(time)
Sleep(22000)

 
	
	while time > 0 do
	dx= math.random(-45,45)
	y=math.random(-360,360)
	Turn(FiWoSpin,y_axis,math.rad(y),0)
	Turn(FiWoSpin,x_axis,math.rad(dx),0)
	EmitSfx(FiWoSpin,1030)
	Sleep(400)
	x=math.random(1,12)
		dice=1026
		if math.random(0,1) ==1 then dice=1027 end
		if math.random(0,1)==1  then dice=1028 end
		if math.random(0,1)==1  then dice=1029 end
	boolRunIt=false
		if math.random(0,1)==1 then boolRunIt=true end
	
		for i=1,x,1 do
		
			if boolRunIt==true then 	
			t=y+(i*4)
			Turn(FiWoSpin,y_axis,math.rad(t),0) 
			end
			if boolRunIt==true and math.random(0,1)==1 then 
			t=dx-(i*4)
			Turn(FiWoSpin,x_axis,math.rad(t),0) 
			end
			
			if math.random(0,1)==1 then
			EmitSfx(FireWorks,dice)
			end
		
		end
		d=math.floor(math.random(250,700))
		Sleep(d)
		time=time-d
	end

end

function blitzlicht()
SetSignalMask(SIG_BLITZ)
while(true) do
EmitSfx(cVictorySt,1025)
Sleep(50)
end
end
--this is a test
function flicker()

SetSignalMask(SIG_FLICK)
while(true)do
dice=math.random(0,8)

if dice==0 then
	Show(sfxRotate)
end
	if dice==1 then
	Show(sfxRand0)
	EmitSfx(sfxRand0,1025)
	end
			if dice==2 then
				Show(sfxRand1)
				Show(sfxSmallRotator) 
				EmitSfx(sfxSmallRotator,1024)
				EmitSfx(sfxRand1,1025)
			end
					if dice==3 then
					Show(sfxRand2)
					EmitSfx(sfxRand2,1025)
					end
							if dice==4 then
							Show(sfxRand3)
							Show(sfxSmallRotator) 
							EmitSfx(sfxSmallRotator,1024)
							EmitSfx(sfxRand3,1025)
							end
									if dice==5 then
									Show(sfxRand4)
									Show(sfxRotate)
									EmitSfx(sfxRand4,1025)
									end
											if dice==6 then
											Show(sfxRand5)
											EmitSfx(sfxRand5,1025)
											end
													if dice==7 then
													Show(sfxRand6) 
													EmitSfx(sfxRand6,1025)
													Show(sfxSmallRotator)
													EmitSfx(sfxSmallRotator,1024) 
													end
													randomFlicker=math.random(490,1080)
													Sleep(randomFlicker)
														if dice%3==0 then
														Hide(sfxSmallRotator)
														Hide(sfxRotate)
														end

																if dice==8 then
																Hide(sfxRand0)
																Hide(sfxRand1)
																Hide(sfxRand2)
																Hide(sfxRand3)
																Hide(sfxRand4)
																Hide(sfxRand5)
																Hide(sfxRand6)
															
																end
end
end



function statueWarpIn()
StartThread(blitzlicht)
Spring.PlaySoundFile("sounds/cv/te.wav")
Sleep(2600)

----Spring.Echo("weee... warp in")
Spin(cVS_warp06, y_axis,math.rad(40),3)
Spin(cVS_warp05, y_axis,math.rad(40),3)
Spin(cVS_warp04, y_axis,math.rad(50),3)
Spin(cVS_warp03, y_axis,math.rad(60),3)
Spin(cVS_warp02,y_axis,math.rad(70),3)
Spin(cVS_warp01,y_axis,math.rad(80),3)
Spin(cVS_warp,y_axis,math.rad(90),3)

--MultiAxisSpin
Spin(sfxRand0,y_axis,math.rad(60),3)
Spin(sfxRand1,y_axis,math.rad(-75),3)
Spin(sfxSmallRotator,y_axis,math.rad(20),3)
Spin(sfxRand2,y_axis,math.rad(20),3)
Spin(sfxRand3,y_axis,math.rad(80),3)
Spin(sfxRand4,y_axis,math.rad(70),3)
Spin(sfxRand5,y_axis,math.rad(-45),3)
Spin(sfxRand6,y_axis,math.rad(-30),3)
Spin(sfxRotate,y_axis,math.rad(-50),3)

Spin(sfxRand0 ,x_axis,math.rad(5),3)
Spin(sfxRand1 ,z_axis,math.rad(5),3)
Spin(sfxSmallRotator ,x_axis,math.rad(5),3)
Spin(sfxRand2 ,x_axis,math.rad(5),3)
Spin(sfxRand3 ,x_axis,math.rad(5),3)
Spin(sfxRand4 ,z_axis,math.rad(5),3)
Spin(sfxRand5 ,x_axis,math.rad(5),3)
Spin(sfxRand6 ,x_axis,math.rad(5),3)
Spin(sfxRotate,z_axis,math.rad(5),3)
--Ready for the great Show
Sleep(600)
Show(sfxSmallRotator) 
EmitSfx(sfxSmallRotator,1024)

Sleep(1100)
Show(cVS_warp)
Sleep(1360)
		--
		randomizer=math.random(4,12)
		for i=0,randomizer,1 do
		kugelblitz=math.random(-3,3)
				if kugelblitz%3== 0 then
				Move(cVS_warp,y_axis,kugelblitz, randomizer)
				sleepy=kugelblitz*randomizer
				Sleep(sleepy)
				end
						if kugelblitz%2== 0 then
						Move(cVS_warp,x_axis,kugelblitz, randomizer)
						sleepy=kugelblitz*randomizer
						Sleep(sleepy)
						end
								if kugelblitz== 0 or kugeblitz== -1 or kugelblitz== 1 then
								Move(cVS_warp,z_axis,kugelblitz, randomizer)
								sleepy=kugelblitz*randomizer
								Sleep(sleepy)
								end

						
		end
		Move(cVS_warp,x_axis,0, 3)
		Move(cVS_warp,y_axis,0, 3)
		Move(cVS_warp,z_axis,0, 3)
		WaitForMove(cVS_warp,x_axis)
		WaitForMove(cVS_warp,y_axis)
		WaitForMove(cVS_warp,z_axis)
		
Hide (cVS_warp)
Show(cVS_warp01)
Sleep(1800)
StartThread(flicker)
Sleep(2048)
Signal(SIG_FLICK)
Hide(cVS_warp01)
Show(cVS_warp02)
StartThread(flicker)

		randomizer=math.random(2,6)
		for i=0,randomizer,1 do
		kugelblitz=math.random(-3,3)
				if kugelblitz%3== 0 then
				Move(cVS_warp02,y_axis,kugelblitz, randomizer)
				EmitSfx(cVS_warp02,1025)
				sleepy=kugelblitz*randomizer
				Sleep(sleepy)
				end
						if kugelblitz%2==0 then
						Move(cVS_warp02,x_axis,kugelblitz, randomizer)
						EmitSfx(cVS_warp02,1025)
						sleepy=kugelblitz*randomizer
						Sleep(sleepy)
						end
								if kugelblitz==0 or kugeblitz== -1 or kugelblitz== 1 then
								Move(cVS_warp02,z_axis,kugelblitz, randomizer)
								EmitSfx(cVS_warp02,1025)
								sleepy=kugelblitz*randomizer
								Sleep(sleepy)
								end

						
		end
		 
		Move(cVS_warp02,x_axis,0, 5)
		Move(cVS_warp02,y_axis,0, 5)
		Move(cVS_warp02,z_axis,0, 5)
		WaitForMove(cVS_warp02,x_axis)
		WaitForMove(cVS_warp02,y_axis)
		WaitForMove(cVS_warp02,z_axis)

Signal(SIG_FLICK)		
Hide(cVS_warp02)	
Show(cVS_warp03)
Sleep(2600)
StartThread(flicker)
	randomizer=math.random(2,6)
		for i=0,randomizer,1 do
		kugelblitz=math.random(-3,3)
				if kugelblitz%3== 0 then
				Move(cVS_warp03,y_axis,kugelblitz, randomizer)
				sleepy=kugelblitz*kugelblitz*randomizer
				Sleep(sleepy)
				end
						if kugelblitz%2== 0 then
						Move(cVS_warp03,x_axis,kugelblitz, randomizer)
						sleepy=kugelblitz*kugelblitz*randomizer
						Sleep(sleepy)
						end
								if kugelblitz==0 or kugeblitz== -1 or kugelblitz== 1 then
								Move(cVS_warp03,z_axis,kugelblitz, randomizer)
								sleepy=kugelblitz*kugelblitz*randomizer
								Sleep(sleepy)
								end
		end			
							
		Move(cVS_warp03,x_axis,0, 5)
		Move(cVS_warp03,y_axis,0, 5)
		Move(cVS_warp03,z_axis,0, 5)
		WaitForMove(cVS_warp03,x_axis)
		WaitForMove(cVS_warp03,y_axis)
		WaitForMove(cVS_warp03,z_axis)
Signal(SIG_FLICK)		 
Hide(cVS_warp03)
Show(cVS_warp04)
EmitSfx(cVS_warp04,1024)
StartThread(flicker)
degradeSleep=math.random(2000,2400)
remains=degradeSleep%1
degradeSleep=degradeSleep-remains

Sleep(degradeSleep)
Signal(SIG_FLICK)
Hide(cVS_warp04)
EmitSfx(cVS_warp04,1024)
Show(cVS_warp05)
 
degradeSleep=degradeSleep/2
remains=degradeSleep%1
degradeSleep=degradeSleep-remains
Sleep(degradeSleep)

StartThread(flicker)
Hide(cVS_warp05)
Show(cVS_warp06)
degradeSleep=degradeSleep/2
remains=degradeSleep%1
degradeSleep=degradeSleep-remains
Sleep(degradeSleep)
Signal(SIG_FLICK)
 

Explode(sfxRand0,SFX.SHATTER)
EmitSfx(sfxRand0,1025)
Explode(sfxRand1,SFX.SHATTER)
EmitSfx(sfxRand1,1025)
Explode(sfxSmallRotator,SFX.SHATTER)
Explode(sfxRand2,SFX.SHATTER)
EmitSfx(sfxRand2,1025)
Explode(sfxRand3,SFX.SHATTER)
EmitSfx(sfxRand3,1025)
Explode(sfxRand4,SFX.SHATTER)
EmitSfx(sfxRand4,1025)
Explode(sfxRand5,SFX.SHATTER)
EmitSfx(sfxRand5,1025)
Explode(sfxRand6,SFX.SHATTER)
EmitSfx(sfxRand6,1025)
Explode(sfxRotate, SFX.SHATTER)
Explode(cVS_warp06,SFX.SHATTER)
EmitSfx(cVS_warp06,1025)
Explode(cVS_warp05,SFX.SHATTER)
EmitSfx(cVS_warp05,1025)
Explode(cVS_warp04,SFX.SHATTER)
EmitSfx(cVS_warp04,1025)
Explode(cVS_warp03,SFX.SHATTER)
EmitSfx(cVS_warp03,1025)
Explode(cVS_warp02,SFX.SHATTER)
EmitSfx(cVS_warp02,1025)
Explode(cVS_warp01,SFX.SHATTER)
EmitSfx(cVS_warp01,1025)
Explode(cVS_warp,SFX.SHATTER)
Hide(sfxRand0)
Hide(sfxRand1)
Hide(sfxSmallRotator)
Hide(sfxRand2)
Hide(sfxRand3)
Hide(sfxRand4)
Hide(sfxRand5)
Hide(sfxRand6)
Hide(sfxRotate)
Hide(cVS_warp06)
Hide(cVS_warp05)
Hide(cVS_warp04)
Hide(cVS_warp03)
Hide(cVS_warp02)
Hide(cVS_warp01)
Hide(cVS_warp)
Show(cVictorySt)
i=math.random(0,2)
if i==0 then
end
		if i==1 then
		--Head and Crown
		Show(cVSrand1)
		Show(cVSrand2)
		end
if i==2 then
--swoard and crown
Show(cVSrand2)
Show(cVSrand3)
end

Move(cVictorySt,y_axis,-50,60)
WaitForMove(cVictorySt,y_axis)
Signal(SIG_BLITZ)
Move(cVictorySt,y_axis,-125,125)
WaitForMove(cVictorySt,y_axis)
Move(cVictorySt,y_axis,-325,170)
WaitForMove(cVictorySt,y_axis)
Move(cVictorySt,y_axis,-600,200)
WaitForMove(cVictorySt,y_axis)
ole=math.random(0,1)
if ole==1 then
Spring.PlaySoundFile("sounds/cv/cvictory.wav")
else
Spring.PlaySoundFile("sounds/cv/cvictory2.wav")
end
Move(cVictorySt,y_axis,-790,250)
WaitForMove(cVictorySt,y_axis)
for i=1,22, 1 do
EmitSfx(dustemit,1024)
Sleep(50)
end		
Turn(cVSrand2,x_axis,math.rad(-14),4)
WaitForTurn(cVSrand2,x_axis)						
Spin(cVSrand2,y_axis,math.rad(5),3)
end


function script.Create ()

Hide(FiWoSpin)
Hide(cVS_warp06)
Hide(cVS_warp05)
Hide(cVS_warp04)
Hide(cVS_warp03)
Hide(cVS_warp02)
Hide(cVS_warp01)
Hide(cVS_warp)

Hide(cVSrand1)
Hide(cVSrand2)
Hide(cVSrand3)

Hide(cVictorySt)

Hide(sfxRand0)
Hide(sfxRand1)
Hide(sfxSmallRotator)
Hide(sfxRand2)
Hide(sfxRand3)
Hide(sfxRand4)
Hide(sfxRand5)
Hide(sfxRand6)
Hide(sfxRotate)
StartThread(statueWarpIn)
StartThread(fireWorks,60000)
--StartThread(fireWorks,90000)


end


function script.Killed()

----Spring.Echo("weee... i die")
end