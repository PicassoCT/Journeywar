include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"
cegemit = piece "cegemit"
aimpiece = piece "eyes"
GatRetract = piece "GatRetract"

function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	configure()
	StartThread(soundBarrierDetection)
	StartThread(delayedConditionUpdate)
	StartThread(transformIntoAttackState)
end

function configure()
	resetT(TablesOfPiecesGroups)
	hideT(TablesOfPiecesGroups)
	Turn(center,y_axis,math.rad(180),0)
	Show(TablesOfPiecesGroups["Glow"][4])
	Show(aimpiece)
	Show(TablesOfPiecesGroups["Cone"][1])
	Show(TablesOfPiecesGroups["Body"][1])
	Show(TablesOfPiecesGroups["InnerWing"][1])
	Show(TablesOfPiecesGroups["Compress"][1])
	Show(TablesOfPiecesGroups["OuterWing"][1])
	Move(GatRetract,z_axis,-3,0)
	showT(TablesOfPiecesGroups["Antenna"])
end

speedOfSound= 200--elmo/s
myDefID= Spring.GetUnitDefID(unitID)
function soundBarrierDetection()
	
	Sleep(300)
	ox,oy,oz=Spring.GetUnitPosition(unitID)
	Sleep(100)
	timer= 12000
	while true do
	mx,my,mz = Spring.GetUnitPosition(unitID)

		if mx and ox and equal(distance(ox,oy,oz,mx,my,mz), speedOfSound, 10) and timer <= 0	then
			Spring.Echo("Cauterizer"..distance(ox,oy,oz,mx,my,mz))
			decide=math.random(1,2)
			StartThread(PlaySoundByUnitDefID, myDefID, "sounds/cauterizer/sonicboom"..decide..".ogg", 1, 10000, 1, 0)
			Sleep(4000)
		
			dx,dy,dz = ox-mx,oy-my,oz-mz
			
			Norm= math.sqrt(dx^2+dy^2+dz^2)
			EmitSfx(center, 1024)
	
			timer= 12000
		end
	timer= timer-300
	Sleep(300)
	ox,oy,oz=mx,my,mz
	end

end
function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
    return 1
end
--- -aimining & fire weapon 
function script.StartMoving()
    return true
end

function script.StopMoving()
    return true
end

--- -aimining & fire weapon 
function script.AimFromWeapon1()
    return aimpiece
end

function script.QueryWeapon1()
    return aimpiece
end

boolConditionFullfilled= false
function delayedConditionUpdate()
while true do
	Sleep(1000)
		x,y,z= getUnitMoveGoal(unitID)
		ux,uy,uz = Spring.GetUnitPosition(unitID)
		if x  and ux then
			boolConditionFullfilled = distance(ux,uy,uz, x,y,z) < 1000 
		end
	end
end
function script.AimWeapon1(Heading, pitch)
   
    return boolMoving and   boolConditionFullfilled
end

function script.FireWeapon1()
	--StartThread(transformIntoAttackState)
    return true
end
swing = piece"swing"
InnerWing = piece"InnerWing0"
OuterWing = piece"OuterWing0"
function transformAnimation()
tSyncIn(swing,90,0,0,4000)
WaitForTurns(swing)
Sleep(1000)
tSyncIn(swing,0,0,0,4000)
WaitForTurns(swing)
Sleep(1000)
-- tSyncIn(InnerWing,90,0,0, 3000)
-- tSyncIn(OuterWing,-180,0,0, 3000)
-- WaitForTurns(swing,InnerWing,OuterWing)
-- EmitSfx(center, 1024)

end

boolOnlyOnce = false
boolTransformComplete= false
function transformIntoAttackState()
	while true do
		--resetT(TablesOfPiecesGroups)
		configure()
		Sleep(1000)
		transformAnimation()
		Sleep(1000)
	end

if boolOnlyOnce == false then
 boolOnlyOnce = true else return end
Sleep(100)
Spring.MoveCtrl.Enable(unitID,true)



	while nil == transformUnitInto(unitID,"cauterizerdeployed") do
	Sleep(100) 
	end

end
