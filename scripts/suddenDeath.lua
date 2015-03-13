include "toolKit.lua"

function suddenDeath(unitID,recentDamage)
--<RubbleScript>
	if unitID and Spring.ValidUnitID(unitID)==true  then
	if recentDamage== nil or recentDamage > 1 then
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetGaiaTeamID()
	x=math.random(0,3)
	heapID=Spring.CreateUnit("gCScrapHeap",spx,spy,spz, x, teamID)
	Spring.SetUnitNeutral(heapID,true)
	--</RubbleScript>
	--<ciVillian>
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetGaiaTeamID()
	x=math.random(1,5)
	for i=1,x,1 do
	maRa=math.random(-1,1)
	heapID=Spring.CreateUnit("gCiVillian",spx+(150*maRa),spy,spz+(150*maRa),1, teamID)
	Spring.SetUnitMoveGoal (heapID, spx+1000,spy,spz+1000)  
	Spring.SetUnitNeutral(heapID,true)
	end

	--</ciVillian>
		else
		--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
		spx,spy,spz=Spring.GetUnitPosition(unitID)
		teamID=Spring.GetGaiaTeamID()
		x=math.random(0,3)
		heapID=Spring.CreateUnit("gCScrapHeapPeace",spx,spy,spz, x,1, teamID)
		Spring.SetUnitNeutral(heapID,true)
		end
	--</RubbleScript>	
	end

end

function suddenDeathVM(recentDamage)

	if recentDamage == nil or recentDamage > 1 then
		--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
		spx,spy,spz=Spring.GetUnitPosition(unitID)
		--teamID=Spring.GetUnitTeam(unitID)
		teamID=Spring.GetGaiaTeamID()
		--dirx,diry,dirz=Spring.GetUnitDirection(unitID)
		
		
		heapID=Spring.CreateUnit("gCVehicCorpseMini",spx,spy,spz, 1, teamID)
		--Spring.SetUnitDirection(heapID,dirx,diry,dirz)
		Spring.SetUnitNeutral(heapID,true)

	end 	

end

function suddenDeathV(recentDamage)

if recentDamage== nil or  recentDamage > 1 then

		Spring.PlaySoundFile("sounds/cVehicCorpse/xlarge.wav",1.0)
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	--teamID=Spring.GetUnitTeam(unitID)
	teamID=Spring.GetGaiaTeamID()
	--dirx,diry,dirz=Spring.GetUnitDirection(unitID)
	
	
	heapID=Spring.CreateUnit("gCVehicCorpse",spx,spy,spz, 1, teamID)
	--Spring.SetUnitDirection(heapID,dirx,diry,dirz)
	Spring.SetUnitNeutral(heapID,true)

end 	

end

function suddenDeathjBigCorpse(recentDamage)

if recentDamage== nil or  recentDamage > 1 then
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	--teamID=Spring.GetUnitTeam(unitID)
	teamID=Spring.GetGaiaTeamID()
	--dirx,diry,dirz=Spring.GetUnitDirection(unitID)
	dx,dy,dz=Spring.GetUnitDirection(unitID)
	heading=Spring.GetUnitHeading(unitID)
	heapID=Spring.CreateUnit("gJBigBioWaste",spx,spy,spz, 1, teamID)
	
	Spring.SetUnitDirection(heapID,dx,dy,dz)
	--Spring.SetUnitDirection(heapID,dirx,diry,dirz)
	Spring.SetUnitNeutral(heapID,true)

end 	


end

function suddenDeathjMedCorpse(recentDamage)

if recentDamage== nil or  recentDamage > 1 then
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	--teamID=Spring.GetUnitTeam(unitID)
	teamID=Spring.GetGaiaTeamID()
	--dirx,diry,dirz=Spring.GetUnitDirection(unitID)
	dx,dy,dz=Spring.GetUnitDirection(unitID)
	heading=Spring.GetUnitHeading(unitID)
	heapID=Spring.CreateUnit("gjmedbiogwaste",spx,spy,spz, 1, teamID)
	
	Spring.SetUnitDirection(heapID,dx,dy,dz)
	--Spring.SetUnitDirection(heapID,dirx,diry,dirz)
	Spring.SetUnitNeutral(heapID,true)

end 	


end


function suddenDeathjBuildCorpse(unitID, recentDamage)
teamID=Spring.GetUnitTeam(unitID)

if recentDamage and  recentDamage > 1 then
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	--teamID=Spring.GetUnitTeam(unitID)

	--dirx,diry,dirz=Spring.GetUnitDirection(unitID)
	dx,dy,dz=Spring.GetUnitDirection(unitID)
	heading=Spring.GetUnitHeading(unitID)
	heapID=0
	DefID=Spring.GetUnitDefID(unitID)
	DefT=getTreeTypeTable(UnitDefNames)
	
	if not DefT[DefID] then
	heapID=Spring.CreateUnit("jscrapheap",spx,spy,spz, 1, teamID)
	else
	heapID=Spring.CreateUnit("jscrapheap_tree",spx,spy,spz, 1, teamID)
	end
	Spring.SetUnitDirection(heapID,dx,dy,dz)
	--Spring.SetUnitDirection(heapID,dirx,diry,dirz)
	Spring.SetUnitNeutral(heapID,true)

end 	


end