-- In-game, type /luarules kpai in the console to toggle the ai debug messages
 
function gadget:GetInfo()
local modOptions = Spring.GetModOptions()
        return {
                name = "Wild Horses AI",
                desc = "Version the aggro swarm",
                author = "Your Moma",
                date = "around since last tuesday",
                license = "GPL - by reading this you are basically allready infected. Brainz, brainz - no wait -freedomz, freedomz...",
                layer = 82,
                enabled = (modOptions.WildHorsesAI and modOptions.WildHorsesAI== true) or false
        }
end


if (gadgetHandler:IsSyncedCode()) then
VFS.Include("scripts/lib_UnitScript.lua", nil, VFS.DEF_MODE)
------SYNCED--------


-----STAGE SYSTEM--------
local unitOnMission = {} --[unitID] = wieviele frames in ruhe gelassen werden
combine_stages = {}
--skipMetal: if we have that much metal, then this stage is autocomplete/skipped

--kdronewarrior kdronestructure kdroneengineer kairdronefactory kdroneminer

combine_stages[1]= {
	["unitNumbers"]={
		["citadell"]=1,
		["condepot"]=1,
		["scumslum"]=2,
		["contrain"]=2,
		["contruck"]=2,
		},
	skipMetal = math.huge,
	}

combine_stages[2]= {
	["unitNumbers"]={
		["mdigg"]=2,
		["fclvlone"]=1,
		["bg"]=6,
		["contruck"]=2,
		["conair"]=2,
		["scumslum"]=1,
		},
	skipMetal = 500,
	}

combine_stages[3]= {
	["unitNumbers"]={
		["restrictor"]=3,
		["campro"]=2,
		["contruck"]=4,
		["mtw"]=3,
		["art"]=1,
		["builux"]=1,
		["bonker"]=1,
		["contruck"]=2
		},
	skipMetal = 1000,
	}
	
combine_stages[4]= {
	["unitNumbers"]={		
		["fclvl2"]=1,
		["sentrynell"]=2,
		["csniper"]=2,
		["cairbase"]=1,
		["cgunship"]=1,
		["chunterchopper"]=2,
		["contruck"]=2,
		["kdroneminingtower"]=4,
		["crailgun"]=2,
		["cadvisor"]=1,
		["contruck"]=2,
--		["kdroneminer"]=3, --spread fire drone
		},
	skipMetal = 1000,
	}
	
combine_stages[5]= { --mining boom phase
	["unitNumbers"]={
		["conair"]=2,
		["fclvl2"]=1,
		["bbind"]=1,
		["coverworldgate"]=1,
		["contruck"]=2
		},
	skipMetal = 2770,
	}
	
combine_stages[6]= {
	["unitNumbers"]={
		["scumslum"] = 3,
		["conair"]=2,
		["builux"]=3,
		["sentry"]=3,
		["chopper"]=3,
		},
	skipMetal = math.huge,
	}
	
combine_stages[7]= {
	["unitNumbers"]={
		["mtw"] = 4,
		["conair"]=2,
		["cgamagardener"] = 4,
		["cheadlauncher"] = 1,
		},
	skipMetal = math.huge,
	}
	
combine_stages[8]= {
	["unitNumbers"]={
		["bonker"] =2,
		["restrictor"] = 5,
		["mtw"] = 5,
		["coffworldassembly"] = 1,
		},
	skipMetal = math.huge,
	}
		
combine_stages[9]= {
	["unitNumbers"]={
		["bonker"] =2,
		["restrictor"] = 5,
		["mtw"] = 5,
		["coffworldassemblyseed"] = 1,
		},
	skipMetal = math.huge,
	}
combine_stages[10]= {
	["unitNumbers"]={
		["strider"] =2,
		["paxcentrail"] =1,
		["cgatefort"] = 1,
		["ccrabsynth"] = 1,
		["cnanorecon"] = 1,
		},
	skipMetal = math.huge,
	}
	
--funzt!
function print_stages ()
	Spring.Echo ("--printing combine_stages table *START*--")
	for i=1, #combine_stages do
		Spring.Echo ("combine_stages [" .. i  .. "]")
		Spring.Echo ("skipMetal=" .. combine_stages[i].skipMetal)
		for name, amount in pairs (combine_stages[i]["unitNumbers"]) do
			Spring.Echo ("unitNumbers:" .. name .. " - " .. combine_stages[i]["unitNumbers"][name])
		end
	end
	Spring.Echo ("--printing combine_stages table *DONE*--")
end

--funzt!
--return: isComplete, missing table
function stageComplete (teamID, stage)		
	--alle einheiten da die wir brauchen?
	local missing = {}	--[unitname] = wie viele davon noch gebraucht werden
	for name, amount in pairs (stage["unitNumbers"]) do
		--Spring.Echo ("enough " .. name .. "?")
		local unitDefID =UnitDefNames[name].id
		--Spring.Echo (unitDefID)
		local have = Spring.GetTeamUnitDefCount (teamID, unitDefID)
		local shouldHave = stage["unitNumbers"][name]
		if (have < shouldHave) then missing[name] = shouldHave-have end
	end
	if (next(missing) == nil) then return true end
	--genug metal da? dann autocomplete!
	if (Spring.GetTeamResources (teamID, "metal") > stage.skipMetal) then return true, missing end	--ich kauf den ganzen laden!
	return false, missing
end

--return: stagei, missing table
function getHighestCompleteStage (teamID)	
	for i=1, #combine_stages do
		local complete, missing = stageComplete (teamID, combine_stages[i])
		if (complete == false) then return i-1,missing end
	end
	return #combine_stages, nil
end

--job: ["unitname"] = amount
--***problem: es wird alles mehrfach gebaut weil es im n�chsten frame%30 wieder vergeben wird
--braucht also ein inProgress array.
function makeSomeUnits (teamID, job)
local all_units = Spring.GetTeamUnits (teamID)
if (all_units == nil) then return end
	for name, amount in pairs (job) do
		--Spring.Echo ("team " .. teamID .." wants to build " .. amount .. "x " ..name)
		local assigned = 0
		for i,unitID in pairs(all_units) do
			--if (job[name] <= 0) then break end --if the job is already split between builders, break
			if (assigned >= amount) then break end
			local canDo = canUnitBuildThis (unitName (unitID), name)
			if (canDo) then 
				local msg = unitID .. " can do it"
				local wantDo = doesUnitWantBuildJob (unitID, name)
				if (wantDo) then
					msg = msg .. " and wants to do it!"
					--job[name] = job[name] -1
					assigned = assigned +1					
					buildUnit (unitID, name)
					if (assigned >= amount) then break end
				else
					msg = msg .. " but is busy!"
				end
				--Spring.Echo (msg)
			end
		end
	end
end

cBuildTable={}
jBuildTable={}
cBuildTable=getFactionTable("citadell",false)
jBuildTable=getFactionTable("beanstalk",false)

--naja
function canUnitBuildThis (parentName, childName,side)
if side == "centrail" then
 return  cBuildTable[parentName] and cBuildTable[parentName] [childName]
  else
  return  jBuildTable[parentName] and jBuildTable[parentName] [childName]
  end
 end


function doesUnitWantBuildJob (unitID, childname)
	local _, _, _, _, buildProg = Spring.GetUnitHealth(unitID)
	if buildProg < 1 then return false end

	--mining tower haben keinen bock sich abzubauen wenn es noch engineers gibt
	if (unitName (unitID) == "kdroneminingtower") then
		if (#Spring.GetTeamUnitsByDefs (Spring.GetUnitTeam (unitID), {UnitDefNames["kdroneengineer"].id}) > 0) then return false end
	end
	
	--if ((unitOnMission[unitID] and unitOnMission[unitID] >0) and unitIsMobile(unitID)) then return false end
	if ((unitOnMission[unitID] and unitOnMission[unitID] >0) ) then return false end
	
	if (#Spring.GetFullBuildQueue  (unitID) == 0) then return true end --nur eine sache pro fabrik gleichzeitig bauen
	
	return false
end

function buildUnit (unitID, jobname)
	if (unitName (unitID) ==  "kdroneminingtower" and jobname == "kdroneengineer") then undeploy (unitID) end
	
	if (unitName (unitID) == jobname) then --same units can just clone each other
		cloneUnit (unitID, UnitDefNames[jobname].id)		
		return
	end
	
	if (unitName (unitID) == "kdronestructure") then --land factory builds
		Spring.GiveOrderToUnit(unitID, -UnitDefNames[jobname].id, {}, {}) --bauen
		moveAway (unitID, 500)	--waypoint
		return
	end
	
	if (unitName (unitID) == "kairdronefactory") then --air factory builds
		Spring.GiveOrderToUnit(unitID, -UnitDefNames[jobname].id, {}, {}) --bauen
		moveAway (unitID, 1000)	--waypoint
		return
	end
	
	if (not unitOnMission[unitID] and unitName (unitID) ==  "kdroneengineer" and jobname == "kdroneminingtower") then
		--unitOnMission[unitID] = true
		--moveAway (unitID, 2000)
		unitOnMission[unitID] = 100
		deployNearRes (unitID)
		return
	end
	
	if (unitName (unitID) == "kdroneengineer") then --engineer building whatever building
			local ux,uy,uz = Spring.GetUnitPosition (unitID)
			local x,y,z = getBuildSpot (ux,uy,uz, jobname, 200, 50)
			Spring.GiveOrderToUnit(unitID, -UnitDefNames[jobname].id, {x,y,z}, {}) --bauen
		return
	end	
end

function unitName (unitID)
	if (not Spring.ValidUnitID (unitID)) then return "!invalid unitID in unitName()!" end
	local udID =Spring.GetUnitDefID(unitID)
	local uDef = UnitDefs [udID]
	return uDef.name
end

--returns how many kdroneengineer and kdroneminingtowers a team has
function countTowersAndEngineer (teamID)
	return #Spring.GetTeamUnitsByDefs (teamID, {UnitDefNames["kdroneminingtower"].id}) + Spring.GetTeamUnitsByDefs (teamID, {UnitDefNames["kdroneengineer"].id})
end

function unitCount (teamID, unitName)
	return #Spring.GetTeamUnitsByDefs (teamID, {UnitDefNames[unitName].id}) or 0
end
------------


myTeam = {} --enth�lt alle teamids f�r die wir spielen, [1]=3, [2]=7 etc
local data = {} -- [teamID].threatmap etc
 
function gadget:Initialize()
	counter = 0
    -- Initialise AI for all teams that are set to use it
    for _,t in ipairs(Spring.GetTeamList()) do
        local _,_,_,ai,side = Spring.GetTeamInfo(t)
        if ai and Spring.GetTeamLuaAI(t) == gadget:GetInfo().name then
            --log(t, " assigned to "..gadget:GetInfo().name)
            local pos = {}
            local home_x,home_y,home_z = Spring.GetTeamStartPosition(t)
			myTeam[t] = t
			Spring.Echo ("Schwarm AI will play for team  " .. t .." GetTeamLuaAI: " ..  Spring.GetTeamLuaAI(t))        
		end
    end
	if (myTeam == nil) then 
		Spring.Echo ("Schwarm AI: not used, byebye.")
		gadgetHandler:RemoveGadget()
	end
	print_stages ()
end


function think (teamID, data)
	return data
end

function gadget:UnitIdle(unitID, unitDefID, teamID)
	unitOnMission[unitID] = nil
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
	unitOnMission[unitID] = nil
end


function gadget:UnitDamaged(
    unitID, unitDefID, unitTeam,
    damage, paralyzer, weaponID,
    attackerID, attackerDefID, attackerTeam
)
	
	for t in pairs(myTeam) do
		if (unitTeam == myTeam[t]) then
			local goto_x, goto_y, goto_z = Spring.GetUnitPosition (unitID)
			machTargetArea(myTeam[t], goto_x, goto_z)
		end
	end
end	
	
function gadget:GameFrame(frame)
	for i in pairs(unitOnMission) do
		unitOnMission[i] = unitOnMission[i] -1
		if (unitOnMission[i] < 0) then unitOnMission[i] = 0 end
	end

	if (frame % 30 ~=0) then return end
	--Spring.Echo ("l�uft")
	for _,t in pairs(myTeam) do
		--Spring.Echo ("SchwarmAI is playing for team " .. myTeam[t])		
		local h, missing = getHighestCompleteStage (myTeam[t])
		--Spring.Echo ("team " .. myTeam[t] .. " is at stage " .. h)
		if (missing) then
			if (unitCount (myTeam[t], "kdroneengineer") < (missing["kdroneminingtower"] or 0) ) then
				missing["kdroneengineer"] = (missing["kdroneengineer"] or 0) +  (missing["kdroneminingtower"] -unitCount (myTeam[t], "kdroneengineer"))
			end
		makeSomeUnits (myTeam[t], missing)
		undeployEmptyMiningTowers (myTeam[t])
		--if (not missing["kdronestructure"] and not missing["kairdronefactory"]) then
			--sendOutIdleEngineers (myTeam[t])
		--end
		end
		
	--data = think (teamID, data[teamID]
		--
		
		--clonetest(myTeam[t])
	end
end

---------ACTIONS/COMMANDS-----------------

function machGo (teamID) --alle rushen mit
	Spring.Echo ("machGO")
	Spring.Echo ("machGO")
	Spring.Echo ("machGO")
	Spring.Echo ("machGO")
	Spring.Echo ("machGO")
	Spring.Echo ("machGO") --- fill up display screen
	Spring.Echo ("machGO")
	Spring.Echo ("machGO")
	Spring.Echo ("machGO")
	local all_units = Spring.GetTeamUnits (teamID)
	if (all_units == nil) then return end		
	for i,unitID in pairs(all_units) do
		if (Spring.ValidUnitID (unitID)) then
			local x = math.random(Game.mapSizeX)
			local z = math.random(Game.mapSizeZ)
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT , {x, Spring.GetGroundHeight (x,z), z  }, {})
		end
	end
end

function machPatrol (teamID) --alle rushen mit
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE") 
	Spring.Echo ("machPatrol --- ACTIVE") --- fill up display screen
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE")
	Spring.Echo ("machPatrol --- ACTIVE")
	local all_units = Spring.GetTeamUnits (teamID)
	if (all_units == nil) then return end		
	for i,unitID in pairs(all_units) do
		if (Spring.ValidUnitID (unitID)) then
			local x = math.random(Game.mapSizeX)
			local z = math.random(Game.mapSizeZ)
			Spring.GiveOrderToUnit(unitID, CMD.PATROL , {x, Spring.GetGroundHeight (x,z), z  }, {})
		end
	end
end

---yanom's added function is below

function machTargetArea (teamID, x, z) --alle rushen mit
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	Spring.Echo ("Targeting Area ---- Charge!")
	local all_units = Spring.GetTeamUnits (teamID)
	if (all_units == nil) then return end		
	for i,unitID in pairs(all_units) do
		if ( ( unitName (unitID) ~= "kdroneengineer" ) and (Spring.ValidUnitID (unitID)) ) then
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT , {x, Spring.GetGroundHeight (x,z), z  }, {})
		end
	end
end


function moveTo (unitID, tx, tz, keys)
	Spring.GiveOrderToUnit(unitID, CMD.MOVE , {tx, Spring.GetGroundHeight (tx,tz), tz  }, {keys})
end

--move away from current position
function moveAway (unitID, r, keys)
	local x,y,z = Spring.GetUnitPosition (unitID)
	if (x and y and z) then
		local a = math.rad (math.random (0,360))
		x = x + (math.sin (a) * r)
		z = z + (math.cos (a) * r) 
		moveTo (unitID, x, z, keys)
	end
end

function patrolAway (unitID, r, keys)
	local x,y,z = Spring.GetUnitPosition (unitID)
	if (x and y and z) then
		local a = math.rad (math.random (0,360))
		x = x + (math.sin (a) * r)
		z = z + (math.cos (a) * r) 
		Spring.GiveOrderToUnit(unitID, CMD.PATROL , {tx, Spring.GetGroundHeight (tx,tz), tz  }, {keys})
	end
end

function deployNearRes (unitID, keys)
	local nearest_resID, rx,ry,rz, nearest_res_distance  = nearestResFromUnit (unitID)
	--local ux,uy,uz = Spring.GetUnitPosition (unitID)
	local x,y,z = getBuildSpot (rx,ry,rz, "kdroneminingtower", 20, 5)
	deployAt (unitID,  x,z , keys)
end

--engineer geht zu x:z und morpht sich zum mining tower
--funzt!
function deployAt (unitID, tx,tz, keys)
	Spring.GiveOrderToUnit(unitID, CMD.FIGHT , {tx, Spring.GetGroundHeight (tx,tz), tz  }, {keys})
	Spring.GiveOrderToUnit(unitID, 31210,{UnitDefNames["kdroneminingtower"].id},{"shift"})
end

function undeploy (unitID)
	Spring.GiveOrderToUnit(unitID, 31210,{UnitDefNames["kdroneengineer"].id},{})
end

function do_attacknearest (unitID)
	local enemy = Spring.GetUnitNearestEnemy (unitID)
	if (enemy) then 
		Spring.GiveOrderToUnit(unitID, CMD.ATTACK  , { enemy  }, {}) 
	end
end

function cloneUnit (unitID, cloneDef)
	if Spring.ValidUnitID (unitID) then
		Spring.GiveOrderToUnit(unitID, 33333,{cloneDef},{})
	end
end

function undeployRandomMiningTowers (teamID, n)
end
---------------------------------

----------TICK TACK LOGIC (gets executed check every nth frame)------
function undeployEmptyMiningTowers (teamID)
	local mtowers = Spring.GetTeamUnitsByDefs (teamID, {UnitDefNames["kdroneminingtower"].id})
	--Spring.Echo ("#mtowers:" .. #mtowers)
	for i in pairs (mtowers) do
		local nearest_resID, rx,ry,rz, nearest_res_distance  = nearestResFromUnit (mtowers[i])
		if ((nearest_res_distance or 0) > 150) then undeploy (mtowers[i]) end
	end
end

--[[
function sendOutIdleEngineers (teamID)
	local engs = Spring.GetTeamUnitsByDefs (teamID, {UnitDefNames["kdroneengineer"].id})
	if (engs == nil) then return end
	--Spring.Echo ("#mtowers:" .. #mtowers)
	for i in pairs (engs) do
		if (Spring.ValidUnitID (engs[i])) then		
			if (not Spring.GetCommandQueue(engs[i])) then 
				Spring.Echo ("engineer " .. engs[i] .. " has nothing to do and runs away, lol")
				moveAway (engs[i], 1000)
				deployNearRes (engs[i], "shift")
			end
		end
	end
end
--]]

function clonetest (teamID)
	local munits = Spring.GetTeamUnitsByDefs (teamID, {UnitDefNames["kdroneengineer"].id})
	for i in pairs (munits) do
		cloneUnit (munits[i], UnitDefNames["kdroneengineer"].id)
	end
end
------------------------------------------------------
--function gadget:UnitFromFactory(unitID, unitDefID, unitTeam, factID, factDefID, userOrders)
--	if (factID) then unitOnMission [unitID] = 30 end
--end

function gadget:UnitFinished(unitID, unitDefID, teamID)	
	--moveAway (unitID, 200)
	if (isTeamCBM (teamID)) then
		--Spring.Echo ("den controll ich!")
		--Spring.GiveOrderToUnit(unitID, CMD.IDLEMODE,{0},{})	--always fly
		--if (unitIsMobile (unitID) == true) then
			--Spring.Echo ("ich bin da und renn weg")
			moveAway (unitID, 200)
			unitOnMission [unitID] = 30
		--end
		if ((unitName (unitID) ~= "kdroneengineer") or (unitName (unitID) ~= "ktridroneroller")) then
			local x = math.random(Game.mapSizeX)
			local z = math.random(Game.mapSizeZ)
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT , {x, Spring.GetGroundHeight (x,z), z  }, {})
		end
		if (unitName (unitID) == "ktridroneroller") then 
			machPatrol(teamID)
		end
	else
		--Spring.Echo ("den controll ich NICHT!")
	end
	--if (teamID ~= myTeam) then return end
	--Spring.Echo ("SchwarmAI: hab ne neue unit!")
	--local unitDef = UnitDefs[unitDefID]
	--if (unitDef.name == "kdroneengineer") then 
		--local nearest_resID, rx,ry,rz, nearest_res_distance  = nearestResFromUnit (unitID)
		--Spring.Echo ("going to " .. rx .. ":" .. rz)
		--deployAt (unitID,  rx+math.random(-50,50), rz+math.random(-50,50))		
	--end	
	--if (isResourceType (unitDefID)) then Spring.Echo ("its a resource!") end 
end



------HELPER functions-----------
--is team controlled by me?
function isTeamCBM (teamID)
	for t in pairs(myTeam) do
		if (teamID == myTeam[t]) then return true end
	end
	return false
end

function unitIsMobile(unitID)
	local udID =Spring.GetUnitDefID(unitID)
	local uDef = UnitDefs [udID]	
	return (uDef.maxVelocity or 0) > 0
end

function getBuildSpot (ux, uy, uz, buildingname, r, rgrow)	
	--Spring.MarkerAddPoint (ux,uy,uz, "trying to find a spot here")
	local blocked = 0
	if (r == nil) then r = 200 end
	if (rgrow == nil) then rgrow = 200 end
	try = 0
	while (blocked ~=2 and try < 20) do
		x = ux + math.random (-r, r)
		z = uz + math.random (-r, r)
		y = Spring.GetGroundHeight (x,z)
		--blocked =Spring.TestBuildOrder (UnitDefNames[buildingname].id, x,y,z,0)
		r = r +rgrow
		try = try +1
	end	
	--Spring.MarkerAddPoint (x,y,z, "found this after " .. try .. " tries")
	return x,y,z
end

function units_allied (unitID1, unitID2)
	return Spring.GetUnitAllyTeam (unitID1) == Spring.GetUnitAllyTeam (unitID2)
end

--funzt aber irgendwie naja
function nearestResFromUnit (uID)
	local nearest_resID = nil
	local nearest_res_distance = 9999999999
	local x,y,z = Spring.GetUnitPosition(uID)
	if (not x or not z) then return end
	res=Spring.GetUnitsInCylinder (x,z, 5000, Spring.GetGaiaTeamID())
	if (res == nil) then return nil end	--no near units at all :/
	--Spring.Echo ("#res:" .. #res)
	for i in pairs (res) do
		if Spring.ValidUnitID (res[i]) then
			--Spring.Echo ("jo:"..res[i])
			--Spring.Echo ("vergleiche" .. res[i])
			--if (isResourceType (Spring.GetUnitDefID(res[i])) == true) then			
			if (true) then
				local d = Spring.GetUnitSeparation (uID, res[i])
				if (d < nearest_res_distance) then
					nearest_res_distance = d
					nearest_resID = res[i]
				end
			end
		end
	end
	if (nearest_resID~=nil) then 		
		local rx,ry,rz=Spring.GetUnitPosition(nearest_resID)
		return nearest_resID, rx,ry,rz, nearest_res_distance 
		else return 666,666,666,666,666,666,666
	end
end

--funzt!
function isResourceType (unitDefID)	
	if (UnitDefID == nil) then return false end
	local udef = UnitDefs[unitDefID]
	if (udef) then
		local cp = udef.customParams
		if (cp) then
			if (cp.is_mineable) then return true end
		end
	end
	return false
end
---------------------------------

--2         3        4   5   6   7   
--playerID, cmdType, px, py, pz, label
function gadget:RecvLuaMsg(msg, playerID)
	--Spring.Echo ("AI: look what i got " .. msg)
	if (msg:find("MapDrawCmd",1,true)) then
		local p = explode ("|", msg)
		if (p[3] == "point") then
			local x = p[4]
			local y = p[5]
			local z = p[6]
			local label = p[7]
		end
	end
	
end




-- explode(seperator, string)
function explode(d,p)
  local t, ll
  t={}
  ll=0
  if(#p == 1) then return {p} end
	while true do
	  l=string.find(p,d,ll,true) -- find the next d in the string
	  if l~=nil then -- if "not not" found then..
		table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
		ll=l+1 -- save just after where we found it for searching next time.
	  else
		table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
		break -- Break at end, as it should be, according to the lua manual.
	  end
	end
  return t
end



else ------UNSYNCED--------

--function gadget:AddConsoleLine(msg,priority)							--does not work
--	Spring.Echo ("i hear you man")
--end



--function gadget:KeyPress(key) 										--this works!
	--Spring.Echo ("pressed key in gadget: " .. key)
--end

--function gadget:MapDrawCmd(playerID, cmdType, px, py, pz, label)
--	Spring.Echo ("marker!")
--	Spring.Echo ("playerID: " .. playerID .. "cmdType:" .. cmdType .. "px:" .. px .. "py:" .. py .. "pz:" .. pz .."label:" .. label)	
--end
end	--end unsynced
