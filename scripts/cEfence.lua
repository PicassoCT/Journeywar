include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 


local boolImInCharge=false

--pieces
local efence= piece"efence"
local efencegat0 =piece"efencegat0"
local efencegate =piece"efencegate"
local eTow1 =piece"eTow1"
local eTow2 =piece"eTow2"
local eTow3 =piece"eTow3"
local eTow4 =piece"eTow4"
local eTow5 =piece"eTow5"
local eTow6 =piece"eTow6"
local eTow7 =piece"eTow7"

turretTable= {}
 table.insert (turretTable,eTow1)
 table.insert (turretTable,eTow2)
 table.insert (turretTable,eTow3)
 table.insert (turretTable,eTow4)
 table.insert (turretTable,eTow5)
 table.insert (turretTable,eTow6)
 table.insert (turretTable,eTow7)
 local boolSoundFinnished1=true
 local boolSoundFinnished2=true
 local boolSoundFinnished3=true
 local boolSoundFinnished4=true
 local boolSoundFinnished5=true
 local boolSoundFinnished6=true
 local boolSoundFinnished7=true




local etowItterator=1

local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_OPEN = 4  --signal for the weapon aiming thread
local SIG_CLOSE = 8  --signal for the weapon aiming thread

function showALittleLight()
while (true) do
if boolImInCharge==false then
EmitSfx(eTow1,1025)
else
EmitSfx(eTow1,1026)
end
Sleep(180)
end
end

prevInCharge=false
unitdef=Spring.GetUnitDefID(unitID)

function chargeUp(boolischarged)
prevInCharge=boolImInCharge
boolImInCharge=boolischarged

	if prevInCharge==false and boolImInCharge==true then
		if maRa()==true then
		PlaySoundByUnitType(unitdef, "sounds/cEfence/Activate.ogg",0.9, 5000,1)
		else
		PlaySoundByUnitType(unitdef, "sounds/cEfence/chargingUp.wav",0.9, 70000,1)
		end
	elseif prevInCharge==true and boolImInCharge==false then
	PlaySoundByUnitType(unitdef, "sounds/cEfence/DeActivate.ogg",0.9, 5000,1)
	end


----Spring.Echo("Im shocked,Sir, shoked and appalled! Have you ever thought about energy conservation?!")
end


function script.QueryBuildInfo() 
	return buildspot	--the unit will be constructed at the position of this piece
end



function script.QueryNanoPiece()

     return buildspot
end



function openGate()
--Spring.Echo("startopen")
--Open Gate Animation
Spring.PlaySoundFile("sounds/cEfence/openGate.wav")
Signal(SIG_CLOSE)
SetSignalMask(SIG_OPEN)
local aRandomVal=math.random(0,2)
local innerGateSpeed=0.5

if aRandomVal == 0 then
--Spring.Echo("openend0")
Turn(efencegat0,x_axis,math.rad(-91),3)
WaitForTurn(efencegat0,x_axis)



elseif aRandomVal == 1 then
--Spring.Echo("openend1")
		--------------------------------------------------------------
		
					Turn(efencegat0,x_axis,math.rad(-52),3)
					local i=7.0
					Turn(efencegate,x_axis,math.rad((52)),1)
					Sleep(250)
					Turn(efencegat0,x_axis,math.rad(-100),0.5)
				while(i < 0.1 or i > -0.1 ) do
					Turn(efencegate,x_axis,math.rad((100+i)),innerGateSpeed)
					local x=(math.random(5,8))/10
					
						if innerGateSpeed >0.1 then
						innerGateSpeed=innerGateSpeed*x
						end
					
					i=i*x*-1
					WaitForTurn(efencegate,x_axis)
					
						Sleep(45)
					end
					Sleep(1000)
					WaitForTurn(efencegat0,x_axis)
					
					Turn(efencegat0,x_axis,math.rad(-149),3)
					 i=7.0
					Turn(efencegate,x_axis,math.rad((149)),2)
					
				while(i < 0.1 or i > -0.1 ) do
					Turn(efencegate,x_axis,math.rad((149+i)),innerGateSpeed)
					   local x=(math.random(7,9))/10
					
						if innerGateSpeed >0.1 then
						innerGateSpeed=innerGateSpeed*x
						end
					
					i=i*x*-1
					WaitForTurn(efencegate,x_axis)
						Sleep(45)
				
					
					end
					WaitForTurn(efencegat0,x_axis)

		
		
else 
--Spring.Echo("openendelse")
		randAMath=math.random(0,1)
		local i=7.0
				if randAMath == 1 then
				local datValue= math.random (100,179)
				Turn(efencegat0,x_axis,math.rad(-179),3)
							Turn(efencegate,x_axis,math.rad((datValue)),1.4)
							while( i < 0.1 or i > -0.1 )do
								Turn(efencegate,x_axis,math.rad((datValue+i)),innerGateSpeed)
								local x=(math.random(7,9))/10
									if innerGateSpeed >0.1 then
									innerGateSpeed=innerGateSpeed*x
									end
								i=i*x*-1
								WaitForTurn(efencegate,x_axis)
								Sleep(45)
							
								
							
							end
				else
						Turn(efencegat0,x_axis,math.rad(-174),3)
						Turn(efencegate,x_axis,math.rad(174),3)
						 i=7.0
						while(i < 0.1 or i > -0.1 ) do
									Turn(efencegate,x_axis,math.rad((174+i)),innerGateSpeed)
									local x=(math.random(7,9))/10
									if innerGateSpeed >0.1 then
									innerGateSpeed=innerGateSpeed*x
									end
									i=i*x*-1
									WaitForTurn(efencegate,x_axis)
									Sleep(45)
								
						  end
				end
WaitForTurn(efencegat0,x_axis)
--Spring.Echo("openend")

end

--Play Open Gate Sound



--Spring.Echo("endOpen")
end

function closeGate()
--Close Gate Animation
--Play Close Gate Sound
--Spring.Echo("startclose")
Signal(SIG_OPEN)
SetSignalMask(SIG_CLOSE)
Spring.PlaySoundFile("sounds/cEfence/openGate.wav")

Turn(efencegat0,x_axis,math.rad(45),2)
Turn(efencegate,x_axis,math.rad(45),2)
WaitForTurn(efencegat0,x_axis)
WaitForTurn(efencegate,x_axis)

Spring.PlaySoundFile("sounds/cEfence/closegate.wav")
Turn(efencegat0,x_axis,math.rad(0),3.5)

WaitForTurn(efencegat0,x_axis)
Turn(efencegate,x_axis,math.rad(0),3.5)
WaitForTurn(efencegate,x_axis)

--Spring.Echo("endclose")

end


function script.Activate()
	SetUnitValue(COB.YARD_OPEN, 1)
	--SetUnitValue(COB.INBUILDSTANCE, 1)
   Signal(SIG_CLOSE)
   StartThread(openGate)
   --Sleep(50)
	return 1
end

function script.Deactivate()
	SetUnitValue(COB.YARD_OPEN, 0)
	--SetUnitValue(COB.YARD_OPEN, 0)
    Signal(SIG_OPEN)
    StartThread(closeGate)
	--Sleep(50)
	return 0
end


--------BUILDING---------
function script.StopBuilding()
	
end

-- function checkCharged()
-- while (true) do
-- Sleep(1200)
	-- if boolImInCharge== true then
-- --	StartThread(openGate) --JustTestwise
	-- ----Spring.Echo("Danger, Danger, High Voltage!")
	-- end
-- end
-- end



function script.Create()

--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)


GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)


--</buildanimationscript>
--StartThread(checkCharged)
 StartThread(closeGate)
end



function script.StartBuilding(heading, pitch)	
return true
end





---AIMING & SHOOTING---
-----------------------------------------WEAPON ONE ----------------------------
function script.AimFromWeapon1() 
    	return turretTable[1] 
end

function script.QueryWeapon1() 
	return turretTable[1] 
end


function script.AimWeapon1( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished1==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon1()
boolSoundFinnished1=false
oneInThree=math.random(0,2)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished1=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished1=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished1=true
end
end
--------------------------------------------------------------------------------
-----------------------------------------WEAPON TWO ----------------------------
function script.AimFromWeapon2() 
    	return turretTable[2] 
end

function script.QueryWeapon2() 
	return turretTable[2] 
end


function script.AimWeapon2( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished2==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon2()
boolSoundFinnished2=false
oneInThree=math.random(0,3)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished2=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished2=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished2=true
end
if oneInThree == 3 then
Spring.PlaySoundFile("sounds/cEfence/electric_loop.wav") 
Sleep(4000)
boolSoundFinnished2=true
end
end
--------------------------------------------------------------------------------
-----------------------------------------WEAPON Three ----------------------------
function script.AimFromWeapon3() 
    	return turretTable[3] 
end

function script.QueryWeapon3() 
	return turretTable[3] 
end


function script.AimWeapon3( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished3==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon3()
boolSoundFinnished3=false
oneInThree=math.random(0,2)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished3=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished3=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished3=true
end
end
--------------------------------------------------------------------------------
-----------------------------------------WEAPON FOUR ----------------------------
function script.AimFromWeapon4() 
    	return turretTable[4] 
end

function script.QueryWeapon4() 
	return turretTable[4] 
end


function script.AimWeapon4( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished4==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon4()
boolSoundFinnished4=false
oneInThree=math.random(0,2)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished4=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished4=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished4=true
end
end
--------------------------------------------------------------------------------
-----------------------------------------WEAPON FIVE ----------------------------
function script.AimFromWeapon5() 
    	return turretTable[5] 
end

function script.QueryWeapon5() 
	return turretTable[5] 
end


function script.AimWeapon5( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished5==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon5()
boolSoundFinnished5=false
oneInThree=math.random(0,2)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished5=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished5=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished5=true
end
end
--------------------------------------------------------------------------------
-----------------------------------------WEAPON 6 ----------------------------
function script.AimFromWeapon6() 
    	return turretTable[6] 
end

function script.QueryWeapon6() 
	return turretTable[6] 
end


function script.AimWeapon6( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished6==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon6()
boolSoundFinnished6=false
oneInThree=math.random(0,2)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished6=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished6=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished6=true
end
end
--------------------------------------------------------------------------------
-----------------------------------------WEAPON 7 ----------------------------
function script.AimFromWeapon7() 
    	return turretTable[7] 
end

function script.QueryWeapon7() 
	return turretTable[7] 
end


function script.AimWeapon7( heading, pitch )

	
	SetSignalMask(SIG_AIM)
   if boolImInCharge==true and boolSoundFinnished7==true then
	return true
   else
   return false
   end
   
end

function script.FireWeapon7()
boolSoundFinnished7=false
oneInThree=math.random(0,2)
if oneInThree == 0 then
Spring.PlaySoundFile("sounds/cEfence/eSpark1.wav") 
Sleep(2000)
boolSoundFinnished7=true
end
if oneInThree == 1 then
Spring.PlaySoundFile("sounds/cEfence/eSpark2.wav") 
Sleep(2000)
boolSoundFinnished7=true
end
if oneInThree == 2 then
Spring.PlaySoundFile("sounds/cEfence/eSpark3.wav") 
Sleep(2000)
boolSoundFinnished7=true
end
end
--------------------------------------------------------------------------------


function script.Killed(recentDamage, maxHealth)
	Explode(efencegat0,SFX.FALL)
			Explode(efencegate,SFX.FIRE)
			
		return 1 
end