include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

local totalReppairs = 600000
local repairsDone = 600000
local timeTillDoneQuart = 450000
cubes = {}
outerCubes = {}
totalCubes = 588

for i = 1, totalCubes, 1 do
    piecenameOne = "Cube" .. i
    piecenameTwo = "ShellC" .. i
    outerCubes[i] = piece(piecenameTwo)
    cubes[i] = piece(piecenameOne)
end

function showHideCube(i, bShow)


if bShow == true then
 if outerCubes[i] then Show(outerCubes[i]) end
 if cubes[i] then Show(cubes[i]) end
 
else
 if outerCubes[i] then Hide(outerCubes[i]) end
 if cubes[i] then Hide(cubes[i]) end

end   
end

tentacleCounter = 0
percentage = 0.0
function upGradde()
    --getting the old hitpoints
    oldhp, maxhp = Spring.GetUnitHealth(unitID)
  
    while repairsDone > 0 do
			 buildingTentacles()
			percentage= (repairsDone/totalReppairs)

        hp, maxhp = Spring.GetUnitHealth(unitID)
       
        diff = hp - oldhp

        if diff > 0 then
            repairsDone = repairsDone - diff
        end

        if hp > maxhp * 0.5 then
            Spring.SetUnitHealth(unitID, math.ceil(maxhp * 0.5))
            hp = math.ceil(maxhp * 0.5)
        end

        oldhp = hp
	 Sleep(150)   	
    end
	
	for i = 1, totalCubes, 1 do
        if fcvlvl2[i] == true then
            Show(cubes[i])
            Move(cubes[i], y_axis, 0, 42)
            Move(cubes[i], z_axis, 0, 42)
            Move(cubes[i], x_axis, 0, 42)
        else				
				StartThread(mSyncIn,cubes[i], 0, math.random(-8000,-300), 0, math.ceil(math.random(10000,20000)))	
				if outerCubes[i] then
				StartThread(mSyncIn,outerCubes[i], 0, math.random(-8000,-300), 0, math.ceil(math.random(10000,30000)))			
				end
			end
    end
    --Congrats you survived growing up
    if GG.UnitsToSpawn then
        x, y, z = Spring.GetUnitPosition(unitID)
        teamID = Spring.GetUnitTeam(unitID)
        GG.UnitsToSpawn:PushCreateUnit("cbuildanimation", x, y, z, 0, teamID)
        GG.UnitsToSpawn:PushCreateUnit("cfclvl2", x, y, z, 0, teamID)
    end
    Sleep(30000)
    Spring.DestroyUnit(unitID, false, true)
end



fcvlvl2 = {
    true, true, true, false, true, true, true,
    false, true, true, false, true, true, false,
    false, true, true, false, true, true, true,
    true, true, true, false, true, true, false,
    false, true, true, true, true, true, true,
    true, true, true, true, true, true, true,
    true, true, true, true, true, true, true,



    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, true, true, false, true, false, false,
    false, false, true, true, true, false, false,
    false, false, false, false, false, false, false,



    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, true, true, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, true, true, false,
    false, false, false, false, false, false, false,
    false, false, false, false, true, true, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, true, true, false,
    false, false, false, false, false, false, false,
    false, false, false, false, true, true, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,
}


fclvl1 = {
    false, true, true, true, true, true, false,
    false, true, true, true, true, true, false,
    false, true, true, true, true, true, false,
    false, true, true, true, true, true, false,
    false, true, true, true, true, true, false,
    false, true, true, true, true, true, false,
    false, true, true, true, true, true, false,



    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, true, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,



    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, true, false, false,
    false, false, true, false, true, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, false, false, false,
    false, false, true, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,

    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, true, false, false, false, false,
    false, false, true, false, false, false, false,
    false, false, false, false, false, false, false,
    false, false, false, false, false, false, false,
}

cekMat =
{
    [1] = { x = 1, y = 0, z = -7 },
    [2] = { x = 1, y = 0, z = 0 },
    [3] = { x = 1, y = 0, z = 7 },
    [4] = { x = 0, y = 0, z = -7 },
    [5] = { x = 0, y = 0, z = 7 },
    [6] = { x = -1, y = 0, z = 7 },
    [7] = { x = -1, y = 0, z = 0 },
    [8] = { x = -1, y = 0, z = -7 },
    [9] = { x = 0, y = 49, z = 0 },
}
function nextIt(it)
    val = math.ceil(math.random(1, 9))
    if (it % 7 == 0 and cekMat[val].x == 1) or (it % 7 == 1 and cekMat[val].x == -1) or (it < 8 and cekMat[val].z == 7) or (it > 42 and cekMat[val].z == -7) then
        if (it + 49 < totalCubes) then
            return it + 49
        else
            return nil
        end
    else
        return it + cekMat[val].z + cekMat[val].y + cekMat[val].x
    end
end

allreadyMoving={}

function buildingTentacles()

	
	 iLevel= math.ceil((1.0-percentage)* totalCubes)
	 for i=1, 588, 7 do
		for l=0, 7, 1 do
		local k= i + l
		boolTouched= false
			
	   -- if part of the blueprint
			if fcvlvl2[k] == true  then 				
				boolTouched= true
				bCometogether = math.random(0,1)==1 
					if bCometogether == false then
						showHideCube(k, true)
					end
					
				randMove=	function()
						if not allreadyMoving[k] then allreadyMoving[k] = false end
						if allreadyMoving[k] == true then return end
						allreadyMoving[k] = true						
					
						movePieceRandDir(cubes[k], math.random(10,50), 25, -25,  25, -25,  -25, -200)
						if outerCubes[k] then
						movePieceRandDir(outerCubes[k], math.random(10,50), 25, -25,  25, -25,  -25, -200)
						WaitForMoves(outerCubes[k])
						end
						
						WaitForMoves(cubes[k])
						showHideCube(k, true)
						mSyncIn(cubes[k], 0, 0, 0, math.ceil(math.random(500,3000)))
						if outerCubes[k] then
						mSyncIn(outerCubes[k], 0, 0, 0, math.ceil(math.random(500,3000)))
							WaitForMoves(outerCubes[k])
						end						
					
						WaitForMoves(cubes[k])
						allreadyMoving[k] = false
					end
					
					
				StartThread(randMove)
			else
		   --if part of the percentage display
				if k < iLevel then 	
					boolTouched= true
					showHideCube(k, true)
					if outerCubes[k] then 
						StartThread(mSyncIn,outerCubes[k], math.random(-10,10),  math.random(-10,10),  math.random(-10,10), math.ceil(math.random(500,3000))) 
					end
					StartThread(mSyncIn,cubes[k], math.random(-10,10),  math.random(-10,10),  math.random(-10,10), math.ceil(math.random(500,3000))) 

			   end			   
		   end	
		   
		     if k-7 == i or k == i+7 and (i % 49 == 0 or i % 49 == 1 or i % 49== 7 or i % 49 == 42) then
						boolTouched= true
						showHideCube(k, true)
				   end		   
		   
		   
			if boolTouched== false then showHideCube(k, false) end
		end
	 end
   
end


function buildFactory()

    for i = 1, totalCubes, 1 do
        if fclvl1[i] == true then
            Show(cubes[i])
            Move(cubes[i], y_axis, 0, 0)
            Move(cubes[i], z_axis, 0, 0)
            Move(cubes[i], x_axis, 0, 0)
        end
    end

    for i = 1, totalCubes, 1 do
        if fcvlvl2[i] == true then
            Show(cubes[i])
            Move(cubes[i], y_axis, 0, 42)
            Move(cubes[i], z_axis, 0, 42)
            Move(cubes[i], x_axis, 0, 42)
        end
    end

    for i = 1, totalCubes, 1 do
        if fclvl1[i] == true and fcvlvl2[i] == false then
            Show(cubes[i])
            Move(cubes[i], y_axis, -350, 60)
        end
    end
end

function moveIntoPlace()
    buildFactory()
end


function script.Create()
    for i = 1, totalCubes, 1 do
        Hide(outerCubes[i])
        Hide(cubes[i])
        Move(cubes[i], y_axis, -600, 0)
        valx = math.random(-50, 50)
        valz = math.random(-50, 50)
        Move(cubes[i], x_axis, valx, 0)
        Move(cubes[i], z_axis, valz, 0)
    end
    StartThread(upGradde)
    StartThread(moveIntoPlace)
    --generatepiecesTableAndArrayCode(unitID)
end

function script.Killed(recentDamage, _)

    return 1
end