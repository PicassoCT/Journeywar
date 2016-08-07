--pieces
lavawheel1=piece"lavawheel1"
lavawheel2=piece"lavawheel2"
lavawheel3=piece"lavawheel3"
lavawheel4=piece"lavawheel4"
center=piece"center"
LavaWheelie=piece"LavaWheelie"
lavaCircle=piece"lavaCircle"
lavabubbles=piece"lavabubbles"

volcaNooo=piece"volcaNooo"

lavaCov1=piece"lavaCov1"

lavaCov2=piece"lavaCov2"

lavaCov3=piece"lavaCov3"

shatterSphere=piece"shatterSphere"
outSky=piece"outSky"
local SIG_SPAWN=1
local SIG_LIGHT=2
inSky=piece"inSky"
local lavaBomb= piece"lavaBomb"
local LavaPyre= piece"LavaPyre"
teamID=Spring.GetUnitTeam(unitID )

eruptionArray={}
for i=1,18,1 do
eruptionArray[i]={}
Emiters="eruptionp"..i
eruptionArray[i]=piece(Emiters)
end
groundEmitters={}

for i=1,8,1 do
groundEmitters[i]={}
Emiters="EmitG"..i
groundEmitters[i]=piece(Emiters)
end

skyEmitters={}
for i=1,34,1 do
skyEmitters[i]={}
Emiters="EmitS"..i
skyEmitters[i]=piece(Emiters)
end

lSpawner={}
for i=1,4,1 do
lSpawner[i]={}
lavaSpawneX="lavaSpawner"..i
lSpawner[i]=piece(lavaSpawneX)
end
lPyre={}
for i=1,3,1 do
lPyre[i]={}
lavaSpawneX="lavaPyre"..i
lPyre[i]=piece(lavaSpawneX)
end

lavaLingus={}
for i=1,4,1 do
lavaLingus[i]={}
lavaSpawneX="lavaTongue"..i
lavaLingus[i]=piece(lavaSpawneX)
end

--/pieces
--Variables
shakeTime=3000
totalErruptionTime=52000
--

function script.Killed()

end




function script.QueryWeapon1() return 
lavaBomb end
	
	function script.AimFromWeapon1() 

	return lavaBomb end
	
	function script.AimWeapon1( heading, pitch )

          
		return true
	end
	
	
	function script.FireWeapon1()
	
	end
function fromDust()

fromDusk=0
	while(fromDusk<shakeTime) do
		for i=1,8,1 do
		EmitSfx(groundEmitters[i], 1024)
		
		end
	shaky=math.random(45,120)
	Sleep(shaky)
	Sleep(10)
	fromDusk=fromDusk+shaky
	end
end

boolLactoseIntolerantVolcano=true
function LavaBomberMan()
while(boolLactoseIntolerantVolcano==true) do

Explode(lavaBomb,SFX.SMOKE+SFX.FIRE+SFX.FALL+SFX.EXPLODE_ON_HIT)
napTime=math.random(70,830)
Sleep(napTime)
Sleep(10)
end
end



boolCoverUp=true
function firexWorX()
	while(boolCoverUp==true) do
		for i=1,8,1 do
		EmitSfx(groundEmitters[i], 1027)
		EmitSfx(skyEmitters[i], 1026)
	
		end
	Sleep(65)
	end
end

function fireWhoreX()
while(screwYou==true) do
	for i=1,8,1 do
		EmitSfx(groundEmitters[i], 1027)
		lol=math.random(0,34)
		if lol%6 ==0 then
		EmitSfx(groundEmitters[i], 1025)
		end
	
		end
		Sleep (90)

end

end

boolDarkCloudUp=true
function smokeOnTheHeight()
	while(boolDarkCloudUp==true) do
		for i=8,34,1 do
	
	
		EmitSfx(skyEmitters[i], 1026)
		y=math.random(0,8)
				if y==4 then
				EmitSfx(skyEmitters[i], 1028)
				elseif y%2==0 then
						EmitSfx(skyEmitters[i], 1029)
				end
		end
	Sleep(65)
	end

end

function PyreMover()
while(boolLactoseIntolerantVolcano==true) do
Move(LavaPyre,y_axis,36,56)

WaitForMove(LavaPyre,y_axis)
Move(LavaPyre,y_axis,0,0)

end

end

function bloodAndAshes()
while(boolLactoseIntolerantVolcano==true) do
for i=1,21,1 do
	
			deci=math.random(0,1)
			if deci==1 then
			EmitSfx(skyEmitters[i], 1030)
			else
					EmitSfx(skyEmitters[i], 1031)
			end
		
		end
nap=math.random(30,750)
Sleep(nap)
Sleep(10)
end
end

function lavaProps()
ror=1

for i=1,table.getn(lavaLingus),1 do
Spin(lavaLingus[i],y_axis,math.rad(-54),0.5)

end

	while(true) do
	Sleep(1000)

		if ror%30==0 then
		Spring.PlaySoundFile("sounds/gVolcano/blubber.wav")
		ror=1
		end
			while (ror % 3 ~= 0) do
			ror=ror+1
			x=math.random(1,4)
            
			Show(lavaLingus[x])
			Move(lavaLingus[x],y_axis,-5,0)
			Move(lavaLingus[x],y_axis,0,2.5)
			Sleep(300)
			Turn(lavaLingus[x],x_axis,math.rad(90),8)
		    Sleep(400)
			Hide(lavaLingus[x])
			Sleep(40)
			end
	end
end

function playSoundFiles()


Sleep(4000)
			Spring.PlaySoundFile("sounds/gVolcano/volcano.wav")
Sleep(3000)
while(boolLactoseIntolerantVolcano==true) do
	Spring.PlaySoundFile("sounds/gVolcano/volErupt.wav")
	Sleep(7000)
end
end

function spawnLavaUnits()
SetSignalMask(SIG_SPAWN)
while(true) do
	for i=1,4,1 do
	randspeed=math.random(0.3,3)
	Move(lSpawner[i],y_axis,-9,0)
	Move(lSpawner[i],y_axis,0,randspeed)

	end
	Sleep(8000)
	pos=math.random(0,3)
	if pos==0 then
			posX,  posY , posZ,_,_,_ =Spring.GetUnitPiecePosDir(unitID,lSpawner[1])	
			posY=Spring.GetGroundHeight(posX,posZ)	
				
				--spawn a Unit
				Spring.CreateUnit("gLava",posX,posY,posZ, 0, teamID)  
	elseif pos==1 then
		posX,  posY , posZ,_,_,_ =Spring.GetUnitPiecePosDir(unitID,lSpawner[2])	
			posY=Spring.GetGroundHeight(posX,posZ)	
			
				--spawn a Unit
				Spring.CreateUnit("gLava",posX,posY,posZ, 0, teamID)  
	elseif pos==2 then
		posX,  posY , posZ,_,_,_ =Spring.GetUnitPiecePosDir(unitID,lSpawner[3])	
			posY=Spring.GetGroundHeight(posX,posZ)	
			
				--spawn a Unit
				Spring.CreateUnit("gLava",posX,posY,posZ, 0, teamID)  
	else
				posX,  posY , posZ,_,_,_ =Spring.GetUnitPiecePosDir(unitID,lSpawner[4])	
			posY=Spring.GetGroundHeight(posX,posZ)	
				
				--spawn a Unit
				Spring.CreateUnit("gLava",posX,posY,posZ, 0, teamID)  
	end
for i=1,4,1 do
randspeed=math.random(0.3,3)
Move(lSpawner[i],y_axis,-9,randspeed)
end
WaitForMove(lSpawner[4],y_axis)
end
end



function showAllTheObjects()
	for i=1,4,1 do

	Show(lavaLingus[i])
	Hide(LavaPyre)
	Hide(outSky)
	Hide(inSky)
	end
	for i=1,3,1 do
	Show(lPyre[i])
	end
	
           
			
	
			 Show(LavaWheelie)
			 
			 Show(lavaCircle) 
			  
             Show(lavabubbles)     
            
             Show(volcaNooo)     
             Show(lavaCov1)     
             Show(lavaCov2)     
             Show(lavaCov3)     
             Hide(shatterSphere)     
         
            
			    
          
		
	
	

end
function foreverBlowinBubbles()
Show(lavabubbles)
Move(lavabubbles,y_axis,-4,0)
Move(lavabubbles,y_axis,0,0.5)
WaitForMove(lavabubbles,y_axis)
Hide(lavabubbles)
end

function emitit()
SetSignalMask(SIG_LIGHT)
	while(true)do
	Sleep(60)
	EmitSfx(shatterSphere,1032)
	end
end

function bubbles()
	while(true) do
	diceBeNice=math.random(0,7)
		if diceBeNice==1 or diceBeNice==5 then
		StartThread(foreverBlowinBubbles)
		end
	Sleep(380)
	end
end


function volCanos()

for i=1,4,1 do
Hide(lSpawner[i])
end

Hide(lavaBomb)
degreeTurn=(math.random(0,3))*90
Turn(center,y_axis,math.rad(degreeTurn),0)

showAllTheObjects()
StartThread(playSoundFiles)
Show(lavaCov3)
Show(lavaCov2)
Show(lavaCov1)
Show(volcaNooo)
StartThread(lavaProps)

--preEruptionPhase
StartThread(fromDust)
--MoveUpMountain
Move(center,y_axis,0,3.2)

Sleep(shakeTime)
--CameraShake (made by Beherith)
--DustExplosion...+Pieces Earth
StartThread(fromDust)
Sleep(900)
EmitSfx(eruptionArray[1],1033)
for i=1,18,1 do
Explode((eruptionArray[i]),SFX.SMOKE+SFX.FIRE+SFX.FALL+SFX.EXPLODE_ON_HIT)
Hide(eruptionArray[i])
end

Hide(lavaCov3)
StartThread(firexWorX)
--LavaBombs..
StartThread(LavaBomberMan)
--Fire...(SkyHigh)+ Sparks and Bombs
StartThread(smokeOnTheHeight)
Sleep(400)
	for i=8,21,1 do
		EmitSfx(skyEmitters[i], 1027)
	end
Sleep(800)
Show(inSky)
--Show(outSky)
StartThread(PyreMover)
StartThread(fireWhoreX)
--Smoke (Unhide SmokeClouds)
--Unhide the Pyle
Show(LavaPyre)
--Eruption
StartThread(emitit)

-->Deckeldecider-> Fork Detail Threads 
coverBlown=math.random(0,3)
if coverBlown==1 then
Explode(lavaCov1, SFX.FALL)
Hide(lavaCov1)
elseif coverBlown==2 then
Explode(lavaCov1, SFX.FALL)
Explode(lavaCov2, SFX.FALL)
Hide(lavaCov1)
Hide(lavaCov2)
elseif coverBlown==3 then
Explode(lavaCov1, SFX.FALL)
Explode(lavaCov2, SFX.FALL)
Explode(lavaCov3, SFX.FALL)
Hide(lavaCov1)
Hide(lavaCov2)
Hide(lavaCov3)
end
WaitForMove(center,y_axis)
		     Show(lavawheel1)     
           
             
			 Show(lavawheel2)     
           
			 Show(lavawheel3)     
			
			 Show(lavawheel4)   
--SpawnLavaUnits
StartThread(spawnLavaUnits)
StartThread(bloodAndAshes)

--ContinuedActivity


--Sparks and Ashes
Sleep(totalErruptionTime)
StartThread(bubbles)
--Pyreflames going downwards..
boolLactoseIntolerantVolcano=false
--Aftermath
Sleep(120)
Move(LavaPyre,y_axis,-133,89)
Hide(outSky)
Hide(inSky)
while(true==Spring.UnitScript.IsInMove(LavaPyre, y_axis)) do
	for i=1,8,1 do
	EmitSfx(skyEmitters[i],1026)
	EmitSfx(skyEmitters[i],1027)
	end
Sleep(50)
end
boolCoverUp=false
boolDarkCloudUp=false
Signal(SIG_LIGHT)
Hide(LavaPyre)
Sleep(90000)
--pyrecollaps(SmokeEmitEnd)
-- Fire im Cylinder
-- Shatter Lava Sphere
--Lava Tongue Circle
--Lava versiegt..
Move(lavaCircle,y_axis,-30,0.25)
WaitForMove(lavaCircle,y_axis)
Signal(SIG_SPAWN)

Hide(lavaCircle)
quietSomeTime=math.random(8000,26000)
Sleep(quietSomeTime)

Move(center,y_axis,-40,0.5)
x,y,z=Spring.GetUnitPosition(unitID)
Spring.CreateFeature( "lavafeature2" ,  x,  y,  z)
Spring.DestroyUnit (unitID,true,true)
					 
--Mountain collapses
--spawns feature..
end




function volCanIcActivitys()
while(true) do
shall=math.random(0,1)
if shall==1 then
StartThread(foreverBlowinBubbles)
end


Sleep(150)
end
end

function script.Create()
x,y,z=Spring.GetUnitPosition(unitID)
size=42
if GG.DynDefMap == nil then GG.DynDefMap={} end
if GG.DynRefMap == nil then GG.DynRefMap={} end
GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="borderblur"}
GG.DynRefMap[#GG.DynRefMap+1]=	preparhalfSphereTable(size, 4)
GG.boolForceLandLordUpdate=true


for i=1,4,1 do
	Hide(lSpawner[i])
	Hide(lavaLingus[i])

	end
	for i=1,3,1 do

	Hide(lPyre[i])
	end
	
             Hide(lavawheel1)     
             Spin(lavawheel1,x_axis,math.rad(-13),0.05)
             Spin(LavaPyre,y_axis,math.rad(18),0.5)
			 Hide(lavawheel2)  
			 
             Spin(lavawheel2,z_axis,math.rad(-30),0.05)
      
			 Hide(lavawheel3)     
			 Spin(lavawheel3,x_axis,math.rad(13),0.05)
			 
			 Spin(lavawheel4,z_axis,math.rad(30),0.05)
			 Hide(lavawheel4)     
			 Spin(outSky,y_axis,math.rad(12),0.4)
			 Spin(inSky,y_axis,math.rad(14),0.4)
			
             Move(center,y_axis,-21,0)
			 Hide(LavaWheelie)   
			 xol=math.random(10,40)
			 Spin(LavaWheelie,x_axis,math.rad(xol),0.2)
             
			 xol=math.random(10,40)
			 Spin(LavaWheelie,z_axis,math.rad(xol),0.2)
			 xol=math.random(1,4)
			 Spin(LavaWheelie,y_axis,math.rad(xol),0.2)
			 
			 Hide(lavaCircle) 
			 Spin(lavaCircle,y_axis,math.rad(-3),0.05)			 
             Hide(lavabubbles)     
          
             Hide(volcaNooo)     
             Hide(lavaCov1)     
             Hide(lavaCov2)     
             Hide(lavaCov3)     
             Hide(shatterSphere)     
             
          
			   
                  
volCanos()
end
