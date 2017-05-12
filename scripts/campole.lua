include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"



function script.Create()

    --<buildanimationscript>
    x, y, z = Spring.GetUnitPosition(unitID)
    teamID = Spring.GetUnitTeam(unitID)
    GG.UnitsToSpawn:PushCreateUnit("cbuildanimation", x, y, z, 0, teamID)


    --</buildanimationscript>

    StartThread(speachHolder)
    StartThread(resourceConverterLoop)
end

boolRessourceConverting = false
function speachHolder()
    local unitDefID = Spring.GetUnitDefID(unitID)

    while (true) do
        if boolRessourceConverting == true then
            speach = math.random(0, 9)
            if speach == 1 then
                PlaySoundByUnitDefID(unitDefID, "sounds/ccampole/speecha.wav", 1, 9000, 0.1)
            elseif speach == 2 then
                PlaySoundByUnitDefID(unitDefID, "sounds/ccampole/speechb.wav", 1, 9000, 0.1)
            elseif speach == 3 then
                PlaySoundByUnitDefID(unitDefID, "sounds/ccampole/speechc.wav", 1, 9000, 0.1)
            elseif speach == 4 then
                PlaySoundByUnitDefID(unitDefID, "sounds/ccampole/speechd.wav", 1, 9000, 0.1)
            elseif speach == 5 then
                PlaySoundByUnitDefID(unitDefID, "sounds/ccampole/speeche.wav", 1, 9000, 0.1)
            end
        end
        Sleep(15000)
        well = math.ceil(math.random(80000, 180000))
        Sleep(well)
    end
end


function resourceConverterLoop()
    while true do
        if Spring.UseUnitResource(unitID, "energy", 48 * 1.5) == true then
            boolRessourceConverting = true
            Spring.AddUnitResource(unitID, "m", 2)
        else
            boolRessourceConverting = false
        end
        Sleep(1000)
    end
end

function script.Killed()
end