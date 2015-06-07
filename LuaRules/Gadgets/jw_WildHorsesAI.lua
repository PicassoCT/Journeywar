-- In-game, type /luarules kpai in the console to toggle the ai debug messages
 
function gadget:GetInfo()
        return {
                name = "Wild Horses AI",
                desc = "Generic Emergent AI using eventstreams",
                author = "Picasso",
                date = "around since last tuesday",
                license = "GPL - by reading this you are basically allready infected.",
                layer = 82,
                enabled = false
        }
end

	VFS.Include("scripts/lib_OS.lua"      )
	VFS.Include("scripts/lib_TableOp.lua"      )
	VFS.Include("scripts/lib_Build.lua" 	)

	

--wishlist
--FutureUseDefID={DefID={Base Def Aggr}}
--
--CurrentUseDefID={DefID={Base Def Aggr}}
--
--ExpUseDefID ={DefID={Base Def Aggr}}

--Observe
--Agg:  Basically a copy running on the enemys side - merged with real Observations
--Def:  Reevaluate  MexPositions and Factorys
--Base: Detect Stall,
--[[

functin loadDeducedBuildTrees(side,unittype)

function weightBuildTree()

function updateVE()
function getPrimeTarget(VE)

function updateDefMap()
function getProtectionorExpansionGoal()


]]
--Think
--Movement
--StorageTable 
--	AI[teamid]
--			WorldRepresentaiton[x][y]=interest (Value= Height * Metal, }
--			Base
--				  
--				Wishlist, Unitpool->Father, Task-List-Priority[unitid],  
--			DefRes
--				Wishlist, Unitpool & TaskList, DefMap
--			Aggressor
--				WishList, Unitpool & TaskList, Virtual Enemy
--			UnitPools contian a UnitID,UnitDefID,TaskPriority	
	
function forgeAI_Table(side,teamid,teaminfo)


boolWishListExists,heuraWishList=loadheuristicWishlists(side)
	if boolWishListExists==true then 
	AI[teamid]=heuraWishList
	else
		if side=="journeyman" then
		local tab={Base=jBase,DefRes=jDefRes, Aggressor=jAggressor}
		AI[teamid]=tab
		else 
		local tab={Base=cBase,DefRes=cDefRes, Aggressor=cAggressor}
		AI[teamid]=tab
		end
	
	--Data needed  -- StrategicValueMap   --Agression Heatmap
	end	
end	
--if funds push wish to base, base builds unit and returns to Stakeholderr
	
--Fund Distribution
--	If you got funding fullfill base wish, evaluate, give evenstreamorder
--		if still funding, fullfill resdef wish
--		if still funding fullfill aggro wish
--Act		

function storeheuristicWishlist(List)
end

function loadheuristicWishlists(side)
return false, {}
end

//wishlists 
cBase={ boolFundRound=false, Tasks={},energyTraded=0, metaltraded=0,orderded=false
		UnitPool={}, TaskList={},
 Build={
 
		["citadell"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=10,Mreturn=10}	,
		["scumslum"]		={nr=3, cyle=0,	cycleInc=2,xpShort=1,xpLong=1,Ereturn=10,Mreturn=0,DeaDamage=0},
		["condepot"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},	
		["fclvlone"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["fclvl2"]			={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0}, 
		["cairbase"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0} 
		}

 }
 
cDefRes={boolFundRound=false, Tasks={},energyTraded=0, metaltraded=0,orderded=false
		 UnitPool={}, TaskList={},
 Build={

		["mdigg"]				={nr=1, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=5},
		["sentry"]				={nr=1, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["crailgun"]			={nr=1, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["sentrynell"]			={nr=1,cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0}
		["cgama"]			={nr=1,cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0}
		}
		}
cAggressor={boolFundRound=false, Tasks={},energyTraded=0, metaltraded=0,orderded=false
 UnitPool={}, TaskList={},
 Build={
		["mtw"]					={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["restrictor"]			={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		}
		}
jBase={boolFundRound=false, Tasks={},energyTraded=0, metaltraded=0,orderded=false
 UnitPool={}, TaskList={},
 Build={

		["beanstalk"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["eggstackfac"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},	
		["jmovingfac2"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jtrafactory"]		={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0}, 
		["jinfinityscraddle"]={nr=1, cycle=0,cycleInc=7,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0} 
		}
   
}
jDefRes={boolFundRound=false, Tasks={},energyTraded=0, metaltraded=0,orderded=false
 UnitPool={}, TaskList={},
 Build={

		["jdrilltree"]				={nr=1, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jwatergate"]				={nr=1, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jgeohive"]				={nr=1, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jfungiforrest"]			={nr=1,cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jdarkgate"]				={nr=1,cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jbeehive"]				={nr=1,cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jtree"]					={nr=3, cycle=0,cycleInc=5,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		}
}
jAggressor={boolFundRound=false, Tasks={},energyTraded=0, metaltraded=0,orderded=false
 UnitPool={}, TaskList={},
 Build={

		["vort"]					={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jsungodcattle"]			={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jhivehound"]			={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jeliah"]				={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jglowworm"]			={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		["jbeherith"]			={nr=1, cycle=0,cycleInc=1,xpShort=1,xpLong=1,Ereturn=0,Mreturn=0,DeaDamage=0},
		}
		}


--================================================================================================
 
 
if (gadgetHandler:IsSyncedCode()) then
 
--SYNCED
local AI={}

local function RemoveSelfIfNoTeam()
	local AIcount=0
	for t,td in pairs(teamData) do
		AIcount=AIcount+1
	end
	if(AIcount==0) then -- #teamData is 0 even when there are teams, and teamData=={} is untrue even when teamData={}
		Spring.Echo("none",gadget:GetInfo().name.." removing self")
		gadgetHandler:RemoveGadget()
		return true
	end
	return false
end
  
function gadget:Initialize()
    teams=Spring.GetTeamInfo()
	for k,v in pairs(teams) do 
	forgeAI_Table(getTeamSide(k),k,v)
	end	
   
end

function checkFundRoundEnd(T)
if T.DefRes.boolFundRound==true and T.Base.boolFundRound==true and T.Aggressor.boolFundRound==true then  
 T.DefRes.boolFundRound=false 
 T.Base.boolFundRound=false 
 T.Aggressor.boolFundRound=false 
end
return T
end

local function returnUnitToPool(teamid,unitid, assignedSubAI,father)
	if assignedSubAI == "Base" then
	AI[teamid].Base.UnitPool[unitid]=father
	AI[teamid].Base.TaskList[unitid]=nil
	end	
	
	if assignedSubAI == "DefRes" then
	AI[teamid].DefRes.UnitPool[unitid]=father
	AI[teamid].DefRes.TaskList[unitid]=nil
	end	
	
	if assignedSubAI == "Aggressor" then
	AI[teamid].Aggressor.UnitPool[unitid]=father
	AI[teamid].Aggressor.TaskList[unitid]=nil
	end


    end
     
    if GG.UnitPool== nil then GG.UnitPool = { Return = returnUnitToPool } end
--filters the next to build unit/building according to need
	function nextBuildFilterFunction(typeTable, AI_Table)
	return typeTable[1]
	end

	function getNextWish(Table)
--	we filter out all the tables whos cycle equals is due
	maxkeyT={}
	for k,v in pairs(Table) do
		if v.cycle==v.cyleInc then maxkeyT[k]=true	else 	v.cycle	=	v.cycle+1	end
	end

	--we take from those Table the one that has heighest return of Investment/and or moneycycle
	--this will be returned as next wish, the next Cycle beeing set to reset
	nxtKey=nextBuildFilterFunction(maxkeyT, AI)
	Table[nxtKey].cycle=0
	return UnitDefNames[nxtKey].id
	end    

function Base(AITable)
	 --if you got the funds build
	 
	  NeededEntity=GetNextWish(AITable.Base)
	 -- if you dont have the funds still cut deither defres or Aggressorness
		--give BuildOrdersBase
		for unit,_ in pairs(AITable.Base.UnitPool) do
			
		
		end
		--createTasks
		--give MoveOrdersBase to not assigned Units
			--if  Tasks higher Prio then deassign Eventstream and create new Eventstream 
		--if surplus funds, buy tasks from DefRes or Aggressor AI
return AITable
end

function DefRes(AITable)
	--if defRes --check funding
	--if funding, order building or unit from base (Task)
	-- check RessourceMap and Recent Battle& Build Hotzones
		--expand RessourceBuilding
		-- if Aggressored, buy protection via Tasks from Aggressor
return AITable
		end

function Aggressor(AITable)
	-- Virtual Enemy
		--if Virtual Enemy is stronger Harass, Delay and Defend
	--else
		--find Weakspot  
	
return AITable
end
 
 
function gadget:GameFrame(frame)
	if frame % 50 == 0 then
	Spring.Echo("AI Evaluation cycle")
		for teamid,T in pairs(AI) do
			T=checkFundRoundEnd(T)
		
			if T.Base.boolFundRound==true then
			-- Base stage
				T=Base(T)
			end
			if T.DefRes.boolFundRound==true then
			--Defense stage
				T=DefRes(T)
			end	
			if  T.Aggressor.boolFundRound==true then
			--Aggressive Stage			
				T=Aggressor(T)
			end				
		end
	
		end
end


function gadget:UnitCreated(u,ud,team,builder)
	if AI[team] then
	
		if UnitDefs[ud].IsBuilder ==false then
		AssignedAI="Base"
		else
			if math.random(0,1)==1 then AssignedAI="Aggressor" else AssignedAI="DefRes" end
		end
		returnUnitToPool(team,u,AssignedAI,builder)
	end
end


 
function gadget:UnitDamaged(u,ud,team, damage, para, weapon,Aggressorer,aud,ateam)
--Damaged Units become Property of the AggressorAI, which will try to save them

end
 
function gadget:UnitFinished(u, ud, team, builder)
end
 
function gadget:UnitDestroyed(u,ud,team)
end
 
function gadget:UnitTaken(u,ud,team,newteam)
        
end
 
function gadget:UnitGiven(u,ud,team,oldteam)
        
end
 

 
 
end