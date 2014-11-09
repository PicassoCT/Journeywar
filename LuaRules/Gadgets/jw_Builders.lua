
	function gadget:GetInfo()
	return {
	name = "Bob The Builder ",
	desc = "Sets builders too work at full auto",
	author = "FireStorm",
	date = "7 b.Creation",
	license = "GNU GPL, v2 its goes in all fields",
	layer = 0,
	enabled = true -- loaded by default?
	}
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	-- synced only
if (gadgetHandler:IsSyncedCode()) then
	function findNearestUnit(x,z,tableOfUnits)
	distances=1  				--SmallestDistance

	tx,ty,tz=Spring.GetUnitPosition(tableOfUnits[1])
	smallestDistanceSoooFar=math.sqrt((x-tx)^2+(z-tz)^2)
	
	for i=1,#tableOfUnits,1 do
	tx,ty,tz=Spring.GetUnitPosition(tableOfUnits[i])
	tdistance=math.sqrt((x-tx)^2+(z-tz)^2)
		if tdistance < smallestDistanceSoooFar then
		distances=i
		smallestDistanceSoooFar=tdistance
		end
	
	
	end
	return tableOfUnits[distances]
	end
	--Every unit signs up, is checked for its UnitdefId beeing that of a WaterAdder or a WaterSubstractor
	function gadget:UnitCreated(unitID, unitDefID, unitTeam)

		if unitDefID==UnitDefNames["condepot"].id or unitDefID==UnitDefNames["eggstackfac"].id  then
		temp_O_RaryC={}
		temp_O_RaryJ={}
		temp_O_RaryC=Spring.GetTeamUnitsByDefs(unitTeam,UnitDefNames["citadell"].id)
		temp_O_RaryJ=Spring.GetTeamUnitsByDefs(unitTeam,UnitDefNames["beanstalk"].id)

	
		x,y,z=Spring.GetUnitPosition(unitID)
		
			if temp_O_RaryC and table.getn(temp_O_RaryC) > 0 then
			nearest=findNearestUnit(x,z,temp_O_RaryC)
			
			
				if nearest then
				
			
						Spring.GiveOrderToUnit(unitID,CMD.GUARD,{nearest}, {"shift"})
				end
			end
			
			
			if temp_O_RaryJ and table.getn(temp_O_RaryJ) > 0 then
				nearest=findNearestUnit(x,z,temp_O_RaryJ)
			
			
					if nearest then
					   Spring.GiveOrderToUnit(unitID, CMD.GUARD  , {nearest}, {"shift"}) 
					end
			
			end
		
		
		end

	

	end


end



