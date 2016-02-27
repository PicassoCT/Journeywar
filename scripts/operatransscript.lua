include "AniMatrix.lua"
include "NeverEndingParty.lua"
include "suddenDeath.lua"
include "lib_UnitScript.lua"



local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
local loaded=false

Ragdolls={}
for i=1,10,1 do
if i~=9 then
Ragdolls[i]={}
 slot= "Rag"..i
Ragdolls[i]=piece (slot)
elseif i== 10 then
Ragdolls[9]={}
 slot= "Rag"..i
Ragdolls[9]=piece (slot)

end
end

sloth ={}
for i=1,5,1 do
sloth[i]={}
local slot= "slot"..i
sloth[i]=piece (slot)

end

-- include AnimMatrix.lua


local base = piece "operatrans"
local opcrane= piece "opcrane"
local operadoor1= piece"operadoor1"
local operadoor2=piece "operadoor2"
local testCenter1= piece "testCenter1"



local body1 = piece "oppod"
local oppod1gun1 =piece "oppod1gun1"
local flare1 = piece "flare1"
local oppod1gun2 =piece "oppod1gun2"
local flare2 = piece "flare2"
local opAttachP = piece "opAttachP"
local passengertable={}

local body2 = piece "oppod2"
local oppod2gun2 =piece "oppod2gun2"
local flare3 = piece "flare03"
local oppod2gun1 =piece "oppod2gun1"
local flare4 = piece "flare04"
-- declares all the pieces we'll use in the script.
local flipflop = true
local flipflop2=false
local SIG_AIM = 2
local SIG_REST=4
local SIG_BAY=8
local overhead=0
local cargo=0
local cargoMax=5
local RESTORE_DELAY = (Spring.UnitScript.GetLongestReloadTime(unitID) * 2 ) +1024
-- picks a sensible time to wait before trying to turn the turret back to default.


function script.Create()
Turn(testCenter1,x_axis,math.rad(5.8),0)
Turn(testCenter1,z_axis,math.rad(-4),0)
Hide(flare1)
Hide(flare2)
Hide(flare3)
Hide(flare4)
StartThread(PartyManager)
StartThread(CriticalHitDetector)
StartThread(costlyUnderAttack)

end

function script.StartMoving()
												
																								
end

function script.StopMoving()

end



local function RestoreAfterDelay()
    -- defines a local funtion to wait a bit, then move the turret back to how it was originally.

	Sleep(RESTORE_DELAY)

	------Spring.Echo("Phail reached")
	Turn(body1, y_axis,  math.rad(0),5)
	Turn(body1, x_axis, math.rad(0),5)
	Turn(body2, y_axis,  math.rad(0),5)
	Turn(body2, x_axis,  math.rad(0),5)
	Turn(oppod2gun2, x_axis, math.rad(0),5)
	Turn(oppod2gun1, x_axis, math.rad(0),5)
	Turn(oppod1gun2, x_axis, math.rad(0),5)
	Turn(oppod1gun1, x_axis, math.rad(0),5)
end

function script.AimWeapon1( heading, pitch)
	
    -- each time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same time.
	Turn(body1, y_axis, heading, 6)
	Turn(oppod1gun2, x_axis, -pitch,5)
	Turn(oppod1gun1, x_axis, -pitch,5)
	overhead=pitch
	
	WaitForTurn(body1, y_axis)
	WaitForTurn(oppod1gun2, x_axis)
	WaitForTurn(oppod1gun2, x_axis)

	StartThread(RestoreAfterDelay)
	return true
end

function script.QueryWeapon1() 

		if  (flipflop==true)
			then  flipflop=false
			 
			 return flare1
								else
								flipflop=true
								return flare2 
								end
	end

function script.FireWeapon1()
	EmitSfx(flare1, 1)
	EmitSfx(flare2, 1)
	
	Turn(oppod1gun2, x_axis, overhead-10,8)
	Turn(oppod1gun1, x_axis, overhead-10,8)

	return true
end

function script.AimFromWeapon1() 
return body1 end


	
	-- The piece that the bullet/laser/whatever comes out of.


function script.AimWeapon2( heading, pitch)
	
    -- each time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same time.
	Turn(body2, y_axis, heading, 6)
	Turn(oppod2gun2, x_axis, -pitch,5)
	Turn(oppod2gun1, x_axis, -pitch,5)
	overhead=pitch
	
	WaitForTurn(body2, y_axis)
	WaitForTurn(oppod2gun1, x_axis)
	WaitForTurn(oppod2gun2, x_axis)

	StartThread(RestoreAfterDelay)
	return true
end

function script.QueryWeapon2() 

		if  (flipflop2==true)
			then  flipflop2=false
			 
			 return flare3
								else
								flipflop2=true
								return flare4 
								end
	end

function script.FireWeapon2()
	EmitSfx(flare3, 1)
	EmitSfx(flare4, 1)
	
	Turn(oppod2gun2, x_axis, overhead-10,8)
	Turn(oppod2gun1, x_axis, overhead-10,8)

	return true
end

function script.AimFromWeapon2() 
return body2 end

function closeBaydoors()
SetSignalMask(SIG_BAY)
while(true==Spring.UnitScript.IsInMove (opcrane, y_axis)) do
Sleep(300)
end
Move(operadoor1,x_axis,0,2)
Move(operadoor1,z_axis,0,2)
Move(operadoor2,x_axis,0,2)
Move(operadoor2,z_axis,0,2)


end

function script.TransportPickup(passengerID)
	-- no napping!
	local passengerTeam = Spring.GetUnitTeam(passengerID)
	local ourTeam = Spring.GetUnitTeam(unitID)
	local gaiaTeamID=Spring.GetGaiaTeamID()
	if   Spring.AreTeamsAllied(passengerTeam,ourTeam)== false  and passengerTeam ~= gaiaTeamID then
	Spring.Echo("Opera Transport, doesent pick up Enemy Units")
		return
	end
Signal(SIG_BAY)
	
	--if opera has full house
	if cargo >= cargoMax then return end
	SetUnitValue(COB.BUSY, 1)
	Move(operadoor1,x_axis,-12,2)
	Move(operadoor1,z_axis,-14,2)
	Move(operadoor2,x_axis,12,2)
	Move(operadoor2,z_axis,-14,2)
	Spring.PlaySoundFile("sounds/cOperaT/opendoor.wav")
	WaitForMove(operadoor2,z_axis)
	WaitForMove(operadoor2,x_axis)
	WaitForMove(operadoor1,z_axis)
	WaitForMove(operadoor1,x_axis)
	
	
	
	local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
	local px2, py2, pz2 = Spring.GetUnitBasePosition(passengerID)
	local dx, dy , dz = px2 - px1, py2 - py1, pz2 - pz1
	local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID))/32768*math.pi
	local dist = (dx^2 + dy^2)^0.5
	
--openBayDoors

    if dist >128 then return end
    Move(opcrane,z_axis,dist,15)
	WaitForMove(opcrane,z_axis)
	Turn(base, y_axis, heading,9)
    WaitForTurn(base, y_axis)
	AttachUnit(opAttachP, passengerID)
	
	table.insert(passengertable,passengerID)
	Move(opcrane, z_axis, 0, 15)
	cargo=cargo+1
	WaitForMove(opcrane, z_axis)
	AttachUnit(sloth[cargo], passengerID)
	Spring.SetUnitNoDraw(passengerID,true) 
	Turn(base, y_axis, math.rad(0),19)
	loaded=true
	SetUnitValue(COB.BUSY, 0)
	StartThread(closeBaydoors)
end


function script.TransportDrop(passengerID, x, y, z)
	if loaded == false then return end
	--if unit not loaded
	notloaded=true
	for i=1,cargo,1 do
			if passengertable[i] == passengerID then
			notloaded=false
			end
	end
	
	if notloaded == true then return end
	
	SetUnitValue(COB.BUSY, 1)
	Signal(SIG_BAY)
	
	y = y - Spring.GetUnitHeight(passengerID) - 10
	local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
	local dx, dy , dz = x - px1, y - py1, z - pz1
	local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID))/32768*math.pi
	local dist = (dx^2 + dy^2)^0.5
	local angleV = math.atan(dy/dist)
	dist = dist/math.cos(angleV)	-- convert 2d distance (adjacent) to 3d dist (hypotenuse)


	Move(operadoor1,x_axis,-12,2)
	Move(operadoor1,z_axis,-14,2)
	Move(operadoor2,x_axis,12,2)
	Move(operadoor2,z_axis,-14,2)
	Spring.PlaySoundFile("sounds/cOperaT/opendoor.wav")
	WaitForMove(operadoor2,z_axis)
	WaitForMove(operadoor2,x_axis)
	WaitForMove(operadoor1,z_axis)
	WaitForMove(operadoor1,x_axis)
	Move(opcrane,z_axis,0,15)
	WaitForMove(opcrane, z_axis)
	
	AttachUnit(opAttachP, passengerID)
	Spring.SetUnitNoDraw(passengerID,false) 	
	Move(opcrane, z_axis, 50, 15)
	WaitForMove(opcrane, z_axis)

	DropUnit(passengerID)
	cargo=cargo-1

	if cargo<= 0 then
	loaded = false
	end

	Move(opcrane, z_axis,0,15)
	WaitForMove(opcrane, z_axis)
	
	StartThread(closeBaydoors)	
	SetUnitValue(COB.BUSY, 0)
end


LastDamage=0

	function script.HitByWeapon ( x, z, weaponDefID, damage )
	LastDamage=damage
	return damage
	end

SIGHT_DISTANCE=420

function costlyUnderAttack()
	id,olhp, hp = 0,0,0
	while true do

		if LastDamage> 0  then
			LastDamage=0
			Spring.UseUnitResource(unitID,"e",50)
			Spring.UseUnitResource(unitID,"m",5)
		
		end
		
		--Add Reward with Battles in Sight
		if id and oldhp > hp then
			if exists(id) == true and GetUnitDistance(id,uniID) < SIGHT_DISTANCE then
				Spring.AddUnitResource(unitID,"m",10)
				oldhp=hp
			end
		
		end
		
		
		id =Spring.GetUnitNearestEnemy(unitID)
		if id then
			hp=Spring.GetUnitHealth(id)	
		end
	Sleep(500)
	end
end




-- The unit looks from this piece down the QueryWeapon piece, to see whether it's aiming at anything.

function script.Killed(recentDamage, maxHealth)
	for i=1,8,1 do
			Explode(Ragdolls[i],SFX.FIRE+SFX.FALL)
			tempVal=dramatisPersona[i][11]
					for a=1,tempVal,1 do
					------Spring.Echo("I:",i .."    A:", a)
					Hide(dramatisPersona[i][3][a])	
					end
			Sleep(80)
	end
	random=math.random(-1,1)
	if random==0 then
	random=1
	end
	random=random*65
	Explode(operadoor1,SFX.FIRE+SFX.FALL)
	Hide(operadoor1)
	Explode(operadoor2,SFX.FIRE+SFX.FALL)
    Hide(operadoor2)
	Turn(base,x_axis,math.rad(10),0.2)
	Turn(base,z_axis,math.rad(random),0.5)
	Explode (body1, SFX.FIRE+SFX.FALL)
	Hide(body1)
	Explode (body2, SFX.FIRE+SFX.FALL)
	Hide(body2)
	WaitForTurn(base,z_axis)
	unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
	Spring.SpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
	suddenDeathV(recentDamage)
	i=1+1
end

function script.AimWeapon3( heading, pitch)
	
    -- each time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same time.
	Turn(body1, y_axis, heading, 6)
	Turn(oppod1gun2, x_axis, -pitch,5)
	Turn(oppod1gun1, x_axis, -pitch,5)
	overhead=pitch
	
	WaitForTurn(body1, y_axis)
	WaitForTurn(oppod1gun2, x_axis)
	WaitForTurn(oppod1gun2, x_axis)

	StartThread(RestoreAfterDelay)
	return true
end

function script.QueryWeapon3() 

		if  (flipflop==true)
			then  flipflop=false
			 
			 return flare1
								else
								flipflop=true
								return flare2 
								end
	end

function script.FireWeapon3()
	EmitSfx(flare1, 1)
	EmitSfx(flare2, 1)
	
	Turn(oppod1gun2, x_axis, overhead-10,8)
	Turn(oppod1gun1, x_axis, overhead-10,8)

	return true
end

function script.AimFromWeapon3() 
return body1 end


	
	-- The piece that the bullet/laser/whatever comes out of.


function script.AimWeapon4( heading, pitch)
	
    -- each time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same time.
	Turn(body2, y_axis, heading, 6)
	Turn(oppod2gun2, x_axis, -pitch,5)
	Turn(oppod2gun1, x_axis, -pitch,5)
	overhead=pitch
	
	WaitForTurn(body2, y_axis)
	WaitForTurn(oppod2gun1, x_axis)
	WaitForTurn(oppod2gun2, x_axis)

	StartThread(RestoreAfterDelay)
	return true
end

function script.QueryWeapon4() 

		if  (flipflop2==true)
			then  flipflop2=false
			 
			 return flare3
								else
								flipflop2=true
								return flare4 
								end
	end

function script.FireWeapon4()
	EmitSfx(flare3, 1)
	EmitSfx(flare4, 1)
	
	Turn(oppod2gun2, x_axis, overhead-10,8)
	Turn(oppod2gun1, x_axis, overhead-10,8)

	return true
end

function script.AimFromWeapon4() 
return body2 end

