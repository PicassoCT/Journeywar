

function gadget:GetInfo()
  return {
    name      = "Buffs & Debuffs",
    desc      = "",
    author    = "Handles Unit Auras, Bonuses, Support if it isnt handled directly in UnitScript",
    date      = "Jan. 2015",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts

if (gadgetHandler:IsSyncedCode()) then
if not GG.GluedForLife then GG.GluedForLife={} end

local OPERAID=UnitDefNames["operatrans"].id
local AffectedUnitTables={}
	AffectedUnitTables[OPERAID]=true

	OperaTable={}
local  operaAddMetall=420


function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
if AffectedUnitTables[unitDefID] then
	if unitDefID==OPERAID then 
	ed=Spring.GetUnitNearestEnemy(unitID)
		if ed then 
		OperaTable[unitID]= ed
		else
		OperaTable[unitID]=unitID
		end
	end
end
end


function gadget:UnitDestroyed(unitID, unitDefID, teamID)
if OperaTable[unitID] then OperaTable[unitID]=nil end
end


OldGlueTable={}
function setUnitSpeed(unitid, speedInPercent)
if OldGlueTable[unitid] and OldGlueTable[unitid] == speedInPercent then return end 

	
	UnitDefID=Spring.GetUnitDefID(unitid)
	maxSpeed=UnitDefs[UnitDefID].speed
	Spring.GetCOBUnitVar(unitd,COB.MAX_SPEED,maxSpeed*speedInPercent)
							
OldGlueTable[unitid]=speedInPercent
end

function gadget:Gameframe(n)
	if n% 100 ==0 then
	if not GG.GluedForLife then GG.GluedForLife={} end
	for k,v in pairs(GG.GluedForLife) do
		if Spring.GetUnitIsDead(k)==false then
			x,y,z=Spring.GetUnitPosition(unitID)
			if y and y < 0 then -- The Glue is undone
			GG.GluedForLife[k]=1	
			end
		setUnitSpeed(k,v)				
		end
	end
	end
	
	if n % 250 == 0 then 
		for uid,id in pairs(OperaTable) do
		alive=Spring.GetUnitIsDead(id)
				if alive and alive==false then
				Spring.AddUnitResource(uid, "m",operaAddMetall)
				end
			OperaTable[uid]=Spring.GetUnitNearestEnemy(uid) or uid
		end
	end

end

end