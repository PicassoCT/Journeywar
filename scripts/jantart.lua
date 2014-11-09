local jantart  = piece "jantart"
local flare1= piece "emit1"
local flare2= piece "emit2"
local flare3= piece "emit3"
local antrotor=piece "antrotor"
local antrotor2=piece "antrotor2"
local antrotor3=piece "antrotor3"


local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread



function script.Create()
  Hide(flare1)
  Hide(flare2)
  Hide(flare3)
end

function script.Killed()
Move(jantart,y_axis,-20,8)

	while(true==Spring.UnitScript.IsInMove (jantart, y_axis)) do
EmitSfx(flare1,1025) 
EmitSfx(flare2,1025) 
EmitSfx(flare3,1025) 
Sleep(120)
end
EmitSfx(flare1,1024)
--Spring.SpawnCEG

--( string "cegname",
--   number posX = 0, number posY = 0, number posZ = 0,
--   number dirX = 0, number dirY = 0, number dirZ = 0,
--   number radius = 0, number damage = 0
-- )


return 1

end



	
local function move()

leftOrRight=math.random(0,1)
if leftOrRight == 1 then
Spin(jantart,y_axis,math.rad(-14),3)
else
Spin(jantart,y_axis,math.rad(14),3)
end

Spin(antrotor,y_axis,math.rad(42),9)
Spin(antrotor2,y_axis,math.rad(42),9)
Spin(antrotor3,y_axis,math.rad(42),9)
	
	
end




function script.StartMoving()
   
	StartThread(move)

end

function script.StopMoving()
StopSpin(jantart,y_axis)
StopSpin(antrotor,y_axis)
StopSpin(antrotor2,y_axis)
StopSpin(antrotor3,y_axis)
	
	
		
		
end



	
------------------------------------------------------------------
function chooseYourFlare()
	three=math.random(0,2)
	if three== 0 then
	flareOfchoice=flare1
	return flare1 
	
		elseif three== 1 then
		flareOfchoice=flare2
		return flare2
			else
			flareOfchoice=flare3
			return flare3

			end

end

	local flareOfchoice=flare1
	boolAimFromWeaponFixxed=false
function script.AimFromWeapon1() 	
if boolAimFromWeaponFixxed== false then
flareOfchoice=chooseYourFlare()
boolAimFromWeaponFixxed=true
end
return flareOfchoice	

 end
	


function script.QueryWeapon1() 
return flareOfchoice
				
end
	
	function script.AimWeapon1( heading, pitch )
		
	
	   return true
	   end
	   


	
	
	function script.FireWeapon1()
	boolAimFromWeaponFixxed=false
	EmitSfx(flareOfchoice,1025)
	Sleep(150)
	EmitSfx(flareOfchoice,1025)
	Sleep(150)
	EmitSfx(flareOfchoice,1025)
	Sleep(150)
	EmitSfx(flareOfchoice,1025)

	end
