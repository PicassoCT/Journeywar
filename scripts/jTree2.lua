include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "createCorpse.lua"
include "lib_jw.lua" 
include "lib_Build.lua" 


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
function actualTrample()
Sleep(500)
Spring.DestroyUnit(unitID,false,true)

end
DNASpiral = piece "DNASpiral"
function TreeTrample()
StartThread(actualTrample)
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
	mP(fruits[nr][1],0,0,0,0)
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,fruits[nr][1])
	y2=Spring.GetGroundHeight(x,z)
	distance=math.abs(y-y2)
	
	fruits[nr][2]=true
	speed=1
	mSyncIn(fruits[nr][1],0,-distance,0,5000)
	WaitForMoves(fruits[nr][1])
	
	
end
maxtime=90000

function fruitLoop()
	
	while(true)  do
		
		rest=math.ceil(math.random(4900,62000))
		Sleep(rest)
		deci=math.ceil(math.random(0,table.getn(fruits)))

			if fruits[deci] and fruits[deci][2] and fruits[deci][2]==false then
				StartThread(fallingFruit,deci)
			end

	end
end



TransformTable = getDreamTreeTransformUnitTypeTable(UnitDefNames)
TransformRange=200
function convertInfantryNearby()

    myTeam = Spring.GetUnitTeam(unitID)

    while true do
        px, py, pz = Spring.GetUnitPosition(unitID)
        T = getAllInCircle(px, pz, TransformRange, unitID)

        process(T,
            function(id)
                defID = Spring.GetUnitDefID(id)
                if id ~= unitID and TransformTable[defID] then
                    return id
                end
            end,
            function(id)
                unitTeam = Spring.GetUnitTeam(id)
                typeToTransferInto = TransformTable[Spring.GetUnitDefID(id)]
                if typeToTransferInto then
                    resultID = transformUnitInto(id, typeToTransferInto)
                    return resultID
                end
            end,
            function(id)
                if id then

                    Spring.TransferUnit(id, myTeam, false)
                    ux, uy, uz = Spring.GetUnitPosition(id)
                    Spring.SpawnCEG("jtree2trans", ux, uy + 15, uz, 0, 1, 0, 60)
                end
            end)


        Sleep(350)
    end
end

function dnaspiralloop()
    Show(DNASpiral)
    while true do
        Spin(DNASpiral, y_axis, math.rad(-12), 0.001)
        WMove(DNASpiral, y_axis, -10, 1)
        StopSpin(DNASpiral, y_axis, 0.001)
        Sleep(1000)
        Spin(DNASpiral, y_axis, math.rad(12), 0.001)
        WMove(DNASpiral, y_axis, 0, 1)
        StopSpin(DNASpiral, y_axis, 0.001)
        Sleep(4000)
    end
end


rootTurnDeg=0
TableOfPieceGroups = {}
rootTurnDeg = 0
function script.Create()
    TableOfPieceGroups = getPieceTableByNameGroups(false, true)
    StartThread(delayedActivation)
    Spin(centRot, y_axis, math.rad(4), 0.001)
    Spin(rot1, y_axis, math.rad(4), 0.001)
    Spin(rot2, y_axis, math.rad(-8), 0.001)

    --centerturn
    randoMarlo = math.random(0, 360)
    Turn(center, y_axis, math.rad(randoMarlo))

    tempTypeDefID = Spring.GetUnitDefID(unitID)

    --the roots turning
    selector = aListOfRandom(table.getn(root))
    for i = 1, table.getn(root), 1 do
        Turn((root[selector[i]]), y_axis, rootTurnDeg)
        rootTurnDeg = diceNewDeg(rootTurnDeg, 75, 25)
    end

    resetT(TableOfPieceGroups["fruit"], 0)
    add = 0
    for i = 1, table.getn(leaves), 1 do
        this = math.random(0, 360)
        Turn(leaves[i], y_axis, math.rad(this), 0)
    end
    Hide(DNASpiral)

    --if a tree is drunk in the woods and falls down
    randoValX = math.random(-5, 5)
    randoValZ = math.random(-5, 5)
    randoValY = math.random(0, 360)
    Turn(center, x_axis, math.rad(randoValX), 0)
    Turn(center, y_axis, math.rad(randoValY), 0)
    Turn(center, z_axis, math.rad(randoValZ), 0)
    -- getting the baumkrone straighted

    --liane?

    --the treetop randomizing

    --the roots turning
    astTurndeg = 0
    selector = aListOfRandom(table.getn(rotable))
    for i = 1, table.getn(rotable), 1 do
        Turn((rotable[selector[i]]), y_axis, astTurndeg)
        astTurndeg = diceNewDeg(astTurndeg, 51, 15)
    end
    StartThread(randomizedSpin)

    if Spring.GetUnitDefID(unitID) == UnitDefNames["jtree2"].id then
        for i = 1, table.getn(fruits), 1 do
            Hide(fruits[i][1])
        end
    else

        StartThread(fruitLoop)
        StartThread(convertInfantryNearby)
        StartThread(dnaspiralloop)
    end

    StartThread(deactivateAndReturnCosts, unitID, UnitDefs, 0.45)
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
	if boolDenialActive == true then
		setDenial(unitID)
		return 1
	end
end


function script.Deactivate()
	
	
	return 0
end