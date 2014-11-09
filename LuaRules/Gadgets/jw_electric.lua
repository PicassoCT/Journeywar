
     
    function gadget:GetInfo()
    return {
    name = "Electric Barriers",
    desc = "Handles the Wallbuilder electrifying the E-Fence Walls and JourneyShield",
    author = "PicassoCT",
    date = "Oh, you wish, you had it with this file - but she got class",
    license = "GNU GPL, v2 its goes in all fields",
    layer = 0,
    enabled = true -- loaded by default?
    }
    end
     
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     
    -- synced only
  if (gadgetHandler:IsSyncedCode()) then

     

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     

    local boolGameIsNotOver=true
    local UPDATE_FREQUNECY=60
    local rangeOfElectricity=200
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     
    local UnitDefIDTable={}
     UnitDefIDTable[1]=UnitDefNames["efence"].id
     UnitDefIDTable[2]=UnitDefNames["beanstalk"].id
     UnitDefIDTable[3]=UnitDefNames["citadell"].id
     UnitDefIDTable[4]=UnitDefNames["cwallbuilder"].id
     
    local unifiedUnitTable={}
     --Example:
	    --1
		--1
		--Efence
		--50
		--50
		--[1]=true (the unit is obviously connected with itself (beeing the first unit in the table)
	 
    --by convention everything stored in the four tables above follows the following subtable-order
    -- 1: UnitID
    -- 2: UnitTeam  -- necessary to avoid strange side-effects like the Efence overloading teammates defenseshields
    -- 3: UnitDefID --yes, i could have used a enumeration, but this makes it upwards compatible
    -- 4: X-Coordinate
    -- 5: Z-Coordinate
    -- 6: The chargedUnits Connection Matrice Column
     -- a boolean Matrice whos purpose is to store any unit recived - twice- and thus 
	 -- mark via a boolean expression any unit that is connected to it
     
     
     
    ----------------------------------------------------------------------------------------
    local previousResult
    local previousCubic
    local rangeOfOld = -1
	-- search in Table, organized in the unifiedUnitTable way
	
	   function electrifyUnit(idInQuestion,boolischarged)
	
				   
					  ------Spring.Echo("Type: ", type(idInQuestion))
					local env = Spring.UnitScript.GetScriptEnv(idInQuestion)
					  if env and env.chargeUp then
					  Spring.UnitScript.CallAsUnit(idInQuestion, env.chargeUp, 	boolischarged )		
					  else
					  ------Spring.Echo("Imphailed")
					  end
           
    end
	
    --Function: presumes a coordinatesystem, based upon the comparePointX && ComparePointZ as the Origin
    function withinRange(circleRange,xCoord,zCoord)

newCubic=0
	if rangeOfOld == circleRange then
	newCubic=previousCubic
	else
	newCubic= 0.7071067811865475*circleRange
	previousCubic=newCubic
	end

negCircleRange=-1*circleRange

	--checking the most comon cases   |Coords Outside the Circlebox
			if xCoord > circleRange or xCoord < negCircleRange then
			return false
			end

					if zCoord >circleRange or zCoord <negCircleRange then
					return false
					end

negNewCubic=-1* newCubic


							--checking everything within the circle box
							if (xCoord < newCubic and xCoord > negNewCubic) and (zCoord < newCubic and zCoord > negNewCubic) then
							return true
							end


-- very few cases make it here.. to the classic, bad old range compare
secondRange=math.sqrt(xCoord^2 +zCoord^2)

if secondRange < circleRange then 
return true 

else 
return false
end

end
    
	

    function updateConnectionTable()
            for i=1,table.getn(unifiedUnitTable),1 do
			
			--Spring.Echo("updateConnectionTable"..unifiedUnitTable[i][3])
			--if and only if units is a wallbuilder
				if unifiedUnitTable[i][3]== WALLBUILDERDEFID then
				 --Spring.Echo("WallBuilder Position Update called")
						--update Position
						x,y,z=Spring.GetUnitPosition(unifiedUnitTable[i][1])
						unifiedUnitTable[i][4]=x
						unifiedUnitTable[i][5]=z
						
				end
								--recalculate the adjazenzMatrice table.. for all units
								unifiedUnitTable[i][6]={}
								for j=1,table.getn(unifiedUnitTable),1 do		
								
									if i~=j and withinRange(rangeOfElectricity,unifiedUnitTable[j][4]-unifiedUnitTable[i][4],unifiedUnitTable[j][5]-unifiedUnitTable[i][5])== true then
									unifiedUnitTable[i][6][unifiedUnitTable[j][1]]=true
									
									--DelMe
									if unifiedUnitTable[i][3]== WALLBUILDERDEFID then			
									--Spring.Echo("WallBuilder "..i.." is connected to unit "..j.." :")
									end
									--DelMe
									
									end
								end       
								
		
			end
     end
     
    --func returns index of the unit in table.. carefull with that.. can change if units are removed in the process
    function findUnitOfType(UnitDefIdIndex)
	------Spring.Echo("FindUnitOfType")
    temp_O_Rary={} --another drunk Irish Variable -- on the rocky road to Dublin
            for i=1,table.getn(unifiedUnitTable),1 do
                    if unifiedUnitTable[i][3]==UnitDefIDTable[UnitDefIdIndex] then
                    temp_O_Rary[#temp_O_Rary+1]=unifiedUnitTable[i][1]
                    end
            end
    return temp_O_Rary
    end
     
	--be carefull to call this before you update the positions and connections
    function removeUnit(handedOverID)
		for i=1, table.getn(unifiedUnitTable),1 do
			if unifiedUnitTable[i] and unifiedUnitTable[i][1]==handedOverID then
			table.remove(unifiedUnitTable,i)
			end
		end       
           
    end
     

	--function: This function registrates any unit of interest into the unified unit table 
    function genericRegistration (thisID,unitTeam,unitDefID)
	unifiedUnitTable[#unifiedUnitTable+1]={}
	
	assert(unitDefID)
									unifiedUnitTable[#unifiedUnitTable][1]=thisID
									unifiedUnitTable[#unifiedUnitTable][2]=unitTeam
									unifiedUnitTable[#unifiedUnitTable][3]=unitDefID
									
									
									x,y,z 		= Spring.GetUnitPosition(thisID)
									unifiedUnitTable[#unifiedUnitTable][4]=x
                                    unifiedUnitTable[#unifiedUnitTable][5]=z
									
									--Units this Unit is connected too
									aEmptyTable={}
												for i=1,(table.getn(unifiedUnitTable)),1 do
													if withinRange(rangeOfElectricity,unifiedUnitTable[i][4]-x,unifiedUnitTable[i][5]-z) == true then
													aEmptyTable[unifiedUnitTable[i][1]]=true
													end	
												end

                                  unifiedUnitTable[#unifiedUnitTable][6]=aEmptyTable
								 
                   
    end
	
	function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
		if cWallBuilderTable[unitID] then 
		cWallBuilderTable[unitID]=nil 
		wallbuildCounter=wallbuildCounter-1
		end
		if electrifyAbleUnits[unitID] then electrifyAbleUnits[unitID]=nil end
	
	end
		
	--all the Wallbuilders
		cWallBuilderTable={} 
		wallbuildCounter=0
        electrifyAbleUnits={}
	
	 WALLBUILDERDEFID= UnitDefNames["cwallbuilder"].id
	 EFENCEDEFID= UnitDefNames["efence"].id
	 BEANSTALKDEFID=UnitDefNames["beanstalk"].id
	 CITADELLDEFID=  UnitDefNames["citadell"].id
    
	--registrates all the elctrified Units
    function gadget:UnitCreated(unitID, unitDefID, unitTeam)
    
	if unitDefID==WALLBUILDERDEFID then
                    --Spring.Echo("Wallbuilder registrated")
					wallbuildCounter=wallbuildCounter+1
					cWallBuilderTable[unitID]=#unifiedUnitTable+1
                    genericRegistration (unitID,unitTeam,unitDefID)
                
				elseif  unitDefID== EFENCEDEFID or unitDefID== BEANSTALKDEFID or unitDefID== CITADELLDEFID then
           
                            --Spring.Echo("efence registrated")
							electrifyAbleUnits[unitID]=#unifiedUnitTable+1
                            genericRegistration (unitID,unitTeam,unitDefID)
							end
     
                                   
     
     
    end
     
--checks for livesigns in everyUnit
    function validateUnitTable()
	 ------Spring.Echo("validateUnitTable")
	for i=1,table.getn(unifiedUnitTable),1 do
           
                    if unifiedUnitTable[i][1] and Spring.ValidUnitID((unifiedUnitTable[i][1]))~=true then
                    removeUnit(unifiedUnitTable[i][1])
                    x=x-1
                    i=i-1
                    end
            end 
    end
    
	function findUnitInUnifiedUnitTable(unitid)
		for i=1,#unifiedUnitTable do
			if unifiedUnitTable[i][1]==unitid then 
			return i 
			end	
		end	
	end
	

	
    function roastBeef()
		--Spring.Echo("unifiedUnitTable"..#unifiedUnitTable)
		
            if unifiedUnitTable and table.getn(unifiedUnitTable)> 0 then
                    --Get List of Wallbuilders
                    --Validate List of Wallbuilders -- so only existing Units are parsed
                      validateUnitTable()
                   
                    --Get List of Wallbuilders Validate List of Wallbuilders -- so only existing Units are parsed
                    updateConnectionTable()
                   
           
                    if cWallBuilderTable and wallbuildCounter > 0 then
					--Spring.Echo("Wallbuilders there")
							   local unitsToBeCharged={}
									
								for k,v in pairs(cWallBuilderTable) do
								
								if unifiedUnitTable[v] and unifiedUnitTable[v][6] then
									for ik,_ in pairs(unifiedUnitTable[v][6]) do
										unitsToBeCharged[ik]=true
									end
								end
								end
								
								--we found the 							
								boolAddedNewUnits=true
								 newlyAddedUnitsPool={}
								 newlyAddedUnitsPool=unitsToBeCharged
								 tempUnitPool={}
								
								while boolAddedNewUnits == true do
								boolAddedNewUnits=false
								unitsAdded=0
									for k,_ in pairs(newlyAddedUnitsPool) do
									nr=findUnitInUnifiedUnitTable(k)
						
											if nr then 
											--we get all the Units this one is connected too
												for ak, _ in pairs(unifiedUnitTable[nr][6]) do
												if k ~= ak and  unitsToBeCharged[ak] == nil and  newlyAddedUnitsPool[ak] == nil then
												tempUnitPool[ak]=true
												unitsAdded=unitsAdded+1
												boolAddedNewUnits=true
												end
												end	
											end
										--Spring.Echo("unitsToBeCharged->UnitsAdded"..unitsAdded)
									end	
									--we transfer the new newlyAddedUnitsPool into the unitsToBeCharged
									unitsToBeCharged=mergeTwoKeyTables(unitsToBeCharged,newlyAddedUnitsPool)
									newlyAddedUnitsPool=tempUnitPool
									tempUnitPool={}
								end
									
													if unitsToBeCharged  then
															for k,v in pairs(electrifyAbleUnits) do
																if unitsToBeCharged[k] then 
																electrifyUnit(k,true) 
																else
																electrifyUnit(k,false)		
																end
															end
																			
												else
												--case no wallbuilders in the list
													
													for k,v in pairs(electrifyAbleUnits) do
													electrifyUnit(k,false)											
													end
													
												end
             end
			end
  end
  
            function gadget:GameFrame(f)
                      if f%UPDATE_FREQUNECY == 0 then
                      roastBeef()
                      end
            end
			
			
			function mergeTwoKeyTables(A,B)
				for k,v in pairs(B) do
				if not A[k] then A[k]=v end
				end
			return A
			end
     
end
	
	