include "suddenDeath.lua"

 globalCityWideAlarm=0
local condepotre = piece"condepotre"
local condepotbu= piece "condepotbu"
local condepotb0= piece "condepotb0"
local condboltlo= piece "condboltlo"

local condbolt1= piece "condbolt1"
local condbolt2= piece "condbolt2"
local condbolt3= piece "condbolt3"
local condbolt4= piece "condbolt4"

local cdturningpoint= piece"cdturningpoint"

buildspottrain= piece"buildspottrain"

buildspotplan1 = piece "buildspotplane"
buildspotplane2 = piece "buildspotplane2"
buildspotplane3 = piece "buildspotplane3"
buildspotplane4 = piece "buildspotplane4"

buildspottruck1 = piece "buildspottruck"
buildspottruck2 = piece "buildspottruck2"
buildspottruck3 = piece "buildspottruck3"
buildspottruck4 = piece "buildspottruck4"

local condepotli = piece"condepotli"
local condepotl2 = piece"condepotl2"
local condepotl0 = piece"condepotl0"
local condepotl1 = piece"condepotl1"

local cdcontain0=piece"cdcontain0"
local cdcontaine=piece"cdcontaine"

local cdcontain1=piece"cdcontain1"
local cdcontain2=piece"cdcontain2"
local cdcontain3=piece"cdcontain3"
local cdcontain4=piece"cdcontain4"
local cdcontain5=piece"cdcontain5"
local cdcontain6=piece"cdcontain6"
local cdcontain7=piece"cdcontain7"
local cdcontain8=piece"cdcontain8"
local cdcontain9=piece"cdcontain9"
local boolRetracted=true
local boolBuildSpotFixxed=false
local unitDefID =  0
local boolIsBuilding=false
local currentBuildSpot=buildspottrain
local cdcrane = piece "cdcrane"
local SIG_BUILD=2
local buildID = nil
local  SIG_InActivate=4
local SIG_OPEN=8
local SIG_CLOSE=32
local SIG_IDLE=16
local SIG_RESET=64

local boolStateSet=true
local boolStable=true
      boolBuildEnder=true
	  
teamID=Spring.GetUnitTeam(unitID)

function script.Create()
--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)

GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)

--</buildanimationscript>

Hide(condepotli)
Hide(condepotl2 )
Hide(condepotl0)
Hide(condepotl1)
--Spring.Echo("GOTHISFAR")
StartThread(open)
StartThread(unitsIsBuilding)
StartThread(alarmCheck)
end

function script.QueryBuildInfo() 
  
	return currentBuildSpot

end


function script.QueryNanoPiece()
     return cdcrane
end

function building()
boolIsBuilding=true

--SetSignalMask(SIG_BUILD)
local spthemLights=themLights
while (boolIsBuilding==true) do
Sleep(150)
rand=math.random(0,1)
	themLights()
			if rand==1 then
			randspeed=math.random(2.5,3.5)
			Move(cdcrane,x_axis, 50, randspeed)
			WaitForMove(cdcrane,x_axis)
			end
	spthemLights()
				if rand==0 then
				randspeed=math.random(2.5,3.5)
				Move(cdcrane,x_axis, -50, randspeed)
				WaitForMove(cdcrane,x_axis)
				end

	spthemLights()


end
boolBuildSpotFixxed=false

end


function unitsIsBuilding()
--Spring.Echo("Script gets Executed")
local conAirDefID= UnitDefNames["conair"].id

local conTrainDefID= UnitDefNames["contrain"].id

local conTruckDefID= UnitDefNames["contruck"].id
local spGetUnitIsBuilding=Spring.GetUnitIsBuilding
local spGetUnitDefID= Spring.GetUnitDefID

		while(true) do
		Sleep(100)
				if boolIsBuilding ==false then
				boolBuildSpotFixxed=false
				end
		
				if boolIsBuilding == true and boolBuildSpotFixxed == false then
				Sleep(10)
				buildID=spGetUnitIsBuilding(unitID)
				Sleep(10)
							while(buildID == nil) do
							Sleep(100)
							buildID=spGetUnitIsBuilding(unitID)
							end

				unitDefID=spGetUnitDefID(buildID)				
						
						
				
         while (unitDefID ~= nil and buildID ~= nil and boolBuildSpotFixxed == false) do 
					if unitDefID == conTrainDefID then 
					boolBuildSpotFixxed=true
					currentBuildSpot= buildspottrain
					
									elseif  unitDefID == conAirDefID then 
									vierGewinnt=math.random(0,3)
										if vierGewinnt== 0 then
												boolBuildSpotFixxed=true
												currentBuildSpot= buildspotplane1	
												elseif vierGewinnt== 1 then
												boolBuildSpotFixxed=true
														currentBuildSpot=  buildspotplane2
														elseif vierGewinnt== 2 then
														boolBuildSpotFixxed=true
																currentBuildSpot= buildspotplane3
																elseif vierGewinnt== 3 then
																	boolBuildSpotFixxed=true
																	currentBuildSpot=  buildspotplane4
																	end	
										


										elseif  unitDefID == conTruckDefID then
										vierGewinnt=math.random(0,3)


											if vierGewinnt == 0 then
												boolBuildSpotFixxed=true
													currentBuildSpot= buildspottruck1	
											elseif vierGewinnt == 1 then
												boolBuildSpotFixxed=true
												currentBuildSpot= buildspottruck2	
											elseif vierGewinnt== 2 then
														boolBuildSpotFixxed=true
														currentBuildSpot=  buildspottruck3	
														elseif vierGewinnt== 3 then
															boolBuildSpotFixxed=true
															currentBuildSpot=  buildspottruck4	
															end	

											else
											boolBuildSpotFixxed=false
											Sleep(50)
											--Spring.Echo("BuildSpotUnfixxed")
											end	
		end





				Sleep(300)
				end
		
		end
end




function script.Killed(recentDamage,_)


Move(condepotre,y_axis,-11,22)
Turn(condepotre,x_axis,math.rad(5),0.5)
Turn(condepotre,z_axis,math.rad(-5),0.5)
WaitForMove(condepotre,y_axis)
WaitForTurn(condepotre,x_axis)
WaitForTurn(condepotre,z_axis)
Move(cdcontaine,z_axis,19,17)
Turn(cdcontaine,x_axis,math.rad(25),9)
Turn(cdcontaine,y_axis,math.rad(-15),6)
Sleep(125)
Explode(cdcontaine, SFX.NONE + SFX.FALL)
Explode(cdcontain0,  SFX.NONE +SFX.FALL)
Explode(cdcontain1,  SFX.NONE +SFX.FALL)
Explode(cdcontain2, SFX.NONE + SFX.FALL)

Explode(cdcontain3,  SFX.FALL)
Explode(cdcontain4, SFX.FALL+ SFX.EXPLODE_ON_HIT)

Explode(cdcontain9,  SFX.FALL+ SFX.EXPLODE_ON_HIT)
Hide(cdcontain0)
Hide(cdcontain1)
Hide(cdcontain2)
Hide(cdcontain3)
Hide(cdcontain4)

Hide(cdcontain9)
Move(cdcrane,x_axis,24,8)

Move(cdcrane,x_axis,58,32)
WaitForMove(cdcrane,x_axis)
Sleep(150)
--ReturnToFix
Turn(cdturningpoint,x_axis,math.rad(5),0.8)
Turn(cdturningpoint,y_axis,math.rad(8),1.2)
Turn(cdturningpoint,z_axis,math.rad(-25),1)
WaitForTurn(cdturningpoint,x_axis)
WaitForTurn(cdturningpoint,y_axis)
WaitForTurn(cdturningpoint,z_axis)
Turn(cdturningpoint,z_axis,math.rad(-45),1.5)
WaitForTurn(cdturningpoint,z_axis)
Turn(cdturningpoint,z_axis,math.rad(-55),2)
WaitForTurn(cdturningpoint,z_axis)
Explode(cdcrane,SFX.NONE +SFX.FALL)
Hide(cdcrane)
Turn(condepotre,x_axis,math.rad(25),3.25)

--
Explode( buildspottrain, SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 

Explode( buildspotplane2 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 
Explode( buildspotplane3 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 
Explode( buildspotplane4 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 
Explode( buildspottruck1 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 
Explode( buildspottruck2 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 
Explode( buildspottruck3 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT) 
Explode( buildspottruck4 , SFX.FIRE + SFX.FALL + SFX.EXPLODE_ON_HIT)

Move(cdcontain5,z_axis,15,3)
Move(cdcontain8,z_axis,25,3)
Turn(cdcontain5,x_axis,math.rad(60),16)
Turn(cdcontain5,y_axis,math.rad(15),6)
Turn(cdcontain8,z_axis,math.rad(-27),12)
Turn(cdcontain8,x_axis,math.rad(-1),12)
Turn(cdcontain8,y_axis,math.rad(-19),12)

Sleep(122)
Move(cdcontain8,z_axis,45,3)
Move(cdcontain8,y_axis,-10,6)
Move(cdcontain5,z_axis,30,9)
Turn(cdcontain5,x_axis,math.rad(132),48)
Turn(cdcontain5,y_axis,math.rad(32),12)
Move(cdcontain5,z_axis,60,27)
Turn(cdcontain8,z_axis,math.rad(-27),12)
WaitForMove(cdcontain5,z_axis)    
WaitForMove(cdcontain8,z_axis)    
WaitForTurn(cdcontain5,x_axis)     
WaitForTurn(cdcontain5,y_axis)     
WaitForTurn(cdcontain8,z_axis)     
WaitForTurn(cdcontain8,x_axis)     
WaitForTurn(cdcontain8,y_axis)     


Explode(cdcontain5, SFX.FALL+ SFX.EXPLODE_ON_HIT)
Explode(cdcontain6,  SFX.NONE +SFX.FALL)
Explode(cdcontain7, SFX.NONE + SFX.FALL)
Explode(cdcontain8,  SFX.NONE +SFX.FALL)
Hide(cdcontain5)
Hide(cdcontain6)
Hide(cdcontain7)
Hide(cdcontain8)

WaitForTurn(condepotre,x_axis)

suddenDeath(unitID,recentDamage)
Explode(condepotre, SFX.SHATTER)
Sleep(10)
return 0
end

function open()
	boolRetracted =false
    Spring.PlaySoundFile("sounds/cbuil/cbuilrise.wav")
	Signal(SIG_CLOSE)
    SetSignalMask(SIG_OPEN)
	
	
	Spin(condboltlo,y_axis,0,0.7)
	
	Sleep(1100)
	Move(condboltlo,x_axis,0,0.3)
	WaitForMove(condboltlo,y_axis)
	Hide(condboltlo)
	Turn(condepotbu,z_axis,math.rad(0),0.35)
	Turn(condepotb0,z_axis,math.rad(0),0.35)
	Move(condepotbu,y_axis,0,5)
	Move(condepotb0,y_axis,0,5)
	-- i actually imagined the controlltower to be the key_lock of that blasted door, but had enough trouble as it is...
	--	still would be fucking awesome
	Sleep(1250)
	Move(condepotre,y_axis,0,6)
	WaitForMove(condepotre,y_axis)
	WaitForMove(condepotb0,y_axis)
	WaitForMove(condepotbu,y_axis)

	Turn(condepotbu,x_axis,math.rad(0),12)
	Turn(condepotbu,y_axis,math.rad(0),12)
	Turn(condepotbu,z_axis,math.rad(0),12)
	
	Turn(condepotb0,x_axis,math.rad(0),12)
	Turn(condepotb0,y_axis,math.rad(0),12)
	Turn(condepotb0,z_axis,math.rad(0),12)	
	Move(condboltlo,x_axis,0,5)
	Move(condboltlo,y_axis,0,5)
	Move(condboltlo,z_axis,0,5)
	Turn(condboltlo,x_axis,math.rad(0),12)
	Turn(condboltlo,y_axis,math.rad(0),12)
	Turn(condboltlo,z_axis,math.rad(0),12)
	
	



	
		while(true) do
		Sleep(400)
		
		end
	
	end
	
function close()
		
	boolRetracted =true

	
	Spring.PlaySoundFile("sounds/cbuil/cbuilretr.wav")
    Signal(SIG_OPEN)
	--Hide(condboltlo)
    SetSignalMask(SIG_CLOSE)
	Move(condboltlo,x_axis,10,5)
	WaitForMove(condboltlo,x_axis)
	Move(condepotre,y_axis,-222,6)
	WaitForMove(condepotre,y_axis)
	Move(condepotbu,y_axis,45,5)
	Move(condepotb0,y_axis,45,5)
	Move(condepotbu,x_axis,-11,5)
	Move(condepotb0,x_axis,11,5)
	Turn(condepotbu,z_axis,math.rad(45),0.05)
	Turn(condepotb0,z_axis,math.rad(-45),0.05)
	Move(condepotbu,y_axis,93,5)
	Move(condepotb0,y_axis,93,5)
	Sleep(189)
	
	
	Turn(condepotbu,z_axis,math.rad(90),0.05)
	Turn(condepotb0,z_axis,math.rad(-90),0.05)
	Move(condbolt1,y_axis,-14,1)
	Move(condbolt2,y_axis,-14,1)
	Move(condbolt3,y_axis,-14,1)
	Move(condbolt4,y_axis,-14,1)
	--Move(condepotb0,x_axis,15,0.77)--i
	--Move(condepotbu,x_axis,-10,3.55)--i
	--
	--WaitForMove(condepotbu,y_axis)
	--WaitForMove(condepotb0,x_axis)
	Sleep(1200)
	Move(condepotbu,x_axis,0,0.5)
	Move(condepotb0,x_axis,0,0.5)
	Spring.PlaySoundFile("sounds/cComon/cBunkerShut.wav")
	WaitForTurn(condepotbu,z_axis)
	WaitForTurn(condepotb0,z_axis)

	WaitForMove(condbolt4,y_axis)
	WaitForMove(condbolt3,y_axis)
	WaitForMove(condbolt2,y_axis)
	WaitForMove(condbolt1,y_axis)
	----condepotbolts
	
	Sleep(1200)
 

	Show(condboltlo)
	Move(condboltlo,x_axis,9,1)
	
	WaitForMove(condboltlo,x_axis)
	Turn(condboltlo,x_axis,math.rad(180),0.85)
	WaitForTurn(condboltlo,x_axis)
	Turn(condboltlo,x_axis,math.rad(360),0.2)
	WaitForTurn(condboltlo,x_axis)
	Move(condboltlo,x_axis,12,4)
	Move(condepotb0,x_axis,0.5,2)
	Move(condepotbu,x_axis,-0.5,2)
	Sleep(2500)
	Spin(condboltlo,x_axis,math.rad(20),0.7)
	Move(condboltlo,x_axis,4,0.5)
	WaitForMove(condboltlo,x_axis)
	StopSpin(condboltlo,x_axis)
	--Waits
	
	
	Move(condboltlo,x_axis,0,2)
	Spin(condboltlo,x_axis,math.rad(40),0.7)
	Sleep(700)
	StopSpin(condboltlo,x_axis)
	Turn(condboltlo,x_axis,math.rad(0),0.7)
	Move(condbolt1,y_axis,0,2)
	Move(condbolt2,y_axis,0,2)
	Move(condbolt3,y_axis,0,2)
	Move(condbolt4,y_axis,0,2)
	--waitforTurn
	Move(condboltlo,x_axis,10,2)
	
	
	

	Signal(SIG_IDLE)
	


	while(true) do

	Sleep(400)
	
	--SetUnitValue(COB.INBUILDSTANCE, 0)
	end


end

function themLights()



	Show(condepotli)
	Sleep(175)
	Show(condepotl2)
	Sleep(50)
	Hide(condepotli)
	Sleep(75)
	Show(condepotl1)
	Sleep(50)
	Hide(condepotl2)
	Sleep(75)
	Show(condepotl0)
	Sleep(50)
	Hide(condepotl1)
	Sleep(125)
	Hide(condepotl0)
	Sleep(550)
	


end

local function idle()
SetSignalMask(SIG_IDLE)
	while(true)do
	themLights()
	randMove=math.random(0,51)
	themLights()
	randSpeed=math.random(0.4,4)
	Move(cdcrane,x_axis, randMove, randSpeed)
	themLights()
	randSleep=math.random(512,1024)
	themLights()
	Sleep(randSleep)
	-- Light chain as function
	themLights()
	
	
	randMove=math.random(-48,-25)
	Move(cdcrane,x_axis, randMove, randSpeed)
	themLights()
	themLights()
	end
end





function script.Activate()
--Spring.Echo("We shall see about that")
	if GG.Alarm== nil then 
	GG.Alarm={}
	GG.Alarm[teamID]={}
	end
    GG.Alarm[teamID]=false


	SetUnitValue(COB.YARD_OPEN, 1)
	SetUnitValue(COB.INBUILDSTANCE, 1)
	SetUnitValue(COB.BUGGER_OFF, 1)
	
	return 1
end

function script.Deactivate()
	if GG.Alarm== nil then 
	GG.Alarm={}
	GG.Alarm[teamID]={}
	end
GG.Alarm[teamID]=true


	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	SetUnitValue(COB.BUGGER_OFF, 0)

	return 0
end







function script.StopBuilding()



boolIsBuilding=false
  

end

function script.StartBuilding(heading, pitch)	
--Spring.Echo("First to die of thirst?")
Signal(SIG_RESET)
StartThread(building)

boolIsBuilding=true



end

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
	  
		while(true) do
				if GG.Alarm[teamID] == true and GG.Alarm[teamID] ~= statusOfOld then
				statusOfOld=GG.Alarm[teamID]
				--case Alarm and building is still open
			
				boolClosingTimes=true
					Signal(SIG_OPEN)
					
				
				StartThread(close)
				end
				
					if GG.Alarm[teamID] == false and GG.Alarm[teamID] ~= statusOfOld then
					--case no Alarm and building is still retracted
					statusOfOld=GG.Alarm[teamID]	
						Signal(SIG_CLOSE)
								
						StartThread(open)				 
					end
					
				Sleep(4095)
					--nothing
					
				


	
		end
end




