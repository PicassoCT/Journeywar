local turret =piece "sentur"
local sentry = piece"sentry"
local flare =piece "flare02"
local itterator= 1
local SIG_IDLE=2
local boolStillAttackin=false

function idle()
SetSignalMask(SIG_IDLE)
while(true) do
				if boolStillAttackin== true then
				boolStillAttackin=false
				Sleep(1240)
				end
				
		if boolStillAttackin== false then
		local left=math.random(20,65)
		Turn(turret,y_axis,math.rad(left),0.75)
		WaitForTurn(turret,y_axis)
		Sleep(50)
		local right=math.random(-65,-20)

		Turn(turret,y_axis,math.rad(right),0.75)
		WaitForTurn(turret,y_axis)
		Sleep(120)
		end
end
end


function script.Create()
  --Spring.Echo "This was a Triumph! Im making a note here huge Success!"
  --Spring.UnitScript.Play("sentrydeploy")
  StartThread(idle)
end

function script.Killed()
	
Turn(sentry,z_axis, math.rad(82),math.rad(55))
WaitForTurn(sentry, z_axis)
Turn(sentry,z_axis, math.rad(75),math.rad(55))
WaitForTurn(sentry, z_axis)
Turn(turret,y_axis, math.rad(30),math.rad(45))
WaitForTurn(sentry, y_axis)
Turn(sentry,z_axis, math.rad(82),math.rad(35))
WaitForTurn(sentry, z_axis)
Turn(sentry,z_axis, math.rad(75),math.rad(48))
WaitForTurn(sentry, z_axis)
Turn(turret,y_axis, math.rad(320),math.rad(45))
WaitForTurn(sentry, y_axis)
Turn(sentry,z_axis, math.rad(82),math.rad(35))
WaitForTurn(sentry, z_axis)
Turn(turret,y_axis, math.rad(30),math.rad(45))
WaitForTurn(sentry, y_axis)
Turn(sentry,z_axis, math.rad(75),math.rad(48))
WaitForTurn(sentry, z_axis)
Turn(turret,y_axis, math.rad(320),math.rad(45))
WaitForTurn(sentry, y_axis)


Sleep(2400)
Explode (sentry, SFX.FIRE)
Explode (turret, SFX.FIRE)
end






function script.QueryWeapon1() return 
flare end
	
	function script.AimFromWeapon1() 
	--soundstart="sentryalert"
	return turret end
	
	function script.AimWeapon1( heading, pitch )

            boolStillAttackin=true
        	Turn(turret, y_axis, heading, math.rad(150))
        	WaitForTurn(turret, y_axis)
			--Turn(lgun, x_axis, -pitch, math.rad(100))
        	
        	--WaitForTurn(lgun, x_axis)
		--StartThread(RestoreAfterDelay)
		return true
	end
	
	
	function script.FireWeapon1()
	
	end
