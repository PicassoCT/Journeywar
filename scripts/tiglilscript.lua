--All Praise goes to Knorke. Just look under Awesome in the Wiki.


--Those who enter: Beware, only mindfucks here, i swear!
-- i worked really hard to de-robotimize these - and i think i succeded. 
tldrum = 		piece "tldrum"
dancepivot = 	piece "dancepivot"

local aimpivot = 	piece "aimpivot"
local deathpivot = 	piece "deathpivot"
local tigLil = 	piece "tigLil"
local tlHead = 	piece "tlHead"
local tlhairup = 	piece "tlhairup"
local tlhairdown =	piece "tlhairdown"
local tlarm = 		piece "tlarm"
local tlarmr = 	piece "tlarmr"
local tlsparksemit= piece "tlsparksemit"
local tlsparksemit2=piece "tlsparksemit2"
local tllegUp = 	piece "tllegUp"
local tllegLow = 	piece "tllegLow"
local tllegUpR = 	piece "tllegUpR"
local tllegLowR = 	piece "tllegLowR"
local tlpole =piece "tlpole"
local tlharp =piece "tlharp"
local tlflute =piece "tlflute"
local tldancedru =piece "tldancedru"

local AMBUSHLOADTIME=30000
local AMBUSHTIME=9000
local RELOADTIME=900
local COOLDOWNTIMER=0
Sleeper= 6
tempsleep=0
randomvalue=-1
temphair=1
local tempclap=math.random(3,12)
local tempRand=1
local SIG_WALK = 1	-- signal for the walk animation thread
local SIG_AIM = 2 -- signal for the weapon aiming thread
local SIG_WHIR = 4
local SIG_IDLE =8
local SIG_SWING=16
local SIG_HAIRWIND=32
local boolKill=false
local SIG_ONTHEMOVE=64
local SIG_INCIRCLE=128
local SIG_TALKHEAD=256
local SIG_GESTE=512
local SIG_PEACE= 1024
Heading=0
boolANewAttack=true
howlong=1
---Signals to be spread

---------------------IdleStance10-Fucntions-------


function drumClapOverhead()
	
	
	
	Turn(tigLil,x_axis,math.rad(-18),4)
	Turn(tigLil,y_axis,math.rad(0),4)
	Turn(tigLil,z_axis,math.rad(0),4)
	
	
	Turn(tlHead,x_axis,math.rad(-13),4)
	Turn(tlHead,y_axis,math.rad(0),4)
	Turn(tlHead,z_axis,math.rad(0),4)
	
	tempRand=math.random(-12,18)
	Turn(tlhairup,x_axis,math.rad(39),4)
	Turn(tlhairup,y_axis,math.rad(tempRand),4)
	tempRand=math.random(-7,7)
	Turn(tlhairup,z_axis,math.rad(tempRand),4)
	
	Turn(tlhairdown,x_axis,math.rad(-46),4)
	
	Turn(tlarm,x_axis,math.rad(-17),4)
	Turn(tlarm,y_axis,math.rad(-104),7)
	Turn(tlarm,z_axis,math.rad(-117),6)
	
	
	Turn(tlarmr,x_axis,math.rad(180),6)
	Turn(tlarmr,y_axis,math.rad(-87),6)
	Turn(tlarmr,z_axis,math.rad(-59),5)
	
	Turn(tllegUp,x_axis,math.rad(21),4)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),2)
	
	
	Turn(tllegLow,x_axis,math.rad(0),4)
	Turn(tllegLow,y_axis,math.rad(0),4)
	Turn(tllegLow,z_axis,math.rad(0),4)
	
	
	Turn(tllegUpR,x_axis,math.rad(45),4)
	Turn(tllegUpR,y_axis,math.rad(15),3)
	Turn(tllegUpR,z_axis,math.rad(0),2)
	
	Turn(tllegLowR,x_axis,math.rad(89),4)
	Turn(tllegLowR,y_axis,math.rad(0),4)
	Turn(tllegLowR,z_axis,math.rad(0),4)
	
	
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	
	
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlHead,y_axis) 
	WaitForTurn(tlHead,z_axis) 
	
	
	--WaitForTurn(tlhairup,x_axis) 
	--WaitForTurn(tlhairup,y_axis) 
	
	--WaitForTurn(tlhairup,z_axis) 
	
	--WaitForTurn(tlhairdown,x_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	
	
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	--------------- Clap---------------
	
	
	
	Turn(tigLil,x_axis,math.rad(-12),4)
	Turn(tigLil,y_axis,math.rad(0),4)
	Turn(tigLil,z_axis,math.rad(0),4)
	
	
	Turn(tlHead,x_axis,math.rad(5),4)
	Turn(tlHead,y_axis,math.rad(15),4)
	Turn(tlHead,z_axis,math.rad(0),4)
	
	
	tempRand=math.random(-55,-20)
	Turn(tlhairup,x_axis,math.rad(tempRand),3)
	tempRand=math.random(-27,5)
	Turn(tlhairup,y_axis,math.rad(tempRand),4)
	tempRand=math.random(-7,7)
	Turn(tlhairup,z_axis,math.rad(tempRand),4)
	
	tempRand=math.random(-36,26)
	Turn(tlhairdown,x_axis,math.rad(tempRand),4)
	
	Turn(tlarm,x_axis,math.rad(-17),4)
	Turn(tlarm,y_axis,math.rad(-96),5)
	Turn(tlarm,z_axis,math.rad(-117),5)
	
	
	Turn(tlarmr,x_axis,math.rad(182),4)
	Turn(tlarmr,y_axis,math.rad(-101),4)
	Turn(tlarmr,z_axis,math.rad(-67),4)
	
	Turn(tllegUp,x_axis,math.rad(-47),5)
	Turn(tllegUp,y_axis,math.rad(15),4)
	Turn(tllegUp,z_axis,math.rad(0),4)
	
	
	Turn(tllegLow,x_axis,math.rad(91),7)
	Turn(tllegLow,y_axis,math.rad(0),4)
	Turn(tllegLow,z_axis,math.rad(0),4)
	
	
	Turn(tllegUpR,x_axis,math.rad(10),5)
	Turn(tllegUpR,y_axis,math.rad(15),4)
	Turn(tllegUpR,z_axis,math.rad(0),4)
	
	Turn(tllegLowR,x_axis,math.rad(4),4)
	Turn(tllegLowR,y_axis,math.rad(0),4)
	Turn(tllegLowR,z_axis,math.rad(0),4)
	
	
	
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	
	
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlHead,y_axis) 
	WaitForTurn(tlHead,z_axis) 
	
	--WaitForTurn(tlhairup,x_axis) 
	
	--WaitForTurn(tlhairup,y_axis) 
	
	--WaitForTurn(tlhairup,z_axis) 
	
	
	--WaitForTurn(tlhairdown,x_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	
	
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	
	
	
	
	
	----------------------------Retour-----------------
	
	
	Turn(tigLil,x_axis,math.rad(-18),4)
	Turn(tigLil,y_axis,math.rad(0),4)
	Turn(tigLil,z_axis,math.rad(0),4)
	
	
	Turn( tlHead, x_axis,math.rad(-13),4)
	Turn( tlHead, y_axis,math.rad(0),4)
	Turn( tlHead, z_axis,math.rad(0),4)
	
	tempRand=math.random(-12,18)
	Turn(tlhairup,x_axis,math.rad(39),4)
	Turn(tlhairup,y_axis,math.rad(tempRand),4)
	tempRand=math.random(-7,7)
	Turn(tlhairup,z_axis,math.rad(tempRand),4)
	
	Turn(tlhairdown,x_axis,math.rad(-46),4)
	
	Turn(tlarm,x_axis,math.rad(-17),4)
	Turn(tlarm,y_axis,math.rad(-104),6)
	Turn(tlarm,z_axis,math.rad(-117),7)
	
	
	Turn(tlarmr,x_axis,math.rad(180),8)
	Turn(tlarmr,y_axis,math.rad(-87),6)
	Turn(tlarmr,z_axis,math.rad(-59),5)
	
	Turn(tllegUp,x_axis,math.rad(21),4)
	Turn(tllegUp,y_axis,math.rad(0),4)
	Turn(tllegUp,z_axis,math.rad(0),4)
	
	
	Turn(tllegLow,x_axis,math.rad(0),5)
	Turn(tllegLow,y_axis,math.rad(0),4)
	Turn(tllegLow,z_axis,math.rad(0),4)
	
	
	Turn(tllegUpR,x_axis,math.rad(45),7)
	Turn(tllegUpR,y_axis,math.rad(15),5)
	Turn(tllegUpR,z_axis,math.rad(0),4)
	
	Turn(tllegLowR,x_axis,math.rad(89),7)
	Turn(tllegLowR,y_axis,math.rad(0),4)
	Turn(tllegLowR,z_axis,math.rad(0),4)
	
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	
	
	WaitForTurn( tlHead, x_axis) 
	WaitForTurn( tlHead, y_axis) 
	WaitForTurn( tlHead, z_axis) 
	
	--WaitForTurn(tlhairup,x_axis) 
	--WaitForTurn(tlhairup,y_axis) 
	
	--WaitForTurn(tlhairup,z_axis) 
	
	--WaitForTurn(tlhairdown,x_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	
	
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	
end

function drumClapFront()
	
	
	
	
	Turn(tigLil,x_axis,math.rad(25),3)
	Turn(tigLil,y_axis,math.rad(0),4)
	Turn(tigLil,z_axis,math.rad(0),4)
	
	
	Turn(tlHead,x_axis,math.rad(55),4)
	Turn(tlHead,y_axis,math.rad(-6),4)
	Turn(tlHead,z_axis,math.rad(0),4)
	
	tempRand=math.random(55,80)
	Turn(tlhairup,x_axis,math.rad(tempRand),7)
	tempRand=math.random(-27,19)
	Turn(tlhairup,y_axis,math.rad(tempRand),2)
	tempRand=math.random(-5,45)
	Turn(tlhairup,z_axis,math.rad(tempRand),5)
	
	tempRand=math.random(34,52)
	
	Turn(tlhairdown,x_axis,math.rad(tempRand),3)
	
	Turn(tlarm,x_axis,math.rad(0),4)
	Turn(tlarm,y_axis,math.rad(-82),4)
	Turn(tlarm,z_axis,math.rad(-206),4)
	
	
	Turn(tlarmr,x_axis,math.rad(54),4)
	Turn(tlarmr,y_axis,math.rad(-174),4)
	Turn(tlarmr,z_axis,math.rad(-72),4)
	
	tempRand=math.random(-30,6)
	Turn(tllegUp,x_axis,math.rad(tempRand),5)
	Turn(tllegUp,y_axis,math.rad(15),4)
	Turn(tllegUp,z_axis,math.rad(0),4)
	
	Turn(tllegLow,x_axis,math.rad(0),4)
	Turn(tllegLow,y_axis,math.rad(0),4)
	Turn(tllegLow,z_axis,math.rad(0),4)
	
	tempRand=math.random(-101,-84)
	Turn(tllegUpR,x_axis,math.rad(tempRand),5)
	Turn(tllegUpR,y_axis,math.rad(15),4)
	Turn(tllegUpR,z_axis,math.rad(0),4)
	
	tempRand=math.random(120,148)
	Turn(tllegLowR,x_axis,math.rad(tempRand),8)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	
	
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	
	
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlHead,y_axis) 
	WaitForTurn(tlHead,z_axis) 
	
	
	--WaitForTurn(tlhairup,x_axis) 
	
	--WaitForTurn(tlhairup,y_axis) 
	--WaitForTurn(tlhairup,z_axis) 
	
	
	--WaitForTurn(tlhairdown,x_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	
	
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	--------------- UnClap---------------
	
	Turn(tigLil,x_axis,math.rad(15),4)
	Turn(tigLil,y_axis,math.rad(0),4)
	Turn(tigLil,z_axis,math.rad(0),4)
	
	
	Turn(tlHead,x_axis,math.rad(36),4)
	Turn(tlHead,y_axis,math.rad(-6),4)
	Turn(tlHead,z_axis,math.rad(0),4)
	
	tempdown=math.random(-105,-95)
	Turn(tlhairup,x_axis,math.rad(tempdown),4)-- -15
	Turn(tlhairup,y_axis,math.rad(5),4)
	Turn(tlhairup,z_axis,math.rad(0),4)
	tempDownO=math.random(-75,-68)
	Turn(tlhairdown,x_axis,math.rad(tempDownO),5)-- -58
	
	Turn(tlarm,x_axis,math.rad(0),4)
	Turn(tlarm,y_axis,math.rad(-87),4)
	Turn(tlarm,z_axis,math.rad(-190),4)
	
	
	Turn(tlarmr,x_axis,math.rad(77),6)
	Turn(tlarmr,y_axis,math.rad(-161),6)
	Turn(tlarmr,z_axis,math.rad(-67),6)
	
	Turn(tllegUp,x_axis,math.rad(-75),5)
	Turn(tllegUp,y_axis,math.rad(15),4)
	Turn(tllegUp,z_axis,math.rad(0),4)
	
	
	Turn(tllegLow,x_axis,math.rad(91),8)
	Turn(tllegLow,y_axis,math.rad(0),4)
	Turn(tllegLow,z_axis,math.rad(0),4)
	
	
	Turn(tllegUpR,x_axis,math.rad(-19),2)
	Turn(tllegUpR,y_axis,math.rad(15),3)
	Turn(tllegUpR,z_axis,math.rad(0),4)
	
	Turn(tllegLowR,x_axis,math.rad(4),4)
	Turn(tllegLowR,y_axis,math.rad(0),4)
	Turn(tllegLowR,z_axis,math.rad(0),4)
	
	
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	
	
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlHead,y_axis) 
	WaitForTurn(tlHead,z_axis) 
	
	
	--WaitForTurn(tlhairup,x_axis) 
	--WaitForTurn(tlhairup,y_axis) 
	--WaitForTurn(tlhairup,z_axis) 
	
	--WaitForTurn(tlhairdown,x_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	
	
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	------------------------------------------ 
	
	
	
	
	Turn(tigLil,x_axis,math.rad(25),4)
	Turn(tigLil,y_axis,math.rad(0),4)
	Turn(tigLil,z_axis,math.rad(0),4)
	
	
	Turn(tlHead,x_axis,math.rad(55),4)
	Turn(tlHead,y_axis,math.rad(-6),4)
	Turn(tlHead,z_axis,math.rad(0),4)
	
	tempRand=math.random(-83,73)
	Turn(tlhairup,x_axis,math.rad(tempRand),4)
	tempRand=math.random(-27,19)
	Turn(tlhairup,y_axis,math.rad(tempRand),4)
	tempRand=math.random(-5,45)
	Turn(tlhairup,z_axis,math.rad(tempRand),4)
	
	tempRand=math.random(4,52)
	
	Turn(tlhairdown,x_axis,math.rad(tempRand),4)
	
	Turn(tlarm,x_axis,math.rad(0),4)
	Turn(tlarm,y_axis,math.rad(-82),4)
	Turn(tlarm,z_axis,math.rad(-206),4)
	
	
	Turn(tlarmr,x_axis,math.rad(54),4)
	Turn(tlarmr,y_axis,math.rad(-174),4)
	Turn(tlarmr,z_axis,math.rad(-72),4)
	
	tempRand=math.random(-30,6)
	Turn(tllegUp,x_axis,math.rad(tempRand),4)
	Turn(tllegUp,y_axis,math.rad(15),4)
	Turn(tllegUp,z_axis,math.rad(0),4)
	
	Turn(tllegLow,x_axis,math.rad(0),4)
	Turn(tllegLow,y_axis,math.rad(0),4)
	Turn(tllegLow,z_axis,math.rad(0),4)
	
	tempRand=math.random(-101,-84)
	Turn(tllegUpR,x_axis,math.rad(tempRand),4)
	Turn(tllegUpR,y_axis,math.rad(15),4)
	Turn(tllegUpR,z_axis,math.rad(0),4)
	
	tempRand=math.random(120,148)
	Turn(tllegLowR,x_axis,math.rad(tempRand),4)
	Turn(tllegLowR,y_axis,math.rad(0),4)
	Turn(tllegLowR,z_axis,math.rad(0),4)
	
	
	
	
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	
	
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlHead,y_axis) 
	WaitForTurn(tlHead,z_axis) 
	
	
	--WaitForTurn(tlhairup,x_axis) 
	
	--WaitForTurn(tlhairup,y_axis) 
	
	--WaitForTurn(tlhairup,z_axis) 
	
	
	
	--WaitForTurn(tlhairdown,x_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	
	
	
	Sleep(60)
	
	
end


function danceEnd()
	
	
	Turn (tigLil,x_axis,math.rad(0),3)
	Turn (tigLil,y_axis,math.rad(0),3)
	Turn (tigLil,z_axis,math.rad(0),3)
	
	
	Turn (tlHead,x_axis,math.rad(0),3)
	Turn (tlHead,y_axis,math.rad(35),3)
	Turn (tlHead,z_axis,math.rad(0),3)
	
	Turn (tlhairup,x_axis,math.rad(0 ),3)
	Turn (tlhairup,y_axis,math.rad(-135),3)
	Turn (tlhairup,z_axis,math.rad(-279),3)
	
	Turn (tlhairdown,x_axis,math.rad(45),3)
	
	Turn (tlarm,x_axis,math.rad(0),3)
	Turn (tlarm,y_axis,math.rad(30),3)
	Turn (tlarm,z_axis,math.rad(39),3)
	
	Turn (tlarmr,x_axis,math.rad(0),3)
	Turn (tlarmr,y_axis,math.rad(37),3)
	Turn (tlarmr,z_axis,math.rad(0),3)
	
	
	Turn (tllegUp,x_axis,math.rad(-4),3)
	Turn (tllegUp,y_axis,math.rad(-1),3)
	Turn (tllegUp,z_axis,math.rad(12),3)
	
	Turn (tllegLow,x_axis,math.rad(0),3)
	
	
	Turn (tllegUpR,x_axis,math.rad(4),3)
	Turn (tllegUpR,y_axis,math.rad(0),3)
	Turn (tllegUpR,z_axis,math.rad(-8),3)
	
	Turn (tllegLowR,x_axis,math.rad(0),3)
	
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tigLil,y_axis) 
	WaitForTurn (tigLil,z_axis) 
	
	
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlHead,y_axis) 
	WaitForTurn (tlHead,z_axis) 
	
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairup,y_axis) 
	WaitForTurn (tlhairup,z_axis) 
	
	WaitForTurn (tlhairdown,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	
	WaitForTurn (tllegLow,x_axis) 
	
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	
	WaitForTurn (tllegLowR,x_axis) 
	
	
	
	
	Turn (tlHead,x_axis,math.rad(0),3)
	Turn (tlHead,y_axis,math.rad(3),3)
	Turn (tlHead,z_axis,math.rad(0),3)
	
	Turn (tlhairup,x_axis,math.rad(0 ),3)
	Turn (tlhairup,y_axis,math.rad(37),3)
	Turn (tlhairup,z_axis,math.rad(279),3)
	
	Turn (tlhairdown,x_axis,math.rad(-60),3)
	
	Turn (tlarm,x_axis,math.rad(0),3)
	Turn (tlarm,y_axis,math.rad(0),3)
	Turn (tlarm,z_axis,math.rad(23),3)
	
	Turn (tlarmr,x_axis,math.rad(0),3)
	Turn (tlarmr,y_axis,math.rad(0),3)
	Turn (tlarmr,z_axis,math.rad(-30),3)
	
	
	Turn (tllegUp,x_axis,math.rad(-45),3)
	Turn (tllegUp,y_axis,math.rad(0),3)
	Turn (tllegUp,z_axis,math.rad(12),3)
	
	Turn (tllegLow,x_axis,math.rad(0),3)
	
	
	Turn (tllegUpR,x_axis,math.rad(90),3)
	Turn (tllegUpR,y_axis,math.rad(0),3)
	Turn (tllegUpR,z_axis,math.rad(-8),3)
	
	
	Turn (tllegLowR,x_axis,math.rad(0),3)
	
	
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlHead,y_axis) 
	WaitForTurn (tlHead,z_axis) 
	
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairup,y_axis) 
	WaitForTurn (tlhairup,z_axis) 
	
	WaitForTurn (tlhairdown,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	
	WaitForTurn (tllegLow,x_axis) 
	
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	
	WaitForTurn (tllegLowR,x_axis) 
	
	Move(tigLil,y_axis,-8,19)
	
	Turn (tigLil,x_axis,math.rad(15),3)
	Turn (tigLil,y_axis,math.rad(0),3)
	Turn (tigLil,z_axis,math.rad(0),3)
	
	
	Turn (tlHead,x_axis,math.rad(41),3)
	Turn (tlHead,y_axis,math.rad(-15),3)
	Turn (tlHead,z_axis,math.rad(0),3)
	
	Turn (tlhairup,x_axis,math.rad(0),3)
	Turn (tlhairup,y_axis,math.rad(37),3)
	Turn (tlhairup,z_axis,math.rad(279),3)
	
	Turn (tlhairdown,x_axis,math.rad(-60),3)
	
	Turn (tlarm,x_axis,math.rad(0),3)
	Turn (tlarm,y_axis,math.rad(52),3)
	Turn (tlarm,z_axis,math.rad(14),3)
	
	Turn (tlarmr,x_axis,math.rad(0),3)
	Turn (tlarmr,y_axis,math.rad(51),3)
	Turn (tlarmr,z_axis,math.rad(-30),3)
	
	
	Turn (tllegUp,x_axis,math.rad(-114),3)
	Turn (tllegUp,y_axis,math.rad(1),3)
	Turn (tllegUp,z_axis,math.rad(12),3)
	
	Turn (tllegLow,x_axis,math.rad(98),3)
	
	
	Turn (tllegUpR,x_axis,math.rad(47),3)
	Turn (tllegUpR,y_axis,math.rad(0),3)
	Turn (tllegUpR,z_axis,math.rad(0),3)
	
	Turn (tllegLowR,x_axis,math.rad(20),3)
	Sleep(128)
	
	
	Turn (tlHead,x_axis,math.rad(41),3)
	Turn (tlHead,y_axis,math.rad(21),3)
	Turn (tlHead,z_axis,math.rad(0),3)
	
	Turn (tlhairup,x_axis,math.rad(-26 ),3)
	Turn (tlhairup,y_axis,math.rad(109),3)
	Turn (tlhairup,z_axis,math.rad(-286),3)
	
	Turn (tlhairdown,x_axis,math.rad(-49),3)
	WaitForMove(tigLil,y_axis)
	
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tigLil,y_axis) 
	WaitForTurn (tigLil,z_axis) 
	
	
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlHead,y_axis) 
	WaitForTurn (tlHead,z_axis) 
	
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairup,y_axis) 
	WaitForTurn (tlhairup,z_axis) 
	
	WaitForTurn (tlhairdown,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	
	WaitForTurn (tllegLow,x_axis) 
	
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	
	WaitForTurn (tllegLowR,x_axis) 
	
	
	
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlHead,y_axis) 
	WaitForTurn (tlHead,z_axis) 
	
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairup,y_axis) 
	WaitForTurn (tlhairup,z_axis) 
	
	WaitForTurn (tlhairdown,x_axis) 
	
	Move(tigLil,y_axis,0,12)
	
	WaitForMove(tigLil,y_axis)
	
	
end

function danceTurnLeft()
	Signal(SIG_INCIRCLE)
	SetSignalMask(SIG_INCIRCLE)
	while (true) do
		
		
		---
		Turn (tigLil,x_axis,math.rad(-14),3)
		
		Turn (tigLil,z_axis,math.rad(0),3)
		
		Turn (tlHead,x_axis,math.rad(55),1)
		Turn (tlHead,y_axis,math.rad(-28),2)
		Turn (tlhairup,y_axis,math.rad(15),6)
		
		Turn (tlhairup,x_axis,math.rad(180),12)
		Turn (tlhairup,y_axis,math.rad(109),8)
		Turn (tlhairup,z_axis,math.rad(-270),14)
		
		tempHair=math.random(-28,30)
		Turn (tlhairdown,x_axis,math.rad(tempHair),3)
		Turn (tlarm,x_axis,math.rad(79),6)
		Turn (tlarm,y_axis,math.rad(28),3)
		Turn (tlarm,z_axis,math.rad(39),4)
		
		Turn (tlarmr,x_axis,math.rad(61),5)
		Turn (tlarmr,y_axis,math.rad(4),3)
		Turn (tlarmr,z_axis,math.rad(-22),3)
		
		
		Turn (tllegUp,x_axis,math.rad(-50),4)
		Turn (tllegUp,y_axis,math.rad(0),4)
		Turn (tllegUp,z_axis,math.rad(0),2)
		
		Turn (tllegLow,x_axis,math.rad(90),5)
		
		
		Turn (tllegUpR,x_axis,math.rad(14),6)
		Turn (tllegUpR,y_axis,math.rad(-18),2)
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		Turn (tllegLow,x_axis,math.rad(27),4)
		
		Sleep(250)
		
		Turn (tigLil,x_axis,math.rad(-14),3)
		
		Turn (tigLil,z_axis,math.rad(0),3)
		Turn (tlHead,x_axis,math.rad(22),1)
		Turn (tlHead,y_axis,math.rad(-47),2)
		Turn (tlhairup,y_axis,math.rad(15),6)
		Sleep(40)
		Turn (tlhairup,x_axis,math.rad(180),12)
		Turn (tlhairup,y_axis,math.rad(109),8)
		Turn (tlhairup,z_axis,math.rad(-270),14)
		
		tempHair=math.random(-28,30)
		Turn (tlhairdown,x_axis,math.rad(tempHair),3)
		Turn (tlarm,x_axis,math.rad(217),12)
		Turn (tlarm,y_axis,math.rad(28),3)
		Turn (tlarm,z_axis,math.rad(39),4)
		
		Turn (tlarmr,x_axis,math.rad(-34),5)
		Turn (tlarmr,y_axis,math.rad(4),3)
		Turn (tlarmr,z_axis,math.rad(-22),3)
		
		
		Turn (tllegUp,x_axis,math.rad(15),4)
		Turn (tllegUp,y_axis,math.rad(-11),4)
		Turn (tllegUp,z_axis,math.rad(10),2)
		
		Turn (tllegLow,x_axis,math.rad(-17),5)
		
		
		Turn (tllegUpR,x_axis,math.rad(-56),6)
		Turn (tllegUpR,y_axis,math.rad(-18),2)
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		Turn (tllegLow,x_axis,math.rad(113),4)
		Turn (tllegLow,y_axis,math.rad(18),4)
		
		Sleep(260)
		
		Turn (tigLil,x_axis,math.rad(-53),3)
		
		Turn (tigLil,z_axis,math.rad(0),3)
		
		Turn (tlHead,x_axis,math.rad(31),1)
		Turn (tlHead,y_axis,math.rad(-44),2)
		Turn (tlhairup,y_axis,math.rad(15),6)
		
		Turn (tlhairup,x_axis,math.rad(180),12)
		Turn (tlhairup,y_axis,math.rad(109),8)
		Turn (tlhairup,z_axis,math.rad(-270),14)
		
		tempHair=math.random(-28 ,30)
		Turn (tlhairdown,x_axis,math.rad(tempHair),3)
		Turn (tlarm,x_axis,math.rad(3),12)
		Turn (tlarm,y_axis,math.rad(-23),3)
		Turn (tlarm,z_axis,math.rad(39),4)
		
		Turn (tlarmr,x_axis,math.rad(-34),5)
		Turn (tlarmr,y_axis,math.rad(17),3)
		Turn (tlarmr,z_axis,math.rad(-22),3)
		
		
		Turn (tllegUp,x_axis,math.rad(64),4)
		Turn (tllegUp,y_axis,math.rad(0),4)
		Turn (tllegUp,z_axis,math.rad(10),2)
		
		Turn (tllegLow,x_axis,math.rad(97),8)
		
		
		Turn (tllegUpR,x_axis,math.rad(39),4)
		Turn (tllegUpR,y_axis,math.rad(0),2)
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		Turn (tllegLow,x_axis,math.rad(15),4)
		Turn (tllegLow,y_axis,math.rad(0),4)
		Turn (tllegLow,z_axis,math.rad(7),4)
		Sleep(250)
		Turn (tigLil,x_axis,math.rad(-14),3)
		
		Turn (tigLil,z_axis,math.rad(0),3)
		
		Turn (tlHead,x_axis,math.rad(55),1)
		Turn (tlHead,y_axis,math.rad(-28),2)
		Turn (tlhairup,y_axis,math.rad(15),6)
		
		Turn (tlhairup,x_axis,math.rad(180),12)
		Turn (tlhairup,y_axis,math.rad(109),8)
		Turn (tlhairup,z_axis,math.rad(-270),14)
		
		tempHair=math.random(-28 ,30)
		Turn (tlhairdown,x_axis,math.rad(tempHair),3)
		tempArm=math.random(55,80)
		Turn (tlarm,x_axis,math.rad(tempArm),6)
		Turn (tlarm,y_axis,math.rad(28),3)
		Turn (tlarm,z_axis,math.rad(39),4)
		
		tempArm=math.random(45,70)
		Turn (tlarmr,x_axis,math.rad(tempArm),5)
		Turn (tlarmr,y_axis,math.rad(4),3)
		Turn (tlarmr,z_axis,math.rad(-22),3)
		
		
		Turn (tllegUp,x_axis,math.rad(-50),4)
		Turn (tllegUp,y_axis,math.rad(0),4)
		Turn (tllegUp,z_axis,math.rad(0),2)
		
		Turn (tllegLow,x_axis,math.rad(90),5)
		
		tempLeg=math.random(-10,34)
		Turn (tllegUpR,x_axis,math.rad(tempLeg),6)
		Turn (tllegUpR,y_axis,math.rad(-18),2)
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		Turn (tllegLow,x_axis,math.rad(27),4)
		Sleep(250)
		
	end
	
end


function talkingHead()
	Signal(SIG_TALKHEAD)
	
	SetSignalMask(SIG_TALKHEAD)
	while(true) do
		for tlH=0,howlong,1 do
			rindRand=math.random(-5,10)
			speedRand=math.random(4,7)
			Turn(tlHead,x_axis,math.rad(rindRand),speedRand)
			rindRand=math.random(-4,4)
			Turn(tlHead,z_axis,math.rad(rindRand),4)
			wordLenght=math.random(40,280)
			Sleep(wordLenght)
		end
		nonTalk=math.random(400,2080)
		Sleep(nonTalk)
		
	end
	
	
end


function danceTurnRight()
	
	Signal(SIG_INCIRCLE)
	SetSignalMask(SIG_INCIRCLE)
	while (true) do
		
		
		---
		Turn (tigLil,x_axis,math.rad(-19),3)
		
		Turn (tigLil,z_axis,math.rad(-10),3)
		
		
		Turn (tlHead,x_axis,math.rad(14),2)
		Turn (tlHead,y_axis,math.rad(-12),2)--i
		Turn (tlHead,z_axis,math.rad(10),2)
		
		Turn (tlhairup,x_axis,math.rad(0),3)
		Turn (tlhairup,y_axis,math.rad(108),5)--i
		Turn (tlhairup,z_axis,math.rad(-265),11)
		
		Turn (tlhairdown,x_axis,math.rad(22),3)
		
		Turn (tlarm,x_axis,math.rad(58),6)
		Turn (tlarm,y_axis,math.rad(70),6)--i
		Turn (tlarm,z_axis,math.rad(39),4)
		
		Turn (tlarmr,x_axis,math.rad(11),3)
		Turn (tlarmr,y_axis,math.rad(-50),5)--i
		Turn (tlarmr,z_axis,math.rad(-1),3)
		
		
		Turn (tllegUp,x_axis,math.rad(31),3)
		Turn (tllegUp,y_axis,math.rad(-39),4)--i
		Turn (tllegUp,z_axis,math.rad(3),3)
		
		Turn (tllegLow,x_axis,math.rad(12),3)
		
		
		Turn (tllegUpR,x_axis,math.rad(-38),4)
		Turn (tllegUpR,y_axis,math.rad(31),3)--i
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		
		Turn (tllegLowR,x_axis,math.rad(2),3)
		
		Sleep(250)
		
		Turn (tlHead,x_axis,math.rad(-10),1)
		Turn (tlHead,y_axis,math.rad(21),2)
		tempHair=math.random(67,121)
		Turn (tlhairup,y_axis,math.rad(tempHair),7)
		
		
		Turn (tlhairup,z_axis,math.rad(-270),12)
		
		Turn (tlhairdown,x_axis,math.rad(22),2)
		
		Turn (tlarm,y_axis,math.rad(26),3)
		Turn (tlarm,z_axis,math.rad(28),3)
		
		Turn (tlarmr,x_axis,math.rad(11),3)
		Turn (tlarmr,y_axis,math.rad(-44),4)
		Turn (tlarmr,z_axis,math.rad(50),5)
		
		
		Turn (tllegUp,x_axis,math.rad(-50),5)
		Turn (tllegUp,y_axis,math.rad(0),3)
		Turn (tllegUp,z_axis,math.rad(0),3)
		
		Turn (tllegLow,x_axis,math.rad(90),8)
		
		
		Turn (tllegUpR,x_axis,math.rad(0),3)
		Turn (tllegUpR,y_axis,math.rad(0),3)
		Turn (tllegUpR,z_axis,math.rad(-7),1)
		
		Sleep(250)
		Turn (tlHead,x_axis,math.rad(-26),3)
		Turn (tlHead,y_axis,math.rad(14),3)
		Turn (tlHead,z_axis,math.rad(10),3)
		
		Turn (tlhairup,x_axis,math.rad(19),2)
		Turn (tlhairup,y_axis,math.rad(109),9)
		Turn (tlhairup,z_axis,math.rad(230),11)
		
		Turn (tlhairdown,x_axis,math.rad(-20),2)
		Turn (tlarm,x_axis,math.rad(58),4)
		Turn (tlarm,y_axis,math.rad(14),2)
		Turn (tlarm,z_axis,math.rad(39),3)
		
		Turn (tlarmr,x_axis,math.rad(11),3)
		Turn (tlarmr,y_axis,math.rad(-25),3)
		Turn (tlarmr,z_axis,math.rad(50),4)
		
		
		Turn (tllegUp,x_axis,math.rad(-7),5)
		Turn (tllegUp,y_axis,math.rad(0),5)
		Turn (tllegUp,z_axis,math.rad(3),5)
		
		Turn (tllegLow,x_axis,math.rad(12),4)
		
		
		Turn (tllegUpR,x_axis,math.rad(-43),5)
		Turn (tllegUpR,y_axis,math.rad(-24),4)
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		
		Sleep(250)
		
		Turn (tlHead,x_axis,math.rad(-10),1)
		Turn (tlHead,y_axis,math.rad(21),2)
		Turn (tlhairup,y_axis,math.rad(109),6)
		
		Turn (tlhairup,x_axis,math.rad(0),4)
		Turn (tlhairup,z_axis,math.rad(-270),5)
		
		Turn (tlhairdown,x_axis,math.rad(22),3)
		
		Turn (tlarm,y_axis,math.rad(26),3)
		Turn (tlarm,z_axis,math.rad(28),3)
		
		Turn (tlarmr,x_axis,math.rad(11),5)
		Turn (tlarmr,y_axis,math.rad(-114),3)
		Turn (tlarmr,z_axis,math.rad(-22),3)
		
		
		Turn (tllegUp,x_axis,math.rad(-50),4)
		Turn (tllegUp,y_axis,math.rad(0),4)
		Turn (tllegUp,z_axis,math.rad(0),2)
		
		Turn (tllegLow,x_axis,math.rad(90),5)
		
		
		Turn (tllegUpR,x_axis,math.rad(14),6)
		Turn (tllegUpR,y_axis,math.rad(-18),2)
		Turn (tllegUpR,z_axis,math.rad(-7),3)
		Turn (tllegLow,x_axis,math.rad(27),4)
		
		
		WaitForTurn (tlHead,x_axis) 
		WaitForTurn (tlHead,y_axis) 
		WaitForTurn (tlhairup,y_axis) 
		
		WaitForTurn (tlhairup,x_axis) 
		WaitForTurn (tlhairup,z_axis) 
		
		WaitForTurn (tlhairdown,x_axis) 
		
		WaitForTurn (tlarm,y_axis) 
		WaitForTurn (tlarm,z_axis) 
		
		WaitForTurn (tlarmr,x_axis) 
		WaitForTurn (tlarmr,y_axis) 
		WaitForTurn (tlarmr,z_axis) 
		
		
		WaitForTurn (tllegUp,x_axis) 
		WaitForTurn (tllegUp,y_axis) 
		WaitForTurn (tllegUp,z_axis) 
		
		WaitForTurn (tllegLow,x_axis) 
		
		
		WaitForTurn (tllegUpR,x_axis) 
		WaitForTurn (tllegUpR,y_axis) 
		WaitForTurn (tllegUpR,z_axis) 
		WaitForTurn (tllegLow,x_axis) 
		
		
		
	end
	
end


function gestiKulieren()
	
	SetSignalMask(SIG_GESTE)
	while(true) do
		
		--Hand back to default
		
		
		randSleep=math.random(400,9001)
		if randSleep> 2049 then
			
			Turn(tlarmr,x_axis,math.rad(0),5)
			Turn(tlarmr,y_axis,math.rad(0),4)
			
			Turn(tlarmr,z_axis,math.rad(-74),5)
			Turn(tlarm,x_axis,math.rad(0),5)
			Turn(tlarm,y_axis,math.rad(0),4)
			
			Turn(tlarm,z_axis,math.rad(87),5)
			
			
			
			
			
			
			
			
			
		end
		
		Sleep(randSleep)
		decider=math.random(0,1)
		if decider==1 then
			--Geste weit offen
			rollDice=math.random(0,1)
			if rollDice==1 then
				--DualGeste
				randAlle=math.random(-139,80)
				Turn(tlarmr,x_axis,math.rad(randAlle),5)
				Turn(tlarmr,y_axis,math.rad(-90),4)
				randAlle=math.random(-82,40)
				Turn(tlarmr,z_axis,math.rad(randAlle),5)
				
				
				Sleep(140)
				
				randAlle=math.random(-80,139)
				Turn(tlarm,x_axis,math.rad(randAlle),3)
				Turn(tlarm,y_axis,math.rad(90),5)
				randAlle=math.random(-82,40)
				Turn(tlarm,z_axis,math.rad(randAlle),4)
			end
			if rollDice==0 then
				
				randAlle=math.random(-139,80)
				Turn(tlarmr,x_axis,math.rad(randAlle),5)
				Turn(tlarmr,y_axis,math.rad(-90),4)
				randAlle=math.random(-82,40)
				Turn(tlarmr,z_axis,math.rad(randAlle),5)
				
				
				Sleep(140)
				
				--monohanded gestures almost always are executed subconciessly with the prefered hand..
				
			end
			
		end
		
		if decider==0 then
			
			x=math.random(12,52)
			y=math.random(80,124)
			
			Turn(tlarmr,x_axis,math.rad(0),5)
			y=y*-1
			Turn(tlarmr,y_axis,math.rad(y),5)
			Turn(tlarmr,z_axis,math.rad(x),5)
			
			
			Turn(tlarmr,x_axis,math.rad(0),5)
			yMax=124+y
			y=80+yMax-3
			Turn(tlarmr,y_axis,math.rad(y),5)
			x=x*-1
			Turn(tlarmr,z_axis,math.rad(x),5)
			
			Sleep(180)
			
			
			
			-- Geste zusammen
		end
	end
end


function onTheMove()
	Signal(SIG_ONTHEMOVE)
	SetSignalMask(SIG_ONTHEMOVE)
	nCounter=0
	while (true) do
		
		if nCounter== 0 then
			Spring.PlaySoundFile("sounds/tiglil/tgdance.wav") 
		elseif nCounter== 5 then
			nCounter=0
		end
		
		flipFlop=math.random(0,1)
		if flipFlop==1 then 
			drumClapOverhead()
		end
		
		if flipFlop==0 then 
			drumClapFront()
		end
		
		nCounter=nCounter+1
	end
	
	
	
	
end


function spagat()
	
	Move(tigLil,y_axis,-10,37)
	
	Turn (tigLil,x_axis,math.rad(0),3)
	Turn (tigLil,y_axis,math.rad(0),3)
	Turn (tigLil,z_axis,math.rad(0),3)
	
	
	Turn (tlHead,x_axis,math.rad(0),3)
	Turn (tlHead,y_axis,math.rad(3),3)
	Turn (tlHead,z_axis,math.rad(0),3)
	
	Turn (tlhairup,x_axis,math.rad(-52),4)
	Turn (tlhairup,y_axis,math.rad(0),3)
	Turn (tlhairup,z_axis,math.rad(0),3)
	
	Turn (tlhairdown,x_axis,math.rad(-60),4)
	
	Turn (tlarm,x_axis,math.rad(0),3)
	Turn (tlarm,y_axis,math.rad(0),3)
	Turn (tlarm,z_axis,math.rad(-23),3)--i
	Turn (tlarmr,x_axis,math.rad(0),3)
	Turn (tlarmr,y_axis,math.rad(0),3)
	Turn (tlarmr,z_axis,math.rad(30),3)--i
	
	
	Turn (tllegUp,x_axis,math.rad(-90),6)
	Turn (tllegUp,y_axis,math.rad(0),3)
	Turn (tllegUp,z_axis,math.rad(12),4)
	
	Turn (tllegLow,x_axis,math.rad(0),3)
	
	
	Turn (tllegUpR,x_axis,math.rad(90),6)
	Turn (tllegUpR,y_axis,math.rad(0),3)
	Turn (tllegUpR,z_axis,math.rad(-8),4)
	
	Turn (tllegLowR,x_axis,math.rad(0),3)
	WaitForMove(tigLil,y_axis)
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tigLil,y_axis) 
	WaitForTurn (tigLil,z_axis) 
	
	
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlHead,y_axis) 
	WaitForTurn (tlHead,z_axis) 
	
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairup,y_axis) 
	WaitForTurn (tlhairup,z_axis) 
	
	WaitForTurn (tlhairdown,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	WaitForTurn (tllegLow,x_axis) 
	
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	
	WaitForTurn (tllegLowR,x_axis) 
	Sleep(750)
	
	Turn (tlarm,z_axis,math.rad(23),9)--i
	Turn (tlarmr,z_axis,math.rad(-23),9)--i
	
	Turn (tllegUp,x_axis,math.rad(0),8)
	Turn (tllegUp,y_axis,math.rad(0),3)
	Turn (tllegUp,z_axis,math.rad(0),4)
	
	Turn (tllegLow,x_axis,math.rad(0),3)
	
	
	Turn (tllegUpR,x_axis,math.rad(0),8)
	Turn (tllegUpR,y_axis,math.rad(0),3)
	Turn (tllegUpR,z_axis,math.rad(0),4)
	
	Move(tigLil,y_axis,0,38)
	WaitForMove(tigLil,y_axis)
	
end

--[[
function handclapHigh(clapnumber)
	Signal(SIG_CLAP1)
	SetSignalMask(SIG_CLAP1)
	for itterator = 1, clapnumber, 1 do
		
		--Hand Standyposition
		
		Turn(tlarmr,x_axis,math.rad(16 ),3)
		Turn(tlarmr,y_axis,math.rad(-32),3)
		Turn(tlarmr,z_axis,math.rad(88),3)
		
		
		Turn(tlarm,x_axis,math.rad(188),3)
		Turn(tlarm,y_axis,math.rad(63),3)
		Turn(tlarm,z_axis,math.rad(58),3)
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		
		
		
		-- Hands together
		
		aynRandOM=math.random(28,38)
		Turn(tlHead,x_axis,math.rad(aynRandOM),3)
		Turn(tlhairdown,x_axis,math.rad(-98),3)
		Turn(tlhairdown,x_axis,math.rad(-1),3)
		
		Turn(tlarmr,x_axis,math.rad(16 ),3)
		Turn(tlarmr,y_axis,math.rad(15),3)--i
		Turn(tlarmr,z_axis,math.rad(114),3)--i
		
		
		Turn(tlarm,x_axis,math.rad(154),3)
		Turn(tlarm,y_axis,math.rad(180),3)
		Turn(tlarm,z_axis,math.rad(75),3)--i
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		Sleep(40)
		
		--Hand Standyposition
		
		Turn(tlarmr,x_axis,math.rad(16 ),3)
		Turn(tlarmr,y_axis,math.rad(-32),3)
		Turn(tlarmr,z_axis,math.rad(88),3)
		
		
		Turn(tlarm,x_axis,math.rad(188),3)
		Turn(tlarm,y_axis,math.rad(63),3)
		Turn(tlarm,z_axis,math.rad(58),3)
		
		aynRandOM=math.random(12,20)
		Turn(tlHead,x_axis,math.rad(aynRandOM),3)
		Turn(tlhairup,x_axis,math.rad(-71),3)
		Turn(tlhairdown,x_axis,math.rad(-27),3)
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		
		
		
		
		
		
		
		
		
		
		
	end
	
	
end


function handclapLow(clapnumber)
	Signal(SIG_CLAP2)
	SetSignalMask(SIG_CLAP2)
	for itterator = 1, clapnumber, 1 do
		aynRandOM=math.random(28,38)
		Turn(tlHead,x_axis,math.rad(aynRandOM),3)
		Turn(tlhairdown,x_axis,math.rad(-98),3)
		Turn(tlhairdown,x_axis,math.rad(-1),3)
		
		--Hand Standyposition
		
		Turn(tlarmr,x_axis,math.rad(-124),7)
		Turn(tlarmr,y_axis,math.rad(-148),6)--i
		Turn(tlarmr,z_axis,math.rad(72),3)
		
		
		Turn(tlarm,x_axis,math.rad(-124),6)
		Turn(tlarm,y_axis,math.rad(135),7)--i
		Turn(tlarm,z_axis,math.rad(-63),3)--i
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		
		
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		-- Hands together
		Turn(tlarmr,x_axis,math.rad(-124),7)
		Turn(tlarmr,y_axis,math.rad(-175),7)--i
		Turn(tlarmr,z_axis,math.rad(72),7)
		
		
		Turn(tlarm,x_axis,math.rad(-124),7)
		Turn(tlarm,y_axis,math.rad(165),7)
		Turn(tlarm,z_axis,math.rad(-63),7)--i
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		
		Sleep(40)
		--Hand Standyposition
		
		Turn(tlarmr,x_axis,math.rad(-124),5)
		Turn(tlarmr,y_axis,math.rad(-148),5)--i
		Turn(tlarmr,z_axis,math.rad(72),3)
		
		aynRandOM=math.random(12,20)
		Turn(tlHead,x_axis,math.rad(aynRandOM),3)
		Turn(tlhairup,x_axis,math.rad(-71),3)
		Turn(tlhairdown,x_axis,math.rad(-27),3)
		
		
		Turn(tlarm,x_axis,math.rad(-124),5)
		Turn(tlarm,y_axis,math.rad(135),5)
		Turn(tlarm,z_axis,math.rad(-63),3)--i
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		
		aynRandOM=math.random(50,175)
		Sleep(aynRandOM)
		
	end
	
	
end
]]--

function armswing()
	SetSignalMask(SIG_SWING)
	Turn(tlarmr,z_axis,math.rad(-80),480)
	Turn(tlarmr,y_axis,math.rad(-86),3)
	WaitForTurn(tlarmr,y_axis)
	Turn(tlarmr,x_axis,math.rad(12),3)
	WaitForTurn(tlarmr,x_axis)
	
	Turn(tlarm,y_axis,math.rad(-85),12)
	WaitForTurn(tlarm,y_axis)
	Turn(tlarm,y_axis,math.rad(-104),12)
	WaitForTurn(tlarm,y_axis)
	Turn(tlarm,x_axis,math.rad(-12),3)
	WaitForTurn(tlarm,x_axis)
	
	
	while(true) do
		--needs a redo
		--RightArmForwards,195 --i
		--ToFix: armright swings backward
		
		
		
		Turn(tlarmr,z_axis,math.rad(-102),5)
		
		WaitForTurn(tlarmr,z_axis)
		Turn(tlarmr,z_axis,math.rad(-67),6)
		
		WaitForTurn(tlarmr,z_axis)
		Turn(tlarmr,z_axis,math.rad(-30),6)
		
		WaitForTurn(tlarmr,z_axis)
		Turn(tlarmr,z_axis,math.rad(-15),5)
		WaitForTurn(tlarmr,z_axis)
		Sleep(25)
		
		
		
		Turn(tlarm,z_axis,math.rad(95),5)
		WaitForTurn(tlarm,z_axis)
		Turn(tlarm,z_axis,math.rad(107),6)
		WaitForTurn(tlarm,z_axis)
		Turn(tlarm,z_axis,math.rad(143),6)
		WaitForTurn(tlarm,z_axis)
		Turn(tlarm,z_axis,math.rad(170),5)
		WaitForTurn(tlarm,z_axis)
		
		Sleep(25)
		
		-- Left ArmBack
		
		
		
		
		
	end
end


function creaRandomValue(lowLimit,upLimit)
	randomvalue= math.random(lowLimit,upLimit)
	return randomvalue
end



function hair_inwind()
	
	SetSignalMask(SIG_HAIRWIND)
	while(true) do
		temphair=math.random(-19,11)
		Turn(tlhairup,x_axis,math.rad(temphair),2)
		temphair=math.random(-33,1)
		Turn(tlhairdown,x_axis,math.rad(temphair),3)
		Sleep(50)
		WaitForTurn(tlhairup,x_axis)
		WaitForTurn(tlhairdown,x_axis)
		
	end
end

function bladewhirl_thread()
	--redo with sinking to knee
	
	
	
	Signal(SIG_WHIR)
	SetSignalMask(SIG_WHIR)
	while(true)do 
		Signal(SIG_WALK)
		Signal(SIG_IDLE)
		Sleeper=Sleeper+1
		Sleeper=Sleeper%11
		stillAttacking=true
		if Sleeper==1 then
			
			
			
			Turn (deathpivot,x_axis,math.rad(25),12)
			Turn (deathpivot,y_axis,Heading,5)--i
			Turn (deathpivot,z_axis,math.rad(0),4)
			
			Move (deathpivot,y_axis,-6.5,3)
			
			Turn (tlHead,x_axis,math.rad(-23),5)
			Turn (tlHead,y_axis,math.rad(0),2)--i
			Turn (tlHead,z_axis,math.rad(0),2)
			
			Turn (tlhairup,x_axis,math.rad(19),10)
			Turn (tlhairup,y_axis,math.rad(0),5)--i
			Turn (tlhairup,z_axis,math.rad(0),11)
			
			Turn (tlhairdown,x_axis,math.rad(-14),4)
			
			Turn (tlarm,x_axis,math.rad(0),6)
			Turn (tlarm,y_axis,math.rad(0),6)--i
			Turn (tlarm,z_axis,math.rad(49),14)
			EmitSfx(tlHead, 1024)

			Turn (tlarmr,x_axis,math.rad(10),3)
			Turn (tlarmr,y_axis,math.rad(0),5)--i
			Turn (tlarmr,z_axis,math.rad(-53),14)
			
			
			Turn (tllegUp,x_axis,math.rad(-87),16)
			Turn (tllegUp,y_axis,math.rad(0),4)--i
			Turn (tllegUp,z_axis,math.rad(0),3)
			
			Turn (tllegLow,x_axis,math.rad(122),24)
			
			
			Turn (tllegUpR,x_axis,math.rad(-82),16)
			Turn (tllegUpR,y_axis,math.rad(0),3)--i
			Turn (tllegUpR,z_axis,math.rad(0),3)
			
			Turn (tllegLowR,x_axis,math.rad(121),24)
			
			Sleep(189)
			
			--Jump
			rand=math.random(0,1)
			if rand==1 then
				Turn (tigLil,y_axis,math.rad(360),48)--i
			end
			Turn (deathpivot,x_axis,math.rad(41),12)
			
			Turn (tllegUp,x_axis,math.rad(0),36)
			Turn (tllegUp,y_axis,math.rad(-19),9)--i
			Turn (tllegUp,z_axis,math.rad(5),3)
			
			Turn (tllegLow,x_axis,math.rad(0),99)
			
			
			Turn (tllegUpR,x_axis,math.rad(0),26)
			Turn (tllegUpR,y_axis,math.rad(16),8)--i
			Turn (tllegUpR,z_axis,math.rad(-10),5)
			
			Turn (tllegLowR,x_axis,math.rad(0),110)
			
			
			Turn (deathpivot,y_axis,math.rad(0),5)--i
			Turn (deathpivot,z_axis,math.rad(0),4)
			
			Move (tigLil,y_axis,15,40)
			
			Turn (tlHead,x_axis,math.rad(-48),25)
			Turn (tlHead,y_axis,math.rad(0),2)--i
			Turn (tlHead,z_axis,math.rad(0),2)
			
			Turn (tlhairup,x_axis,math.rad(0),10)
			Turn (tlhairup,y_axis,math.rad(0),5)--i
			Turn (tlhairup,z_axis,math.rad(0),11)
			
			Turn (tlhairdown,x_axis,math.rad(-31),4)
			
			Turn (tlarm,x_axis,math.rad(0),6)
			Turn (tlarm,y_axis,math.rad(0),6)--i
			Turn (tlarm,z_axis,math.rad(83),14)
			
			Turn (tlarmr,x_axis,math.rad(10),3)
			Turn (tlarmr,y_axis,math.rad(0),5)--i
			Turn (tlarmr,z_axis,math.rad(-76),14)
			
			
			Sleep(50)
			rand=math.random(0,1)
			if rand==1 then
				Turn (tlarm,x_axis,math.rad(0),6)
				Turn (tlarm,y_axis,math.rad(86),24)--i
				Turn (tlarm,z_axis,math.rad(-37),24)
				
				Turn (tlarmr,x_axis,math.rad(10),3)
				Turn (tlarmr,y_axis,math.rad(-82),34)--i
				Turn (tlarmr,z_axis,math.rad(37),24)
			end
			
			if rand==0 then
				Turn (tlarm,x_axis,math.rad(0),16)
				Turn (tlarm,y_axis,math.rad(-109),26)--i
				Turn (tlarm,z_axis,math.rad(26),9)
				
				Turn (tlarmr,x_axis,math.rad(0),2)
				Turn (tlarmr,y_axis,math.rad(87),8)--i
				Turn (tlarmr,z_axis,math.rad(-60),14)
				
				Turn (tlarm,x_axis,math.rad(0),6)
				Turn (tlarm,y_axis,math.rad(-93),16)--i
				Turn (tlarm,z_axis,math.rad(-143),24)
				
				Turn (tlarmr,x_axis,math.rad(0),3)
				Turn (tlarmr,y_axis,math.rad(87),9)--i
				Turn (tlarmr,z_axis,math.rad(146),14)
				
				
			end
			WaitForMove (tigLil,y_axis)
			Sleep(240)
			-- Bring
			Turn (tlarm,x_axis,math.rad(0),6)
			Turn (tlarm,y_axis,math.rad(-93),16)--i
			Turn (tlarm,z_axis,math.rad(184),90)
			
			Turn (tlarmr,x_axis,math.rad(0),3)
			Turn (tlarmr,y_axis,math.rad(87),9)--i
			Turn (tlarmr,z_axis,math.rad(-169),90)
			------
			
			
			Turn (tigLil,x_axis,math.rad(-48),12)
			
			Turn (tlHead,x_axis,math.rad(17),5)
			Turn (tlHead,y_axis,math.rad(0),2)--i
			Turn (tlHead,z_axis,math.rad(0),2)
			
			Turn (tlhairup,x_axis,math.rad(0),10)
			Turn (tlhairup,y_axis,math.rad(0),5)--i
			Turn (tlhairup,z_axis,math.rad(0),11)
			
			Turn (tlhairdown,x_axis,math.rad(-31),4)
			
			
			
			Turn (tllegUp,x_axis,math.rad(-129),21)
			Turn (tllegUp,y_axis,math.rad(0),4)--i
			Turn (tllegUp,z_axis,math.rad(-5),3)
			
			Turn (tllegLow,x_axis,math.rad(52),24)
			
			rand=math.random(0,1)
			if rand==1 then
				
				
				Turn (tllegUpR,x_axis,math.rad(-126),21)
				Turn (tllegUpR,y_axis,math.rad(16),3)--i
				Turn (tllegUpR,z_axis,math.rad(10),3)
				
				Turn (tllegLowR,x_axis,math.rad(96),24)
			end
			
			if rand==0 then
				
				
				Turn (tllegUpR,x_axis,math.rad(-31),21)
				Turn (tllegUpR,y_axis,math.rad(127),23)--i
				Turn (tllegUpR,z_axis,math.rad(97),8)
				
				Turn (tllegLowR,x_axis,math.rad(53),14)
			end
			
			Sleep(275)
			Turn (tigLil,x_axis,math.rad(28),6)
			
			Turn (tlHead,x_axis,math.rad(17),5)
			Turn (tlHead,y_axis,math.rad(0),2)--i
			Turn (tlHead,z_axis,math.rad(0),2)
			
			hairrand=math.random(-17,26)
			Turn (tlhairup,x_axis,math.rad(34),10)
			Turn (tlhairup,y_axis,math.rad(hairrand),5)--i
			Turn (tlhairup,z_axis,math.rad(0),11)
			
			Turn (tlhairdown,x_axis,math.rad(25),4)
			
			Turn (tlarm,x_axis,math.rad(0),6)
			Turn (tlarm,y_axis,math.rad(0),6)--i
			Turn (tlarm,z_axis,math.rad(-90),14)
			
			Turn (tlarmr,x_axis,math.rad(0),3)
			Turn (tlarmr,y_axis,math.rad(0),5)--i
			Turn (tlarmr,z_axis,math.rad(90),14)
			
			
			Turn (tllegUp,x_axis,math.rad(-156),16)
			Turn (tllegUp,y_axis,math.rad(0),4)--i
			Turn (tllegUp,z_axis,math.rad(21),3)
			
			Turn (tllegLow,x_axis,math.rad(0),24)
			
			
			Turn (tllegUpR,x_axis,math.rad(-129),16)
			Turn (tllegUpR,y_axis,math.rad(0),3)--i
			Turn (tllegUpR,z_axis,math.rad(0),3)
			
			Turn (tllegLowR,x_axis,math.rad(0),24)
			
			Sleep(140)
			
			---
			
			Turn (tlarm,x_axis,math.rad(0),6)
			Turn (tlarm,y_axis,math.rad(0),6)--i
			Turn (tlarm,z_axis,math.rad(83),14)
			
			Turn (tlarmr,x_axis,math.rad(10),3)
			Turn (tlarmr,y_axis,math.rad(0),5)--i
			Turn (tlarmr,z_axis,math.rad(-76),14)
			
			Turn (tlhairup,x_axis,math.rad(-61),10)
			Turn (tlhairup,y_axis,math.rad(-17),5)--i
			Turn (tlhairup,z_axis,math.rad(0),11)
			
			Turn (tlhairdown,x_axis,math.rad(-43),4)
			
			
			Turn (tigLil,x_axis,math.rad(323),3)
			
			hairrand=math.random(-17,26)
			Turn (tlhairup,x_axis,math.rad(34),10)
			Turn (tlhairup,y_axis,math.rad(hairrand),5)--i
			Turn (tlhairup,z_axis,math.rad(0),11)
			
			Turn (tlhairdown,x_axis,math.rad(25),4)
			
			
			Turn (tlarm,x_axis,math.rad(0),6)
			Turn (tlarm,y_axis,math.rad(90),6)--i
			Turn (tlarm,z_axis,math.rad(0),14)
			
			Turn (tlarmr,x_axis,math.rad(0),3)
			Turn (tlarmr,y_axis,math.rad(-90),5)--i
			Turn (tlarmr,z_axis,math.rad(0),14)
			
			
			Turn (tllegUp,x_axis,math.rad(-91),16)
			Turn (tllegUp,y_axis,math.rad(0),4)--i
			Turn (tllegUp,z_axis,math.rad(-4),3)
			
			Turn (tllegLow,x_axis,math.rad(138),24)
			
			
			Turn (tllegUpR,x_axis,math.rad(-86),16)
			Turn (tllegUpR,y_axis,math.rad(0),3)--i
			Turn (tllegUpR,z_axis,math.rad(0),3)
			
			Turn (tllegLowR,x_axis,math.rad(128),24)
			Sleep(140)
			
			
			Turn (tigLil,x_axis,math.rad(349),16)
			WaitForTurn (tigLil,x_axis)
			Move(tigLil,y_axis,2,15)
			Move (deathpivot,y_axis,0,3)
			WaitForMove (deathpivot,y_axis)
			WaitForMove(tigLil,y_axis)
			Turn (tigLil,x_axis,math.rad(0),36)
			
		end
		if( Sleeper==2 or Sleeper==4 or Sleeper==6 or Sleeper==8 or Sleeper==9) then
			
			Turn(tllegLowR,x_axis,math.rad(0),8)
			Turn(tllegLow,x_axis,math.rad(0),8)
			
			Turn(deathpivot,x_axis,math.rad(10),2)
			Turn(deathpivot,y_axis,math.rad(180),6)
			Sleep(150)
			randomvalue=creaRandomValue(-52,-16)
			Turn(tlhairdown,x_axis,math.rad(randomvalue),5)
			
			Turn(tlHead,y_axis,math.rad( 20),2)
			Turn(tlHead,z_axis,math.rad(33),4)
			randomvalue=math.random(-52,-16)
			Turn(tlhairup,x_axis,math.rad(randomvalue),5)
			-- 14 51
			Turn(tlhairup,y_axis,math.rad(-77),7)
			Turn(tlhairup,x_axis,math.rad(-82),4)
			randomvalue=creaRandomValue(-52,-16)
			Turn(tlhairdown,x_axis,math.rad(randomvalue),4)
			
			Turn(tlarm,x_axis,math.rad(- 97),8)
			Turn(tlarm,y_axis,math.rad(0),4)
			Turn(tlarm,z_axis,math.rad(- 16),2)
			
			Turn(tlarmr,x_axis,math.rad(- 92),8)
			Turn(tlarmr,y_axis,math.rad(0),6)
			Turn(tlarmr,z_axis,math.rad(- 19),2)
			
			Turn(tllegUp,x_axis,math.rad(- 5),1)
			Turn(tllegUp ,y_axis,math.rad(-11),2)
			Turn(tllegUp ,z_axis,math.rad(- 8),2)
			--FixMe
			EmitSfx(tlHead, 1024)

			Turn(tllegUpR,x_axis,math.rad(34),4)
			Turn(tllegUpR,y_axis,math.rad(-39),4)
			Turn(tllegUpR,z_axis,math.rad(- 17),2)
			
			Turn(tllegLowR,x_axis,math.rad(38),4)
			
			--[[
			WaitForTurn(tlhairdown,x_axis)
			
			WaitForTurn(tlHead,y_axis) 
			WaitForTurn(tlHead,z_axis) 
			WaitForTurn(tlhairup,x_axis)
			
			WaitForTurn(tlhairup,y_axis)
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			WaitForTurn(tllegUp,x_axis) 
			WaitForTurn(tllegUp ,y_axis) 
			WaitForTurn(tllegUp ,z_axis) 
			
			WaitForTurn(tllegUpR,x_axis) 
			WaitForTurn(tllegUpR,y_axis) 
			WaitForTurn(tllegUpR,z_axis) 
			WaitForTurn(tllegLowR,x_axis) 
			WaitForTurn(deathpivot,x_axis) 
			WaitForTurn(deathpivot,y_axis) 
			
			WaitForTurn(tlhairup,x_axis)
			WaitForTurn(tlhairdown,x_axis)
			WaitForTurn(deathpivot,x_axis)
			WaitForTurn(deathpivot,y_axis)]]
			Sleep(450)
			Turn(deathpivot,x_axis,math.rad(-12),2)
			Turn(deathpivot,y_axis,math.rad(360),8)
			Turn(tlarmr,x_axis,math.rad(- 97),4)
			Turn(tlarmr,y_axis,math.rad(0),4)
			Turn(tlarmr,z_axis,math.rad(- 16),2)
			
			Turn(tlarm,x_axis,math.rad(- 92),4)
			Turn(tlarm,y_axis,math.rad(0),6)
			Turn(tlarm,z_axis,math.rad(- 19),2)
			Sleep(75)
			WaitForTurn(deathpivot,x_axis)
			WaitForTurn(deathpivot,y_axis)
			
			
			
			
		end
		
		
		
		
		
		if(Sleeper==0 or Sleeper==3 or Sleeper==5 or Sleeper==7 or Sleeper==10) then
			
			Turn(deathpivot,x_axis,math.rad(-10),1)
			Turn(deathpivot,y_axis,math.rad(-180),18)
			randomvalue=creaRandomValue(-52,-16)
			Turn(tlhairdown,x_axis,math.rad(randomvalue),4)
			
			Turn(tlHead,y_axis,math.rad(-4),2)
			Turn(tlHead,z_axis,math.rad(-22),2)
			randomvalue=creaRandomValue(-97,-79)
			Turn(tlhairup,z_axis,math.rad(randomvalue),3)
			randomvalue=creaRandomValue(-105,-64)
			Turn(tlhairup,y_axis,math.rad(randomvalue),7)
			randomvalue=creaRandomValue(-31,11)
			Turn(tlhairup,x_axis,math.rad(randomvalue),3)
			randomvalue=creaRandomValue(-52,-16)
			Turn(tlhairdown,x_axis,math.rad(randomvalue),4)
			EmitSfx(tlHead, 1024)

			Turn(tlarmr,x_axis,math.rad(97),8)
			Turn(tlarmr,y_axis,math.rad(-11),1)
			Turn(tlarmr,z_axis,math.rad(-16),2)
			WaitForTurn (deathpivot,x_axis) 
			WaitForTurn (deathpivot,y_axis) 
			Move(tigLil,y_axis,-4,16)
			WaitForTurn (tlhairdown,x_axis)
			
			WaitForTurn (tlHead,y_axis)
			WaitForTurn (tlHead,z_axis) 
			
			WaitForTurn (tlhairup,z_axis)
			WaitForTurn (tlhairup,y_axis)
			WaitForTurn (tlhairup,x_axis)
			
			WaitForTurn (tlhairdown,x_axis)
			
			WaitForTurn (tlarmr,x_axis) 
			WaitForTurn (tlarmr,y_axis) 
			WaitForTurn (tlarmr,z_axis) 
			--
			WaitForTurn (tlarm,x_axis) 
			WaitForTurn (tlarm,y_axis) 
			WaitForTurn (tlarm,z_axis) 
			--
			Turn(tlarm,x_axis,math.rad(92),4)
			Turn(tlarm,y_axis,math.rad( 11),4)
			tempArm=math.random(-15,22)
			Turn(tlarm,z_axis,math.rad(tempArm),4)
			
			
			
			
			
			Turn(tllegUp,x_axis,math.rad(-45),3)
			Turn(tllegUp,y_axis,math.rad(11),2)
			Turn(tllegUp,z_axis,math.rad(8),2)
			Turn(tllegLow,x_axis,math.rad(95),6)
			
			Turn(tllegUpR,x_axis,math.rad(28),3)
			Turn(tllegUpR,y_axis,math.rad(42),3)
			Turn(tllegUpR,z_axis,math.rad(0),3)
			Turn(tllegLowR,x_axis,math.rad(90),5)
			
			Turn(deathpivot,x_axis,math.rad(12),1)
			Turn(deathpivot,y_axis,math.rad(-360),8)
			
			WaitForTurn (tllegUpR,x_axis)
			WaitForTurn (tllegUpR,y_axis)
			WaitForTurn (tllegUpR,z_axis)
			
			WaitForTurn (tllegUp,x_axis) 
			WaitForTurn (tllegUp,y_axis) 
			WaitForTurn (tllegUp,z_axis) 
			
			WaitForTurn (tllegLow,x_axis) 
			
			
			WaitForTurn (deathpivot,x_axis) 
			WaitForTurn (deathpivot,y_axis) 
			
			EmitSfx(tlHead, 1024)
	
			
			
			Sleep(150)
			Move(tigLil,y_axis,0,12)
			Turn(tllegLowR,x_axis,math.rad(0),7)
			Turn(tllegLow,x_axis,math.rad(0),7)
			Sleep(150)
		end
	end
end


function legs_down()
	Hide(tlpole)
	Hide(tldrum)
	Hide(tlflute)
	Hide(tlharp)
	Hide(tldancedru)
	Move(tldancedru,y_axis,0,60)
	Move(tldancedru,x_axis,0,60)
	Move(tldancedru,z_axis,0,60)
	Move(tlHead,y_axis,0,60)
	Move(tlHead,x_axis,0,60)
	Move(tlHead,z_axis,0,60)			
	Move(tlarm,y_axis,0,60)
	Move(tlarm,x_axis,0,60)
	Move(tlarm,z_axis,0,60)
	Move(tlarmr,y_axis,0,60)
	Move(tlarmr,x_axis,0,60)
	Move(tlarmr,z_axis,0,60)		
	Move(tldrum,y_axis,0,60)
	Move(tldrum,x_axis,0,60)
	Move(tldrum,z_axis,0,60)
	Turn(tlharp,x_axis,math.rad(0),45)
	Turn(tlharp,y_axis,math.rad(0),45)
	Turn(tlharp,z_axis,math.rad(0),45)
	Turn(tlflute,x_axis,math.rad(0),45)
	Turn(tlflute,y_axis,math.rad(0),45)
	Turn(tlflute,z_axis,math.rad(0),45)
	
	StopSpin(tigLil,y_axis)
	StopSpin(tigLil,z_axis)
	StopSpin(tigLil,x_axis)
	StopSpin(dancepivot,y_axis)
	Move(deathpivot,y_axis,0,60)
	Move(deathpivot,x_axis,0,60)
	Move(deathpivot,z_axis,0,60)
	Turn(dancepivot,x_axis,math.rad(0),45)
	Turn(dancepivot,y_axis,math.rad(0),45)
	Turn(dancepivot,z_axis,math.rad(0),45)
	Move(tigLil,y_axis,0,60)
	Move(tigLil,x_axis,0,60)
	Move(tigLil,z_axis,0,60)
	Turn(deathpivot,x_axis,math.rad(0),45)
	Turn(deathpivot,y_axis,math.rad(0),45)
	Turn(deathpivot,z_axis,math.rad(0),45)
	Turn(tigLil,x_axis,math.rad(0),32)
	Turn(tigLil,y_axis,math.rad(0),32)
	Turn(tigLil,z_axis,math.rad(0),32)
	Turn(tlHead,x_axis,math.rad(0),2)
	Turn(tlHead,y_axis,math.rad(0),2)
	Turn(tlHead,z_axis,math.rad(0),2)
	Turn(tlhairup,x_axis,math.rad(-74),2)
	Turn(tlhairup,y_axis,math.rad(0),2)
	Turn(tlhairup,z_axis,math.rad(0),2)
	Turn(tlhairdown,x_axis,math.rad(-19),3)
	Turn(tllegUp,x_axis,math.rad(0),2)
	Turn(tllegUp,y_axis,math.rad(0),2)
	Turn(tllegUp,z_axis,math.rad(0),2)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),2)
	Turn(tllegLow,z_axis,math.rad(0),2)
	Turn(tllegUpR,x_axis,math.rad(0),2)
	Turn(tllegUpR,y_axis,math.rad(0),2)
	Turn(tllegUpR,z_axis,math.rad(0),2)
	Turn(tllegLowR,x_axis,math.rad(0),2)
	Turn(tllegLowR,y_axis,math.rad(0),2)
	Turn(tllegLowR,z_axis,math.rad(0),2)
	Sleep(75)
	--[[WaitForMove(tigLil,y_axis)
	WaitForMove(tigLil,x_axis)
	WaitForMove(tigLil,z_axis)
	WaitForTurn(deathpivot,x_axis) 
	WaitForTurn(deathpivot,y_axis) 
	WaitForTurn(deathpivot,z_axis) 
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tigLil,y_axis) 
	WaitForTurn(tigLil,z_axis) 
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlHead,y_axis) 
	WaitForTurn(tlHead,z_axis) 
	WaitForTurn(tlhairup,x_axis)
	WaitForTurn(tlhairup,y_axis) 
	WaitForTurn(tlhairup,z_axis) 
	WaitForTurn(tlhairdown,x_axis)
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) ]]-- 
	
	
	
end


function idle_stance5()
	
	Turn (tigLil,x_axis,math.rad(-37), 2)
	Turn (tlHead,x_axis,math.rad(-38), 2)
	Turn (tlhairup,x_axis,math.rad(-18), 4)
	
	Turn (tlarm,x_axis,math.rad(0), 3)
	Turn (tlarm,y_axis,math.rad(-32), 3)
	Turn (tlarm,z_axis,math.rad(26), 3)
	
	Turn (tlarmr,x_axis,math.rad(0), 3)
	Turn (tlarmr,y_axis,math.rad(30), 3)
	Turn (tlarmr,z_axis,math.rad(-42), 3)
	
	Turn (tllegUp,x_axis,math.rad(22), 3)
	Turn (tllegLow,x_axis,math.rad(16), 3)
	Turn (tllegUpR,x_axis,math.rad(23), 3)
	Turn (tllegLowR,x_axis,math.rad(17), 3)
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegLow,x_axis) 
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegLowR,x_axis) 
	Sleep (1024)
	
	legs_down ()
	Sleep(50) 
	Turn (tigLil,x_axis,math.rad(-37), 4)
	Turn (tlHead,x_axis,math.rad(-38), 4)
	Turn (tlhairup,x_axis,math.rad(-18), 4)
	Turn (tlarm,x_axis,math.rad(-42), 3)
	Turn (tlarm,y_axis,math.rad(49), 5)
	Turn (tlarm,z_axis,math.rad(-9), 3)
	Turn (tlarmr,x_axis,math.rad(-42), 5)
	Turn (tlarmr,y_axis,math.rad(-49), 5)
	Turn (tlarmr,z_axis,math.rad(-9), 3)
	Turn (tllegUp,x_axis,math.rad(22), 3)
	Turn (tllegLow,x_axis,math.rad(16), 3)
	Turn (tllegUpR,x_axis,math.rad(23), 3)
	Turn (tllegLowR,x_axis,math.rad(17), 3)
	
	
	-- backflip
	
	Turn (tigLil,x_axis,math.rad(-88), 8)
	Turn (tlarm,x_axis,math.rad(-74), 4)
	Turn (tlarm,y_axis,math.rad(51), 4)
	Turn (tlarm,z_axis,math.rad(-5), 4)
	Turn (tlarmr,x_axis,math.rad(-74), 7)
	Turn (tlarmr,y_axis,math.rad(51), 4)
	Turn (tlarmr,z_axis,math.rad(-5), 4)
	Turn (tllegUp,x_axis,math.rad(42), 5)
	Turn (tllegUpR,x_axis,math.rad(41), 5)
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegLow,x_axis) 
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegLowR,x_axis) 
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUpR,x_axis) 
	
	
	-- handstand
	
	Turn (tigLil,x_axis,math.rad(-180), 6)
	Turn (tlHead,x_axis,math.rad(-8), 3)
	Turn (tlhairup,x_axis,math.rad(101), 5)
	Turn (tlhairdown,x_axis,math.rad(21), 3)
	
	Turn (tlarm,x_axis,math.rad(7), 7)
	Turn (tlarm,y_axis,math.rad(0), 7 )
	Turn (tlarm,z_axis,math.rad(-88), 5)
	
	Turn (tlarmr,x_axis,math.rad(7), 7)
	Turn (tlarmr,y_axis,math.rad(0), 7)
	Turn (tlarmr,z_axis,math.rad(92), 5)
	
	Turn (tllegUp,x_axis,math.rad(0), 3)
	Turn (tllegUp,y_axis,math.rad(0), 3)
	Turn (tllegUp,z_axis,math.rad(0), 3)
	Turn (tllegLow,y_axis,math.rad(0), 3)
	Turn (tllegLow,z_axis,math.rad(0), 3)
	Turn (tllegLow,x_axis,math.rad(0), 3)
	
	Turn (tllegUpR,x_axis,math.rad(0), 3)
	Turn (tllegUpR,y_axis,math.rad(0), 3)
	Turn (tllegUpR,z_axis,math.rad(0), 3)
	Turn (tllegLowR,y_axis,math.rad(0), 3)
	Turn (tllegLowR,z_axis,math.rad(0), 3)
	Turn (tllegLowR,x_axis,math.rad(0), 3)
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairdown,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	WaitForTurn (tllegLow,y_axis) 
	WaitForTurn (tllegLow,z_axis) 
	WaitForTurn (tllegLow,x_axis) 
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	WaitForTurn (tllegLowR,y_axis) 
	WaitForTurn (tllegLowR,z_axis) 
	WaitForTurn (tllegLowR,x_axis) 
	Sleep(3141)
	--reasumePosition
	
	Turn (tigLil,x_axis,math.rad(-290),8)
	
	Turn (tlhairup,x_axis,math.rad(90), 4)
	
	Turn (tlarm,x_axis,math.rad(0), 5)
	Turn (tlarm,y_axis,math.rad(-53), 5)
	Turn (tlarm,z_axis,math.rad(0), 5)
	
	Turn (tlarmr,x_axis,math.rad(0), 5)
	Turn (tlarmr,y_axis,math.rad(53), 5)
	Turn (tlarmr,z_axis,math.rad(0), 5)
	
	Turn (tllegUp,x_axis,math.rad(-72), 7)
	Turn (tllegUp,y_axis,math.rad(0), 7)
	Turn (tllegUp,z_axis,math.rad(0), 7)
	Turn (tllegLow,y_axis,math.rad(0), 7)
	Turn (tllegLow,z_axis,math.rad(0), 7)
	Turn (tllegLow,x_axis,math.rad(0), 7)
	
	Turn (tllegUpR,x_axis,math.rad(-41), 8)
	Turn (tllegUpR,y_axis,math.rad(0), 3)
	Turn (tllegUpR,z_axis,math.rad(0), 3)
	Turn (tllegLowR,y_axis,math.rad(0), 3)
	Turn (tllegLowR,z_axis,math.rad(0), 3)
	Turn (tllegLowR,x_axis,math.rad(0), 3)
	
	WaitForTurn (tigLil,x_axis) 
	
	WaitForTurn (tlhairup,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	WaitForTurn (tllegLow,y_axis) 
	WaitForTurn (tllegLow,z_axis) 
	WaitForTurn (tllegLow,x_axis) 
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	WaitForTurn (tllegLowR,y_axis) 
	WaitForTurn (tllegLowR,z_axis) 
	WaitForTurn (tllegLowR,x_axis) 
	--Return
	
	Turn (tigLil,x_axis,math.rad(-360), 3)
	Turn (tlHead,x_axis,math.rad(0), 3)
	Turn (tlhairup,x_axis,math.rad(-43), 5)
	Turn (tlhairdown,x_axis,math.rad(-44), 6)
	
	Turn (tlarm,x_axis,math.rad(0), 5)
	Turn (tlarm,y_axis,math.rad(0), 5)
	Turn (tlarm,z_axis,math.rad(0), 5)
	
	Turn (tlarmr,x_axis,math.rad(0), 3)
	Turn (tlarmr,y_axis,math.rad(0), 3)
	Turn (tlarmr,z_axis,math.rad(0), 3)
	
	Turn (tllegUp,x_axis,math.rad(0), 3)
	Turn (tllegUp,y_axis,math.rad(0), 3)
	Turn (tllegUp,z_axis,math.rad(0), 3)
	Turn (tllegLow,y_axis,math.rad(0), 3)
	Turn (tllegLow,z_axis,math.rad(0), 3)
	Turn (tllegLow,x_axis,math.rad(0), 3)
	
	Turn (tllegUpR,x_axis,math.rad(0), 3)
	Turn (tllegUpR,y_axis,math.rad(0), 3)
	Turn (tllegUpR,z_axis,math.rad(0), 3)
	Turn (tllegLowR,y_axis,math.rad(0), 3)
	Turn (tllegLowR,z_axis,math.rad(0), 3)
	Turn (tllegLowR,x_axis,math.rad(0), 3)
	
	Turn (tigLil,x_axis,math.rad(360), 360)
	
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tigLil,x_axis) 
	WaitForTurn (tlHead,x_axis) 
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlhairdown,x_axis) 
	
	WaitForTurn (tlarm,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarm,z_axis) 
	
	WaitForTurn (tlarmr,x_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tlarmr,z_axis) 
	
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegUp,z_axis) 
	WaitForTurn (tllegLow,y_axis) 
	WaitForTurn (tllegLow,z_axis) 
	WaitForTurn (tllegLow,x_axis) 
	
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	WaitForTurn (tllegUpR,z_axis) 
	WaitForTurn (tllegLowR,y_axis) 
	WaitForTurn (tllegLowR,z_axis) 
	WaitForTurn (tllegLowR,x_axis) 
	
	
	
	
	
	legs_down()
end

--like a bitch over trouble water (expandable)
function idle_stance4()
	
	Turn(tlarm,z_axis,math.rad(-90),3)
	Turn(tllegUp,x_axis,math.rad(-40),2)
	Turn(tllegUp,y_axis,math.rad(-80),2)
	Turn(tllegUp,z_axis,math.rad(-6 ),2)
	Turn(tllegLow,x_axis,math.rad(125),4)
	Turn(tllegUpR,z_axis,math.rad(-8),2)
	WaitForTurn(tlarm,z_axis) 
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	Sleep(1675) 
	dice=math.random(0,1)
	if dice==0 then
		--endless poseIbilitys
	end
	if dice==1 then
		
		--Move(tigLil,z_axis,-7,5)--i-7
		--Move(tigLil,x_axis,-7,3)
		--WaitForMove(tigLil,x_axis)
		Turn(tigLil,x_axis,math.rad(-90),12)
		
		Turn(tigLil,y_axis,math.rad(0),12)
		Turn(tigLil,z_axis,math.rad(0),12)	
		
		Turn(tlHead,x_axis,math.rad( -24),2)
		
		Turn(tlhairup,x_axis,math.rad(28 ),3)
		
		Turn(tlhairup,y_axis,math.rad(0),4)
		Turn(tlhairup,z_axis,math.rad(0),4)
		
		Turn(tlhairdown,x_axis,math.rad(0),4)
		
		Turn(tlarm,x_axis,math.rad(8),8)
		Turn(tlarm,y_axis,math.rad(-83),8)
		Turn(tlarm,z_axis,math.rad(-35),5)
		
		Turn(tlarmr,x_axis,math.rad(8),8)
		Turn(tlarmr,y_axis,math.rad(83),8)
		Turn(tlarmr,z_axis,math.rad(41),5)
		
		Turn(tllegUp,x_axis,math.rad(40),4)
		Turn(tllegUp ,y_axis,math.rad(2),2)
		Turn(tllegUp ,z_axis,math.rad(-3),2)
		Turn(tllegLow,x_axis,math.rad(38),4)				
		
		Turn(tllegUpR,x_axis,math.rad(42),3)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),2)
		
		Turn(tllegLowR,x_axis,math.rad(28),3)
		WaitForTurn(tigLil,x_axis) 
		
		WaitForTurn(tigLil,y_axis) 
		WaitForTurn(tigLil,z_axis) 
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlHead,y_axis) 
		WaitForTurn(tlHead,z_axis) 
		
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairup,y_axis) 
		WaitForTurn(tlhairup,z_axis) 
		
		WaitForTurn(tlhairdown,x_axis) 
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp ,y_axis) 
		WaitForTurn(tllegUp ,z_axis) 
		WaitForTurn(tllegLow,x_axis) 				
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		
		WaitForTurn(tllegLowR,x_axis) 
		Sleep(2024)
		
		Turn(tigLil,x_axis,math.rad(1),12)
		
		Turn(tigLil,y_axis,math.rad(-90),8)
		Turn(tigLil,z_axis,math.rad(90),8)	
		
		Turn(tlHead,x_axis,math.rad( -6),2)
		Turn(tlHead,y_axis,math.rad( -5),2)
		Turn(tlHead,z_axis,math.rad( -9),2)
		
		Turn(tlhairup,x_axis,math.rad(15),3)
		Turn(tlhairup,y_axis,math.rad(102),8)
		Turn(tlhairup,z_axis,math.rad(-90),7)
		
		Turn(tlhairdown,x_axis,math.rad(0),4)
		
		Turn(tlarm,x_axis,math.rad(65),8)
		Turn(tlarm,y_axis,math.rad(-83),8)
		Turn(tlarm,z_axis,math.rad(-86),6)
		
		Turn(tlarmr,x_axis,math.rad(8),8)
		Turn(tlarmr,y_axis,math.rad(83),8)
		Turn(tlarmr,z_axis,math.rad(41),5)
		
		Turn(tllegUp,x_axis,math.rad(40),5)
		Turn(tllegUp ,y_axis,math.rad(90),4)
		Turn(tllegUp ,z_axis,math.rad(-3),4)
		Turn(tllegLow,x_axis,math.rad(38),8)				
		
		Turn(tllegUpR,x_axis,math.rad(42),5)
		Turn(tllegUpR,y_axis,math.rad(0),4)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		
		Turn(tllegLowR,x_axis,math.rad(28),3)
		WaitForTurn(tigLil,x_axis) 
		
		WaitForTurn(tigLil,y_axis) 
		WaitForTurn(tigLil,z_axis) 
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlHead,y_axis) 
		WaitForTurn(tlHead,z_axis) 
		
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairup,y_axis) 
		WaitForTurn(tlhairup,z_axis) 
		
		WaitForTurn(tlhairdown,x_axis) 
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp ,y_axis) 
		WaitForTurn(tllegUp ,z_axis) 
		WaitForTurn(tllegLow,x_axis) 				
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		
		WaitForTurn(tllegLowR,x_axis) 
		
		
		Turn(tigLil,x_axis,math.rad(90),12)
		
		Turn(tigLil,y_axis,math.rad(-187),12)
		Turn(tigLil,z_axis,math.rad(0),12)	
		
		Turn(tlHead,x_axis,math.rad( 70),5)
		Turn(tlHead,y_axis,math.rad( 0),2)
		Turn(tlHead,z_axis,math.rad( 0),2)
		
		Turn(tlhairup,x_axis,math.rad(95),8)
		Turn(tlhairup,y_axis,math.rad(0),4)
		Turn(tlhairup,z_axis,math.rad(0),4)
		
		Turn(tlhairdown,x_axis,math.rad(0),4)
		
		Turn(tlarm,x_axis,math.rad(144),8)
		Turn(tlarm,y_axis,math.rad(3),8)
		Turn(tlarm,z_axis,math.rad(-86),5)
		
		Turn(tlarmr,x_axis,math.rad(190),9)
		Turn(tlarmr,y_axis,math.rad(-65),8)
		Turn(tlarmr,z_axis,math.rad(41),5)
		
		Turn(tllegUp,x_axis,math.rad(-87),8)
		Turn(tllegUp ,y_axis,math.rad(-31),4)
		Turn(tllegUp ,z_axis,math.rad(-3),4)
		Turn(tllegLow,x_axis,math.rad(-8),6)				
		
		Turn(tllegUpR,x_axis,math.rad(-87),3)
		Turn(tllegUpR,y_axis,math.rad(31),3)
		Turn(tllegUpR,z_axis,math.rad(0),2)
		
		Turn(tllegLowR,x_axis,math.rad(-8),3)
		WaitForTurn(tigLil,x_axis) 
		
		WaitForTurn(tigLil,y_axis) 
		WaitForTurn(tigLil,z_axis) 
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlHead,y_axis) 
		WaitForTurn(tlHead,z_axis) 
		
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairup,y_axis) 
		WaitForTurn(tlhairup,z_axis) 
		
		WaitForTurn(tlhairdown,x_axis) 
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp ,y_axis) 
		WaitForTurn(tllegUp ,z_axis) 
		WaitForTurn(tllegLow,x_axis) 				
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		
		WaitForTurn(tllegLowR,x_axis) 
		
		legs_down()
		
		
		
	end
end

function idle_stance2()
	rand=math.random(0,2)
	if rand==1 then
		Turn(tlarmr,y_axis,math.rad( -85),3)
		Turn(tlHead,y_axis,math.rad(23),2)
		WaitForTurn(tlHead,y_axis)
		WaitForTurn(tlarmr,y_axis)
		Turn(tlHead,y_axis,math.rad( -63),2)
		Turn(tlarm,y_axis,math.rad( -90),4)
		WaitForTurn(tlarm,y_axis)
		Sleep(50)
		Turn(tlarm,z_axis,math.rad(-120),4)
		WaitForTurn(tlarm,z_axis)
		Sleep(550)
	end
	if rand==0 then
		--snowAngel
		Move(deathpivot,y_axis,2,2)
		Turn(deathpivot,x_axis,math.rad(-94),1)
		Turn(tlhairup,x_axis,math.rad(95),7)
		angels=math.random(9,12)
		for i=0, angels, 1 do
			
			
			Turn(tlarmr,z_axis,math.rad(44),1)
			Turn(tlarm,z_axis,math.rad(-44),1)
			Turn(tllegUp,z_axis,math.rad(-44),1)
			Turn(tllegUpR,z_axis,math.rad(44),1)
			WaitForTurn(tllegUp,z_axis)
			WaitForTurn(tllegUpR,z_axis)	
			WaitForTurn(tlarm,z_axis)
			WaitForTurn(tlarmr,z_axis)
			
			Sleep(50)
			Turn(tlarmr,z_axis,math.rad(0),1)
			Turn(tllegUpR,z_axis,math.rad(0),1)
			Turn(tllegUp,z_axis,math.rad(0),1)
			Turn(tlarm,z_axis,math.rad(0),1)
			
			WaitForTurn(tllegUp,z_axis)
			WaitForTurn(tllegUpR,z_axis)	
			WaitForTurn(tlarm,z_axis)
			WaitForTurn(tlarmr,z_axis)
			Sleep(172)
		end
		Turn(deathpivot,x_axis,math.rad(0),7)
		WaitForTurn(deathpivot,x_axis)
		
	end
	
	if rand==2 then
		Turn(tllegUp,x_axis,math.rad(0),6)
		Turn(tllegUpR,x_axis,math.rad(0),4)
		Sleep(340)
		Move(deathpivot,y_axis,-1.5,3)
		Turn(tlarmr,y_axis,math.rad(-90),4)
		Turn(tlarm,y_axis,math.rad(90),4)
		Turn(tigLil,x_axis,math.rad(55),5)
		Turn(tllegUp,x_axis,math.rad(-65),6)
		Turn(tllegUpR,x_axis,math.rad(55),4)
		shakeThatTailFeather=math.random(3,11)
		--bootyshake
		for i=0, shakeThatTailFeather, 1 do
			Turn(tigLil,y_axis,math.rad(20),1)
			Turn(tlarmr,y_axis,math.rad(-58),2)
			Turn(tlarm,y_axis,math.rad(110),3)
			Turn(tlhairup,y_axis,math.rad(40),5)
			Turn(tllegUp,x_axis,math.rad(-57),3)
			Turn(tllegUpR,x_axis,math.rad(-62),3)	
			Turn(tllegUpR,z_axis,math.rad(2),1)
			WaitForTurn(tigLil,y_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarm,y_axis) 
			
			WaitForTurn(tllegUp,x_axis) 
			WaitForTurn(tllegUpR,x_axis) 
			WaitForTurn(tllegUpR,z_axis) 
			randSleep=math.random(34,66) 
			Sleep(randSleep)
			
			Turn(tigLil,y_axis,math.rad(-20),2)
			Turn(tlarmr,y_axis,math.rad(-113),5)
			Turn(tlarmr,z_axis,math.rad(9),1)
			Turn(tlarm,y_axis,math.rad(67),3)
			Turn(tlarm,z_axis,math.rad(4),2)
			Turn(tlhairup,y_axis,math.rad(-40),5)
			Turn(tllegUp,x_axis,math.rad(-64),3)
			Turn(tllegUp,z_axis,math.rad(5),1)
			Turn(tllegUpR,x_axis,math.rad(-55),3)	
			Turn(tllegUpR,z_axis,math.rad(1),1)
			WaitForTurn(tigLil,y_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarm,y_axis) 
			
			WaitForTurn(tllegUp,x_axis) 
			WaitForTurn(tllegUpR,x_axis) 
			WaitForTurn(tllegUpR,z_axis) 
			HellsBells=math.random(66,122)
			Sleep(HellsBells)
		end
		--BUTT - you cant do that PICASSO. OH INTERNET! I DONT EVEN STARTED!
		Turn(tigLil,x_axis,math.rad(3),5)
		Turn(tigLil,y_axis,math.rad(0),5)
		Turn(tlarmr,x_axis,math.rad(0),4)
		Turn(tlarmr,y_axis,math.rad(0),4)
		Turn(tlarmr,z_axis,math.rad(-77),4)
		
		Turn(tlarm,x_axis,math.rad(0),4)
		Turn(tlarm,y_axis,math.rad(0),4)
		Turn(tlarm,z_axis,math.rad(86),4)
		
		Turn(tllegUp,x_axis,math.rad(0),6)
		Turn(tllegUp,y_axis,math.rad(0),6)
		Turn(tllegUp,z_axis,math.rad(5),6)
		
		Turn(tllegUpR,x_axis,math.rad(0),4)	
		Turn(tllegUpR,y_axis,math.rad(0),4)
		Turn(tllegUpR,z_axis,math.rad(6),4)
		Sleep(128)
		Turn(tlhairup,y_axis,math.rad(0),5)
		Turn(tlhairdown,x_axis,math.rad(33),5)
		Turn(tlHead,x_axis,math.rad(-32),4)
		Turn(tlHead,y_axis,math.rad(-45),4)
		WaitForTurn(tlHead,x_axis)
		WaitForTurn(tlHead,y_axis)
		Turn(tlarmr,x_axis,math.rad(15),2)
		Turn(tlarmr,y_axis,math.rad(0),2)
		Turn(tlarmr,z_axis,math.rad(-63),3)
		Sleep(80)
		Turn(tlarmr,x_axis,math.rad(15),2)
		Turn(tlarmr,y_axis,math.rad(0),2)
		Turn(tlarmr,z_axis,math.rad(-83),3)
		Sleep(256)
		Turn(tlarm,x_axis,math.rad(0),8)
		Turn(tlarm,y_axis,math.rad(112),14)
		Turn(tlarm,z_axis,math.rad(-37),5)
		--laughing
		tease=math.random(2,8)
		for i=0, tease, 1 do
			Turn(tlHead,x_axis,math.rad(-32),4)
			WaitForTurn(tlHead,x_axis)
			Sleep(66)
			
			Turn(tlHead,x_axis,math.rad(-15),3)
			WaitForTurn(tlHead,x_axis)
			
		end
		
	end
	
	legs_down()
	truth=math.random(0,1)
	if truth==1 then
		
		Sleeper=2
		
		Move(tigLil,z_axis,-21,7)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		WaitForMove(tigLil,z_axis)
		Move(tigLil,z_axis,-12,5)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		WaitForMove(tigLil,z_axis)
		Move(tigLil,z_axis,0,7)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		WaitForMove(tigLil,z_axis)
		Turn(tlarmr,z_axis,math.rad(-26),3)
		Turn(tlarmr,x_axis,math.rad(0),3)
		Turn(tlarmr,y_axis,math.rad(0),3)
		
		Turn(tlarm,z_axis,math.rad(-53),3)
		Turn(tlarm,x_axis,math.rad(0),3)
		Turn(tlarm,y_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(90),18)
		
		Turn(tllegUp,x_axis,math.rad(0),2)
		Turn(tllegUp,y_axis,math.rad(0),2)
		Turn(tllegUp,z_axis,math.rad(0),2)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),2)
		Turn(tllegLow,z_axis,math.rad(0),2)
		Turn(tllegUpR,x_axis,math.rad(0),2)
		Turn(tllegUpR,y_axis,math.rad(0),2)
		Turn(tllegUpR,z_axis,math.rad(0),2)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),2)
		Turn(tllegLowR,z_axis,math.rad(0),2)
		
		Turn(tlhairup,y_axis,math.rad(-90),18)
		Turn(tlhairup,z_axis,math.rad(-90),18)
		
		Turn(tlarmr,z_axis,math.rad(52),6)
		
		
		
		Spin(tigLil,z_axis,math.rad(70),12)
		
		
		Spin(dancepivot,y_axis,math.rad(40),9)
		
		
		Sleep(10275)
		StopSpin(tigLil,z_axis,3)
		StopSpin(dancepivot,y_axis,3)
		Turn(tlhairup,y_axis,math.rad(90),18)
		Turn(tlhairup,z_axis,math.rad(-90),18)
		
		
	end
end

function idle_stance3()
	rand=math.random(0,1)
	if rand==1 then
		Turn(tlarm,z_axis,math.rad(-52),4)
		
		Turn(tlarmr,z_axis,math.rad(49),4)
		
		Turn(tllegUp,z_axis,math.rad(-60),4)
		Turn(tllegUpR,z_axis,math.rad(61),4)
		
		
		WaitForTurn(tlarm,z_axis) 
		WaitForTurn(tlarmr,z_axis) 
		WaitForTurn(tllegUp,z_axis)
		WaitForTurn(tllegUpR,z_axis) 
		Turn(tigLil,x_axis,math.rad(72),4)
		Turn(tlHead,x_axis,math.rad(-34),3)
		Move(tigLil,y_axis,-7,12)
		WaitForMove(tigLil,y_axis)
		-- works
		
		Turn(tllegUp,z_axis,math.rad(0),4)
		Turn(tllegUpR,z_axis,math.rad(0),8)
		Turn(tllegUpR,x_axis,math.rad(70),3)
		Turn(tllegLowR,x_axis,math.rad(90),3)
		Turn(tlarm,z_axis,math.rad(14),4)
		Turn(tlarm,y_axis,math.rad(88),7)
		
		Turn(tllegUp,x_axis,math.rad(25),2)
		Turn(tllegUp,z_axis,math.rad(-90),5)
		Turn(tlhairup,x_axis,math.rad(-39),3)
		
		WaitForTurn(tigLil,x_axis)
		WaitForTurn(tlHead,x_axis)
		WaitForTurn(tllegUpR,x_axis)
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegUp,x_axis)
		
		Sleep(1475)
		
		Move(tigLil,y_axis,3,15)
		Turn(tlarm,x_axis,math.rad(0),4)
		Turn(tlarm,z_axis,math.rad(0),4)
		Turn(tlarm,y_axis,math.rad(0),7)
		Turn(tlarmr,x_axis,math.rad(0),4)
		Turn(tlarmr,z_axis,math.rad(0),4)
		Turn(tlarmr,y_axis,math.rad(0),7)
		Turn(tlHead,x_axis,math.rad(18),3)
		Turn(tlhairup,x_axis,math.rad(-80),3)
		Turn(tlhairdown,x_axis,math.rad(-60),5)
		--reset arms
		
		Turn(tllegUpR,x_axis,math.rad(-38),4)
		
		Turn(tllegUp,z_axis,math.rad(0),4)
		Turn(tllegUp,x_axis,math.rad(32),4)
		Turn(tllegUp,x_axis,math.rad(38),4)
		Turn(tllegLowR,x_axis,math.rad(55),3)
		Turn(tllegUp,x_axis,math.rad(0),2)
		
		Turn(tigLil,x_axis,math.rad(-90),18)
		WaitForTurn(tigLil,x_axis)
		Turn(tigLil,x_axis,math.rad(-180),12)
		WaitForTurn(tigLil,x_axis)
		Turn(tigLil,x_axis,math.rad(-270),8)
		WaitForTurn(tigLil,x_axis)
		Turn(tigLil,x_axis,math.rad(-360),6)
		WaitForTurn(tigLil,x_axis)
		
		WaitForMove(tigLil,y_axis)
		WaitForTurn(tigLil,x_axis) 
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairdown,x_axis) 
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegLowR,x_axis) 
		WaitForTurn(tllegUp,x_axis) 
		Turn(tigLil,x_axis,math.rad(0),360)
		WaitForTurn(tigLil,x_axis) 
		Move(tigLil,y_axis,0,35)
	end
	if rand==0 then
		rand=math.random(0,1)
		if rand==0 then
			Turn(tllegUp,x_axis,math.rad(0),4)
			Turn(tllegUp,y_axis,math.rad(0),4)
			Turn(tllegUp,z_axis,math.rad(9),4)
			Turn(tllegLow,x_axis,math.rad(0),3)
			Turn(tllegUpR,x_axis,math.rad(8),4)
			Turn(tllegUpR,y_axis,math.rad(0),4)
			Turn(tllegUpR,z_axis,math.rad(-12),4)
			Turn(tllegLowR,x_axis,math.rad(0),3)
			Sleep(540)
			Turn(deathpivot,y_axis,math.rad(360),4)
			Sleep(2048)
		end
		if rand==1 then
			Turn(tllegUp,x_axis,math.rad(0),4)
			Turn(tllegUp,y_axis,math.rad(0),4)
			Turn(tllegUp,z_axis,math.rad(9),4)
			Turn(tllegLow,x_axis,math.rad(0),3)
			Turn(tllegUpR,x_axis,math.rad(8),4)
			Turn(tllegUpR,y_axis,math.rad(0),4)
			Turn(tllegUpR,z_axis,math.rad(-12),4)
			Turn(tllegLowR,x_axis,math.rad(0),3)
			
			
			
			for i=0,10,1 do
				Turn(tlarm,x_axis,math.rad(9),4)
				Turn(tlarm,y_axis,math.rad(01),4)
				rand=math.random(80,92)
				Turn(tlarm,z_axis,math.rad(rand),1)
				Turn(tlarmr,x_axis,math.rad(0),4)
				Turn(tlarmr,y_axis,math.rad(0),4)
				rand=math.random(-85,-70)
				Turn(tlarmr,z_axis,math.rad(rand),3)
				rand=math.random(-42,44)
				Turn(tlHead,z_axis,math.rad(rand),2)
				rand1=math.random(0,1)
				if rand1==1 then
					rand=math.random(-16,24)
					Turn(tlHead,y_axis,math.rad(rand),3)
				end
				--einfach nur rumstehen, einfach sich selbst sein...
				Sleep(4096)
			end
		end
		Turn(tlarm,x_axis,math.rad(0),4)
		Turn(tlarm,y_axis,math.rad(-41),4)
		Turn(tlarm,z_axis,math.rad(90),2)
		Turn(tlarmr,x_axis,math.rad(0),4)
		Turn(tlarmr,y_axis,math.rad(41),4)
		Turn(tlarmr,z_axis,math.rad(-79),3)
		itRandom=math.random(0,12)
		
		for it=0,itRandom,1 do
			rand=math.random(59,83)
			Turn(tlarm,z_axis,math.rad(rand),1)
			rand=math.random(104,126)
			Turn(tlarmr,z_axis,math.rad(rand),1)
			
			Sleep(440)
			rand=math.random(104,126)
			Turn(tlarm,z_axis,math.rad(rand),1)
			rand=math.random(-83,-59)
			Turn(tlarmr,z_axis,math.rad(rand),1)
			Sleep(280)
		end
		
		
		
	end
end

function idle_stance()
	
	Turn(tlHead,y_axis,math.rad(-38),3)
	WaitForTurn(tlHead,y_axis)
	Turn(tlHead,y_axis,math.rad( 20),2)
	WaitForTurn(tlHead,y_axis)
	Turn(tlarm,z_axis,math.rad(- 38),1)
	Turn(tlarmr,y_axis,math.rad(-22),1)
	Turn(tlarmr,z_axis,math.rad(- 28),1)
	WaitForTurn(tlarm,z_axis)
	WaitForTurn(tlarmr,y_axis)
	WaitForTurn(tlarmr,z_axis)
	Turn(tllegUp,x_axis,math.rad(-5),1)
	Turn(tllegUp,y_axis,math.rad(-11),1)
	Turn(tllegUp,z_axis,math.rad(8),1)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),2)
	Turn(tllegLow,z_axis,math.rad(0),2)
	
	Turn(tllegUpR,x_axis,math.rad(105),6)
	Turn(tllegUpR,y_axis,math.rad(0),1)
	Turn(tllegUpR,z_axis,math.rad(-12),1)
	Turn(tllegLowR,x_axis,math.rad(98),3)
	Turn(tllegLowR,y_axis,math.rad(0),2)
	Turn(tllegLowR,z_axis,math.rad(0),2)
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis)
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis) 
	WaitForTurn(tllegLowR,y_axis) 
	WaitForTurn(tllegLowR,z_axis) 
	Sleep(325)
	Turn(tlarmr,z_axis,math.rad(38),3)
	Turn(tlarm,y_axis,math.rad( 22),1)
	Turn(tlarm,z_axis,math.rad(38),2)
	WaitForTurn(tlarmr,z_axis)
	WaitForTurn(tlarm,y_axis)
	WaitForTurn(tlarm,z_axis)
	
	Turn(tlHead,y_axis,math.rad( 0),2)
	
	Turn(tlarm,z_axis,math.rad(0),1)
	Turn(tlarmr,y_axis,math.rad(0),1)
	Turn(tlarmr,z_axis,math.rad(0),1)
	
	Turn(tllegUp,x_axis,math.rad(0),1)
	Turn(tllegUp,y_axis,math.rad(0),1)
	Turn(tllegUp,z_axis,math.rad(0),1)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),2)
	Turn(tllegLow,z_axis,math.rad(0),2)
	
	Turn(tllegUpR,x_axis,math.rad(0),6)
	Turn(tllegUpR,y_axis,math.rad(0),1)
	Turn(tllegUpR,z_axis,math.rad(0),1)
	Turn(tllegLowR,x_axis,math.rad(0),3)
	Turn(tllegLowR,y_axis,math.rad(0),2)
	Turn(tllegLowR,z_axis,math.rad(0),2)
	
	Turn(tlarmr,z_axis,math.rad(0),3)
	Turn(tlarm,y_axis,math.rad( 0),1)
	Turn(tlarm,z_axis,math.rad(0),2)
	Sleep(1575)
	
	rand=math.random(0,1)
	if rand==1 then
		
		
		temprand=math.random(7,19)
		for i=0,temprand, 1 do 
			--chat lenght
			
			howOften=math.random(2,6)
			rand=math.random(0,1)
			if rand==0 then
				--Headshake--disagree
				violently=math.random(5,9)
				for at=0, howOften, 1 do
					if violently>2 then
						
						violently=violently-1
					end
					
					Turn(tlHead,y_axis,math.rad(-35),violently)
					Sleep(280)
					Turn(tlHead,y_axis,math.rad(30),violently)
					Sleep(180)
					--------Spring.Echo("Works1")
				end
			end
			
			if rand==1 then
				--Nod (Not the Critizen Kane Nod from C&C) --always important to avoid missunderstandings in code
				--------Spring.Echo("KillmeImBuggy!1")
				
				for at=0, howOften, 1 do
					
					Turn(tlHead,x_axis,math.rad(-4),8)
					Sleep(280)
					Turn(tlHead,x_axis,math.rad(22),9)
					Sleep(180)
				end
			end
			
			
			gestRand=math.random(3,12)
			for ot=0,gestRand, 1 do
				howLong=math.random(2,6)
				--------Spring.Echo("KillmeImBuggy!2")
				StartThread(talkingHead)
			end
			Sleep(370)
			
			xif=howLong%2
			if xif==1 then
				--------Spring.Echo("remember")
				Turn(tlarm,x_axis,math.rad(-17),3)
				Turn(tlarm,y_axis,math.rad(137),7)
				Turn(tlarm,z_axis,math.rad(-19),3)
			end
			if xif==0 then
				-- deute 
				--------Spring.Echo("KillmeImBuggy3!")
				Turn(tlarmr,x_axis,math.rad(1),3)
				
				marlonRando=math.random(36,129)
				marlonRando=marlonRando*-1
				--Turn(tlarmr,y_axis,math.rad((marlonRando)),7)
				Turn(tlarmr,y_axis,math.rad(marlonRando),7)
				Turn(tlarmr,z_axis,math.rad(0),3)
				Sleep(640)
				Turn(tlarmr,x_axis,math.rad(0),3)
				
				Turn(tlarmr,y_axis,math.rad(marlonRando),7)
				Turn(tlarmr,z_axis,math.rad(0),3)
			end
			
			--Chatblock
			--------Spring.Echo("KillmeImBuggy!4")
			Sleep(250)
			Signal(SIG_TALKHEAD)
			howLong=math.random(2,6)
			StartThread(talkingHead)
			Signal(SIG_GESTE)
			StartThread(gestiKulieren)
			Sleep(2048)
			--EndChatblock
			--explain
			
			dicer=math.random(0,1)
			if dicer==1 then 
				Signal(SIG_GESTE)
				--------Spring.Echo("KillmeImBuggy!5")
				legs_down()
				
				Turn(tlarmr,x_axis,math.rad(0),1)
				Turn(tlarmr,y_axis,math.rad(-64),5)
				Turn(tlarmr,z_axis,math.rad(-17),2)
				Sleep(80)
				Turn(tlarm,x_axis,math.rad(1),1)
				Turn(tlarm,y_axis,math.rad(95),5)
				Turn(tlarm,z_axis,math.rad(-8),12)
				Sleep(200)
				target=math.random(1,6)
				for ix=0, target,1 do
					torg=math.random(8,25)
					ex=ix%2
					if ex==1 then
						torg=torg*-1
					end
					Turn(tlarm,z_axis,math.rad(torg),12)
					Sleep(140)
				end
			end
			--Chatblock
			--------Spring.Echo("KillmeImBuggy!6")
			Signal(SIG_GESTE)
			StartThread(gestiKulieren)
			Signal(SIG_TALKHEAD)
			howLong=math.random(2,6)
			StartThread(talkingHead)
			forQuiteALongTime=math.random(4096,8048)
			Sleep(forQuiteALongTime)
			--EndChatblock
			if dicer==0 then
				--argue&bitch
				Signal(SIG_GESTE)
				--------Spring.Echo("KillmeImBuggy!7")
				--FistShaking
				Turn(tigLil,x_axis,math.rad(0),1)
				
				Turn(tlarmr,x_axis,math.rad(0),1)
				Turn(tlarmr,y_axis,math.rad(0),5)
				Turn(tlarmr,z_axis,math.rad(-71),8)
				Turn(tlarm,x_axis,math.rad(0),1)
				Turn(tlarm,y_axis,math.rad(0),5)
				Turn(tlarm,z_axis,math.rad(71),8)
				Sleep(120)
				Turn(tlarm,z_axis,math.rad(82),4)
				Turn(tlarmr,z_axis,math.rad(-65),4)
				Sleep(120)
				Turn(tlarm,z_axis,math.rad(71),4)
				Turn(tlarmr,z_axis,math.rad(-71),4)
				---StompthatLegUP
				Turn(tllegUpR,x_axis,math.rad(-29),6)
				Turn(tllegUpR,y_axis,math.rad(0),1)
				Turn(tllegUpR,z_axis,math.rad(-8),1)
				Turn(tllegLowR,x_axis,math.rad(57),3)
				Turn(tllegLowR,y_axis,math.rad(9),2)
				Turn(tllegLowR,z_axis,math.rad(0),2)
				Sleep(360)
				--FistShaking
				Turn(tlarmr,x_axis,math.rad(0),1)
				Turn(tlarmr,y_axis,math.rad(0),5)
				Turn(tlarmr,z_axis,math.rad(-71),8)
				Turn(tlarm,x_axis,math.rad(0),1)
				Turn(tlarm,y_axis,math.rad(0),5)
				Turn(tlarm,z_axis,math.rad(71),8)
				Sleep(100)
				Turn(tlarm,z_axis,math.rad(82),4)
				Turn(tlarmr,z_axis,math.rad(-65),4)
				Sleep(60)
				Turn(tlarm,z_axis,math.rad(71),4)
				Turn(tlarmr,z_axis,math.rad(-71),4)
				Turn(tllegUp,x_axis,math.rad(0),16)
				Turn(tllegUp,y_axis,math.rad(0),1)
				Turn(tllegUp,z_axis,math.rad(0),8)
				Turn(tllegLow,x_axis,math.rad(0),25)
				Turn(tllegLow,y_axis,math.rad(0),5)
				Turn(tllegLow,z_axis,math.rad(0),2)
				Turn(tllegUpR,x_axis,math.rad(0),16)
				Turn(tllegUpR,y_axis,math.rad(0),1)
				Turn(tllegUpR,z_axis,math.rad(-8),8)
				Turn(tllegLowR,x_axis,math.rad(0),25)
				Turn(tllegLowR,y_axis,math.rad(0),5)
				Turn(tllegLowR,z_axis,math.rad(0),2)
				Sleep(180)
				
				--FistShaking
				Turn(tlarmr,x_axis,math.rad(0),1)
				Turn(tlarmr,y_axis,math.rad(0),5)
				Turn(tlarmr,z_axis,math.rad(-71),8)
				Turn(tlarm,x_axis,math.rad(0),1)
				Turn(tlarm,y_axis,math.rad(0),5)
				Turn(tlarm,z_axis,math.rad(71),8)
				Sleep(120)
				Turn(tlarm,z_axis,math.rad(82),4)
				Turn(tlarmr,z_axis,math.rad(-65),4)
				Sleep(120)
				Turn(tlarm,z_axis,math.rad(71),4)
				Turn(tlarmr,z_axis,math.rad(-71),4)
				Sleep(120)
			end
			--Chatblock	
			--------Spring.Echo("KillmeImBuggy!8")
			Signal(SIG_GESTE)
			StartThread(gestiKulieren)
			Signal(SIG_TALKHEAD)
			howLong=math.random(2,6)
			StartThread(talkingHead)
			forQuiteALongTime=math.random(4096,8048)
			Sleep(forQuiteALongTime)
			--EndChatblock
			
			
			-- sexy geste
			oneInSix=math.random(0,18)
			if oneInSix==6 then
				--------Spring.Echo("KillmeImBuggy!9")
				itTerrator=math.random(0,11)
				Signal(SIG_TALKHEAD)
				Signal(SIG_GESTE)
				speedincreaser=0.1
				for grafZahl=0,itTerrator, 1 do
					--move back
					if grafzahl==itTerrator-2 then
						speedincreaser=speedincreaser+0.05
					end
					
					speed=1*speedincreaser
					Turn(deathpivot,x_axis,math.rad(-8),speed)
					speed=5*speedincreaser
					Turn(deathpivot,y_axis,math.rad(0),speed)
					speed=8*speedincreaser
					Turn(deathpivot,z_axis,math.rad(0),speed)
					
					speed=3*speedincreaser
					Turn(tigLil,x_axis,math.rad(17),speed)
					speed=2*speedincreaser
					Turn(tigLil,y_axis,math.rad(4),speed)
					speed=2*speedincreaser
					Turn(tigLil,z_axis,math.rad(0),speed)
					speed=10*speedincreaser
					Turn(tlHead,x_axis,math.rad(26),speed)
					speed=5*speedincreaser
					Turn(tlHead,y_axis,math.rad(0),speed)
					speed=8*speedincreaser
					Turn(tlHead,z_axis,math.rad(0),speed)
					speed=11*speedincreaser
					Turn(tlhairup,x_axis,math.rad(-52),speed)
					speed=8*speedincreaser
					Turn(tlhairdown,x_axis,math.rad(-30),speed)
					speed=3*speedincreaser																
					Turn(tlarm,x_axis,math.rad(8),speed)
					speed=8*speedincreaser
					Turn(tlarm,y_axis,math.rad(80),speed)
					speed=15*speedincreaser
					Turn(tlarm,z_axis,math.rad(55),speed)
					speed=1*speedincreaser
					Turn(tlarmr,x_axis,math.rad(-9),speed)
					speed=5*speedincreaser
					Turn(tlarmr,y_axis,math.rad(-80),speed)
					speed=15*speedincreaser
					Turn(tlarmr,z_axis,math.rad(-55),speed)
					speed=16*speedincreaser
					Turn(tllegUpR,x_axis,math.rad(-24),speed)
					speed=1*speedincreaser
					Turn(tllegUpR,y_axis,math.rad(0),speed)
					speed=8*speedincreaser
					Turn(tllegUpR,z_axis,math.rad(-8),speed)
					speed=22*speedincreaser
					Turn(tllegLowR,x_axis,math.rad(14),speed)
					speed=5*speedincreaser
					Turn(tllegLowR,y_axis,math.rad(0),speed)
					speed=2*speedincreaser
					Turn(tllegLowR,z_axis,math.rad(0),speed)
					speed=14*speedincreaser
					Turn(tllegUp,x_axis,math.rad(-24),speed)
					speed=8*speedincreaser
					Turn(tllegUp,y_axis,math.rad(-21),speed)
					speed=4*speedincreaser
					Turn(tllegUp,z_axis,math.rad(0),speed)
					speed=22*speedincreaser
					Turn(tllegLow,x_axis,math.rad(15),speed)
					speed=5*speedincreaser
					Turn(tllegLow,y_axis,math.rad(0),speed)
					speed=2*speedincreaser
					Turn(tllegLow,z_axis,math.rad(0),speed)
					Sleep(240)
					
					--move forth
					speed=6*speedincreaser
					Turn(deathpivot,x_axis,math.rad(6),speed)
					speed=5*speedincreaser
					Turn(deathpivot,y_axis,math.rad(0),speed)
					speed=8*speedincreaser
					Turn(deathpivot,z_axis,math.rad(0),speed)
					speed=3*speedincreaser
					Turn(tigLil,x_axis,math.rad(-25),speed)
					speed=2*speedincreaser
					Turn(tigLil,y_axis,math.rad(4),speed)
					speed=2*speedincreaser
					Turn(tigLil,z_axis,math.rad(0),speed)
					speed=5*speedincreaser
					Turn(tlHead,x_axis,math.rad(-18),speed)
					speed=5*speedincreaser
					Turn(tlHead,y_axis,math.rad(0),speed)
					speed=8*speedincreaser
					Turn(tlHead,z_axis,math.rad(0),speed)
					speed=11*speedincreaser
					Turn(tlhairup,x_axis,math.rad(-61),speed)
					speed=8*speedincreaser
					Turn(tlhairdown,x_axis,math.rad(30),speed)
					
					speed=3*speedincreaser
					Turn(tlarm,x_axis,math.rad(8),speed)
					speed=8*speedincreaser
					Turn(tlarm,y_axis,math.rad(80),speed)
					speed=15*speedincreaser
					Turn(tlarm,z_axis,math.rad(89),speed)
					speed=1*speedincreaser
					Turn(tlarmr,x_axis,math.rad(-9),speed)
					speed=5*speedincreaser
					Turn(tlarmr,y_axis,math.rad(14),speed)								
					speed=15*speedincreaser
					Turn(tlarmr,z_axis,math.rad(-89),15)
					speed=16*speedincreaser
					Turn(tllegUpR,x_axis,math.rad(19),speed)
					speed=1*speedincreaser
					Turn(tllegUpR,y_axis,math.rad(-10),speed)
					speed=8*speedincreaser
					Turn(tllegUpR,z_axis,math.rad(-8),speed)
					speed=22*speedincreaser
					Turn(tllegLowR,x_axis,math.rad(14),speed)
					speed=5*speedincreaser
					Turn(tllegLowR,y_axis,math.rad(0),speed)
					speed=2*speedincreaser
					Turn(tllegLowR,z_axis,math.rad(0),speed)
					speed=16*speedincreaser
					Turn(tllegUp,x_axis,math.rad(14),speed)
					speed=8*speedincreaser
					Turn(tllegUp,y_axis,math.rad(9),speed)
					speed=4*speedincreaser
					Turn(tllegUp,z_axis,math.rad(0),speed)
					speed=22*speedincreaser
					Turn(tllegLow,x_axis,math.rad(15),speed)
					speed=5*speedincreaser
					Turn(tllegLow,y_axis,math.rad(0),speed)
					speed=2*speedincreaser
					Turn(tllegLow,z_axis,math.rad(0),speed)
					Sleep(180)
					
					if speedincreaser<1 then
						speedincreaser=speedincreaser+0.1
					end
				end
			end			
			
			Sleep(400)
			Signal(SIG_TALKHEAD)
			howLong=math.random(2,6)
			StartThread(talkingHead)
			--laughing
			--------Spring.Echo("KillmeImBuggy!10")
			coinUpYouLive=math.random(0,6)
			if coinUpYouLive==3 then
				Turn(deathpivot,x_axis,math.rad(0),1)
				Turn(deathpivot,y_axis,math.rad(0),5)
				Turn(deathpivot,z_axis,math.rad(0),8)
				
				Turn(tigLil,x_axis,math.rad(19),3)
				Turn(tigLil,y_axis,math.rad(4),2)
				Turn(tigLil,z_axis,math.rad(0),2)
				
				Turn(tlHead,x_axis,math.rad(0),5)
				Turn(tlHead,y_axis,math.rad(0),5)
				Turn(tlHead,z_axis,math.rad(0),8)
				
				Turn(tlhairup,x_axis,math.rad(-77),11)
				Turn(tlhairdown,x_axis,math.rad(-16),8)
				
				
				Turn(tlarm,x_axis,math.rad(-18),3)
				Turn(tlarm,y_axis,math.rad(-49),8)
				Turn(tlarm,z_axis,math.rad(113),15)
				
				Turn(tlarmr,x_axis,math.rad(0),1)
				Turn(tlarmr,y_axis,math.rad(-154),5)
				Turn(tlarmr,z_axis,math.rad(27),15)
				
				Turn(tllegUpR,x_axis,math.rad(-47),16)
				Turn(tllegUpR,y_axis,math.rad(0),1)
				Turn(tllegUpR,z_axis,math.rad(0),8)
				Turn(tllegLowR,x_axis,math.rad(47),25)
				Turn(tllegLowR,y_axis,math.rad(0),5)
				Turn(tllegLowR,z_axis,math.rad(0),2)
				
				Turn(tllegUp,x_axis,math.rad(-44),16)
				Turn(tllegUp,y_axis,math.rad(0),8)
				Turn(tllegUp,z_axis,math.rad(0),4)
				Turn(tllegLow,x_axis,math.rad(16),25)
				Turn(tllegLow,y_axis,math.rad(0),5)
				Turn(tllegLow,z_axis,math.rad(0),2)		
				
				Sleep(50)
				bitchslap=math.random(3,11)
				
				for omgImTired=0, bitchslap,1 do
					Turn(tlarm,x_axis,math.rad(-18),3)
					Turn(tlarm,y_axis,math.rad(-49),8)
					Turn(tlarm,z_axis,math.rad(113),15)
					
					Sleep(150)
					Turn(tlarm,x_axis,math.rad(-17),3)
					Turn(tlarm,y_axis,math.rad(-23),8)
					Turn(tlarm,z_axis,math.rad(101),15)
					Sleep(230)
				end
			end
		end
		
		
	end					
end

function idle_stance6()
	
	Turn(tlHead,x_axis,math.rad(-29),3)
	Turn(tlHead,x_axis,math.rad(29),3)
	
	--wait &sleep
	Sleep(150)
	Move (tigLil,y_axis,-8,12)
	
	
	Turn(tlHead,x_axis,math.rad(0),3)
	Turn(tlhairup,x_axis,math.rad(-77),4)
	Turn(tlarm,x_axis,math.rad(-27),3)
	Turn(tlarm,y_axis,math.rad(-12),3)
	Turn(tlarm,z_axis,math.rad(72),3)
	
	Turn(tlarmr,x_axis,math.rad(-12),3)
	Turn(tlarmr,y_axis,math.rad(104),3)
	Turn(tlarmr,z_axis,math.rad(-107),3)
	
	
	Turn(tllegUp,x_axis,math.rad(-63),4)
	Turn(tllegUp,y_axis,math.rad(-14),4)
	Turn(tllegLow,x_axis,math.rad(147),6)
	
	Turn(tllegUpR,x_axis,math.rad(291),4)
	Turn(tllegUpR,y_axis,math.rad(10),4)
	Turn(tllegLowR,x_axis,math.rad(147),6)
	
	WaitForTurn(tlHead,x_axis) 
	
	Sleep(2048)
	--wait &sleep
	WaitForMove(tigLil,y_axis)
	
	
	
	
	WaitForTurn(tlhairup,x_axis) 
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegLow,x_axis) 
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegLowR,x_axis) 
	
	
	Sleep(550)
	--jumpstage
	
	flipFlop=math.random(0,1)
	if flipFlop==1 then
		Spin(tigLil,y_axis,math.rad(360))
		
		
		Move(tigLil,y_axis,7,74)
		Move(tigLil,y_axis,11,64)
		Sleep(50)
		
		--Turn(deathpivot,y_axis,math.rad(179),8)
		Move(tigLil,y_axis,17,54)
		WaitForMove(tigLil,y_axis)
		
		Turn(tlHead,x_axis,math.rad(10),3)
		
		--Turn(deathpivot,y_axis,math.rad(269),2)
		--Turn(deathpivot,y_axis,math.rad(360),4)
		
		Turn(tlarm,x_axis,math.rad(0),6)
		Turn(tlarm,y_axis,math.rad(0),6)
		Turn(tlarm,z_axis,math.rad(-98),7)
		
		
		Turn(tlarmr,x_axis,math.rad(0),6)
		Turn(tlarmr,y_axis,math.rad(0),6)
		Turn(tlarmr,z_axis,math.rad(98),7)
		
		
		Turn(tllegUp,x_axis,math.rad(-17),7)
		Turn(tllegUp,y_axis,math.rad(-90),7)
		Turn(tllegLow,x_axis,math.rad(41),9)
		
		Turn(tllegUpR,x_axis,math.rad(-17),7)
		Turn(tllegUpR,y_axis,math.rad(75),7)
		Turn(tllegLowR,x_axis,math.rad(41),9)
		
		--wait&sleep
		
		
		WaitForTurn(tlHead,x_axis) 
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegLow,x_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegLowR,x_axis) 
		
		
		
		WaitForMove(tigLil,y_axis)
		
		
		Move (tigLil,y_axis,11,54)
		Move (tigLil,y_axis,7,64)
		Move (tigLil,y_axis,0,74)
		StopSpin(tigLil,y_axis)
		WaitForTurn(tigLil,y_axis)
		Turn(tlhairup,x_axis,math.rad(63),28)
		WaitForMove(tigLil,y_axis)
		WaitForTurn(tlhairup,x_axis) 
		Turn(tlHead,x_axis,math.rad(0),3)
		Turn(tlhairup,x_axis,math.rad(0),4)
		Turn(tlarm,x_axis,math.rad(0),3)
		Turn(tlarm,y_axis,math.rad(0),3)
		Turn(tlarm,z_axis,math.rad(0),3)
		
		
		Turn(tlarmr,x_axis,math.rad(0),3)
		Turn(tlarmr,y_axis,math.rad(0),3)
		Turn(tlarmr,z_axis,math.rad(0),3)
		
		
		Turn(tllegUp,x_axis,math.rad(0),3)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(0),3)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),3)
		
		
		
		WaitForTurn(tlHead,x_axis) 
		
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegLow,x_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegLowR,x_axis) 
		Turn (tigLil,y_axis,math.rad(0),360)
		
		
		
		WaitForTurn(tlhairup,x_axis)
		
		WaitForMove(tigLil,y_axis)
		Sleep(350)
		
	end
	
	if flipFlop==0 then
		Sleep(512)
		Move (tigLil,y_axis,-10,12)
		Turn(tigLil,x_axis,math.rad(-4),2)
		Turn(tigLil,y_axis,math.rad(0),2)
		Turn(tigLil,z_axis,math.rad(0),2)
		
		Turn(tlHead,x_axis,math.rad(0),3)
		Turn(tlHead,y_axis,math.rad(0),3)
		Turn(tlHead,z_axis,math.rad(0),3)
		
		Turn(tlhairup,x_axis,math.rad(-74),4)
		Turn(tlhairup,y_axis,math.rad(0),4)
		Turn(tlhairup,z_axis,math.rad(0),4)
		
		
		Turn(tlarm,x_axis,math.rad(-5),3)
		Turn(tlarm,y_axis,math.rad(-39),3)
		Turn(tlarm,z_axis,math.rad(-33),3)
		
		Turn(tlarmr,x_axis,math.rad(0),3)
		Turn(tlarmr,y_axis,math.rad(24),3)
		Turn(tlarmr,z_axis,math.rad(-33),3)
		
		
		Turn(tllegUp,x_axis,math.rad(0),4)
		Turn(tllegUp,y_axis,math.rad(230),22)
		Turn(tllegUp,z_axis,math.rad(90),4)
		Turn(tllegLow,x_axis,math.rad(152),6)
		
		Turn(tllegUpR,x_axis,math.rad(0),4)
		Turn(tllegUpR,y_axis,math.rad(119),4)
		Turn(tllegUpR,z_axis,math.rad(-90),4)
		Turn(tllegLowR,x_axis,math.rad(148),6)
		
		Sleep(440)
		
		Turn(tlarm,x_axis,math.rad(0),3)
		Turn(tlarm,y_axis,math.rad(57),3)
		Turn(tlarm,z_axis,math.rad(22),3)
		
		Sleep(50)
		
		Turn(tlHead,x_axis,math.rad(16),3)
		Turn(tlHead,y_axis,math.rad(54),3)
		Turn(tlHead,z_axis,math.rad(0),3)
		
		Turn(tlhairup,x_axis,math.rad(-38),4)
		Turn(tlhairup,y_axis,math.rad(57),4)
		Turn(tlhairup,z_axis,math.rad(90),4)
		
		Sleep(150)
		
		Turn(tlHead,x_axis,math.rad(16),3)
		Turn(tlHead,y_axis,math.rad(-54),3)
		Turn(tlHead,z_axis,math.rad(6),3)
		
		Turn(tlhairup,x_axis,math.rad(-21),5)
		Turn(tlhairup,y_axis,math.rad(57),5)
		Turn(tlhairup,z_axis,math.rad(-90),5)
		
		Turn(tlhairdown,x_axis,math.rad(17),8)
		Sleep (125)
		
		Turn(tlHead,x_axis,math.rad(16),6)
		Turn(tlHead,y_axis,math.rad(54),6)
		Turn(tlHead,z_axis,math.rad(0),5)
		
		Turn(tlhairup,x_axis,math.rad(-38),7)
		Turn(tlhairup,y_axis,math.rad(57),7)
		Turn(tlhairup,z_axis,math.rad(90),7)
		
		--ixxed
		--HairInFront
		Turn(tlHead,x_axis,math.rad(11),6)
		Turn(tlHead,y_axis,math.rad(-32),6)
		Turn(tlHead,z_axis,math.rad(0),6)
		
		Turn(tlhairup,x_axis,math.rad(3),8)
		Turn(tlhairup,y_axis,math.rad(-53),8)
		Turn(tlhairup,z_axis,math.rad(79),8)
		
		Turn(tlhairdown,x_axis,math.rad(24),8)
		Sleep(60)
		
		Turn(tlhairup,x_axis,math.rad(-21),4)
		Turn(tlhairup,y_axis,math.rad(-125),4)
		Turn(tlhairup,z_axis,math.rad(151),4)
		Turn(tlarmr,y_axis,math.rad(-55),9)
		Turn(tlarmr,z_axis,math.rad(-29),9)
		Turn(tlhairdown,x_axis,math.rad(24),8)
		
		Sleep(256)
		Turn(tlarm,x_axis,math.rad(-84),3)
		Turn(tlarm,y_axis,math.rad(57),3)
		Turn(tlarm,z_axis,math.rad(22),4)
		Sleep(256)
		Turn(tlarm,x_axis,math.rad(-125),3)
		Turn(tlarm,y_axis,math.rad(122),3)
		Turn(tlarm,z_axis,math.rad(10),4)
		
		randItterator=math.random(6,16)
		for i=1,randItterator,1 do
			Sleep(256)
			Turn(tlarm,x_axis,math.rad(-147),0.5)
			Turn(tlarm,y_axis,math.rad(152),0.5)
			Turn(tlarm,z_axis,math.rad(19),0.5)
			
			WaitForTurn(tlarm,x_axis)
			WaitForTurn(tlarm,y_axis)
			WaitForTurn(tlarm,z_axis)
			Turn(tlarm,x_axis,math.rad(-147),0.25)
			Turn(tlarm,y_axis,math.rad(155),0.25)
			Turn(tlarm,z_axis,math.rad(5),0.25)
			WaitForTurn(tlarm,x_axis)
			WaitForTurn(tlarm,y_axis)
			WaitForTurn(tlarm,z_axis)
			Turn(tlarm,x_axis,math.rad(-147),0.125)
			Turn(tlarm,y_axis,math.rad(158),0.125)
			Turn(tlarm,z_axis,math.rad(-8),0.125)
			WaitForTurn(tlarm,x_axis)
			WaitForTurn(tlarm,y_axis)
			WaitForTurn(tlarm,z_axis)
			
		end
		
		
	end
	legs_down()
	Move (tigLil,y_axis,0,12)
	Sleep(2048)
	
	rand=math.random(0,1)
	if rand==1 then
		--levitate
		--FixMe : HairShouldFloat
		Move (tigLil,y_axis,-10,12)
		Turn(tigLil,x_axis,math.rad(-4),2)
		Turn(tigLil,y_axis,math.rad(0),2)
		Turn(tigLil,z_axis,math.rad(0),2)
		
		Turn(tlHead,x_axis,math.rad(0),3)
		Turn(tlHead,y_axis,math.rad(0),3)
		Turn(tlHead,z_axis,math.rad(0),3)
		
		Turn(tlhairup,x_axis,math.rad(-74),4)
		Turn(tlhairup,y_axis,math.rad(0),4)
		Turn(tlhairup,z_axis,math.rad(0),4)
		
		
		Turn(tlarm,x_axis,math.rad(0),3)
		Turn(tlarm,y_axis,math.rad(43),3)
		Turn(tlarm,z_axis,math.rad(22),3)
		
		Turn(tlarmr,x_axis,math.rad(-4),3)
		Turn(tlarmr,y_axis,math.rad(-44),3)
		Turn(tlarmr,z_axis,math.rad(-15),3)
		
		
		Turn(tllegUp,x_axis,math.rad(0),4)
		Turn(tllegUp,y_axis,math.rad(230),22)
		Turn(tllegUp,z_axis,math.rad(90),4)
		Turn(tllegLow,x_axis,math.rad(152),6)
		
		Turn(tllegUpR,x_axis,math.rad(0),4)
		Turn(tllegUpR,y_axis,math.rad(119),4)
		Turn(tllegUpR,z_axis,math.rad(-90),4)
		Turn(tllegLowR,x_axis,math.rad(148),6)
		
		
		for i=0, 25, 1 do
			Turn(tlarm,x_axis,math.rad(24),1)
			Turn(tlarmr,x_axis,math.rad(24),1)
			Sleep(620)
			Turn(tlarm,x_axis,math.rad(-4),1)
			Turn(tlarmr,x_axis,math.rad(-4),1)
			Sleep(620)
		end
		Move (tigLil,y_axis,-9,0.5)
		Sleep(150)
		Move (tigLil,y_axis,-10,0.5)
		Sleep(320)
		Move (tigLil,y_axis,-5,0.25)
		
		howLong=math.random(12,24)
		for i=0,howLong, 1 do
			Turn(tlarm,x_axis,math.rad(24),1)
			Turn(tlarmr,x_axis,math.rad(24),1)
			Sleep(420)
			Turn(tlarm,x_axis,math.rad(-4),1)
			Turn(tlarmr,x_axis,math.rad(-4),1)
			Sleep(420)
		end
		
		randSleep=math.random(512,4096)
		rand=math.random(0,1)
		WaitForMove (tigLil,y_axis)
		if rand==0 then
			Move (tigLil,y_axis,5,0.5)
			Turn(tllegUp,x_axis,math.rad(0),0.25)
			Turn(tllegUp,y_axis,math.rad(0),0.25)
			Turn(tllegUp,z_axis,math.rad(0),0.25)
			Turn(tllegLow,x_axis,math.rad(0),0.25)
			
			Turn(tllegUpR,x_axis,math.rad(0),0.25)
			Turn(tllegUpR,y_axis,math.rad(0),0.25)
			Turn(tllegUpR,z_axis,math.rad(0),0.25)
			Turn(tllegLowR,x_axis,math.rad(0),0.25)
			Sleep(700)
			WaitForMove (tigLil,y_axis)
			-- random float in space
			
			tumbleWeed=math.random(7,14)
			
			spinX=math.random(10,60)
			spinY=math.random(10,80)
			spinZ=math.random(30,70)
			rondo=math.random(0,2)
			
			
			
			
			if rondo==0 then
				spinY=0
				spinZ=spinZ/spinX
			end
			if rondo==1 then
				spinX=spinX/spinY
				spinZ=0
			end
			if rondo==2 then
				spinY=spinY/spinZ
				spinX=0
			end
			
			boolAllreadyActive=false
			temp=12
			boolInPosition=false
			for at=0, tumbleWeed, 1 do
				Move (tigLil,y_axis,temp,0.5)
				--Team 4 Place Levitation SubScript here
				
				if boolAllreadyActive==false then
					------Spring.Echo("Should work!0")
					boolAllreadActive=true
					
					if rondo==0 then
						
						Spin(tigLil,x_axis,math.rad(spinX),0.25)
						
						Spin(tigLil,z_axis,math.rad(spinZ),0.45)
					end
					if rondo==1 then
						Spin(tigLil,x_axis,math.rad(spinX),0.25)
						Spin(tigLil,y_axis,math.rad(spinY),0.35)
						
					end
					if rondo==2 then
						Spin(tigLil,y_axis,math.rad(spinY),0.35)
						Spin(tigLil,z_axis,math.rad(spinZ),0.45)
						
					end
					
				end
				
				
				
				if boolInPosition==false then
					------Spring.Echo("HappyTrigger is Triggerhappy!")
					Turn(tlHead,x_axis,math.rad(83),4)
					
					
					Turn(tlarm,y_axis,math.rad(79),4)
					
					Turn(tlarm,x_axis,math.rad(79),1)
					Turn(tlarm,z_axis,math.rad(-6),1)
					
					
					Turn(tlarmr,y_axis,math.rad(-102),3)
					Turn(tlarmr,x_axis,math.rad(-97),3)
					Turn(tlarmr,z_axis,math.rad(-12),3)
					
					Turn(tllegUp,x_axis,math.rad(-137),3)
					--i
					Turn(tllegUp,z_axis,math.rad(5),1)
					Turn(tllegLow,x_axis,math.rad(155),1)
					--i
					Turn(tllegLow,z_axis,math.rad(15),2)
					
					Turn(tllegUpR,x_axis,math.rad(-135),4)
					--i
					Turn(tllegUpR,y_axis,math.rad(10),2)
					--i
					Turn(tllegUpR,z_axis,math.rad(-13),2)
					Turn(tllegLowR,x_axis,math.rad(135),1)
					Turn(tllegLowR,y_axis,math.rad(0),1)
					Turn(tllegLowR,z_axis,math.rad(0),1)
					WaitForTurn(tlHead,x_axis) 
					
					
					WaitForTurn(tlarm,y_axis) 
					
					WaitForTurn(tlarm,x_axis) 
					WaitForTurn(tlarm,z_axis) 
					
					
					WaitForTurn(tlarmr,y_axis) 
					WaitForTurn(tlarmr,x_axis) 
					WaitForTurn(tlarmr,z_axis) 
					
					WaitForTurn(tllegUp,x_axis) 
					--i
					WaitForTurn(tllegUp,z_axis) 
					WaitForTurn(tllegLow,x_axis) 
					--i
					WaitForTurn(tllegLow,z_axis) 
					
					WaitForTurn(tllegUpR,x_axis) 
					--i
					WaitForTurn(tllegUpR,y_axis) 
					--i
					WaitForTurn(tllegUpR,z_axis) 
					WaitForTurn(tllegLowR,x_axis) 
					WaitForTurn(tllegLowR,y_axis) 
					WaitForTurn(tllegLowR,z_axis) 
					boolinPosition=true
					
				end
				
				WaitForMove (tigLil,y_axis)
				Sleep(1024)
				
				if temp <32 then
					temp=temp+3
				end
				------Spring.Echo("Should work!2")
				
			end
			------Spring.Echo("Should work!3")
			if rondo==0 then
				
				StopSpin(tigLil,x_axis)
				
				StopSpin(tigLil,z_axis)
			end
			if rondo==1 then
				StopSpin(tigLil,x_axis)
				StopSpin(tigLil,y_axis)
				
			end
			if rondo==2 then
				StopSpin(tigLil,y_axis)
				StopSpin(tigLil,z_axis)
				
			end
			
			
			
		end
		
		
		
		Sleep(randSleep)
		temp=13
		--HeadShake
		if boolInPosition==true then
			Move (tigLil,y_axis,temp,2)
			for i=0, 4, 1 do
				
				Turn(tlHead,y_axis,math.rad(30),13)
				Sleep(210)
				
				WaitForMove (tigLil,y_axis)
				Turn(tlHead,y_axis,math.rad(-30),13)
				Sleep(210)
				
			end
			WaitForMove (tigLil,y_axis)
			
		end
		if boolInPosition==false then
			Move(tigLil,y_axis,0,18)
			
			
			--landing
			Turn(tlhairdown,x_axis,math.rad(0),14)
			Turn(tigLil,x_axis,math.rad(40),14)
			Turn(tigLil,y_axis,math.rad(0),14)
			Turn(tigLil,z_axis,math.rad(0),14)
			Turn(tlhairup,x_axis,math.rad(73),14)
			Turn(tlHead,y_axis,math.rad(42),14)
			Turn(tlHead,x_axis,math.rad(0),14)
			Turn(tlHead,z_axis,math.rad(0),14)
			Turn(tlarm,x_axis,math.rad(0),7)
			Turn(tlarm,y_axis,math.rad(0),7)
			Turn(tlarm,z_axis,math.rad(0),7)
			Turn(tlarmr,x_axis,math.rad(0),7)
			Turn(tlarmr,y_axis,math.rad(42),7)
			Turn(tlarmr,z_axis,math.rad(0),7)
			Turn(tllegLow,x_axis,math.rad(0),9)
			Turn(tllegLow,z_axis,math.rad(0),12)
			Turn(tllegLowR,x_axis,math.rad(0),12)
			Turn(tlhairdown,x_axis,math.rad(18),14)
			Turn(tllegUp,x_axis,math.rad(-37),12)
			Turn(tllegUp,y_axis,math.rad(19),12)
			Turn(tllegUp,z_axis,math.rad(0),12)
			Turn(tllegUpR,x_axis,math.rad(-39),12)
			Turn(tllegUpR,y_axis,math.rad(-14),12)
			Turn(tllegUpR,z_axis,math.rad(0),12)
			Turn(tlhairup,x_axis,math.rad(18),14)
			WaitForMove(tigLil,y_axis)
			
			
			
			Turn(tllegUp,x_axis,math.rad(-6),12)
			Turn(tllegUp,y_axis,math.rad(-37),12)
			Turn(tllegUp,z_axis,math.rad(0),12)
			Turn(tllegLow,x_axis,math.rad(24),9)
			Turn(tllegLow,z_axis,math.rad(-5),12)
			
			Turn(tllegUpR,x_axis,math.rad(-119),12)
			Turn(tllegUpR,y_axis,math.rad(-11),12)
			Turn(tllegUpR,z_axis,math.rad(0),12)
			Turn(tllegLowR,x_axis,math.rad(78),12)
			Move(tigLil,y_axis,-5,12)
			WaitForMove(tigLil,y_axis)
			Sleep(160)
			Move(tigLil,y_axis,-7,3)
			Turn(tigLil,x_axis,math.rad(50),14)
			Turn(tigLil,y_axis,math.rad(5),14)
			Turn(tigLil,z_axis,math.rad(0),14)
			Turn(tlhairup,x_axis,math.rad(-90),14)
			Turn(tlHead,y_axis,math.rad(6),14)
			Turn(tlHead,x_axis,math.rad(0),14)
			Turn(tlHead,z_axis,math.rad(0),14)
			Turn(tlarm,x_axis,math.rad(0),7)
			Turn(tlarm,y_axis,math.rad(27),7)
			Turn(tlarm,z_axis,math.rad(0),7)
			Turn(tlarmr,x_axis,math.rad(-40),7)
			Turn(tlarmr,y_axis,math.rad(0),7)
			Turn(tlarmr,z_axis,math.rad(-32),7)
			Turn(tllegUp,x_axis,math.rad(6),12)
			Turn(tllegUp,y_axis,math.rad(-37),12)
			Turn(tllegUp,z_axis,math.rad(0),12)
			Turn(tllegLow,x_axis,math.rad(16),9)
			
			Turn(tllegUpR,x_axis,math.rad(-126),12)
			Turn(tllegUpR,y_axis,math.rad(-11),12)
			Turn(tllegUpR,z_axis,math.rad(0),12)
			Turn(tllegLowR,x_axis,math.rad(109),12)
			WaitForMove(tigLil,y_axis)
			Sleep(300)
			Move(tigLil,y_axis,-5,12)
			Turn(tigLil,x_axis,math.rad(40),14)
			Turn(tigLil,y_axis,math.rad(0),14)
			Turn(tigLil,z_axis,math.rad(0),14)
			Turn(tllegUp,x_axis,math.rad(-6),12)
			Turn(tllegUp,y_axis,math.rad(-37),12)
			Turn(tllegUp,z_axis,math.rad(0),12)
			Turn(tllegLow,x_axis,math.rad(24),9)
			Turn(tllegLow,z_axis,math.rad(-5),12)
			
			Turn(tllegUpR,x_axis,math.rad(-119),12)
			Turn(tllegUpR,y_axis,math.rad(-11),12)
			Turn(tllegUpR,z_axis,math.rad(0),12)
			Turn(tllegLowR,x_axis,math.rad(78),12)
			Turn(tlHead,y_axis,math.rad(42),14)
			Turn(tlHead,x_axis,math.rad(0),14)
			Turn(tlHead,z_axis,math.rad(0),14)
			Turn(tlarm,x_axis,math.rad(0),7)
			Turn(tlarm,y_axis,math.rad(0),7)
			Turn(tlarm,z_axis,math.rad(0),7)
			Turn(tlarmr,x_axis,math.rad(0),7)
			Turn(tlarmr,y_axis,math.rad(42),7)
			Turn(tlarmr,z_axis,math.rad(0),7)
			Sleep(2048)
			--abfedern
			
			
			
			
			
		end
		legs_down()
		Sleep(279)
		
	end
	
end

--rest&sleep
function idle_stance7()
	
	
	
	--SitUp Position Legs Sidewayfold
	
	Move(tigLil,y_axis,-1,4)
	WaitForMove(tigLil,y_axis)
	
	Turn (tlhairup,x_axis,math.rad(29),3)
	Turn (tlarm,y_axis,math.rad(-12),3)
	Turn (tlarmr,y_axis,math.rad(38),3)
	Turn (tllegUp,x_axis,math.rad(-4),3)
	Turn (tllegUp,y_axis,math.rad(-59),3)
	Turn (tllegLow,x_axis,math.rad(35),3)
	Turn (tllegUpR,x_axis,math.rad(-20),3)
	Turn (tllegUpR,y_axis,math.rad(-44),3)
	
	Turn (tllegLowR,x_axis,math.rad(31),3)
	
	
	
	WaitForTurn (tlhairup,x_axis) 
	WaitForTurn (tlarm,y_axis) 
	WaitForTurn (tlarmr,y_axis) 
	WaitForTurn (tllegUp,x_axis) 
	WaitForTurn (tllegUp,y_axis) 
	WaitForTurn (tllegLow,x_axis) 
	WaitForTurn (tllegUpR,x_axis) 
	WaitForTurn (tllegUpR,y_axis) 
	
	WaitForTurn (tllegLowR,x_axis) 
	Sleep(256)
	
	--Watch over Knee
	randOMatic=math.random(0,1)
	if randOMatic==0 then
		--workOver
		--lean back & relex
		Move(tigLil,y_axis,-10,13.5)
		Turn (tigLil,x_axis,math.rad(-34),4)
		Turn (tlHead,x_axis,math.rad(-14),3)
		
		Turn (tlarm,x_axis,math.rad(0),6)
		Turn (tlarm,y_axis,math.rad(-58),6)
		Turn (tlarm,z_axis,math.rad(31),3)
		Turn (tlarmr,x_axis,math.rad(0),6)
		Turn (tlarmr,y_axis,math.rad(77),6)
		Turn (tlarmr,z_axis,math.rad(-23),3)
		
		
		
		Turn (tlhairup,x_axis,math.rad(-38),4)
		Turn (tlhairup,y_axis,math.rad(0),3)
		Turn (tlhairup,z_axis,math.rad(0),3)
		Turn (tlhairdown,x_axis,math.rad(26),4)
		
		Turn (tllegUp,x_axis,math.rad(-90),6)
		Turn (tllegUp,y_axis,math.rad(-15),3)
		Turn (tllegUp,z_axis,math.rad(0),3)
		Turn (tllegLow,x_axis,math.rad(90),6)
		Turn (tllegLow,y_axis,math.rad(12),3)
		
		Turn (tllegUpR,x_axis,math.rad(-90),6)
		Turn (tllegUpR,y_axis,math.rad(15),3)
		Turn (tllegUpR,z_axis,math.rad(0),3)
		
		Turn (tllegLowR,x_axis,math.rad(90),6)
		Turn (tllegLowR,y_axis,math.rad(-8),3)
		Turn (tllegLowR,z_axis,math.rad(0),3)
		Sleep(12000)
	end
	legs_down()
	
	
	if randOMatic==1 then
		Move(tigLil,y_axis,-6,5)
		
		Turn (tigLil,x_axis,math.rad(8),3)
		Turn (tigLil,y_axis,math.rad(-2),3)
		Turn (tlhairup,x_axis,math.rad(-77),3)
		
		Turn (tlarm,x_axis,math.rad(-151),5)
		Turn (tlarm,y_axis,math.rad(92),4)
		Turn (tlarm,z_axis,math.rad(-31),3)
		
		Turn (tlarmr,x_axis,math.rad(188),5)
		Turn (tlarmr,y_axis,math.rad(-83),3)
		Turn (tlarmr,z_axis,math.rad(14),3)
		
		Turn (tllegUp,x_axis,math.rad(-120),5)
		Turn (tllegUp,y_axis,math.rad(0),3)
		Turn (tllegLow,x_axis,math.rad(60),3)
		
		Turn (tllegUpR,x_axis,math.rad(-117),3)
		Turn (tllegUpR,y_axis,math.rad(0),3)
		
		Move(tigLil,y_axis,-10,14)
		WaitForMove(tigLil,y_axis)
		WaitForTurn (tigLil,x_axis) 
		WaitForTurn (tigLil,y_axis) 
		Turn (tllegLowR,x_axis,math.rad(55),4) 
		WaitForTurn (tlhairup,x_axis) 
		WaitForTurn (tlarm,x_axis) 
		WaitForTurn (tlarm,y_axis) 
		WaitForTurn (tlarm,z_axis) 
		
		WaitForTurn (tlarmr,x_axis) 
		WaitForTurn (tlarmr,y_axis) 
		WaitForTurn (tlarmr,z_axis) 
		
		WaitForTurn (tllegUp,x_axis) 
		WaitForTurn (tllegUp,y_axis) 
		WaitForTurn (tllegLow,x_axis) 
		
		WaitForTurn (tllegUpR,x_axis) 
		WaitForTurn (tllegUpR,y_axis) 
		
		WaitForTurn (tllegLowR,x_axis) 
		
		
		Sleep(4096)
		
		flipFlop=math.random(0,1)
		if flipFlop==1 then
			
			Turn (tlarmr,x_axis,math.rad(-180),3)
			Turn (tlarmr,y_axis,math.rad(-76),3)
			Turn (tlarmr,z_axis,math.rad(102),3)
			
			Turn (tlarm,x_axis,math.rad(0),3)
			Turn (tlarm,y_axis,math.rad(-8),3)
			Turn (tlarm,z_axis,math.rad(0),3)
			
			Sleep(512)
			--LayDown
			
			
			Move(tigLil,y_axis,-11,4)
			WaitForMove(tigLil,y_axis)
			Turn (tigLil,x_axis,math.rad(-98),3)
			Turn (tigLil,y_axis,math.rad(0),3)
			Turn (tigLil,z_axis,math.rad(0),3)
			
			
			Turn (tlHead,x_axis,math.rad(40),3)
			Turn (tlHead,y_axis,math.rad(30),3)
			Turn (tlarmr,x_axis,math.rad(0),3)
			Turn (tlarmr,y_axis,math.rad(0),3)
			Turn (tlarmr,z_axis,math.rad(0),3)
			Sleep(75)
			Turn (tlarmr,x_axis,math.rad(-2),3)
			Turn (tlarmr,y_axis,math.rad(52),3)
			Turn (tlarmr,z_axis,math.rad(90),3)
			
			Turn (tlhairup,x_axis,math.rad(-8),3)
			Turn (tlhairup,y_axis,math.rad(55),3)
			Turn (tlhairup,z_axis,math.rad(-90),3)
			
			Turn (tllegUp,x_axis,math.rad(-15),3)
			Turn (tllegUp,y_axis,math.rad(0),3)
			Turn (tllegUp,z_axis,math.rad(0),3)
			Turn (tllegLow,x_axis,math.rad(60),3)
			
			Turn (tllegUpR,x_axis,math.rad(9),3)
			Turn (tllegUpR,y_axis,math.rad(0),3)
			Turn (tllegUpR,z_axis,math.rad(0),3)
			
			Turn (tllegLowR,x_axis,math.rad(0),3)
			Turn (tllegLowR,x_axis,math.rad(0),3)
			Turn (tllegLowR,x_axis,math.rad(0),3)
			WaitForTurn (tigLil,x_axis) 
			WaitForTurn (tigLil,y_axis) 
			WaitForTurn (tigLil,z_axis) 
			
			WaitForTurn (tlarm,x_axis) 
			WaitForTurn (tlarm,y_axis)
			WaitForTurn (tlarm,z_axis) 
			
			WaitForTurn (tlarmr,x_axis) 
			WaitForTurn (tlarmr,y_axis) 
			WaitForTurn (tlarmr,z_axis) 
			
			WaitForTurn (tlHead,x_axis) 
			WaitForTurn (tlHead,y_axis) 
			WaitForTurn (tlarm,x_axis) 
			WaitForTurn (tlarm,y_axis) 
			WaitForTurn (tlarm,z_axis) 
			
			WaitForTurn (tlhairup,x_axis) 
			WaitForTurn (tlhairup,y_axis) 
			WaitForTurn (tlhairup,z_axis) 
			
			WaitForTurn (tllegUp,x_axis) 
			WaitForTurn (tllegUp,y_axis) 
			WaitForTurn (tllegUp,z_axis) 
			WaitForTurn (tllegLow,x_axis) 
			
			WaitForTurn (tllegUpR,x_axis) 
			WaitForTurn (tllegUpR,y_axis) 
			WaitForTurn (tllegUpR,z_axis) 
			
			WaitForTurn (tllegLowR,x_axis) 
			WaitForTurn (tllegLowR,x_axis) 
			WaitForTurn (tllegLowR,x_axis) 
			Sleep(50)
			Sleep(8096)
			
			Move(tigLil,y_axis,0,25)
			Turn (tigLil,x_axis,math.rad(0),3)
			Turn (tigLil,y_axis,math.rad(0),3)
			WaitForMove(tigLil,y_axis)
			WaitForTurn (tigLil,x_axis) 
			WaitForTurn (tigLil,y_axis) 
		end
		
		if flipFlop==0 then
			
			
			Move(tlHead,z_axis,-0.826,1)
			Move(tigLil,y_axis,-11,5)
			Turn (tigLil,x_axis,math.rad(75),6)
			Turn (tigLil,y_axis,math.rad(180),8)
			Turn (tlHead,x_axis,math.rad(-50),3)
			Turn (tlHead,y_axis,math.rad(0),3)
			
			Turn (tlarm,x_axis,math.rad(-35),3)
			Turn (tlarm,y_axis,math.rad(180),8)
			Turn (tlarm,z_axis,math.rad(-43),3)
			
			Turn (tlarmr,x_axis,math.rad(-1),3)
			Turn (tlarmr,y_axis,math.rad(199),7)
			Turn (tlarmr,z_axis,math.rad(32),3)
			
			Turn (tlhairup,x_axis,math.rad(-40),3)
			Turn (tlhairup,y_axis,math.rad(-7),3)
			Turn (tlhairup,z_axis,math.rad(0),3)
			Turn (tlhairdown,x_axis,math.rad(8),3)
			Turn(tllegUp,x_axis,math.rad(0),5)
			Turn(tllegUp,y_axis,math.rad(0),5)
			Turn(tllegUp,z_axis,math.rad(0),5)
			Turn(tllegUpR,x_axis,math.rad(0),5)
			Turn(tllegUpR,y_axis,math.rad(0),5)
			Turn(tllegUpR,z_axis,math.rad(0),5)
			WaitForTurn (tigLil,x_axis) 
			WaitForTurn (tigLil,y_axis) 
			WaitForTurn (tlHead,x_axis) 
			WaitForTurn (tlHead,y_axis) 
			
			WaitForTurn (tlarm,x_axis) 
			WaitForTurn (tlarm,y_axis) 
			WaitForTurn (tlarm,z_axis) 
			
			WaitForTurn (tlarmr,x_axis) 
			WaitForTurn (tlarmr,y_axis) 
			WaitForTurn (tlarmr,z_axis) 
			
			WaitForTurn (tlhairup,x_axis) 
			WaitForTurn (tlhairup,y_axis) 
			WaitForTurn (tlhairup,z_axis) 
			
			
			
			
			tempItMax=math.random(7,12)
			for it=0, tempItMax, 1 do
				hipHop=math.random(0,1)
				if hipHop==1 then
					Turn(tllegLowR,x_axis,math.rad(12),3)
					WaitForTurn(tllegLowR,x_axis)
					sheGotLeg=math.random(15,138)
					Sleep(512)
					Turn(tllegLow,x_axis,math.rad(sheGotLeg),3)
					WaitForTurn(tllegLow,x_axis)
					randBreak=math.random(512,1024)
					Sleep(randBreak)
					
				end
				if hipHop==0 then
					Turn(tllegLow,x_axis,math.rad(12),3)
					WaitForTurn(tllegLow,x_axis)
					sheGotLeg=math.random(15,138)
					Sleep(512)
					Turn(tllegLowR,x_axis,math.rad(sheGotLeg),3)
					WaitForTurn(tllegLowR,x_axis)
					randBreak=math.random(512,1024)
					Sleep(randBreak)
				end
				
			end
		end
		Move(tlHead,z_axis,0,1)
		Sleep(550)
	end
	
	BitchSleep=math.random(1024,8000)
	Sleep(BitchSleep)
	BitchSleep=BitchSleep%2
	if BitchSleep==1 then
		randDuration=math.random(1,3)
		for i=0, randDuration, 1 do
			--swoard kata
			
			-- aufwaermuebungen
			
			
			--sowardkicks
			
			
			--spreadPose (Karatekid)
			
			
			
			
			
			--swoardspin in four directions, always going faster
			
			
			
			
			--fanal
			
			
			--standing
		end
		legs_down()
	end
end

function idle_stance8()
	spagat()
	legs_down()
	tempThrower=math.random(1,7)
	Turn(tlarm,x_axis,math.rad(-7),3)
	Turn(tlarm,y_axis,math.rad(-138),2)
	Turn(tlarm,z_axis,math.rad(52),2)
	Show(tldrum)
	Sleep(50)
	WaitForTurn(tlarm,z_axis)
	Turn(tlarm,x_axis,math.rad(0),3)
	Turn(tlarm,y_axis,math.rad(0),3)
	Turn(tlarm,z_axis,math.rad(0),4)
	WaitForTurn(tlarm,y_axis)
	
	for i=1,tempThrower,1 do
		Turn(tlarm,x_axis,math.rad(-180),3)
		Turn(tlarm,y_axis,math.rad(90),6)
		Turn(tlarm,z_axis,math.rad(0),4)
		
		Turn(tlarmr,x_axis,math.rad(0),3)
		Turn(tlarmr,y_axis,math.rad(103),6)
		Turn(tlarmr,z_axis,math.rad(-44),4)
		
		WaitForTurn(tlarm,x_axis)
		Turn(tlarm,z_axis,math.rad(-52),5)
		WaitForTurn(tlarm,z_axis)
		Turn(tlarm,x_axis,math.rad(-180),8)
		Turn(tlarm,y_axis,math.rad(90),8)
		Turn(tlarm,z_axis,math.rad(0),8)
		WaitForTurn(tlarm,z_axis)
		Turn(tlhairup,x_axis,math.rad(-17),4)
		
		Turn(tlHead,x_axis,math.rad(-42),1)
		Move(tldrum,y_axis,-26,27)
		WaitForMove(tldrum,y_axis)
		Move(tldrum,y_axis,-30,22)
		WaitForMove(tldrum,y_axis)
		Move(tldrum,y_axis,-36,12)
		
		WaitForMove(tldrum,y_axis)
		Turn(tlHead,x_axis,math.rad(0),2)
		Turn(tlhairup,x_axis,math.rad(-74),5)
		Move(tldrum,y_axis,-30,15)
		Move(tldrum,y_axis,-26,27)
		WaitForMove(tldrum,y_axis)
		Move(tldrum,y_axis,-0.2,37)
		WaitForMove(tldrum,y_axis)
		Turn(tlarm,z_axis,math.rad(-68),5)
		WaitForTurn(tlarm,z_axis)
		
	end
	
	
	Sleep(150)
	Turn(tlarm,x_axis,math.rad(0),3)
	Turn(tlarm,y_axis,math.rad(0),2)
	Turn(tlarm,z_axis,math.rad(0),3)
	WaitForTurn(tlarm,y_axis)
	Turn(tlarm,x_axis,math.rad(-187),3)
	
	Turn(tlarm,y_axis,math.rad(-138),2)
	Turn(tlarm,z_axis,math.rad(-52),3)
	Hide(tldrum)
	
	
end



--clapstance
function idle_stance9()
	--Clap
	
	Turn(tigLil,x_axis,math.rad(-16),3)
	Turn(tlHead,x_axis,math.rad(16),3)
	Turn(tlhairup,x_axis,math.rad(-71),3)
	Turn(tlhairdown,x_axis,math.rad(-27),3)
	Turn(tlarm,x_axis,math.rad(-124),3)
	Turn(tlarmr,x_axis,math.rad(-124),3)
	Turn(tllegUp,x_axis,math.rad(26),3)
	Turn(tllegLow,x_axis,math.rad(-10),3)
	Turn(tllegUpR,x_axis,math.rad(14),3)
	WaitForTurn(tigLil,x_axis) 
	WaitForTurn(tlHead,x_axis) 
	WaitForTurn(tlhairup,x_axis) 
	WaitForTurn(tlhairdown,x_axis) 
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegUpR,x_axis) 
	
	Sleep(150)
	tempclap=math.random(3,12)
	--random number of handclaps
	decider=math.random(0,1)
	if (decider==0) then
		
		for itterator = 1, tempclap, 1 do
			
			--Hand Standyposition
			
			Turn(tlarmr,x_axis,math.rad(16 ),3)
			Turn(tlarmr,y_axis,math.rad(-32),3)
			Turn(tlarmr,z_axis,math.rad(88),3)
			
			
			Turn(tlarm,x_axis,math.rad(188),3)
			Turn(tlarm,y_axis,math.rad(63),3)
			Turn(tlarm,z_axis,math.rad(58),3)
			
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			
			
			
			
			-- Hands together
			
			aynRandOM=math.random(28,38)
			Turn(tlHead,x_axis,math.rad(aynRandOM),3)
			Turn(tlhairdown,x_axis,math.rad(-98),3)
			Turn(tlhairdown,x_axis,math.rad(-1),3)
			
			Turn(tlarmr,x_axis,math.rad(16 ),3)
			Turn(tlarmr,y_axis,math.rad(15),3)--i
			Turn(tlarmr,z_axis,math.rad(114),3)--i
			
			
			Turn(tlarm,x_axis,math.rad(154),3)
			Turn(tlarm,y_axis,math.rad(180),3)
			Turn(tlarm,z_axis,math.rad(75),3)--i
			
			WaitForTurn(tlHead,x_axis) 
			WaitForTurn(tlhairdown,x_axis) 
			WaitForTurn(tlhairdown,x_axis) 
			
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			Sleep(40)
			
			--Hand Standyposition
			
			Turn(tlarmr,x_axis,math.rad(16 ),3)
			Turn(tlarmr,y_axis,math.rad(-32),3)
			Turn(tlarmr,z_axis,math.rad(88),3)
			
			
			Turn(tlarm,x_axis,math.rad(188),3)
			Turn(tlarm,y_axis,math.rad(63),3)
			Turn(tlarm,z_axis,math.rad(58),3)
			
			aynRandOM=math.random(12,20)
			Turn(tlHead,x_axis,math.rad(aynRandOM),3)
			Turn(tlhairup,x_axis,math.rad(-71),3)
			Turn(tlhairdown,x_axis,math.rad(-27),3)
			
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			
			
			WaitForTurn(tlHead,x_axis) 
			WaitForTurn(tlhairup,x_axis) 
			WaitForTurn(tlhairdown,x_axis) 
			
		end
		
		
		
		
		
		
		
		Sleep(50)
	end
	if (decider==1) then
		for itterator = 1, tempclap, 1 do
			aynRandOM=math.random(28,38)
			Turn(tlHead,x_axis,math.rad(aynRandOM),3)
			Turn(tlhairdown,x_axis,math.rad(-98),3)
			Turn(tlhairdown,x_axis,math.rad(-1),3)
			
			--Hand Standyposition
			
			Turn(tlarmr,x_axis,math.rad(-124),7)
			Turn(tlarmr,y_axis,math.rad(-148),6)--i
			Turn(tlarmr,z_axis,math.rad(72),3)
			
			
			Turn(tlarm,x_axis,math.rad(-124),6)
			Turn(tlarm,y_axis,math.rad(135),7)--i
			Turn(tlarm,z_axis,math.rad(-63),3)--i
			WaitForTurn(tlHead,x_axis) 
			WaitForTurn(tlhairdown,x_axis) 
			WaitForTurn(tlhairdown,x_axis) 
			
			
			
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			-- Hands together
			Turn(tlarmr,x_axis,math.rad(-124),7)
			Turn(tlarmr,y_axis,math.rad(-175),7)--i
			Turn(tlarmr,z_axis,math.rad(72),7)
			
			
			Turn(tlarm,x_axis,math.rad(-124),7)
			Turn(tlarm,y_axis,math.rad(165),7)
			Turn(tlarm,z_axis,math.rad(-63),7)--i
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			
			
			Sleep(40)
			--Hand Standyposition
			
			Turn(tlarmr,x_axis,math.rad(-124),5)
			Turn(tlarmr,y_axis,math.rad(-148),5)--i
			Turn(tlarmr,z_axis,math.rad(72),3)
			
			aynRandOM=math.random(12,20)
			Turn(tlHead,x_axis,math.rad(aynRandOM),3)
			Turn(tlhairup,x_axis,math.rad(-71),3)
			Turn(tlhairdown,x_axis,math.rad(-27),3)
			
			
			Turn(tlarm,x_axis,math.rad(-124),5)
			Turn(tlarm,y_axis,math.rad(135),5)
			Turn(tlarm,z_axis,math.rad(-63),3)--i
			
			WaitForTurn(tlarmr,x_axis) 
			WaitForTurn(tlarmr,y_axis) 
			WaitForTurn(tlarmr,z_axis) 
			
			
			WaitForTurn(tlHead,x_axis) 
			WaitForTurn(tlhairup,x_axis) 
			WaitForTurn(tlhairdown,x_axis) 
			
			
			WaitForTurn(tlarm,x_axis) 
			WaitForTurn(tlarm,y_axis) 
			WaitForTurn(tlarm,z_axis) 
			
			
			aynRandOM=math.random(50,175)
			Sleep(aynRandOM)
			
		end
		
		Sleep(50)
	end
	
	
	
	
	--HandWave
	
	Turn(tlarmr,x_axis,math.rad(23),3)
	Turn(tlarmr,y_axis,math.rad(-17),3)
	Turn(tlarmr,z_axis,math.rad(100),3)
	
	
	Turn(tlarm,x_axis,math.rad(-123),3)
	Turn(tlarm,y_axis,math.rad(-32),3)
	Turn(tlarm,z_axis,math.rad(82),3)
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	Sleep(250)
	--Handwavethe Second
	
	Turn(tlarmr,x_axis,math.rad(23),2)
	Turn(tlarmr,y_axis,math.rad(86),2)
	Turn(tlarmr,z_axis,math.rad(114),2)
	
	Turn(tlarm,x_axis,math.rad(-123),2)
	Turn(tlarm,y_axis,math.rad(37),2)
	Turn(tlarm,z_axis,math.rad(82),2)
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	Sleep(250)
	--HandWave
	
	Turn(tlarmr,x_axis,math.rad(23),2)
	Turn(tlarmr,y_axis,math.rad(-17),2)
	Turn(tlarmr,z_axis,math.rad(100),2)
	
	
	Turn(tlarm,x_axis,math.rad(-122),2)
	Turn(tlarm,y_axis,math.rad(-32),2)
	Turn(tlarm,z_axis,math.rad(82),2)
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	Sleep(250)
	
	
	--Handwavethe Second
	
	Turn(tlarmr,x_axis,math.rad(22),2)
	Turn(tlarmr,y_axis,math.rad(86),2)
	Turn(tlarmr,z_axis,math.rad(114),2)
	
	Turn(tlarm,x_axis,math.rad(-123),2)
	Turn(tlarm,y_axis,math.rad(37),2)
	Turn(tlarm,z_axis,math.rad(82),2)
	
	
	WaitForTurn(tlarmr,x_axis) 
	WaitForTurn(tlarmr,y_axis) 
	WaitForTurn(tlarmr,z_axis) 
	
	WaitForTurn(tlarm,x_axis) 
	WaitForTurn(tlarm,y_axis) 
	WaitForTurn(tlarm,z_axis) 
	Sleep(250)
end


--dancestance
function idle_stance_10()
	for i=0,4,1 do
		---------------------------------------Preparations--------------------------
		Turn(tlarm,x_axis,math.rad(0),4)
		Turn(tlarm,y_axis,math.rad(0),4)
		Turn(tlarm,z_axis,math.rad(0),4)
		WaitForTurn(tlarm,y_axis)
		Turn(tlarm,x_axis,math.rad(-7),1)
		Turn(tlarm,y_axis,math.rad(-138),11)
		Turn(tlarm,z_axis,math.rad(52),4)
		WaitForTurn(tlarm,y_axis)
		Show(tldrum)
		Sleep(150)
		Turn(tlarm,x_axis,math.rad(0),4)
		Turn(tlarm,y_axis,math.rad(0),4)
		Turn(tigLil,y_axis,math.rad(180),18)
		WaitForTurn(tigLil,y_axis)
		---------------------------------------Preparations--------------------------
		--searchmebookmark
		-- do 
		tempTurnRandA=math.random(75,105)
		Turn(dancepivot,y_axis,math.rad(tempTurnRandA),0.35)
		
		Signal(SIG_ONTHEMOVE)
		StartThread(onTheMove)
		WaitForTurn(dancepivot,y_axis)
		Signal(SIG_ONTHEMOVE)
		flopFlip=math.random(0,1)
		Signal(SIG_INCIRCLE)
		if flopFlip==1 then
			Turn(tigLil,y_axis,math.rad(-360),7)
			StartThread(danceTurnRight)
		end
		if flopFlip==0 then
			Turn(tigLil,y_axis,math.rad(360),7)
			StartThread(danceTurnLeft)
		end
		WaitForTurn(tigLil,y_axis)
		Signal(SIG_INCIRCLE)
		
		
		tempTurnRandB=math.random(160,190)
		Turn(dancepivot,y_axis,math.rad(tempTurnRandB),0.35)
		
		Signal(SIG_ONTHEMOVE)
		StartThread(onTheMove)
		WaitForTurn(dancepivot,y_axis)
		Signal(SIG_ONTHEMOVE)
		Signal(SIG_INCIRCLE)
		if flopFlip==1 then
			Turn(tigLil,y_axis,math.rad(-360),7)
			StartThread(danceTurnRight)
		end
		if flopFlip==0 then
			Turn(tigLil,y_axis,math.rad(360),7)
			StartThread(danceTurnLeft)
		end
		WaitForTurn(tigLil,y_axis)
		Signal(SIG_INCIRCLE)
		
		tempTurnRandC=math.random(245,290)
		Turn(dancepivot,y_axis,math.rad(tempTurnRandC),0.35)
		
		Signal(SIG_ONTHEMOVE)
		StartThread(onTheMove)
		WaitForTurn(dancepivot,y_axis)
		Signal(SIG_ONTHEMOVE)
		Signal(SIG_INCIRCLE)
		if flopFlip==1 then
			Turn(tigLil,y_axis,math.rad(-360),7)
			StartThread(danceTurnRight)
		end
		if flopFlip==0 then
			Turn(tigLil,y_axis,math.rad(360),7)
			StartThread(danceTurnLeft)
		end
		WaitForTurn(tigLil,y_axis)
		Signal(SIG_INCIRCLE)
		
		WaitForTurn(dancepivot,y_axis)
		Turn(dancepivot,y_axis,math.rad(360),0.35)
		
		Signal(SIG_ONTHEMOVE)
		StartThread(onTheMove)
		WaitForTurn(dancepivot,y_axis)
		Signal(SIG_ONTHEMOVE)
		Signal(SIG_INCIRCLE)
		if flopFlip==1 then
			Turn(tigLil,y_axis,math.rad(-360),7)
			StartThread(danceTurnRight)
		end
		if flopFlip==0 then
			Turn(tigLil,y_axis,math.rad(360),7)
			StartThread(danceTurnLeft)
		end
		WaitForTurn(tigLil,y_axis)
		Signal(SIG_INCIRCLE)
		
		Turn(tigLil,y_axis,math.rad(0),8)
		WaitForTurn(dancepivot,y_axis)
		
	end
	Signal(SIG_ONTHEMOVE)
	Signal(SIG_INCIRCLE)
	danceEnd()
	Hide(tldrum)
	Sleep(250)
	legs_down()
end

--even numbers left foot up
function drumPose1(mspeed, tspeed)
	
	Turn (tigLil, x_axis, math.rad(0), tspeed)
	Turn (tigLil, y_axis, math.rad(0), tspeed)
	Turn (tigLil, z_axis, math.rad(0), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(20), tspeed)
	Turn (tlHead, y_axis, math.rad(0), tspeed)
	Turn (tlHead, z_axis, math.rad(0), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-69.999992370605), tspeed)
	Turn (tlhairup, y_axis, math.rad(0), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(-30.000001907349), tspeed)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(10.000008583069), tspeed)
	Turn (tlarm, y_axis, math.rad(0), tspeed)
	Turn (tlarm, z_axis, math.rad(-89.999992370605), tspeed)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(0), tspeed)
	Turn (tlarmr, y_axis, math.rad(0), tspeed)
	Turn (tlarmr, z_axis, math.rad(40), tspeed)
	Move (tlsparksemit, x_axis, 0, mspeed)
	Move (tlsparksemit, y_axis, 0, mspeed)
	Move (tlsparksemit, z_axis, 0, mspeed)
	Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(0), tspeed)
	Turn (tllegUp, y_axis, math.rad(0), tspeed)
	Turn (tllegUp, z_axis, math.rad(0), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(0), tspeed)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis, 0, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(-59.999996185303), tspeed)
	Turn (tllegUpR, y_axis, math.rad(-10), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(81.499992370605), tspeed)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(-9.9999980926514), tspeed)
	
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	
	
	
end

function drumPose2(mspeed, tspeed)
	
	Turn (tigLil, x_axis, math.rad(-30.000001907349), tspeed)
	Turn (tigLil, y_axis, math.rad(0), tspeed)
	Turn (tigLil, z_axis, math.rad(10), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(40), tspeed)
	Turn (tlHead, y_axis, math.rad(0), tspeed)
	Turn (tlHead, z_axis, math.rad(10), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-40), tspeed)
	Turn (tlhairup, y_axis, math.rad(40), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(-49.999996185303), tspeed)
	Turn (tlhairdown, y_axis, math.rad(9.9999980926514), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(60.000003814697), tspeed)
	Turn (tlarm, y_axis, math.rad(0), tspeed)
	Turn (tlarm, z_axis, math.rad(-89.999992370605), tspeed)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(69.999992370605), tspeed)
	Turn (tlarmr, y_axis, math.rad(0), tspeed)
	Turn (tlarmr, z_axis, math.rad(20.000001907349), tspeed)
	Move (tlsparksemit, x_axis, 0, mspeed)
	Move (tlsparksemit, y_axis, 0, mspeed)
	Move (tlsparksemit, z_axis, 0, mspeed)
	Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(-29.999998092651), tspeed)
	Turn (tllegUp, y_axis, math.rad(0), tspeed)
	Turn (tllegUp, z_axis, math.rad(0), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(89.999992370605), tspeed)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis, 0, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(40), tspeed)
	Turn (tllegUpR, y_axis, math.rad(-10), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(1.5), tspeed)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(-9.9999980926514), tspeed)
	Move (aimpivot, x_axis, 0, mspeed)
	Move (aimpivot, y_axis, 0, mspeed)
	Move (aimpivot, z_axis, 0, mspeed)
	Turn (aimpivot, x_axis, math.rad(0), tspeed)
	Turn (aimpivot, y_axis, math.rad(0), tspeed)
	Turn (aimpivot, z_axis, math.rad(0), tspeed)
	
	
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
end

local function drumPose3(mspeed, tspeed)
	
	
	Turn (tigLil, x_axis, math.rad(-1.7075473124351e-006), tspeed)
	Turn (tigLil, y_axis, math.rad(0), tspeed)
	Turn (tigLil, z_axis, math.rad(-10.000001907349), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(-34.000007629395), tspeed)
	Turn (tlHead, y_axis, math.rad(0), tspeed)
	Turn (tlHead, z_axis, math.rad(17), tspeed)
	
	Turn (tlhairup, x_axis, math.rad(-20.000001907349), tspeed)
	Turn (tlhairup, y_axis, math.rad(1.7075473124351e-006), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	
	Turn (tlhairdown, x_axis, math.rad(19.999998092651), tspeed)
	Turn (tlhairdown, y_axis, math.rad(9.9999980926514), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	
	Turn (tlarm, x_axis, math.rad(90), 18)
	Turn (tlarm, y_axis, math.rad(0), tspeed)
	Turn (tlarm, z_axis, math.rad(43.000015258789), 9)
	
	
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	
	Turn (tlarmr, x_axis, math.rad(-65.000015258789), 10)
	Turn (tlarmr, y_axis, math.rad(0), tspeed)
	Turn (tlarmr, z_axis, math.rad(20.000001907349), tspeed)
	
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	
	Turn (tllegUp, x_axis, math.rad(16.000003814697), tspeed)
	Turn (tllegUp, y_axis, math.rad(2), tspeed)
	Turn (tllegUp, z_axis, math.rad(-4), tspeed)
	
	Turn (tllegLow, x_axis, math.rad(-2.0490568203968e-005), tspeed)
	Turn (tllegLow, y_axis, math.rad(-45), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	
	Turn (tllegUpR, x_axis, math.rad(-77), tspeed)
	Turn (tllegUpR, y_axis, math.rad(20), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	
	Turn (tllegLowR, x_axis, math.rad(131.49998474121), 22)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(-9.9999980926514), tspeed)
	
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	
end

local function drumPose4(mspeed,tspeed)
	
	bigT=tspeed*3
	Turn (tigLil, x_axis, math.rad(10), tspeed)
	Turn (tigLil, y_axis, math.rad(10), tspeed)
	Turn (tigLil, z_axis, math.rad(10), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(6), tspeed)
	Turn (tlHead, y_axis, math.rad(20), tspeed)
	Turn (tlHead, z_axis, math.rad(17), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-60), bigT)
	Turn (tlhairup, y_axis, math.rad(1.7075473124351e-006), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(-49.999996185303), bigT)
	Turn (tlhairdown, y_axis, math.rad(9.9999980926514), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(163), 19)
	Turn (tlarm, y_axis, math.rad(20.000001907349), tspeed)
	Turn (tlarm, z_axis, math.rad(92.000007629395), bigT)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(-1.9999997615814), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(5), tspeed)
	Turn (tlarmr, y_axis, math.rad(0), tspeed)
	Turn (tlarmr, z_axis, math.rad(90), bigT)
	
	
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(-134), 20)
	Turn (tllegUp, y_axis, math.rad(32), tspeed)
	Turn (tllegUp, z_axis, math.rad(-4), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(120), 20)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis, 0, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(13), tspeed)
	Turn (tllegUpR, y_axis, math.rad(20), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(11.5), tspeed)
	Turn (tllegLowR, y_axis, math.rad(-10), tspeed)
	Turn (tllegLowR, z_axis, math.rad(-12), tspeed)
	
	
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
end

local function drumPose5(mspeed,tspeed)
	
	
	Turn (tigLil, x_axis, math.rad(-5.2999997138977), tspeed)
	Turn (tigLil, y_axis, math.rad(1.8999998569489), tspeed)
	Turn (tigLil, z_axis, math.rad(-1.6999999284744), tspeed)
	
	Turn (tlHead, x_axis, math.rad(-20.000001907349), tspeed)
	Turn (tlHead, y_axis, math.rad(40), 12)
	Turn (tlHead, z_axis, math.rad(0), tspeed)
	
	Turn (tlhairup, x_axis, math.rad(0), tspeed)
	Turn (tlhairup, y_axis, math.rad(-59.999996185303), tspeed)
	Turn (tlhairup, z_axis, math.rad(89.999992370605), tspeed)
	
	Turn (tlhairdown, x_axis, math.rad(-59.999996185303), 13)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	
	
	Turn (tlarm, x_axis, math.rad(-149.99998474121), 23)
	Turn (tlarm, y_axis, math.rad(40), tspeed)
	Turn (tlarm, z_axis, math.rad(-89.999992370605), 17)
	
	
	
	Turn (tlarmr, x_axis, math.rad(-120.09998321533),23)
	Turn (tlarmr, y_axis, math.rad(0), tspeed)
	Turn (tlarmr, z_axis, math.rad(-89.399993896484), 15)
	
	Turn (tllegUp, x_axis, math.rad(0), tspeed)
	Turn (tllegUp, y_axis, math.rad(0), tspeed)
	Turn (tllegUp, z_axis, math.rad(0), tspeed)
	
	Turn (tllegLow, x_axis, math.rad(40), tspeed)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	
	Turn (tllegUpR, x_axis, math.rad(-99.999984741211), 16)
	Turn (tllegUpR, y_axis, math.rad(20), tspeed)
	Turn (tllegUpR, z_axis, math.rad(10), tspeed)
	
	Turn (tllegLowR, x_axis, math.rad(109.99999237061), 17)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	
	
	
	
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
end

local function drumPose6(mspeed,tspeed, addUp)
	
	--drumjump
	Move (tigLil, x_axis, 0, mspeed)
	addUp=addUp-5.5
	Move (tigLil, y_axis, addUp, 20)
	Move (tigLil, z_axis, 6, mspeed)
	Turn (tigLil, x_axis, math.rad(-55.299999237061), 12)
	Turn (tigLil, y_axis, math.rad(1.8999998569489), tspeed)
	Turn (tigLil, z_axis, math.rad(-1.6999999284744), tspeed)
	
	Turn (tlHead, x_axis, math.rad(40), 9)
	Turn (tlHead, y_axis, math.rad(-9.9999980926514), tspeed)
	Turn (tlHead, z_axis, math.rad(10), tspeed)
	
	Turn (tlhairup, x_axis, math.rad(-20.000001907349), 7)
	Turn (tlhairup, y_axis, math.rad(-40), 9)
	Turn (tlhairup, z_axis, math.rad(20.000001907349), tspeed)
	
	Turn (tlhairdown, x_axis, math.rad(29.999998092651), 8)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	
	Turn (tlarm, x_axis, math.rad(-109.89999389648), 15)
	Turn (tlarm, y_axis, math.rad(168.99998474121), 22)
	Turn (tlarm, z_axis, math.rad(-101.89998626709), 15)
	
	Turn (tlarmr, x_axis, math.rad(-84.100021362305), 13)
	Turn (tlarmr, y_axis, math.rad(49.999996185303), 9)
	Turn (tlarmr, z_axis, math.rad(-89.399993896484), 12)
	
	Turn (tllegUp, x_axis, math.rad(20.000001907349), 7)
	Turn (tllegUp, y_axis, math.rad(-19.999998092651), tspeed)
	Turn (tllegUp, z_axis, math.rad(-20), tspeed)
	Turn (tllegLow, x_axis, math.rad(109.99999237061), 11)
	Turn (tllegLow, y_axis, math.rad(-10), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Turn (tllegUpR, x_axis, math.rad(12.000003814697), tspeed)
	Turn (tllegUpR, y_axis, math.rad(30.000001907349), 7)
	Turn (tllegUpR, z_axis, math.rad(30.000001907349), 5)
	
	Turn (tllegLowR, x_axis, math.rad(115.99987792969), 22)
	Turn (tllegLowR, y_axis, math.rad(-10), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	
	WaitForTurn(tigLil, x_axis) 
	WaitForTurn(tigLil, y_axis) 
	WaitForTurn(tigLil, z_axis) 
	WaitForMove(tlHead, x_axis) 
	WaitForMove(tlHead, y_axis) 
	WaitForMove(tlHead, z_axis) 
	WaitForTurn(tlHead, x_axis) 
	WaitForTurn(tlHead, y_axis) 
	WaitForTurn(tlHead, z_axis) 
	WaitForMove(tlhairup, x_axis) 
	WaitForMove(tlhairup, y_axis) 
	WaitForMove(tlhairup, z_axis) 
	WaitForTurn(tlhairup, x_axis) 
	WaitForTurn(tlhairup, y_axis) 
	WaitForTurn(tlhairup, z_axis) 
	WaitForMove(tlhairdown, x_axis) 
	WaitForMove(tlhairdown, y_axis) 
	WaitForMove(tlhairdown, z_axis) 
	WaitForTurn(tlhairdown, x_axis) 
	WaitForTurn(tlhairdown, y_axis) 
	WaitForTurn(tlhairdown, z_axis) 
	WaitForMove(tlflute, x_axis) 
	WaitForMove(tlflute, y_axis) 
	WaitForMove(tlflute, z_axis) 
	WaitForTurn(tlflute, x_axis) 
	WaitForTurn(tlflute, y_axis) 
	WaitForTurn(tlflute, z_axis) 
	WaitForMove(tlarm, x_axis) 
	WaitForMove(tlarm, y_axis) 
	WaitForMove(tlarm, z_axis) 
	WaitForTurn(tlarm, x_axis) 
	WaitForTurn(tlarm, y_axis) 
	WaitForTurn(tlarm, z_axis) 
	
	
	WaitForMove(tldrum, x_axis) 
	WaitForMove(tldrum, y_axis) 
	WaitForMove(tldrum, z_axis) 
	WaitForTurn(tldrum, x_axis) 
	WaitForTurn(tldrum, y_axis) 
	WaitForTurn(tldrum, z_axis) 
	WaitForMove(tlarmr, x_axis) 
	WaitForMove(tlarmr, y_axis) 
	WaitForMove(tlarmr, z_axis) 
	WaitForTurn(tlarmr, x_axis) 
	WaitForTurn(tlarmr, y_axis) 
	WaitForTurn(tlarmr, z_axis) 
	
	WaitForMove(tlharp, x_axis) 
	WaitForMove(tlharp, y_axis) 
	WaitForMove(tlharp, z_axis) 
	WaitForTurn(tlharp, x_axis) 
	WaitForTurn(tlharp, y_axis) 
	WaitForTurn(tlharp, z_axis) 
	WaitForMove(tllegUp, x_axis) 
	WaitForMove(tllegUp, y_axis) 
	WaitForMove(tllegUp, z_axis) 
	WaitForTurn(tllegUp, x_axis) 
	WaitForTurn(tllegUp, y_axis) 
	WaitForTurn(tllegUp, z_axis) 
	WaitForMove(tllegLow, x_axis) 
	WaitForMove(tllegLow, y_axis) 
	WaitForMove(tllegLow, z_axis) 
	WaitForTurn(tllegLow, x_axis) 
	WaitForTurn(tllegLow, y_axis) 
	WaitForTurn(tllegLow, z_axis) 
	WaitForMove(tllegUpR, x_axis) 
	WaitForMove(tllegUpR, y_axis) 
	WaitForMove(tllegUpR, z_axis) 
	WaitForTurn(tllegUpR, x_axis) 
	WaitForTurn(tllegUpR, y_axis) 
	WaitForTurn(tllegUpR, z_axis) 
	WaitForMove(tllegLowR, x_axis) 
	WaitForMove(tllegLowR, y_axis) 
	WaitForMove(tllegLowR, z_axis) 
	WaitForTurn(tllegLowR, x_axis) 
	WaitForTurn(tllegLowR, y_axis) 
	WaitForTurn(tllegLowR, z_axis) 
	Move(tigLil, x_axis, 0,25)
	addUp=addUp+2.5
	Move(tigLil, y_axis, addUp,25)
	WaitForMove(tigLil, y_axis)
	
end

local function drumPose7(mspeed,tspeed, addUp)
	
	Move (tigLil, x_axis, 0, mspeed)
	addUp=addUp-5.5
	Move (tigLil, y_axis, addUp, mspeed)
	
	
	Move (tigLil, x_axis, 0, mspeed)
	Move (tigLil, y_axis,addUp, mspeed)
	
	Turn (tigLil, x_axis, math.rad(14.699995994568), tspeed)
	Turn (tigLil, y_axis, math.rad(1.8999998569489), tspeed)
	Turn (tigLil, z_axis, math.rad(-1.6999999284744), tspeed)
	
	Turn (tlHead, x_axis, math.rad(10.000001907349), tspeed)
	Turn (tlHead, y_axis, math.rad(-9.9999980926514), tspeed)
	Turn (tlHead, z_axis, math.rad(10), tspeed)
	
	Turn (tlhairup, x_axis, math.rad(-89.999992370605), 12)
	Turn (tlhairup, y_axis, math.rad(-1.7075473124351e-006), tspeed)
	Turn (tlhairup, z_axis, math.rad(20.000001907349), tspeed)
	
	Turn (tlhairdown, x_axis, math.rad(29.999998092651), tspeed)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Turn (tlarm, x_axis, math.rad(-139.89999389648), 22)
	Turn (tlarm, y_axis, math.rad(99), 16)
	Turn (tlarm, z_axis, math.rad(-101.89998626709), 16)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(-54.100028991699), 8)
	Turn (tlarmr, y_axis, math.rad(49.999996185303), tspeed)
	Turn (tlarmr, z_axis, math.rad(-89.399993896484), tspeed)
	Turn (tllegUp, x_axis, math.rad(-109.99998474121), tspeed)
	Turn (tllegUp, y_axis, math.rad(20.000001907349), tspeed)
	Turn (tllegUp, z_axis, math.rad(-20), tspeed)
	Turn (tllegLow, x_axis, math.rad(-9.9999914169312), tspeed)
	Turn (tllegLow, y_axis, math.rad(-10), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Turn (tllegUpR, x_axis, math.rad(-107.99998474121), 15)
	Turn (tllegUpR, y_axis, math.rad(-1.7075473124351e-006), tspeed)
	Turn (tllegUpR, z_axis, math.rad(1.7075473124351e-006), tspeed)
	Turn (tllegLowR, x_axis, math.rad(135.99987792969), tspeed)
	Turn (tllegLowR, y_axis, math.rad(-10), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	
	
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	Move (tigLil, x_axis, 0,25)
	addUp=addUp+5.5
	Move (tigLil, y_axis, addUp,25)
	WaitForMove(tigLil, y_axis)
end


local function drumPose8 (mspeed,tspeed)
	tspeed=3
	--HipShake
	rand=math.random(2,7)
	insomnia=484
	for i=0, rand, 1 do
		
		--Move (deathpivot, x_axis, 0, mspeed)
		Turn (tigLil, x_axis, math.rad(0), tspeed)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(-10), tspeed)
		Move (tlHead, x_axis, 0, mspeed)
		Move (tlHead, y_axis, 0, mspeed)
		Move (tlHead, z_axis, 0, mspeed)
		Turn (tlHead, x_axis, math.rad(10), tspeed)
		Turn (tlHead, y_axis, math.rad(0), tspeed)
		Turn (tlHead, z_axis, math.rad(-10), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0, mspeed)
		Move (tlhairup, z_axis, 0, mspeed)
		Turn (tlhairup, x_axis, math.rad(-71.999992370605), 6)
		Turn (tlhairup, y_axis, math.rad(20), tspeed)
		Turn (tlhairup, z_axis, math.rad(0), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(-30.000001907349), tspeed)
		Turn (tlhairdown, y_axis, math.rad(0), tspeed)
		Turn (tlhairdown, z_axis, math.rad(0), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(0), tspeed)
		Turn (tlflute, y_axis, math.rad(0), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Move (tlarm, x_axis, 0, mspeed)
		Move (tlarm, y_axis, 0, mspeed)
		Move (tlarm, z_axis, 0, mspeed)
		Turn (tlarm, x_axis, math.rad(5.0000009536743), tspeed)
		Turn (tlarm, y_axis, math.rad(-21.999998092651), tspeed)
		Turn (tlarm, z_axis, math.rad(93.999977111816), 8)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		
		Move (tlarmr, x_axis, 0, mspeed)
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(-10.000001907349), tspeed)
		Turn (tlarmr, y_axis, math.rad(79.999992370605), 6)
		Turn (tlarmr, z_axis, math.rad(-69.999992370605), 5)
		
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, 0, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(0), tspeed)
		Turn (tllegUp, y_axis, math.rad(0), tspeed)
		Turn (tllegUp, z_axis, math.rad(10), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(0), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, -5.9604644775391e-008, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(1.7075473124351e-006), tspeed)
		Turn (tllegUpR, y_axis, math.rad(-10), tspeed)
		Turn (tllegUpR, z_axis, math.rad(10), tspeed)
		Move (tllegLowR, x_axis, 0, mspeed)
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(0), tspeed)
		Turn (tllegLowR, y_axis, math.rad(0), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		
		
		
		Sleep(insomnia)
		insomnia=insomnia+180
		
		Turn (deathpivot, x_axis, math.rad(0), tspeed)
		Turn (deathpivot, y_axis, math.rad(0), tspeed)
		Turn (deathpivot, z_axis, math.rad(0), tspeed)
		
		Turn (dancepivot, x_axis, math.rad(0), tspeed)
		Turn (dancepivot, y_axis, math.rad(0), tspeed)
		Turn (dancepivot, z_axis, math.rad(0), tspeed)
		
		Turn (tigLil, x_axis, math.rad(0), tspeed)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(0), tspeed)
		
		Turn (tlHead, x_axis, math.rad(11), tspeed)
		Turn (tlHead, y_axis, math.rad(0), tspeed)
		Turn (tlHead, z_axis, math.rad(3), tspeed)
		
		Turn (tlhairup, x_axis, math.rad(-119.99997711182), 10)
		Turn (tlhairup, y_axis, math.rad(147.99998474121), 14)
		Turn (tlhairup, z_axis, math.rad(-149.99996948242), 16)
		
		Turn (tlhairdown, x_axis, math.rad(-30.000001907349), tspeed)
		Turn (tlhairdown, y_axis, math.rad(0), tspeed)
		Turn (tlhairdown, z_axis, math.rad(0), tspeed)
		
		Turn (tlarm, x_axis, math.rad(3.0000014305115), tspeed)
		Turn (tlarm, y_axis, math.rad(-67.000038146973), tspeed)
		Turn (tlarm, z_axis, math.rad(86.999969482422), 10)
		
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(-4.0000014305115), tspeed)
		Turn (tlarmr, y_axis, math.rad(97.000007629395), 10)
		Turn (tlarmr, z_axis, math.rad(-85.999969482422), tspeed)
		
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		
		Turn (tllegUp, x_axis, math.rad(0), tspeed)
		Turn (tllegUp, y_axis, math.rad(0), tspeed)
		Turn (tllegUp, z_axis, math.rad(0), tspeed)
		
		Turn (tllegLow, x_axis, math.rad(0), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		
		Turn (tllegUpR, x_axis, math.rad(1.7075473124351e-006), tspeed)
		Turn (tllegUpR, y_axis, math.rad(-10), tspeed)
		Turn (tllegUpR, z_axis, math.rad(-10), tspeed)
		
		Turn (tllegLowR, x_axis, math.rad(0), tspeed)
		Turn (tllegLowR, y_axis, math.rad(0), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		insomnia=insomnia/2
		intCast=insomnia%1
		insomnia=insomnia-intCast
		Sleep(insomnia)
		
		
	end
	
end

--TurnÜbungen
local function drumPose(mspeed,tspeed,addUp)
	randyPro=math.random(2,8)
	
	for i=0, randyPro, 1 do
		Move (deathpivot, x_axis, 0, mspeed)
		Move (deathpivot, y_axis, 0, mspeed)
		Move (deathpivot, z_axis, 0, mspeed)
		Turn (deathpivot, x_axis, math.rad(0), tspeed)
		Turn (deathpivot, y_axis, math.rad(0), tspeed)
		Turn (deathpivot, z_axis, math.rad(0), tspeed)
		Move (dancepivot, x_axis, 0, mspeed)
		Move (dancepivot, y_axis, 0, mspeed)
		Move (dancepivot, z_axis, 0, mspeed)
		Turn (dancepivot, x_axis, math.rad(0), tspeed)
		Turn (dancepivot, y_axis, math.rad(0), tspeed)
		Turn (dancepivot, z_axis, math.rad(0), tspeed)
		addUp1=addUp-10.5 --7
		
		Move (tigLil, x_axis, 0, mspeed)
		Move (tigLil, y_axis, addUp1, 8)
		
		Move (tigLil, z_axis, 0, mspeed)
		Turn (tigLil, x_axis, math.rad(-104.00002288818), tspeed)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(0), tspeed)
		Move (tlHead, x_axis, 0, mspeed)
		Move (tlHead, y_axis, 0, mspeed)
		Move (tlHead, z_axis, 0, mspeed)
		Turn (tlHead, x_axis, math.rad(20), tspeed)
		Turn (tlHead, y_axis, math.rad(0), tspeed)
		Turn (tlHead, z_axis, math.rad(0), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0, mspeed)
		Move (tlhairup, z_axis, 0, mspeed)
		Turn (tlhairup, x_axis, math.rad(80), tspeed)
		Turn (tlhairup, y_axis, math.rad(1.7075473124351e-006), tspeed)
		Turn (tlhairup, z_axis, math.rad(0), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(0), tspeed)
		Turn (tlhairdown, y_axis, math.rad(0), tspeed)
		Turn (tlhairdown, z_axis, math.rad(0), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(0), tspeed)
		Turn (tlflute, y_axis, math.rad(0), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Move (tlarm, x_axis, 0, mspeed)
		Move (tlarm, y_axis, 0, mspeed)
		Move (tlarm, z_axis, 0, mspeed)
		Turn (tlarm, x_axis, math.rad(0), tspeed)
		Turn (tlarm, y_axis, math.rad(0), tspeed)
		Turn (tlarm, z_axis, math.rad(-30.000001907349), tspeed)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		Move (tldrum, x_axis, 0, mspeed)
		Move (tldrum, y_axis, 0, mspeed)
		Move (tldrum, z_axis, 0, mspeed)
		Turn (tldrum, x_axis, math.rad(0), tspeed)
		Turn (tldrum, y_axis, math.rad(0), tspeed)
		Turn (tldrum, z_axis, math.rad(0), tspeed)
		Move (tlarmr, x_axis, 0, mspeed)
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(0), tspeed)
		Turn (tlarmr, y_axis, math.rad(-1.7075473124351e-006), tspeed)
		Turn (tlarmr, z_axis, math.rad(40), tspeed)
		Move (tlsparksemit, x_axis, 0, mspeed)
		Move (tlsparksemit, y_axis, 0, mspeed)
		Move (tlsparksemit, z_axis, 0, mspeed)
		Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
		Move (tlharp, x_axis, 0, mspeed)
		Move (tlharp, y_axis, 0, mspeed)
		Move (tlharp, z_axis, 0, mspeed)
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, 0, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(-79.999992370605), tspeed)
		Turn (tllegUp, y_axis, math.rad(0), tspeed)
		Turn (tllegUp, z_axis, math.rad(0), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(99.999992370605), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, 0, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(-60.999996185303), tspeed)
		Turn (tllegUpR, y_axis, math.rad(0), tspeed)
		Turn (tllegUpR, z_axis, math.rad(0), tspeed)
		Move (tllegLowR, x_axis, 0, mspeed)
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(79.999992370605), tspeed)
		Turn (tllegLowR, y_axis, math.rad(0), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		Move (aimpivot, x_axis, 0, mspeed)
		Move (aimpivot, y_axis, 0, mspeed)
		Move (aimpivot, z_axis, 0, mspeed)
		Turn (aimpivot, x_axis, math.rad(0), tspeed)
		Turn (aimpivot, y_axis, math.rad(0), tspeed)
		Turn (aimpivot, z_axis, math.rad(0), tspeed)
		
		
		
		SleepIncrease=250-(12.5*i)
		WaitForMove (tigLil, y_axis)
		Sleep(SleepIncrease)
		Move (deathpivot, x_axis, 0, mspeed)
		Move (deathpivot, y_axis, 0, mspeed)
		Move (deathpivot, z_axis, 0, mspeed)
		Turn (deathpivot, x_axis, math.rad(0), tspeed)
		Turn (deathpivot, y_axis, math.rad(0), tspeed)
		Turn (deathpivot, z_axis, math.rad(0), tspeed)
		Move (dancepivot, x_axis, 0, mspeed)
		Move (dancepivot, y_axis, 0, mspeed)
		Move (dancepivot, z_axis, 0, mspeed)
		Turn (dancepivot, x_axis, math.rad(0), tspeed)
		Turn (dancepivot, y_axis, math.rad(0), tspeed)
		Turn (dancepivot, z_axis, math.rad(0), tspeed)
		Move (tigLil, x_axis, 0, mspeed)
		addUp2=addUp-7.5000019073486 --6
		----Spring.Echo("addUp 8")
		Move (tigLil, y_axis,addUp2 , 7)
		Move (tigLil, z_axis, 0, mspeed)
		Turn (tigLil, x_axis, math.rad(-124.00002288818), tspeed)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(0), tspeed)
		Move (tlHead, x_axis, -1.5, mspeed)
		Move (tlHead, y_axis, -0.5, mspeed)
		Move (tlHead, z_axis, 1.5, mspeed)
		Turn (tlHead, x_axis, math.rad(68), tspeed)
		Turn (tlHead, y_axis, math.rad(-4), tspeed)
		Turn (tlHead, z_axis, math.rad(-2.0000007152557), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0, mspeed)
		Move (tlhairup, z_axis, -0.20000076293945, mspeed)
		Turn (tlhairup, x_axis, math.rad(60.000003814697), tspeed)
		Turn (tlhairup, y_axis, math.rad(1.7075473124351e-006), tspeed)
		Turn (tlhairup, z_axis, math.rad(10.000001907349), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(0), tspeed)
		Turn (tlhairdown, y_axis, math.rad(0), tspeed)
		Turn (tlhairdown, z_axis, math.rad(0), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(0), tspeed)
		Turn (tlflute, y_axis, math.rad(0), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Move (tlarm, x_axis, 0, mspeed)
		Move (tlarm, y_axis, 0, mspeed)
		Move (tlarm, z_axis, 0, mspeed)
		Turn (tlarm, x_axis, math.rad(-20), tspeed)
		Turn (tlarm, y_axis, math.rad(10), tspeed)
		Turn (tlarm, z_axis, math.rad(19.999998092651), tspeed)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		Move (tldrum, x_axis, 0, mspeed)
		Move (tldrum, y_axis, 0, mspeed)
		Move (tldrum, z_axis, 0, mspeed)
		Turn (tldrum, x_axis, math.rad(0), tspeed)
		Turn (tldrum, y_axis, math.rad(0), tspeed)
		Turn (tldrum, z_axis, math.rad(0), tspeed)
		Move (tlarmr, x_axis, 0, mspeed)
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(-20), tspeed)
		Turn (tlarmr, y_axis, math.rad(-1.7075473124351e-006), tspeed)
		Turn (tlarmr, z_axis, math.rad(-19.999998092651), tspeed)
		Move (tlsparksemit, x_axis, 0, mspeed)
		Move (tlsparksemit, y_axis, 0, mspeed)
		Move (tlsparksemit, z_axis, 0, mspeed)
		Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
		Move (tlharp, x_axis, 0, mspeed)
		Move (tlharp, y_axis, 0, mspeed)
		Move (tlharp, z_axis, 0, mspeed)
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, 0, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(19.999998092651), tspeed)
		Turn (tllegUp, y_axis, math.rad(1.7075473124351e-006), tspeed)
		Turn (tllegUp, z_axis, math.rad(-20), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(99.999992370605), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, 0, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(19), tspeed)
		Turn (tllegUpR, y_axis, math.rad(0), tspeed)
		Turn (tllegUpR, z_axis, math.rad(20), tspeed)
		
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(89.999992370605), tspeed)
		Turn (tllegLowR, y_axis, math.rad(0), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		WaitForMove (tigLil, y_axis)
	end
	
	Turn (tigLil, x_axis, math.rad(0), 0.15)
	Turn (tigLil, y_axis, math.rad(0), 0.15)
	Turn (tigLil, z_axis, math.rad(0), 0.15)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(-20), tspeed)
	Turn (tlHead, y_axis, math.rad(20), tspeed)
	Turn (tlHead, z_axis, math.rad(0), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-49.999984741211), tspeed)
	Turn (tlhairup, y_axis, math.rad(-12.000000953674), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(-26.000001907349), tspeed)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(10), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(-179.99998474121), tspeed)
	Turn (tlarm, y_axis, math.rad(-10.000001907349), tspeed)
	Turn (tlarm, z_axis, math.rad(89.999992370605), tspeed)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(-179.99998474121), tspeed)
	Turn (tlarmr, y_axis, math.rad(-20.000001907349), tspeed)
	Turn (tlarmr, z_axis, math.rad(-79.999992370605), tspeed)
	Move (tlsparksemit, x_axis, 0, mspeed)
	Move (tlsparksemit, y_axis, 0, mspeed)
	Move (tlsparksemit, z_axis, 0, mspeed)
	Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(0), tspeed)
	Turn (tllegUp, y_axis, math.rad(0), tspeed)
	Turn (tllegUp, z_axis, math.rad(0), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(10), tspeed)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis, -5.9604644775391e-008, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(-10), tspeed)
	Turn (tllegUpR, y_axis, math.rad(0), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(30.000001907349), tspeed)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	--WaitForTurn (tigLil, x_axis) 
	--WaitForTurn (tigLil, y_axis) 
	--WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	
	
end

local function drumPoseNeutral(mspeed,tspeed,addUp)
	
	Turn (tigLil, x_axis, math.rad(0), tspeed)
	Turn (tigLil, y_axis, math.rad(0), tspeed)
	Turn (tigLil, z_axis, math.rad(0), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(-20), tspeed)
	Turn (tlHead, y_axis, math.rad(20), tspeed)
	Turn (tlHead, z_axis, math.rad(0), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-49.999984741211), 10)
	Turn (tlhairup, y_axis, math.rad(-12.000000953674), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(-26.000001907349), tspeed)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(10), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(-179.99998474121), 27)
	Turn (tlarm, y_axis, math.rad(-10.000001907349), tspeed)
	Turn (tlarm, z_axis, math.rad(89.999992370605), 16)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(-179.99998474121), 27)
	Turn (tlarmr, y_axis, math.rad(-20.000001907349), tspeed)
	Turn (tlarmr, z_axis, math.rad(-79.999992370605), tspeed)
	Move (tlsparksemit, x_axis, 0, mspeed)
	Move (tlsparksemit, y_axis, 0, mspeed)
	Move (tlsparksemit, z_axis, 0, mspeed)
	Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(0), tspeed)
	Turn (tllegUp, y_axis, math.rad(0), tspeed)
	Turn (tllegUp, z_axis, math.rad(0), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(10), tspeed)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis,0, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(-10), tspeed)
	Turn (tllegUpR, y_axis, math.rad(0), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(30.000001907349), tspeed)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	
	
	
	
	
end


local function drumPoseNeutral2(mspeed,tspeed,addUp)
	addUp=addUp-7
	----Spring.Echo("Addup 5 to -7 neutral pose 2 ")
	
	Move (tigLil, x_axis, 0, mspeed)
	Move (tigLil, y_axis,addUp, mspeed)
	Move (tigLil, z_axis, 0, mspeed)
	Turn (tigLil, x_axis, math.rad(0), tspeed)
	Turn (tigLil, y_axis, math.rad(0), tspeed)
	Turn (tigLil, z_axis, math.rad(0), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(10), tspeed)
	Turn (tlHead, y_axis, math.rad(10.000001907349), tspeed)
	Turn (tlHead, z_axis, math.rad(0), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-49.999984741211), tspeed)
	Turn (tlhairup, y_axis, math.rad(-12.000000953674), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(-26.000001907349), tspeed)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(10), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(-80), 14)
	Turn (tlarm, y_axis, math.rad(-10.000001907349), tspeed)
	Turn (tlarm, z_axis, math.rad(89.999992370605), tspeed)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(-269.99996948242), 24)
	Turn (tlarmr, y_axis, math.rad(-20.000001907349), tspeed)
	Turn (tlarmr, z_axis, math.rad(-79.999992370605), 11)
	Move (tlsparksemit, x_axis, 0, mspeed)
	Move (tlsparksemit, y_axis, 0, mspeed)
	Move (tlsparksemit, z_axis, 0, mspeed)
	Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(-92.999984741211), 10)
	Turn (tllegUp, y_axis, math.rad(-89.999992370605), 9)
	Turn (tllegUp, z_axis, math.rad(20), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(149.99998474121), 12)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis, -5.9604644775391e-008, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(-69.999969482422), 10)
	Turn (tllegUpR, y_axis, math.rad(0), tspeed)
	Turn (tllegUpR, z_axis, math.rad(79.999992370605), 10)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(139.99998474121), 20)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	
	
	
end

local function drumPoseNeutral3(mspeed,tspeed,addUp)
	
	
	rand=math.random(0,1)
	if rand==1 then
		
		addUp=addUp-8
		----Spring.Echo("DrumPoseNeutral3 ")
		----Spring.Echo(addUp)
		Move (tigLil, x_axis, 0, mspeed)
		Move (tigLil, y_axis, addUp, mspeed)
		Move (tigLil, z_axis, 0, mspeed)--5.9604644775391e-008
		Turn (tigLil, x_axis, math.rad(89.999992370605), 10)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(0), tspeed)
		Move (tlHead, x_axis, 0, mspeed)
		Move (tlHead, y_axis, -0.5, mspeed)
		Move (tlHead, z_axis, -0.5, mspeed)
		Turn (tlHead, x_axis, math.rad(-99.999984741211), 11)
		Turn (tlHead, y_axis, math.rad(-7.9999976158142), tspeed)
		Turn (tlHead, z_axis, math.rad(-8), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0.99999994039536, mspeed)
		Move (tlhairup, z_axis, 1, mspeed)
		Turn (tlhairup, x_axis, math.rad(21.000015258789), tspeed)
		Turn (tlhairup, y_axis, math.rad(7.9999957084656), tspeed)
		Turn (tlhairup, z_axis, math.rad(10), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(-26.000001907349), tspeed)
		Turn (tlhairdown, y_axis, math.rad(10), tspeed)
		Turn (tlhairdown, z_axis, math.rad(10), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(10), tspeed)
		Turn (tlflute, y_axis, math.rad(10), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Move (tlarm, x_axis, 0, mspeed)
		Move (tlarm, y_axis, 0, mspeed)
		Move (tlarm, z_axis, 0, mspeed)
		Turn (tlarm, x_axis, math.rad(-179.99998474121), 22)
		Turn (tlarm, y_axis, math.rad(-20.000001907349), tspeed)
		Turn (tlarm, z_axis, math.rad(40), tspeed)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		Move (tldrum, x_axis, 0, mspeed)
		Move (tldrum, y_axis, 0, mspeed)
		Move (tldrum, z_axis, 0, mspeed)
		Turn (tldrum, x_axis, math.rad(0), tspeed)
		Turn (tldrum, y_axis, math.rad(0), tspeed)
		Turn (tldrum, z_axis, math.rad(0), tspeed)
		Move (tlarmr, x_axis, 0, mspeed)
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(-54.699993133545), tspeed)
		Turn (tlarmr, y_axis, math.rad(-109.99999237061), 21)
		Turn (tlarmr, z_axis, math.rad(97), tspeed)
		Move (tlsparksemit, x_axis, 0, mspeed)
		Move (tlsparksemit, y_axis, 0, mspeed)
		Move (tlsparksemit, z_axis, 0, mspeed)
		Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
		Move (tlharp, x_axis, 0, mspeed)
		Move (tlharp, y_axis, 0, mspeed)
		Move (tlharp, z_axis, 0, mspeed)
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, -0.5, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(-90.999984741211), 12)
		Turn (tllegUp, y_axis, math.rad(-92.999992370605), 13)
		Turn (tllegUp, z_axis, math.rad(20), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(8.5377369032358e-006), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, -5.9604644775391e-008, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(-69.999969482422), tspeed)
		Turn (tllegUpR, y_axis, math.rad(0), tspeed)
		Turn (tllegUpR, z_axis, math.rad(79.999992370605), tspeed)
		Move (tllegLowR, x_axis, 0, mspeed)
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(3), tspeed)
		Turn (tllegLowR, y_axis, math.rad(-9.9999914169312), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		
		
		
		Sleep(150)
	end
	if rand==0 then
		addUp=addUp-7.5
		
		----Spring.Echo(addUp)
		Move (tigLil, x_axis, 0, mspeed)
		Move (tigLil, y_axis, addUp, mspeed)
		Move (tigLil, z_axis, 0, mspeed)-- 5.9604644775391e-008
		Turn (tigLil, x_axis, math.rad(0), tspeed)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(0), tspeed)
		Move (tlHead, x_axis, 0, mspeed)
		Move (tlHead, y_axis, 0, mspeed)
		Move (tlHead, z_axis, 0, mspeed)
		Turn (tlHead, x_axis, math.rad(8.9999990463257), tspeed)
		Turn (tlHead, y_axis, math.rad(-7.9999980926514), tspeed)
		Turn (tlHead, z_axis, math.rad(0), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0, mspeed)
		Move (tlhairup, z_axis, 0, mspeed)
		Turn (tlhairup, x_axis, math.rad(-68.999977111816), tspeed)
		Turn (tlhairup, y_axis, math.rad(7.9999957084656), tspeed)
		Turn (tlhairup, z_axis, math.rad(10), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(-26.000001907349), tspeed)
		Turn (tlhairdown, y_axis, math.rad(10), tspeed)
		Turn (tlhairdown, z_axis, math.rad(10), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(10), tspeed)
		Turn (tlflute, y_axis, math.rad(10), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Move (tlarm, x_axis, 0, mspeed)
		Move (tlarm, y_axis, 0, mspeed)
		Move (tlarm, z_axis, 0, mspeed)
		Turn (tlarm, x_axis, math.rad(-179.99998474121), 26)
		Turn (tlarm, y_axis, math.rad(-20.000001907349), tspeed)
		Turn (tlarm, z_axis, math.rad(40), tspeed)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		Move (tldrum, x_axis, 0, mspeed)
		Move (tldrum, y_axis, 0, mspeed)
		Move (tldrum, z_axis, 0, mspeed)
		Turn (tldrum, x_axis, math.rad(0), tspeed)
		Turn (tldrum, y_axis, math.rad(0), tspeed)
		Turn (tldrum, z_axis, math.rad(0), tspeed)
		Move (tlarmr, x_axis, 0, mspeed)
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(-54.699993133545), tspeed)
		Turn (tlarmr, y_axis, math.rad(-109.99999237061), 10)
		Turn (tlarmr, z_axis, math.rad(97), tspeed)
		Move (tlsparksemit, x_axis, 0, mspeed)
		Move (tlsparksemit, y_axis, 0, mspeed)
		Move (tlsparksemit, z_axis, 0, mspeed)
		Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
		Move (tlharp, x_axis, 0, mspeed)
		Move (tlharp, y_axis, 0, mspeed)
		Move (tlharp, z_axis, 0, mspeed)
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, 0, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(-92.999984741211), 12)
		Turn (tllegUp, y_axis, math.rad(-89.999992370605), 15)
		Turn (tllegUp, z_axis, math.rad(20), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(8.5377369032358e-006), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, -5.9604644775391e-008, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(-69.999969482422), tspeed)
		Turn (tllegUpR, y_axis, math.rad(0), tspeed)
		Turn (tllegUpR, z_axis, math.rad(79.999992370605), 10)
		Move (tllegLowR, x_axis, 0, mspeed)
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(3), tspeed)
		Turn (tllegLowR, y_axis, math.rad(-9.9999914169312), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		Move (aimpivot, x_axis, 0, mspeed)
		Move (aimpivot, y_axis, 0, mspeed)
		Move (aimpivot, z_axis, 0, mspeed)
		Turn (aimpivot, x_axis, math.rad(0), tspeed)
		Turn (aimpivot, y_axis, math.rad(0), tspeed)
		Turn (aimpivot, z_axis, math.rad(0), tspeed)
		
		
		
		
		WaitForTurn (tigLil, x_axis) 
		WaitForTurn (tigLil, y_axis) 
		WaitForTurn (tigLil, z_axis) 
		WaitForMove (tlHead, x_axis) 
		WaitForMove (tlHead, y_axis) 
		WaitForMove (tlHead, z_axis) 
		WaitForTurn (tlHead, x_axis) 
		WaitForTurn (tlHead, y_axis) 
		WaitForTurn (tlHead, z_axis) 
		WaitForMove (tlhairup, x_axis) 
		WaitForMove (tlhairup, y_axis) 
		WaitForMove (tlhairup, z_axis) 
		WaitForTurn (tlhairup, x_axis) 
		WaitForTurn (tlhairup, y_axis) 
		WaitForTurn (tlhairup, z_axis) 
		WaitForMove (tlhairdown, x_axis) 
		WaitForMove (tlhairdown, y_axis) 
		WaitForMove (tlhairdown, z_axis) 
		WaitForTurn (tlhairdown, x_axis) 
		WaitForTurn (tlhairdown, y_axis) 
		WaitForTurn (tlhairdown, z_axis) 
		WaitForMove (tlflute, x_axis) 
		WaitForMove (tlflute, y_axis) 
		WaitForMove (tlflute, z_axis) 
		WaitForTurn (tlflute, x_axis) 
		WaitForTurn (tlflute, y_axis) 
		WaitForTurn (tlflute, z_axis) 
		WaitForMove (tlarm, x_axis) 
		WaitForMove (tlarm, y_axis) 
		WaitForMove (tlarm, z_axis) 
		WaitForTurn (tlarm, x_axis) 
		WaitForTurn (tlarm, y_axis) 
		WaitForTurn (tlarm, z_axis) 
		WaitForMove (tlsparksemit2, x_axis) 
		WaitForMove (tlsparksemit2, y_axis) 
		WaitForMove (tlsparksemit2, z_axis) 
		WaitForTurn (tlsparksemit2, x_axis) 
		WaitForTurn (tlsparksemit2, y_axis) 
		WaitForTurn (tlsparksemit2, z_axis) 
		WaitForMove (tldrum, x_axis) 
		WaitForMove (tldrum, y_axis) 
		WaitForMove (tldrum, z_axis) 
		WaitForTurn (tldrum, x_axis) 
		WaitForTurn (tldrum, y_axis) 
		WaitForTurn (tldrum, z_axis) 
		WaitForMove (tlarmr, x_axis) 
		WaitForMove (tlarmr, y_axis) 
		WaitForMove (tlarmr, z_axis) 
		WaitForTurn (tlarmr, x_axis) 
		WaitForTurn (tlarmr, y_axis) 
		WaitForTurn (tlarmr, z_axis) 
		WaitForMove (tlsparksemit, x_axis) 
		WaitForMove (tlsparksemit, y_axis) 
		WaitForMove (tlsparksemit, z_axis) 
		WaitForTurn (tlsparksemit, x_axis) 
		WaitForTurn (tlsparksemit, y_axis) 
		WaitForTurn (tlsparksemit, z_axis) 
		WaitForMove (tlharp, x_axis) 
		WaitForMove (tlharp, y_axis) 
		WaitForMove (tlharp, z_axis) 
		WaitForTurn (tlharp, x_axis) 
		WaitForTurn (tlharp, y_axis) 
		WaitForTurn (tlharp, z_axis) 
		WaitForMove (tllegUp, x_axis) 
		WaitForMove (tllegUp, y_axis) 
		WaitForMove (tllegUp, z_axis) 
		WaitForTurn (tllegUp, x_axis) 
		WaitForTurn (tllegUp, y_axis) 
		WaitForTurn (tllegUp, z_axis) 
		WaitForMove (tllegLow, x_axis) 
		WaitForMove (tllegLow, y_axis) 
		WaitForMove (tllegLow, z_axis) 
		WaitForTurn (tllegLow, x_axis) 
		WaitForTurn (tllegLow, y_axis) 
		WaitForTurn (tllegLow, z_axis) 
		WaitForMove (tllegUpR, x_axis) 
		WaitForMove (tllegUpR, y_axis) 
		WaitForMove (tllegUpR, z_axis) 
		WaitForTurn (tllegUpR, x_axis) 
		WaitForTurn (tllegUpR, y_axis) 
		WaitForTurn (tllegUpR, z_axis) 
		WaitForMove (tllegLowR, x_axis) 
		WaitForMove (tllegLowR, y_axis) 
		WaitForMove (tllegLowR, z_axis) 
		WaitForTurn (tllegLowR, x_axis) 
		WaitForTurn (tllegLowR, y_axis) 
		WaitForTurn (tllegLowR, z_axis) 
		
	end
end

local function drumPoseMorphStage(mspeed,tspeed,addUp)
	
	
	Move (tigLil, x_axis, 0, mspeed)
	Move (tigLil, y_axis, addUp, mspeed)
	Move (tigLil, z_axis, 0, mspeed)
	Turn (tigLil, x_axis, math.rad(0), tspeed)
	Turn (tigLil, y_axis, math.rad(20), tspeed)
	Turn (tigLil, z_axis, math.rad(0), tspeed)
	Move (tlHead, x_axis, 0, mspeed)
	Move (tlHead, y_axis, 0, mspeed)
	Move (tlHead, z_axis, 0, mspeed)
	Turn (tlHead, x_axis, math.rad(-10), tspeed)
	Turn (tlHead, y_axis, math.rad(-20), tspeed)
	Turn (tlHead, z_axis, math.rad(0), tspeed)
	Move (tlhairup, x_axis, 0, mspeed)
	Move (tlhairup, y_axis, 0, mspeed)
	Move (tlhairup, z_axis, 0, mspeed)
	Turn (tlhairup, x_axis, math.rad(-69.999992370605), tspeed)
	Turn (tlhairup, y_axis, math.rad(30.000001907349), tspeed)
	Turn (tlhairup, z_axis, math.rad(0), tspeed)
	Move (tlhairdown, x_axis, 0, mspeed)
	Move (tlhairdown, y_axis, 0, mspeed)
	Move (tlhairdown, z_axis, 0, mspeed)
	Turn (tlhairdown, x_axis, math.rad(0), tspeed)
	Turn (tlhairdown, y_axis, math.rad(0), tspeed)
	Turn (tlhairdown, z_axis, math.rad(0), tspeed)
	Move (tlflute, x_axis, 0, mspeed)
	Move (tlflute, y_axis, 0, mspeed)
	Move (tlflute, z_axis, 0, mspeed)
	Turn (tlflute, x_axis, math.rad(0), tspeed)
	Turn (tlflute, y_axis, math.rad(0), tspeed)
	Turn (tlflute, z_axis, math.rad(0), tspeed)
	Move (tlarm, x_axis, 0, mspeed)
	Move (tlarm, y_axis, 0, mspeed)
	Move (tlarm, z_axis, 0, mspeed)
	Turn (tlarm, x_axis, math.rad(1.7075473124351e-006), tspeed)
	Turn (tlarm, y_axis, math.rad(-10), tspeed)
	Turn (tlarm, z_axis, math.rad(-40), tspeed)
	Move (tlsparksemit2, x_axis, 0, mspeed)
	Move (tlsparksemit2, y_axis, 0, mspeed)
	Move (tlsparksemit2, z_axis, 0, mspeed)
	Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
	Move (tldrum, x_axis, 0, mspeed)
	Move (tldrum, y_axis, 0, mspeed)
	Move (tldrum, z_axis, 0, mspeed)
	Turn (tldrum, x_axis, math.rad(0), tspeed)
	Turn (tldrum, y_axis, math.rad(0), tspeed)
	Turn (tldrum, z_axis, math.rad(0), tspeed)
	Move (tlarmr, x_axis, 0, mspeed)
	Move (tlarmr, y_axis, 0, mspeed)
	Move (tlarmr, z_axis, 0, mspeed)
	Turn (tlarmr, x_axis, math.rad(-19.89999961853), tspeed)
	Turn (tlarmr, y_axis, math.rad(0), tspeed)
	Turn (tlarmr, z_axis, math.rad(-54.299999237061), tspeed)
	Move (tlsparksemit, x_axis, 0, mspeed)
	Move (tlsparksemit, y_axis, 0, mspeed)
	Move (tlsparksemit, z_axis, 0, mspeed)
	Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
	Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
	Move (tlharp, x_axis, 0, mspeed)
	Move (tlharp, y_axis, 0, mspeed)
	Move (tlharp, z_axis, 0, mspeed)
	Turn (tlharp, x_axis, math.rad(0), tspeed)
	Turn (tlharp, y_axis, math.rad(0), tspeed)
	Turn (tlharp, z_axis, math.rad(0), tspeed)
	Move (tllegUp, x_axis, 0, mspeed)
	Move (tllegUp, y_axis, 0, mspeed)
	Move (tllegUp, z_axis, 0, mspeed)
	Turn (tllegUp, x_axis, math.rad(-20), tspeed)
	Turn (tllegUp, y_axis, math.rad(-20.000001907349), tspeed)
	Turn (tllegUp, z_axis, math.rad(0), tspeed)
	Move (tllegLow, x_axis, 0, mspeed)
	Move (tllegLow, y_axis, 0, mspeed)
	Move (tllegLow, z_axis, 0, mspeed)
	Turn (tllegLow, x_axis, math.rad(10), tspeed)
	Turn (tllegLow, y_axis, math.rad(0), tspeed)
	Turn (tllegLow, z_axis, math.rad(0), tspeed)
	Move (tllegUpR, x_axis, 0, mspeed)
	Move (tllegUpR, y_axis, 0, mspeed)
	Move (tllegUpR, z_axis, 0, mspeed)
	Turn (tllegUpR, x_axis, math.rad(-10), tspeed)
	Turn (tllegUpR, y_axis, math.rad(-20.000001907349), tspeed)
	Turn (tllegUpR, z_axis, math.rad(0), tspeed)
	Move (tllegLowR, x_axis, 0, mspeed)
	Move (tllegLowR, y_axis, 0, mspeed)
	Move (tllegLowR, z_axis, 0, mspeed)
	Turn (tllegLowR, x_axis, math.rad(30.000001907349), tspeed)
	Turn (tllegLowR, y_axis, math.rad(0), tspeed)
	Turn (tllegLowR, z_axis, math.rad(0), tspeed)
	WaitForTurn (tigLil, x_axis) 
	WaitForTurn (tigLil, y_axis) 
	WaitForTurn (tigLil, z_axis) 
	WaitForMove (tlHead, x_axis) 
	WaitForMove (tlHead, y_axis) 
	WaitForMove (tlHead, z_axis) 
	WaitForTurn (tlHead, x_axis) 
	WaitForTurn (tlHead, y_axis) 
	WaitForTurn (tlHead, z_axis) 
	WaitForMove (tlhairup, x_axis) 
	WaitForMove (tlhairup, y_axis) 
	WaitForMove (tlhairup, z_axis) 
	WaitForTurn (tlhairup, x_axis) 
	WaitForTurn (tlhairup, y_axis) 
	WaitForTurn (tlhairup, z_axis) 
	WaitForMove (tlhairdown, x_axis) 
	WaitForMove (tlhairdown, y_axis) 
	WaitForMove (tlhairdown, z_axis) 
	WaitForTurn (tlhairdown, x_axis) 
	WaitForTurn (tlhairdown, y_axis) 
	WaitForTurn (tlhairdown, z_axis) 
	WaitForMove (tlflute, x_axis) 
	WaitForMove (tlflute, y_axis) 
	WaitForMove (tlflute, z_axis) 
	WaitForTurn (tlflute, x_axis) 
	WaitForTurn (tlflute, y_axis) 
	WaitForTurn (tlflute, z_axis) 
	WaitForMove (tlarm, x_axis) 
	WaitForMove (tlarm, y_axis) 
	WaitForMove (tlarm, z_axis) 
	WaitForTurn (tlarm, x_axis) 
	WaitForTurn (tlarm, y_axis) 
	WaitForTurn (tlarm, z_axis) 
	WaitForMove (tlsparksemit2, x_axis) 
	WaitForMove (tlsparksemit2, y_axis) 
	WaitForMove (tlsparksemit2, z_axis) 
	WaitForTurn (tlsparksemit2, x_axis) 
	WaitForTurn (tlsparksemit2, y_axis) 
	WaitForTurn (tlsparksemit2, z_axis) 
	WaitForMove (tldrum, x_axis) 
	WaitForMove (tldrum, y_axis) 
	WaitForMove (tldrum, z_axis) 
	WaitForTurn (tldrum, x_axis) 
	WaitForTurn (tldrum, y_axis) 
	WaitForTurn (tldrum, z_axis) 
	WaitForMove (tlarmr, x_axis) 
	WaitForMove (tlarmr, y_axis) 
	WaitForMove (tlarmr, z_axis) 
	WaitForTurn (tlarmr, x_axis) 
	WaitForTurn (tlarmr, y_axis) 
	WaitForTurn (tlarmr, z_axis) 
	WaitForMove (tlsparksemit, x_axis) 
	WaitForMove (tlsparksemit, y_axis) 
	WaitForMove (tlsparksemit, z_axis) 
	WaitForTurn (tlsparksemit, x_axis) 
	WaitForTurn (tlsparksemit, y_axis) 
	WaitForTurn (tlsparksemit, z_axis) 
	WaitForMove (tlharp, x_axis) 
	WaitForMove (tlharp, y_axis) 
	WaitForMove (tlharp, z_axis) 
	WaitForTurn (tlharp, x_axis) 
	WaitForTurn (tlharp, y_axis) 
	WaitForTurn (tlharp, z_axis) 
	WaitForMove (tllegUp, x_axis) 
	WaitForMove (tllegUp, y_axis) 
	WaitForMove (tllegUp, z_axis) 
	WaitForTurn (tllegUp, x_axis) 
	WaitForTurn (tllegUp, y_axis) 
	WaitForTurn (tllegUp, z_axis) 
	WaitForMove (tllegLow, x_axis) 
	WaitForMove (tllegLow, y_axis) 
	WaitForMove (tllegLow, z_axis) 
	WaitForTurn (tllegLow, x_axis) 
	WaitForTurn (tllegLow, y_axis) 
	WaitForTurn (tllegLow, z_axis) 
	WaitForMove (tllegUpR, x_axis) 
	WaitForMove (tllegUpR, y_axis) 
	WaitForMove (tllegUpR, z_axis) 
	WaitForTurn (tllegUpR, x_axis) 
	WaitForTurn (tllegUpR, y_axis) 
	WaitForTurn (tllegUpR, z_axis) 
	WaitForMove (tllegLowR, x_axis) 
	WaitForMove (tllegLowR, y_axis) 
	WaitForMove (tllegLowR, z_axis) 
	WaitForTurn (tllegLowR, x_axis) 
	WaitForTurn (tllegLowR, y_axis) 
	WaitForTurn (tllegLowR, z_axis) 
	
end

local function drumPosePoledancin(mspeed,tspeed,addUp)
	addUp=addUp+10
	Move (tigLil, y_axis,addUp, mspeed)
	Move (tigLil, x_axis,-3, mspeed)
	Turn (tigLil, z_axis,math.rad(-90),9)
	Show(tlpole)
	Turn (tlHead, x_axis,math.rad(6),2)
	Turn (tlHead, y_axis,math.rad(2),2)
	Turn (tlHead, z_axis,math.rad(-9),2)
	Turn (tlhairup, y_axis,math.rad(-57),5)
	Turn (tlhairup, z_axis,math.rad(90),9)
	Turn (tlhairup, x_axis,math.rad(17),3)
	
	Turn (tlarm, z_axis,math.rad(-46),5)
	Turn (tlarmr, z_axis,math.rad(76),8)
	
	Turn (tllegUp, x_axis,math.rad(-39),4)
	Turn (tllegLow, x_axis,math.rad(147),14)
	
	Turn (tllegUpR, x_axis,math.rad(-71),7)
	Turn (tllegUpR, y_axis,math.rad(69),7)
	Turn (tllegLowR, x_axis,math.rad(142),15)
	Move (tigLil, y_axis,-3, 0.35)
	Spin(deathpivot,y_axis,math.rad(40),22)
	Spin(tldancedru,y_axis,math.rad(-40),22)
	Move (tigLil, y_axis,-7, 0.25)
	WaitForMove(tigLil, y_axis)
	StopSpin(deathpivot,y_axis)
	StopSpin(tldancedru,y_axis)
	Hide(tlpole)
	
end

local function idle_stance11()
	tspeed=2
	mspeed=3
	--music loud and pure
	rand=math.random(0,2)
	
	if rand==0 then
		--drum&base
		
		--plant drum
		Show(tldrum)
		Turn (tlarm, x_axis, math.rad(-129.99998474121), tspeed)
		Turn (tlarm, y_axis, math.rad(60.000003814697), tspeed)
		Turn (tlarm, z_axis, math.rad(39.099998474121), tspeed)
		Sleep(270)
		Turn (tlarm, x_axis, math.rad(-90), tspeed)
		Turn (tlarm, y_axis, math.rad(60.000003814697), tspeed)
		Turn (tlarm, z_axis, math.rad(39.099998474121), tspeed)
		WaitForTurn (tlarm, x_axis)
		WaitForTurn (tlarm, y_axis)
		WaitForTurn (tlarm, z_axis)
		Turn (tlHead, x_axis, math.rad(39), tspeed)
		Turn (tlHead, y_axis, math.rad(0), tspeed)
		Turn (tlHead, z_axis, math.rad(-29.200000762939), tspeed)
		Turn (tlhairup, x_axis, math.rad(-119.99999237061), tspeed)
		Turn (tlhairup, y_axis, math.rad(10), tspeed)
		Turn (tlhairup, z_axis, math.rad(-30.000001907349), tspeed)
		Turn (tlflute, x_axis, math.rad(0), tspeed)
		Turn (tlflute, y_axis, math.rad(0), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Turn (tlarm, x_axis, math.rad(-90), tspeed)
		Turn (tlarm, y_axis, math.rad(60.000003814697), tspeed)
		Turn (tlarm, z_axis, math.rad(39.099998474121), tspeed)
		Move (tldrum, z_axis, -23, mspeed)
		Move (tlarmr, x_axis, 1.1920928955078e-007, mspeed)
		Turn (tlarmr, z_axis, math.rad(43.000003814697), tspeed)
		WaitForTurn (tlarmr, z_axis)
		WaitForMove (tldrum, z_axis)
		Hide(tldrum)
		Show(tldancedru)
		---------------------------------------------------
		mspeed=1
		growBeatBox=math.random(-3,18)
		Move (tldancedru, y_axis, growBeatBox, mspeed)
		growBeatBox=growBeatBox+3
		addUp=growBeatBox
		Move (tigLil, y_axis, growBeatBox, mspeed)
		WaitForMove (tigLil, y_axis)
		Sleep(360)
		discodancin=math.random(8,18)
		twoAndTwo=10
		two=math.random(-1,0)
		
		twoAndTwo=twoAndTwo+(20*two)
		Spin(tigLil,y_axis,math.rad(20))
		--FIXME
		mspeed=4
		tspeed=2
		
		for i=0, discodancin, 1 do
			--8 drums
			for a=0, 4, 1 do
				even=math.random(0,2)
				
				
				if even==0 then
					tspeed=3
					drumPose2(mspeed, tspeed)
					Sleep(60)
				end
				if even==1 then
					
					tspeed=3.5
					drumPose4(mspeed, tspeed)
					Sleep(60)
				end
				if even==2 then
					drumPose6(mspeed, tspeed,addUp)
					Sleep(60)
				end
				----- unevens
				uneven=math.random(0,3)
				
				if uneven==0 then
					tspeed=4
					drumPose1(mspeed, tspeed)
					Sleep(40)
				end
				if uneven==1 then
					tspeed=5
					
					drumPose3(mspeed, tspeed)
					Sleep(45)
				end
				if uneven==2 then
					drumPose5(mspeed, tspeed)
				end
				if uneven==3 then
					drumPose7(mspeed, tspeed, addUp)
				end
			end
			--4 drum
			local oneInFour=math.random(0,4)
			
			if 	oneInFour==0 then
				
				drumPose8 (mspeed,tspeed)
				Sleep(30)
				drumPoseMorphStage(mspeed,tspeed,addUp)
				Sleep(40)
			end
			if 	oneInFour==1 then
				drumPose(mspeed,tspeed,addUp)
				Sleep(40)
				drumPoseMorphStage(mspeed,tspeed,addUp)
				Sleep(40)
			end
			if 	oneInFour==2 then
				drumPoseNeutral(mspeed,tspeed,addUp)
				drumPoseMorphStage(mspeed,tspeed,addUp)
			end
			if 	oneInFour==3 then
				drumPoseNeutral2(mspeed,tspeed,addUp)
				drumPoseMorphStage(mspeed,tspeed,addUp)
			end
			if 	oneInFour==4 then
				drumPoseNeutral3(mspeed,tspeed,addUp)
				drumPoseMorphStage(mspeed,tspeed,addUp)
			end
			if 	oneInFour==5 then
				drumPosePoledancin(mspeed,tspeed,addUp)
				drumPoseMorphStage(mspeed,tspeed,addUp)
			end
			
			
			
		end
	end
	if rand==1 then
		--fluteloop
		local randOneZero=math.random(0,1)
		if randOneZero==1 then
			durRand=math.random(4,18)
			for it=0, durRand, 1 do
				--querflöten
				tspeed=1
				mspeed=1
				Turn (tigLil, x_axis, math.rad(10), tspeed)
				Turn (tigLil, y_axis, math.rad(0), tspeed)
				Turn (tigLil, z_axis, math.rad(0), tspeed)
				Move (tlHead, x_axis, 0, mspeed)
				Move (tlHead, y_axis, 0, mspeed)
				Move (tlHead, z_axis, 0, mspeed)
				Turn (tlHead, x_axis, math.rad(0), tspeed)
				Turn (tlHead, y_axis, math.rad(0), tspeed)
				Turn (tlHead, z_axis, math.rad(0), tspeed)
				Move (tlhairup, x_axis, 0, mspeed)
				Move (tlhairup, y_axis, 0, mspeed)
				Move (tlhairup, z_axis, 0, mspeed)
				Turn (tlhairup, x_axis, math.rad(-59.600006103516), tspeed)
				Turn (tlhairup, y_axis, math.rad(0), tspeed)
				Turn (tlhairup, z_axis, math.rad(0), tspeed)
				Move (tlhairdown, x_axis, 0, mspeed)
				Move (tlhairdown, y_axis, 0, mspeed)
				Move (tlhairdown, z_axis, 0, mspeed)
				Turn (tlhairdown, x_axis, math.rad(-20), tspeed)
				Turn (tlhairdown, y_axis, math.rad(0), tspeed)
				Turn (tlhairdown, z_axis, math.rad(0), tspeed)
				Move (tlflute, x_axis, -0.099999986588955, mspeed)
				Move (tlflute, y_axis, 0.19999998807907, mspeed)
				Move (tlflute, z_axis, -0.099999964237213, mspeed)
				Turn (tlflute, x_axis, math.rad(5.0000009536743), tspeed)
				Turn (tlflute, y_axis, math.rad(-90), tspeed)
				Turn (tlflute, z_axis, math.rad(-607.00006103516), tspeed)
				Move (tlarm, x_axis, 0.49999988079071, mspeed)
				Move (tlarm, y_axis, 0, mspeed)
				Move (tlarm, z_axis, -0.39999997615814, mspeed)
				Turn (tlarm, x_axis, math.rad(69.999992370605), tspeed)
				Turn (tlarm, y_axis, math.rad(20), tspeed)
				Turn (tlarm, z_axis, math.rad(-11.000000953674), tspeed)
				
				Move (tldrum, x_axis, 0, mspeed)
				Move (tldrum, y_axis, 0, mspeed)
				Move (tldrum, z_axis, 0, mspeed)
				Turn (tldrum, x_axis, math.rad(0), tspeed)
				Turn (tldrum, y_axis, math.rad(0), tspeed)
				Turn (tldrum, z_axis, math.rad(0), tspeed)
				Move (tlarmr, x_axis, 1.0000001192093, mspeed)
				Move (tlarmr, y_axis, 0, mspeed)
				Move (tlarmr, z_axis, -1, mspeed)
				Turn (tlarmr, x_axis, math.rad(-208.99992370605), tspeed)
				Turn (tlarmr, y_axis, math.rad(52.000022888184), tspeed)
				Turn (tlarmr, z_axis, math.rad(202.90002441406), tspeed)
				Move (tlsparksemit, x_axis, 0, mspeed)
				Move (tlsparksemit, y_axis, 0, mspeed)
				Move (tlsparksemit, z_axis, 0, mspeed)
				Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
				Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
				Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
				Move (tlharp, x_axis, 0, mspeed)
				Move (tlharp, y_axis, 0, mspeed)
				Move (tlharp, z_axis, 0, mspeed)
				Turn (tlharp, x_axis, math.rad(0), tspeed)
				Turn (tlharp, y_axis, math.rad(0), tspeed)
				Turn (tlharp, z_axis, math.rad(0), tspeed)
				Move (tllegUp, x_axis, 0, mspeed)
				Move (tllegUp, y_axis, 0, mspeed)
				Move (tllegUp, z_axis, 0, mspeed)
				Turn (tllegUp, x_axis, math.rad(-15.000001907349), tspeed)
				Turn (tllegUp, y_axis, math.rad(0), tspeed)
				Turn (tllegUp, z_axis, math.rad(0), tspeed)
				Move (tllegLow, x_axis, 0, mspeed)
				Move (tllegLow, y_axis, 0, mspeed)
				Move (tllegLow, z_axis, 0, mspeed)
				Turn (tllegLow, x_axis, math.rad(0), tspeed)
				Turn (tllegLow, y_axis, math.rad(0), tspeed)
				Turn (tllegLow, z_axis, math.rad(0), tspeed)
				Move (tllegUpR, x_axis, 0, mspeed)
				Move (tllegUpR, y_axis, 0, mspeed)
				Move (tllegUpR, z_axis, 0, mspeed)
				Turn (tllegUpR, x_axis, math.rad(-11), tspeed)
				Turn (tllegUpR, y_axis, math.rad(0), tspeed)
				Turn (tllegUpR, z_axis, math.rad(0), tspeed)
				Move (tllegLowR, x_axis, 0, mspeed)
				Move (tllegLowR, y_axis, 0, mspeed)
				Move (tllegLowR, z_axis, 0, mspeed)
				Turn (tllegLowR, x_axis, math.rad(0), tspeed)
				Turn (tllegLowR, y_axis, math.rad(0), tspeed)
				Turn (tllegLowR, z_axis, math.rad(0), tspeed)
				
				Show (tlflute)
				Sleep(950)
				
				Turn (tigLil, x_axis, math.rad(0), tspeed)
				Turn (tigLil, y_axis, math.rad(0), tspeed)
				Turn (tigLil, z_axis, math.rad(0), tspeed)
				Move (tlHead, x_axis, 0, mspeed)
				Move (tlHead, y_axis, 0, mspeed)
				Move (tlHead, z_axis, 0, mspeed)
				Turn (tlHead, x_axis, math.rad(1), tspeed)
				Turn (tlHead, y_axis, math.rad(6), tspeed)
				Turn (tlHead, z_axis, math.rad(0), tspeed)
				Move (tlhairup, x_axis, 0, mspeed)
				Move (tlhairup, y_axis, 0, mspeed)
				Move (tlhairup, z_axis, 0, mspeed)
				Turn (tlhairup, x_axis, math.rad(-79.599998474121), tspeed)
				Turn (tlhairup, y_axis, math.rad(0), tspeed)
				Turn (tlhairup, z_axis, math.rad(0), tspeed)
				Move (tlhairdown, x_axis, 0, mspeed)
				Move (tlhairdown, y_axis, 0, mspeed)
				Move (tlhairdown, z_axis, 0, mspeed)
				Turn (tlhairdown, x_axis, math.rad(1.9999989271164), tspeed)
				Turn (tlhairdown, y_axis, math.rad(-1), tspeed)
				Turn (tlhairdown, z_axis, math.rad(0), tspeed)
				Move (tlflute, x_axis, -0.099999986588955, mspeed)
				Move (tlflute, y_axis, 0.19999998807907, mspeed)
				Move (tlflute, z_axis, -0.099999964237213, mspeed)
				Turn (tlflute, x_axis, math.rad(4.0000009536743), tspeed)
				Turn (tlflute, y_axis, math.rad(-80.999984741211), tspeed)
				Turn (tlflute, z_axis, math.rad(-607.00006103516), tspeed)
				Move (tlarm, x_axis, 0.49999988079071, mspeed)
				Move (tlarm, y_axis, 0, mspeed)
				Move (tlarm, z_axis, -0.39999997615814, mspeed)
				Turn (tlarm, x_axis, math.rad(67.999992370605), tspeed)
				Turn (tlarm, y_axis, math.rad(20), tspeed)
				Turn (tlarm, z_axis, math.rad(-16.000001907349), tspeed)
				Move (tlsparksemit2, x_axis, 0, mspeed)
				Move (tlsparksemit2, y_axis, 0, mspeed)
				Move (tlsparksemit2, z_axis, 0, mspeed)
				Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
				Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
				Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
				Move (tldrum, x_axis, 0, mspeed)
				Move (tldrum, y_axis, 0, mspeed)
				Move (tldrum, z_axis, 0, mspeed)
				Turn (tldrum, x_axis, math.rad(0), tspeed)
				Turn (tldrum, y_axis, math.rad(0), tspeed)
				Turn (tldrum, z_axis, math.rad(0), tspeed)
				Move (tlarmr, x_axis, 1.0000001192093, mspeed)
				Move (tlarmr, y_axis, 0, mspeed)
				Move (tlarmr, z_axis, -1, mspeed)
				Turn (tlarmr, x_axis, math.rad(-204.99995422363), tspeed)
				Turn (tlarmr, y_axis, math.rad(52.000022888184), tspeed)
				Turn (tlarmr, z_axis, math.rad(202.90002441406), tspeed)
				Move (tlsparksemit, x_axis, 0, mspeed)
				Move (tlsparksemit, y_axis, 0, mspeed)
				Move (tlsparksemit, z_axis, 0, mspeed)
				Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
				Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
				Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
				Move (tlharp, x_axis, 0, mspeed)
				Move (tlharp, y_axis, 0, mspeed)
				Move (tlharp, z_axis, 0, mspeed)
				Turn (tlharp, x_axis, math.rad(0), tspeed)
				Turn (tlharp, y_axis, math.rad(0), tspeed)
				Turn (tlharp, z_axis, math.rad(0), tspeed)
				Move (tllegUp, x_axis, 0, mspeed)
				Move (tllegUp, y_axis, 0, mspeed)
				Move (tllegUp, z_axis, 0, mspeed)
				Turn (tllegUp, x_axis, math.rad(-5.0000023841858), tspeed)
				Turn (tllegUp, y_axis, math.rad(0), tspeed)
				Turn (tllegUp, z_axis, math.rad(0), tspeed)
				Move (tllegLow, x_axis, 0, mspeed)
				Move (tllegLow, y_axis, 0, mspeed)
				Move (tllegLow, z_axis, 0, mspeed)
				Turn (tllegLow, x_axis, math.rad(0), tspeed)
				Turn (tllegLow, y_axis, math.rad(0), tspeed)
				Turn (tllegLow, z_axis, math.rad(0), tspeed)
				Move (tllegUpR, x_axis, 0, mspeed)
				Move (tllegUpR, y_axis, 0, mspeed)
				Move (tllegUpR, z_axis, 0, mspeed)
				Turn (tllegUpR, x_axis, math.rad(-1.0000003576279), tspeed)
				Turn (tllegUpR, y_axis, math.rad(0), tspeed)
				Turn (tllegUpR, z_axis, math.rad(0), tspeed)
				Move (tllegLowR, x_axis, 0, mspeed)
				Move (tllegLowR, y_axis, 0, mspeed)
				Move (tllegLowR, z_axis, 0, mspeed)
				Turn (tllegLowR, x_axis, math.rad(0), tspeed)
				Turn (tllegLowR, y_axis, math.rad(0), tspeed)
				Turn (tllegLowR, z_axis, math.rad(0), tspeed)
				
				
				
				Sleep(460)
				
			end
			Move(tlarm,x_axis,0,4)
			Move(tlarm,y_axis,0,4)
			Move(tlarm,z_axis,0,4)
			Hide(tlflute)
			
		end
		if randOneZero==0 then		
			--querTröte
			Show(tlflute)
			
			jamin=math.random(5,19)
			for ot=0,jamin, 1 do
				tspeed=2	
				
				
				Turn (tigLil, x_axis, math.rad(0), tspeed)
				Turn (tigLil, y_axis, math.rad(0), tspeed)
				Turn (tigLil, z_axis, math.rad(0), tspeed)
				Move (tlHead, x_axis, 0, mspeed)
				Move (tlHead, y_axis, 0, mspeed)
				Move (tlHead, z_axis, 0, mspeed)
				Turn (tlHead, x_axis, math.rad(0), tspeed)
				Turn (tlHead, y_axis, math.rad(0), tspeed)
				Turn (tlHead, z_axis, math.rad(0), tspeed)
				Move (tlhairup, x_axis, 0, mspeed)
				Move (tlhairup, y_axis, 0, mspeed)
				Move (tlhairup, z_axis, 0, mspeed)
				Turn (tlhairup, x_axis, math.rad(-59.999996185303), 7)
				Turn (tlhairup, y_axis, math.rad(0), tspeed)
				Turn (tlhairup, z_axis, math.rad(0), tspeed)
				Move (tlhairdown, x_axis, 0, mspeed)
				Move (tlhairdown, y_axis, 0, mspeed)
				Move (tlhairdown, z_axis, 0, mspeed)
				Turn (tlhairdown, x_axis, math.rad(0), tspeed)
				Turn (tlhairdown, y_axis, math.rad(0), tspeed)
				Turn (tlhairdown, z_axis, math.rad(0), tspeed)
				Move (tlflute, x_axis, -0.3999999165535, mspeed)
				Move (tlflute, y_axis, 0.099999994039536, mspeed)
				Move (tlflute, z_axis, -5.9604644775391e-008, mspeed)
				Turn (tlflute, x_axis, math.rad(30.000001907349), tspeed)
				Turn (tlflute, y_axis, math.rad(0), tspeed)
				Turn (tlflute, z_axis, math.rad(-199.99998474121), tspeed)
				Move (tlarm, x_axis, 0, mspeed)
				Move (tlarm, y_axis, 0, mspeed)
				Move (tlarm, z_axis, 0, mspeed)
				Turn (tlarm, x_axis, math.rad(-159.99998474121), 15)
				Turn (tlarm, y_axis, math.rad(109.99998474121), 10)
				Turn (tlarm, z_axis, math.rad(0), tspeed)
				Move (tlsparksemit2, x_axis, 0, mspeed)
				Move (tlsparksemit2, y_axis, 0, mspeed)
				Move (tlsparksemit2, z_axis, 0, mspeed)
				Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
				Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
				Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
				Move (tldrum, x_axis, 0, mspeed)
				Move (tldrum, y_axis, 0, mspeed)
				Move (tldrum, z_axis, 0, mspeed)
				Turn (tldrum, x_axis, math.rad(0), tspeed)
				Turn (tldrum, y_axis, math.rad(0), tspeed)
				Turn (tldrum, z_axis, math.rad(0), tspeed)
				Move (tlarmr, x_axis, 0, mspeed)
				Move (tlarmr, y_axis, 0, mspeed)
				Move (tlarmr, z_axis, 0, mspeed)
				Turn (tlarmr, x_axis, math.rad(-167.69998168945), 16)
				Turn (tlarmr, y_axis, math.rad(-99.999984741211), 10)
				Turn (tlarmr, z_axis, math.rad(10.000001907349), tspeed)
				Move (tlsparksemit, x_axis, 0, mspeed)
				Move (tlsparksemit, y_axis, 0, mspeed)
				Move (tlsparksemit, z_axis, 0, mspeed)
				Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
				Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
				Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
				Move (tlharp, x_axis, 0, mspeed)
				Move (tlharp, y_axis, 0, mspeed)
				Move (tlharp, z_axis, 0, mspeed)
				Turn (tlharp, x_axis, math.rad(0), tspeed)
				Turn (tlharp, y_axis, math.rad(0), tspeed)
				Turn (tlharp, z_axis, math.rad(0), tspeed)
				Move (tllegUp, x_axis, 0, mspeed)
				Move (tllegUp, y_axis, 0, mspeed)
				Move (tllegUp, z_axis, 0, mspeed)
				Turn (tllegUp, x_axis, math.rad(0), tspeed)
				Turn (tllegUp, y_axis, math.rad(0), tspeed)
				Turn (tllegUp, z_axis, math.rad(0), tspeed)
				Move (tllegLow, x_axis, 0, mspeed)
				Move (tllegLow, y_axis, 0, mspeed)
				Move (tllegLow, z_axis, 0, mspeed)
				Turn (tllegLow, x_axis, math.rad(0), tspeed)
				Turn (tllegLow, y_axis, math.rad(0), tspeed)
				Turn (tllegLow, z_axis, math.rad(0), tspeed)
				Move (tllegUpR, x_axis, 0, mspeed)
				Move (tllegUpR, y_axis, 0, mspeed)
				Move (tllegUpR, z_axis, 0, mspeed)
				Turn (tllegUpR, x_axis, math.rad(0), tspeed)
				Turn (tllegUpR, y_axis, math.rad(0), tspeed)
				Turn (tllegUpR, z_axis, math.rad(0), tspeed)
				Move (tllegLowR, x_axis, 0, mspeed)
				Move (tllegLowR, y_axis, 0, mspeed)
				Move (tllegLowR, z_axis, 0, mspeed)
				Turn (tllegLowR, x_axis, math.rad(0), tspeed)
				Turn (tllegLowR, y_axis, math.rad(0), tspeed)
				Turn (tllegLowR, z_axis, math.rad(0), tspeed)
				iWantRand=math.random(400,1200)
				
				Sleep(iWantRand)
				ranZig=math.random(0,1)
				if ranzig==1 then
					--down
					Move (deathpivot, x_axis, 0, mspeed)
					
					Move (tigLil, x_axis, 0, mspeed)
					Move (tigLil, y_axis, 0, mspeed)
					Move (tigLil, z_axis, 0, mspeed)
					Turn (tigLil, x_axis, math.rad(20), tspeed)
					Turn (tigLil, y_axis, math.rad(0), tspeed)
					Turn (tigLil, z_axis, math.rad(0), tspeed)
					Move (tlHead, x_axis, 0, mspeed)
					Move (tlHead, y_axis, 0, mspeed)
					Move (tlHead, z_axis, 0, mspeed)
					Turn (tlHead, x_axis, math.rad(20.000001907349), tspeed)
					Turn (tlHead, y_axis, math.rad(0), tspeed)
					Turn (tlHead, z_axis, math.rad(0), tspeed)
					Move (tlhairup, x_axis, 0, mspeed)
					Move (tlhairup, y_axis, 0, mspeed)
					Move (tlhairup, z_axis, 0, mspeed)
					Turn (tlhairup, x_axis, math.rad(-89.999992370605), tspeed)
					Turn (tlhairup, y_axis, math.rad(0), tspeed)
					Turn (tlhairup, z_axis, math.rad(0), tspeed)
					Move (tlhairdown, x_axis, 0, mspeed)
					Move (tlhairdown, y_axis, 0, mspeed)
					Move (tlhairdown, z_axis, 0, mspeed)
					Turn (tlhairdown, x_axis, math.rad(-30.000001907349), tspeed)
					Turn (tlhairdown, y_axis, math.rad(0), tspeed)
					Turn (tlhairdown, z_axis, math.rad(0), tspeed)
					Move (tlflute, x_axis, -0.3999999165535, mspeed)
					Move (tlflute, y_axis, 0.099999994039536, mspeed)
					Move (tlflute, z_axis, -5.9604644775391e-008, mspeed)
					Turn (tlflute, x_axis, math.rad(30.000001907349), tspeed)
					Turn (tlflute, y_axis, math.rad(0), tspeed)
					Turn (tlflute, z_axis, math.rad(-199.99998474121), 20)
					Move (tlarm, x_axis, 0, mspeed)
					Move (tlarm, y_axis, 0, mspeed)
					Move (tlarm, z_axis, 0, mspeed)
					Turn (tlarm, x_axis, math.rad(-159.99998474121), 15)
					Turn (tlarm, y_axis, math.rad(116.99997711182), 11)
					Turn (tlarm, z_axis, math.rad(-9), tspeed)
					
					Move (tldrum, x_axis, 0, mspeed)
					Move (tldrum, y_axis, 0, mspeed)
					Move (tldrum, z_axis, 0, mspeed)
					Turn (tldrum, x_axis, math.rad(0), tspeed)
					Turn (tldrum, y_axis, math.rad(0), tspeed)
					Turn (tldrum, z_axis, math.rad(0), tspeed)
					Move (tlarmr, x_axis, 0, mspeed)
					Move (tlarmr, y_axis, 0, mspeed)
					Move (tlarmr, z_axis, 0, mspeed)
					Turn (tlarmr, x_axis, math.rad(-157.69998168945), 15)
					Turn (tlarmr, y_axis, math.rad(-103.99999237061), 10)
					Turn (tlarmr, z_axis, math.rad(18), tspeed)
					
					Move (tlharp, x_axis, 0, mspeed)
					Move (tlharp, y_axis, 0, mspeed)
					Move (tlharp, z_axis, 0, mspeed)
					Turn (tlharp, x_axis, math.rad(0), tspeed)
					Turn (tlharp, y_axis, math.rad(0), tspeed)
					Turn (tlharp, z_axis, math.rad(0), tspeed)
					Move (tllegUp, x_axis, 0, mspeed)
					Move (tllegUp, y_axis, 0, mspeed)
					Move (tllegUp, z_axis, 0, mspeed)
					Turn (tllegUp, x_axis, math.rad(-10), tspeed)
					Turn (tllegUp, y_axis, math.rad(0), tspeed)
					Turn (tllegUp, z_axis, math.rad(0), tspeed)
					Move (tllegLow, x_axis, 0, mspeed)
					Move (tllegLow, y_axis, 0, mspeed)
					Move (tllegLow, z_axis, 0, mspeed)
					Turn (tllegLow, x_axis, math.rad(0), tspeed)
					Turn (tllegLow, y_axis, math.rad(0), tspeed)
					Turn (tllegLow, z_axis, math.rad(0), tspeed)
					Move (tllegUpR, x_axis, 0, mspeed)
					Move (tllegUpR, y_axis, 0, mspeed)
					Move (tllegUpR, z_axis, 0, mspeed)
					Turn (tllegUpR, x_axis, math.rad(-20), tspeed)
					Turn (tllegUpR, y_axis, math.rad(0), tspeed)
					Turn (tllegUpR, z_axis, math.rad(0), tspeed)
					Move (tllegLowR, x_axis, 0, mspeed)
					Move (tllegLowR, y_axis, 0, mspeed)
					Move (tllegLowR, z_axis, 0, mspeed)
					Turn (tllegLowR, x_axis, math.rad(0), tspeed)
					Turn (tllegLowR, y_axis, math.rad(0), tspeed)
					Turn (tllegLowR, z_axis, math.rad(0), tspeed)
					
				end
				if ranzig==0 then
					--up
					
					
					Turn (tigLil, x_axis, math.rad(10.000001907349), tspeed)
					Turn (tigLil, y_axis, math.rad(0), tspeed)
					Turn (tigLil, z_axis, math.rad(0), tspeed)
					Move (tlHead, x_axis, 0, mspeed)
					Move (tlHead, y_axis, 0, mspeed)
					Move (tlHead, z_axis, 0, mspeed)
					Turn (tlHead, x_axis, math.rad(-49.999996185303), tspeed)
					Turn (tlHead, y_axis, math.rad(0), tspeed)
					Turn (tlHead, z_axis, math.rad(0), tspeed)
					Move (tlhairup, x_axis, 0, mspeed)
					Move (tlhairup, y_axis, 0, mspeed)
					Move (tlhairup, z_axis, 0, mspeed)
					Turn (tlhairup, x_axis, math.rad(9.9999980926514), tspeed)
					Turn (tlhairup, y_axis, math.rad(10), tspeed)
					Turn (tlhairup, z_axis, math.rad(10), tspeed)
					Move (tlhairdown, x_axis, 0, mspeed)
					Move (tlhairdown, y_axis, 0, mspeed)
					Move (tlhairdown, z_axis, 0, mspeed)
					Turn (tlhairdown, x_axis, math.rad(-30.000001907349), tspeed)
					Turn (tlhairdown, y_axis, math.rad(0), tspeed)
					Turn (tlhairdown, z_axis, math.rad(0), tspeed)
					Move (tlflute, x_axis, -0.3999999165535, mspeed)
					Move (tlflute, y_axis, 0.099999994039536, mspeed)
					Move (tlflute, z_axis, -5.9604644775391e-008, mspeed)
					Turn (tlflute, x_axis, math.rad(30.000001907349), tspeed)
					Turn (tlflute, y_axis, math.rad(0), tspeed)
					Turn (tlflute, z_axis, math.rad(-199.99998474121), 20)
					Move (tlarm, x_axis, 0, mspeed)
					Move (tlarm, y_axis, 0, mspeed)
					Move (tlarm, z_axis, 0, mspeed)
					Turn (tlarm, x_axis, math.rad(-159.99998474121), 16)--159
					Turn (tlarm, y_axis, math.rad(86.999984741211), tspeed)
					Turn (tlarm, z_axis, math.rad(41), tspeed)
					Move (tlsparksemit2, x_axis, 0, mspeed)
					Move (tlsparksemit2, y_axis, 0, mspeed)
					Move (tlsparksemit2, z_axis, 0, mspeed)
					Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
					Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
					Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
					Move (tldrum, x_axis, 0, mspeed)
					Move (tldrum, y_axis, 0, mspeed)
					Move (tldrum, z_axis, 0, mspeed)
					Turn (tldrum, x_axis, math.rad(0), tspeed)
					Turn (tldrum, y_axis, math.rad(0), tspeed)
					Turn (tldrum, z_axis, math.rad(0), tspeed)
					Move (tlarmr, x_axis, 0, mspeed)
					Move (tlarmr, y_axis, 0, mspeed)
					Move (tlarmr, z_axis, 0, mspeed)
					Turn (tlarmr, x_axis, math.rad(-167.69998168945), 16)
					Turn (tlarmr, y_axis, math.rad(-93.999992370605), 10)
					Turn (tlarmr, z_axis, math.rad(-41.999996185303), 4)
					Move (tlsparksemit, x_axis, 0, mspeed)
					Move (tlsparksemit, y_axis, 0, mspeed)
					Move (tlsparksemit, z_axis, 0, mspeed)
					Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
					Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
					Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
					Move (tlharp, x_axis, 0, mspeed)
					Move (tlharp, y_axis, 0, mspeed)
					Move (tlharp, z_axis, 0, mspeed)
					Turn (tlharp, x_axis, math.rad(0), tspeed)
					Turn (tlharp, y_axis, math.rad(0), tspeed)
					Turn (tlharp, z_axis, math.rad(0), tspeed)
					Move (tllegUp, x_axis, 0, mspeed)
					Move (tllegUp, y_axis, 0, mspeed)
					Move (tllegUp, z_axis, 0, mspeed)
					Turn (tllegUp, x_axis, math.rad(0), tspeed)
					Turn (tllegUp, y_axis, math.rad(0), tspeed)
					Turn (tllegUp, z_axis, math.rad(0), tspeed)
					Move (tllegLow, x_axis, 0, mspeed)
					Move (tllegLow, y_axis, 0, mspeed)
					Move (tllegLow, z_axis, 0, mspeed)
					Turn (tllegLow, x_axis, math.rad(0), tspeed)
					Turn (tllegLow, y_axis, math.rad(0), tspeed)
					Turn (tllegLow, z_axis, math.rad(0), tspeed)
					Move (tllegUpR, x_axis, 0, mspeed)
					Move (tllegUpR, y_axis, 0, mspeed)
					Move (tllegUpR, z_axis, 0, mspeed)
					Turn (tllegUpR, x_axis, math.rad(-10), tspeed)
					Turn (tllegUpR, y_axis, math.rad(0), tspeed)
					Turn (tllegUpR, z_axis, math.rad(0), tspeed)
					Move (tllegLowR, x_axis, 0, mspeed)
					Move (tllegLowR, y_axis, 0, mspeed)
					Move (tllegLowR, z_axis, 0, mspeed)
					Turn (tllegLowR, x_axis, math.rad(0), tspeed)
					Turn (tllegLowR, y_axis, math.rad(0), tspeed)
					Turn (tllegLowR, z_axis, math.rad(0), tspeed)
					anotherRandomSleepVal=math.random(600,1200)		
					Sleep(anotherRandomSleepVal)			
					
				end
				
			end
			
			Hide(tlflute)
			
		end
		
		
		
	end
	
	if rand==2 then
		--harp a darp
		Show(tlharp)
		mspeed=5
		tspeed=0.5
		
		Move (tigLil, x_axis, 0, mspeed)
		Move (tigLil, y_axis, -7.2999997138977, mspeed)
		Move (tigLil, z_axis, 0, mspeed)
		Turn (tigLil, x_axis, math.rad(3.9999983310699), tspeed)
		Turn (tigLil, y_axis, math.rad(-20.999990463257), tspeed)
		Turn (tigLil, z_axis, math.rad(-4), tspeed)
		Move (tlHead, x_axis, 0, mspeed)
		Move (tlHead, y_axis, 0, mspeed)
		Move (tlHead, z_axis, 0, mspeed)
		Turn (tlHead, x_axis, math.rad(10), tspeed)
		Turn (tlHead, y_axis, math.rad(30.000001907349), tspeed)
		Turn (tlHead, z_axis, math.rad(0), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0, mspeed)
		Move (tlhairup, z_axis, 0, mspeed)
		Turn (tlhairup, x_axis, math.rad(-87.999992370605), tspeed)
		Turn (tlhairup, y_axis, math.rad(0), tspeed)
		Turn (tlhairup, z_axis, math.rad(0), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(0), tspeed)
		Turn (tlhairdown, y_axis, math.rad(0), tspeed)
		Turn (tlhairdown, z_axis, math.rad(0), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(0), tspeed)
		Turn (tlflute, y_axis, math.rad(0), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		
		Turn (tlarm, x_axis, math.rad(174.99989318848), tspeed)
		Turn (tlarm, y_axis, math.rad(110.99998474121), tspeed)
		Turn (tlarm, z_axis, math.rad(20), tspeed)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		Move (tldrum, x_axis, 0, mspeed)
		Move (tldrum, y_axis, 0, mspeed)
		Move (tldrum, z_axis, 0, mspeed)
		Turn (tldrum, x_axis, math.rad(0), tspeed)
		Turn (tldrum, y_axis, math.rad(0), tspeed)
		Turn (tldrum, z_axis, math.rad(0), tspeed)
		Move (tlarmr, x_axis, 0, mspeed)
		Move (tlarmr, y_axis, 0, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(-10.000008583069), tspeed)
		Turn (tlarmr, y_axis, math.rad(-99.999984741211), tspeed)
		Turn (tlarmr, z_axis, math.rad(-10), tspeed)
		
		Move (tlharp, x_axis, 0, mspeed)
		Move (tlharp, y_axis, 0, mspeed)
		Move (tlharp, z_axis, 0, mspeed)
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, 0, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(-49.999996185303), tspeed)
		Turn (tllegUp, y_axis, math.rad(-40), tspeed)
		Turn (tllegUp, z_axis, math.rad(0), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(129.99998474121), 22)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, -5.9604644775391e-008, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(-59.999996185303), tspeed)
		Turn (tllegUpR, y_axis, math.rad(20), tspeed)
		Turn (tllegUpR, z_axis, math.rad(0), tspeed)
		Move (tllegLowR, x_axis, 0, mspeed)
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(139.99998474121), 22)
		Turn (tllegLowR, y_axis, math.rad(0), tspeed)
		Turn (tllegLowR, z_axis, math.rad(0), tspeed)
		WaitForTurn (tigLil, x_axis) 
		WaitForTurn (tigLil, y_axis) 
		WaitForTurn (tigLil, z_axis) 
		WaitForMove (tlHead, x_axis) 
		WaitForMove (tlHead, y_axis) 
		WaitForMove (tlHead, z_axis) 
		WaitForTurn (tlHead, x_axis) 
		WaitForTurn (tlHead, y_axis) 
		WaitForTurn (tlHead, z_axis) 
		WaitForMove (tlhairup, x_axis) 
		WaitForMove (tlhairup, y_axis) 
		WaitForMove (tlhairup, z_axis) 
		WaitForTurn (tlhairup, x_axis) 
		WaitForTurn (tlhairup, y_axis) 
		WaitForTurn (tlhairup, z_axis) 
		WaitForMove (tlhairdown, x_axis) 
		WaitForMove (tlhairdown, y_axis) 
		WaitForMove (tlhairdown, z_axis) 
		WaitForTurn (tlhairdown, x_axis) 
		WaitForTurn (tlhairdown, y_axis) 
		WaitForTurn (tlhairdown, z_axis) 
		WaitForMove (tlflute, x_axis) 
		WaitForMove (tlflute, y_axis) 
		WaitForMove (tlflute, z_axis) 
		WaitForTurn (tlflute, x_axis) 
		WaitForTurn (tlflute, y_axis) 
		WaitForTurn (tlflute, z_axis) 
		WaitForMove (tlarm, x_axis) 
		WaitForMove (tlarm, y_axis) 
		WaitForMove (tlarm, z_axis) 
		WaitForTurn (tlarm, x_axis) 
		WaitForTurn (tlarm, y_axis) 
		WaitForTurn (tlarm, z_axis) 
		WaitForMove (tlsparksemit2, x_axis) 
		WaitForMove (tlsparksemit2, y_axis) 
		WaitForMove (tlsparksemit2, z_axis) 
		WaitForTurn (tlsparksemit2, x_axis) 
		WaitForTurn (tlsparksemit2, y_axis) 
		WaitForTurn (tlsparksemit2, z_axis) 
		WaitForMove (tldrum, x_axis) 
		WaitForMove (tldrum, y_axis) 
		WaitForMove (tldrum, z_axis) 
		WaitForTurn (tldrum, x_axis) 
		WaitForTurn (tldrum, y_axis) 
		WaitForTurn (tldrum, z_axis) 
		WaitForMove (tlarmr, x_axis) 
		WaitForMove (tlarmr, y_axis) 
		WaitForMove (tlarmr, z_axis) 
		WaitForTurn (tlarmr, x_axis) 
		WaitForTurn (tlarmr, y_axis) 
		WaitForTurn (tlarmr, z_axis) 
		WaitForMove (tlsparksemit, x_axis) 
		WaitForMove (tlsparksemit, y_axis) 
		WaitForMove (tlsparksemit, z_axis) 
		WaitForTurn (tlsparksemit, x_axis) 
		WaitForTurn (tlsparksemit, y_axis) 
		WaitForTurn (tlsparksemit, z_axis) 
		WaitForMove (tlharp, x_axis) 
		WaitForMove (tlharp, y_axis) 
		WaitForMove (tlharp, z_axis) 
		WaitForTurn (tlharp, x_axis) 
		WaitForTurn (tlharp, y_axis) 
		WaitForTurn (tlharp, z_axis) 
		WaitForMove (tllegUp, x_axis) 
		WaitForMove (tllegUp, y_axis) 
		WaitForMove (tllegUp, z_axis) 
		WaitForTurn (tllegUp, x_axis) 
		WaitForTurn (tllegUp, y_axis) 
		WaitForTurn (tllegUp, z_axis) 
		WaitForMove (tllegLow, x_axis) 
		WaitForMove (tllegLow, y_axis) 
		WaitForMove (tllegLow, z_axis) 
		WaitForTurn (tllegLow, x_axis) 
		WaitForTurn (tllegLow, y_axis) 
		WaitForTurn (tllegLow, z_axis) 
		WaitForMove (tllegUpR, x_axis) 
		WaitForMove (tllegUpR, y_axis) 
		WaitForMove (tllegUpR, z_axis) 
		WaitForTurn (tllegUpR, x_axis) 
		WaitForTurn (tllegUpR, y_axis) 
		WaitForTurn (tllegUpR, z_axis) 
		WaitForMove (tllegLowR, x_axis) 
		WaitForMove (tllegLowR, y_axis) 
		WaitForMove (tllegLowR, z_axis) 
		WaitForTurn (tllegLowR, x_axis) 
		WaitForTurn (tllegLowR, y_axis) 
		WaitForTurn (tllegLowR, z_axis) 
		hitIt=math.floor(math.random(12,38))
		lastSwingBy=20
		flipFlop1=-1
		for play=1, hitIt, 1 do
			flipFlop1=flipFlop1*-1
			
			tspeed=(play*hitIt)%3
			
			swingBy =math.floor(math.random(-40,40))
			
			if swingBy > -10 and swingBy < 10 then
				swingBy=swingBy*2
			end
			if swingBy < -12 or swingBy > 12 then
				tspeed=3
			end
			
			swingBy=swingBy*flipFlop1
			
			
			Turn (tlarm, x_axis, math.rad(174.29985046387), 17)
			Turn (tlarm, y_axis, math.rad(100.69999694824), 10)
			Turn (tlarm, z_axis, math.rad(swingBy), tspeed)						
			WaitForTurn (tlarm, z_axis)	
			WaitForTurn (tlarm, x_axis)	
			WaitForTurn (tlarm, y_axis)	
			
			sleepingBeau=math.random(500,960)
			Sleep(sleepingBeau)
			
		end
	end
	Hide(tlharp)
end

--eggspawn --tigLil and SkinFantry

experienceSoFar=1
teamID=Spring.GetUnitTeam(unitID)
function spawnAEgg(x,z)
	randSleep=math.ceil(math.random(370,1200))
	Sleep(randSleep)
	Spring.CreateUnit("jtigeggnogg",x,-10,z, 0, teamID) 
	
end

function EGG_LOOP()
	x,y,z=Spring.GetUnitPosition(unitID)
	local spGetGroundHeight=Spring.GetGroundHeight
	while(true) do
		x,_,z=Spring.GetUnitPosition(unitID)
		--check if standing in Water
		y=spGetGroundHeight(x,z)
		if y <= 0 then	
			-- if in Water check experience
			temp=Spring.GetUnitExperience(unitID)
			if temp > experienceSoFar+1 then --levelup

				--spawn numberofEggsToSpawn
				for i=1,math.ceil(experienceSoFar),1 do
					StartThread(spawnAEgg,x,z)
				end
				experienceSoFar=temp
				--update experienceSoFar
			end
		end
		Sleep(1500)
		
	end
end



function script.Create()
	StartThread(EGG_LOOP)
	Hide(tlpole)
	Hide(tlsparksemit)
	Hide(tlsparksemit2)
	Hide(deathpivot)
	Hide(tldrum)
	Hide(tlharp)
	Hide(tlflute)
	Hide(tldancedru)
	StartThread(ReloadCountDown)
end

function script.Killed(recentDamage,maxHealth)
	randKill=math.random(0,1)
	Spring.PlaySoundFile("sounds/tiglil/tgdeath.wav") 
	if randKill==1 then
		tspeed=22
		mspeed=19
		boolKill=true
		legs_down()
		--FlybackStage
		--z_axis is inverted
		--y_axis is inverted
		Signal(SIG_HAIRWIND)
		Signal(SIG_WALK)
		Signal(SIG_WHIR)
		Signal(SIG_SWING)
		Signal(SIG_IDLE)
		Signal(SIG_GESTE)
		Signal(SIG_TALKHEAD)
		Signal(SIG_ONTHEMOVE)
		Signal(SIG_INCIRCLE)
		
		Explode(tldrum,SFX.FALL)
		Hide(tldrum)
		
		Move (deathpivot, x_axis, 0, mspeed)
		Move (deathpivot, y_axis, 0, mspeed)
		Move (deathpivot, z_axis, 0, mspeed)
		Turn (deathpivot, x_axis, math.rad(-88.899993896484), tspeed)
		Turn (deathpivot, y_axis, math.rad(0), tspeed)
		Turn (deathpivot, z_axis, math.rad(-0.30000001192093), tspeed)
		Move (dancepivot, x_axis, 0, mspeed)
		Move (dancepivot, y_axis, 0, mspeed)
		Move (dancepivot, z_axis, 0, mspeed)
		Turn (dancepivot, x_axis, math.rad(0), tspeed)
		Turn (dancepivot, y_axis, math.rad(0), tspeed)
		Turn (dancepivot, z_axis, math.rad(0), tspeed)
		Move (tigLil, x_axis, 0.10000038146973, mspeed)
		Move (tigLil, y_axis, 0, mspeed)
		Move (tigLil, z_axis, 0.90000009536743, mspeed)
		Turn (tigLil, x_axis, math.rad(0), tspeed)
		Turn (tigLil, y_axis, math.rad(0), tspeed)
		Turn (tigLil, z_axis, math.rad(0.30000001192093), tspeed)
		Move (tlHead, x_axis, 0, mspeed)
		Move (tlHead, y_axis, 10, mspeed)
		Move (tlHead, z_axis, -1, mspeed)
		Turn (tlHead, x_axis, math.rad(42.999946594238), tspeed)
		Turn (tlHead, y_axis, math.rad(-80.999984741211), tspeed)
		Turn (tlHead, z_axis, math.rad(0), tspeed)
		Move (tlhairup, x_axis, 0, mspeed)
		Move (tlhairup, y_axis, 0, mspeed)
		Move (tlhairup, z_axis, 0, mspeed)
		Turn (tlhairup, x_axis, math.rad(-20), tspeed)
		Turn (tlhairup, y_axis, math.rad(-10), tspeed)
		Turn (tlhairup, z_axis, math.rad(-69.999992370605), tspeed)
		Move (tlhairdown, x_axis, 0, mspeed)
		Move (tlhairdown, y_axis, 0, mspeed)
		Move (tlhairdown, z_axis, 0, mspeed)
		Turn (tlhairdown, x_axis, math.rad(0), tspeed)
		Turn (tlhairdown, y_axis, math.rad(0), tspeed)
		Turn (tlhairdown, z_axis, math.rad(0), tspeed)
		Move (tlflute, x_axis, 0, mspeed)
		Move (tlflute, y_axis, 0, mspeed)
		Move (tlflute, z_axis, 0, mspeed)
		Turn (tlflute, x_axis, math.rad(0), tspeed)
		Turn (tlflute, y_axis, math.rad(0), tspeed)
		Turn (tlflute, z_axis, math.rad(0), tspeed)
		Move (tlarm, x_axis, 0, mspeed)
		Move (tlarm, y_axis, 0, mspeed)
		Move (tlarm, z_axis, 0, mspeed)
		Turn (tlarm, x_axis, math.rad(10), tspeed)
		Turn (tlarm, y_axis, math.rad(0), tspeed)
		Turn (tlarm, z_axis, math.rad(-49.999996185303), tspeed)
		Move (tlsparksemit2, x_axis, 0, mspeed)
		Move (tlsparksemit2, y_axis, 0, mspeed)
		Move (tlsparksemit2, z_axis, 0, mspeed)
		Turn (tlsparksemit2, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit2, z_axis, math.rad(0), tspeed)
		Move (tldrum, x_axis, 0, mspeed)
		Move (tldrum, y_axis, 0, mspeed)
		Move (tldrum, z_axis, 0, mspeed)
		Turn (tldrum, x_axis, math.rad(0), tspeed)
		Turn (tldrum, y_axis, math.rad(0), tspeed)
		Turn (tldrum, z_axis, math.rad(0), tspeed)
		Move (tlarmr, x_axis, 2, mspeed)
		Move (tlarmr, y_axis, 2, mspeed)
		Move (tlarmr, z_axis, 0, mspeed)
		Turn (tlarmr, x_axis, math.rad(0), tspeed)
		Turn (tlarmr, y_axis, math.rad(0), tspeed)
		Turn (tlarmr, z_axis, math.rad(-18.999982833862), tspeed)
		Move (tlsparksemit, x_axis, 0, mspeed)
		Move (tlsparksemit, y_axis, 0, mspeed)
		Move (tlsparksemit, z_axis, 0, mspeed)
		Turn (tlsparksemit, x_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, y_axis, math.rad(0), tspeed)
		Turn (tlsparksemit, z_axis, math.rad(0), tspeed)
		Move (tlharp, x_axis, 0, mspeed)
		Move (tlharp, y_axis, 0, mspeed)
		Move (tlharp, z_axis, 0, mspeed)
		Turn (tlharp, x_axis, math.rad(0), tspeed)
		Turn (tlharp, y_axis, math.rad(0), tspeed)
		Turn (tlharp, z_axis, math.rad(0), tspeed)
		Move (tllegUp, x_axis, 0, mspeed)
		Move (tllegUp, y_axis, 0, mspeed)
		Move (tllegUp, z_axis, 0, mspeed)
		Turn (tllegUp, x_axis, math.rad(0), tspeed)
		Turn (tllegUp, y_axis, math.rad(0), tspeed)
		Turn (tllegUp, z_axis, math.rad(-45), tspeed)
		Move (tllegLow, x_axis, 0, mspeed)
		Move (tllegLow, y_axis, 0, mspeed)
		Move (tllegLow, z_axis, 0, mspeed)
		Turn (tllegLow, x_axis, math.rad(-45), tspeed)
		Turn (tllegLow, y_axis, math.rad(0), tspeed)
		Turn (tllegLow, z_axis, math.rad(0), tspeed)
		Move (tllegUpR, x_axis, 0, mspeed)
		Move (tllegUpR, y_axis, 0, mspeed)
		Move (tllegUpR, z_axis, 0, mspeed)
		Turn (tllegUpR, x_axis, math.rad(0), tspeed)
		Turn (tllegUpR, y_axis, math.rad(0), tspeed)
		Turn (tllegUpR, z_axis, math.rad(0), tspeed)
		Move (tllegLowR, x_axis, 0, mspeed)
		Move (tllegLowR, y_axis, 0, mspeed)
		Move (tllegLowR, z_axis, 0, mspeed)
		Turn (tllegLowR, x_axis, math.rad(405.39999389648), tspeed)
		Turn (tllegLowR, y_axis, math.rad(-225.00001525879), tspeed)
		Turn (tllegLowR, z_axis, math.rad(-135.50001525879), tspeed)
		
		
	end
	
	if randKill==0 then
		boolKill=true
		legs_down()
		--FlybackStage
		--z_axis is inverted
		--y_axis is inverted
		Signal(SIG_HAIRWIND)
		Signal(SIG_WALK)
		Signal(SIG_WHIR)
		Signal(SIG_SWING)
		Signal(SIG_IDLE)
		Signal(SIG_GESTE)
		Signal(SIG_TALKHEAD)
		Signal(SIG_ONTHEMOVE)
		Signal(SIG_INCIRCLE)
		
		Explode(tldrum,SFX.FALL)
		Hide(tldrum)
		
		Turn(tigLil,x_axis,math.rad(12),2)
		Turn(tlHead,x_axis,math.rad(36),4)
		Turn(tlhairup,x_axis,math.rad(76),5)
		Turn(tlhairdown,x_axis,math.rad(20),3)
		
		Turn(tlarm,y_axis,math.rad(-32),3)
		Turn(tlarmr,y_axis,math.rad(28),3)
		
		Turn(tllegUp,z_axis,math.rad(-14),2)
		Turn(tllegUp,x_axis,math.rad(-21),3)
		Turn(tllegLow,x_axis,math.rad(-23),3)
		
		Turn(tllegUpR,z_axis,math.rad(13),2)
		Turn(tllegUpR,x_axis,math.rad(-23),3)
		Turn(tllegLowR,x_axis,math.rad(-21),3)
		
		WaitForTurn(tigLil,x_axis) 
		
		
		Turn(deathpivot,x_axis,math.rad(-76),6)
		WaitForTurn(deathpivot,x_axis) 
		
		Turn(tlHead,x_axis,math.rad(-30),5)
		Turn(tlhairup,x_axis,math.rad(-23),3)
		Turn(tlhairdown,x_axis,math.rad(-31),4)
		Turn(tlarm,y_axis,math.rad(32),4)
		
		Turn(tlarmr,y_axis,math.rad( -32),4)
		Turn(tlarmr,x_axis,math.rad(-15),2)
		
		Turn(tllegUp,x_axis,math.rad(-55),6)
		Turn(tllegUp,z_axis,math.rad(-14),2)
		Turn(tllegLow,x_axis,math.rad(37),5)
		
		Turn(tllegUpR,x_axis,math.rad(-62),7)
		Turn(tllegUpR,z_axis,math.rad(13),2)
		Turn(tllegLowR,x_axis,math.rad(31),4)
		
		
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairdown,x_axis)
		WaitForTurn(tlarm,y_axis) 
		
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		
		WaitForTurn(tllegUpR,x_axis)
		WaitForTurn(tllegUpR,z_axis)
		WaitForTurn(tllegLowR,x_axis)
		
		Signal(SIG_WALK)
		
		
		Turn(deathpivot,x_axis,math.rad(-79),8)
		Turn(tigLil,x_axis,math.rad(-29),4)
		Turn(tlHead,x_axis,math.rad(46),5)
		Turn(tlhairup,x_axis,math.rad(-129),13)
		
		Turn(tlhairup,y_axis,math.rad(31),4)
		
		
		Turn(tlarm,x_axis,math.rad(0),4)
		Turn(tlarm,y_axis,math.rad(-25),5)
		Turn(tlarm,z_axis,math.rad(47),5)
		
		
		Turn(tlarmr,x_axis,math.rad(0),6)
		Turn(tlarmr,y_axis,math.rad(38),5)
		Turn(tlarmr,z_axis,math.rad(-56),5)
		
		--y-axis
		Turn(tllegUp,x_axis,math.rad(15),3)
		Turn(tllegUp,z_axis,math.rad(-14),3)
		Turn(tllegUp,y_axis,math.rad(0),6)
		
		Turn(tllegLow,x_axis,math.rad(8),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		Turn(tllegLow,y_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(16),3)
		Turn(tllegUpR,z_axis,math.rad(13),3)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		
		Turn(tllegLowR,x_axis,math.rad(31),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		
		
		--[[WaitForTurn(deathpivot,x_axis)
		WaitForTurn(tigLil,x_axis) 
		WaitForTurn(tlHead,x_axis) 
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairup,y_axis) 
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,z_axis) 
		WaitForTurn(tlarmr,x_axis) 
		WaitForTurn(tlarmr,y_axis) 
		WaitForTurn(tlarmr,z_axis) 
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegUp,y_axis) 
		
		WaitForTurn(tllegLow,x_axis)
		WaitForTurn(tllegLow,z_axis) 
		WaitForTurn(tllegLow,y_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		
		WaitForTurn(tllegLowR,x_axis) 
		WaitForTurn(tllegLowR,z_axis) 
		WaitForTurn(tllegLowR,y_axis) ]]--
		Sleep(250)
		Signal(SIG_WALK)
		
		Turn(tigLil,x_axis,math.rad(-33),1)
		Turn(tigLil,y_axis,math.rad(-91),3)
		--i
		Turn(tigLil,z_axis,math.rad(20),1)
		
		
		Turn(tlHead,x_axis,math.rad(83),4)
		Turn(tlhairup,x_axis,math.rad(266),26)
		Turn(tlhairup,y_axis,math.rad( -82),3)
		Turn(tlhairdown,x_axis,math.rad(8),2)
		Turn(tlhairdown,y_axis,math.rad(0),2)
		Turn(tlhairdown,z_axis,math.rad(0),2)
		
		Turn(tlarm,y_axis,math.rad(79),4)
		
		Turn(tlarm,x_axis,math.rad(79),5)
		Turn(tlarm,z_axis,math.rad(-6),3)
		
		--i
		Turn(tlarmr,y_axis,math.rad(-102),3)
		Turn(tlarmr,x_axis,math.rad(-97),3)
		Turn(tlarmr,z_axis,math.rad(-12),3)
		
		Turn(tllegUp,x_axis,math.rad(-137),3)
		--i
		Turn(tllegUp,z_axis,math.rad(5),1)
		Turn(tllegLow,x_axis,math.rad(155),5)
		--i
		Turn(tllegLow,z_axis,math.rad(15),2)
		
		Turn(tllegUpR,x_axis,math.rad(-135),4)
		--i
		Turn(tllegUpR,y_axis,math.rad(10),2)
		--i
		Turn(tllegUpR,z_axis,math.rad(-13),2)
		Turn(tllegLowR,x_axis,math.rad(135),5)
		Turn(tllegLowR,y_axis,math.rad(0),5)
		Turn(tllegLowR,z_axis,math.rad(0),5)
		
		WaitForTurn(tigLil,x_axis) 
		WaitForTurn(tigLil,y_axis) 
		WaitForTurn(tigLil,z_axis) 
		
		WaitForTurn(deathpivot,y_axis) 
		WaitForTurn(deathpivot,z_axis) 
		WaitForTurn(tlHead,x_axis) 
		
		WaitForTurn(tlhairup,x_axis) 
		WaitForTurn(tlhairup,y_axis) 
		WaitForTurn(tlhairdown,x_axis)
		WaitForTurn(tlhairdown,y_axis)
		WaitForTurn(tlhairdown,z_axis)
		
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tlarm,y_axis) 
		WaitForTurn(tlarm,x_axis) 
		WaitForTurn(tlarm,z_axis) 
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis) 
		WaitForTurn(tllegLowR,y_axis) 
		WaitForTurn(tllegLowR,z_axis) 
		Turn(tllegUpR,x_axis,math.rad(-125),0.5)
		Turn(tllegUp,x_axis,math.rad(-122),0.5)
		Turn(tigLil,y_axis,math.rad(-93),1)
		Sleep(850)
		Turn(tigLil,y_axis,math.rad(-86),1)
		Turn(tllegUpR,x_axis,math.rad(-135),0.5)
		Sleep(850)
		Turn(tllegUpR,x_axis,math.rad(-125),0.5)
		Turn(tllegUp,x_axis,math.rad(-122),0.5)
		Turn(tigLil,y_axis,math.rad(-93),1)
		Sleep(850)
		Turn(tllegUpR,x_axis,math.rad(-135),0.5)
		Turn(tigLil,y_axis,math.rad(-88),1)
		Sleep(850)
		Turn(tllegUpR,x_axis,math.rad(-115),0.5)
		Turn(tigLil,y_axis,math.rad(-93),1)
		Sleep(850)
		Turn(tllegUpR,x_axis,math.rad(-125),0.5)
		Turn(tigLil,y_axis,math.rad(-90),1)
		Turn(tllegUp,x_axis,math.rad(-122),0.5)
		Sleep(850)
		Turn(tigLil,y_axis,math.rad(-93),1)
		Turn(tllegUpR,x_axis,math.rad(-135),0.5)
		WaitForTurn(tigLil,y_axis)
		Turn(tigLil,y_axis,math.rad(-91),1)
		Sleep(4096)
		
		Signal(SIG_WALK)
		
	end
	return 1 		
end



---WALKING -
function walk()
	Hide(tldrum)
	Hide(tlflute)
	Hide(tlharp)
	Hide(tldancedru)
	
	
	
	legs_down()
	Signal(SIG_ONTHEMOVE)
	Signal(SIG_SWING)	
	Signal(SIG_ONTHEMOVE)
	Signal(SIG_INCIRCLE)
	if (Sleeper==1 or Sleeper==8) then
		
		
		StartThread (armswing)
	end
	
	SetSignalMask(SIG_WALK)
	while(true) do
		
		-- Rightback
		
		Turn(tllegUpR,x_axis,math.rad(21),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(12),4)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		
		Turn(tllegUp,x_axis,math.rad(-22),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tigLil,y_axis,math.rad(-2),1)
		Turn(tigLil,z_axis,math.rad(3),1)
		WaitForTurn(tigLil,y_axis)
		Sleep(75)
		boolMove=true		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		Turn(tllegUp,x_axis,math.rad(21),2)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),3)
		--Turn(tllegLow,x_axis,math.rad(12),2)
		Turn(tllegLow,x_axis,math.rad(12),4)
		Turn(tllegLow,y_axis,math.rad(0),3)
		Turn(tllegLow,z_axis,math.rad(0),3)
		
		Turn(tllegUpR,x_axis,math.rad(-22),2)
		Turn(tllegUpR,y_axis,math.rad(0),3)
		Turn(tllegUpR,z_axis,math.rad(0),3)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),3)
		Turn(tllegLowR,z_axis,math.rad(0),3)
		Turn(tigLil,y_axis,math.rad(3),1)
		Turn(tigLil,z_axis,math.rad(-4),1)
		WaitForTurn(tigLil,y_axis)
		
		
		
		WaitForTurn(tigLil,z_axis)
		
		WaitForTurn(tllegUp,x_axis) 
		WaitForTurn(tllegUp,y_axis) 
		WaitForTurn(tllegUp,z_axis) 
		WaitForTurn(tllegLow,x_axis) 
		WaitForTurn(tllegLow,y_axis) 
		WaitForTurn(tllegLow,z_axis) 
		Sleep(65)
		WaitForTurn(tllegUpR,x_axis) 
		WaitForTurn(tllegUpR,y_axis) 
		WaitForTurn(tllegUpR,z_axis) 
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		
		
		
	end
end


-- Idling
function idle()
	Signal(SIG_HAIRWIND)
	Signal(SIG_WALK)
	Signal(SIG_WHIR)
	Signal(SIG_SWING)
	Signal(SIG_IDLE)
	Signal(SIG_ONTHEMOVE)
	Signal(SIG_INCIRCLE)
	Signal(SIG_GESTE)
	Signal(SIG_TALKHEAD)
	local lidle_stance = idle_stance
	
	local lidle_stance2=idle_stance2
	
	local lidle_stance3=idle_stance3
	
	
	local lidle_stance4=idle_stance4
	
	local lidle_stance5=idle_stance5
	
	local lidle_stance6=idle_stance6
	
	local lidle_stance7= idle_stance7
	
	
	local lidle_stance8= 	idle_stance8
	
	local lidle_stance9= idle_stance9
	
	local lidle_stance_10= 	idle_stance_10
	
	local lidle_stance11= idle_stance11
	
	SetSignalMask(SIG_IDLE)
	while(boolCloaked==false) do
		Signal(SIG_GESTE)
		Signal(SIG_TALKHEAD)
		Turn(tigLil,y_axis,math.rad(0),4)
		Turn(tigLil,z_axis,math.rad(0),4)	
		Turn(tlHead,x_axis,math.rad(0),4)
		Turn(tlHead,y_axis,math.rad(0),4)
		Turn(tlHead,z_axis,math.rad(0),4)
		Turn(tlhairup,x_axis,math.rad(-74),2)
		Turn(tlhairup,y_axis,math.rad(0),2)
		Turn(tlhairup,z_axis,math.rad(0),2)
		Turn(tlhairdown,x_axis,math.rad(-19),3)
		Turn(tllegUp,x_axis,math.rad(0),3)
		Turn(tllegUp,y_axis,math.rad(0),3)
		Turn(tllegUp,z_axis,math.rad(0),2)
		Turn(tllegLow,x_axis,math.rad(0),2)
		Turn(tllegLow,y_axis,math.rad(0),2)
		Turn(tllegLow,z_axis,math.rad(0),2)
		Turn(tllegUpR,x_axis,math.rad(0),3)
		Turn(tllegUpR,y_axis,math.rad(0),2)
		Turn(tllegUpR,z_axis,math.rad(0),4)
		Turn(tllegLowR,x_axis,math.rad(0),2)
		Turn(tllegLowR,y_axis,math.rad(0),2)
		Turn(tllegLowR,z_axis,math.rad(0),2)
		Turn(tlarmr,y_axis,math.rad(0),3)
		
		Turn(tlarmr,z_axis,math.rad(0),3)
		
		
		Turn(tlarmr,x_axis,math.rad(0),3)
		
		
		Turn(tlarm,y_axis,math.rad(0),4)
		
		Turn(tlarm,z_axis,math.rad(0),3)
		Turn(tlarm,x_axis,math.rad(0),3)
		
		WaitForTurn(tigLil,y_axis)
		WaitForTurn(tigLil,z_axis)
		WaitForTurn(tlHead,x_axis)
		WaitForTurn(tlHead,y_axis)
		WaitForTurn(tlHead,z_axis)
		WaitForTurn(tlhairup,x_axis)
		WaitForTurn(tlhairup,y_axis)
		WaitForTurn(tlhairup,z_axis)
		WaitForTurn(tlhairdown,x_axis)
		WaitForTurn(tllegUp,x_axis)
		WaitForTurn(tllegUp,y_axis)
		WaitForTurn(tllegUp,z_axis)
		WaitForTurn(tllegLow,x_axis)
		WaitForTurn(tllegLow,y_axis)
		WaitForTurn(tllegLow,z_axis)
		WaitForTurn(tllegUpR,x_axis)
		WaitForTurn(tllegUpR,y_axis)
		WaitForTurn(tllegUpR,z_axis)
		WaitForTurn(tllegLowR,x_axis)
		WaitForTurn(tllegLowR,y_axis)
		WaitForTurn(tllegLowR,z_axis)
		WaitForTurn(tlarmr,y_axis)
		
		WaitForTurn(tlarmr,z_axis)
		
		
		WaitForTurn(tlarmr,x_axis)
		
		
		WaitForTurn(tlarm,y_axis)
		
		WaitForTurn(tlarm,z_axis)
		
		WaitForTurn(tlarm,x_axis)
		
		legs_down()
		
		--changebookmark
		Sleep(285)
		Sleeper=math.random(0,10)
		
		tempsleep=math.random(512,4096)
		if (Sleeper==0) then
			Sleep(tempsleep)
			lidle_stance()
		end
		if (Sleeper==1) then
			Sleep(tempsleep)
			lidle_stance2()
		end
		if (Sleeper==2) then
			Sleep(tempsleep)
			lidle_stance3()
		end
		if (Sleeper==3) then
			Sleep(tempsleep)
			lidle_stance4()
		end
		if (Sleeper==4) then
			Sleep(tempsleep)
			lidle_stance5()
		end
		if (Sleeper==5) then
			Sleep(tempsleep)
			lidle_stance6()
		end
		if (Sleeper==6) then
			Sleep(tempsleep)
			lidle_stance7()
		end
		if (Sleeper==7) then
			Sleep(tempsleep)
			lidle_stance8()
		end
		if (Sleeper==8) then
			Sleep(tempsleep)
			lidle_stance9()
		end
		if (Sleeper==9) then
			Sleep(tempsleep)
			lidle_stance_10()
		end
		if (Sleeper==10) then
			Sleep(tempsleep)
			lidle_stance11()
		end
		
		
		
	end
end


local boolMove=false


function script.StartMoving()
	Signal(SIG_GESTE)
	Signal(SIG_TALKHEAD)
	Signal(SIG_WALK)
	StartThread (walk) 
	
	Signal(SIG_IDLE)
	--Signal(SIG_WHIR)
	
	Signal(SIG_HAIRWIND)
	StartThread(hair_inwind)
end

function script.StopMoving()
	boolMove=false
	
	--Signal(SIG_HAIRWIND)
	-- Signal(SIG_SWING) 	
	--Signal(SIG_WALK)
	--Signal(SIG_IDLE)
	
	
	
	if (boolKill==false) then
		
		StartThread (idle)
	end
end

---AIMING & SHOOTING -
function script.AimFromWeapon1() 
	
	return aimpivot 
end

function script.QueryWeapon1() 
	return aimpivot
end


function WeaponAmbushMode()
	if boolAmbushInProgress==true then return true end
	if RELOADTIME == 0 then 
		return true 
	else 
		return false
	end
end


--must return true to allow the weapon to shot. return false denies the weapon from shooting
-- can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon1(heading,pitch)
	--make sure the aiming animation is only run once

	Signal(SIG_AIM)
	Signal(SIG_ONTHEMOVE)
	Signal(SIG_INCIRCLE)
	Signal(SIG_IDLE)
	Signal(SIG_GESTE)
	Signal(SIG_TALKHEAD)
	SetSignalMask(SIG_AIM)
	Heading=heading
	--wait until the weapon is pointed in the right direction
	boolCanFire= WeaponAmbushMode()
	if boolCanFire==true then
	
		everyHundredTigLils=math.random(0,25)
		if everyHundredTigLils == 9 then
			Spring.PlaySoundFile("sounds/tiglil/tgAttac.wav")
		elseif everyHundredTigLils == 18 then
			Spring.PlaySoundFile("sounds/tiglil/tgAttac2.wav")
		end
	end
	
	return boolCanFire
end

function ReloadCountDown()
	if boolAmbushInProgress == true then RELOADTIME= 0; return end
	
	RELOADTIME=COOLDOWNTIMER
	Sleep(RELOADTIME)
	RELOADTIME=0
end

-- called after the weapon has fired
function script.FireWeapon1()
	Signal(SIG_WHIR)
	if boolAmbushInProgress==false then
	
		StartThread(ReloadCountDown)
	end
	
	StartThread (bladewhirl_thread)
	sound=math.random(0,1)
	if sound== 0 then
		Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav") 
		
	else 
		Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav") 
	end
	
end


boolAmbushCharged=false
boolAmbushInProgress=false
boolFiringWeapon=false

function AmbushinProgressThread()
	Spring.Echo("AmbushActivated")
	boolAmbushInProgress=true
	Sleep(AMBUSHTIME)
	boolAmbushInProgress=false
	Spring.Echo("AmbushEnded")
end

function waitPosition()
	Signal(SIG_IDLE)
	
	Move(tigLil,z_axis,-21,7)
	Turn(tllegUpR,x_axis,math.rad(21),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(12),4)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	
	Turn(tllegUp,x_axis,math.rad(-22),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tigLil,y_axis,math.rad(-2),1)
	Turn(tigLil,z_axis,math.rad(3),1)
	WaitForTurn(tigLil,y_axis)
	Sleep(75)
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	
	
	Turn(tllegUp,x_axis,math.rad(21),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	--Turn(tllegLow,x_axis,math.rad(12),2)
	Turn(tllegLow,x_axis,math.rad(12),4)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tllegUpR,x_axis,math.rad(-22),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(0),2)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	Turn(tigLil,y_axis,math.rad(3),1)
	Turn(tigLil,z_axis,math.rad(-4),1)
	WaitForTurn(tigLil,y_axis)
	
	
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	Sleep(65)
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	Turn(tllegUpR,x_axis,math.rad(21),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(12),4)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	
	Turn(tllegUp,x_axis,math.rad(-22),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tigLil,y_axis,math.rad(-2),1)
	Turn(tigLil,z_axis,math.rad(3),1)
	WaitForTurn(tigLil,y_axis)
	Sleep(75)
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	
	
	Turn(tllegUp,x_axis,math.rad(21),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	--Turn(tllegLow,x_axis,math.rad(12),2)
	Turn(tllegLow,x_axis,math.rad(12),4)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tllegUpR,x_axis,math.rad(-22),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(0),2)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	Turn(tigLil,y_axis,math.rad(3),1)
	Turn(tigLil,z_axis,math.rad(-4),1)
	WaitForTurn(tigLil,y_axis)
	
	
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	Sleep(65)
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	Turn(tllegUpR,x_axis,math.rad(21),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(12),4)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	
	Turn(tllegUp,x_axis,math.rad(-22),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tigLil,y_axis,math.rad(-2),1)
	Turn(tigLil,z_axis,math.rad(3),1)
	WaitForTurn(tigLil,y_axis)
	Sleep(75)
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	
	
	Turn(tllegUp,x_axis,math.rad(21),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	--Turn(tllegLow,x_axis,math.rad(12),2)
	Turn(tllegLow,x_axis,math.rad(12),4)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tllegUpR,x_axis,math.rad(-22),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(0),2)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	Turn(tigLil,y_axis,math.rad(3),1)
	Turn(tigLil,z_axis,math.rad(-4),1)
	WaitForTurn(tigLil,y_axis)
	
	
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	Sleep(65)
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	WaitForMove(tigLil,z_axis)
	Move(tigLil,z_axis,-12,5)
	Turn(tllegUpR,x_axis,math.rad(21),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(12),4)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	
	Turn(tllegUp,x_axis,math.rad(-22),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	Turn(tllegLow,x_axis,math.rad(0),2)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tigLil,y_axis,math.rad(-2),1)
	Turn(tigLil,z_axis,math.rad(3),1)
	WaitForTurn(tigLil,y_axis)
	Sleep(75)
	
	WaitForTurn(tigLil,z_axis)
	
	WaitForTurn(tllegUp,x_axis) 
	WaitForTurn(tllegUp,y_axis) 
	WaitForTurn(tllegUp,z_axis) 
	WaitForTurn(tllegLow,x_axis) 
	WaitForTurn(tllegLow,y_axis) 
	WaitForTurn(tllegLow,z_axis) 
	
	WaitForTurn(tllegUpR,x_axis) 
	WaitForTurn(tllegUpR,y_axis) 
	WaitForTurn(tllegUpR,z_axis) 
	WaitForTurn(tllegLowR,x_axis)
	WaitForTurn(tllegLowR,y_axis)
	WaitForTurn(tllegLowR,z_axis)
	
	
	Turn(tllegUp,x_axis,math.rad(21),2)
	Turn(tllegUp,y_axis,math.rad(0),3)
	Turn(tllegUp,z_axis,math.rad(0),3)
	--Turn(tllegLow,x_axis,math.rad(12),2)
	Turn(tllegLow,x_axis,math.rad(12),4)
	Turn(tllegLow,y_axis,math.rad(0),3)
	Turn(tllegLow,z_axis,math.rad(0),3)
	
	Turn(tllegUpR,x_axis,math.rad(-22),2)
	Turn(tllegUpR,y_axis,math.rad(0),3)
	Turn(tllegUpR,z_axis,math.rad(0),3)
	Turn(tllegLowR,x_axis,math.rad(0),2)
	Turn(tllegLowR,y_axis,math.rad(0),3)
	Turn(tllegLowR,z_axis,math.rad(0),3)
	Turn(tigLil,y_axis,math.rad(3),1)
	Turn(tigLil,z_axis,math.rad(-4),1)
	WaitForTurn(tigLil,y_axis)
	
	
	
	
end

function AmbushCounterThread()
	Spring.Echo("AmbushPreparing")
	SetSignalMask(SIG_AMBUSH)
	Sleep(AMBUSHLOADTIME)
	boolAmbushCharged=true
	Spring.Echo("AmbushReady")
end

boolCloaked=false
function cloakCheckAndAmbushLoad()
	local boolPrevCloaked=false
	
	
	while true do
		--check wether the Unit is cloaked 
		boolCloaked=GetUnitValue(COB.CLOAKED)
		--if first time true, set unit FireStats to ReturnFire, set to Hold Position, start AmbushCounter --setFirstTime False
		if boolPrevCloaked==false and boolCloaked==true then
			Spring.Echo("Cloaking")
			Signal(SIG_AMBUSH)
			SIGNAL(SIG_IDLE)
			if boolPeacefull==true then
				StartThread(AmbushCounterThread)
				GiveOrderToUnit(unitID, CMD.FIRE_STATE, {0}, {})
				GiveOrderToUnit(unitID, CMD.MOVE_STATE, {0}, {}) 
				boolPrevCloaked=true 
				WaitPosition()
			else
				SetUnitValue(COB.CLOAKED, 1)
				SetUnitValue(COB.WANT_CLOAK, 0)
			end
		end
		
		
		--if cloaked and boolMove is true, uncloak, reset Fire Status --resetFirstTime
		if boolCloaked==true and (boolFiringWeapon==true or boolMoving==true) then
			Spring.Echo("Cloaking abandoned- Ambushing if charged")
			SetUnitValue(COB.WANT_CLOAK, 0)
			SetUnitValue(COB.CLOAKED, 0)
			boolPrevCloaked=false
			GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, {}) 
			GiveOrderToUnit(unitID, CMD.MOVE_STATE, {1}, {})
			Signal(SIG_AMBUSH)
			if boolAmbushCharged==true then
				StartThread(AmbushinProgressThread)
				boolAmbushCharged=false
			end
			--fire Ambushmodethread
		end
		
		Sleep(250)
	end
end

function script.Activate()
	if boolPeacefull==true then
		SetUnitValue(COB.WANT_CLOAK,1)
	end
	return 1
end

function script.Deactivate()
	SetUnitValue(COB.WANT_CLOAK,0)
	return 0
end

boolPeacefull=true
function restorePeace()
	SetSignalMask(SIG_PEACE)
	Sleep(5000)
	boolPeacefull=true
end
function script.HitByWeapon ( x, z, weaponDefID, damage )
	boolPeacefull=false
	Signal(SIG_PEACE)
	StartThread(restorePeace)
end