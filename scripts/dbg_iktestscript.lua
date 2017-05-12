include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"
include "lib_ik.lua"


function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"

piecesTable = {}
pieceNameTable = {}
for i = 1, 6 do
    sting = "bone" .. i
    piecesTable[#piecesTable + 1] = piece(sting)
end

function script.Create()
    --generatepiecesTableAndArrayCode(unitID)
    StartThread(iktest)
end

function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
    return 1
end

function echoPiecePosition(name, id)
    x, y, z = Spring.GetUnitPiecePosDir(unitID, id)
    Spring.Echo("Piece:" .. name .. " P(" .. x .. "/" .. y .. "/" .. z)
end

--FOOO load the new Version
function iktest()
    createIkChain(unitID, piecesTable[1], piecesTable[6])



    while true do
        Spring.Echo("Iktest alive")
        Sleep(10000)
    end
end