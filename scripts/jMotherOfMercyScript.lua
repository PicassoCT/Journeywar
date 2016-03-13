
	include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_anim.lua"

 include "lib_Build.lua" 

	include "suddenDeath.lua"
function script.HitByWeapon ( x, z, weaponDefID, damage )
hp=Spring.GetUnitHealth(unitID)
if hp and  hp-damage < 0 then
Spring.SetUnitCrashing(unitID,true)
SetUnitValue(COB.CRASHING, 1)
Spring.SetUnitNeutral(unitID,true)
Spring.SetUnitNoSelect(unitID,true)
return 0
end
return damage
end
tenTacles={}
for i=1,5 do
tenTacles[i]={}
	for j=1,9 do
	val=(i-1)*9+j
	piecename="Tent"..val
	tenTacles[i][j]=piece(piecename)
	end
end
 ETTable={}
 piecesTable={}
 center = piece"center"

 piecesTable[#piecesTable+1]= center
 Body = piece"Body"

 piecesTable[#piecesTable+1]= Body
 Effector1 = piece"Effector1"

 ETTable[#ETTable+1]= Effector1
 Effector2 = piece"Effector2"

 ETTable[#ETTable+1]= Effector2
 Effector3 = piece"Effector3"

 ETTable[#ETTable+1]= Effector3
 Effector4 = piece"Effector4"

 ETTable[#ETTable+1]= Effector4
 Tent1 = piece"Tent1"

 piecesTable[#piecesTable+1]= Tent1
 Tent2 = piece"Tent2"

 piecesTable[#piecesTable+1]= Tent2
 Tent3 = piece"Tent3"

 piecesTable[#piecesTable+1]= Tent3
 Tent4 = piece"Tent4"

 piecesTable[#piecesTable+1]= Tent4
 Tent5 = piece"Tent5"

 piecesTable[#piecesTable+1]= Tent5
 Tent6 = piece"Tent6"

 piecesTable[#piecesTable+1]= Tent6
 Tent7 = piece"Tent7"

 piecesTable[#piecesTable+1]= Tent7
 Tent8 = piece"Tent8"

 piecesTable[#piecesTable+1]= Tent8
 Tent9 = piece"Tent9"

 piecesTable[#piecesTable+1]= Tent9
 Kreis06 = piece"Kreis06"

 piecesTable[#piecesTable+1]= Kreis06
 Tent10 = piece"Tent10"

 piecesTable[#piecesTable+1]= Tent10
 Tent11 = piece"Tent11"

 piecesTable[#piecesTable+1]= Tent11
 Tent12 = piece"Tent12"

 piecesTable[#piecesTable+1]= Tent12
 Tent13 = piece"Tent13"

 piecesTable[#piecesTable+1]= Tent13
 Tent14 = piece"Tent14"

 piecesTable[#piecesTable+1]= Tent14
 Tent15 = piece"Tent15"

 piecesTable[#piecesTable+1]= Tent15
 Tent16 = piece"Tent16"

 piecesTable[#piecesTable+1]= Tent16
 Tent17 = piece"Tent17"

 piecesTable[#piecesTable+1]= Tent17
 Tent18 = piece"Tent18"

 piecesTable[#piecesTable+1]= Tent18
 Kreis15 = piece"Kreis15"

 piecesTable[#piecesTable+1]= Kreis15
 Tent19 = piece"Tent19"

 piecesTable[#piecesTable+1]= Tent19
 Tent20 = piece"Tent20"

 piecesTable[#piecesTable+1]= Tent20
 Tent21 = piece"Tent21"

 piecesTable[#piecesTable+1]= Tent21
 Tent22 = piece"Tent22"

 piecesTable[#piecesTable+1]= Tent22
 Tent23 = piece"Tent23"

 piecesTable[#piecesTable+1]= Tent23
 Tent24 = piece"Tent24"

 piecesTable[#piecesTable+1]= Tent24
 Tent25 = piece"Tent25"

 piecesTable[#piecesTable+1]= Tent25
 Tent26 = piece"Tent26"

 piecesTable[#piecesTable+1]= Tent26
 Tent27 = piece"Tent27"

 piecesTable[#piecesTable+1]= Tent27
 Kreis16 = piece"Kreis16"

 piecesTable[#piecesTable+1]= Kreis16
 Tent28 = piece"Tent28"

 piecesTable[#piecesTable+1]= Tent28
 Tent29 = piece"Tent29"

 piecesTable[#piecesTable+1]= Tent29
 Tent30 = piece"Tent30"

 piecesTable[#piecesTable+1]= Tent30
 Tent31 = piece"Tent31"

 piecesTable[#piecesTable+1]= Tent31
 Tent32 = piece"Tent32"

 piecesTable[#piecesTable+1]= Tent32
 Tent33 = piece"Tent33"

 piecesTable[#piecesTable+1]= Tent33
 Tent34 = piece"Tent34"

 piecesTable[#piecesTable+1]= Tent34
 Tent35 = piece"Tent35"

 piecesTable[#piecesTable+1]= Tent35
 Tent36 = piece"Tent36"

 piecesTable[#piecesTable+1]= Tent36
 Kreis13 = piece"Kreis13"

 piecesTable[#piecesTable+1]= Kreis13
 Tent37 = piece"Tent37"

 piecesTable[#piecesTable+1]= Tent37
 Tent38 = piece"Tent38"

 piecesTable[#piecesTable+1]= Tent38
 Tent39 = piece"Tent39"

 piecesTable[#piecesTable+1]= Tent39
 Tent40 = piece"Tent40"

 piecesTable[#piecesTable+1]= Tent40
 Tent41 = piece"Tent41"

 piecesTable[#piecesTable+1]= Tent41
 Tent42 = piece"Tent42"

 piecesTable[#piecesTable+1]= Tent42
 Tent43 = piece"Tent43"

 piecesTable[#piecesTable+1]= Tent43
 Tent44 = piece"Tent44"

 piecesTable[#piecesTable+1]= Tent44
 Tent45 = piece"Tent45"

 piecesTable[#piecesTable+1]= Tent45
 Kreis14 = piece"Kreis14"

 piecesTable[#piecesTable+1]= Kreis14
 thrustemit = piece"thrustemit"

 piecesTable[#piecesTable+1]= thrustemit

TargetPieces={} 


function script.Activate()
				       --activates the secondary weapon 
			
					--	return 1
					end

		function script.Deactivate()
		  --deactivates the secondary weapon 
	
			
				--return 0
		end


function script.StartMoving()
Signal(SIG_AIM)
	--windGet()

	
	 
   boolMoving=true

 
    
end

function script.StopMoving()



 boolMoving=false
end




function script.Create()

	 StartThread(moveMent)
	 StartThread(sfx)
	 StartThread(TurnDetect)
	 StartThread(aimOS)

 --updateDelete

--Spring.PlaySoundFile("sounds/conair/cConAir.wav")
end

function script.Killed(recentDamage)


--needsWreckageFeature

  
Sleep(400)
suddenDeathjBuildCorpse(unitID, recentDamage)
return 0
end

function sfx()
	while true do
		while boolMoving==true and boolTurning==false do
		EmitSfx(thrustemit,1026)
		Sleep(100)
		end
	Sleep(250)
	end
end

boolTractor=false
boolTurning=false
boolTurnLeft=false

function TurnDetect()
local spGetUnitHeading=Spring.GetUnitHeading
oldHeading=spGetUnitHeading(unitID)
Sleep(500)
newHeading=oldHeading

	while true do	
newHeading=spGetUnitHeading(unitID)

	if math.abs(newHeading-oldHeading)> 1400 then
	boolTurning=true
		if newHeading-oldHeading < 0 then boolTurnLeft=true else boolTurnLeft=false end
			else
			boolTurning=false
			end
	Sleep(500)
	oldHeading=newHeading
	end
end

function TurnArms(boolTurnDirection)

	
	if boolTurnDirection == true then
		for i=1,5 do
		waveATable(tenTacles[i], y_axis, math.sin, 1, 0.12, 1.570796326794896,8.5, false)			
		end	
	else
		for i=1,5 do
			waveATable(tenTacles[i], y_axis, math.sin, -1, 0.12, 1.570796326794896,8.5, false)	
		end
	end
end

local piq=3.14159*0.15
function altidle()

Turn(center,x_axis,math.rad(-90),27)
Move(center,y_axis,290,96)
WaitForMove(center,y_axis)
temp_O_Rary=math.random(11,11.5)*piq

		 waveATable(tenTacles[1], x_axis,  math.sin, 1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)
		 waveATable(tenTacles[1], y_axis,  math.sin, -1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)	
		 waveATable(tenTacles[2], x_axis,  math.sin, 1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)
		 waveATable(tenTacles[2], y_axis,  math.sin, 1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)	
                                           
		 waveATable(tenTacles[3], x_axis,  math.sin, 1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)
                                           
		 waveATable(tenTacles[4], x_axis,  math.sin, -1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)
		 waveATable(tenTacles[4], y_axis,  math.sin, -1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)	
		 waveATable(tenTacles[5], x_axis,  math.sin, -1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)
		 waveATable(tenTacles[5], y_axis,  math.sin, 1, 0.14, 6.2831853071,8.5, false,temp_O_Rary)


end

function idle()
 kih=0.785398163397*math.ceil(math.random(1,8))
 dih=0.785398163397*math.ceil(math.random(1,8))
	if math.random(0,1) then
		for i=1,5 do
				waveATable(tenTacles[i], x_axis, math.sin, 1, 0.12, dih,8.5, false,kih)
				waveATable(tenTacles[i], y_axis, math.sin, 1, 0.12, dih,8.5, false,kih)			
		end		
	else        
				for i=1,5 do
				waveATable(tenTacles[i], x_axis, math.sin, 1, 0.12, dih,8.5, false,kih)
				waveATable(tenTacles[i], y_axis, math.sin, 1, 0.12, dih,8.5, false,kih)			
		end

	end

end


local pi=3.14159
local pit=pi*0.75
local pih=pi/2
local pid=pi*2

function moveMent()

local lwaveTable=	 waveATable
local lidle=idle
local laltidle=altidle
zerofunc = function () return 0 end
while true do

	while boolMoving==true and boolTractor==false and boolTurning==false do
	
		 lwaveTable(tenTacles[1], x_axis, math.sin, 1, 0.14, pid,8.5, false)
		 lwaveTable(tenTacles[1], y_axis, math.sin, -1, 0.14, pid,8.5, false)	
		 lwaveTable(tenTacles[2], x_axis, math.sin, 1, 0.14, pid,8.5, false)
		 lwaveTable(tenTacles[2], y_axis, math.sin, 1, 0.14, pid,8.5, false)	

		 lwaveTable(tenTacles[3], x_axis, math.sin, 1, 0.14, pid,8.5, false)
		 
		 lwaveTable(tenTacles[4], x_axis, math.sin, -1, 0.14, pid,8.5, false)
		 lwaveTable(tenTacles[4], y_axis, math.sin, -1, 0.14, pid,8.5, false)	
		 lwaveTable(tenTacles[5], x_axis, math.sin, -1, 0.14, pid,8.5, false)
		 lwaveTable(tenTacles[5], y_axis, math.sin, 1, 0.14, pid,8.5, false)
 Sleep(900)
		lwaveTable(tenTacles[1], x_axis, math.sin, -1, 0.14, pid,8.5, false,pih)
		
		lwaveTable(tenTacles[3], y_axis, math.sin, -1, 0.14, pid,8.5, false,pih)
		lwaveTable(tenTacles[1], y_axis, math.sin, 1, 0.14, pid,8.5, false,pih)	
		lwaveTable(tenTacles[2], x_axis, math.sin, -1, 0.14, pid,8.5, false,pih)
		lwaveTable(tenTacles[2], y_axis, math.sin, -1, 0.14, pid,8.5, false,pih)	
		
		lwaveTable(tenTacles[4], x_axis, math.sin, 1, 0.14, pid,8.5, false,pih)
		lwaveTable(tenTacles[4], y_axis, math.sin, 1, 0.14, pid,8.5, false,pih)	
		lwaveTable(tenTacles[5], x_axis, math.sin, 1, 0.14, pid,8.5, false,pih)
		lwaveTable(tenTacles[5], y_axis, math.sin, -1, 0.14, pid,8.5, false,pih)
 Sleep(1500)

		lwaveTable(tenTacles[1], x_axis, zerofunc, 1, 0.14, pid,8.5, false)
		lwaveTable(tenTacles[1], y_axis, zerofunc, 1, 0.14, pid,8.5, false)	
		lwaveTable(tenTacles[2], x_axis, zerofunc, 1, 0.14, pid,8.5, false)
		lwaveTable(tenTacles[2], y_axis, zerofunc, 1, 0.14, pid,8.5, false)	
		
		lwaveTable(tenTacles[3], x_axis, zerofunc, -1, 0.14, pid,8.5, false)
		
		lwaveTable(tenTacles[4], x_axis, zerofunc, 1, 0.14, pid,8.5, false)
		lwaveTable(tenTacles[4], y_axis, zerofunc, 1, 0.14, pid,8.5, false)	
		lwaveTable(tenTacles[5], x_axis, zerofunc, 1, 0.14, pid,8.5, false)
		lwaveTable(tenTacles[5], y_axis, zerofunc, 1, 0.14, pid,8.5, false)
 Sleep(800)
	end
	if boolTurning==true and boolTractor==false then
	TurnArms(boolTurnLeft)
	end
	ridle=math.random(0,1)
	while boolTractor==false and boolTurning== false and boolMoving==false  do
		if ridle ==1 then
		lidle()
		else
			if math.random(0,1) ==1 then
			laltidle()
			end
		end
	Sleep(900)	
	end
	Turn(center,x_axis,math.rad(0),27)
	Move(center,y_axis,0,96)
	
Sleep(250)
end
end
----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	
	return true
end

local unitdef=Spring.GetUnitDefID(unitID)
local soundfile="sounds/jMom/TractorDeployed.ogg"
function emitTractorSFX()
PlaySoundByUnitType(unitdef, soundfile, 0.5, 2500,1)
end

ROCKDISTANCE=2000
function IsRockStillInRange()
x,y,z=Spring.GetUnitPosition(unitID)
ux,uy,uz=Spring.GetUnitPosition(thisIsMyRockID)
x,y,z=x-ux,y-uy,z-uz
return math.sqrt(x*x+y*y+z*z) < ROCKDISTANCE
end

function aimOS()
	while true do
	-- is there A rock
		if doesRockStillExist() == true then 
		boolCanFire=false 
		boolTractor=true
		trainEffectors(thisIsMyRockID)
		StartThread(emitTractorSFX)
			-- if there is a rock is it still in range
			if IsRockStillInRange() == false then
			Spring.DestroyUnit(thisIsMyRockID,false,true)
			boolCanFire=true
			
			end
		else
		boolTractor=false
		retractEffectors()
		end
	Sleep(3000)
	end
end

boolCanFire=true
thisIsMyRockID=-1 --there are billions like this in the orth cloud, but this is mine
function doesRockStillExist()
return Spring.ValidUnitID(thisIsMyRockID)  
end


local teamID=Spring.GetUnitTeam(unitID)
function ripARock(x,y,z)
	if doesRockStillExist()==false then
	thisIsMyRockID=Spring.CreateUnit("flyingmountain",x,y,z,0, teamID)
	Spring.SetUnitMoveGoal(unitID,x,y,z)
	end
end

function retractEffectors()
	for i=1,#ETTable do
	Turn(ETTable[i],x_axis,math.rad(0),4)
	Turn(ETTable[i],y_axis,math.rad(0),4)
	Turn(ETTable[i],z_axis,math.rad(0),4)
	end
	
	for i=1,#ETTable do
	WaitForTurn(ETTable[i],x_axis)
	end

	for i=1,#ETTable do
	Move(ETTable[i],x_axis,(0),4)
	Move(ETTable[i],y_axis,(0),4)
	Move(ETTable[i],z_axis,(0),4)
	end

end

local spGetUnitPosition=Spring.GetUnitPosition

function miMax(min,val,max)
return math.min(math.max(val,min),max)
end

function limit(nr,xval,yval)
	if nr==1 or nr == 2 then
	return xval,miMax(-18,yval,49)
	else
	return xval,miMax(-31,yval,21)
	end
end

function trainEffectors(target)
Move(ETTable[1],x_axis,-22,4)
Move(ETTable[2],x_axis,-22,4)
Move(ETTable[3],x_axis,22,4)
Move(ETTable[4],x_axis,22,4)

WaitForMove(ETTable[1],x_axis)
px,py,pz=spGetUnitPosition(unitID)
x,y,z=spGetUnitPosition(target)
if x then
x,y,z=x-px,y-py,z-pz
x_rad=math.atan2(math.sqrt(x*x+z*z),y)


	for i=1,#ETTable do
	Turn(ETTable[i],x_axis,x_rad,4)
	end
end	
end

function script.FireWeapon1()	
	return true
end







