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
	--StartThread(transformIntoAttackState)
end

function configure()
	resetT(TablesOfPiecesGroups)
	hideAll(unitID)
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
	timer= 0
	while true do
	mx,my,mz = Spring.GetUnitPosition(unitID)

		if mx and ox and equal(distance(ox,oy,oz,mx,my,mz), speedOfSound, 10) and timer <= 0	then
		--	Spring.Echo("Cauterizer"..distance(ox,oy,oz,mx,my,mz))
			decide=math.random(1,3)
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
boolMoving=false
function script.StartMoving()
boolMoving=true  
  return true
end

function script.StopMoving()
boolMoving=false    
	return true
end

--- -aimining & fire weapon 
function script.AimFromWeapon1()
    return aimpiece
end

function script.QueryWeapon1()
    return aimpiece
end



function script.AimWeapon1(Heading, pitch)

    return boolOnlyOnce == false 
end

function script.FireWeapon1()
	StartThread(transformAnimation)
    return true
end

function configureHoverDrone()
	hideAll(unitID)
	showT(TablesOfPiecesGroups["Antenna"])
	Move(GatRetract,z_axis,0,7)
	Show(TablesOfPiecesGroups["Glow"][1])
	Show(aimpiece)
	StartThread(delayedShowAndTell,TablesOfPiecesGroups["Glow"], 1500,4,1)
	Show(TablesOfPiecesGroups["Cone"][2])
	Show(TablesOfPiecesGroups["Body"][2])
	Show(TablesOfPiecesGroups["InnerWing"][2])
	Show(TablesOfPiecesGroups["Compress"][2])
	Show(TablesOfPiecesGroups["OuterWing"][2])
	for i=1,3 do		
		Move(TablesOfPiecesGroups["Antenna"][i],z_axis, -5*i,15)
	end
end

swing = piece"swing"
InnerWing = piece"InnerWing0"
OuterWing = piece"OuterWing0"
Emittor = piece"Body0"
HoverPoint = piece"HoverPoint"
function transformAnimation()
	Spring.MoveCtrl.Enable(unitID)
	StartThread(PlaySoundByUnitDefID, myDefID, "sounds/cauterizer/sonicboom2.ogg", 1, 10000, 1, 0)

	tSyncIn(InnerWing,90,0,0, 2000)
	tSyncIn(OuterWing,-179,0,0, 2000)
	tSyncIn(swing,90,0,0,1000)
	Sleep(250)
	EmitSfx(Emittor, 1024)
	WaitForTurns(swing,InnerWing,OuterWing)
	tSyncIn(Emittor,74,0,0,3000)
	tSyncIn(swing,0,0,0,3000)
	mSyncIn(Emittor, 0,15,0, 2000)
	configureHoverDrone()
	StartThread(smallCorrections)
	WaitForMoves(Emittor,swing)
	WaitForTurns(swing,Emittor)
	transformUnitInto(unitID,"cauterizerdeployed")
end

function smallCorrections()
	while true do 

	tSyncIn(InnerWing,math.random(-20,-10),0,0, 1000)
	tSyncIn(OuterWing,math.random(-5,5),0,0, 1000)
	Sleep(1000)
	end


end

function delayedShowAndTell(T,delay,start, ends)
val= -1
	for i=start,ends, val do
		if T[i+1] then
			Hide(T[i+1])
		end
		if T[i] then
			Show(T[i])
		end
	Sleep(delay)
	end

end
boolOnlyOnce = false
boolTransformComplete= false
function transformIntoAttackState()

if boolOnlyOnce == false then
 boolOnlyOnce = true
 else 
 return end
transformAnimation()

end
