--This is the Water Extractor Script - it decrements the water once per minute by the given global Amount..
--<variables>
g_WaterOffSet=0
g_ReductionRate=0.025
--</variables>
--<pieces>
center= piece"center"
local portal= 		piece"portal"
local portal1=   piece"portal1"
local portal2=   piece"portal2"
local portal0=   piece"portal0"
local portal3 =  piece"portal3"
local dcemit0 =  piece"dcemit0"
local dcemit1 =  piece"dcemit1"
local dcemit2 =  piece"dcemit2"
local dcemit3 =  piece"dcemit3"

pMecha={}
for i=1,5,1 do
pMecha[i]={}
pMecha[i+5]={}
dusty= "pmech"..i
pMecha[i]=piece (dusty)
pMecha[i+5]=false
end
function winWeap(howOften)
for i=1,howOften,1 do
Spring.PlaySoundFile("sounds/cWaterExtractor/winweap.wav")
sleeptime=math.random(1700,5000)
Sleep(sleeptime)


end
end

function playSound()
local spPlaySoundFile=Spring.PlaySoundFile
while(true) do
xi=math.random(1,4)
StartThread(winWeap,xi)
spPlaySoundFile("sounds/cWaterExtractor/sucking.wav")
Sleep(16000)
fallSilentForAWhile=math.random(0,1)
if fallSilentForAWhile==1 then
Sleep(22000)
end

end
end

function crypticMechanism()
while true do
		for i=1,5,1 do
			if pMecha[i+5]==false then
			pMecha[i+5]=true
			posNeg=math.random(-1,1)
			speed=math.random(12,240)
			if posNeg==0 then
			posNeg=-1
			end
			Spin(pMecha[i],y_axis,math.rad(posNeg*speed),0.5)
			--spin it

			else
			randomice=math.random(0,1)
			--end spin
			if randomice==1 then
			StopSpin(pMecha[i],y_axis,0.5)
			Sleep(300)
			pMecha[i+5]=false
			end
			
			end
		end
		Spring.PlaySoundFile("sounds/cWaterExtractor/mechaCharchingUp.wav")
howLong=math.random(12000,42000)
Sleep(howLong)
end
end

function emitSFX()
 unitX,unitY,unitZ= Spring.GetUnitPosition(unitID)

local spGetUnitPiecePosition=Spring.GetUnitPiecePosition
local spSpawnCEG=Spring.SpawnCEG
		
				
		
	while(true) do
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal1" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal2" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal3" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal0" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
	
	
	
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit0" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit1" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit2" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit3" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
	Sleep(500)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal1" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal2" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal3" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal0" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
	
	
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit0" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit1" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit2" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit3" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)


	Sleep(500)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal1" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal2" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal3" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"portal0" )
			spSpawnCEG("cwaterextOrange",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
	
	
	
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit0" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit1" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit2" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
			local CemitX,CemitY,CemitZ=spGetUnitPiecePosition(unitID,piece"dcemit3" )
			spSpawnCEG("cwaterext",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)

	Sleep(500)
	end
end


function decoRation()
while(true) do
Sleep(400)
end
end

function addWaterLvl()
while(true) do
	if GG.subWaterLevel ~= nil then

	GG.subWaterLevel=GG.subWaterLevel+ g_ReductionRate
	Sleep(1000)

	else
	Sleep(1000)
	end
end

end

function killMeSoftly()
local x,y,z=Spring.GetUnitPosition(unitID)
local spGetGroundHeight=Spring.GetGroundHeight
while(true) do

y=spGetGroundHeight(x,z)
	if y > 0 then
	Spin(center,y_axis,math.rad(192),0.01)
	Sleep(9000)
	Spring.DestroyUnit(unitID,false,false)
	end
Sleep(3141)
end
end

function script.Create()
Spin(portal,y_axis,math.rad(70),0.5)
StartThread(addWaterLvl)
StartThread(decoRation)
StartThread(emitSFX)
StartThread(crypticMechanism)
StartThread(killMeSoftly)
StartThread(playSound)
end

--if the LandLordGadget triggers this function, it has read the WaterLevelChange
function reciveWaterReSet(boolReSet)
	if boolReSet==true then
	g_WaterOffSet=0
	end

end



function script.killed()
EmitSfx(portal,1026)
Sleep(350)
EmitSfx(portal,1026)
Sleep(300)
EmitSfx(portal,1031)
EmitSfx(pMecha[1],1024)
Sleep(150)
EmitSfx(pMecha[2],1024)
Sleep(150)
EmitSfx(pMecha[3],1024)
Sleep(150)
return 1
end