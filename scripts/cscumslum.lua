include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 


scumslum = piece "scumslum"
scumslum2 = piece "scumslum2"
scumslum3 = piece "scumslum3"
local explodeemit0 = piece "explodeemit0"
local explodeemit1 = piece "explodeemit1"
local explodeemit2 = piece "explodeemit2"
local explodeemit3 = piece "explodeemit3"
local explodeemit4 = piece "explodeemit4"
local explodeemit5 = piece "explodeemit5"
local gangstaturner1 = piece "gangstaturner1"
local gangstaturner2 = piece "gangstaturner2"
local gangstaturner3 = piece "gangstaturner3"
teamID=Spring.GetUnitTeam(unitID)
slumTable={
		[1]=scumslum,
		[2]=scumslum2,
		[3]=scumslum3
			}


local scgangsta = piece "scgangsta"
local scgangsta2 = piece "scgangsta2"
local scgangsta3 = piece "scgangsta3"
gangstArray={}
table.insert(gangstArray,scgangsta)

table.insert(gangstArray,scgangsta2)

table.insert(gangstArray,scgangsta3)


local damageAccumulated=0
ratio=4
echoTable(UnitDefNames["scumslum"],false,"UnitDefNames[scumslum]")

mratio=1/((UnitDefNames["scumslum"].buildcostmetal /ratio )/(UnitDefNames["gcivillian"].buildcostmetal /2))
eratio=1/((UnitDefNames["scumslum"].buildcostenergy /ratio )/(UnitDefNames["gcivillian"].buildcostenergy /2))


hp,maxhp=Spring.GetUnitHealth(unitID)
ratioDamage=math.abs(maxhp*((mratio+eratio)/2))
--gcivilian
--buildCostMetal = 250,
--buildCostEnergy = 750,

function script.HitByWeapon ( x, z, weaponDefID, damage )
damageAccumulated=damageAccumulated+damage
	if damageAccumulated > ratioDamage then
	laID=Spring.GetUnitLastAttacker(unitID)
	valID=Spring.GetUnitIsDead(laID)
	px,pz=0,0
		if valID and valID==true then
			px,_,pz=Spring.GetUnitPosition(laID)
		else
			px,_,pz=Spring.GetUnitPosition(unitID)
			px,pz=px+ (x*-35),pz+(z*-35)	
		end
	id=Spring.CreateUnit("gcivilian",px,0,pz,0,teamID)
		if id then
			Spring.SetUnitNoSelect(id,true)
		end
	end

return damage
end

function buildSlum()
hideT(slumTable)
	if math.random(0,1)==1 then 
	Show(scumslum)
	else
	boolAtLeastOne=false
	
	for i=1,#slumTable do
		if maRa()==true then 
		Show(slumTable[i]) 
		boolAtLeastOne =true
			if i > 1 and maRa() ==true then Turn(slumTable[i],y_axis,math.rad(math.ceil(math.random(1,8))*90),0)  end
		end
	end
		if boolAtLeastOne==false then Show(scumslum)  end
	end
end


function showGangsta()
Hide(scgangsta)
Hide(scgangsta2)
Hide(scgangsta3)
rand=math.random(1,3)
for i=1,rand, 1 do
Show(gangstArray[i])
end

end

function moveGangta3()
currentheading3=math.random(52,277)
cripWalkSpeed3=math.random(2,6)
distance3=math.random(-93,0)


	if  currentheading3 < 130 then
	distance3=distance3%25
	end	
	Turn(scgangsta3,y_axis,math.rad(0),12)
	WaitForTurn(scgangsta3,y_axis)
	
	Turn(gangstaturner3,y_axis,math.rad(currentheading3),6)

	WaitForTurn(gangstaturner3,y_axis)
	Move(scgangsta3,z_axis,distance3,cripWalkSpeed3)
	
	
	
	
	
	
	
	WaitForMove(scgangsta3,z_axis)
end
function moveGangta2()
currentheading2=math.random(-89,208)
cripWalkSpeed2=math.random(2,6)
distance2=math.random(-93,0)
Turn(scgangsta2,y_axis,math.rad(0),4)
WaitForTurn(scgangsta2,y_axis)
	if  currentheading2 < 130 then
	currentheading2=currentheading2%30
	end
	Turn(gangstaturner2,y_axis,math.rad(currentheading2),6)
	WaitForTurn(gangstaturner2,y_axis)
	Move(scgangsta2,x_axis,distance2,cripWalkSpeed2)
	WaitForMove(scgangsta2,x_axis)
	
end

function moveGangta1()
currentheading1=math.random(85,330)
cripWalkSpeed=math.random(2,6)
distance=math.random(-200,0)
Turn(scgangsta,y_axis,math.rad(180),4)
WaitForTurn(scgangsta,y_axis)

	if  currentheading1 > 102 then
	currentheading1=currentheading1%30
	end
	Turn(gangstaturner1,y_axis,math.rad(currentheading1),6)
	WaitForTurn(gangstaturner1,y_axis)
	Move(scgangsta,x_axis,distance,cripWalkSpeed)
	WaitForMove(scgangsta,x_axis)
    Sleep(50)
end

function breakdance()
Turn(scgangsta3,z_axis,math.rad(90),12)
Turn(scgangsta3,x_axis,math.rad(270),12)
WaitForTurn(scgangsta3,z_axis)
rundmc=math.random(-1,1)
if rundmc==0 then
rundmc=1
end
Spin(scgangsta3,y_axis,12,1.2)

Sleep(6000)
Turn(scgangsta3,x_axis,math.rad(0),22)
Turn(scgangsta3,z_axis,math.rad(180),12)
StopSpin(scgangsta3,y_axis)
Spin(scgangsta3,x_axis,(15*rundmc),1.2)
Sleep(6000)
StopSpin(scgangsta3,x_axis)
Turn(scgangsta3,x_axis,math.rad(0),22)
Turn(scgangsta3,y_axis,math.rad(0),22)
Turn(scgangsta3,z_axis,math.rad(0),22)
Sleep(2000)


end

function gangstaIdling()
local currentheading1=0
local moveOnTheTurf1=0
local currentheading2=0
local moveOnTheTurf2=0
local currentheading3=0
local moveOnTheTurf3=0
while(true) do
--return phase
Turn(scgangsta,y_axis,math.rad(0),3)
Turn(scgangsta2,y_axis,math.rad(180),3)
Turn(scgangsta3,y_axis,math.rad(180),3)
Turn(scgangsta,z_axis,math.rad(0),3)
Turn(scgangsta2,z_axis,math.rad(0),3)
Turn(scgangsta3,z_axis,math.rad(0),3)
Turn(scgangsta,x_axis,math.rad(0),3)
Turn(scgangsta2,x_axis,math.rad(0),3)
Turn(scgangsta3,x_axis,math.rad(0),3)
WaitForTurn(scgangsta,y_axis)
WaitForTurn(scgangsta2,y_axis)
WaitForTurn(scgangsta3,y_axis)
WaitForTurn(scgangsta,z_axis)
WaitForTurn(scgangsta2,z_axis)
WaitForTurn(scgangsta3,z_axis)
WaitForTurn(scgangsta,x_axis)
WaitForTurn(scgangsta2,x_axis)
WaitForTurn(scgangsta3,x_axis)

Move(scgangsta,x_axis,0,1)
Move(scgangsta2,x_axis,0,1)
Move(scgangsta3,x_axis,0,1)
Move(scgangsta,z_axis,0,1)
Move(scgangsta2,z_axis,0,1)
Move(scgangsta3,z_axis,0,1)
WaitForMove(scgangsta,x_axis)
WaitForMove(scgangsta2,x_axis)
WaitForMove(scgangsta3,x_axis)
WaitForMove(scgangsta,z_axis)
WaitForMove(scgangsta2,z_axis)
WaitForMove(scgangsta3,z_axis)
Turn(gangstaturner1,y_axis,math.rad(0),1)
WaitForTurn(gangstaturner1,y_axis)
Turn(gangstaturner2,y_axis,math.rad(0),1)
WaitForTurn(gangstaturner2,y_axis)
Turn(gangstaturner3,y_axis,math.rad(0),1)
WaitForTurn(gangstaturner3,y_axis)

--talkphase

--numberRounds=math.random(0,27)
numberRounds=1
for a=0,numberRounds,1 do
turfTalk=math.random(-12,13)
turfSpeed=math.random(0.7,4.2)
Turn(scgangsta,y_axis,math.rad(turfTalk),turfSpeed)
turfTalk=math.random(-12,13)
turfSpeed=math.random(0.7,4.2)
Turn(scgangsta2,y_axis,math.rad(turfTalk),turfSpeed)
turfTalk=math.random(-12,13)
turfSpeed=math.random(0.7,4.2)
Turn(scgangsta3,y_axis,math.rad(turfTalk),turfSpeed)
WaitForTurn(scgangsta3,y_axis)
WaitForTurn(scgangsta2,y_axis)
WaitForTurn(scgangsta,y_axis)
RandoVal=math.floor(math.random(0,600))
Sleep(RandoVal)

end
Turn(scgangsta,y_axis,math.rad(0),3)
Turn(scgangsta2,y_axis,math.rad(0),3)
Turn(scgangsta3,y_axis,math.rad(0),3)
currentheading1=0
currentheading2=0
currentheading3=0
Sleep(350)
xOr=math.random(0,4)
--one, two , or all three got to move
			if xOr == 0 then
			moveGangta1()

			--one moves
			end
			if xOr == 1 then
			--two moves
			moveGangta2()
			moveGangta1()

			end
			if xOr == 2 then
			--three move
			moveGangta1()
			moveGangta2()
			moveGangta3()
			end
			if xOr == 3 or xOr == 4 then
			currentheading1=0
			currentheading2=0
			currentheading3=0
			breakdance()
			end




end
end

function script.Create()
buildSlum()
--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)


if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
	GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)

--</buildanimationscript>

showGangsta()
StartThread(gangstaIdling)
end

function script.Killed(recentDamage, maxHealth)

sleepRand=math.random(200,1250)
Sleep(sleepRand)
Explode(explodeemit0,SFX.FIRE)
sleepRand=math.random(200,1250)
Sleep(sleepRand)
Explode(explodeemit1,SFX.FIRE)
sleepRand=math.random(200,1250)
Sleep(sleepRand)
Explode(explodeemit2,SFX.FIRE)
sleepRand=math.random(200,1250)
Sleep(sleepRand)
Explode(explodeemit3,SFX.FIRE)
sleepRand=math.random(200,1250)
Sleep(sleepRand)
Explode(explodeemit4,SFX.FIRE)
sleepRand=math.random(200,1250)
Sleep(sleepRand)
Explode(explodeemit5,SFX.FIRE)
local xturn= math.random(0,8)
local zturn= math.random(0,8)
local yturn= math.random(0,3)
Sleep(1200)
local unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
Sleep(50)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
Turn(scumslum,y_axis,math.rad(yturn),0.25)    
Turn(scumslum,x_axis,math.rad(xturn),0.25)    
Turn(scumslum,z_axis,math.rad(zturn),0.25)    
Move(scumslum,y_axis,-10.7,12)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
WaitForMove(scumslum,y_axis)
Move(scumslum,y_axis,-24.7,18)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
WaitForMove(scumslum,y_axis)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
Move(scumslum,y_axis,-59.7,42)
WaitForMove(scumslum,y_axis)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
Move(scumslum,y_axis,-109.7,42)
WaitForMove(scumslum,y_axis)
Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
	
suddenDeath(unitID,recentDamage)
Sleep(10)
return 0
end




