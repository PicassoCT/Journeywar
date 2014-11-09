--Script Victory Statue
local jVflow1=piece"jVflow1"
local jVflow2=piece"jVflow2"
local jVflow3=piece"jVflow3"
local jVflow4=piece"jVflow4"
local jVflow5=piece"jVflow5"
local jVflow6=piece"jVflow6"
local jVictoryUp=piece"jVictoryUp"
local jVictory=piece"jVictory"
--this is a test

function bloom()
randY=math.random(0,360)
a=1024
--Spring.Echo(a)
b=math.bit_bits(a, 5)
--Spring.Echo(b)
Turn(jVictory,y_axis,math.rad(randY),12)
WaitForTurn(jVictory,y_axis)
Turn(jVictoryUp,z_axis,math.rad(-36),7)
Move(jVictoryUp,x_axis,21,5)
Move(jVictoryUp,y_axis,-35,5)
Move(jVictoryUp,z_axis,-5,5)
WaitForMove(jVictoryUp,x_axis)
WaitForMove(jVictoryUp,y_axis)
WaitForMove(jVictoryUp,z_axis)
WaitForTurn(jVictoryUp,z_axis)

Move(jVictory,y_axis,-150,40)
WaitForMove(jVictory,y_axis)
randSpin=math.random(7,11)
Spin(jVictory,y_axis,math.rad(-20),randSpin)
Show(jVflow1)                 
Show(jVflow2)                 
Show(jVflow3)                 
Show(jVflow4)                 
Show(jVflow5)                 
Show(jVflow6)  
Show(jVictory)
Spring.PlaySoundFile("sounds/jvict/jvictorious.wav")
Move(jVictory,y_axis,-100,24)
WaitForMove(jVictory,y_axis)
Move(jVictory,y_axis,-50,12)
WaitForMove(jVictory,y_axis)
Move(jVictory,y_axis,0,4)
WaitForMove(jVictory,y_axis)
StopSpin(jVictory,y_axis,5)
Sleep(2380)

four=4.1
Turn(jVflow1,x_axis,math.rad(-92),four)

four=3.9
Turn(jVflow2,x_axis,math.rad(96),four)

four=3.6
Turn(jVflow4,z_axis,math.rad(58),four)
four=four*2
Turn(jVflow4,x_axis,math.rad(-34),four)

four=4.3
Turn(jVflow3,z_axis,math.rad(-87),four)
four=four*2
Turn(jVflow3,x_axis,math.rad(-7),four)
Turn(jVflow3,y_axis,math.rad(-22),four)
-------------------------------------------------
four=4.15
Turn(jVflow5,z_axis,math.rad(-101),four)
four=four/2
Turn(jVflow5,y_axis,math.rad(51),four)
four=4.02
Turn(jVflow5,x_axis,math.rad(-29),four)

Turn(jVflow6,x_axis,math.rad(32),four)
Turn(jVflow6,y_axis,math.rad(22),four)
Turn(jVflow6,z_axis,math.rad(92),four)
----------------------------------------------------
Show(jVictoryUp)
Move(jVictoryUp,y_axis,0,35)
Turn(jVictoryUp,z_axis,math.rad(0),17)
Move(jVictoryUp,x_axis,0,25)
Move(jVictoryUp,z_axis,0,25)

WaitForMove(jVictoryUp,y_axis)
Sleep(9500)


Explode(jVflow1,SFX.FALL)
Explode(jVflow2,SFX.FALL)
Explode(jVflow3,SFX.FALL)
Explode(jVflow4,SFX.FALL)
Explode(jVflow5,SFX.FALL)
Explode(jVflow6,SFX.FALL)
Hide( jVflow1)                 
Hide( jVflow2)                 
Hide( jVflow3)                 
Hide( jVflow4)                 
Hide( jVflow5)                 
Hide( jVflow6) 
Sleep(6000)

end


function script.Create()
--Spring.Echo("weee... im born")

Hide( jVflow1)                 
Hide( jVflow2)                 
Hide( jVflow3)                 
Hide( jVflow4)                 
Hide( jVflow5)                 
Hide( jVflow6)                 
Hide( jVictoryUp)                 
Hide( jVictory)
StartThread(bloom)                 
end


function script.Killed()
----Spring.Echo("weee... i die")
end