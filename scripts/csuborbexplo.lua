center= piece "center"
rotatecenter = piece "rotatecenter"
impactor =piece "impactor"
fire1=piece "fire1"
fire2=piece "fire2"
fireballcenter= piece"fireballcenter"
flameemit1= piece"flameemit1"
flameemit2= piece"flameemit2"
flameemit3= piece"flameemit3"

ring={}
for i=1, 12, 1 do
ring[i]={}
temp="ringparticlespawn"..i
ring[i]=piece (temp)
end

local SIG_BLINK=1
local SIG_FLAME=2

fireballz={}
for i=1, 9, 1 do
fireballz[i]={}
temp="fireball"..i
fireballz[i]=piece (temp)
end

function decalFactoryEmit()
Sleep(300)
posX,posY,posZ=Spring.GetUnitPosition(unitID)
Spring.CreateUnit("NukedecalFactory",posX,posY,posZ, 0, teamID)  


end

spiralcenter =piece "spiralcenter"
fireFx =piece "fireFx"
function spawnBrix()
temp=25
max=600
local spEmitFx=EmitSfx
	while(temp < 350 ) do
	Move(fireFx,x_axis,temp,0)
	temp=temp+18.4
	for i=1, 360, 1 do
		holyRandoma=math.random(0,1)
		if holyRandoma==1 then
		Turn(spiralcenter,y_axis,math.rad(i),0,true)
		spEmitFx(fireFx,1032)
		end
	end
	Turn(spiralcenter,y_axis,math.rad(0),0,true)
	Sleep(2)
	end

end

function blinkFire()
Spin(fire1,y_axis,math.rad(52),0.3)
Spin(fire2,y_axis,math.rad(-52),0.3)
SetSignalMask(SIG_BLINK)
	while (true) do
	deciOne=math.random(0,2)
		if deciOne== 1 then
		Show(fire1)
			elseif deciOne== 0 then
			Show(fire2)
				else
				Show(fire2)
				Show(fire1)
				end
	Sleep(80)
	Hide(fire1)
	Hide(fire2)
	Sleep(120)
	end


end
function playSound()
Sleep(750)
Spring.PlaySoundFile("sounds/csubOrbital/impactor.wav")

end

function flameEmit()
SetSignalMask(SIG_FLAME)
local spEmitFx=EmitSfx
	while(true)do
	spEmitFx(flameemit1,1026)
	spEmitFx(flameemit1,1027)
	spEmitFx(flameemit2,1026)
	spEmitFx(flameemit2,1027)
	spEmitFx(flameemit3,1026)
	spEmitFx(flameemit3,1027)
	Sleep(50)
	end
end
function spawnFire(time,x,y,z)
local spSpawnCEG=	Spring.SpawnCEG
for i=1, time, 1 do
	spSpawnCEG("unitonfire",x,y,z,0,1,0,50,0)
	spSpawnCEG("unitonfire",x,y+7,z,0,1,0,50,0)

	Sleep(90)
end

for i=1,time*3,1 do
	spSpawnCEG("blackerthensmoke",x,y,z,0,1,0,50,0)
	Sleep(90)
end

end

function goTooKillThemAllPicaMon()

selectRange=260
piecePosX,piecePosY,piecePosZ=Spring.GetUnitPosition(unitID)
----Spring.Echo("PiecePosX:",piecePosX.."      | PiecePosZ:",piecePosZ)
--get Piece Position
proChoice={}
proChoice=Spring.GetUnitsInCylinder(piecePosX, piecePosZ,selectRange )--no idea why 2.9 but satan told me so

	if proChoice ~= nil then
							
											

											--Kill the Unit
			for i=1,table.getn(proChoice),1 do		
													if proChoice[i] ~= unitID then
													x,y,z=Spring.GetUnitPosition(proChoice[i])
													StartThread(spawnFire,82,x,y,z)
													Spring.SetUnitNoDraw(proChoice[i],false)
													Spring.DestroyUnit(proChoice[i],false,false) --leave no wreck
												    end
			end

	end
end
					--Reset the Parts
 function randomFire(time)					

x,y,z=Spring.GetUnitPosition(unitID)

temptime=0
local spSpawnCEG=	Spring.SpawnCEG

	while (temptime < time) do
	randx=math.random(-150,150)
	randz=math.random(-150,150)
	randx=math.random(-150,150)
	randz=math.random(-150,150)
		if randx > -60 and randx < 60 or randz > -60 and randz < 60 then
		ohThrownDiceBeNice=math.random(0,1)
			if ohThrownDiceBeNice==1 then
			randx=math.random(60,90)*math.random(-1,1)
			randz=math.random(60,90)*math.random(-1,1)
			end
		end
	spSpawnCEG("flames",x+randx,y,z+randz,0,1,0,50,0)
	spSpawnCEG("glowsmoke",x+randx,y+20,z+randz,0,1,0,80,0)
	spSpawnCEG("blackerThenSmoke",x+randx,y+26,z+randz,0,1,0,100,0)
	spSpawnCEG("volcanolightsmall",x+randx,y,z+randz,0,1,0,50,0)
	Sleep(60)
	temptime=temptime+60
	end

end

function randomFires()
nr=math.random(7,12)
for i=1,nr,1 do
randomnumber=math.random(34000,84000)
StartThread(randomFire,randomnumber)
end
while(true)do
Sleep(100)
end

end

function volcaniclavalamp()
local spEmitSFX=EmitSfx
for i=1,42,1 do
Sleep(60)
spEmitSFX(center,1031)
end
end

function justWaitAndSee()


Turn(center,y_axis,math.rad(180),0)

posX,posY,posZ=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
--set the unit to no collide
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitNeutral(unitID, true ) 
Spring.SetUnitBlocking( unitID, false)

--set the unit to be ignored
Show(impactor)
StartThread(blinkFire)
Turn(impactor,z_axis,math.rad(-90),0)
StartThread(flameEmit)
StartThread(playSound)
Turn(impactor,z_axis,math.rad(0),0.41083005)
WaitForTurn(impactor,z_axis)
Spring.CreateUnit("NukedecalFactory",posX,posY,posZ,0, teamID)  
Hide(impactor)
goTooKillThemAllPicaMon()
EmitSfx(center,1028)
Signal(SIG_BLINK)
Signal(SIG_FLAME)
Hide(fire1)
Hide(fire2)

EmitSfx(fire1,1024)
Sleep(10)
EmitSfx(center,1024)
StartThread(spawnBrix)
for i=1,7, 1 do
EmitSfx(center,1025)--sphere
end
Sleep(50)
EmitSfx(center,1029)
Sleep(400)
EmitSfx(center,1025)--sphere
EmitSfx(center,1029)
Sleep(2000)
StartThread(volcaniclavalamp)
StartThread(randomFires)
Sleep(20000)

Spring.DestroyUnit (unitID,true,true)
end
					
function script.Create()
StartThread(justWaitAndSee)
end

function script.Killed()
	

end




