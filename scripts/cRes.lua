include "createCorpse.lua"
local res = piece "res"
local resDust = piece "resDust"
local resturm = piece "resturm"
local resthumb= piece "resthumb"
local reswheelz = piece "reswheelz"
local reswheelz0 = piece "reswheelz0"
local reswheelz1 = piece "reswheelz1"
local fireEmit = piece "reswheelz1"
local barrelmovespeed=5
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_MOVE=4
local SIG_THUMB=8
local headingOfOld=0
local boolThumperActivated=false
local headingDistancePos= 3141 --3600
local headingDistanceNeg= -3141 --3600
local boolConstMove=false
local boolTempMove=false
local tempSpeedStore=5.2


function headingWatcher ()
	while(true) do
		heading=Spring.GetUnitHeading(unitID)
		
		local tempHead=heading-headingOfOld
		--compares the heading of the unit, if the heading changed massively - or the unit has the thumper activated, the wheels are set into turnmode
		if tempHead > 0 and tempHead > headingDistancePos and boolConstMove== false or tempHead < 0 and tempHead < headingDistanceNeg and boolConstMove== false or boolThumperActivated==true then
			Turn(reswheelz,y_axis,math.rad(90),10)
			Turn(reswheelz1,y_axis,math.rad(37),9)
			Turn(reswheelz0,y_axis,math.rad(-37),9)
			Sleep(150)
		elseif boolThumperActivated == false then 
			Turn(reswheelz,y_axis,math.rad(0),22)
			Turn(reswheelz1,y_axis,math.rad(0),22)
			Turn(reswheelz0,y_axis,math.rad(0),22)
			Sleep(150)
		end
		headingOfOld=heading
		
	end
end

function script.Create()
	StartThread(headingWatcher)
end

function hammerHart()
	SetSignalMask(SIG_THUMB)
	while(true) do
		Move(resthumb,y_axis,0,0.5)
		WaitForMove(resthumb,y_axis)
		Sleep(600)
		
		
		
		unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
		Move(resthumb,y_axis,-4,15)
		Spring.PlaySoundFile("sounds/cRes/thumper_dust.wav")
		WaitForMove(resthumb,y_axis) 
		EmitSfx(resthumb, 4097)
		Spring.SpawnCEG("dirt",unitx,unity,unitz,0,1,0,50,0)
		Sleep(900)
		
	end
	
	
end

function script.Killed(recentDamage)
	local unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
	Spring.SpawnCEG("330RLexplode",unitx,unity,unitz,0,1,0,50,0)
	Explode(resturm, SFX.FIRE+ SFX.FALL)
	Sleep(450)
	Explode(res, SFX.FIRE)
	createCorpseCUnitSmall(recentDamage)
	
end

maxspeed=math.ceil(COB.MAX_SPEED *65533)
function script.Activate()
	--set the MovementSpeed back to the original speed
	Signal(SIG_THUMB)
		
	SetUnitValue(COB.MAX_SPEED,maxspeed)--sets the speed to 5,2 *65533
	Move(resthumb,y_axis,0,0.5)
		
	boolThumperActivated=false
	Spring.PlaySoundFile("sounds/cRes/cthoff.wav")
	
	return 1
end

function script.Deactivate()
	Spring.PlaySoundFile("sounds/cRes/thumper_hit.wav")
	boolThumperActivated=true
	tempSpeedStore=5.2
	StartThread(hammerHart)
	SetUnitValue(COB.MAX_SPEED,1)
	
	--set the MovementSpeed to zero
	return 0
end

function constMoveDetec()
	SetSignalMask(SIG_MOVE)
	boolTempMove=false
	Sleep(450)
	if boolTempMove==true then
		boolConstMove=true
	else
		boolConstMove=false
	end
	
	
end	



function script.StartMoving()
	StartThread(constMoveDetec)													
	
end

function script.StopMoving()
	Signal(SIG_MOVE)
end




function script.AimFromWeapon2() 	
	
	
	
return resthumb end

function script.QueryWeapon2() 
	return resthumb 
end


function script.AimWeapon2( heading, pitch )
	
	if boolThumperActivated == true then
		
		
		return true
	else
		Move(resthumb,x_axis,0,2)
		
		return false
	end		
	
	
end


function script.FireWeapon2()
	EmitSfx(resthumb,4097)
	for i=1, 5, 1 do
		EmitSfx(resthumb,1024)
		Sleep(15)
	end
	
end
----------------------------------------------------------------------------------

function script.AimFromWeapon1() 	
	
	
	
return fireEmit end

function script.QueryWeapon1() 
	return fireEmit
end



function script.AimWeapon1( heading, pitch )
	Turn(resturm,y_axis,heading,4)
	WaitForTurn(resturm,y_axis)
	
	if boolThumperActivated ==false then
		return true
	else
		
		return false
	end
end


function script.FireWeapon1()
	
	
	
end