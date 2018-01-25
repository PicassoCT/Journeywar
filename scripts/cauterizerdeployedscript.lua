include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}


function script.HitByWeapon(x, z, weaponDefID, damage)
end
bodyCenter = piece"bodyCenter"
GattlingCenter = piece "GattlingCenter"
GattlingDeploy = piece "GattlingDeploy"
hoverPos = piece"hoverPos"
center = piece "center"
aimpiece = piece "aimpiece"
cegemit= piece"cegemit"

--Out
BodyO		= "BodyO"
outerFinO = piece "outerFinO"
innerFinO = piece "innerFinO"

OuterFinCenter 	= piece "OuterFinCenter"
InnerFinCenter 	= piece "InnerFinCenter"
--Firing
BodyF		="BodyF"
outerFinF 	= piece "outerFinF"
innerFinF 	= piece "innerFinF"

swingJet 	= piece "swingJet"

lifeTimeInMinutes = 3
AMMUNITION = 600

function script.Create()
  generatepiecesTableAndArrayCode(unitID)
  TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
  resetT(TablesOfPiecesGroups)
  StartThread(transformFromPlaneToDroneAnimation)
  StartThread(AnimationLoop)
end

function script.Killed(recentDamage, _)
  createCorpseCUnitGeneric(recentDamage)
  return 1
end

function AnimationLoop()
  StartThread(GattlingAnimation)
  while boolFireReady == false do
    Sleep(100)
  end

  while true do		
    while boolAiming == false do
      if boolMoving then
        directionalHoveringAnimation()
      else
        hoverInPlaceAnimation()
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

function GattlingAnimation()
  while boolFireReady == false do Sleep(100 ) end
  WMove(GattlingDeploy,x_axis, 3, 3)
  glowLevelGattlingT = TablesOfPiecesGroups["GatGlowLvl"]
  while AMMUNITION > 0 do
    Counter= 0
	glowIndex=1
    while boolCeasedFiring == false do 
      Spin(GattlingCenter,x_axis, math.rad(442),0.3)
      Counter= Counter + 1
	 glowIndex = math.max(1,math.min(math.ceil(glowIndex)+1, #glowLevelGattlingT))
	 hideT(glowLevelGattlingT)
	 Show(glowLevelGattlingT[glowIndex])
      if Counter > 5 then
        Hide(GattlingO)
        Show(GattlingF)
      else
        Hide(GattlingF)
        Show(GattlingO)
      end
    end
    Spin(GattlingCenter,x_axis, math.rad(0),0.3)
	glowIndex = math.max(1,glowIndex -0.1)
	hideT(glowLevelGattlingT)
	Show(glowLevelGattlingT[math.ceil(glowIndex)])
    Sleep(100)
  end
  WMove(GattlingDeploy,x_axis,0,1)
  StopSpin(GattlingCenter,x_axis,0.3)
end

function showDroneExaust()


end

--- -aimining & fire weapon Gattling
function script.AimFromWeapon1()
  return aimpiece
end

function script.QueryWeapon1()
  return aimpiece
end
function finalizeFunction()
--fire final starburst at last attacked enemy or last attacker
end
function transformFromPlaneToDroneAnimation()

  boolFireReady = false
  StartThread(PlaySoundByUnitDefID, myDefID, "sounds/cauterizer/howling.wav", 1, 2000, 1, 0)
	spawnCEGAtPiece(unitID, cegemit, "supersonic",0,0,0,0,true)
  for i=5, 90,5 do
    tSyncIn(swingJet,i,0,0,i*10)
    WaitForTurns(swingJet)
	if i > 45 then
		Turn(OuterFinCenter,x_axis,0)
		Turn(InnerFinCenter,x_axis,math.rad(90),3)
	end
  end
  Turn(OuterFinCenter,x_axis,0)
  Turn(InnerFinCenter,x_axis,math.rad(90),3)
  Show(BodyO)
  Hide(BodyF)
  Hide(outerFinO)
  Show(outerFinF)
  StartThread(lifeTime ,unitID, lifeTimeInMinutes* 60 * 1000, false, true, finalizeFunction)
  StartThread(showDroneExaust)
  movePieceToPiece(bodyCenter, swingJet,5)
  movePieceToPiece(swingJet, hoverPos,5)
  WaitForMoves(bodyCenter,swingJet)
  movePieceToPiece(swingJet, hoverPos,5)
  WaitForMoves(bodyCenter,swingJet)

  boolFireReady= true
end

boolFireReady = false
globalPitch= 0
function script.AimWeapon1(Heading, pitch)
  if boolFireReady == true then
    Turn(center,y_axis,Heading,3)
    globalPitch= pitch
    Turn(bodyCenter,x_axis,-pitch ,3)
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

function script.FireWeapon1()
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
  Turn(center,y_axis,0,0.5)
end

function script.StopMoving()
end

function script.Activate()

  return 1
end

function script.Deactivate()

  return 0
end
