
function script.HitByWeapon ( x, z, weaponDefID, damage )




return 0
end


Emitor=piece"Emitor"
function script.Create()
Spring.MoveCtrl.Enable(unitID,true)
HeightsTable={}
x,HeightsTable[1],z=Spring.GetUnitPosition(unitID)

HeightsTable[5],HeightsTable[2],HeightsTable[3],HeightsTable[4]=Spring.GetGroundHeight(x,z-150),Spring.GetGroundHeight(x+150,z),Spring.GetGroundHeight(x-150,z),Spring.GetGroundHeight(x,z+150)
max=50

for i=1,#HeightsTable,1 do
	if HeightsTable[i] > max then
	max=HeightsTable[i]
	end
end

Spring.MoveCtrl.SetPosition(unitID,x,max-10,z)
Spring.SetUnitNeutral(unitID,true)
Turn(Emitor,x_axis,math.rad(90),0)
Hide(Emitor)
StartThread(Emit)
end


function Emit()
defID=Spring.GetUnitDefID(unitID)
local emit=1024
if defID==UnitDefNames["actionzone"].id then emit=1025 end
if defID==UnitDefNames["reservoirzone"].id then emit=1026 end
	while true do
	EmitSfx(Emitor,emit)
	Sleep(10)
	end

end

function script.Killed(recentDamage,_)
return 0
end



