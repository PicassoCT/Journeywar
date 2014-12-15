include"suddenDeath.lua"

Wheel1 =piece "Wheel1"
Wheel2 =piece "Wheel2"
Low1 = piece "Low1"
Low2 = piece "Low2"


function littleCarsGoingBackAndForth()
while true do
Move(Low1,z_axis,120,45)
Move(Low2,z_axis,-110,45)
WaitForMove(Low2,z_axis)
WaitForMove(Low1,z_axis)
Move(Low1,z_axis,0,0)
Move(Low2,z_axis,0,0)
rand=math.ceil(math.random(10,1000))
Sleep(rand)
end

end


function sound()
while(true) do
Spring.PlaySoundFile("sounds/ctransithub/traffic.wav",0.8)
Sleep(3500)
dice=math.random(1,128)
	if dice== 99 then
	Spring.PlaySoundFile("sounds/ctransithub/trafficnodepolice.wav",0.8)
	Sleep(4000)

	end


end

end

function script.Create()
StartThread(sound)
StartThread(littleCarsGoingBackAndForth)

Spin(Wheel1,z_axis,math.rad(-70),0)
Spin(Wheel2,z_axis,math.rad(70),0)
--StartThread(main)
end
function script.Killed(recentDamage,_)
suddenDeath(unitID,recentDamage)
return 0
end