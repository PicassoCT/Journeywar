
function gadget:GetInfo()
	return {
		name	  = "Units having nice moments with tractor gun ya",
		desc	  = "This gadget handles the units get attracted to ComEnder gun and then trew into another unit, Intentionally this gadget doesn't refer to specific unit, means that can be used for another unit instead of just ComEnder's :D",
		author	= "Cubex (aka the 3rd crazy guy of Spring community)",
		date	  = "2013-04-19 18:33:52",
		license   = "PAUATP v4 (Print And Use As Toilet Paper ver 4), but at least leave my author name ;)",
		layer	 = 8-2/2+3*3/2-11.5, --No worry, its 0
		enabled   = true,
	}
end

--Here we use "Tractored" or "In transit" to refer those unit under tractor beam effect
--"Captured" refers unit that are attached to tractor'ing unit, has nothing to do with any TAism or unit being team transfered, thanks for your intergalactic apologies

--Requirements:

--1 - Units that have tractorbeam must have the corresponding BlockShot* of the weapon, calling GG.NotifyBlockShot(unitID, weaponNum)
--	Example for weapon 2:

-- 		function script.BlockShot2()
-- 			return GG.NotifyBlockShot(unitID, 2) 
--		end

--2 - tractorbeam weaponDef must have this if you want to be usable with allied units
--		no worry, tractor only affecs the unit which is targeting, so ever if allied unit get in line, they are ignored (but blocks tractor beam)

--		avoidFriendly = false,


---BOTH CODE---

--Constants
local CMD_NOOP = { --No operation cmd (used for making unit non attackable etc...)
		id = 39999,
		type = CMDTYPE.ICON,
		name = "No Operation",
		tooltip = "Does Nothing",
		cursor = "cursornormal",
		hidden = true,
}
local CMD_NOOP_ID = CMD_NOOP.id

if gadgetHandler:IsSyncedCode() then ----SYNCED CODE----

--Speedups
local spEcho = Spring.Echo
local spGetUnitWeaponVectors = Spring.GetUnitWeaponVectors
local spSetUnitVelocity = Spring.SetUnitVelocity
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitVectors = Spring.GetUnitVectors
local spGetUnitPiecePosition = Spring.GetUnitPiecePosition
local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
local spGetUnitHeading = Spring.GetUnitHeading
local spSetUnitNoSelect = Spring.SetUnitNoSelect
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetUnitCommands = Spring.GetUnitCommands
local spAddUnitImpulse = Spring.AddUnitImpulse
local spGetGroundHeight = Spring.GetGroundHeight
local spDestroyUnit = Spring.DestroyUnit
local spGetUnitCollisionVolumeData = Spring.GetUnitCollisionVolumeData
local spGetUnitsInSphere = Spring.GetUnitsInSphere
local spAddUnitDamage = Spring.AddUnitDamage 
local spGetUnitVelocity = Spring.GetUnitVelocity
local spGetUnitDefID = Spring.GetUnitDefID
local spTransferUnit = Spring.TransferUnit
local spSetUnitNeutral = Spring.SetUnitNeutral
local spGetUnitHealth = Spring.GetUnitHealth
local spSetUnitHealth = Spring.SetUnitHealth
local spSetUnitWeaponState = Spring.SetUnitWeaponState
local spGetUnitHeight = Spring.GetUnitHeight

local mcEnable = Spring.MoveCtrl.Enable
local mcDisable = Spring.MoveCtrl.Disable
local mcSetPhysics = Spring.MoveCtrl.SetPhysics
local mcSetVelocity = Spring.MoveCtrl.SetVelocity

local sqrt = math.sqrt
local rad = math.rad
local atan2 = math.atan2
local max = math.max
local sub = string.sub
local tonumber = tonumber

--Variables
local UnitInTransitCounter=0
_G.unitAffected = {} --All unit that are in movectrl control, example: being tractored/captured... format {victimUnit = tractorUnit}. used for reversal lookup when a victim unit is destroyed, so we know which tractor is need to delete
local unitTractor = {} --Table where each unit with tractor weapon is saved, format is {unitID = tractorPiece} where tractorPiece is piece from beam is fired
local unitTractoring = {} --Tractors that are already tractoring a unit, format {TractorUnitID = InTransitUnitID}
local unitInTransit = {} --All units that are being tractored, timeout part means the gameframes passed since last tractor beam touched the unit, used to discard tractoring, table format {CapturedUnitID = {TractorUnitID, Timeout}
local unitCaptured = {} --Table where the each unit that had captured unit is saved, format {TractorUnitID = CapturedUnitID}
local unitShotReady = {} --List of unit with tractor that has been intercepted and blocked because of carrying a unit in tractor gun, means that we must trow the unit to enemy! format {TractorUnitID = aimVector}
local unitReload = {} --each unit's tractor beam reload time left
local unitLaunched = {} --Units that are launched 

--Constants
local TRACTOR_DEF_NAME = "tractorbeam"--"sentrygun"--
local TRACTOR_DEF_ID =  WeaponDefNames[TRACTOR_DEF_NAME].id --The weapon def id of tractor beam laser
local TRACTOR_TIMEOUT = 8 --Number of gameframes until timeout, this stops unit being tractored even if doesnt receive any beam in some time
local TRACTOR_TRESHOLD = 1.5 --Threshold which unit is attached
local TRACTOR_SPEED = 2 --Speed of unit when tractored
local TRACTOR_TROWSPEED = 8 --Speed of unit when launched from gun
local TRACTOR_SIZELIMIT = 9 --Put what you want, this limit X*Z of the unit max size (contruck is 3x3)
local TRACTOR_MASSLIMIT = 1000 --Put what you want, this limits the max mass that can be tractored
local TRACTOR_RELOADTIME = 5*32 --Tractor reload time. Remember 1 sec = 32~ gameframes
local TRACTOR_WHITETIME = 0.25*32 --Time which the launched unit doesnt get triggered by unit touch
local TRACTOR_UPIMPULSE = 0 --Impulse extra which is added when launched

local COLLISION_GROUND_SPEED = 0.5 --The minimal speed which triggers destruction of unit
local COLLISION_SPHERE = 15 --Extra size for collision sphere
local COLLISION_IMPULSEFACTOR = 0.75 --How much affects unit impulse to damage calculation (multiplied, so 0 means nothing)
local COLLISION_MASSFACTOR = 0.50 --How much affects unit mass to damage (same as above)

local TRACTOR_IGNORELIST = { --Units ignored from being tractored
	ccomender = true,
	jvarytara = true,
}

local CMD_WAIT = CMD.WAIT
local CMD_ATTACK = CMD.ATTACK
local CMD_REMOVE = CMD.REMOVE
local CMD_OPT_ALT = CMD.OPT_ALT

local PI = math.pi

local TEAMGAIA = Spring.GetGaiaTeamID()

--Utilities funcs
local function GetUnitPiecePos(unitID, piece) --returns position of piece in world coordinates
	local x,y,z = spGetUnitPosition(unitID)
	local front,up,right = spGetUnitVectors(unitID)
	local px,py,pz = spGetUnitPiecePosition(unitID, piece)
	return x + (pz*front[1] + py*up[1] + px*right[1]),
		y + (pz*front[2] + py*up[2] + px*right[2]),
		z + (pz*front[3] + py*up[3] + px*right[3])
end

local function GetUnitWeaponPiece(unitID, weaponNum)
	local env = Spring.UnitScript.GetScriptEnv(unitID)
		if not env then  return nil end
	local weaponFunc = env.script["QueryWeapon" .. weaponNum] --Get the corresponding weapon num query function example: 2 -> "QueryWeapon2"
	if weaponFunc == nil then
		return nil --Func is not present in unitscript
	else
		return Spring.UnitScript.CallAsUnit(unitID, weaponFunc)
	end
end

local function GetUnitPieceRotation(unitID, piece)
	local rx, ry, rz = Spring.UnitScript.CallAsUnit(unitID, Spring.UnitScript.GetPieceRotation, piece)
	local Heading = spGetUnitHeading(unitID) --COB format!
	local dy = rad(Heading / 182)
	return rx, dy + ry, rz
end

local function GetDistanceVec3(sx, sy, sz, ex, ey, ez)
	local dx = ex - sx
	local dy = ey - sy
	local dz = ez - sz
	return sqrt(dx*dx + dy*dy + dz*dz)
end

local function GetVelocityVec3(sx, sy, sz, ex, ey, ez, speed)
	if speed == nil then
		speed = 1
	end
	local dx = ex - sx
	local dy = ey - sy
	local dz = ez - sz
	local d = sqrt(dx*dx + dy*dy + dz*dz)
	local vx = dx/d * speed
	local vy = dy/d * speed
	local vz = dz/d * speed
	return vx, vy, vz
end

local function GiveDoubleWait(unitID)
	spGiveOrderToUnit(unitID, CMD_WAIT, {}, {})
	spGiveOrderToUnit(unitID, CMD_WAIT, {}, {})
end

local function DeactivateWeapons(unitID) --thanks knorke
	local unitDefID = spGetUnitDefID(unitID)
	local n = #UnitDefs[unitDefID].weapons
	for wi=0,n-1,1 do
		--Spring.SetUnitWeaponState (unitID, wi,{aimReady=0})
		spSetUnitWeaponState(unitID, wi,{reloadFrame=99999})
	end
end

--Functions called from LUS (remenber that this comes from LUS realm, no nesting allowed! (Gadget -> LUS -> Gadget -> LUS for example, will cause fatal errors and dragons))
function GG.NotifyBlockShot(unitID) 
	if unitReload[unitID] then
		return true --Weapon needs recharge
	elseif unitCaptured[unitID] ~= nil then  --Only block unit's shot if we are carrying a unit in tractor gun
		local cmdQueue = spGetUnitCommands(unitID)
		local currentCmd = cmdQueue[1]
		local tx, ty, tz
		if currentCmd and currentCmd.id == CMD_ATTACK then
			local params = currentCmd.params
			if #params == 1 then
				tx, ty, tz = spGetUnitPosition(params[1])
			else
				tx, ty, tz = params[1], params[2], params[3]
			end
			spGiveOrderToUnit(unitID, CMD_REMOVE, {currentCmd.tag}, {CMD_OPT_ALT})
		else
			return true --This souldn't happen...
		end
		local capturedID = unitCaptured[unitID]
		local weaponPiece = unitTractor[unitID]	
		local ax, ay, az = GetUnitPiecePos(unitID, weaponPiece)
		local vx, vy, vz = GetVelocityVec3(ax, ay, az, tx, ay, tz, TRACTOR_TROWSPEED)
		local aimVector = {vx, vy, vz}
		unitShotReady[unitID] = aimVector
		return true --Block the tractor, as we are launching the unit
	else
		return false --No unit in gun
	end
end

--Engine callins
function gadget:UnitFinished(unitID, unitDefID) --Check if unit has a tractor weapon, and save weapon's fire piece in unitTractor
	local unitDef = UnitDefs[unitDefID]
	local weaponNum = nil
	local weaponPiece = nil
	for wid, wdef in pairs(unitDef.weapons) do --Iterate trough unitDef weapons
		if wdef.weaponDef == TRACTOR_DEF_ID then --Oh it has a tractor
			weaponPiece = GetUnitWeaponPiece(unitID, wid) --get which piece fires the weapon id and append to list
			if weaponPiece ~= nil then --valid found, break search
				weaponNum = wid
				break
			end
		end
	end
	if weaponPiece ~= nil then
		unitTractor[unitID] = weaponPiece
	else
		unitTractor[unitID] = nil
	end
end

function gadget:UnitDestroyed(unitID)
	if _G.unitAffected[unitID] then --unit is one that was being tractored? delete tractor's and this unit refs
		local attackerID = _G.unitAffected[unitID]
		_G.unitAffected[unitID] = nil
		unitInTransit[unitID] = nil
		unitShotReady[unitID] = nil
		--Now we remove the rest of references of the parent/attacker/tractor
		unitTractoring[attackerID] = nil
		unitCaptured[attackerID] = nil
	elseif unitTractor[unitID] then --Remove tractor refences of this unit if its a tractor
		local tractoredID = unitTractoring[unitID] or unitCaptured[unitID] --Get the unit that is under our tractor if there is any
		unitTractor[unitID] = nil
		unitTractoring[unitID] = nil
		unitCaptured[unitID] = nil
		if tractoredID then --There was a tractored unit before this unit was destroyed?
			_G.unitAffected[tractoredID] = nil
			UnitInTransitCounter=math.max(0,UnitInTransitCounter-1)
			unitInTransit[tractoredID] = nil
			unitShotReady[tractoredID] = nil
			 --For safe...
			mcSetVelocity(tractoredID, 0, 0, 0)
			mcDisable(tractoredID)
			GiveDoubleWait(tractoredID)
			spSetUnitNoSelect(tractoredID, false)
		end
	end
end

function gadget:UnitPreDamaged(unitID, unitDefID, _, _, _, weaponDefID, _, attackerID) --controls which units are tractored and which are ignored
	if weaponDefID == TRACTOR_DEF_ID then --Check if weapon is tractor
		if unitID ~= attackerID then --This happens...
			local unitDef = UnitDefs[unitDefID]
			if not TRACTOR_IGNORELIST[unitDef.name] then --Ignore units in list
				if unitDef.canMove and unitDef.maxAcc > 0 and (unitDef.xsize/2 * unitDef.zsize/2) <= TRACTOR_SIZELIMIT and unitDef.mass <= TRACTOR_MASSLIMIT then --Check if the unit is mobile (no citadel flying thanks :P ) and if size is less or equal than limit
					if unitCaptured[attackerID] == nil and unitLaunched[unitID] == nil then --Check if the attacker is not being carrying another unit already or if the actual unit is not being launched from a tractor
						if unitTractoring[attackerID] == nil or unitTractoring[attackerID] == unitID then --The attacker is not tractoring another unit?
							if _G.unitAffected[unitID] == nil or _G.unitAffected[unitID] == attackerID then --We are not already being tractored by another unit?
								local cmdQueue = spGetUnitCommands(attackerID)
								local currentCmd = cmdQueue[1]
								if currentCmd ~= nil and currentCmd.id == CMD_ATTACK and currentCmd.params[1] == unitID then --Check if attack is directed to us
									if _G.unitAffected[unitID] == nil then --First time?
										mcEnable(unitID) --Enable movectrl
										_G.unitAffected[unitID] = attackerID
										unitTractoring[attackerID] = unitID
					   	 				spSetUnitNoSelect(unitID, true) --Make non selectable
									end
									UnitInTransitCounter=UnitInTransitCounter+1
									unitInTransit[unitID] = {attackerID, 0} --We set timeout as 0
								end
							end
						end
					end
				end
			end
		end
		return 0
	end
end


function gadget:GameFrame(f)

if UnitInTransitCounter ~= 0 then
	for tractoredID, data in pairs(unitInTransit) do --unit under tractor beam effect
		local attackerID, timeout = data[1], data[2]
		timeout = timeout + 1
		if timeout > TRACTOR_TIMEOUT then
			--spEcho("Timeout!")
			unitInTransit[tractoredID] = nil
			unitTractoring[attackerID] = nil
			_G.unitAffected[tractoredID] = nil
			mcSetVelocity(tractoredID, 0, 0, 0) --Stop the velocity
			mcDisable(tractoredID)
			spSetUnitNoSelect(tractoredID, false)
			GiveDoubleWait(tractoredID)
		else
			local weaponPiece = unitTractor[attackerID]
			local px, py, pz = spGetUnitPosition(tractoredID)
			local ax, ay, az = GetUnitPiecePos(attackerID, weaponPiece)
			local height = spGetUnitHeight(tractoredID) / 2
			local gy = spGetGroundHeight(ax, az)
			if ay - height <= gy then
				height = 0
			end
			local distance = GetDistanceVec3(px, py + height, pz, ax, ay, az)
			if distance < TRACTOR_TRESHOLD then --Is near enough to cannon?
				--spEcho("Reached Threshold!")
				unitInTransit[tractoredID] = nil --We are not tractoring it
				unitTractoring[attackerID] = nil
				unitCaptured[attackerID] = tractoredID --Unit is now in tractor gun (captured)
				mcSetVelocity(tractoredID, 0, 0, 0) --Stop the velocity
            	spTransferUnit(tractoredID, TEAMGAIA, false) --Now unit is team gaia
           		spSetUnitNeutral(tractoredID, true) --neutralize to ignore from others weapon (it gets attacked O_o)
				DeactivateWeapons(tractoredID)
				--Now we procced to remove the attack command, because we have the unit in the gun
				local cmdQueue = spGetUnitCommands(attackerID)
				local currentCmd = cmdQueue[1]
				if currentCmd.id == CMD_ATTACK and currentCmd.params[1] == tractoredID then
					spGiveOrderToUnit(attackerID, CMD_REMOVE, {currentCmd.tag}, {CMD_OPT_ALT})
				end
			else
				unitInTransit[tractoredID] = {attackerID, timeout} --Update the incremented timeout
				local vx, vy, vz = GetVelocityVec3(px, py + height, pz, ax, ay, az, TRACTOR_SPEED)
				mcSetVelocity(tractoredID, vx, vy, vz)
			end
		end
	end
end
	for attackerID, capturedID in pairs(unitCaptured) do --make units look like attached to gun taking account piece position and rotation
		local weaponPiece = unitTractor[attackerID]
		local px, py, pz = spGetUnitPosition(attackerID)
		local ax, ay, az = GetUnitPiecePos(attackerID, weaponPiece)
		local ry = atan2(px-ax, pz-az) + PI--Get direction of piece regarding to unit base
		local height = Spring.GetUnitHeight(capturedID) / 2 --get the middle height of unit
		local gy = spGetGroundHeight(ax, az)
		if ay - height <= gy then
			height = 0
		end
		mcSetPhysics(capturedID, ax, ay - height, az, 0, 0, 0, 0, 0, 0) --maintain gun piece position
	end
	for attackerID, aimVector in pairs(unitShotReady) do
		--spEcho("Trow", attackerID, aimVector[1], aimVector[2], aimVector[3])
		local unitID = unitCaptured[attackerID]
		mcSetVelocity(unitID, 0, 0, 0) --Stop the velocity
		mcDisable(unitID) --Stop movectrl-ing the unit
		spSetUnitVelocity(unitID, 0, 0, 0) --Thanks Car for hint (so, we need to set velocity 0 and then add impulse, spring stuff...)
		spAddUnitImpulse(unitID, aimVector[1], aimVector[2] + TRACTOR_UPIMPULSE, aimVector[3]) --Set a initial impulse of unit (now is not under movectrl)
		--Finished, remove unnecesary entries
		unitShotReady[attackerID] = nil
		unitCaptured[attackerID] = nil
		unitReload[attackerID] = TRACTOR_RELOADTIME
		unitLaunched[unitID] = 0
	end
	for attackerID, reloadtime in pairs(unitReload) do
		reloadtime = reloadtime - 1
		if reloadtime < 0 then
			reloadtime = nil
		end
		unitReload[attackerID] = reloadtime
	end
	for unitID, time in pairs(unitLaunched) do --Check if units touches ground or another unit
		time = time + 1
		unitLaunched[unitID] = time
		local collided = false --flag if the unit has collided with another
		local attackerID = _G.unitAffected[unitID]
		local vx, vy, vz = spGetUnitVelocity(unitID)
		local impulse = ((vx + vy + vz) / 3) * COLLISION_IMPULSEFACTOR
		if  time > TRACTOR_WHITETIME then
			--Check if collides with some unit
			local mx, my, mz = spGetUnitPosition(unitID)
			local height = spGetUnitHeight(unitID) / 2
			local sx, sy, sz, ox, oy, oz = spGetUnitCollisionVolumeData(unitID)
			local size = max(sx, sy, sz) --Maximum size of collidision volume
			local nearUnits = spGetUnitsInSphere(mx + ox, my + height + oy, mz + oz, size + COLLISION_SPHERE) --Place the sphere accounting offset that collisionvolume might have...
			if nearUnits and #nearUnits > 0 then --Units near? destroy our launched unit TODO: ADD COLLISION DAMAGE TO UNITS!! MASS ACCOUNTED
				local unitDef = UnitDefs[spGetUnitDefID(unitID)]
				local damage = (unitDef.mass * COLLISION_MASSFACTOR) + impulse
				for i = 1, #nearUnits do
					local nearUnitID = nearUnits[i]
					if nearUnitID == attackerID or nearUnitID == unitID then --remove myself or my attacker
						nearUnits[i] = nil
					else
						local health = spGetUnitHealth(nearUnitID) - damage
						--spEcho(nearUnitID, attackerID, unitID, damage, health)
						if health > 0 then
							spSetUnitHealth(nearUnitID, health)
						else
							spDestroyUnit(nearUnitID, false, false, attackerID) --attacker is the true enemy (alrought the projectile is another unit... what a dilemma)
						end
					end
				end
				if #nearUnits > 0 then
					collided = true
					spDestroyUnit(unitID, false, false, attackerID) --Destroy the unit, also pass tractor unitID (the attacker)
					unitLaunched[unitID] = nil
					_G.unitAffected[unitID] = nil
				end
			end
			if not collided and impulse < COLLISION_GROUND_SPEED then --Seems to be slowed too muchs
				spEcho("GROUND", impulse)
				spDestroyUnit(unitID, false, false, attackerID) --Destroy the unit, also pass tractor unitID (the attacker)
				unitLaunched[unitID] = nil
				_G.unitAffected[unitID] = nil
			end
		end
	end
end

function gadget:CommandFallback(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions) --Return Used, Finished
	if cmdID == CMD_NOOP_ID then
		return true, true
	else
		return false, false
	end
end


else --UNSYNCED

--Speedups
local spEcho = Spring.Echo
local spGetMouseState = Spring.GetMouseState
local spTraceScreenRay = Spring.TraceScreenRay

function gadget:DefaultCommand() --Make unit nonselectable/attackable/iterable if its under tractor effect
	local mx,my = spGetMouseState()
	local pointingType, pointingUnit = spTraceScreenRay(mx,my)
	if pointingType == "unit" then
		if SYNCED.unitAffected[pointingUnit] then
			return CMD_NOOP_ID --Ignore any interaction
		end
	end
end

end
--]]
----END GADGET----