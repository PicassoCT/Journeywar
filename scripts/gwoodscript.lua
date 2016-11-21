include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

RECURSIVE_FORREST_MAX= 768
ForrestDiameter=  90


wood={}
for i=1,13,1 do
	wood[i]=piece(("Wood"..i))
end

defID= Spring.GetUnitDefID(unitID)

boolIsRecursiveWood= (defID == UnitDefNames["grecforrest"].id)

function script.Create()
	for i=1,#wood,1 do
		Hide(wood[i])
		rot=math.random(0,360)
		Turn(wood[i],y_axis,math.rad(rot),0)
		
		multiplicator=1
		if i>11 then multiplicator = 5 end
		val=math.random(-4,4)*multiplicator
		Turn(wood[i],x_axis,math.rad(val),0)
		val=math.random(-4,4)
		Turn(wood[i],z_axis,math.rad(val),0)
	end
	Move(wood[1],y_axis,-120,0)
	
	val=math.ceil(math.random(1,#wood))
	Show(wood[val])
	if math.random(0,1)==1 then 
		val=math.ceil(math.random(1,#wood))
		Show(wood[val])
	end
	Move(wood[1],y_axis,-10,	2.9)
	if boolIsRecursiveWood== true then
		StartThread(recursiveForrest)
		StartThread(delayedKickOff)
	end
end


function delayedKickOff()
Sleep(25)
boolDelayedKickOff=true
end
searchAccessor1x1= getTableAccessor(1,1, true)

function slopeChecker(posX, posZ)
	boolSlipperySlope=false
	for i=1,#searchAccessor1x1 do
		dx,dy,dz,slope = Spring.GetGroundNormal(	posX+ searchAccessor1x1[i].x*ForrestDiameter/2 ,
		posZ+ searchAccessor1x1[i].z*ForrestDiameter/2)
		
		boolSlipperySlope= boolSlipperySlope or (dy < 0.72)
	end
	return boolSlipperySlope
end
 mapX= Game.mapSizeX*512
 mapZ= Game.mapSizeZ*512
 
function getMapChecked(posX,posZ)
return(posX > ForrestDiameter*2 and posX < mapX-ForrestDiameter*2  and posZ > ForrestDiameter*2 and posZ < mapZ-ForrestDiameter*2)
end

function recursiveForrest()
	while boolDelayedKickOff==false do 
		Sleep(10)
	end
	Sleep(350)
	if not GG.RecursiveForrestCounter then GG.RecursiveForrestCounter = 1 end
	if GG.RecursiveForrestCounter > RECURSIVE_FORREST_MAX then return end
	teamID=Spring.GetUnitTeam(unitID)
	
	ux,_,uz=Spring.GetUnitPosition(unitID)
	searchAccessor= getTableAccessor(3,3, true)
	for i=1, #searchAccessor do
		Sleep(GG.RecursiveForrestCounter)
			posX= ux + searchAccessor[i].x* (ForrestDiameter*2)
			posZ= uz + searchAccessor[i].z* (ForrestDiameter*2)
		if searchAccessor[i].x~= 0 or searchAccessor[i].z ~= 0 and getMapChecked(posX,posZ)== true then
			--if condition is fullfilled 

		
			--get Positions- check wether there is allready forrest
			T= getAllInCircle(posX,posZ,ForrestDiameter)
			
	--yes, i missed LINQ
	process(T,
			function(id)
				typeOfUnit=Spring.GetUnitDefID(id)
				if typeOfUnit == defID then return id end
			end
			)
			
			--no water and the terrain is not to steep
			if #T == 0 and Spring.GetGroundHeight(posX,posZ) > 1 then
		
				randoVal= math.random(0,3)> 1
				if slopeChecker(posX, posZ)== false and GG.RecursiveForrestCounter <	RECURSIVE_FORREST_MAX and randoVal== true  then
					echo("grecforrest::"..3)
					posX=posX + math.random(1,ForrestDiameter/3)*randSign()
					posZ=posZ + math.random(1,ForrestDiameter/3)*randSign()
					
					GG.UnitsToSpawn:PushCreateUnit("grecforrest",posX,0,posZ,0,teamID)
					GG.RecursiveForrestCounter=GG.RecursiveForrestCounter+1
				end
			end
		end
	end
	
	if math.random(0,12) < 3 then 
	Spring.DestroyUnit(unitID,true, false) 
	GG.RecursiveForrestCounter=GG.RecursiveForrestCounter-1
	end
	
	
end

function script.Killed(recentDamage,_)
	return 1
end