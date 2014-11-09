center=piece"center"
beans= piece"beans"
beanstalk=piece"beanstalk"
introgroup =piece"introgroup"
bean1 =piece"bean1"
seed =piece"seed"
rootGroup=piece"rootGroup"
seedRotator=piece"seedRotator"
bshelix=piece"bshelix"
unRooted=piece"unRooted"
bsfetas=piece"bsfetas"
growGroup=piece"growGroup"
local SIG_ENTER=1
local SIG_PUMP=2
local SIG_DIRT=4
local SIG_PIPE=8
local SIG_LEAVE=16
teamID=Spring.GetUnitTeam(unitID)
local currentpiece=piece"somemit1"
buildemitcenter= piece"buildemitcenter"
emitIt={}
for i=1,6,1 do
emitIt[i]={}
stone= "somemit"..i
emitIt[i]=piece (stone)
end

spindl= piece"spindl"
spindl2=piece"spindl2"
spindl3=piece"spindl3"
pipePieces={}
for i=1,59,1 do
pipePieces[i]={}
stone= "bspip01p"..i
pipePieces[i]=piece (stone)
end

pumps={}
for i=1,5,1 do
pumps[i]={}
stone= "pump"..i
pumps[i]=piece (stone)
end

greenSleaves={}
for i=1,14,1 do
greenSleaves[i]={}
stone= "growLea"..i
greenSleaves[i]=piece (stone)
end

bean1=piece"bean1"
bean2=piece"bean2"
bean3=piece"bean3"
rootgrow=piece"rootgrow"
rootRotate=piece"rootRotate"





wurzelballen={}

for i=1,4,1 do
wurzelballen[i]={}
stone= "Wurzelbal"..i
wurzelballen[i]=piece (stone)
end




dirt={}
for i=1,6,1 do
dirt[i]={}
stone= "Dirt"..i
dirt[i]=piece (stone)
end
fireFx1=piece"fireFx1"
fireFx2=piece"fireFx2"
fireFx3=piece"fireFx3"
spiralCenter= piece"spiralCenter"

function nanoEmitIdler()
local randNom=math.random
	while(true) do
	randDeg=randNom(0,360)
	Turn(buildemitcenter,y_axis,math.rad(randDeg),0)
	selected=math.ceil(randNom(1,6))
	currentpiece=emitIt[selected]
	Sleep(75)
	end
end

function cyclesOfFire()
Hide(fireFx1)
Hide(fireFx2)
Hide(fireFx3)
	while(true) do
	Spin(spiralCenter,y_axis,math.rad(42),0.3)
	EmitSfx(fireFx1,1032)
	EmitSfx(fireFx2,1032)
	EmitSfx(fireFx3,1032)
	Sleep(60)

	end
end
blimelyLookAtTheTime=0

boolOnce=true
total=10
function spawny()
blimelyLookAtTheTime=1500
	if total > 0 then
	slice=math.floor(math.random(1,5))
	px, py, pz, dx, dy, dz =Spring.GetUnitPiecePosDir(unitID,pumps[slice])
	Spring.CreateUnit("tiglil",px,py,pz, 0, teamID)  
	total=total-1
		elseif boolOnce==true then
		boolOnce=false
		Sleep(23000)
		total=10
		boolOnce=true
		end
Sleep(1500)
blimelyLookAtTheTime=0

end


function HitByWeapon ( x, z, weaponDefID, damage )
	if blimelyLookAtTheTime == 0 and damage > 15 then
	StartThread(spawny)
	end

end

function emitDirt()
SetSignalMask(SIG_DIRT)
StartThread(cyclesOfFire)
while(true) do
	for i=1,6,1 do
	rondo=math.random(190,420)
	Explode(dirt[i],SFX.FALL+SFX.NO_HEATCLOUD)
			for i=1,6,1 do
			EmitSfx(dirt[i],1028)
			EmitSfx(dirt[i],1028)
			end
	
	Sleep(rondo)
	end
Sleep(300)	
	
end
end

function SpinArrest(piecename)
StopSpin(piecename,x_axis)
StopSpin(piecename,y_axis)
StopSpin(piecename,z_axis)

end
--13
function unfoldLeaves()
for i=1,table.getn(greenSleaves),1 do
	Hide(greenSleaves[i])
end
Sleep(3000)
SetSignalMask(SIG_LEAVE)
	while(true) do
	for i=1,table.getn(greenSleaves),1 do
	
	ProRany=math.random(0,1)
		if ProRany == 1 then
		EmitSfx(greenSleaves[i],1031)
		Sleep(25)
		EmitSfx(greenSleaves[i],1031)
		else
		Explode((greenSleaves[i]),SFX.NO_HEATCLOUD + SFX.FALL)
		end
		
	
	Sleep(100)
	end
	end
end


function emitSparks()
while(true) do
for i=1,table.getn(dirt),1 do
EmitSfx(dirt[i],1030)

end
Sleep(200)
end

end

function moveUpAndDown()
SetSignalMask(SIG_PUMP)
Signal(SIG_PIPE)
StartThread(pumpAnimation)
while(true) do
for i=1,table.getn(pumps),1 do
Move(pumps[i],y_axis,13,0.8)
end
WaitForMove(pumps[5],y_axis)
for i=1,5,1 do
Move(pumps[i],y_axis,0,1.8)
end
WaitForMove(pumps[5],y_axis)
end
end
--emits the Seeds EntryHeat
function flameEmitEntry()
SetSignalMask(SIG_ENTER)
emOx,emOy,emOz=0
while(true)do
emitX,emitY,emitZ,_,_,_=Spring.GetUnitPiecePosDir(unitID,seed)

							Spring.SpawnCEG("blackerThenSmoke",emitX,emitY,emitZ,0,1,0,50,0)
							Spring.SpawnCEG("flames",emitX,emitY,emitZ,0,1,0,50,0)
							Spring.SpawnCEG("blackerThenSmoke",emOx,emOy,emOz,0,1,0,50,0)
							Spring.SpawnCEG("glowSmoke",emOx,emOy,emOz,0,1,0,50,0)
							emOx=emitX
							emOy=emitY
							emOz=emitZ
Sleep(40)
end
end

function pumpAnimation()
for i=1,59,1 do
Hide(pipePieces[i])
end
SetSignalMask(SIG_PIPE)
while(true) do
--3
for i=3,59,3 do
Show(pipePieces[i])
end
Sleep(50)
for i=2,59,3 do
Hide(pipePieces[i])
end

second=math.random(280,360)
Sleep(second)

--1
for i=3,58,3 do
Hide(pipePieces[i])
end

for i=1,59,3 do
Show(pipePieces[i])
end
first=math.random(150,250)
Sleep(first)
--2
for i=2,59,3 do
Show(pipePieces[i])
end
Sleep(50)

for i=1,59,3 do
Hide(pipePieces[i])
end
second=math.random(200,300)
Sleep(second)


end



end
function playHeartBeat()
while(true) do
Spring.PlaySoundFile("sounds/jBeanStalk/beanstalkhbeat.wav")
Sleep(9000)
end
end

function idle()
while(true) do
sleepTime=math.random(90,14000)
Sleep(sleepTime)
Signal(SIG_PUMP)
sleepTime=math.random(90,14000)
Sleep(sleepTime)
StartThread(moveUpAndDown)

end
end


testTable={}

function greatEntry()
Spin(bsfetas,y_axis,math.rad(3.2),0.2)
Spin(bshelix,y_axis,math.rad(4.2),0.2)
tableOfPieces={}
tableOfPieces=Spring.GetUnitPieceList(unitID)

	for i=1,table.getn(tableOfPieces),1 do
	name=tableOfPieces[i]
	x=piece(name)
	Show(x)

	end
	
	for i=1,6,1 do
	Hide(dirt[i])
	end
	
	Hide(unRooted)
	Hide(spindl)
	Hide(spindl2)
	Hide(spindl3)
	Hide(fireFx1)
	Hide(fireFx2)
	Hide(fireFx3)
	Hide(seed)
	Hide(bean1)

	Hide(bean2)

	Hide(bean3)

	Hide(spindl)

	Hide(spindl2)

	Hide(spindl3)

	Hide(rootRotate)
	for i=1,14,1 do
	Hide(greenSleaves[i])

	end
	
	for i=1,4,1 do
	Hide(wurzelballen[i])
	end

end

function script.Create()
greatEntry()

StartThread(idle)
StartThread(nanoEmitIdler)
StartThread(playHeartBeat)
Signal(SIG_LEAVE)
--StartThread(reInforCements)
StartThread(waitingGame)
end

function script.Killed()

end
local boolreVert=false
function waitingGame()
	while(true) do
		if boolreVert==true and (Spring.ValidUnitID (unitID)) then
		Sleep(500)
				if boolreVert==true and (Spring.ValidUnitID (unitID)) then
			   local x,y,z=Spring.GetUnitPosition (unitID)
			   local teamID = Spring.GetUnitTeam (unitID)
				mexID= Spring.CreateUnit("mbeanstalk", x, y, z, 0, teamID) 
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(mexID,health)	
				Spring.DestroyUnit (unitID,false,true)
				end
		end
		  
		  
	  

	Sleep(1000)
	end
end

function script.Activate ( )
boolreVert=false

--boolUnDeployed=false
--boolSafetyFirst=true
	return 1
  end

function script.Deactivate ( )
boolreVert=true
--if boolSafetyFirst==true then
--boolUnDeployed=true
--end
--Place Unmorpher here
	return 0
  end



--------BUILDING---------
function script.StopBuilding()
  Signal(SIG_PUMP)
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)	
StartThread(moveUpAndDown)
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

function script.QueryNanoPiece()
     return currentpiece
end



	
aimpoint= piece "aimpoint"
----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpoint 
end

function script.QueryWeapon1() 
	return aimpoint 
end

function script.AimWeapon1( heading ,pitch)	

	
	return true
end

function script.FireWeapon1()	



	return true
end
