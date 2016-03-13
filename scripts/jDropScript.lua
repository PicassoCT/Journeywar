include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
MoveIt=piece"MoveIt"
Para=piece"Para"
fruit={}
for i=1,19 do
name="fruit"..i
fruit[i]=piece(name)

end

function script.Create()
for i=1,19 do

Hide(fruit[i])
end



Spin(MoveIt,y_axis,math.rad(math.random(1,22)),0)

StartThread(onTheMove)
StartThread(swingLow)
x=math.ceil(math.random(1,19))
Show(fruit[x])

end

function onTheMove()
Spring.SetUnitBlocking(unitID,false)

Up=math.random(800,1200)

Move(MoveIt,y_axis,Up,0,true)
Move(MoveIt,y_axis,0,math.random(2,5))
WaitForMove(MoveIt,y_axis)
Hide(Para)
dice=math.ceil(math.random(20000,50000))
Sleep(dice)
Spring.DestroyUnit(unitID,true,true)
end

function swingLow()
	while true do
	xval=math.random(1,5)
	zval=math.random(1,5)
	deci= 1
	if math.random(0,1)==1 then deci=-1 end

	Turn(MoveIt,x_axis,math.rad(xval),0.1)
	Turn(MoveIt,z_axis,math.rad(zval*deci),0.1)
	if math.abs(xval) > math.abs(zval) then
	WaitForTurn(MoveIt,x_axis)
	else
	WaitForTurn(MoveIt,z_axis)
	end
	Sleep(100)
	Turn(MoveIt,x_axis,math.rad(xval*-1),0.1)
	Turn(MoveIt,z_axis,math.rad(zval*deci*-1),0.1)
	if math.abs(xval) > math.abs(zval) then
	WaitForTurn(MoveIt,x_axis)
	else
	WaitForTurn(MoveIt,z_axis)
	end
	Sleep(100)
	end
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end




function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end

