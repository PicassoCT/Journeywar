--This is the Water Extractor Script - it decrements the water once per minute by the given global Amount..
--<pieces>
waterEmit1=piece"waterEmit1"
waterEmit2=piece"waterEmit2"
waterEmit3=piece"waterEmit3"
waterEmit4=piece"waterEmit4"
waterEmit5=piece"waterEmit5"
waterwheel=piece"waterwheel"
waterimp= piece"waterimp"
center= piece"center"
Leave1= piece"Leave1"
Leave2= piece"Leave2"
Leave3= piece"Leave3"
SIG_WATER=1

watercircles={}
for i=1, 12, 1 do
watercircles[i]={}
piecename="watercirc"..i
watercircles[i]=piece (piecename)
Hide(watercircles[i])
end

dropLet={}
dropcirc={}
extdrop={}
for i=1, 3, 1 do
dropLet[i]={}
dropcirc[i]={}
extdrop[i]={}
piecename="dropcenter"..i
piecenameb="dropcirc"..i
piecenamec="extdrop"..i

dropLet[i]=piece (piecename)
dropcirc[i]=piece (piecenameb)
extdrop[i]=piece (piecenamec)

end

droped={}
for i=1, 8, 1 do
droped[i]={}
piecename="drop"..i
droped[i]=piece (piecename)
Hide(droped[i])
end
--</pieces>

--<variables>
local int3=0
g_WaterOffSet=0
g_AddOnRate=0.025
--</variables>
function decoRation()
while(true) do
Sleep(400)
end
end

function emitit()
SetSignalMask(SIG_WATER)
	while(true)do
	Sleep(60)
	rand=math.random(1,3)
	if rand==3 then
	EmitSfx(waterEmit4,1025)
	elseif rand== 2 then
	EmitSfx(waterEmit3,1025)
	elseif rand==1 then
	EmitSfx(waterEmit5,1025)
	else
	EmitSfx(waterEmit2,1025)
	end
	
	end
end

function addWaterLvl()
Sleep(100)
	while(true) do
		if GG.addWaterLevel ~= nil then

		GG.addWaterLevel=GG.addWaterLevel+g_AddOnRate
		--Spring.Echo(GG.addWaterLevel)
		Sleep(1000)
		--Spring.Echo("WaterUp",g_WaterOffSet)
		else
		Sleep(1000)
		end
	end
end

function turnWaterWheel()
	while(true) do
	Show(watercircles[7])
	Turn(waterwheel,z_axis,math.rad(-30),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[2])


	Show(watercircles[8])
	Turn(waterwheel,z_axis,math.rad(-63),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[3])

	Show(watercircles[9])
	Turn(waterwheel,z_axis,math.rad(-87),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[4])

	Show(watercircles[10])
	Turn(waterwheel,z_axis,math.rad(-124),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[5])

	Show(watercircles[11])
	Turn(waterwheel,z_axis,math.rad(-152),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[6])


	Show(watercircles[12])
	Turn(waterwheel,z_axis,math.rad(-181),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[7])

	Show(watercircles[1])
	Turn(waterwheel,z_axis,math.rad(-207),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[8])

	Show(watercircles[2])
	Turn(waterwheel,z_axis,math.rad(-239),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[9])

	Show(watercircles[3])
	Turn(waterwheel,z_axis,math.rad(-267),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[10])

	Show(watercircles[4])
	Turn(waterwheel,z_axis,math.rad(-295),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[11])

	Show(watercircles[5])
	Turn(waterwheel,z_axis,math.rad(-332),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[12])

	Show(watercircles[6])
	Turn(waterwheel,z_axis,math.rad(-361),45)
	WaitForTurn(waterwheel,z_axis)
	Hide(watercircles[1])

	Show(watercircles[7])
	Turn(waterwheel,z_axis,math.rad(0),0)
	Hide(watercircles[2])
	end

end

function emitWaterSFX()
x=6
for i=1, 15, 1 do
				if x > 0 then 
				Show(watercircles[x])
				x=x-1
				end

EmitSfx(waterEmit1,1024)
Sleep(60)
end

	while(true) do
	--EmitSfx(waterEmit1,1024)
	EmitSfx(waterEmit2,1024)
	EmitSfx(waterEmit2,1024)
	Sleep(60)


	end

end

function emitSound()
		while true do 
		d=math.random(1,3)
		if d == 1 then
			Spring.PlaySoundFile("sounds/jwatergate/waterGate1.wav")
			Sleep(14000)
		elseif d== 2 then
			Spring.PlaySoundFile("sounds/jwatergate/waterGate2.wav")
			Sleep(20000)
								else
								x=math.random(0,1)
										if x== 1 then

											Spring.PlaySoundFile("sounds/jwatergate/waterGate2.wav")
										else
											Spring.PlaySoundFile("sounds/jwatergate/waterGate1.wav")
										end
									
									Sleep(14000)

								
								end
		end
end


--dropLet={}
--dropcirc={}
--extdrop={}
function dropIt()
int3=int3+1

deci=math.random(1,3)
Hide(extdrop[deci])
aynRandomVal=math.random(0,360)
Turn(dropLet[deci],y_axis,math.rad(aynRandomVal),0)
Turn(dropcirc[deci],z_axis,math.rad(0),0)
Show(extdrop[deci])

Turn(dropcirc[deci],z_axis,math.rad(-220),9)
WaitForTurn(dropcirc[deci],z_axis)
Hide(extdrop[deci])
int3=int3-1
end


function impactShow()
Spin(waterimp,y_axis,math.rad(12),0.1)
Hide(waterimp)
		for i=1, 8, 1 do
--		Show(droped[i])
Hide(droped[i])
		end
	while(true) do
	

	    --Show(waterimp)
	
		--done=math.random(1,8)
		--for i=1, done, 1 do
		
	--	Show(droped[i])
	
		--end
	sleeprand=math.random(80,220)
	Sleep(sleeprand)
				while( int3 < 3) do
				StartThread(dropIt)
				end
				
		--for i=1, done, 1 do

		--Hide(droped[i])
		--end	
		
	end
		
end

function centerTurner()
xi=0.12

di=math.random(-1,1)
if di==0 then di =1 end
xi=di*xi
Spin(center,y_axis,math.rad(xi),0.1)
end


function waveItLikeYouJustdontCare()
	while(true) do
	Turn(Leave1,x_axis,math.rad(1),0.02)
	Turn(Leave2,x_axis,math.rad(-1),0.024)
	Turn(Leave3,x_axis,math.rad(1),0.02)
	WaitForTurn(Leave2,x_axis)
	
	Turn(Leave1,x_axis,math.rad(-1),0.02)
	Turn(Leave2,x_axis,math.rad(1.5),0.02)
	Turn(Leave3,x_axis,math.rad(-1),0.02)
	WaitForTurn(Leave2,x_axis)
	end
end

function script.Create()
--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
--Spring.CreateUnit("jbuildanimation",x,y,z,0,teamID) --TODO

--</buildanimationscript>
for i=1, 12, 1 do
Hide(watercircles[i])
end
for i=1, 3, 1 do
Hide(extdrop[i])
end
rando=math.random(0,360)
Turn(center,y_axis,rando,0)

Spring.PlaySoundFile("sounds/jwatergate/waterGate3.wav")
centerTurner()

StartThread(turnWaterWheel)
StartThread(emitSound)
StartThread(emitWaterSFX)
StartThread(addWaterLvl)
StartThread(decoRation)
StartThread(waveItLikeYouJustdontCare)
StartThread(impactShow)
StartThread(emitit)
end

--if the LandLordGadget triggers this function, it has read the WaterLevelChange
function reciveWaterReSet(boolReSet)
	if boolReSet==true then
	g_WaterOffSet=0
	end


end


function script.killed()

return 1
end