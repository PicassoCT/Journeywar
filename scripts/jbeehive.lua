
--Define the wheel pieces

--Define the pieces of the weapon

local start = piece "start"

--define other pieces



function fromTimeToTime()
local spPlaySoundFile=Spring.PlaySoundFile
	while (true) do
	Sleep(1000)
	dice=math.random(0,10)
		if dice==3 then
		anyThingButPlayItLoud=math.random(0.75,1)
		spPlaySoundFile("sounds/jbeehive/beehiveactive.wav",anyThingButPlayItLoud)  
		end

	end

end
function script.Create()
StartThread(fromTimeToTime)

end





----aimining & fire weapon
function script.AimFromWeapon1() 
	return start 
end

function script.QueryWeapon1() 
	return start
end

function script.AimWeapon1( heading ,pitch)	

	Turn(start, y_axis, heading,4)
	Turn(start, x_axis, -pitch, 4)
	WaitForTurn(start,y_axis)
	
	return true
end

boolPlaySound=false
function playActivateSound()
boolPlaySound=true
Spring.PlaySoundFile("sounds/jbeehive/beeAktiv.wav")  
Sleep(4500)
boolPlaySound=false
end

function script.FireWeapon1()	
if boolPlaySound==false then StartThread(playActivateSound) end
	return true
end


function script.Killed(recentDamage, maxHealth)

return 1
end
--Building


