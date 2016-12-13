include "createCorpse.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


cars={}
for i=1,14,1 do
s="car0"..i
cars[#cars+1]=piece(s)
end
bike1=piece"bike1"
bike2=piece"bike2"
bike3=piece"bike3"
table.insert(cars,bike1)
table.insert(cars,bike2)
table.insert(cars,bike3)

Balls={}
for i=1,9,1 do
s="CBall0"..i
Balls[#Balls+1]=piece(s)
end


LKW=piece"LKW"


local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_MOVE=4
local SIG_THUMB=8

actualBalls={}
function builder()
actualBalls={}
	for i=1,table.getn(cars),1 do
	Hide(cars[i])
	end


	for i=1,table.getn(Balls),1 do
	Hide(Balls[i])
	end
	Hide(LKW)


dice=math.random(1,20)
	if dice >= 15 and dice < 19 then
	 Show(LKW)
			for i=1,4,1 do
			Show(Balls[i])
			actualBalls[#actualBalls+1]=Balls[i]
			end
		elseif dice== 14 then
		Show(cars[dice])

			elseif dice > 18 then
			Show(cars[math.floor(math.random(1,3))+14])
			Show(Balls[9])
			Show(Balls[8])
			actualBalls[#actualBalls+1]=Balls[8]
			actualBalls[#actualBalls+1]=Balls[9]
				else
				Show(cars[dice])
					for i=5,7,1 do
					Show(Balls[i])
					actualBalls[#actualBalls+1]=Balls[i]
					end



				end




end

function script.Create()
builder()
StartThread(rushHour)
--StartThread(changeOfCar)
end


function script.Killed()
local unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
Spring.SpawnCEG("330RLexplode",unitx,unity,unitz,0,1,0,50,0)
Explode(Balls[5], SFX.FIRE+ SFX.FALL)
Sleep(450)
Explode(Balls[2], SFX.FIRE)
createCorpseCUnitSmall(recentDamage)

end

--Spring.PlaySoundFile("sounds/cRes/cthoff.wav")
boolConstMove=false

--[[
function changeOfCar()
local spGetUnitPositon=Spring.GetUnitPosition
	while GG.SpawnPointTable == nil do
	Sleep(500)
	end

 farCastPointTable={}
 for i=1,GG.SpawnPointTable,1 do
  x,y,z=spGetUnitPositon(GG.SpawnPointTable[i].unitid)
	 if x then
	 farCastPointTable[#farCastPointTable+1]={x=x,z=z}  
	 end
 end
 
 spTable=nil
 
	while true do
	x,y,z=spGetUnitPositon(unitID)
		for i=1,#farCastPointTable,1 do
		x=x-farCastPointTable[i].x
		z=z-farCastPointTable[i].z
			if math.sqrt(x*x+z*z) < 25 then 
			
			builder() 
			end
		end
 
	Sleep(350)
	end
	
	
end

]]
function rushHour()
Time=math.ceil(math.random(90000,400000))
Sleep(Time)
local spGetUnitPositon=Spring.GetUnitBasePosition
xo,yo,zo=spGetUnitPositon(unitID)
	while true do

	x,y,z=spGetUnitPositon(unitID)
	Sleep(3900)
	hereIsTheSthring="sounds/gCar/honkIfYouAreHorny"
	wavYourArmsLikeYouJustDontCare=".ogg"
		if not((math.abs(x)-math.abs(xo)) > 15 or  (math.abs(z)-math.abs(zo)) > 15 ) then
		stringTanga=hereIsTheSthring..(math.floor(math.random(1,8)))
		stringTanga=stringTanga..wavYourArmsLikeYouJustDontCare
		makeSomeNoise=math.random(0.5,0.9)
		Spring.PlaySoundFile(stringTanga,makeSomeNoise)
		end


	x,y,z=xo,yo,zo

	end


end
	
	
function script.StartMoving()
	if actualBalls then
		for i=1,#actualBalls,1 do
		Spin(actualBalls[i],x_axis,math.rad(90),0.07)
		end

	end							

end

function script.StopMoving()
		if actualBalls then
		for i=1,#actualBalls,1 do
		StopSpin(actualBalls[i],x_axis,0.7)
		end

	end
end

			
		
		
