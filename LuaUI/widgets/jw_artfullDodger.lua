
function widget:GetInfo()
	return {
		name      = "Artfull dodger",
		desc      = "Everyone steps away from splash damage dangered units",
		author    = "Picasso",
		version   = "v1.0",
		date      = "Jul 18, 2009",
		license   = "GNU GPL, v2 or later",
		layer     = 3,
		enabled   = true
	}
end

ARTFULLDOGERKEY= 68
artfulldogerkey= 100
SPLASHRANGE= 128
framesToReroute = 75

--> Grabs every Unit in a circle, filters out the unitid or teamid if given
function getAllInCircle(x, z, Range, unitID, teamid)
    if not x or not z then
        return {}
    end
    if not Range then assert(Range) end

   local T = Spring.GetUnitsInCylinder(x, z, Range, teamid)

    if unitID and T and #T > 1 and type(unitID) == 'number' then
        for num, id in ipairs(T) do
            if id == unitID then
                table.remove(T, num)
            end
        end
    end
    return T
end

local playerID= Spring.GetMyPlayerID()
local teamID = 1

function widget:Initialize()
		playerID=Spring.GetMyPlayerID()
_,_,_,teamID = Spring.GetPlayerInfo(playerID)
end

allReroutedUnits= {}
function rerootAroundUnits(frame)
	if frame % 8 == 0 then
	for id,t in pairs(allReroutedUnits) do
		if id then
			allReroutedUnits[id].frames = allReroutedUnits[id].frames -1
			
			rerootUnit(id, t.swingById,t.range)
			if allReroutedUnits[id].frames <= 0 then
				allReroutedUnits[id] = nil
			end
		end
	end
	end
end

function rerootUnit(Id, swingById, range)
--calculate the offsetVector
			ux,uy,uz = Spring.GetUnitPosition(swingById)
			px,py,pz=Spring.GetUnitPosition(Id)
			pdx,pdz = px-ux, pz- uz
			
			--multiply the offsetVector with a rangefactor
			distance = (pdx^2 + pdz^2)^0.5
			factor= range/distance
			pdx,pdz= (pdx *factor) + ux, (pdz*factor)+uz
 		  Spring.GiveOrderToUnit (Id, CMD.INSERT, {0, CMD.MOVE, 0, pdx, py, pdz}, {"alt"})
end


 function widget:KeyPress(key, mods, isRepeat, label, unicode)

	if key == ARTFULLDOGERKEY or key == artfulldogerkey then
	local T = {}
		
		selectedUnits =Spring.GetSelectedUnits()
		if selectedUnits then
			for num,swingById in pairs(selectedUnits) do
			ux,uy,uz= Spring.GetUnitPosition(swingById)
				T = getAllInCircle(ux,uz, SPLASHRANGE, teamID)
				for i=1,#T do
					allReroutedUnits[T[i]] = {frames=framesToReroute, swingById = swingById, range =SPLASHRANGE }
				end
			end
		return true
		end
	end
 end
 
 function widget:GameFrame(f)
	rerootAroundUnits(f)
 
 end
 
