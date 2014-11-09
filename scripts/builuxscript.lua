
include "suddenDeath.lua"
local builux = piece "builux"
local bldoor1  = piece  "bldoor1"
local bldoor2 = piece "bldoor2"
local blground= piece"blground"
local builuxcenter= piece "builuxcenter"
local SIG_Activate=2
local SIG_InActivate=4
local SIG_AC=8
boolUpgradeReady=true
upgradetime=math.floor(60000*math.random(6,9))
boolUpgradeTime=false

function upgraDDe()
Sleep(upgradetime)
boolUpgradeTime=true
while(boolUpgradeReady==false)do
StartThread(close)
Sleep(6000)
end
			   local x,y,z=Spring.GetUnitPosition (unitID)
			    GG.UnitsToSpawn:PushCreateUnit("mbuilux",x,y,z,0,teamID)
				Spring.DestroyUnit (unitID,false,true)

end

curtain={}
for i=1, 40, 1 do
curtain[i]={}
temp="Curtain"..i
curtain[i]=piece(temp)
end

function idle(negset,target)

target=target%35
SetSignalMask(SIG_IDLE)


for i=target,target+5, 1 do
Speeddiffy=(math.random(1,2))/(((i+1)*5)-target)
Turn(curtain[i],x_axis,math.rad(0),Speeddiffy)
end
WaitForTurn(curtain[target],x_axis)
randElay=math.random(350,650)
Sleep(randElay)


	while(true) do
		for i=target,target+5, 1 do
		Speeddiffy=(math.random(1,2))/(((i+1)*5)-target)
		val=math.random(-4.2,0.25)
		Turn(curtain[i],x_axis,math.rad(val*negset),Speeddiffy/10)
		end
	WaitForTurn(curtain[target],x_axis)
	Sleep(100)
	end

end

function windStoss(delaytime,StartVal, StrengthInDegree, StrenghtOfWind,length,negset)

SetSignalMask(SIG_WIND)
Sleep(delaytime)
boolFlipFlop=false
local pieight= 3.145159/8
local pifourth= 3.145159/4

--Tongue rolled
if math.random(0,1)==1 then
Turn(curtain[StartVal],x_axis,math.rad(35*negset),1.89)
WaitForTurn(curtain[StartVal],x_axis)
		for i=1, 4 do
		val=-60*negset
		Turn(curtain[StartVal+i],x_axis,math.rad(val),1.26)
		end
Turn(curtain[StartVal],x_axis,math.rad(90*negset),1.89)
WaitForTurn(curtain[StartVal],x_axis)
		for i=1, 4 do
		Turn(curtain[StartVal+i],x_axis,math.rad(0),2.26)
		if i%2==0 then 	Sleep(450) end
		end
end


for i=1,length,1 do
if boolFlipFlop== false then boolFlipFlop=true else boolFlipFlop=false end

MaxDegree=(math.random(85,110))


	if boolFlipFlop==true then
	Turn(curtain[StartVal],x_axis,math.rad(MaxDegree*negset-12),0.65)
		for i=1, 4 do
		val=(math.cos(i*pifourth)*-25*negset)
		Turn(curtain[StartVal+i],x_axis,math.rad(val),0.34)
		end
	else
	Turn(curtain[StartVal],x_axis,math.rad(MaxDegree*negset+12),0.85)
		for i=1, 4 do
		val=(math.sin(i*pifourth)*-25*negset)
		Turn(curtain[StartVal+i],x_axis,math.rad(val),0.57)
		end
	end
	
WaitForTurn(curtain[StartVal],x_axis)

end

Sleep(250) --Return down

		Turn(curtain[StartVal],x_axis,math.rad(20),0.85)	
		for i=1, 4 do
		val=(math.cos(i*pifourth)*-25*negset)
		Turn(curtain[StartVal+i],x_axis,math.rad(val),0.67)
		end
		WaitForTurn(curtain[StartVal],x_axis)
		
		Turn(curtain[StartVal],x_axis,math.rad(0),0.85)
		for i=1, 4 do
		Turn(curtain[StartVal+i],x_axis,math.rad(0),0.97)
		end
		WaitForTurn(curtain[StartVal],x_axis)
		
	
	while(true) do

		for i=StartVal,StartVal+4, 1 do
	Speeddiffy=(math.random(3,5))/(5-(i-StartVal))
	val=math.random(-1.2,0.25)
			Turn(curtain[i],x_axis,math.rad(val*negset),Speeddiffy/100)
		end
	WaitForTurn(curtain[StartVal],x_axis)
	Sleep(100)
	end
end

function windyS()
local lidle=idle
local lwindstoss=windStoss
	while(true) do
	Signal(SIG_IDLE)
	--windburst
	howLongRand=math.random(1,25)
	StarStrenght=35
	windStrenght=math.random(2,5)
	longusLonger=math.ceil(math.random(7,12))
		for i=1,table.getn(curtain)-4,5 do
		StarStrenght=(StarStrenght+math.random(-5,5)) %50
		delayDice=math.random(200,800)
			negset=-1
			if i < 20 or i>40 and i < 60  or i > 90 and i < 100 then
			negset=1
			end
	
		                    --(delaytime,StartVal, StrengthInDegree, StrenghtOfWind,length,negset)
		StartThread(lwindstoss,delayDice,i, StarStrenght, windStrenght,longusLonger,negset)
		end
    randOmTimes=math.ceil(math.random(13500,25600))
	Sleep(randOmTimes)
	Signal(SIG_WIND)
	--randomidletime
	for i=1,table.getn(curtain)-4,5 do
		
			negset=1
			if i < 20 or i>40 and i < 60  or i > 90 and i < 100 then
			negset=-1
			end
		StartThread(lidle,negset,i)
		end
	randSleep=math.random(12000,34000)
	Sleep(randSleep)

	end
end
  -- globalCityWideAlarm=0
--local boolAllreadyAlarmed=false 




function open()
boolUpgradeReady=false
	Spring.PlaySoundFile("sounds/cbuil/cbuilrise.wav")
	Signal(SIG_AC)
	boolAllreadyOpen=true
	Signal(SIG_InActivate)
	Signal(SIG_Activate)
    SetSignalMask(SIG_Activate)
	
	Turn(bldoor1,z_axis,math.rad(-15),0.5)
	Turn(bldoor2,z_axis,math.rad(-15),0.5)
	Sleep(50)
	WaitForTurn(bldoor1,z_axis)
	WaitForTurn(bldoor2,z_axis)
	Turn(bldoor1,z_axis,math.rad(0),1.5)
	Turn(bldoor2,z_axis,math.rad(0),1.5)
	Sleep(50)
	WaitForTurn(bldoor1,z_axis)
	WaitForTurn(bldoor2,z_axis)
	Move(bldoor1,y_axis,-52,1.55)
	Move(bldoor2,y_axis,-54,1.75)
	WaitForMove(bldoor2,y_axis)
	WaitForMove(bldoor1,y_axis)
	Move(builux,y_axis,0,1.5)
	WaitForMove(builux,y_axis)
	Hide(bldoor1)
	Hide(bldoor2)
	--while(globalCityWideAlarm==0) do
	while(true) do
	Sleep(4192)
	end
	
	--StartThread(alarmCheck)
end

teamID=Spring.GetUnitTeam(unitID)
statusOfOld=nil
function alarmCheck()
if GG.Alarm== nil then 
GG.Alarm={}
GG.Alarm[teamID]={}
GG.Alarm[teamID]=false
end

if GG.Alarm[teamID]==true then
statusOfOld=true
else 
statusOfOld=false
end
boolClosingTimes=false

	  
		while(true) do
				if GG.Alarm[teamID] == true and boolClosingTimes== false  and GG.Alarm[teamID] ~= statusOfOld then
				--case Alarm and building is still open
				boolClosingTimes=true
				statusOfOld=true
				Signal(SIG_Activate)
				Signal(SIG_InActivate)
				
				StartThread(close)
				end
				
					if GG.Alarm[teamID] == false and boolClosingTimes== true and boolUpgradeTime==true and GG.Alarm[teamID] ~= statusOfOld then
					--case no Alarm and building is still retracted
						statusOfOld=false
						Signal(SIG_Activate)
						Signal(SIG_InActivate)
						StartThread(open)				 
					end
					
				Sleep(4095)
					--nothing
					
				


	
		end
end



function close()
Spring.PlaySoundFile("sounds/cbuil/cbuilretr.wav")
	
	

	--Signal(SIG_AC)

    SetSignalMask(SIG_InActivate)
	
	Move(builux,y_axis,-84,1.5)
	WaitForMove(builux,y_axis)
	Show(bldoor1)
	Show(bldoor2)
	
	Move(bldoor1,y_axis,40,8)
	Move(bldoor2,y_axis,40,8)
	WaitForMove(bldoor2,y_axis)
	WaitForMove(bldoor1,y_axis)
	Move(bldoor1,y_axis,56,1.90)--i
	Move(bldoor2,y_axis,57,1.85)
 	Turn(bldoor1,z_axis,math.rad(-90),0.24)
	Turn(bldoor2,z_axis,math.rad(90),0.24)
	Spring.PlaySoundFile("sounds/cComon/cBunkerShut.wav")
	WaitForMove(bldoor2,y_axis)
	WaitForMove(bldoor1,y_axis)
	
	

	Sleep(50)

	
	
	WaitForTurn(bldoor1,z_axis)
	WaitForTurn(bldoor2,z_axis)
	--while(globalCityWideAlarm==1) do
	
		boolUpgradeReady=true 
	
	
	--StartThread(alarmCheck)
end


		function script.Create()
		--<buildanimationscript>
		x,y,z=Spring.GetUnitPosition(unitID)
		teamID=Spring.GetUnitTeam(unitID)
		Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)

		--</buildanimationscript>
		
--*		--Spring.Echo("Script, is executed..")
		fourFeather=math.random(0,3)
		if fourFeather==0 then
		Turn(builuxcenter,y_axis,math.rad(90),0)
		elseif fourFeather==1 then
		Turn(builuxcenter,y_axis,math.rad(180),0)
		elseif fourFeather==2 then
		Turn(builuxcenter,y_axis,math.rad(270),0)
		end
		
		Hide(bldoor2)
		Hide(bldoor2)
		StartThread(open)
		StartThread(upgraDDe)
		StartThread(alarmCheck)--
		StartThread(windyS)
		end


			function script.Killed(recentDamage,_)
			
			Explode(builux,SFX.SHATTER)
			Explode(bldoor1,SFX.FIRE)
			Explode(bldoor2,SFX.FIRE)
			suddenDeath(unitIDrecentDamage)
			return 0
			end



					function script.Activate()
						Signal(SIG_InActivate)
						Signal(SIG_Activate)
						StartThread(open)
						if GG.Alarm== nil then 
						GG.Alarm={}
						GG.Alarm[teamID]={}
						GG.Alarm[teamID]=false
						end
						GG.Alarm[teamID]=false
						
						
						
					--	StartThread(alarmCheck)
						return 1
					end

		function script.Deactivate()
				Signal(SIG_InActivate)
				Signal(SIG_Activate)
						if GG.Alarm== nil then 
						GG.Alarm={}
						GG.Alarm[teamID]={}
						end
						GG.Alarm[teamID]=true

			StartThread(close)
			--StartThread(alarmCheck)
			
				return 0
		end


--------BUILDING---------



