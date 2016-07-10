
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

local repairsDone=600000
local timeTillDoneQuart=450000
cubes={}
outerCubes={}
totalCubes=588

for i=1,totalCubes,1 do
	cubes[i]={}
	outerCubes[i]={}
	piecenameOne="Cube"..i
	piecenameTwo="ShellC"..i
	outerCubes[i]=piece(piecenameTwo)
	cubes[i]=piece(piecenameOne)
end

tentacleCounter=0
function upGradde()
	--getting the old hitpoints
	oldhp,maxhp=Spring.GetUnitHealth(unitID)
	
	while repairsDone > 0 do
		hp,maxhp=Spring.GetUnitHealth(unitID)
		Sleep(1000)
		if tentacleCounter < 3 then
			tentacleCounter=tentacleCounter+1
			StartThread(buildingTentacles)
		end
		diff= hp- oldhp
		
		if diff > 0 then
			repairsDone = repairsDone -diff
		end
		
		if hp > maxhp * 0.75 then		
			Spring.SetUnitHealth(unitID,math.ceil(maxhp * 0.75) )
			hp= math.ceil(maxhp * 0.75) 
		end
		
		oldhp = hp
	end
	--Congrats you survived growing up
	if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)	
	GG.UnitsToSpawn:PushCreateUnit("fclvl2",x,y,z,0,teamID)	
	Sleep(4000)
	Spring.DestroyUnit(unitID,false,true)
end



fcvlvl2={
	true,true,true,false,true,true,true,
	false,true,true,false,true,true,false,
	false,true,true,false,true,true,true,
	true,true,true,false,true,true,false,
	false,true,true,true,true,true,true,
	true,true,true,true,true,true,true,
	true,true,true,true,true,true,true,
	
	
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,true,true,false,true,false,false,
	false,false,true,true,true,false,false,
	false,false,false,false,false,false,false,
	
	
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,true,true,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,true,true,false,
	false,false,false,false,false,false,false,
	false,false,false,false,true,true,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,true,true,false,
	false,false,false,false,false,false,false,
	false,false,false,false,true,true,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	
	
	
}


fclvlone={
	false,true,true,true,true,true,false,
	false,true,true,true,true,true,false,
	false,true,true,true,true,true,false,
	false,true,true,true,true,true,false,
	false,true,true,true,true,true,false,
	false,true,true,true,true,true,false,
	false,true,true,true,true,true,false,
	
	
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,true,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	
	
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,true,false,false,
	false,false,true,false,true,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,false,false,false,
	false,false,true,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,true,false,false,false,false,
	false,false,true,false,false,false,false,
	false,false,false,false,false,false,false,
	false,false,false,false,false,false,false,
}

cekMat=
{ 
	[1]={x=1,y=0,z=-7},
	[2]={x=1,y=0,z=0},
	[3]={x=1,y=0,z=7},
	[4]={x=0,y=0,z=-7},
	[5]={x=0,y=0,z=7},
	[6]={x=-1,y=0,z=7},
	[7]={x=-1,y=0,z=0},
	[8]={x=-1,y=0,z=-7},
	[9]={x=0,y=49,z=0},
	
}
function nextIt(it)
	val= math.ceil(math.random(1,9))
	if (it%7== 0 and cekMat[val].x== 1) or (it%7 == 1 and cekMat[val].x== -1 ) or (it <8 and cekMat[val].z== 7) or (it>42 and cekMat[val].z== -7 ) then
		if (it+49 < totalCubes) then 
			return it+49 
		else 
			return nil 
		end
	else
		return it+cekMat[val].z+cekMat[val].y+cekMat[val].x
	end
	
	
end

function buildingTentacles()
	dice=math.floor(math.random(1,49))
	if fcvlvl2[dice] and fcvlvl2[dice]==true then
		it=dice+49
		itTable={}
		while it and fcvlvl2[it]==false and cubes[it] do
			Move(cubes[it],y_axis,-260,0)
			if cubes[it] then
				table.insert(itTable,it)
				
				Show(cubes[it])
				Move(cubes[it],y_axis,0,25)
				Move(cubes[it],x_axis,0,25)
				Move(cubes[it],z_axis,0,25)
				WaitForMove(cubes[it],x_axis)
				WaitForMove(cubes[it],z_axis)
				WaitForMove(cubes[it],y_axis)					
				if cubes[it] then	
					x,y,z=Spring.GetUnitPiecePosition(unitID,cubes[it])
					
					it=nextIt(it)
					if cubes[it] then
						Move(cubes[it],y_axis,0,0,true)
						px,py,pz=Spring.GetUnitPiecePosition(unitID,cubes[it])
						x,y,z=px-x,py-y,pz-z
						Move(cubes[it],y_axis,y,0,true)
						Move(cubes[it],x_axis,x,0,true)
						Move(cubes[it],z_axis,z,0,true)
					end
				end
			end
		end
		Sleep(8000)
		
		for i=1,#itTable, 1 do
			Move(cubes[itTable[i]],y_axis,-750,125)
			Move(cubes[itTable[i]],x_axis,0,25)
			Move(cubes[itTable[i]],z_axis,0,25)
		end
		Sleep(9000)
		for i=1,#itTable, 1 do
			Hide(cubes[itTable[i]])
		end
	end
	tentacleCounter=tentacleCounter-1
end


function buildFactory()
	
	for i=1,totalCubes,1 do
		if fclvlone[i]==true then
			Show(cubes[i])
			Move(cubes[i],y_axis,0,0)
			Move(cubes[i],z_axis,0,0)
			Move(cubes[i],x_axis,0,0)
		end			
	end	
	
	for i=1,totalCubes,1 do
		if fcvlvl2[i]==true then
			Show(cubes[i])
			Move(cubes[i],y_axis,0,42)
			Move(cubes[i],z_axis,0,42)
			Move(cubes[i],x_axis,0,42)
		end
	end
	
	for i=1,totalCubes,1 do
		if fclvlone[i]==true and fcvlvl2[i]==false then
			Show(cubes[i])
			Move(cubes[i],y_axis,-350,60)
			
		end			
	end	
	
end

function moveIntoPlace()
	buildFactory()
	
end


function script.Create()
	for i=1,totalCubes,1 do
		Hide(outerCubes[i])
		Hide(cubes[i])
		Move(cubes[i],y_axis,-600,0)
		valx=math.random(-50,50)
		valz=math.random(-50,50)
		Move(cubes[i],x_axis,valx,0)
		Move(cubes[i],z_axis,valz,0)
	end
	StartThread(upGradde)
	StartThread(moveIntoPlace)
	--generatepiecesTableAndArrayCode(unitID)
end

function script.Killed(recentDamage,_)
	
	return 1
end