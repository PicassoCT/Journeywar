include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

SUCKER_RANGE= 250
LIFE_TIME_LIMITED= 10000
boolAttached=false


function attachToCorpse()
	teamID=Spring.GetUnitTeam(unitID)
	if not GG.CorpseDevourer then GG.CorpseDevourer = {} end
	if not GG.CorpseDevourer[teamID] then GG.CorpseDevourer[teamID] = {} end
	x,_,z = Spring.GetUnitPosition(unitID)
    T = getAllInCircle(x, z, range)
	CorpseTypeTable = getCorpseTypeTable()
	oneTrueCorpse = nil
	
	process(T,
		function(id)
			defID=Spring.GetUnitDefID(id)
			if CorpseTypeTable[defID] then return id end
		end,
		function(id)
			if not oneTrueCorpse and  not GG.CorpseDevourer[teamID][id] then
				GG.CorpseDevourer[teamID][id] = true
				oneTrueCorpse = id
			end
		end
		)
		
	return oneTrueCorpse 
end

function tryToGetCorpse()
myCorpse=attachToCorpse()
	while lifetime < LIFE_TIME_LIMITED and not myCorpse do
		Sleep(1000)
		lifetime = lifetime + 1000
		myCorpse=attachToCorpse()
	end
	
	tentacleToUnit(tentacleTable, myCorpse, waveCycleTime, nrOfWaves, Time)
end

function lifeTimeLimited()
Sleep(LIFE_TIME_LIMITED)
if boolAttached == false then Spring.DestroyUnit(unitID,true,true) end
end



function script.Create()
    StartThread(attachToCorpse)
    StartThread(lifeTimeLimited)
end