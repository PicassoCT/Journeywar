include "suddenDeath.lua"
include "toolKit.lua"

SIG_ATTACKED=2
SIG_DELAYEDSTOP=4

piecesTable={}
currentPiece=1
-- piece -->AttachPoints
AttachPoints={}

--unitID-->piece
if not GG.BoundVaryFoos then GG.BoundVaryFoos={} end

boolComplete=false
boolUnderAttack=false

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
boolUnderAttack=true
Signal(SIG_ATTACKED)
StartThread(resetAttack)
end

boolBuildEnded=false

function partOfShipPartOfCrew( point, VaryFooID)
Spring.SetUnitNeutral(VaryFooID,true)
Spring.MoveCtrl.Enable(VaryFooID,true)
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
roX,roY,roZ=0,0,0

	while boolBuildEnded == false do
	tx,ty,tz=spGetUnitPiecePosDir(unitID,VaryFooID)
	Spring.MoveCtrl.SetPosition(VaryFooID,tx+math.random(-5,5),ty,tz+math.random(-5,5))
	Spring.MoveCtrl.SetRotation(VaryFooID,roX, roY,roZ)
	roX,roY,roZ=roX+math.random(-0.01,0.01),roY+math.random(-0.01,0.01),roZ+math.random(-0.01,0.01)
	Sleep(500)
	end

Spring.SetUnitAlwaysVisible(VaryFooID,false)
Spring.DestroyUnit(VaryFooID,true,true)
end

nrAdded=0
nrNeeded=#AttachPoints

function sortPiecesByHeight(ableStableTableOfBabelEnable)
bucketSortList={}

	for i=1,#ableStableTableOfBabelEnable do
	px,py,pz=spGetUnitPiecePosDir(unitID,ableStableTableOfBabelEnable[i])
		if not bucketSortList[math.ceil(py)] then 
			bucketSortList[math.ceil(py)]={}
		end
	end
	sortedTable={}
	index=1
	for k,v in pairs(bucketSortList) do
		if type(v)=="number" then
		sortedTable[index]=ableStableTableOfBabelEnable[v]
		else
			for i=1,#v do
				sortedTable[index]=ableStableTableOfBabelEnable[v[i]]
			end
		end
	end
	return sortedTable
end


function raiseAvatara()
hideT(piecesTable)
AttachPoints=sortPiecesByHeight(AttachPoints)
indexP=1
hx,hy,hz=spGetUnitPiecePosDir(unitID,AttachPoints[indexP])
base=Spring.GetGroundHeight(hx,hz)
DistanceDown=base-hy
Move(center,y_axis,DistanceDown,0)
MoveCtrl.Enable(unitID,true)
	while nrAdded < nrNeeded do
	Move(center,y_axis,DistanceDown*(nrAdded/nrNeeded),1.5)
	--check VaryFoos around you
	allVaryFoos={}
	
		if boolUnderAttack==true then
			--defend moma
			ax,ay,az=Spring.GetUnitNearestEnemy(unitID)
			for i=1,#allVaryFoos do
			if not GG.BoundVaryFoos[allVaryFoos[i]] then
					Spring.SetUnitMoveGoal(allVaryFoos[i],ax,ay,az)		
			end
			end
	
		else --build on
		--get nextPiece above ground
		attachP=AttachPoints[math.min(indexP,#AttachPoints)]
		indexP=indexP+1
		
		x,y,z=Spring.GetUnitPiecePosDir(unitID,attachP)
			for i=1,#allVaryFoos do
			
				ux,uy,uz=Spring.GetUnitPosition(allVaryFoos[i])
				if (ux-x) *(uy-y)* (uz-z) < 50 then --integrate it into the Avatara
					if not GG.BoundVaryFoos[allVaryFoos[i]] then
					StartThread(partOfShipPartOfCrew, attachP, allVaryFoos[i])
					end
				else
					Spring.SetUnitMoveGoal(allVaryFoos[i],x,y,z)	
				end
			end
		end
	
	end
	MoveCtrl.Enable(unitID,false)
	boolBuildEnded=true
	boolComplete=true
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
	
function resetAttack()
SetSignalMask(SIG_ATTACKED)
Sleep(10000)
boolUnderAttack=false
end

function script.Create()
generatepiecesTableAndArrayCode(unitID)
StartThread(raiseAvatara)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end



function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

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

function script.QueryBuildInfo() 
  return center 
end

function script.QueryNanoPiece()
     return center
end

