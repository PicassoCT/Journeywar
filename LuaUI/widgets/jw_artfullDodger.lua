
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

ARTFULLDOGERKEY= 32
SPLASHRANGE= 128

--> Grabs every Unit in a circle, filters out the unitid or teamid if given
function getAllInCircle(x, z, Range, unitID, teamid)
    if not x or not z then
        return {}
    end
    if not Range then assert(Range) end

    T = Spring.GetUnitsInCylinder(x, z, Range, teamid)

    if unitID and T and #T > 1 and type(unitID) == 'number' then
        for num, id in ipairs(T) do
            if id == unitID then
                table.remove(T, num)
            end
        end
    end
    return T
end

 function widget:KeyPress(key, mods, isRepeat, label, unicode)

	if key == ARTFULLDOGERKEY then
		playerID=Spring.GetMyPlayerID()
		selectedUnits =Spring.GetSelectedUnits(playerID)
		
		if selectedUnits then
			T = {}
			ux,uy,uz=0,0,0
			for num, id in pairs(selectedUnits) do
				ux,_,uz = Spring.GetUnitPosition(id)
				T = getAllInCircle(x,z, SPLASHRANGE, id)
				break
			end
			
			for num, id in pairs(T) do
			--calculate the offsetVector
			px,py,pz=Spring.GetUnitPosition(id)
			pdx,pdz = px-ux, pz- uz
			
			--multiply the offsetVector with a rangefactor
			distance = (pdx^2 + pdz^2)^0.5
			factor= SPLASHRANGE/distance
			pdx,pdz= (pdx *factor) + ux, (pdz*factor)+uz
			
			--insert  a move command
			--TODO save commands, insert command,restore commands
			Spring.GiveOrderToUnit(id, CMD.MOVE, { pdx, py, pdz }, {})
			end
		end
	end
	return false
 end
