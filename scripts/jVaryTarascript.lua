include "createCorpse.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 


SIG_ATTACKED=2
SIG_DELAYEDSTOP=4


  piecesTable={}
  piecesTable[#piecesTable+1]= piece("center");center= piece("center")
  piecesTable[#piecesTable+1]= piece("varytara.3DS");varytara3DS= piece("varytara.3DS")
  piecesTable[#piecesTable+1]= piece("AimArm002");AimArm002= piece("AimArm002")
  piecesTable[#piecesTable+1]= piece("AimArm1");AimArm1= piece("AimArm1")
  piecesTable[#piecesTable+1]= piece("AimArmF003");AimArmF003= piece("AimArmF003")
  piecesTable[#piecesTable+1]= piece("AimArmF2");AimArmF2= piece("AimArmF2")
  piecesTable[#piecesTable+1]= piece("Body2");Body2= piece("Body2")
  piecesTable[#piecesTable+1]= piece("Body3");Body3= piece("Body3")
  piecesTable[#piecesTable+1]= piece("Body4");Body4= piece("Body4")
  piecesTable[#piecesTable+1]= piece("Body5");Body5= piece("Body5")
  piecesTable[#piecesTable+1]= piece("Body6");Body6= piece("Body6")
  piecesTable[#piecesTable+1]= piece("FootF003");FootF003= piece("FootF003")
  piecesTable[#piecesTable+1]= piece("FootF004");FootF004= piece("FootF004")
  piecesTable[#piecesTable+1]= piece("FootF005");FootF005= piece("FootF005")
  piecesTable[#piecesTable+1]= piece("FootF006");FootF006= piece("FootF006")
  piecesTable[#piecesTable+1]= piece("FootF1");FootF1= piece("FootF1")
  piecesTable[#piecesTable+1]= piece("FootF2");FootF2= piece("FootF2")
  piecesTable[#piecesTable+1]= piece("FrontF003");FrontF003= piece("FrontF003")
  piecesTable[#piecesTable+1]= piece("FrontF004");FrontF004= piece("FrontF004")
  piecesTable[#piecesTable+1]= piece("FrontF1");FrontF1= piece("FrontF1")
  piecesTable[#piecesTable+1]= piece("FrontF2");FrontF2= piece("FrontF2")
  piecesTable[#piecesTable+1]= piece("Kugel01");Kugel01= piece("Kugel01")
  piecesTable[#piecesTable+1]= piece("Kugel011");Kugel011= piece("Kugel011")
  piecesTable[#piecesTable+1]= piece("Kugel02");Kugel02= piece("Kugel02")
  piecesTable[#piecesTable+1]= piece("Kugel03");Kugel03= piece("Kugel03")
  piecesTable[#piecesTable+1]= piece("Kugel04");Kugel04= piece("Kugel04")
  piecesTable[#piecesTable+1]= piece("Kugel05");Kugel05= piece("Kugel05")
  piecesTable[#piecesTable+1]= piece("Kugel06");Kugel06= piece("Kugel06")
  piecesTable[#piecesTable+1]= piece("Kugel07");Kugel07= piece("Kugel07")
  piecesTable[#piecesTable+1]= piece("Kugel08");Kugel08= piece("Kugel08")
  piecesTable[#piecesTable+1]= piece("Kugel09");Kugel09= piece("Kugel09")
  piecesTable[#piecesTable+1]= piece("Kugel10");Kugel10= piece("Kugel10")
  piecesTable[#piecesTable+1]= piece("Line003");Line003= piece("Line003")
  piecesTable[#piecesTable+1]= piece("Line004");Line004= piece("Line004")
  piecesTable[#piecesTable+1]= piece("Line005");Line005= piece("Line005")
  piecesTable[#piecesTable+1]= piece("Line006");Line006= piece("Line006")
  piecesTable[#piecesTable+1]= piece("Line007");Line007= piece("Line007")
  piecesTable[#piecesTable+1]= piece("Line08");Line08= piece("Line08")
  piecesTable[#piecesTable+1]= piece("Line09");Line09= piece("Line09")
  piecesTable[#piecesTable+1]= piece("Linie01");Linie01= piece("Linie01")
  piecesTable[#piecesTable+1]= piece("Linie028");Linie028= piece("Linie028")
  piecesTable[#piecesTable+1]= piece("Objekt003");Objekt003= piece("Objekt003")
  piecesTable[#piecesTable+1]= piece("Objekt02");Objekt02= piece("Objekt02")
  piecesTable[#piecesTable+1]= piece("Sphere017");Sphere017= piece("Sphere017")

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
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
function partOfShipPartOfCrew( point, VaryFooID)
Spring.SetUnitNeutral(VaryFooID,true)
Spring.MoveCtrl.Enable(VaryFooID,true)

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
--generatepiecesTableAndArrayCode(unitID)
StartThread(raiseAvatara)
end

function script.Killed(recentDamage,_)

createCorpseCUnitGeneric(recentDamage)
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

Spring.SetUnitNanoPieces(unitID,{ center})

