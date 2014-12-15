include "suddenDeath.lua"
--Define the wheel pieces

--Define the pieces of the weapon

local flare1 = piece "flare1"
local gun1 = piece "gun1"
local gun2 = piece "gun2"
local gun3 = piece "gun3"
local gun4 = piece "gun4"
local flare2 = piece "flare2"
local flare3 = piece "flare3"
local flare4= piece "flare4"

SIG_FIRE=2
SIG_FIRE2=4
--define other pieces


teamID=Spring.GetUnitTeam(unitID)

function script.Create()
Hide(flare1)
Hide(flare2)
Hide(flare3)
Hide(flare4)
end


function flareThread(nr)
	if nr==1 then
	for i=1, 17, 1 do
	EmitSfx(flare1,1024)
	Sleep(97)
	end
		elseif nr== 2 then
		for i=1, 17, 1 do
		EmitSfx(flare2,1024)
		Sleep(97)
		end
			elseif nr==3 then
			for i=1, 17, 1 do
			EmitSfx(flare3,1024)
			Sleep(97)
			end
				elseif nr==4 then
				for i=1, 17, 1 do
				EmitSfx(flare4,1024)
				Sleep(97)
				end
				end
end


----aimining & fire weapon
boolDoneAiming1=false
function script.AimFromWeapon1() 
	return gun1 
end

function script.QueryWeapon1() 
	return gun1
end

function script.AimWeapon1( heading ,pitch)	
Signal(SIG_FIRE)
	if heading > 1.63 and heading < 4.8  then
	boolDoneAiming1=false
	return false
	else
		--aiming animation: instantly turn the gun towards the enemy

		Turn(gun1, y_axis, heading,4)
		Turn(gun1, x_axis, -pitch, 4)
		WaitForTurn(gun1,y_axis)
		boolDoneAiming1=true
		return true
	end
end



function script.FireWeapon1()	
Spring.PlaySoundFile("sounds/bonkers/plasma.wav",1.0)
for i=1,25, 1 do
EmitSfx(flare1,2052)
Sleep(15)
end
	return true
end

----------------------------------------------
function script.AimFromWeapon2() 
	return gun2
end

function script.QueryWeapon2() 
	return gun2 
end

function script.AimWeapon2( heading ,pitch)	

if heading > 1.63 and heading < 4.8  then
Turn(gun2,y_axis,(0),4)

return false
else
	--aiming animation: instantly turn the gun towards the enemy
	Turn(gun2, y_axis, heading, 4)
	Turn(gun2, x_axis, -pitch, 4)
	WaitForTurn(gun2,y_axis)
	return true
end
end



function script.FireWeapon2()	
StartThread(flareThread,2)
	return true
end

boolDoneAiming2=false
----------------------------------------------
function script.AimFromWeapon3() 
	return gun3 
end

function script.QueryWeapon3() 
	return gun3 
end

function script.AimWeapon3( heading ,pitch)	
Signal(SIG_FIRE2)
	if heading < 1.63 or heading > 4.8 then
	boolDoneAiming3=false
	return false
	else
		--aiming animation: instantly turn the gun towards the enemy

		Turn(gun3, y_axis, heading,4)
		Turn(gun3, x_axis, -pitch, 4)
		WaitForTurn(gun3,y_axis)
		boolDoneAiming3=true
		return true
	end
end


boolDoneAiming7=false
empty=piece"empty"
function script.FireWeapon3()	
Spring.PlaySoundFile("sounds/bonkers/plasma.wav",1.0)
for i=1,25, 1 do
EmitSfx(flare3,2053)
Move(empty,x_axis,15,955)
WaitForMove(empty,x_axis)
Move(empty,x_axis,0,0)
end


	return true
end

----------------------------------------------
function script.AimFromWeapon4() 
	return gun4
end

function script.QueryWeapon4() 
	return gun4
end

function script.AimWeapon4( heading ,pitch)	
if heading < 1.63 or heading > 4.8  then

return false
else
	--aiming animation: instantly turn the gun towards the enemy
	Turn(gun4, y_axis, heading,4)
	Turn(gun4, x_axis, -pitch, 4)
	WaitForTurn(gun4,y_axis)
	
	return true
end
end



function script.FireWeapon4()	
StartThread(flareThread,4)
	return true
end


----------------------------------------------
function script.AimFromWeapon5() 
	return flare1
end

function script.QueryWeapon5() 
	return flare1
end

function script.AimWeapon5( heading ,pitch)	
SetSignalMask(SIG_FIRE)


return 	true

end



function script.FireWeapon5()	

	return true
end

----------------------------------------------

function script.AimFromWeapon6() 
	return flare1
end

function script.QueryWeapon6() 
	return flare1
end

function script.AimWeapon6( heading ,pitch)	

return 	true


end



function script.FireWeapon6()	

--EmitSfx(flare1,1025)
	return true
end



function script.Killed(recentDamage, maxHealth)
teamID=Spring.GetUnitTeam(unitID)
dropPx,dropPy,dropZ=Spring.GetUnitPosition(unitID)
for i=1,4,1 do 
	Spring.CreateUnit("bg",dropPx+20,dropPy,dropZ+90, 0, teamID)  

end
suddenDeath(unitID,recentDamage)
Sleep(10)
--whatever
return 0
end
--Building


