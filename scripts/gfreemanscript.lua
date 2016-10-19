include "createCorpse.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 


--Define the wheel pieces
crowbar=piece"Crowbar"


--Define the pieces of the weapon
local turret = piece "RUArm01"
local turret2 = piece "LUArm"
local flare01 = piece "Crowbar"
local flare02= piece "Crowbar"
local center= piece "center"

local skinleg = piece"LLeg"
local lowlegsk = piece"LLLeg"
local skinleg2 = piece"RLeg"
local lowlegsk02 = piece"RLLeg"

local boolSecondAiming=false

local body = piece "body"
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_IDLE=4
local emitor=piece"emitor"

function legs_down()
	Move (center,x_axis,0,12)
	Move (center,y_axis,0,12)
	Move (center,z_axis,0,12)
	Move (body,x_axis,0,12)
	Move (body,y_axis,0,12)
	Move (body,z_axis,0,12)
	Turn (center, x_axis,math.rad(0), 15)	
	Turn (center, y_axis,math.rad(0), 15)	
	Turn (center, z_axis,math.rad(0), 15)
	Turn (body, x_axis,math.rad(0), 15)	
	Turn (body, y_axis,math.rad(0), 15)	
	Turn (body, z_axis,math.rad(0), 15)
	Turn (skinleg2, x_axis,math.rad(0), 15)
	Turn (skinleg, x_axis,math.rad(0), 15)
	Turn(lowlegsk,x_axis,math.rad(0), 32)
	Turn(lowlegsk02,x_axis,math.rad(0), 32)
	
	
end


function Emit()

	while true do
	EmitSfx(emitor,1024)
	Sleep(10)
	end

end

function HitByWeapon ( x, z, weaponDefID, damage )
imBleeding=Spring.GetUnitLastAttacker(unitID)
	if imBleeding then
	   weAreAllVictims=Spring.GetUnitTeam(imBleeding)
	   if weAreAllVictims then
					Spring.AddTeamResource(weAreAllVictims, "metall",  42  )
					Spring.AddTeamResource( weAreAllVictims, "energy",  42)

		end
	end
end


function script.Create()
StartThread(Emit)
--generatepiecesTableAndArrayCode(unitID)
end

function script.Killed(recentDamage,_)

createCorpseCUnitGeneric(recentDamage)
return 1
end

function walk()

	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	Turn(body, x_axis, math.rad(22), 14)
	WaitForTurn(body,x_axis)
	leg_movespeed=6
		
	
	
	while (true) do
	if leg_movespeed <14 then
	leg_movespeed=leg_movespeed+4
	
	end
		--left leg up, right leg down
		Turn(skinleg, x_axis,math.rad(-26) ,12 )
		Turn(lowlegsk,x_axis,math.rad(50), 24)
		
		Turn(skinleg2, x_axis, math.rad(12), leg_movespeed)
		Turn(turret2,x_axis,math.rad(14),8)
		WaitForTurn (skinleg, x_axis)
		WaitForTurn (skinleg2, x_axis)	
		WaitForTurn (lowlegsk02,x_axis)
		
		Turn(turret,x_axis,math.rad(-58),8)
		Turn(skinleg, x_axis,math.rad(-33) ,12 )
		Turn(skinleg2, x_axis, math.rad(22), leg_movespeed)
		Turn(lowlegsk02, x_axis, math.rad(24), leg_movespeed)
		Turn(lowlegsk,x_axis,math.rad(50), 24)
		
		WaitForTurn (skinleg, x_axis)
		WaitForTurn (lowlegsk02,x_axis)
		WaitForTurn (skinleg2, x_axis)		
		WaitForTurn (lowlegsk, x_axis)
		randSleep=math.ceil(math.random(40,100))
		Sleep (randSleep)
		--left leg down, right leg up
		
		Turn(skinleg2, x_axis,math.rad(-26) ,12 )
		Turn(lowlegsk02,x_axis,math.rad(50), 24)
		
		Turn(skinleg, x_axis, math.rad(12), leg_movespeed)
		Turn(turret2,x_axis,math.rad(-58),8)
		WaitForTurn (skinleg2, x_axis)
		WaitForTurn (skinleg, x_axis)	
		WaitForTurn (lowlegsk,x_axis)
		WaitForTurn (lowlegsk02, x_axis)
		
		Turn(turret,x_axis,math.rad(14),8)
		Turn(skinleg2, x_axis,math.rad(-33) ,19 )
		Turn(lowlegsk, x_axis, math.rad(15), leg_movespeed)
		Turn(lowlegsk02,x_axis,math.rad(78), 20)
		
		WaitForTurn ( skinleg2, x_axis)
		WaitForTurn (lowlegsk,x_axis)
		WaitForTurn (lowlegsk02, x_axis)
		Sleep (80)
	end
end


function script.StartMoving()
	Signal(SIG_IDLE)
	legs_down()
	StartThread (walk)

end

function script.StopMoving()
		Signal(SIG_IDLE)
		Signal(SIG_WALK)
		legs_down()
		
end

function script.AimFromWeapon1() 
	return crowbar 
end

function script.QueryWeapon1() 
	return crowbar 
end

function script.AimWeapon1( heading ,pitch)	
Signal(SIG_IDLE)
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)
	return true
end

function script.FireWeapon1()	
	return true
end

