include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


center=piece"center"
pieces={}
-- for i=1,NrOfPieces do
-- name="Deco"..i
-- pieces[#pieces+1]=piece"name"
-- Hide(pieces[#pieces])
-- end



function script.Create()

Turn(center,y_axis,math.rad(math.random(-360,360)),0)
Spring.SetUnitAlwaysVisible(unitID,true)
Spring.SetUnitNeutral(unitID,true)
StartThread(Emit)
end

function Emit()

local emitor=piece"emitor"
local i=0

	while i < 20000 do
	EmitSfx(emitor,1024)
	Sleep(10)
	i=i+10
	end

end

function script.Killed()


return 1
end