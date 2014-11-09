

function gadget:GetInfo()
  return {
    name      = "TacZone",
    desc      = "Advanced programable commands",
    author    = "!jk - first. Im first. It can be done. Picasso",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,	
	version = 1,    
    enabled   = true,
  }
end



	if (gadgetHandler:IsSyncedCode()) then
	local MasterTable={}
	local AZ=UnitDefNames["actionzone"].id
	local TZ=UnitDefNames["triggerzone"].id
	local RZ=UnitDefNames["reservoirzone"].id
	local RESERVOIRSIZE=320
	local TRIGGERSIZE=320
	local teams=Spring.GetTeamList()
	local Zone={}
    local ReservoirToAction={}
	local TriggerToAction={}
	
	local teamIDToNumber={}
	for i=1,#teams, 1 do
	teamIDToNumber[teams[i]]={}
	teamIDToNumber[teams[i]]=i
	end
	
	
	function init()

		if teams then
		Spring.Echo("JW_TriggerZone::Init")
		
			for i=1,#teams, 1 do											
			MasterTable[teamIDToNumber[teams[i]]]={}	
			MasterTable[teamIDToNumber[teams[i]]][1]={}	   	--RESERVOIRS	--every Reservoire has a List of Unit
			MasterTable[teamIDToNumber[teams[i]]][2]={}		--ACTION		--every ActionZone has a List of ReservoirZones
			MasterTable[teamIDToNumber[teams[i]]][3]={}		--TRIGGER		-every Trigger has a Actionzone it guards	
			end
	
		else
		Spring.Echo("JW_TriggerZone::NoTeamsDefined")
		return false
		end
	return true
	end	
	
	function transferCommandsToReservoir (ActionZone)
		if ActionZone then
		local 	CommandTable={}
		CommandTable=Spring.GetUnitCommands(ActionZone)
			if CommandTable then
			local x,y,z=Spring.GetUnitPosition(ActionZone)
					for RZID,AZID in pairs(ReservoirToAction) do
						if AZID == ActionZone then
						  ArrayOfUnits={}
						  ArrayOfUnits= getGuardingUnits(RZID)
						  table.remove(ArrayOfUnits,RZID)
							if ArrayOfUnits then
															
											--we remove the 
											
											for i=1,#ArrayOfUnits, 1 do
											
												Spring.GiveOrderToUnit(ArrayOfUnits[i], CMD.STOP,{}, {} )									
											end		
										
											for _,cmd in ipairs(CommandTable) do									
												Spring.GiveOrderToUnitArray(ArrayOfUnits,cmd.id,cmd.params,{"shift"})
											end	
											
											for i=1,#ArrayOfUnits, 1 do
												Spring.GiveOrderToUnit(ArrayOfUnits[i], CMD.WAIT, {}, {"shift"})
												Spring.GiveOrderToUnit(ArrayOfUnits[i], CMD.WAIT, {}, {})		
											end	
																	
							end
						end
					end
			end
		end
	end
	     	
	function triggerHappy(self)
		enemyID=Spring.GetUnitNearestEnemy(self)
			if enemyID then
			xo,yo,zo=Spring.GetUnitPosition(self)
			x,y,z=Spring.GetUnitPosition(enemyID)
			x,y,z=x-xo,y-yo,z-zo
			 
			dist=math.sqrt(x*x+z*z)
			if dist < TRIGGERSIZE then 
			Spring.Echo("JW_TriggerZone::TriggerHappy") 
			return true
				else 
				Spring.Echo("JW_TriggerZone::TrigerSad")
				return false
				end
			--Spring.Echo("JW_TriggerZone:TriggerDepressed")
			end
	return false
	end					 
		 
	---- /////////////////////////////////// ZONEFUNCTIONS
	function addReservoireZone(unitID,unitDefID,teamID)
	
		if MasterTable[teamID][1] == nil then MasterTable[teamID][1]={} 	end
		MasterTable[teamID][1][unitID] = unitID
		end
					
	function addActionZone(unitID,unitDefID,teamID)
			if MasterTable[teamID][2] == nil then MasterTable[teamID][2]={}	end
			MasterTable[teamID][2][unitID] = unitID
			end	
		
	function addTriggerZone(unitID,unitDefID,teamID)
			if MasterTable[teamID][3] == nil then MasterTable[teamID][3]={} 	end
			MasterTable[teamID][3][unitID] = unitID	
			end		
	---- /////////////////////////////////// ZONEFUNCTIONS
		
	function removeUnit(id,tableIT)
			for _,v in pairs(tableIT) do
				if v== id then
				tableIT[v]= nil
				end
			end
		return tableIT	
		end

		
	function getGuardingUnits(RZone)
		teamID=Spring.GetUnitTeam(RZone)
		x,y,z=Spring.GetUnitPosition(RZone)
		unitList={}
		tables={}
			if x then
			tables=Spring.GetUnitsInRectangle(x-RESERVOIRSIZE,z-RESERVOIRSIZE,x+RESERVOIRSIZE,z+RESERVOIRSIZE)
				table.remove(tables,RZone)
				if tables and table.getn(tables)>1 then 
		
					for i=1,#tables,1 do
					comAndConq={}
					comAndConq=Spring.GetUnitCommands(tables[i])
						for _,cmd in ipairs(comAndConq) do
								if cmd.id == CMD.GUARD and tables[i]~= RZone then
								unitList[#unitList+1]=tables[i]
								end
						end					
					end
				end
			end
		return unitList
		end
			
	function gadget:UnitCreated(unitID, unitDefID, teamID)
			if unitDefID==AZ or unitDefID== RZ or unitDefID== TZ then
			teamID=teamIDToNumber[teamID]
			Spring.Echo("JW_TriggerZone::UnitRegistrated")
				--Registrate Unit	
				if unitDefID==AZ then
				addActionZone(unitID,unitDefID,teamID)
				end	
				if unitDefID==RZ then
				addReservoireZone(unitID,unitDefID,teamID)
				end	
				if unitDefID==TZ then
				addTriggerZone(unitID,unitDefID,teamID)
				end
	
			end
		end

		
		boolChanges=false
	function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
			if unitDefID==AZ or unitDefID== RZ or unitDefID== TZ then
			teamID=teamIDToNumber[teamID]
			boolChanges=true
			--Spring.Echo("JW_TriggerZone::ZoneDestroyed")
			
					--Registrate Unit	
					if unitDefID==AZ then
						
						
						for id,ad in pairs(ReservoirToAction) do
							if ad== unitID then
							ReservoirToAction[ad]=nil
							end
						end	
							MasterTable[teamID][2][unitID]=nil
					end	
					
					if unitDefID==RZ then
						MasterTable[teamID][1][unitID]=nil
					--always check if Reservoir still exists
					
					end	
					if unitDefID==TZ then
					TriggerToAction[unitID]=nil
					MasterTable[teamID][3][unitID]=nil					
					end	
			end
		end
		
	function tprint (tabld, indent)
		if not indent then indent = 0 end
			if tabld == nil  then 
			--Spring.Echo("Nil value at table")
			return end
			local tbl=tabld
			
		for k, v in ipairs(tbl) do
		formatting = string.rep(" ", indent) .. k .. ": "
			if type(v) == "table" then
			print(formatting.."-[]")
			tprint(v, indent+1)
				else
					if v ~= true and v~= false then
					print(formatting .. v)
					end
				end
		end
		
		end
		
	function 	getGuardedUnit(id)
					if id == nil or Spring.GetUnitIsDead(id)== true then
					--Spring.Echo("Unit is gone".. id)
					return {} 
					end
			
				local t=Spring.GetUnitCommands(id)

					 for tid,cmd in ipairs(t) do

						 if cmd.params then
									if cmd.id == CMD.GUARD and cmd.params[1] then
									--Spring.Echo("Got a Guarded Actionzone.."..(cmd.params[1]))
									return cmd.params[1]
									end
						end
					 end
		end
	
function getKeyN(myTable)
	numItems = 0
	for k,v in pairs(myTable) do
		numItems = numItems + 1
	end
	return numItems
end
	
	
		boolInit=false
	function gadget:GameFrame(frame) 
			if frame % 100 == 0 and boolInit==true then
			----Spring.Echo("JW_TriggerZone::Update")
			--Check Reservoire and TriggerZones for new Guarded Actionzones
				for i=1,#teams, 1 do	
				var=0				
				
				
				
		--	--Spring.Echo("JW_TriggerZone:: "..var)
		var=var+1
				if not teams or teams[i] == nil then break end		
		--	--Spring.Echo("JW_TriggerZone:: "..var)
		var=var+1
				--		
				local teamid=teamIDToNumber[teams[i]]
						
				if getKeyN(MasterTable[teamid][1]) ~= 0 or getKeyN(MasterTable[teamid][2])~= 0 or getKeyN(MasterTable[teamid][3])~=0 then
						--Spring.Echo("-------------------------------------")	
						--Spring.Echo("teamid  "..teamid)	
						--Spring.Echo("getKeyN(MasterTable[teamid]  "..getKeyN(MasterTable[teamid]))	
						--Spring.Echo("#MasterTable[teamid][1]  "..getKeyN(MasterTable[teamid][1])	)
						--Spring.Echo("#MasterTable[teamid][2]  "..getKeyN(MasterTable[teamid][2])	)
						--Spring.Echo("#MasterTable[teamid][3]  "..getKeyN(MasterTable[teamid][3])	)
						--Spring.Echo("#ReservoirToAction  "..getKeyN(ReservoirToAction))	
						--Spring.Echo("#TriggerToAction  "..getKeyN(TriggerToAction)	)
						--Spring.Echo("-------------------------------------")	
				end
					if teamid and MasterTable[teamid] and MasterTable[teamid][3] then
						for _,id in pairs(MasterTable[teamid][3]) do
							APT=getGuardedUnit(id)
							--Spring.Echo("ActioZonePointedTowards",APT)
								if APT then
								TriggerToAction[id]=APT
								----Spring.Echo("JW_TriggerZone::Update Trigger - ActionZone")
								end						
						end				
					end
		--	--Spring.Echo("JW_TriggerZone:: "..var)
		var=var+1
				----Spring.Echo("JW_TriggerZone::Update ActionZonesList Reservoirs")	
				
				for _,id in pairs(MasterTable[teamid][1]) do
					if id then					
					ActionZoneID= getGuardedUnit(id)
						if ActionZoneID then
					
						--	--Spring.Echo("JW_TriggerZone:: "..var)
							var=var+1
							
							for _,cid in pairs(MasterTable[teamid][2]) do
								if cid == ActionZoneID then		
								ReservoirToAction[id]=cid
								break							
								end
							end
						end
					end
				end
			
				--	--Spring.Echo("JW_TriggerZone:: "..var) --3
				var=var+1			

			--Check the Triggers for Activity
			
				-- the Trigger is Active
				for di,id in pairs(MasterTable[teamid][3]) do
						var=var+1
					if triggerHappy(id,teamid)==true and TriggerToAction[id] then
						Spring.Echo("JW_TriggerZone::Transerfing Comands to Reservoir")	
						transferCommandsToReservoir(TriggerToAction[di],teamid)		
					end	
				end						
						
				end				
			
			end
		
			if  boolInit==false and frame%10==0 then		
			--Spring.Echo("Init")
			boolInit=init()
			end
		
		
	end

	end
	