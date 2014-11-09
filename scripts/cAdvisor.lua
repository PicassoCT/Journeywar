local emitHer=piece "emitHer"
local center=piece "center"
local advisor=piece "advisor"
local advleg1=piece"advleg1"
local advleg2=piece "advleg2"
local advarm1=piece"advarm1"
local advarm2=piece"advarm2"
local advGluePoint=piece"advGluePoint"
local circCenter=piece"circCenter"
local circIcon=piece"circIcon"
local spinMeRightRound=piece"spinMeRightRound"
local fourRealGpoint=piece"fourRealGpoint"
local aheadGetter=piece"aheadGetter"

local attachunit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit

local UnitHealthReduce=2
local orgSensorRad=-50
local currentSensorRad=orgSensorRad
local addUpRad=5
local iconRad=currentSensorRad
local PSIrange=280
local itterator= 1
local SIG_IDLE=2
local SIG_ICON=4
local SIG_WALK=8
local SIG_LEG=16
local boolStillAttackin=false
local booldIdle=true
local boolUnitAttached=false

function idle()
SetSignalMask(SIG_IDLE)
	while(true) do
			if boolIdle==true then


			else
			Sleep(3500)
			boolIdle=true

			end
	Sleep(100)	
	end
end


function script.Create()
StartThread(idle)
StartThread(lightMyFire)
Spin(fourRealGpoint,y_axis,math.rad(-9),0.5)
Spin(circCenter,y_axis,math.rad(9),-0.5)
Move(circIcon,x_axis,-55,0)
Hide(circIcon)
end

function script.Killed()
	

return 1
end

function walk()
SetSignalMask(SIG_WALK)
	while(true) do
	dolo=math.random(0,5)
	if dolo==1 then
	Move(advisor,y_axis,5,0.1)
	elseif dolo==2 then
	Move(advisor,y_axis,0,0.1)
	end
	Turn(advleg1,x_axis,math.rad(-22),6)
	Turn(advleg2,x_axis,math.rad(22),6)
	Turn(advisor,x_axis,math.rad(1.2),0.5)
	WaitForTurn(advleg2,x_axis)	
	WaitForTurn(advleg1,x_axis)
	Turn(advleg1,x_axis,math.rad(22),6)
	Turn(advleg2,x_axis,math.rad(-22),6)
	Turn(advisor,x_axis,math.rad(-0.8),0.5)
	WaitForTurn(advleg2,x_axis)	
	WaitForTurn(advleg1,x_axis)
	end
end

function script.StartMoving()

Signal(SIG_WALK)
StartThread(walk)

end
function legs_down()
SetSignalMask(SIG_LEG)
Sleep(250)
Move(advisor,y_axis,0,3)	
Move(advisor,x_axis,0,3)	
Move(advisor,z_axis,0,3)	

Turn(advisor,y_axis,math.rad(0),6)
Turn(advleg1,x_axis,math.rad(0),6)
Turn(advleg2,x_axis,math.rad(0),6)

 Turn(advisor,x_axis,math.rad(0),9)
end

function script.StopMoving()
Signal(SIG_WALK)
StartThread(legs_down)

	
		
end




	
function  hpCheck()
	boolUnitAttached=true
	hpOfOld=Spring.GetUnitHealth(unitID)
	hpCurrent=hpOfOld
	--attachUnit TODO
		while hpCurrent>=hpOfOld and boolUnitAttached==true do
		
		hpOfOld=hpCurrent
		hpCurrent=Spring.GetUnitHealth(unitID)
		Sleep(250)
		end
	--detachUnit TODO
	boolUnitAttached=false
end	

function returnRandomLastAttacker(UnitTable)
tableOfVolunteers={}
if UnitTable~=nil then
for i=1,table.getn(UnitTable),1 do
	if Spring.GetUnitLastAttacker(UnitTable[i])==unitID then
	table.insert(tableOfVolunteers,UnitTable[i])
	end
end
	if tableOfVolunteers~=nil and table.getn(tableOfVolunteers)> 0 then
	
	theOne=math.random(1,table.getn(tableOfVolunteers))
	return tableOfVolunteers[theOne]
	end
else
end
end

function iconOngraphy()
SetSignalMask(SIG_ICON)
	while(true)do
	Sleep(250)

	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,aheadGetter)
	height=Spring.GetGroundHeight(x,z)
	difference=0
		if y < height then 
		difference=height-y+5
			else
			difference=(y-height)*-1
			end
	Move(circIcon,y_axis,difference,9)
	Move(circIcon,x_axis,(50+math.abs(iconRad))*-1,9)

	end

end

function lightMyFire()
	while true do
		while boolLightMyFire==true do
					EmitSfx(emitHer,1024)
					EmitSfx(advisor,1024)
			Sleep(50)
		end
	Sleep(500)
	end
end

boolLightMyFire=false
lastAttachedUnit=nil
function vampireCycle(attachUnitID)
    
	if lastAttachedUnit~= nil and Spring.ValidUnitID(lastAttachedUnit)==true then
	DropUnit(lastAttachedUnit)
	--detach Unit of Old
	end
--attachUnit
StartThread(iconOngraphy)
	SetUnitValue(COB.BUSY, 1)

attachunit(fourRealGpoint, attachUnitID)
boolUnitAttached=true

lastAttachedUnit=attachUnit
health=Spring.GetUnitHealth(attachUnitID)

Show(circIcon)
Spin(spinMeRightRound,y_axis,math.rad(42),0.01)
   
	 boolLightMyFire=true
	 
		while(boolUnitAttached==true and health > 0) do 
	
			Sleep(1000)
		  
		currentSensorRad=currentSensorRad+addUpRad
		health=Spring.GetUnitHealth(attachUnitID)
		health=health-UnitHealthReduce
		Spring.SetUnitHealth(attachUnitID,health)
		--expand radarRange
		Spring.SetUnitSensorRadius(unitID,"radar",currentSensorRad)
		--update
		iconRad=currentSensorRad

		end
		
		boolLightMyFire=false
     --Spring.Echo("AdvisorStalker_reaching AttachFunction8")		
StopSpin(spinMeRightRound,y_axis,0)
DropUnit(attachUnitID)		
currentSensorRad=orgSensorRad
iconRad=currentSensorRad
Move(circIcon,x_axis,iconRad,0)
Move(circIcon,y_axis,0,0)
Hide(circIcon)
--Shrink RadarRange back to normal

	SetUnitValue(COB.BUSY, 0)
end

	function getUnitsInRange()
	--Sleep(500)
	Sleep(1200)
	px,py,pz=Spring.GetUnitPosition(unitID)
	UnitsTable={}
	UnitsTable=Spring.GetUnitsInCylinder(px,pz,PSIrange)
	--get Units in Range

		if UnitsTable~=nil then
		--filter out who have the AdvisorStalker as last Opponent
		--random Dice one out
		vicTim=returnRandomLastAttacker(UnitsTable)
			if vicTim~=nil then
			Sleep(50)
			StartThread(vampireCycle,vicTim)
			boolUnitAttached=true
			StartThread(hpCheck)
		end
	--StartThread 
	
			
			else
			--caught a empty table
			end
	end
	
function script.QueryWeapon1() 
return advGluePoint 
end
	
	function script.AimFromWeapon1() 
	--soundstart="sentryalert"
	return advGluePoint end
	
	function script.AimWeapon1( heading, pitch )
    if boolUnitAttached==false then
		   Turn(advisor,y_axis,heading,2.0)
		--   Turn(advisor,x_axis,-pitch,2.0)
		   WaitForTurn(advisor,y_axis)
	
 
		return true
	else
	return false
	end
	end
	

	function script.FireWeapon1()
	StartThread(getUnitsInRange)
	end
