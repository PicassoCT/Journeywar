
 include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_anim.lua"

 include "lib_Build.lua" 


local spiralCenter= piece"spiralCenter"
local fireSpiral1= piece"fireSpiral1"
local fireSpiral2= piece"fireSpiral2"
local shockwaveemit=piece"shockwaveemit"
local shockwavecenter=piece"shockwavecenter"
local fireFx1=piece"fireFx1"
local fireFx2=piece"fireFx2"
local fireFx3=piece"fireFx3"
local ffmain01=piece"ffmain01"
local ffrotator=piece"ffrotator"
local centerFireFx = piece "centerFireFx"
local center=piece"center"
local groupcenter=piece"groupcenter"
local fireCenter=piece"fireCenter"
local fireEmitor=piece"fireEmitor"
pseudoRandom={3,4,4,3,3,1,2,4,2,2,4,2,3,1,1,4,2,4,2,1,1,4,1,3,1,2,1,1,4,3,3,1,3,2,3,4,1,2,2,4,1,1,3,2,4,4,4,2,2,1,2,2,2,2,1,4,4,1,3,4,1,1,4,2,2,2,3,3,2,4,1,2,4,3,3,4,4,1,2,3,4,1,2,3,4,2}
-----
piecesTable={}
internalAffairs={}
internalAffairs[1]=2
internalAffairs[2]=3
internalAffairs[3]=2
internalAffairs[4]=2
internalAffairs[5]=4
internalAffairs[6]=1
internalAffairs[7]=1
internalAffairs[8]=7
internalAffairs[9]=2
internalAffairs[10]=1
internalAffairs[11]=1
internalAffairs[12]=1
petal={}
for i=1,24,1 do
petal[i]={}
temp = "petal0"..i
petal[i]=piece (temp)
piecesTable[#piecesTable+1]=petal[i]
end

Bubbles={}
Oil={}

for i=1,11,1 do
Bubbles[i]={}
	Oil[i]={}
	for a=1,internalAffairs[i],1 do
	Bubbles[i][a]={}
	temp = "bub"..i..a
	Bubbles[i][a]=piece (temp)
	piecesTable[#piecesTable+1]=Bubbles[i][a]
	Oil[i][a]={}
	temp = "oil"..i..a
	Oil[i][a]=piece (temp)
	piecesTable[#piecesTable+1]=Oil[i][a]
	end

end

-----
Hold={}
for i=1,13,1 do
Hold[i]={}
temp = "hold0"..i
Hold[i]=piece (temp)
	piecesTable[#piecesTable+1]=Hold[i]
end

-----


WindP={}
for i=1,9,1 do
WindP[i]={}
temp = "windp0"..i
WindP[i]=piece (temp)
	piecesTable[#piecesTable+1]=WindP[i]
end

Spring.TODO()
-----
Leaves={}

for i=1,20,1 do
Leaves[i]={}
temp = "Leaves0"..i
Leaves[i]=piece (temp)
	piecesTable[#piecesTable+1]=Leaves[i]
end

-----
Roots={}

for i=1,10,1 do
Roots[i]={}
temp = "Root0"..i
Roots[i]=piece (temp)
piecesTable[#piecesTable+1]=Roots[i]
end
----
Seed={}

for i=1,17,1 do
Seed[i]={}
temp = "Seed0"..i
Seed[i]=piece (temp)
piecesTable[#piecesTable+1]=Seed[i]
end
----
Astrotatoren={}

for i=1,6,1 do
Astrotatoren[i]={}
temp = "sRo0"..i
Astrotatoren[i]=piece (temp)
piecesTable[#piecesTable+1]=Astrotatoren[i]
end

--
Blueten={}
for i=1,6,1 do
Blueten[i]={}
temp = "windp0"..i
Blueten[i]=piece (temp)
piecesTable[#piecesTable+1]=Blueten[i]
end
--

flowerRange=180
local oneShot=true

function flySeed(nr)
Move(Seed[nr],y_axis,0,0)
Move(Seed[nr],x_axis,0,0)
Move(Seed[nr],z_axis,0,0)
Show(Seed[nr])
Move(Seed[nr],y_axis,0,0)
randHeight=math.random(200,500)
Spin(Seed[nr],y_axis,math.rad(94),0.6)
randSpeed=math.random(11,22)
Move(Seed[nr],y_axis,randHeight,randSpeed)

--Get Winddir
wx,_,wz=Spring.GetWind()
norm=normTwo(wx,wz)
wx,wz=wx/norm,wz/norm
randoVal=math.random(0,220)
Move(Seed[nr],x_axis,wx,(randSpeed/10))
randoVal=math.random(0,220)
Move(Seed[nr],z_axis,wz,(randSpeed/10))
WaitForMove(Seed[nr],y_axis)


Hide(Seed[nr])
end

local lEmitSfx=EmitSfx
function emitOneOfFour(piecename)
dice=math.random(0,3)
if dice==0 then
lEmitSfx(piecename,1029)
elseif dice==1 then
lEmitSfx(piecename,1030)
elseif dice== 2 then
lEmitSfx(piecename,1031)
elseif dice== 3 then
lEmitSfx(piecename,1032)
end

end

function slowFlameMover()
	while(true) do
	randSpeed=math.random(0.1,0.2)
	Move(fireFx1,x_axis,50,randSpeed)
	Sleep(1000)
	randSpeed=math.random(0.1,0.2)
	Move(fireFx2,x_axis,50,randSpeed)
	Sleep(1000)
	randSpeed=math.random(0.1,0.2)
	Move(fireFx2,x_axis,50,randSpeed)
	WaitForMove(fireFx2,x_axis)
	randSpeed=math.random(0.1,0.2)
	Move(fireFx1,x_axis,0,randSpeed)
	Sleep(1000)
	randSpeed=math.random(0.1,0.2)
	Move(fireFx2,x_axis,0,randSpeed)
	Sleep(1000)
	randSpeed=math.random(0.1,0.2)
	Move(fireFx2,x_axis,0,randSpeed)
	WaitForMove(fireFx2,x_axis)
	
	
	end
end

function unfoldFlowers()
Sleep(3500)
Turn(petal[1],x_axis,math.rad(75),5)--NT
Turn(petal[1],y_axis,math.rad(0),5)
Turn(petal[1],z_axis,math.rad(0),5)

Turn(petal[2],x_axis,math.rad(131),5)
Turn(petal[2],y_axis,math.rad(220),5)--139 360 -x
Turn(petal[2],z_axis,math.rad(-103),5)


Turn(petal[3],x_axis,math.rad(0),5)--NT
Turn(petal[3],y_axis,math.rad(0),5)
Turn(petal[3],z_axis,math.rad(75),5)

Turn(petal[4],x_axis,math.rad(-46),5)
Turn(petal[4],y_axis,math.rad(340),5)--36
Turn(petal[4],z_axis,math.rad(80),5)


Turn(petal[5],x_axis,math.rad(-75),5)--NT
Turn(petal[5],y_axis,math.rad(0),5)
Turn(petal[5],z_axis,math.rad(0),5)

Turn(petal[6],x_axis,math.rad(223),5)
Turn(petal[6],y_axis,math.rad(208),5)
Turn(petal[6],z_axis,math.rad(103),5)


Turn(petal[7],x_axis,math.rad(0),5)--NT
Turn(petal[7],y_axis,math.rad(0),5)
Turn(petal[7],z_axis,math.rad(-75),5)

Turn(petal[8],x_axis,math.rad(35),5)
Turn(petal[8],y_axis,math.rad(-37),5)
Turn(petal[8],z_axis,math.rad(-54),5)


-----------------------------------------------------
Turn(petal[9],x_axis,math.rad(75),5)--NT
Turn(petal[9],y_axis,math.rad(0),5)
Turn(petal[9],z_axis,math.rad(0),5)

Turn(petal[2+8],x_axis,math.rad(131),5)
Turn(petal[2+8],y_axis,math.rad(220),5)--139 360 -x
Turn(petal[2+8],z_axis,math.rad(-103),5)

Turn(petal[11],x_axis,math.rad(0),5)--NT
Turn(petal[11],y_axis,math.rad(0),5)
Turn(petal[11],z_axis,math.rad(75),5)

Turn(petal[4+8],x_axis,math.rad(-46),5)
Turn(petal[4+8],y_axis,math.rad(340),5)--36
Turn(petal[4+8],z_axis,math.rad(80),5)


Turn(petal[13],x_axis,math.rad(-75),5)--NT
Turn(petal[13],y_axis,math.rad(0),5)
Turn(petal[13],z_axis,math.rad(0),5)

Turn(petal[14],x_axis,math.rad(223),5)
Turn(petal[14],y_axis,math.rad(208),5)
Turn(petal[14],z_axis,math.rad(103),5)

Turn(petal[15],x_axis,math.rad(0),5)--NT
Turn(petal[15],y_axis,math.rad(0),5)
Turn(petal[15],z_axis,math.rad(-75),5)

Turn(petal[16],x_axis,math.rad(35),5)
Turn(petal[16],y_axis,math.rad(-37),5)
Turn(petal[16],z_axis,math.rad(-54),5)


-----------------------------------------------------
Turn(petal[9+8],x_axis,math.rad(75),5)--NT
Turn(petal[9+8],y_axis,math.rad(0),5)
Turn(petal[9+8],z_axis,math.rad(0),5)

Turn(petal[10+8],x_axis,math.rad(131),5)
Turn(petal[10+8],y_axis,math.rad(220),5)
Turn(petal[10+8],z_axis,math.rad(-103),5)

Turn(petal[11+8],x_axis,math.rad(0),5)--NT
Turn(petal[11+8],y_axis,math.rad(0),5)
Turn(petal[11+8],z_axis,math.rad(75),5)

Turn(petal[12+8],x_axis,math.rad(-46),5)
Turn(petal[12+8],y_axis,math.rad(340),5)
Turn(petal[12+8],z_axis,math.rad(80),5)

Turn(petal[13+8],x_axis,math.rad(-75),5)--NT
Turn(petal[13+8],y_axis,math.rad(0),5)
Turn(petal[13+8],z_axis,math.rad(0),5)

Turn(petal[14+8],x_axis,math.rad(223),5)
Turn(petal[14+8],y_axis,math.rad(208),5)
Turn(petal[14+8],z_axis,math.rad(103),5)

Turn(petal[15+8],x_axis,math.rad(0),5)--NT
Turn(petal[15+8],y_axis,math.rad(0),5)
Turn(petal[15+8],z_axis,math.rad(-75),5)

Turn(petal[16+8],x_axis,math.rad(35),5)
Turn(petal[16+8],y_axis,math.rad(-37),5)
Turn(petal[16+8],z_axis,math.rad(-54),5)

end

function cyclesOfFire()
--StartThread(slowFlameMover)
Hide(fireFx1)
Hide(fireFx2)
Hide(fireFx3)
	while(true) do
	Spin(spiralCenter,y_axis,math.rad(42),0.3)
	emitOneOfFour(fireFx1)
	emitOneOfFour(fireFx2)
	emitOneOfFour(fireFx3)	
	
	Sleep(60)
	
	end
end


function centerFire()
local splEmitSfx=EmitSfx
while(true) do
splEmitSfx(centerFireFx,1033)
Sleep(50)

end
end


function flyP(nr)
Show(WindP[nr])
randMove=math.random(-62,62)
Move(WindP[nr],y_axis,0,0)
Move((WindP[nr]),z_axis,randMove,0)
randMove=math.random(-62,62)
Move((WindP[nr]),x_axis,randMove,0)
randHeight=math.random(200,500)
spinSpeed=math.random(0.3,1.2)
spinWpeed=math.random(62,110)
Spin(WindP[nr],y_axis,math.rad(spinWpeed),spinSpeed)
Spin(WindP[nr],x_axis,math.rad(spinWpeed/10),spinSpeed)
randspeed=math.random(9.141,17.8172)
Move(WindP[nr],y_axis,randHeight,randspeed)
WaitForMove(WindP[nr],y_axis)
Hide(WindP[nr])
end

function dirtSuckedInwards()
local splEmitSfx=EmitSfx
	while(true) do
	randAdditive=math.random(0,120)
		for i=1,6,1 do
		randDegree=math.random(-15,15)
		finalDegree=(randDegree+(i*60))+120
		randElements=math.random(3,11)
			for o=1,randElements,1 do
			Turn(shockwavecenter,y_axis,math.rad(finalDegree+(3*o)),0,true)

			splEmitSfx(shockwaveemit,1028)
			end
		randSleep=math.random(100,250)
		Sleep(randSleep)
		end
	grandSleep=math.random(600,900)
	Sleep(grandSleep)
	end	
end

function timeDelayedUnfold(i,time)
if i%2==0 then
	Turn(Leaves[i],x_axis,math.rad(90),0)
	Sleep(time)
	Turn(Leaves[i],x_axis,math.rad(-75),2)
	WaitForTurn(Leaves[i],x_axis)
	
	else
	Turn(Leaves[i],x_axis,math.rad(-90),0)
	Sleep(time)
	Turn(Leaves[i],x_axis,math.rad(75),2)
	WaitForTurn(Leaves[i],x_axis)
	end

end

function randBuild()
	--Aeste
	for i=1,table.getn(Roots),1 do
	randoVal=math.random(0,360)
	randoVal=randoVal*i
	Turn(Roots[i],y_axis,math.rad(randoVal),0)
	end

	for i=1,table.getn(Astrotatoren),1 do
	randoVal=math.random(0,360)
	randoVal=randoVal*i
	Turn(Astrotatoren[i],y_axis,math.rad(randoVal),0)
	end
	--/Aeste
	for i=1,table.getn(Leaves),1 do
	StartThread(timeDelayedUnfold,i,1200)
	
	end

--flowers
for i=1,table.getn(Hold),1 do

randoVal=math.random(0,360)
	randoVal=randoVal*i
	Turn(Hold[i],y_axis,math.rad(randoVal),0)
end	

--bubbles
	for i=1,11,1 do
		for a=1,internalAffairs[i],1 do
		--yturn
		randoVal=math.random(0,360)
		randoVal=randoVal*i
		Turn(Bubbles[i][a],y_axis,math.rad(randoVal),0)
		Turn(Oil[i][a],y_axis,math.rad(randoVal),0)
		
		--xturn
		randoVal=math.random(-75,75)
		randoVal=randoVal
		Turn(Bubbles[i][a],x_axis,math.rad(randoVal),0)
		Turn(Oil[i][a],x_axis,math.rad(randoVal),0)
		
			--zturn
		randoVal=math.random(-75,75)
		randoVal=randoVal
		Turn(Bubbles[i][a],z_axis,math.rad(-1*randoVal),0)
		Turn(Oil[i][a],z_axis,math.rad(randoVal),0)
		
		end

	end
	
end

function movePlant()
Move(ffrotator,y_axis,-166,0)
Move(ffmain01,y_axis,-200,0)
Turn(ffrotator,y_axis,math.rad(-122),0)
Move(ffrotator,y_axis,0,55)
Move(ffmain01,y_axis,0,66)
Turn(ffrotator,y_axis,math.rad(0),0.72)

end
function shockwave()
local splEmitSfx= EmitSfx
for i=1,12,1 do
splEmitSfx(spiralCenter,1026)
splEmitSfx(spiralCenter,1026)
splEmitSfx(spiralCenter,1026)
splEmitSfx(spiralCenter,1026)
time=i*10
Sleep(time)
end
end

function fireLight()
deci=1
local splEmitSfx= EmitSfx
while(true) do
splEmitSfx(spiralCenter,1027)
randSleep=math.random(44,78)
Sleep(randSleep)
	if deci==1 then
	deci=0
	splEmitSfx(fireSpiral1,1027)
	Sleep(23)
	else
	deci=1
	splEmitSfx(fireSpiral2,1027)
	Sleep(12)
	end

end
end

function suckInFire()
done=0
local splEmitSfx= EmitSfx
	
while(true) do
		randy=math.random(-22,22)
		it=0
		
		for i=1,360, 1 do
		
		it=((it+i)%63)+1
		x=pseudoRandom[it]
		--x=math.random(1,4)
			if x==1 then
			target=randy+ (i%22)		
			Move(fireEmitor,x_axis,target,0,true)
			Turn(fireCenter,y_axis,math.rad(i),0,true)
			WaitForTurn(fireCenter,y_axis)					
			splEmitSfx(fireEmitor,1034)
			end
		
		end
		if done %190==0 then
			for j=1,table.getn(Astrotatoren),1 do
			splEmitSfx(Astrotatoren[j],1035)
			
			end
			done=0
		end
		done=done+5
	 
	
	Sleep(125)
	end
end

function haveSoundArround()
local spPlaySoundFile=Spring.PlaySoundFile
spPlaySoundFile("sounds/jfireflower/fireflowgrowth.wav") 
Sleep(5000)
while(true)do
di=math.random(0,1)
if di==1 then

spPlaySoundFile("sounds/jfireflower/firehowl.wav",0.5) 
Sleep(10000)
else

spPlaySoundFile("sounds/jfireflower/fireflowburn.wav",0.5) 
Sleep(16000)
end


end

end

local sparedUnits={}
sparedUnits[UnitDefNames["css"].id]=true
sparedUnits[UnitDefNames["jfiredancer"].id]=true
sparedUnits[UnitDefNames["jfiredancebomb"].id]=true

function spawnFire(time,enemyID)
temp=0
x,y,z=0
local spSpawnCEG=Spring.SpawnCEG
local spGetUnitPosition=Spring.GetUnitPosition
while (temp < time) do
	x,y,z=spGetUnitPosition(enemyID)
	spSpawnCEG("disolvefire",x,y,z,0,1,0,50,0)
	randtime=math.random(50,72)
	Sleep(randtime)
	temp=temp+randtime
end

defID=Spring.GetUnitDefID(enemyID)
	if defID and not sparedUnits[defID] then

								Spring.SetUnitNoDraw(enemyID,false)
								spSpawnCEG("disolvefire",x,y,z,0,1,0,50,0)
								Spring.DestroyUnit(enemyID,false,true) 
								Sleep(50)
								spSpawnCEG("disolvefire",x,y,z,0,1,0,50,0)
								Sleep(50)
								spSpawnCEG("disolvefire",x,y,z,0,1,0,50,0)
	end
end

function goTooKillThemAllPicaMon()

selectRange=250
piecePosX,piecePosY,piecePosZ=Spring.GetUnitPosition(unitID)
----Spring.Echo("PiecePosX:",piecePosX.."      | PiecePosZ:",piecePosZ)
--get Piece Position
proChoice={}
proChoice=Spring.GetUnitsInCylinder(piecePosX, piecePosZ,selectRange )--no idea why 2.9 but satan told me so

local spGetUnitPosition=Spring.GetUnitPosition
	if proChoice ~= nil then
							
											

											--Kill the Unit
			for i=1,table.getn(proChoice),1 do		
													if proChoice[i] ~= unitID then
													x,y,z=spGetUnitPosition(proChoice[i])
													StartThread(spawnFire,782,proChoice[i])
											--leave no wreck
												    end
			end

	end
end

function theBigFireStorm()
StartThread(haveSoundArround)
Spin(spiralCenter,y_axis,math.rad(42),0.5)
Sleep(3200)
while(true) do
--EmitBubbles
	for i=1,11,1 do
		for a=1,internalAffairs[i],1 do
		EmitSfx(Oil[i][a],1024)
		Hide(Oil[i][a])
		end
	end
--Start Petals and Seeds
	for i=1,9,1 do
	StartThread(flyP,i)
	end


	for i=1,table.getn(Seed),1 do
	StartThread(flySeed,i)
	end
Spring.PlaySoundFile("sounds/jfireflower/ignite.wav") 	
Sleep(400)
	----- fire ignite + shockwave
EmitSfx(spiralCenter,1025)
StartThread(shockwave)
Sleep(900)
	--show the fireLight     EXPANSION
StartThread(suckInFire)
StartThread(centerFire)	
EmitSfx(spiralCenter,1025)
StartThread(fireLight)
goTooKillThemAllPicaMon()
Sleep(2000)
	--adding some heat       FIREWHIRL + DustInSweep
StartThread(cyclesOfFire)
EmitSfx(spiralCenter,1025)
Spring.PlaySoundFile("sounds/jfireflower/ignite.wav") 	
StartThread(fireLight)
StartThread(dirtSuckedInwards)
goTooKillThemAllPicaMon()
Sleep(3000)
StartThread(centerFire)	
	--adding some heat
EmitSfx(spiralCenter,1025)
Spring.PlaySoundFile("sounds/jfireflower/ignite.wav") 	
StartThread(fireLight)
	for i=1,62,1 do
	goTooKillThemAllPicaMon()
	Sleep(1000)
	end
reSeed()
end
end

function reSeed()

	for i=1,9,1 do
	StartThread(flyP,i)
	end


end

boolFullGrown=false
Pod=piece"Pod"
piecesTable[#piecesTable+1]=Pod

function seedToBeFeed()
boolFullGrown=false
--Move Pod up
Move(Pod,y_axis,-50,0)
Show(Pod)
Move(Pod,y_axis,0,0.5)
WaitForMove(Pod,y_axis)
--unfold Pod
--Feed Me
x,y,z=Spring.GetUnitPosition(unitID)
boolSupperTime=false
	while boolSupperTime==false do
	T=getAllInCircle(unitID,x,z,50)
		if T then
		boolSupperTime=true
		forTableUseFunction(T,
							function (id) Spring.DestroyUnit(id,true,false) end
							)
		end
	Sleep(100)
	end

	--foldFast Animation
	boolFullGrown=true
	
--Fold
Move(Pod,y_axis,-150,0.5)

end

function script.Create()
hideT(piecesTable)
Move(ffrotator,y_axis,-166,0)
Move(ffmain01,y_axis,-200,0)
Turn(ffrotator,y_axis,math.rad(-122),0)
Hide(fireEmitor)
Hide(centerFireFx)
Hide(fireFx1)
Hide(fireFx2)
Hide(fireFx3)
Hide(shockwaveemit)
	for i=1,table.getn(WindP),1 do
	Hide(WindP[i])
	end

x360=math.random(0,360)
Turn(center,y_axis,math.rad(x360),0)
StartThread(seedToBeFeed)

 
end
--What have i done? 
 function SacrificeToTheDevs(goat)
if goat== nil then
os.exit()
 end
 end

aimspot=piece"aimspot"
---AIMING & SHOOTING---
-----------------------------------------WEAPON ONE ----------------------------
function script.AimFromWeapon1() 
    	return aimspot
end

function script.QueryWeapon1() 
	return aimspot
end


function script.AimWeapon1( heading, pitch )
if boolFullGrown==false then return boolFullGrown end

	if oneShot == true then	
	return true
		else 
		return false
		end
   
end

function fireAnimation()


end

function extendFireAnimation()


end

function imOnFire(burningManID)

Sleep(1200)
Spring.DestroyUnit(burningManID,true,false)		
end

function delayedDestruction()
Sleep(9000)
Spring.DestroyUnit(unitID,false,true)		
end

function script.FireWeapon1()

oneShot=false
movePlant()
randBuild()
StartThread(theBigFireStorm)

StartThread(unfoldFlowers)
end



function script.Killed(recentDamage, maxHealth)
x,y,z=Spring.GetUnitPosition(unitID)
if not GG.AddFire then GG.AddFire={} end
GG.AddFire[#GG.AddFire+1]={x=x,y=y,z=z}
		return 1 
end