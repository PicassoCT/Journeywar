
center =piece "center"
dustemit1 =piece "dustemit1"
dustemit2 =piece "dustemit2"
SIG_IDLE=4
shells={}
for i=1,40,1 do
shells[i]={}
tempString= "Shell"..i
shells[i]=piece (tempString)
end


blinkers={}
for i=1,39,1 do
blinkers[i]={}
tempString= "blink"..i
blinkers[i]=piece (tempString)
end



SIG_MOVE=1
SIG_BLINK=2
tail={}
for i=1,5,1 do
tail[i]={}
tempString= "tail"..i
tail[i]=piece (tempString)
end

function dice()
i=math.random(0,1)
if i==1 then
return true
else
return false
end
end

function dustemitters()

	if dice()==true then
	
		if dice()== true then
		EmitSfx(dustemit1,1024)
		EmitSfx(dustemit2,1024)
		else
		EmitSfx(dustemit1,1025)
		EmitSfx(dustemit2,1027)
		end
	end
end
function script.Create()
StartThread(moveIt)
 
end

function blinky()
SetSignalMask(SIG_BLINK)
while(true)do


		for i=1,table.getn(blinkers),1 do
		    
			if dice() == true then
				if dice() == true then
				Show(blinkers[i])
			
				end
			else
			Hide(blinkers[i])
			end
			if i > 29 then
	
			Hide(shells[i])
			end
		end
		for i=1,table.getn(shells),1 do
			if dice() == true then

			Show(shells[i])
			
			else

			Hide(shells[i])
			end
			if i > 29 then
	
			Hide(shells[i])
			end
		end
		hider=math.random(100,800)
		Sleep(hider)	
	end
end


function primitiveTail()
dustemitters()
ty=0
ty=math.random(4,19)
for i=1,table.getn(tail),1 do
Turn(tail[i],y_axis,math.rad(ty),0.3)
end
WaitForTurn(tail[1],y_axis)
for i=1,table.getn(tail),1 do
Turn(tail[i],y_axis,math.rad(-1*ty),0.3)
end
WaitForTurn(tail[(table.getn(tail))],y_axis)



end
lastValue=math.random(-25,25)
function lessprimitiveTail()

generator=0
	if lastValue < 0 then
  generator=math.random(0,25)
  else
  generator=math.random(-25,0)
  end
  Turn(tail[1],y_axis,math.rad(generator),0.3)
  Turn(tail[2],y_axis,math.rad(generator*-1),0.3)
  lastValue=generator*-1
  generator=generator- math.random(-10,10)
  Turn(tail[3],y_axis,math.rad(generator),0.3)
  Turn(tail[4],y_axis,math.rad(generator*-1),0.3)
  Turn(tail[5],y_axis,math.rad(generator%5),0.3)
  WaitForTurn(tail[1],y_axis)
  dicero=math.random(0,2)
  if dicero == 0 then
  for i=1,table.getn(tail),1 do
  Turn(tail[i],y_axis,math.rad(7),0.5)
  end
  WaitForTurn(tail[1],y_axis)
  elseif dicero== 2 then
  for i=1,table.getn(tail),1 do
  Turn(tail[i],y_axis,math.rad(-7),0.5)
  end
  WaitForTurn(tail[1],y_axis)
 end
end
boolisMoving=false

function moveIt()
while(true) do
gen=math.random(15,25)


if boolisMoving==true then
Turn(center,y_axis,math.rad(gen),0.8)
primitiveTail()
WaitForTurn(center,y_axis)
else
lessprimitiveTail()
end



if boolisMoving==true then
Turn(center,y_axis,math.rad(gen*-1),2)
primitiveTail()
WaitForTurn(center,y_axis)
else
lessprimitiveTail()
end

end
end

function script.StartMoving()
Signal(SIG_IDLE)



Signal(SIG_BLINK)
StartThread(blinky)
StartThread(delayedBoolTrue)

end
function delayedBoolFalse()
Sleep(1000)
boolisMoving=false


end

function idle()
SetSignalMask(SIG_IDLE)
Move(center,y_axis,61,14)
Turn(center,x_axis,math.rad(40),0.3)
Sleep(1000)
Spring.PlaySoundFile("sounds/beafeater/rattle.wav")
Sleep(4000)
Move(center,y_axis,0,7)
Turn(center,x_axis,math.rad(0),3)
end

function delayedBoolTrue()
Sleep(1000)
boolisMoving=true

end

function script.StopMoving()
Signal(SIG_BLINK)
StartThread(idle)

if dice() == true then	
StartThread(delayedBoolFalse)
end
end


---AIMING & SHOOTING---
-----------------------------------------WEAPON ONE ----------------------------



function script.Killed(recentDamage, maxHealth)

		return 1 
end