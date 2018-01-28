include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}


function script.HitByWeapon(x, z, weaponDefID, damage)
end
center = piece"center"
GRing = piece "GRing"
GatRetract = piece "GatRetract"
HoverPoint = piece"HoverPoint"
center = piece "center"
aimpiece = piece "eyes"

--Out
GatRetract= piece"GatRetract"

--Firing
Body		=piece-----------------------------------------------"Body0"


lifeTimeInMinutes = 3
AMMUNITION = 100

function configure()
resetT(TablesOfPiecesGroups)
	
	hideAll(unitID)
	showT(TablesOfPiecesGroups["Antenna"])
	Move(GatRetract,z_axis,0,7)
	Show(TablesOfPiecesGroups["Glow"][1])
	Show(aimpiece)
	Show(TablesOfPiecesGroups["Cone"][2])
	Show(TablesOfPiecesGroups["Body"][2])
	Show(TablesOfPiecesGroups["InnerWing"][2])
	Show(TablesOfPiecesGroups["Compress"][2])
	Show(TablesOfPiecesGroups["OuterWing"][2])
	for i=1,3 do		
		Move(TablesOfPiecesGroups["Antenna"][i],z_axis,i*-
		5, 0)
	end
end


function script.Create()
  generatepiecesTableAndArrayCode(unitID)
  TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)

  configure()
  StartThread(AnimationLoop)
end

function script.Killed(recentDamage, _)
  createCorpseCUnitGeneric(recentDamage)
  return 1
end
boolAiming= false 
boolMoving= false
function AnimationLoop()
  StartThread(GattlingAnimation)
 
  while true do		
    while boolAiming == false do
      if boolMoving == true  then

        directionalHoveringAnimation()
      else
	  Spring.Echo("Hovering Segway")
        hoverSegway(
					  Body,
					 InnerWing, 
					 HoverPoint,
					 50, 
					 -90,
					 90,
					 x_axis, 
					 function(axis) return select(1,Spring.UnitScript.GetPieceRotation(Body)) end,
					 function() return boolMoving end, 
					 math.pi/10,
					 math.pi
					 )
      end
      Sleep(10)
    end

    while boolAiming == true do
      compensateForBodyRotationAnimation()
      Sleep(10)
    end
    Sleep(10)
  end
end
function directionalHoveringAnimation()
Spring.Echo("TODO:directionalHoveringAnimation")
end

function compensateForBodyRotationAnimation()
Turn(InnerWing,x_axis,-globalPitch,15)
Turn(OuterWing,x_axis,globalPitch,15)

end
function finalizeFunction()
--fire final starburst at last attacked enemy or last attacker
end

function GattlingAnimation()

  
  glowLevelGattlingT = TablesOfPiecesGroups["Glow"]
  while AMMUNITION > 0 do
	glowIndex=1
	Spin(GRing,z_axis, math.rad(142),12)
    while boolCeasedFiring == false do 
		glowIndex = math.max(1,math.min(math.ceil(glowIndex+1), #glowLevelGattlingT))
		hideT(glowLevelGattlingT)
		Show(glowLevelGattlingT[glowIndex])
		Sleep(1000)
    end
    Spin(GRing,z_axis, math.rad(0),0.3)
	glowIndex = math.max(1,glowIndex -0.01)
	hideT(glowLevelGattlingT)
	Show(glowLevelGattlingT[math.ceil(glowIndex)])
    Sleep(100)
  end
  WMove(GatRetract,x_axis,-5,1)
  StopSpin(GRing,z_axis,0.3)
end

function showDroneExaust()


end

--- -aimining & fire weapon Gattling
function script.AimFromWeapon1()
  return GatRetract
end

function script.QueryWeapon1()
  return GatRetract
end

boolFireReady = true
globalPitch= 0
function script.AimWeapon1(Heading, pitch)
  if boolFireReady == true then
	boolAiming=true
    Turn(center,y_axis,Heading,3)
    globalPitch= pitch
    Turn(center,x_axis,-pitch ,3)
    WaitForTurn(center,y_axis)
    WaitForTurn(center,x_axis)
	
  end
  return boolFireReady ==true and AMMUNITION > 0
end
boolCeasedFiring = true

function delayedDeactivationGun()
  boolCeasedFiring= false
  Signal(SIG_STOPFIRING)
  SetSignalMask(SIG_STOPFIRING)
  Sleep(350)
  boolCeasedFiring = true
end

myDefID = Spring.GetUnitDefID(unitID)

function script.FireWeapon1()
	boolAiming=false
	StartThread(PlaySoundByUnitDefID, myDefID, "sounds/cauterizer/attack.ogg", 1, 1500 , 1, 0)
	StartThread(delayedDeactivationGun)
  Spring.Echo("Cauterizer:: Ammunition ".. AMMUNITION)
  AMMUNITION = AMMUNITION -1
  return true
end

--- -aimining & fire weapon Suicide Starburst
function script.AimFromWeapon2()
  return aimpiece
end


function script.QueryWeapon2()
  return aimpiece
end

boolOneShot = true
function script.AimWeapon2(Heading, pitch)
  --aiming animation: instantly turn the gun towards the enemy

  return AMMUNITION < 1 and boolOneShot == true
end

function foldAnimation()

  boolOneShot = false
  StartThread(finalizeFunction)
end

function script.FireWeapon2()	
  foldAnimation()

  return true
end



function script.StartMoving()
	boolMoving= true
  Turn(center,y_axis,0,0.5)
end

SIG_STOP = 2

function delayedStop()
Signal(SIG_STOP)
SetSignalMask(SIG_STOP)
Sleep(250)
boolMoving = false
end

function script.StopMoving()
StartThread(delayedStop)
end

function script.Activate()

  return 1
end

function script.Deactivate()

  return 0
end
