include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 


SIG_ATTACKED=2
SIG_DELAYEDSTOP=4
RAM_DAMAGE=250

center = piece"center"
piecesTable= {}
currentPiece=1
-- piece -->AttachPoints
AttachPoints=makeTableOfNames("aPoint",1,30)
for i=1,30 do
	AttachPoints[i]= piece(AttachPoints[i])
end


--unitID-->piece
if not GG.BoundVaryFoos then GG.BoundVaryFoos={} end

boolUnderAttack=false

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	boolUnderAttack=true
	Signal(SIG_ATTACKED)
	StartThread(resetAttack)
end

boolBuildEnded=false
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
AttachedUnits={}
function partOfShipPartOfCrew( point, VaryFooID)
	Spring.SetUnitNeutral(VaryFooID,true)
	Spring.UnitScript.AttachUnit(point,VaryFooID)
	AttachedUnits[VaryFooID]=true
	
	
	
	while boolBuildEnded == false do
		tx,ty,tz=Spring.GetUnitDirection(VaryFooID)
		roX,roY,roZ=tx+math.random(-100,100)/1000,		ty+math.random(-100,100)/1000,		tz+math.random(-100,100)/1000
		Spring.SetUnitDirection(VaryFooID,roX, roY,roZ)
		Sleep(500)		
	end
	
	if boolBuildEnded == false then	
		
		Spring.UnitScript.DropUnit(VaryFooID)
		AttachedUnits[VaryFooID]=nil
	end
end

nrAdded=0

	varyTaraID=UnitDefNames["jvaryavatara"].id
	nrNeeded= tonumber(UnitDefs[varyTaraID].customParams.varyfooneeded)

function buildMoma(varyFooos)
	
	
	frame=Spring.GetGameFrame()
	x,y,z=Spring.GetUnitPiecePosDir(unitID,center)
	for i=#varyFooos,1,-1 do	
		
		if Spring.ValidUnitID(varyFooos[i])== false or Spring.GetUnitIsDead(varyFooos[i])==true then
			table.remove(varyFooos,i)
		else					
			indexP=(indexP %#AttachPoints)+1 
			if distanceUnitToUnit(unitID,varyFooos[i] ) < 75 and not AttachedUnits[varyFooos[i]] then --integrate it into the Avatara
				nrAdded=nrAdded+1
				StartThread(partOfShipPartOfCrew, AttachPoints[indexP], varyFooos[i])
				
			else
				ox,oz= RotationMatrice(0,50+ (varyFooos[i]%120),((varyFooos[i]*150)%3000)+frame/64)
				Spring.SetUnitMoveGoal(varyFooos[i],x+ox,y,z+oz)									
			end
		end
	end
end

function defendMoma(varyFooos)
	for k,v in ipairs(	AttachedUnits) do
		Spring.UnitScript.DropUnit(k)
		AttachedUnits[k]=nil
	end
	nrAdded=0
	
	ed=getNearestGroundEnemy(unitID,UnitDefs)
	if ed then
		ax,ay,az=Spring.GetUnitPosition(ed)
		for i=1,#varyFooos do
			Spring.SetUnitMoveGoal(allVaryFoos[i],ax,ay,az)		
		end
	end	
end

function spinTentacles()
	tentacles=pieceNameGroupTable["tentacle"]
	while true do
		randVal=math.random(500,2000)
		Sleep(randVal)
		speed=math.random(2,35)/10
		spinT(tentacles,y_axis,speed,-42,42)
	end
end

function filterNonVaryfoos(id)
	if Spring.GetUnitDefID(id)== VaryFooDefID then 
		return id 
	end 
end

VaryFooDefID=UnitDefNames["jvaryfoo"].id

pieceNameGroupTable=makePiecesTablesByNameGroups(false,true)
function raiseAvatara()
	StartThread(spinTentacles)
	
	hideT(piecesTable)
	frame=Spring.GetGameFrame()
	minMergeTimeComplete=frame +2048
	
	indexP=1
	
	DistanceDown=-150
	Move(center,y_axis,DistanceDown,0,true)
	while nrAdded < nrNeeded do
		
		
		
		Move(center,y_axis, math.min(0,DistanceDown*(1-(nrAdded/nrNeeded))),7.5)
		--check VaryFoos around you
		ux,uy,uz=Spring.GetUnitPosition(unitID)
		units=getAllInCircle(ux,uz,300)
		allVaryFoos=process( units,
		filterNonVaryfoos
		)
		echo("jvaryavatara::nrNeeded"..nrNeeded.." / nrAdded"..nrAdded.." / NrOfFoos"..#units)
		if boolUnderAttack==true then
			--defend moma
			defendMoma(allVaryFoos)
			hideT(piecesTable)
		else --build on
			--get nextPiece above ground
			buildMoma(allVaryFoos)
			
		end
		Sleep(350)
	end
	Move(center,y_axis,0,2.5)
	times=math.ceil(9000/#piecesTable)
	for i=1,#piecesTable do
		Show(piecesTable[i])
		Sleep(times)
	end
	Sleep(9000)
	WMove(center,y_axis,0,2.5)
	for k,v in pairs(AttachedUnits) do
		Spring.DestroyUnit(k,false,true)
	end
	boolBuildEnded=true
	Move(center,y_axis,0,12)
	showT(piecesTable)
	StartThread(moveAble)
end

boolAimingAndFiringWeapon2=false
function moveAble()
	while true do
		if boolMoving ==true then
			moveAnimation()
		else
			StandingAnimation()
			while boolAimingAndFiringWeapon2==true do
				--Keep it steady
				Sleep(300)
			end
		end
		Sleep(200)
	end
end


function moveAnimation()
	Sleep(100)
end

function StandingAnimation()
	resetT(piecesTable,5)
end
function resetAttack()
	SetSignalMask(SIG_ATTACKED)
	Sleep(10000)
	boolUnderAttack=false
end

function script.Create()
	spinT(AttachPoints,y_axis,4.2,-42,42)

	piecesTable=generatepiecesTableAndArrayCode(unitID)
	hideT(piecesTable)
	StartThread(raiseAvatara)
end

function script.Killed(recentDamage,_)
	
	createCorpseJUnitGeneric(recentDamage)
	return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end


pods=pieceNameGroupTable["Pod"]
indexPod=1
function script.QueryWeapon1() 
	return pods[indexPod]
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy´
	return true
	
end

function delayedRegrowth(number)
	Hide(pods[number])	
	Sleep(4500)
	Show(pods[number])
	
end
function script.FireWeapon1()
	StartThread(delayedRegrowth,indexPod)
	
	indexPod=(indexPod%#pods)+1
	return true
end
aimspot=piece"aimspot"
function script.QueryWeapon2() 
	return aimspot
end
boolReadyAim=true 
function takeUpArms(arm1,arm2, pitch)
Turn(arm2,x_axis,math.rad(53),3)
WTurn(arm1,x_axis,math.rad(-53)-pitch,3)
end

	AimArmTable=pieceNameGroupTable["AimArmF"]
function script.AimWeapon2( Heading ,pitch)	
if boolReadyAim==true then

	takeUpArms(AimArmTable[1],AimArmTable[2],pitch)
	takeUpArms(AimArmTable[3],AimArmTable[4],pitch)
	return true
else 
return false
end	
end

function fireAnimation(readyAim)
boolReadyAim=false
moveT(pieceNameGroupTable["chain"],z_axis,75,60)
unitsAffected=getAllNearPiece(unitID,pieceNameGroupTable["ram"][1],50)
process(unitsAffected,
		function(id) 
		Spring.AddUnitDamage(id,RAM_DAMAGE)
		end
		)
Sleep(1200)
if readyAim==true then
resetT(pieceNameGroupTable["chain"],35,true) 
resetT(AimArmTable,4,true) 
boolReadyAim = true 
end
end


function script.FireWeapon2()
	StartThread(fireAnimation,AimArmTable[3],AimArmTable[4], true)
	return true
end


boolMoving=false
function script.StartMoving()
	Signal(SIG_DELAYEDSTOP)
	boolMoving=true
end

function DelayedStop()
	Signal(SIG_DELAYEDSTOP)
	SetSignalMask(SIG_DELAYEDSTOP)
	Sleep(500)
	boolMoving=false
end

function script.StopMoving()
	StartThread(DelayedStop)		
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end