
include "createCorpse.lua"
include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 


treebasis=piece "treebasis"
center=piece "center"
treetoproto=piece "treetoproto"
treerotatestump=piece "LowStem"
counterrotatestump=piece "UpStem"
baumkrone=treetoproto
rooter=piece"rooter"

oldDeg=0
function diceNewDeg(upValue,margin)
	temp=0
	if margin > 0 then
		temp=math.random((margin*-1),margin)
	else
		temp=math.random(margin,-1*margin)
	end
	oldDeg=oldDeg +(upValue+temp)
	return oldDeg
end


function aListOfRandom(nrOfElements)
	tempList={}
	for i=1,nrOfElements,1 do
		tempList[i]=i
	end
	tempList=shuffle(tempList)
	return tempList
end

function TurnRootRandom()

	--if a tree is drunk in the woods and falls down
	randoValX=math.random(-22,22)

	randoValZ=math.random(-55,-11)*randSign()
--	randoValY=math.random(-360,360)
	
--	Turn(treerotatestump,y_axis,math.rad(randoValY),0)
	Turn(rooter,z_axis,math.rad(-1*randoValZ),0)
	Turn(treerotatestump,z_axis,math.rad(randoValZ),0)


	-- getting the baumkrone straighted
	percentage=math.random(1,99)/100
	Turn(counterrotatestump,z_axis,math.rad(-1*randoValZ*(percentage)),0)
		
	Turn(treetoproto,x_axis,math.rad(-1*randoValX*(1-percentage)),0)
	offset=math.random(-10,10)
	Turn(treetoproto,z_axis,math.rad(-1*randoValZ*(1-percentage)+offset),0)

	
end

function createRoot()
	rootOffset=0
	
	process(TableOfPieceGroups["Root"],
	function(id)
		offsetVal=math.random(360/12,360/4)
		rootOffset=rootOffset+offsetVal
		Turn(id,y_axis,math.rad(rootOffset),0)

	end)

end

function createTreeTop()
	treeFormVal=math.random(-9,20)
	rotationValue={}
	index=1
	for i=1,24 do
	rotationValue[#rotationValue+1]=diceNewDeg(360/12,6)
	end
	rotationValue=shuffleT(rotationValue)
	boolSinus=math.random(0,1)==1
	
	process(TableOfPieceGroups["rooftop"],
	function(id)
	if boolSinus == false then
		Turn(id,z_axis,math.rad(math.random(-10,10)),0)	
		Turn(id,y_axis,math.rad(rotationValue[index]),0)

	else
		factor=math.sin(((index/12)*2*math.pi))*10
		Turn(id,z_axis,math.rad(factor),0)	
		rotVal=diceNewDeg(360/12,6)
		Turn(id,y_axis,math.rad(rotVal),0)
	end

		index=index+1
	end)
	
	process(TableOfPieceGroups["TreeCarry"],
	function(id)
		Turn(id,y_axis,math.rad(math.random(-15,15)),0)
		Turn(id,z_axis,math.rad(treeFormVal+math.random(-5,5)),0)
	end)
		process(TableOfPieceGroups["TreeMid"],
	function(id)
		Turn(id,y_axis,math.rad(math.random(-15,15)),0)
		Turn(id,z_axis,math.rad(math.random(-5,5)),0)
	end)
	
			process(TableOfPieceGroups["TreeUp"],
	function(id)
		Turn(id,y_axis,math.rad(math.random(-15,15)),0)
		Turn(id,z_axis,math.rad(math.random(-5,5)),0)
	end)
			process(TableOfPieceGroups["TreeTop"],
	function(id)
		Turn(id,z_axis,math.rad(treeFormVal+ math.random(-3,3)),0)
	end)
	

end

function buildATree()
	TurnRootRandom()
	createTreeTop()
	createRoot()
	--centerturn
	randoMarlo=math.random(0,360)
	Turn(center,y_axis,math.rad(randoMarlo))

end

pieceTable= generatepiecesTableAndArrayCode(unitID, false)
TableOfPieceGroups={}
root={}
function script.Create()
	TableOfPieceGroups=	makePiecesTablesByNameGroups(false,true)
	root=TableOfPieceGroups["Root"]
	StartThread(delayedActivation)
	teamID=Spring.GetUnitTeam(unitID)
	x,y,z=Spring.GetUnitPosition(unitID)
	if math.random(0,1)==1 then
		GG.UnitsToSpawn:PushCreateUnit("gtreeplate",x,y,z,0,teamID)
	else
		GG.UnitsToSpawn:PushCreateUnit("gtreeplate2",x,y,z,0,teamID)
	end
	

	StartThread(buildATree)
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
	createCorpseJBuilding(unitID, recentDamage)
	return 1
	
end

boolDenialActive=false

function delayedActivation()
	health, maxHealth, paralyzeDamage, captureProgress, bp=Spring.GetUnitHealth(unitID)
	
	while bp and bp < 1 do
		health, maxHealth, paralyzeDamage, captureProgress, bp=Spring.GetUnitHealth(unitID)
		Sleep(200)
	end
	Sleep(1000)
	boolDenialActive=true
end



function script.Activate()
	if boolDenialActive== true then
		setDenial(unitID)
	end
	return 1
end

function script.Deactivate()
	
	
	return 0
end