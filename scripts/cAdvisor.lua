include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


local emitHer=piece "emitHer"
local center=piece "center"
advisor=""

 advisor1=piece "advisor1"

 advisor2=piece "advisor2"

local advleg1=piece"advleg1"
local advleg2=piece "advleg2"
local advarm1=piece"advarm1"
local advarm1low=piece"advarm1low"
local advarm2=piece"advarm2"
local advarm2low=piece"advarml2ow"
local advGluePoint=piece"advGluePoint"
local circCenter=piece"circCenter"
local circIcon=piece"circIcon"
local spinMeRightRound=piece"spinMeRightRound"
local fourRealGpoint=piece"fourRealGpoint"
local aheadGetter=piece"aheadGetter"

local attachunit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit

local UnitHealthReduce=42
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
boolHandsfree=true
local boolStalker=false

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
Hide(advisor1)
Hide(advleg1)
Hide(advleg2)

StartThread(idle)
StartThread(lightMyFire)
StartThread(bulletOS)
Spin(fourRealGpoint,y_axis,math.rad(-9),0.5)
Spin(circCenter,y_axis,math.rad(9),-0.5)
Move(circIcon,x_axis,-55,0)
Hide(circIcon)
end

function script.Killed()
	

return 1
end
ox,oy,oz=Spring.GetUnitPosition(unitID)
boolOnce=true
numbers={["1"]=true,["2"]=true,["3"]=true,["4"]=true,["5"]=true,["6"]=true,["7"]=true,["8"]=true,["9"]=true}
advisorDef=Spring.GetUnitDefID(unitID)
function reportForNeuralEnhancement()
strings="Citizen Nr:"
PlaySoundByUnitDefID(advisorDef, "sounds/cadvisor/advisorreportA.ogg",1, 1000, 1)

unitidstring=""..unitID..""
for i=1,string.len(unitidstring) do

     c = string.sub(i,i)
	-- Spring.Echo(c)
	 if numbers[c] then
    -- do something with c
	strings=strings..c
	success=false
		while success==false do
		success=PlaySoundByUnitDefID(advisorDef, "sounds/numbers/"..c..".ogg",1, 650, 1)
		Sleep(500)
		end
	end

end
PlaySoundByUnitDefID(advisorDef, "sounds/cadvisor/advisorreportB.ogg",1, 25000, 1)
--Spring.Echo(strings.." please report to administration for a performance review")	
end

function punnish()
Spring.SetUnitNoSelect(unitID,true)

nx,ny,nz =Spring.GetUnitPosition(unitID)
ux,uy,uz =Spring.GetUnitPosition(unitID)
reportForNeuralEnhancement()
while math.abs(ux-ox) >85 or math.abs(uy-oy)>85 or math.abs( uz-oz) >85 do
Spring.SetUnitMoveGoal(unitID,ox,oy,oz)
ux,uy,uz =Spring.GetUnitPosition(unitID)
Sleep(1000)
end
boolStalker=true
PSIrange=320
orgSensorRad=100
Move(advisor2,y_axis,0,0)
Hide(advisor2)
Show(advisor1)
Show(advleg1)
Show(advleg2)
Spring.SetUnitMoveGoal(unitID,nx,ny,nz)
Spring.SetUnitNoSelect(unitID,false)
end
boolOnce=false
    function script.Activate()
			if boolOnce==false then boolOnce=true 
            StartThread(punnish)
			end    
           
            return 1
    end
     
    function script.Deactivate()
        
            return 0
    end
     
     

function walk()
SetSignalMask(SIG_WALK)
	while(true) do
	dolo=math.random(0,5)
	if dolo==1 then
	Move(advisor1,y_axis,5,0.1)
	elseif dolo==2 then
	Move(advisor1,y_axis,0,0.1)
	end
	Turn(advleg1,x_axis,math.rad(-22),6)
	Turn(advleg2,x_axis,math.rad(22),6)
	if boolOnce == true then
	Turn(advisor1,x_axis,math.rad(1.2),0.5)

	WaitForTurn(advleg2,x_axis)	
	WaitForTurn(advleg1,x_axis)
	Turn(advleg1,x_axis,math.rad(22),6)
	Turn(advleg2,x_axis,math.rad(-22),6)
	Turn(advisor1,x_axis,math.rad(-0.8),0.5)
	WaitForTurn(advleg2,x_axis)	
	WaitForTurn(advleg1,x_axis)
	else
	Move(advisor2,y_axis,math.random(0,50),3)
	Sleep(300)
	end
	val=math.random(10,60)
	zval=math.random(0,56)
	Turn(advarm1,y_axis,math.rad(-val),1.2)
	Turn(advarm1,z_axis,math.rad(zval),1.2)
	Turn(advarm1low,y_axis,math.rad(val*2),3.2)	
	Turn(advarm2,y_axis,math.rad(val),1.2)
	Turn(advarm2,z_axis,math.rad(-zval),1.2)
	Turn(advarm2low,y_axis,math.rad(val*-2),3.2)
	end
end

function script.StartMoving()

Signal(SIG_WALK)
StartThread(walk)

end
function legs_down()
SetSignalMask(SIG_LEG)
Sleep(250)
Move(advisor1,y_axis,0,3)	
Move(advisor1,x_axis,0,3)	
Move(advisor1,z_axis,0,3)	

Turn(advisor1,y_axis,math.rad(0),6)
Turn(advleg1,x_axis,math.rad(0),6)
Turn(advleg2,x_axis,math.rad(0),6)

 Turn(advisor1,x_axis,math.rad(0),9)
	val=70
	zval=25
	Turn(advarm1,y_axis,math.rad(-val),1.2)
	Turn(advarm1,z_axis,math.rad(zval),1.2)
	Turn(advarm1low,y_axis,math.rad(val*2),3.2)	
	Turn(advarm2,y_axis,math.rad(val),1.2)
	Turn(advarm2,z_axis,math.rad(-zval),1.2)
	Turn(advarm2low,y_axis,math.rad(val*-2),3.2)
 
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
					EmitSfx(advisor1,1024)
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
	val=math.random(10,60)
	zval=math.random(0,56)
	function script.AimWeapon1( heading, pitch )
		val=math.random(10,60)
	Turn(advarm1,y_axis,math.rad(-val),1.2)
	Turn(advarm1,z_axis,math.rad(zval),1.2)
	Turn(advarm1low,y_axis,math.rad(val*2),3.2)	
	Turn(advarm2,y_axis,math.rad(val),1.2)
	Turn(advarm2,z_axis,math.rad(-zval),1.2)
	Turn(advarm2low,y_axis,math.rad(val*-2),3.2)
    if boolUnitAttached==false then
		   Turn(advisor1,y_axis,heading,2.0)
		--   Turn(advisor1,x_axis,-pitch,2.0)
		   WaitForTurn(advisor1,y_axis)
	
 
		return true
	else
	return false
	end
	end
	

	function script.FireWeapon1()
	val=math.random(10,37)
	zval=math.random(0,56)
	StartThread(getUnitsInRange)
	end

	
	--[[
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
]]--

include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


CurrentlyControlledProjectiles={}
Counter=0
TimeTillDestroy=22000

function bulletOS()
	
	while boolStalker==false do
		ux,uy,uz=Spring.GetUnitPosition(unitID)
		if boolUnitAttached==false then
		catchProjectiles(ux,uy,uz)
		end
		whirlAndDropProjectiles(200,ux,uy,uz)
	
	Sleep(200)
	end
end


function catchProjectiles(ux,uy,uz)
T={}

T=Spring.GetProjectilesInRectangle(ux-100,uz-100,ux+100,uz+100)

	for i=1,#T,1  do
		if Counter < 5 then
		Spring.SetProjectileMoveControl(T[i],true)
		CurrentlyControlledProjectiles[T[i]]=TimeTillDestroy
		Counter=Counter+1
		end
	end


end

function whirlAndDropProjectiles(timeSinceLastCall,ux,uy,uz)
	
	
	--0.001999198 = 1/TimeTillDestroy*NrOfTotalSpins
	for k,v in pairs(CurrentlyControlledProjectiles) do
	px,py,pz=Spring.GetProjectilePosition(k)
		if px and ux then
		SpeedAtStart=(v*2)/TimeTillDestroy
		x,z=RotationMatrice(px-ux,pz-uz,math.rad(v*0.001999198*(SpeedAtStart)))
		Spring.SetProjectilePosition(k,x+ux,py,z+uz)
		CurrentlyControlledProjectiles[k]=v-timeSinceLastCall
		
			if v <= 0 or boolUnitAttached==true then 
			Spring.SetProjectileGravity(k,9000)				
			Spring.SetProjectileMoveControl(k,false)
			CurrentlyControlledProjectiles[k]=nil
			Counter=math.max(0,Counter-1)
			end	
		end
	end

 
end



	