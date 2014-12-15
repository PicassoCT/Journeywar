    centRot=piece"centRot"
	center= piece "normTree"
	rot1= piece "rot1"
	rot2= piece "rot2"
	
	root={}
	for i=1, 5, 1 do
	root[i]={}
	roottemp="root"..i
	root[i]=piece (roottemp)
	end
	
	
	
	rotable={}
	for i=1, 13, 1 do
	rotable[i]={}
	asttemp="branch"..i
	rotable[i]=piece (asttemp)
	end
	
	sbranch1=piece"sbranch1"
	sbranch2=piece"sbranch2"
	sbranch3=piece"sbranch3"
	sbranch4=piece"sbranch4"
	
	
	function TreeTrample()
	Turn(center,z_axis,math.rad(30),0.3)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(60),1)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(65),2.2)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(89),6)
	Spring.DestroyUnit(unitID,false)
	end
	
		rotable[table.getn(rotable)+1]={}
		rotable[table.getn(rotable)]=sbranch1
		
		rotable[table.getn(rotable)+1]={}
		rotable[table.getn(rotable)]=sbranch2
		
		rotable[table.getn(rotable)+1]={}
		rotable[table.getn(rotable)]=sbranch3
		
		rotable[table.getn(rotable)+1]={}
		rotable[table.getn(rotable)]=sbranch4
	leaves={}
	for i=1, 17, 1 do
	leaves[i]={}
	asttemp="ALeave"..i
	leaves[i]=piece (asttemp)
	end 
	
	fruits={}
	for i=1, 10, 1 do
	fruits[i]={}
	fruits[i][1]={}
	fruits[i][2]={}
	fruits[i][2]=false
	asttemp="fruit"..i
	fruits[i][1]=piece (asttemp)
	end 

function diceNewDeg(oldDeg,upValue,margin)
temp=0
	if margin > 0 then
	temp=math.random((margin*-1),margin)
	else
	temp=math.random(margin,-1*margin)
	end
return (oldDeg+(upValue+temp))
end
--function: Is called by a Gamagardener, replaces the Object with the activated Version - Obj selfdestructor


	function randomizedSpin()
	while 1 do
	upDown=math.random(0,1)
	if upDown==1 then
	dice=math.random(-5,5)
	Move(rot1,y_axis,dice,0.0025)
		dice=math.random(-5,5)
	Move(rot2,y_axis,dice,0.0025)
	end
	
	rest=math.ceil(math.random(900,54000))
	Sleep(rest)
	
	roto=math.random(-4,4)
	Spin(centRot,y_axis,math.rad(roto),0.001)
	toto=math.random(-6,6)
	groto=math.random(-6,6)
	Spin(rot1,y_axis,math.rad(toto),0.001)
	Spin(rot2,y_axis,math.rad(groto),0.001)
		
	end
	end

function shuffle(t)
  local n = #t
 
  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
 
  return t
end
boolGuardian=false


function aListOfRandom(nrOfElements)
tempList={}
for i=1,nrOfElements,1 do
tempList[i]=i
end
tempList=shuffle(tempList)
return tempList
end

local isInfantry={ 
			[UnitDefNames["bg"].id]=true,
			[UnitDefNames["css"].id]=true,
			[UnitDefNames["gcivillian"].id]=true,
			[UnitDefNames["skinfantry"].id]=true,
			[UnitDefNames["tiglil"].id]=true
			}
			
local spGetUnitDefID=Spring.GetUnitDefID
local teamid=Spring.GetUnitTeam(unitID)
function fallingFruit(nr)
x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,fruits[nr][1])
y2=Spring.GetGroundHeight(x,z)
distance=math.abs(y-y2)

fruits[nr][2]=true
speed=1

	for i=1,distance,1 do
	Move(fruits[nr][1],y_axis, -i,speed)
	WaitForMove(fruits[nr][1],y_axis)
	speed=math.min(speed*i*speed, 120)
	
	Sleep(2500)
	end
	StartThread(fieldsOfFruit,nr) 

end
maxtime=90000

function fieldsOfFruit(nr)
--convert infantry
	restTime=math.ceil(math.random(2500,maxtime))
	Sleep(restTime)
	
	t=Spring.GetUnitsInCylinder(x,z,200)
	table.remove(t,unitID)
	if t and #t > 0 then
		for i=1,#t do
		defid=spGetUnitDefID(t[i])
			if math.random(0,1)==1 and isInfantry[defid] then
			replaceUnit(t[i], "tiglil")
			end
		end
	end
	
	Hide(fruits[nr][1])
	Move(fruits[nr][1],y_axis, 0,0)
		rest=maxtime-restTime
		Sleep(rest)
	Show(fruits[nr][1])
	fruits[nr][2]=false
	end


function replaceUnit(id,typeName)
x,y,z=Spring.GetUnitPosition(id)
	if x and  GG.UnitsToSpawn then
	GG.UnitsToSpawn:PushCreateUnit(typeName,x,y,z, 0, teamid)
	end
Spring.DestroyUnit(id,true,true)
end

function fruitLoop()
while(true) do

	rest=math.ceil(math.random(4900,62000))
	Sleep(rest)
	deci=math.ceil(math.random(0,table.getn(fruits)))
	if deci~=2 and deci~=7 and deci~=8 then
		if fruits[deci] and fruits[deci][2] and fruits[deci][2]==false then
		StartThread(fallingFruit,deci)
		end
	end
end
end

	 
rootTurnDeg=0
function script.Create()

Spin(centRot,y_axis,math.rad(4),0.001)
Spin(rot1,y_axis,math.rad(4),0.001)
Spin(rot2,y_axis,math.rad(-8),0.001)
--centerturn
randoMarlo=math.random(0,360)
Turn(center,y_axis,math.rad(randoMarlo))

tempTypeDefID=Spring.GetUnitDefID(unitID)

--the roots turning
selector=aListOfRandom(table.getn(root))
for i=1,table.getn(root),1 do
Turn((root[selector[i]]),y_axis,rootTurnDeg)
rootTurnDeg=diceNewDeg(rootTurnDeg,75,25)
end


add=0
for i=1,table.getn(leaves),1 do
this=math.random(0,360)
Turn(leaves[i],y_axis,math.rad(this),0)
end


--if a tree is drunk in the woods and falls down
randoValX=math.random(-5,5)
randoValZ=math.random(-5,5)
randoValY=math.random(0,360)
Turn(center,x_axis,math.rad(randoValX),0)
Turn(center,y_axis,math.rad(randoValY),0)
Turn(center,z_axis,math.rad(randoValZ),0)
-- getting the baumkrone straighted

--liane?

--the treetop randomizing

--the roots turning
astTurndeg=0
selector=aListOfRandom(table.getn(rotable))
for i=1,table.getn(rotable),1 do
Turn((rotable[selector[i]]),y_axis,astTurndeg)
astTurndeg=diceNewDeg(astTurndeg,51,15)
end
StartThread(randomizedSpin)
tempDEFID=Spring.GetUnitDefID(unitID)
	if tempDEFID==UnitDefNames["jtree2"].id then
		for i=1, table.getn(fruits),1 do
		Hide(fruits[i][1])
		end
	else

	StartThread(fruitLoop)
	end
end



function script.Killed(recentdamage,_)
Spring.PlaySoundFile("sounds/jEtree/tree.wav")
Sleep(2000)


Turn(center,z_axis,math.rad(30),0.3)
WaitForTurn(center,z_axis)
Turn(center,z_axis,math.rad(60),1)
WaitForTurn(center,z_axis)
Turn(center,z_axis,math.rad(65),2.2)
WaitForTurn(center,z_axis)
Turn(center,z_axis,math.rad(89),6)

WaitForTurn(center,x_axis)

--emit various particles+sound

Sleep(4500)
Move(center,y_axis,-32,3.141)--circle
WaitForMove(center,y_axis)
suddenDeathjBuildCorpse(unitID, recentDamage)
return 1

end

