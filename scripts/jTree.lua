
include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

eyenumber=14
local EYES= {}
for i=1, 14, 1 do
	EYES[i]= {}
	eyetemp = "eye0"..i
	EYES[i]= piece (eyetemp)
end


root={}
for i=1, 9, 1 do
	root[i]={}
	roottemp="root"..i
	root[i]=piece (roottemp)
end

standtree={}
for i=1, 5, 1 do
	standtree[i]={}
	standtreetemp="standtree"..i
	standtree[i]=piece (standtreetemp)
end

ast={}
for i=1, 7, 1 do
	ast[i]={}
	asttemp="ast"..i
	ast[i]=piece (asttemp)
end

function TreeTrample()
	Spring.DestroyUnit(unitID,true,false)
end


ast3L2=piece "ast3L2"
ast2L3=piece "ast2L3"
treerotatestump=piece "treerotatestump"
center=piece "center"
ast2L1=piece "ast2L1"
ast5L1=piece "ast5L1"
ast4L1=piece "ast4L1"
ast4L2=piece "ast4L2"
ast1L3=piece "ast1L3"
ast1L2=piece "ast1L2"
ast1L1=piece "ast1L1"
root5base=piece "root5base"
ast2L2=piece "ast2L2"
ast5L2=piece "ast5L2"
ast3L1=piece "ast3L1"
ast1L4=piece "ast1L4"
baumkrone=piece "baumkrone"
rootbase=piece "rootbase"
root2base=piece "root2base"
root3base=piece "root3base"
treebasis=piece "treebasis"


function diceNewDeg(oldDeg,upValue,margin)
	temp=0
	if margin > 0 then
		temp=math.random((margin*-1),margin)
	else
		temp=math.random(margin,-1*margin)
	end
	return (oldDeg+(upValue+temp))
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

function aSilentGuardian(handedoverNumber)
	boolGuardian=false
	Sleep(500)
	howlong=math.random(10,50)
	for i=1,howlong,1 do
		Show(EYES[handedoverNumber])
		trulla=handedoverNumber-1
		Show(EYES[trulla])
		showy=(1000-(i*10))
		Sleep(showy)
		Hide(EYES[handedoverNumber])
		Hide(EYES[trulla])
		Sleep(1024)
		Sleep(i)
	end
	
	boolGuardian=true
end

function blinky(nr1, nr2,time)
	Show(EYES[nr1])
	Show(EYES[nr2])
	Sleep(time)
	Hide(EYES[nr1])
	Hide(EYES[nr2])
	Sleep(600)
	Show(EYES[nr1])
	Show(EYES[nr2])
end

boolGuardian=false
function hungryEYES()
	
	while(true)do
		--guardian
		
		choicy=math.random(2,eyenumber)
		StartThread(aSilentGuardian,choicy)
		--idelwaiting thread
		while(boolGuardian==true) do
			Sleep(400)
		end
		--rest
		randTime=math.random(5000,42000)
		Sleep(randTime)
		
		--wideAwake, one after another
		for i=1, (eyenumber)-1,1 do
			Show((EYES[i]))
			Show(EYES[i+1])
			s=math.random(100,500)
			Sleep(s)
		end
		x=math.random(10,25)
		while (x > 0 ) do 
			--
			for i=1,(eyenumber)-1,2 do
				y=math.random(100,900)	
				Sleep(y)
				StartThread(blinky,i,i+1,y*3)
			end
			Sleep(3000)
			
			x=x-1	
		end	
		
		
		--dosing off
		for i=1,(eyenumber),1 do
			Hide((EYES[i]))
			Sleep(800)
			if i%2==0 then
				Sleep(i*250)
			end
		end
		Sleep(9000)
		
	end
	
end

function aListOfRandom(nrOfElements)
	tempList={}
	for i=1,nrOfElements,1 do
		tempList[i]=i
	end
	tempList=shuffle(tempList)
	return tempList
end


rootTurnDeg=0
function script.Create()
	
	teamID=Spring.GetUnitTeam(unitID)
	x,y,z=Spring.GetUnitPosition(unitID)
	if math.random(0,1)==1 then
		GG.UnitsToSpawn:PushCreateUnit("gtreeplate",x,y,z,0,teamID)
	else
		GG.UnitsToSpawn:PushCreateUnit("gtreeplate2",x,y,z,0,teamID)
	end
	
	--centerturn
	randoMarlo=math.random(0,360)
	Turn(center,y_axis,math.rad(randoMarlo))
	
	--the roots turning
	selector=aListOfRandom(table.getn(root))
	for i=1,table.getn(root),1 do
		Turn((root[selector[i]]),y_axis,rootTurnDeg)
		rootTurnDeg=diceNewDeg(rootTurnDeg,40,15)
	end
	--setup the rootrotatbles
	pie=math.random(0,360)
	Turn(root2base,y_axis,pie,0)
	pie=math.random(0,360)
	Turn(root3base,y_axis,pie,0)
	pie=math.random(0,360)
	Turn(root5base,y_axis,pie,0)
	
	--we decide upon a log
	deci=math.random(1,5)
	
	add=0
	for i=1,table.getn(standtree),1 do
		if i~= deci then
			Hide(standtree[i])
		end
	end
	--shwoing another trunk
	deciAdd=math.random(0,1)
	if deciAdd== 1 then
		add=math.random(1,5)
		Show(standtree[add])
	end
	--EYES wide shut?
	if deci== 4 or add == 4 then
		StartThread(hungryEYES)
		Hide(baumkrone)
		for i=1, eyenumber,1 do
			temp=(EYES[i])
			Hide(temp)
		end
		
	else
		for i=1, eyenumber,1 do
			temp=(EYES[i])
			Hide(temp)
		end
	end
	
	--if a tree is drunk in the woods and falls down
	randoValX=math.random(-22,22)
	randoValZ=math.random(-11,11)
	randoValY=math.random(0,360)
	Turn(treerotatestump,x_axis,math.rad(randoValX),0)
	Turn(treerotatestump,y_axis,math.rad(randoValY),0)
	Turn(treerotatestump,z_axis,math.rad(randoValZ),0)
	-- getting the baumkrone straighted
	Turn(baumkrone,x_axis,math.rad(-1*randoValX),0)
	Turn(baumkrone,z_axis,math.rad(-1*randoValZ),0)
	
	--liane?
	li=math.random(0,2)
	if li==1 then
		Hide(ast4L1)
		Hide(ast4L2)
	end
	--the treetop randomizing
	
	--the roots turning
	astTurndeg=0
	selector=aListOfRandom(table.getn(ast))
	for i=1,table.getn(ast),1 do
		Turn((ast[selector[i]]),y_axis,astTurndeg)
		astTurndeg=diceNewDeg(astTurndeg,51,15)
	end
	if math.random(0,7)==2 then
		StartThread(playSoundByUnitTypOS,unitID,0.5,{
			{name="sounds/jtree/djunglefever"..math.floor(math.random(1,3))..".ogg",time=15000}
		})
	end
	StartThread(deactivateAndReturnCosts,unitID,UnitDefs, 0.75)
end

function dusty(x)
	for i=1,x,1 do
		EmitSfx(root[(i%(table.getn(root)-1))+1],1024)
		EmitSfx(baumkrone,1028)--leaves
		Sleep(90)
	end
	
end

function dusty2(x)
	for i=1,x,1 do
		EmitSfx(root[(i%(table.getn(root)-1))+1],1024)
		EmitSfx(baumkrone,1024)
		EmitSfx(baumkrone,1028)
		EmitSfx(baumkrone,1028)
		for a=1,eyenumber,1 do
			EmitSfx(EYES[a],1024)
		end
		
		Sleep(90)
	end
	
end

function fire(x)
	for i=1,x,1 do
		EmitSfx(root[(i%(table.getn(root)-1))+1],1024)
		EmitSfx(baumkrone,1027)
		EmitSfx(baumkrone,1028)
		EmitSfx(baumkrone,1025)
		if i%12==0 then
			EmitSfx(baumkrone,1026)
		end
		for a=1,14,1 do
			if i%4==0 and a%4==0 then
				EmitSfx(EYES[a],1025)
			end
			EmitSfx(EYES[a],1027)
		end
		
		Sleep(90)
	end
	
	Sleep(300)
	EmitSfx(baumkrone,1026)
	
end



function script.Killed(recentdamage,_)
	Spring.PlaySoundFile("sounds/jEtree/tree.wav")
	Sleep(2000)
	Turn(treerotatestump,x_axis,math.rad(0),2)
	Turn(treerotatestump,y_axis,math.rad(0),2)
	Turn(treerotatestump,z_axis,math.rad(0),2)
	if recentdamage > 12 then
		StartThread(fire,33)
		StartThread(dusty,33)
	else
		StartThread(dusty,33)
	end
	
	
	Turn(center,z_axis,math.rad(30),0.3)
	Turn(baumkrone,z_axis,math.rad(-30),2)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(60),1)
	Turn(baumkrone,z_axis,math.rad(-70),2)
	
	Turn(baumkrone,z_axis,math.rad(-65),2)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(65),2.2)
	Turn(baumkrone,z_axis,math.rad(-65),6)
	WaitForTurn(center,z_axis)
	Turn(baumkrone,z_axis,math.rad(-78),6)
	Turn(center,z_axis,math.rad(89),6)
	
	if recentdamage > 12 then
		StartThread(fire,48)
	else
		StartThread(dusty2,11)
	end
	WaitForTurn(center,x_axis)
	
	EmitSfx(baumkrone,1024)
	for i=1,9, 1 do
		Turn(baumkrone,z_axis,math.rad(-78+(3-(i/2))),0.9*(1/i))
		WaitForTurn(baumkrone,z_axis)
		Turn(baumkrone,z_axis,math.rad(-78-(3.2-(i/3))),0.9*(1/i))
		WaitForTurn(baumkrone,z_axis)
	end
	--emit various particles+sound
	
	Sleep(4500)
	Move(center,y_axis,-32,3.141)--circle
	WaitForMove(center,y_axis)
	suddenDeathjBuildCorpse(unitID, recentDamage)
	return 1
	
end



function script.Activate()
	setDenial(unitID)
	return 1
end

function script.Deactivate()
	
	
	return 0
end