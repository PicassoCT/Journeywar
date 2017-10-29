include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}
SIG_DEATH = 32

function script.HitByWeapon(x, z, weaponDefID, damage)
end
center = piece"center"

function TimeOfMyLife()
    SetSignalMask(SIG_DEATH)
    Sleep(240000)
    Move(center, y_axis, -30, 3)
    WaitForMove(center, y_axis)
    Spring.DestroyUnit(unitID, false, false)
end


function contemplateOrigin()
    boolPositionUnchanged = true
    xo, yo, zo = Spring.GetUnitPosition(unitID)
    while (boolPositionUnchanged == true) do
        x, y, z = Spring.GetUnitPosition(unitID)
        if x ~= xo and z ~= zo then
            boolPositionUnchanged = false
            hideT(TablesOfPiecesGroups)
            Signal(SIG_DEATH)
        end
        Sleep(2000)
    end
end

function script.Create()
Turn(center,y_axis,math.rad(math.random(-360,360)),0)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	boolShowAtLeastOne= false
	numberOfOneFound=nil
	for name,tab in pairs(TablesOfPiecesGroups) do
		for num, pieceID in pairs(tab) do
				numberOfOneFound= pieceID
				if maRa()==true then Show(pieceID); boolShowAtLeastOne=true else Hide(pieceID) end		
		end
	end
	
	if boolShowAtLeastOne==false and numberOfOneFound then Show(numberOfOneFound) end
	    StartThread(TimeOfMyLife)
    StartThread(contemplateOrigin)
end

function script.Killed(recentDamage, _)

    return 1
end

