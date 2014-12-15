include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"

piecesTable={}
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
Egg = piece"Egg"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Egg
Base = piece"Base"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Base

BUILDPROGRESS=0.0001
Down=-208
function script.Create()
Spring.SetUnitBlocking(unitID,false)
Hide(Base)
Hide(Egg)
Move(center,y_axis,Down,0)
StartThread(catchAndUpdateBP)
StartThread(fourMinsMax)
StartThread(doSomething)
end

function identifyUnit()
searchRange=15
x,y,z=Spring.GetUnitPosition(unitID)
TableTop={}
TableTop=Spring.GetUnitsInCylinder(x,z,searchRange)
table.remove(TableTop,unitID)
--itterate throught table, searching a familiar building
if TableTop == nil then return end
if #TableTop == 1 then return TableTop[1] end

	for i=1,table.getn(TableTop),1 do
	health,   maxHealth,   paralyzeDamage, captureProgress,   buildProgress=Spring.GetUnitHealth(TableTop[i])
		if buildProgress and buildProgress < 1 or health/maxHealth < 1 then
		return TableTop[i]
		end
	end
end

local buildID = "none"

function updateBuildProgress()
while not buildID or buildID == "none"  do
buildID=identifyUnit()
Sleep(200)
end

 _,_,_,_,bP= Spring.GetUnitHealth(buildID)

	 if bP== nil then return 0.001 else return bP end
	
end

function catchAndUpdateBP()
while true do
Sleep(1500)
BUILDPROGRESS=updateBuildProgress()
end
end

function script.Killed(recentDamage,_)


return 1
end
SIG_BUILD=2
function doSomething()

Show(Egg)

SetSignalMask(SIG_BUILD)
	while BUILDPROGRESS < 0.4 do
	distance= Down* (1-(BUILDPROGRESS/0.4))
	Move(center,y_axis,distance,3)
	WaitForMove(center,y_axis)
	Sleep(500)
	end
signum=-1
currently=1
Move(center,y_axis,0,3)
StartThread(randomRotate,Egg,y_axis,0.03,-5,5)
StartThread(randomRotate,Egg,x_axis,0.03,-15,15)
StartThread(randomRotate,Egg,z_axis,0.03,-5,5)
Show(Base)
	while true do
	resetPiece(center,0.02)
	Sleep(4000)
	currently=currently*signum
	Up=math.random(0,35)*currently
	Move(center,y_axis,Up,0.3)
	Move(Base,y_axis,-Up,0.3)
	StopSpin(Egg,y_axis,0.1)
	Spin(Egg,y_axis,math.rad(math.random(3*signum,4*signum^2)),1.1)
	Spin(Base,y_axis,math.rad(math.random(3*signum,4*signum^2)),1.1)
	
	Sleep(4000)
	end
end

function fourMinsMax()
Sleep(280000)
Signal(SIG_BUILD)
Move(center,y_axis,-1000,0.5)
WaitForMove(center,y_axis)
Spring.DestroyUnit(unitID,true,false)
end


function script.StartMoving()

end

function script.StopMoving()
		
		
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

