--a wild function appears
include "createCorpse.lua"

flare1 =piece"flare1"
rotator=piece"rotator"
function script.Create()
Hide(flare1)
StartThread(emitFog)
StartThread(emitSound)

end

function emitFog()
Spin(rotator,y_axis,math.rad(360),0)
	while(true) do
	dice=math.random(0,1)
	if dice==1 then EmitSfx(flare1,1024)end
	randtime=math.ceil(math.random(5,25))
	Sleep(randtime)
	end
end 

function emitSound()
	while(true) do
	dice=math.random(1,2)
		if dice==1 then
		Spring.PlaySoundFile("sounds/jjam/jjam1.wav") 

		else
		Spring.PlaySoundFile("sounds/jjam/jjam2.wav") 

		end



	rest=math.ceil(math.random(10024,90000))
	Sleep(rest)
	end
end


function script.Killed()

end