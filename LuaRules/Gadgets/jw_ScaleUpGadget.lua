
function gadget:GetInfo()
   return {
      name = "JW_ScaleUpGadget::",
      desc = "Make mobile units grow and shrink",
      author = "zwzsg",
      date = "21st of March 2013",
      license = "Free, wishing for a benevolent dicatorship, cause instinctarded. To value luarulesdom, you got to be able to use it.",--Janus License- under Software Patent Nr. 23432-756F-11-2014 held by the FSF for commercial purposes, under GPL for non-commercial usage
      layer = 0,
      enabled = true
   }
end


if (gadgetHandler:IsSyncedCode()) then
	
	 JBUILDANIM="NOTYPE"

	--all units that are buildings
	jBuilding={
	[UnitDefNames["jswiftspear"].id]=true,
 	[UnitDefNames["jmovingfac1"].id]=true,	
	[UnitDefNames["jdrilltree"].id]=true,
	[UnitDefNames["eggstackfac"].id]=true,
	[UnitDefNames["jtree"].id]=true,
	[UnitDefNames["jtree2"].id]=true,
	[UnitDefNames["jtree3"].id]=true,
	[UnitDefNames["jgeohive"].id]=true,
	[UnitDefNames["jwatergate"].id]=true,
	[UnitDefNames["jfireflower"].id]=true,
	[UnitDefNames["jbeehive"].id]=true,
	[UnitDefNames["jfungiforrest"].id]=true,
	[UnitDefNames["jnativevil"].id]=true,
	[UnitDefNames["jtreel"].id]=true,
	[UnitDefNames["jabyss"].id]=true	
				}
				


   DefTypeTable={
   [UnitDefNames["jswiftspear"].id]=true,
   [UnitDefNames["jbeherith"].id]=true,
   [UnitDefNames["jsungodcattle"].id]=true,
   [UnitDefNames["cawilduniverseappears"].id]=true,
   [UnitDefNames["ghohymen"].id]=true,
   [UnitDefNames["jvaryfoo"].id]=true,
   [UnitDefNames["jspacebornembryo"].id]=true,
   [UnitDefNames["gseastar"].id]=true
   }
   
   jBuildAnimDefID=UnitDefNames["jbuildanim"].id
   SyncedDataTable={}-- Table that contains some data about some units
   scaleTable={}
   LastSetBuildAnim={}
   jWorkInProgress={}
   buildList={}
   
   local spValidUnitID= Spring.ValidUnitID
 
   
    function gadget:UnitCreated(unitID, unitDefID, unitTeam)
		if DefTypeTable[unitDefID] then --unitDefID== UnitDefNames["tiglil"].id  or unitDefID== UnitDefNames["skinfantry"].id  or 
			boolPulse=false
			StartScale=0.06
		--	if unitDefID== UnitDefNames["tiglil"].id  or unitDefID== UnitDefNames["skinfantry"].id then StartScale=0.52 end
			
			ScaleFactorProFrame=0.001
	
			ScaleUpLimit=1
			if unitDefID== UnitDefNames["gseastar"].id then ScaleFactorProFrame= 0.003 		end --or unitDefID== UnitDefNames["tiglil"].id  or unitDefID== UnitDefNames["skinfantry"].id 	
			if unitDefID== UnitDefNames["jswiftspear"].id then ScaleFactorProFrame=0.001 		end --or unitDefID== UnitDefNames["tiglil"].id  or unitDefID== UnitDefNames["skinfantry"].id 	
			if unitDefID== UnitDefNames["jbeherith"].id 	then ScaleFactorProFrame=0.0005 	end
			if unitDefID== UnitDefNames["jsungodcattle"].id then ScaleFactorProFrame=0.0006 	end
			if unitDefID== UnitDefNames["jspacebornembryo"].id then 
			ScaleFactorProFrame=0 
			boolPulse=true	
			end
			
			if unitDefID== UnitDefNames["cawilduniverseappears"].id then 
			ScaleFactorProFrame=0.05 
			ScaleUpLimit=3.14159
			end
			
			if unitDefID== UnitDefNames["ghohymen"].id then 		
			ScaleFactorProFrame=0.0005
			ScaleUpLimit=2.14159
			end
			
			if unitDefID== UnitDefNames["jvaryfoo"].id then 		
			ScaleFactorProFrame=0.0005
			ScaleUpLimit=3.14159
			end
			
			scaleTable[unitID]={ scale=StartScale ,factor=ScaleFactorProFrame,utype=unitDefID,uid=unitID, scaleLimit=ScaleUpLimit, pulse=boolPulse}
	
			
		-- Here the chosen units will be all moving unit. Put your own filter obviously!
				-- The key is the unitID
			-- The value must be something else than false and nil
			SyncedDataTable[unitID]={}
			SyncedDataTable[unitID]={ birth=unitID+  Spring.GetGameFrame() }
			-- Here I put as value a table with the time of birth, but could be anything
	
		end
		--if journeybuild animation
	  	 if jBuilding[unitDefID] then
		 --Spring.Echo("JourneyBuilding Inserted")
	
		 x,y,z=Spring.GetUnitPosition(unitID)
		 GG.UnitsToSpawn:PushCreateUnit("jbuildanim",x,y,z+4,0,unitTeam)
	
		 
		LastSetBuildAnim[#LastSetBuildAnim+1]={unitID=unitID, unitDefID=unitDefID, unitTeam=unitTeam,birth=Spring.GetGameFrame()}		
		 end	
		 
		 if unitDefID == jBuildAnimDefID then		 
		 buildList[unitID]=LastSetBuildAnim[#LastSetBuildAnim]
		 table.remove(LastSetBuildAnim,#LastSetBuildAnim)
		 end
	  
   end
   
	function gadget:UnitDestroyed(unitID, unitDefID)
      -- Never forget to delete data about dead units!
      -- Or else your tables will slowly grow during game with huge amount of useless data!
      if SyncedDataTable[unitID] then
	  --Spring.Echo("jw_ScaleUPGadget::", SyncedDataTable[unitID])
         SyncedDataTable[unitID]=nil
         SendToUnsynced("UnsetScale",unitID)
      end
   end
   
   --All units that do a constant scaling up
	local UnitsScaling={	
		[UnitDefNames["jswiftspear"].id] 			=true,
		[UnitDefNames["jbeherith"].id] 				=true,
		[UnitDefNames["jsungodcattle"].id] 			=true,
		[UnitDefNames["cawilduniverseappears"].id]	=true,
		[UnitDefNames["ghohymen"].id]				=true,
		[UnitDefNames["jspacebornembryo"].id]		=true
						}
						
	local VARYFOODEFID= UnitDefNames["jvaryfoo"].id
	local SUNGODCATTLEDEFID= UnitDefNames["jsungodcattle"].id
	local EMBRYODEFID= UnitDefNames["jspacebornembryo"].id
	local spGetUnitHealth=Spring.GetUnitHealth
	
local  function handleNewEntrys()
			if table.getn(buildList) > 0 then 
						for id,v in pairs(buildList)  do
								x,y,z=Spring.GetUnitPosition(buildList[id].unitID)
							
								if id then
								guid=buildList[id].unitID
							    scale = 1+0.5*math.sin((frame - v.birth)/50)
								SendToUnsynced("SetScale", unitID, scale)
								scaleTable[id]={scale=scale, utype=JBUILDANIM, uid=id, scaleLimit=1+math.random(0.1,0.3), pulse=true}
								Spring.SetUnitAlwaysVisible(guid,false)
								Spring.SetUnitNoSelect(id,true)
								jWorkInProgress[guid] = id
								
										
								SyncedDataTable[guid] = {}
								SyncedDataTable[guid] = { birth=buildList[id].unitID + frame }	
								end
						end
					buildList={}
			end
  
  end
  
local  function handleBuildAnims()
  					
		------------	--BuildAnims	--------------------------------------------------------------------	
		if #jWorkInProgress > 0 then
			for k,v in pairs(jWorkInProgress) do
			if v then
				health,   maxHealth,   paralyzeDamage,   captureProgress,   buildProgress=spGetUnitHealth(k)
					if buildProgress then
						if buildProgress < 1 then
						Spring.SetUnitAlwaysVisible(k,false)
						Spring.SetUnitAlwaysVisible(v,true)
						scaleTable[v]={scale=buildProgress+math.sin((frame+9000)/100), utype=JBUILDANIM, uid=v, scaleLimit=1+math.random(0.1,0.3)}
				
						elseif buildProgress == 1 then
						Spring.SetUnitAlwaysVisible(k,true)
						Spring.DestroyUnit(v,true,true)
						scaleTable[v]=nil
						end
					end
			end	
			end	
			
			for k,v in pairs(jWorkInProgress) do
				if v and Spring.GetUnitIsDead(v)==true then
				jWorkInProgress[k]=nil
				end
			end 
			
		end
	----------------------------------------------------------------------------------------------------

  
  end
  
local  function setScaleTable()
		 local FeedingVaryFooCopy=GG.VaryFooFeeding
		--PrepCycle 
			for unitID,_ in pairs(scaleTable)  do
					 -- Here my scale is a sinusoid of time. So they grow and shrink smoothly and periodically
					 -- Use your own formula obviously

						if UnitsScaling[scaleTable[unitID].utype] then
							 temp=scaleTable[unitID].scale   + scaleTable[unitID].factor
							 scaleTable[unitID].scale = temp
						end
						--if it is a sungodcattle
							if scaleTable[unitID].utype == SUNGODCATTLEDEFID and scaleTable[unitID].scale >= math.random(0.87,1) then scaleTable[unitID] = nil end 

						--if it is a varyfoo it grows by how much it has eaten
							if scaleTable and scaleTable[unitID] and scaleTable[unitID].utype==VARYFOODEFID and FeedingVaryFooCopy and FeedingVaryFooCopy[unitID] then
								scaleTable[unitID].scale= math.min(scaleTable[unitID].scale+scaleTable[unitID].factor, FeedingVaryFooCopy[unitID])							
							end
							
							if scaleTable[unitID] and scaleTable[unitID].utype==EMBRYODEFID then
							hp=spGetUnitHealth(unitID)	
							if hp then
							scaleTable[unitID].scale=math.max(0.01,hp/100)
							end
							end
							--ending clause
							if scaleTable[unitID] and  scaleTable[unitID].scale >= scaleTable[unitID].scaleLimit then 
							 scaleTable[unitID] = nil
							end
					--end
				 end

			
				for unitID,_ in pairs(scaleTable) do
					 -- Here my scale is a sinusoid of time. So they grow and shrink smoothly and periodically
					 -- Use your own formula obviously
									 -- You should not call it every frame, but only when you wish to change scale
					 SendToUnsynced("SetScale",scaleTable[unitID].scale, scaleTable[unitID].uid )
					 -- Well, I change it constantly, so call it every frame, but that's for a more visual example
				end
		
  
  end
  
			
   
  function gadget:GameFrame(frame)
	
   
		 if frame > 0 and  frame%7 == 0 then
			 
					handleNewEntrys()
					
					handleBuildAnims()
		
					setScaleTable()
			
		end			
			 
		 
   end
   


else -- unsynced


   local UnsyncedScaleTable={}-- Table that contains the scale of units to be scaled

   local function SetScale(callname,scale,unitID)
   		--		Spring.Echo("jw_ScaleUPGadget::GameFrame::SetScale")
   --Spring.Echoqq("JW_ScaleUpGadget_"..unitID.."   |"..scale)
	  UnsyncedScaleTable[unitID]=scale
      Spring.UnitRendering.SetUnitLuaDraw(unitID,true)
   end

   local function UnsetScale(callname,unitID)
   
   --	  Spring.Echo("jw_ScaleUPGadget::GameFrame::UnSetScale")
      UnsyncedScaleTable[unitID]=nil
      Spring.UnitRendering.SetUnitLuaDraw(unitID,false)
   end

   function gadget:Initialize()
   
   	--Spring.Echo("jw_ScaleUPGadget::GameFrame::Init")
      -- This associate the messages with the functions
      -- So that when the synced sends a message "f" it calls the function f in unsynced
      gadgetHandler:AddSyncAction("SetScale",SetScale)
      gadgetHandler:AddSyncAction("UnsetScale",UnsetScale)
   end

   function gadget:DrawUnit(unitID)
      if UnsyncedScaleTable[unitID] then
         local scale=UnsyncedScaleTable[unitID]
         gl.Scale(scale,scale,scale)
         gl.UnitRaw(unitID)
      end
   end

end