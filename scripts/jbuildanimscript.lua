include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

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
--Hide(Base)
--Hide(Egg)
function script.Create()
Spring.SetUnitBlocking(unitID,false)



StartThread(fourMinsMax)
StartThread(doSomething)
end

function identifyUnit()
searchRange=55
x,y,z=Spring.GetUnitPosition(unitID)
TableTop={}
TableTop=Spring.GetUnitsInCylinder(x,z,searchRange)
table.remove(TableTop,unitID)
--itterate throught table, searching a familiar building
if not TableTop or #TableTop == 0 then return end

	for i=1,table.getn(TableTop),1 do
	if Spring.ValidUnitID(TableTop[i]) then
	health,   maxHealth,   paralyzeDamage, captureProgress,   buildProgress=Spring.GetUnitHealth(TableTop[i])
		if buildProgress and buildProgress < 1  then
		return TableTop[i]
		end
	end
	end
end

buildID= "null"
function killMe()
Signal(SIG_BUILD)
Move(Egg,y_axis,-140,30)
WaitForMove(Egg,y_axis)
Spring.DestroyUnit(unitID)

end

function updateBP()
boolDead=Spring.GetUnitIsDead(buildID)
	if boolDead and boolDead==false then
	_,_,_,_,bP= Spring.GetUnitHealth(buildID)
		if bP then return bP else return 1 end
	
	end
return 1 
end

function script.Killed(recentDamage,_)

if buildID and buildID ~="null"and Spring.ValidUnitID(buildID)==true then Spring.SetUnitAlwaysVisible(buildID,true) end
return 1
end
SIG_BUILD=2
function doSomething()

buildID=unitID
counter=0

while counter < 50 and not buildID or buildID== unitID   do
buildID=identifyUnit()
Sleep(100)
counter=counter+1
end
validID= Spring.ValidUnitID(buildID) 
if counter == 50 or not buildID or validID==false  then Move(center,y_axis,-200,30); WaitForMove(center,y_axis);Spring.DestroyUnit(unitID,true,false) return end

Spring.SetUnitAlwaysVisible(buildID,false)

SetSignalMask(SIG_BUILD)


	Move(center,y_axis,Down,0,true)
	Sleep(500)
	
Show(Egg)
Show(Base)

signum=-1
currently=1

StartThread(randomRotate,Egg,y_axis,0.03,-5,5)
StartThread(randomRotate,Egg,x_axis,0.03,-15,15)
StartThread(randomRotate,Egg,z_axis,0.03,-5,5)
Spring.Echo(BUILDPROGRESS)
BUILDPROGRESS=updateBP()
	while BUILDPROGRESS and BUILDPROGRESS < 1 do
	BUILDPROGRESS=updateBP()
	Move(center,y_axis,0,22)

	resetPieceDir(center,0.2)
	Sleep(4000)
	currently=currently*signum
	Up=math.random(0,5)*currently
	Move(Egg,y_axis,Up,3.3)
	Move(Base,y_axis,-Up,0.3)
	StopSpin(Egg,y_axis,0.1)
	Spin(Egg,y_axis,math.rad(math.random(2*signum,3*signum^2)),1.1)
	Spin(Base,y_axis,math.rad(math.random(0.01*signum,0.02*signum^2)),1.1)
	
	Sleep(4000)
	end
	Hide(Egg)
	Sleep(3000)
	Move(Base,y_axis,-50,3)
	WaitForMove(Base,y_axis)
	Spring.SetUnitAlwaysVisible(buildID,true)
	Spring.DestroyUnit(unitID,true,false)
end

function fourMinsMax()
Sleep(280000)
Signal(SIG_BUILD)
Move(center,y_axis,-1000,0.5)
WaitForMove(center,y_axis)
Spring.SetUnitAlwaysVisible(buildID,true)
Spring.DestroyUnit(unitID,true,false)
end


