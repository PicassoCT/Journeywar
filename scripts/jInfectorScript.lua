include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_jw.lua"
include "lib_Build.lua"

center = piece "center"


RANGEOFINFLUENCA = 1300
FactoryTypeTable = getFactoryTypeTable(UnitDefNames, "IwantItAll")
function updateFactorys(OldFactoryTable)

    x, y, z = Spring.GetUnitPosition(unitID)
    proChoice = {}
    proChoice = Spring.GetUnitsInCylinder(x, z, RANGEOFINFLUENCA)
    --proChoice if
    for i=1,#proChoice do if proChoice[i]== unitID then table.remove(proChoice,i) end; end
	
	proChoice = process(
						function(id)
						defID= Spring.GetUnitDefID(id)
							if FactoryTypeTable[defID] then 
								return id 
							end
						end,
						function(id)
							if not OldFactoryTable[id] then OldFactoryTable[id] = id end
						end
						)
   


    return OldFactoryTable
end


boolFullGrown = 0
function delayedAppearance()
    Move(center, y_axis, 375, 1)
    while true do
        --should be fullgrown by then..
        boolFullGrown = math.min(boolFullGrown + 0.0002666666666666666, 100)
        Sleep(1000)
    end
end






function Loop()
   

    FactoryTable = {}
	FactorysWithAssignedTyrion={}
    while true do
		 if GG.Traitors == nil then GG.Traitors = {} end
		 teamID = Spring.GetUnitTeam(unitID)
        --updateFactorys
        FactoryTable = updateFactorys(FactoryTable)
        --GetTheUnitsTheyAreCurrentlyBuilding
		process(FactoryTable,
				function(id)
					if not FactorysWithAssignedTyrion[id] then
						TurnHimToTheDorkSide = Spring.CreateUnit("jtyrion", 0, 0, 0, 0, teamID)
						GG.Traitors[TurnHimToTheDorkSide] = id
						actorysWithAssignedTyrion[id]= TurnHimToTheDorkSide
					end
				
				end
				)	
    end
end

function script.Create()
    StartThread(Loop)
    StartThread(delayedAppearance)
end

function script.Killed()

    return 0
end



			