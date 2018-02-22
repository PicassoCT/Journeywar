STORYMAX = 4


function script.Killed()
    	return 1
end
function healingRest()
while true do
	if boolUnderAttack== false  then
		T= getAllNearUnit(unitID, 200)
		process(T,
				function(id)
				defID= Spring.GetUnitDefID(id)
					if defID and isInfantry[defID] then return id end
				end,
				function(id)
					hp= Spring.GetUnitHealth(id)
					Spring.SetUnitHealth(hp+5)
				end
				)
	Sleep(1000)
	end
end


function anybodyNearby()
    teamid = Spring.GetUnitTeam(unitID)
    T = Spring.GetUnitsInCylinder(x, z, 300, teamid)
    table.remove(T, unitID)
    if T and #T > 2 then
        local CompTable = {
            [UnitDefNames["bg"].id] = true,
            [UnitDefNames["bg2"].id] = true,
            [UnitDefNames["bg3"].id] = true,
            [UnitDefNames["css"].id] = true
        }
        count = 0
        for i = 1, #T do
            defID = Spring.GetUnitDefID(T[i])
            if CompTable[defID] == true then count = count + 1 end
            if count > 2 then return true end
        end
    end
    return false
end

function storyTime()
    local musicfiles = VFS.DirList("sounds/cFirePlace/", "*.ogg")

    Sleep(12000)
    if false == true and math.random(1, 12) == 6 and anybodyNearby() == true then
        SoundName = musicfiles[math.random(1, #musicfiles)]
        Spring.PlaySoundFile(SoundName, 0.9)
    end
end


function dinnerIsReady()
    RandNomNomNom = math.random(80000, 120000)
    Sleep(RandNomNomNom)
    Spring.DestroyUnit(unitID, false, true)
end

function script.Create()

    StartThread(dinnerIsReady)
    StartThread(FireTales)
    StartThread(healingRest)
end

function FireTales()
    if math.random(0, 1) == 1 then
        Time = math.ceil(math.random(42000, 60000))
        storyTime()
        Sleep(Time)
    end
end
