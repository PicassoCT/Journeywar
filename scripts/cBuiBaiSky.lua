

include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

include "lib_Build.lua" 


local SIG_FIRE =1 
local SIG_CRANE =2
nrOfFires=13
fireemitters={}
for i=1,nrOfFires,1 do
	fireemitters[i]={}
	piecename= "fireEmit"..i
	fireemitters[i]=piece(piecename)
end

ArcoStump=piece"stump"
Blocks={}
for i=1,100 do
	name="Block"..i
	number= piece(name)
	if number then
	Blocks[#Blocks+1]=number
	end
	
end

NrOfPoints=0

buibaicity=piece"buibaicity"
center=piece"center"

local healthMax=0
local basisCostMetall=5
local basisCostEnergy=5
local DoneDamage=3

local boolwarstarted=false
local boolpeacestarted=true

local basicMetallStorage=0
local basicEnergyStorage=0
local NumberofFires=0
lastAttackingTeamID=nil
previouslyAttackingTeam=nil
boolDamaged=false
teamID=Spring.GetUnitTeam(unitID)



function nothingEverHappend(datTeamID)
	if datTeamID ~= teamID then boolDamaged=true end
	previouslyAttackingTeam=lastAttackingTeamID
	lastAttackingTeamID=datTeamID
	if not previouslyAttackingTeam then previouslyAttackingTeam=lastAttackingTeamID end
end

function SideEffects()
	if not 	GG.ScumSlumUpgrade then 	GG.ScumSlumUpgrade={}end
	
	IdTable={[UnitDefNames["scumslum"].id]=true}
	while true do
		--get builux nearby
		x,y,z=Spring.GetUnitPosition(unitID)
		T=getAllInCircle(unitID,x,z,512)
		if #T then 
			T=filterUnitTableforDefIDTable(T,IdTable)
			if #T then 
				
				for i=1,#T do
					GG.ScumSlumUpgrade[T[i]]=true
				end
			end
		end
		Sleep(1000)
	end
end

function investMent()
	while true do
		if boolDamaged== true then
			StartThread(fireEmit)
			if previouslyAttackingTeam then
				for i=1, 25, 1 do
					Spring.AddTeamResource(teamID, "metal",math.ceil(basicMetallStorage/15))
					Spring.AddTeamResource(teamID, "energy",math.ceil(basicEnergyStorage/15))
					Spring.UseTeamResource(previouslyAttackingTeam,"metal",math.ceil(basicMetallStorage*2/15))
					Spring.UseTeamResource(previouslyAttackingTeam,"energy",math.ceil(basicEnergyStorage*2/15))		
					Sleep(8000)
				end
			end
			boolDamaged=false	
		end
		Sleep(500)
		
	end
	
end

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
boolDelayedStart = true

return damage
end

function fireEmit()
	while(boolDamaged==true) do 
		for i=1, NrOfPoints,1 do
			EmitSfx(fireemitters[i],1025)
			EmitSfx(fireemitters[i],1026)
			if math.random(0,1)== 1 then EmitSfx(fireemitters[i],1027) end
			if math.random(0,1)== 1 then EmitSfx(fireemitters[i],1028) end
		end
		Sleep(60)
	end
end


function peaceLoop()
	SetSignalMask(SIG_PEACE)
	while(true) do
		energyRandom=math.ceil(math.random(0,5))
		metallRandom=math.ceil(math.random(0,5))
		
		
		boolMSuccess=	Spring.UseTeamResource(teamID,"metal",metallRandom)
		boolESuccess=	Spring.UseTeamResource(teamID,"energy",energyRandom)
		--boolESuccess-->TODO: Cost player basisCostEnergy + energyRandom
		--boolMSuccess<-->TODO: Cost player basisCostMetall + metallRandom
		if boolESuccess ~= nil and boolESuccess == true then
			basicEnergyStorage=basicEnergyStorage +basisCostEnergy+ energyRandom
		end
		if boolMSuccess ~= nil and boolMSuccess == true then
			basicMetallStorage=basicMetallStorage+basisCostMetall+metallRandom
		end
		Sleep(1000)
	end
end



function script.Killed(recentDamage)
	
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	Spring.CreateUnit("crewarder",math.random(1,x),y+500,math.random(1,z),0,teamID)
	if lastAttackingTeamID ~= nil then
		boolGotIt=Spring.UseTeamResource(lastAttackingTeamID,"metal",3900)
		boolGotIt2=Spring.UseTeamResource(lastAttackingTeamID,"energy",3900)
		if boolGotIt == false or boolGotIt2 == false then
			
			Spring.CreateUnit("crewarder",x,y+500,z,0,teamID)
			
		end
		
	end
	
	xrand=math.random(-2,2)
	yrand=math.random(-12,12)
	zrand=math.random(-3,3)
	Turn(buibaicity,x_axis,math.rad(xrand),0.02)
	Turn(buibaicity,y_axis,math.rad(yrand),0.2)
	Turn(buibaicity,z_axis,math.rad(zrand),0.02)
	Move(buibaicity,y_axis,-180,11)
	Timer=0
	while(true==Spring.UnitScript.IsInMove (buibaicity, y_axis)) do
		EmitSfx(center,1024)
		Sleep(120)
		Timer=Timer+1
		if Timer== 20 then
			Move(buibaicity,y_axis,-180,22)
		end
		if Timer== 28 then
			
			Move(buibaicity,y_axis,-180,44)
		end
		
		
	end
	suddenDeath(unitID,recentDamage)
	return 1
end

boolDelayedStart= false
function buildIt()

	while boolDelayedStart== false do
	Sleep(100)	
	end
	reseT(Blocks)
	hideT(Blocks)
	Hide(ArcoStump)

	
	if maRa()==true then
		Hide(buibaicity)
		Show(ArcoStump)	
		
		splits=math.ceil(math.random(2,6))
		tableOfTables={}

			gridTable={}
			freeSpotList={}
			for i= -3,3,1 do
				gridTable[i]={}
				for j=-3,3,1 do
					gridTable[i][j]={}
						
					if 	math.abs(i) %2 == 0 and 
						math.abs(j) %2 == 0  then

					gridTable[i][j][0]= true
					freeSpotList[#freeSpotList+1]={x=i,y= 0,z=j}			
					else
					gridTable[i][j][0]= false
					end
					
						
				end
			end
		
	
			createRandomizedBuilding(Blocks ,160 ,gridTable, freeSpotList, 22.5)			
		
		
		
	else 
		hideT(Blocks)
		Hide(ArcoStump)
		Show(buibaicity)
	end

	
end

function script.Create()
	StartThread(buildIt)
	--<buildanimationscript>
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	
	if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
	--GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
	--Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)
	
	--</buildanimationscript>
	StartThread(peaceLoop)
	StartThread(investMent)
	StartThread(SideEffects)
	Hide(cg)
	Spring.AddUnitDamage(unitID,10)
end
--------BUILDING---------