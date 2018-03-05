function gadget:GetInfo()
    return {
        name = "Grey Goo Chickens",
        desc = "Spawns and manages the GameOf Life Chicken Units",
        author = "",
        date = "Sep. 2008",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = false,
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_OS.lua")
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_Build.lua")
    VFS.Include("scripts/lib_jw.lua")

chickenUnitDefID = UnitDefNames["greygoo"].id
startPos= {x =5, z= 5}
gameGrid= {}
startPattern= {
			 {"oxo"},
			 {"xox"},
			 {"oxo"},
			 pos=startPos
				}

function defineGameGrid(mapSizeX,mapSizeZ, unitSize)
dx= math.floor(mapSizeX/unitSize)
dz= math.floor(mapSizeZ/unitSize)


local cell = {

				}
				
				
end
gameGrid = makeTable
	for x=1,dx do
	for z=1,dz do
		
	end
	end
	
end