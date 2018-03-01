include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_jw.lua"
include "lib_Build.lua"


sporeRange=235
attaPoint=piece"attaPoint"
swingersClub=piece"swingersClub"
local AttachUnits = Spring.UnitScript.AttachUnit
local DropUnits = Spring.UnitScript.DropUnit
boolImAGoldenSpore = (Spring.GetUnitDefID(unitID) == UnitDefNames["jgoldspore"].id)

timeTillFirstSymptoms= math.random(6,12)*1000 --this is health dependant
health1Second= 300

incubationStart= math.random(-2,2)*1000 --start of infection 
totalFungiGrowTime=5000
teamID= Spring.GetUnitTeam(unitID)
boolOutlier = fairRandom(teamID.."jFungiOutlier", 0.3)
boolComeCloser= fairRandom(teamID.."jFungiComeCloser", 0.5)

outLierTime= math.random(60,120)*1000


function incubationThread(id,defID)
	if boolOutlier== true then 
		Sleep(outLierTime)
	end
	moduloCeg= (defID %6)+1
incubtionSleep= math.max(0,math.ceil(timeTillFirstSymptoms+incubationStart))
Sleep(incubtionSleep)

	while true do
		x,y,z=Spring.GetUnitPosition(unitID)
		T= getAllInCircle(x,z, sporeRange, unitID)
		T= process(T,
					function(id)
						vicDefID= Spring.GetUnitDefID(id)
							if not imuneUnitTypes[vicDefID] then
								delayedSound(vicDefID)
								if boolImAGoldenSpore == true then
									return id
								else
									if vicDefID == defID then
										return id
									end
								end
							end
						end,
					function(id)
						if not GG.Spore then GG.Spore={} end
						
						GG.Spore[#GG.Spore+1] ={}
						GG.Spore[#GG.Spore] = id				
					end
						)
						
		
	Sleep(50)
	tx=(math.random(1,20)%8)+1
		if boolImAGoldenSpore== true then
			spawnCegAtPiece(unitID, spores[tx][3],"orangespores")
		else
			spawnCegAtPiece(unitID, spores[tx][3],"spore"..moduloCeg)
		end

	end
end

function symptomThread(id,defID)
	if boolOutlier== true then 
		Sleep(outLierTime)
	end
	Sleep(timeTillFirstSymptoms)
	Spring.SetUnitNoSelect(id,true)
	StartThread(comeCloser, boolComeCloser)

--unfoldFungi while Unit still moves -- no select
	StartThread( unfoldFungi,id,totalFungiGrowTime)
	halfTime=math.ceil(totalFungiGrowTime/2)
	Sleep(halfTime)
--stunned
	stunUnit(id, totalFungiGrowTime/2)
	Sleep(halfTime)
--death
	Sleep(totalFungiGrowTime)
	Spring.DestroyUnit(id,true,false)
	Spring.DestroyUnit(unitID,true,false)
end

-- wish to come close to others 
function comeCloser(boolComeCloser)
	if boolComeCloser == true then
		ad=Spring.GetUnitNearestAlly(id)
			if ad then
			ax,ay,az=Spring.GetUnitPosition(ad)
				if ax then
					Spring.SetUnitMoveGoal(id,ax,ay,az)
				end
			end
	end
end


spores={}
spheres={}
for o=1,9, 1 do
	
	spores[o]={}
	for i=1,3,1 do
		
		spores[o][i]={}
		tempPiece="ext"..o
		tempPiece=tempPiece..i
		spores[o][i]=piece(tempPiece)
		
	end
	spheres[o]={}
	tem="extsphere"..o
	spheres[o]= piece (tem)
end


function randomizedTurn(p, timeInMs)
	x=math.random(0,360)
	y=math.random(0,360)
	z=math.random(0,360)
	tSyncIn(p,x,y,z,timeInMs)	
end

local spGetUnitDefID=Spring.GetUnitDefID

function limrandomizedTurn(piece, timeInMs)
	x=math.random(-15,15)
	y=math.random(-15,15)
	z=math.random(-15,15)
	tSyncIn(piece,x,y,z, timeInMs)
	
end

imuneUnitTypes= getFungiImuneUnitTypeTable(UnitDefNames)
infantryTypeTable= getInfantryTypeTable()

function delayedSound(tDefID)
	if infantryTypeTable[tDefID] then
		StartThread(PlaySoundByUnitDefID, "sounds/jfungiforrest/infantryfungi.wav",0.5, 3000, 2)
	else
		StartThread(PlaySoundByUnitDefID,"sounds/jfungiforrest/fungi.wav",0.5, 3000, 2)
	end	
end

function unfoldAnimation(timeForMovement)
Show(spheres[1])
timeForMovement= math.ceil(timeForMovement/9)
edges= {}
resetT(TableOfPieceGroups["fruit"])
	for o=1,9, 1 do
		randomizedTurn(spheres[o],timeForMovement)
		Show(spheres[o])
		for i=1,3,1 do
			Show(spores[o][i])				
			limrandomizedTurn(spores[o][i],math.ceil(timeForMovement/3))
			if i > 1 then
				speedySpeeSpeedySpoo=math.random(81,120)/100
				mSyncIn(spores[o][i],0,0,4.2,math.ceil(timeForMovement/3))
				edges[#edges+1]=spores[o][i]
			end
		end
		
	end
	for o=1,9, 1 do
		WaitForTurns(spheres[o])

		for i=1,3,1 do
			WaitForTurns(spores[o][i])
			WaitForMoves(spores[o][i])		
		end		
	end
	if maRa()== true then
		bx,by,bz= Spring.GetUnitBasePosition(unitID)
		for i=1,#TableOfPieceGroups["fruit"] do
			ike=TableOfPieceGroups["fruit"][i]
			target= edges[math.random(1,#edges)]
			wx,wy,wz = Spring.GetUnitPiecePosDir(unitID,target)
			MovePieceToPos(ike, -1*(bx-wx),-1*(by-wy)-15,-1*(bz-wz),0)
			r=math.ceil(math.random(150,750))
			Sleep(r)
			Show(ike)
			turnPieceRandDir(ike,0, 360, 0, 360,0, 360, 0)
		end
	end
		

end

SparedTable={}
function unfoldFungi(RottenToTheCore,timeForMovement)
	
	
	for o=1,9, 1 do
		for i=1,3,1 do
			Hide(spores[o][i])
		end
		Hide(spheres[o])
	end
	Spring.SetUnitAlwaysVisible(RottenToTheCore,true)
	x,y,z=Spring.GetUnitPosition(RottenToTheCore)
	rand=math.random(-15,15)
	Spin(swingersClub,y_axis,math.rad(rand),0.25)
	Spin(attaPoint,y_axis,math.rad(-rand),0.25)
	Spring.MoveCtrl.Enable(unitID,true)
	
	biggestPiece= getUnitBiggestPiece(RottenToTheCore)
	StartThread(unfoldAnimation,timeForMovement)
	
	while Spring.GetUnitIsDead(RottenToTheCore)==false  do
		--Move Fungi to Biggest Piece
		dx,dy,dz=0,0,0
		if biggestPiece then
			dx,dy,dz= Spring.GetUnitPiecePosDir(RottenToTheCore,biggestPiece)
		else
			dx,dy,dz=Spring.GetUnitPosition(RottenToTheCore)
			dy=dy+25
		end
		rox,roy,roz=Spring.GetUnitRotation(RottenToTheCore)
		Spring.MoveCtrl.SetRotation(unitID,-rox,-roy,-roz)
		Spring.MoveCtrl.SetPosition(unitID,dx,dy,dz)
		Sleep(10)	
	end
		Spring.DestroyUnit(unitID,true,false)
	
end

boolThreadStart=false
local idHandle="NotAnID"
local hostDefID= "NotAnDefID"

function lifeTimer()
Sleep(3000)
	if idHandle == "NotAnID" then
	Spring.DestroyUnit(unitID,true,true)
	end

end
function handsUpAhemDown(iCanHandleThis)
	idHandle=iCanHandleThis
	hp= Spring.GetUnitHealth(iCanHandleThis)
	if hp then timeTillFirstSymptoms= math.ceil(hp/health1Second) end
	boolThreadStart=true
end

function threadStartLoop()
	while(true) do
		if boolThreadStart==true then 
			boolThreadStart=false 
			hostDefID=spGetUnitDefID(idHandle)
			StartThread(incubationThread,idHandle,hostDefID)
			StartThread(symptomThread,idHandle,hostDefID)

		end
		Sleep(100)
	end
	
end

TableOfPieceGroups={}
function script.Create()
	Spring.SetUnitNeutral(unitID,true)
	Spring.SetUnitAlwaysVisible(unitID,true)
	Spring.SetUnitBlocking(unitID,false)
	Spring.SetUnitNoSelect (unitID, true)
	
	TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	hideT(TableOfPieceGroups["fruit"])
	StartThread(threadStartLoop)
	StartThread(lifeTimer)

end

function script.Killed()
	
	return 0
end