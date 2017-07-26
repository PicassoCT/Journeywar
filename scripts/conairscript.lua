include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

rope = {}

rp0 = piece "rp0" table.insert(rope, rp0)
rp1 = piece "rp1" table.insert(rope, rp1)
rp2 = piece "rp2" table.insert(rope, rp2)
rp3 = piece "rp3" table.insert(rope, rp3)
rp4 = piece "rp4" table.insert(rope, rp4)
rp5 = piece "rp5" table.insert(rope, rp5)
rp6 = piece "rp6" table.insert(rope, rp6)
rp7 = piece "rp7" table.insert(rope, rp7)
rp8 = piece "rp8" table.insert(rope, rp8)
rp9 = piece "rp9" table.insert(rope, rp9)
rp10 = piece "rp10" table.insert(rope, rp10)
rp11 = piece "rp11" table.insert(rope, rp11)
rp12 = piece "rp12" table.insert(rope, rp12)
rp13 = piece "rp13" table.insert(rope, rp13)
rp14 = piece "rp14" table.insert(rope, rp14)
rp15 = piece "rp15" table.insert(rope, rp15)
rp16 = piece "rp16" table.insert(rope, rp16)
rp17 = piece "rp17" table.insert(rope, rp17)
rp18 = piece "rp18" table.insert(rope, rp18)
rp19 = piece "rp19" table.insert(rope, rp19)






--unitPieces
local jetemit3 = piece "jetemit3"
local jetemit2 = piece "jetemit2"
local jetemit1 = piece "jetemit1"
local jetemit4 = piece "jetemit4"
local conspin = piece "conspin"
local nanoemit = piece "nanoemit"
local conair = piece "conair"
local swingersClub = piece "swingersClub"

local conairfron = piece "conairfron"
local conairRear = piece "conairRear"
local condepot = piece "condepot"
local conaircenter = piece "conaircenter"
local bgdrop = piece "bgdrop"


local changeX = 0
local changeY = 0
local changeZ = 0




local boolOnlyOnce = true
local boolMoving = false
SIG_ONTHEFLY = 4
SIG_BUILD = 2
SIG_LANDED = 8
SIG_HOVER = 16
SIG_CHECK = 32
SIG_WIND = 64

SIG_MOMENTUM = 128
SIG_EXAUST = 256
SIG_TIMER = 512

local ropePieces_n = 20
buildProgress = 1
local boolShortStop = false
local boolLongStop = false
local buildID = -666
local boolRopeRelease = false
local booleightDegree = false
local boolUnitIsSoldier = false

local lastKnownPosX = nil
local lastKnownPosY = nil
local lastKnownPosZ = nil

local windForceX = 0
local windForceY = 0
local windForceZ = 0

local alphaOfOldX = 0
local alphaOfOldZ = 0
local xDistanceOfOld = 0
local zDistanceOfOld = 0

unitPosX = 0
unitPosY = 0
unitPosZ = 0
lastKnownPosX = 0
lastKnownPosY = 0
lastKnownPosZ = 0


function script.Activate()
	--activates the secondary weapon
	
	return 1
end

function script.Deactivate()
	--deactivates the secondary weapon
	
	
	return 0
end



function exaust()
	Signal(SIG_EXAUST)
	SetSignalMask(SIG_EXAUST)
	while (true) do
		EmitSfx(jetemit1, 1024)
		EmitSfx(jetemit2, 1024)
		EmitSfx(jetemit3, 1024)
		EmitSfx(jetemit4, 1024)
		Sleep(50)
	end
end

function timedelayedExaustExtinct()
	SetSignalMask(SIG_TIMER)
	Sleep(4000)
	Signal(SIG_EXAUST)
end

function landed()
	
	StopSpin(conspin, y_axis, 1)
	
	Spin(conspin, y_axis, math.rad(135), 12)
	Turn(conaircenter, x_axis, math.rad(0), 5)
	Turn(conairfron, x_axis, math.rad(0), 4)
	Turn(conairRear, x_axis, math.rad(0), 4)
	
	WaitForTurn(conairfron, x_axis)
	WaitForTurn(conairRear, x_axis)
end


function onTheFly()
	
	
	Spin(conspin, y_axis, math.rad(260), 19)
	Turn(conaircenter, x_axis, math.rad(8), 3)
	booleightDegree = true
	Turn(conairfron, x_axis, math.rad(82), 4)
	Turn(conairRear, x_axis, math.rad(77), 4)
	WaitForTurn(conairfron, x_axis)
	WaitForTurn(conairRear, x_axis)
end



function windGet()
	dirX, dirY, dirZ, strength, normDirX, normDirY, normDirZ = Spring.GetWind()
	if strenght == 0 or strenght == nil then
		strenght = 0.1
	end
	dirX = dirX * strenght
	dirZ = dirZ * strenght
	dirX = dirX % 5
	dirZ = dirZ % 5
	if dirX == 0 then
		dirX = 0.1
	end
	if dirZ == 0 then
		dirZ = 0.1
	end
	--- -Spring.Echo("WindX",dirX)
	---- Spring.Echo("WindZ",dirZ)
	
	return dirX, dirZ
end

function round(num, idp)
	res = tonumber(string.format("%." .. (idp or 0) .. "f", num))
	return res
end

function resetRope()
	for ot = 1, table.getn(rope), 1 do
		Turn(rope[ot], x_axis, math.rad(0), 0.5)
		Turn(rope[ot], z_axis, math.rad(0), 0.5)
	end
	xDistanceOfOld = 0
	zDistanceOfOld = 0
end

function updateBuildProgress()
	
	if buildID == nil or buildID == -666 then
		repeat
			
			buildID = Spring.GetUnitIsBuilding(unitID)
			Sleep(60)
		until buildID ~= nil or buildID ~= -666
	end
	if buildID and Spring.ValidUnitID(buildID) then
		local health, maxhealth, paralyzeDamage, captureProgress, Progress = Spring.GetUnitHealth(buildID)
		if Progress == nil then
			Progress = 1
		end
		
		Progress = math.max(Progress, 0.05)
		-------- Spring.Echo("updateBuildProgress")
		Progress = math.ceil(Progress * ropePieces_n)
		return Progress
	end
end

local BGID = UnitDefNames["bg"].id
function unitBuiltCheck()
	--test if unit built is a soldier
	while buildID == nil or buildID == -666 do
		Sleep(150)
		buildID = Spring.GetUnitIsBuilding(unitID)
	end
	local unitDefID = Spring.GetUnitDefID(buildID)
	
	if unitDefID == BGID then
		
		return true
		
	else
		
		return false
	end
end

function sumSiniUp(buildProgress, alphaX)
	if not buildProgress or type(buildProgress) ~= "number" then return 0 end
	local sumItUp = 0
	for com2Sin = 0, buildProgress, 1 do
		sumItUp = (math.sin(math.rad(com2Sin * alphaX))) + sumItUp
	end
	
	return sumItUp
end

function moveThatTrooper(arrivingAlphaX, arrivingAlphaZ, moveSpeed, buildProgress)
	--First the arriving Values are checked for disease, and put into quarantine
	local lenghtOfElement = 5.8
	counter = 3000 / 40
	
	if buildProgress == nil then
		while buildProgress == nil and counter > 0 do
			buildProgress = updateBuildProgress()
			Sleep(40)
			counter = counter - 1
		end
	end
	local numberOfElements = buildProgress
	
	if arrivingAlphaX == nil or arrivingAlphaZ == nil then
		------ Spring.Echo("Fatal Error")
	end
	if arrivingAlphaX == 0 then
		arrivingAlphaX = 0.1
	end
	if arrivingAlphaZ == 0 then
		arrivingAlphaZ = 0.1
	end
	if moveSpeed < 0.1 or nil then
		moveSpeed = 0.1
	end
	if not numberOfElements or numberOfElements < 2 then
		numberOfElements = 2
	end
	
	local alphaXInDegree = arrivingAlphaX
	local alphaZInDegree = arrivingAlphaZ
	--quarantine is over, here may be math
	
	
	
	
	--Moves the Trooper down Y_axis
	local moveDistanceY = lenghtOfElement * numberOfElements * (-1) --
	Move(bgdrop, y_axis, moveDistanceY, 7)
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- |\ sin(alpha)=b/h -> sin(alpha)*h=b => sin(90-alpha)=a/h -> h= sin(90-alpha)*(1/a) ==> sin(alpha)* (sin(90-alpha)/a) = b
	-- | \
	-- | \ h
	-- a|. \
	-- |____\ sin (beta) ==> b equals the first x
	-- b
	----------------------------------------------------------------------------------------------------------------------------------------
	-- local hypoTenusX=math.sin(math.rad(alphaXInDegree))*(lenghtOfElement/math.sin(math.rad(90-alphaXInDegree)))
	-- local hypoTenusZ=math.sin(math.rad(alphaZInDegree))*(lenghtOfElement/math.sin(math.rad(90-alphaZInDegree)))
	----------------------------------------------------------------------------------------------------------------------------------------
	
	-- good old gausche Summenformel gives us the lenght of the triangle
	local DistanceX = (sumSiniUp(buildProgress, alphaXInDegree)) * lenghtOfElement
	
	local DistanceZ = (sumSiniUp(buildProgress, alphaZInDegree)) * lenghtOfElement
	
	--local DistanceX=((0.5)*((numberOfElements+1)*(numberOfElements)))*hypoTenusX
	--local DistanceZ=((0.5)*((numberOfElements+1)*(numberOfElements)))*hypoTenusZ
	------------------------------------------------------------------------------------
	local lengthOfRopeInX = numberOfElements * lenghtOfElement -- the a of the triangle
	
	--basically its the arcus sin of Alpha divided through the squareroot of (b� + a�)
	local AlphaX = math.asin(((DistanceX / (math.sqrt(DistanceX * DistanceX + lengthOfRopeInX * lengthOfRopeInX)))))
	
	--��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@
	-- the movespeed is basically estimated by taking the xDistanceOfOld (the Way the Trooper swings out + the Distance he allready has to swing) and divide that
	-- by the number of times both current Alpha and Alpha of Old need divided by the moveSpeed.
	
	--this block assures that non of the former chancels the later out
	if alphaOfOldX < 0 and alphaXInDegree > 0 or alphaOfOldX > 0 and alphaXInDegree < 0 then
		alphaOfOldX = alphaOfOldX * -1
	end
	if DistanceX < 0 and xDistanceOfOld > 0 or DistanceX > 0 and xDistanceOfOld < 0 then
		DistanceX = DistanceX * -1
	end
	
	--								degree / deg/sec
	local moveSpeedX = (DistanceX + xDistanceOfOld) / ((alphaXInDegree + alphaOfOldX + (0.000001)) / moveSpeed)
	
	
	-- here the moveSpeed is reversed, should it be negative
	if moveSpeedX < 0 then
		moveSpeedX = moveSpeedX * -1
	end
	
	if moveSpeedX == 0 or moveSpeedX == nil then
		
		moveSpeedX = 3
	end
	
	--��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@��@
	
	
	
	Turn(swingersClub, x_axis, AlphaX, moveSpeedX)
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	
	local AlphaZ = math.asin(((DistanceZ / (math.sqrt(DistanceZ * DistanceZ + lengthOfRopeInX * lengthOfRopeInX)))))
	
	if alphaOfOldZ < 0 and alphaZInDegree > 0 or alphaOfOldZ > 0 and alphaZInDegree < 0 then
		alphaOfOldZ = alphaOfOldZ * -1
	end
	if DistanceZ < 0 and zDistanceOfOld > 0 or DistanceZ > 0 and zDistanceOfOld < 0 then
		DistanceZ = DistanceZ * -1
	end
	
	
	--way -- Time = alpha /
	local moveSpeedZ = (DistanceZ + zDistanceOfOld) / ((alphaZInDegree + alphaOfOldZ + (0.000001)) / moveSpeed)
	--MoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeed
	
	if moveSpeedZ < 0 then
		moveSpeedZ = moveSpeedZ * -1
	end
	if moveSpeedZ == 0 or moveSpeedZ == nil then
		
		--Spring.Echo("Throwing a movespeed nilPointerException")
		moveSpeedZ = AlphaZ / alphaZInDegree
	end
	
	--MoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeedMoveSpeed
	if AlphaZ == nil or moveSpeedZ == nil then
		--Spring.Echo("Throwing a movespeed nilPointerException")
	end
	
	Turn(swingersClub, z_axis, AlphaZ, moveSpeedZ)
	
	
	
	--Finally we get our Trooper turning round the rope..
	rANDohm = math.random(-360, 360)
	Turn(bgdrop, y_axis, math.rad(rANDohm), 0.15)
	
	alphaOfOldZ = alphaZInDegree
	alphaOfOldX = alphaXInDegree
	xDistanceOfOld = DistanceX
	zDistanceOfOld = DistanceZ
	-- Echo Block for debugging purposes
	
	--give Out All the Values ever used in this function
end







function ropeShow()
	sleep = 90
	for i = 1, table.getn(rope), 1 do
		
		Show(rope[i])
		sleep = sleep - (2 * i)
		Sleep(sleep)
	end
end

function ropeDrop()
	
	
	
	for b = 1, table.getn(rope), 1 do
		
		Hide(rope[b])
		Sleep(15)
	end
	buildProgress = 1
end


function addUpChange(lastKnownPosX, lastKnownPosY, lastKnownPosZ)
	-- here the complexity enters, as every change depends upon the heading of the unit
	-- positiv xvalues get the rope behind the unit
	-- positiv zvalues get the rope right
	
	unitPosX, unitPosY, unitPosZ = Spring.GetUnitPosition(unitID)
	addX = unitPosX - lastKnownPosX
	addY = unitPosY - lastKnownPosY
	addZ = unitPosZ - lastKnownPosZ
	-------------------------------------------------------------------------------
	if addX < 0.4 and addX > -0.4 then
		local signedStore = addX
		addX = addX ^ 2
		addX = (addX + 1) * signedStore
	end
	
	if addZ < 0.3 and addZ > -0.3 then
		signedStore = addZ
		addZ = (addZ ^ 2)
		addZ = (addZ + 1) * signedStore
	end
	
	if addZ == 0 and addX == 0 or addZ == nil or addX == nil then
		local malTiplik = math.random(-0.9, 0.8)
		addZ = malTiplik
		addX = malTiplik
	end
	
	addX = addX * 3
	addZ = addZ * 3
	return addX, addY, addZ
end

conairDefID = Spring.GetUnitDefID(unitID)
lastLoudness = 0.5
valToAdd = 0.1
function ropeThread()
	-- Resets the Trooper
	
	lastLoudness = getLoud(lastLoudness)
	PlaySoundByUnitDefID(conairDefID, "sounds/conair/cConAir.wav", lastLoudness, 1000, 1, 0)
	
	
	Turn(swingersClub, x_axis, math.rad(0), 150)
	Turn(bgdrop, y_axis, math.rad(0), 150)
	Turn(swingersClub, z_axis, math.rad(0), 150)
	Move(bgdrop, y_axis, 0, 260)
	
	buildID = Spring.GetUnitIsBuilding(unitID)
	if buildID and type(buildID) == "number" then
		Spring.SetUnitNoDraw(buildID, true)
	end
	StartThread(ropeShow)
	Sleep(90)
	Show(bgdrop)
	local boolFirstTimeForEverything = true
	local speedyGonzo = 0.1
	local flopFlip = 1
	local countStartDependBuildProgress = buildProgress
	local lmoveThatTrooper = moveThatTrooper
	local lupdateBuildProgress = updateBuildProgress
	local laddUpChange = addUpChange
	
	if countStartDependBuildProgress == nil then
		countStartDependBuildProgress = 1
	end
	
	boolRopeRelease = false
	
	lastKnownPosX, lastKnownPosY, lastKnownPosZ = Spring.GetUnitPosition(unitID)
	SetSignalMask(SIG_CHECK)
	while (boolRopeRelease == false) do
		
		flopFlip = flopFlip * (-1)
		unitPosX, unitPosY, unitPosZ = Spring.GetUnitPosition(unitID)
		countStartDependBuildProgress = buildProgress
		if not countStartDependBuildProgress then ropeDrop() break end
		
		-- adds the updated position as swing_value
		if boolFirstTimeForEverything == true then
			--added
			boolFirstTimeForEverything = false
			changeX = lastKnownPosX - unitPosX
			changeY = lastKnownPosY - unitPosY
			changeZ = lastKnownPosZ - unitPosZ
			speedyGonzo = (math.sqrt(changeX ^ 2 + changeZ ^ 2)) / 22
			
			changeX = (changeX / ropePieces_n)
			changeZ = (changeZ / ropePieces_n)
		else
			speedyGonzo = (math.sqrt(changeX ^ 2 + changeZ ^ 2)) / 22
			if speedyGonzo < 0.1 then
				speedyGonzo = 0.18
			end
			
			
			addX, addY, addZ = addUpChange(lastKnownPosX, lastKnownPosY, lastKnownPosZ)
			--addIt
			if addX < 0 and changeX > 0.2 then
				addX = addX * -1
			end
			if addZ < 0 and changeZ > 0.2 then
				addZ = addZ * -1
			end
			--addItEnd
			changeX = (changeX + (addX / 22))
			changeZ = (changeZ + (addZ / 22))
		end
		
		
		
		repeat
			countStartDependBuildProgress = updateBuildProgress()
			if not countStartDependBuildProgress then ropeDrop() break end
			--- -Spring.Echo("InnerLoop")
			flopFlip = flopFlip * (-1)
			--
			
			
			--windwave + does not apply to unweighted ropesegments
			windX, windZ = windGet()
			windX = windX / 3
			windZ = windZ / 3
			windTemp = windX * windZ
			if windTemp < 0 then
				windTemp = windTemp * -1
			end
			
			windWave = math.ceil(math.sqrt(windTemp)) --not neg
			
			
			iRandBot = math.random(0, 1)
			--- -Spring.Echo("WindWave")
			if iRandBot == 1 then
				for w = countStartDependBuildProgress, 16, 1 do
					
					Turn(rope[w], x_axis, math.rad(changeX), 0.45)
					Turn(rope[w + 1], x_axis, math.rad(windX * 3), windWave)
					Turn(rope[w + 2], x_axis, math.rad(windX), windWave)
					Turn(rope[w + 3], x_axis, math.rad((windX * -1)), windWave)
					Turn(rope[w + 4], x_axis, math.rad((windX * -3)), windWave)
					
					
					Turn(rope[w], z_axis, math.rad(changeZ), 0.45)
					Turn(rope[w + 1], z_axis, math.rad((windZ * -3)), windWave)
					Turn(rope[w + 2], z_axis, math.rad((windZ * -1)), windWave)
					Turn(rope[w + 3], z_axis, math.rad(windZ), windWave)
					Turn(rope[w + 4], z_axis, math.rad((windZ * 3)), windWave)
					Sleep(15)
				end
			else
				for w = countStartDependBuildProgress, 16, 1 do
					Turn(rope[w], x_axis, math.rad(changeX), 0.45)
					Turn(rope[w + 1], x_axis, math.rad(windX * -3), windWave)
					Turn(rope[w + 2], x_axis, math.rad(windX * -1), windWave)
					Turn(rope[w + 3], x_axis, math.rad((windX)), windWave)
					Turn(rope[w + 4], x_axis, math.rad((windX * 3)), windWave)
					
					
					Turn(rope[w], z_axis, math.rad(changeZ), 0.45)
					Turn(rope[w + 1], z_axis, math.rad((windZ * 3)), windWave)
					Turn(rope[w + 2], z_axis, math.rad((windZ)), windWave)
					Turn(rope[w + 3], z_axis, math.rad(windZ * -1), windWave)
					Turn(rope[w + 4], z_axis, math.rad((windZ * -3)), windWave)
					
					
					
					Sleep(15)
				end
			end
			for cleanUp = 17, #rope, 1 do
				Turn(rope[cleanUp], x_axis, math.rad(changeX), speedyGonzo)
				Turn(rope[cleanUp], z_axis, math.rad(changeZ), speedyGonzo)
				Sleep(15)
			end
			----------------------------------------------------------------
			---- Spring.Echo("OutOfWindWave")
			if changeX > 3 then
				changeX = 3 + (0.3 * (changeX % 2))
			elseif changeX < -3 then
				changeX = -3 - (0.3 * (changeX % 2))
			end
			
			if changeZ > 3 then
				changeZ = 3 + (0.3 * (changeZ % 2))
			elseif changeZ < -3 then
				changeZ = -3 + (0.3 * (changeZ % 2))
			end
			
			
			
			--- -Spring.Echo("Into the SwingBack")
			for i = 1, buildProgress, 1 do
				-----------------------------------------------------------------
				-- addUp Thread Refeshed changes ... applies to both SegmentSorts
				Turn(rope[i], x_axis, math.rad(changeX), speedyGonzo)
				Turn(rope[i], z_axis, math.rad(changeZ), speedyGonzo)
			end
			local tempchangeX = changeX * 0.7
			local tempchangeZ = changeZ * 0.7
			
			for i = buildProgress, table.getn(rope), 1 do
				-----------------------------------------------------------------
				-- addUp Thread Refeshed changes ... applies to both SegmentSorts
				Turn(rope[i], x_axis, math.rad(tempchangeX), speedyGonzo)
				Turn(rope[i], z_axis, math.rad(tempchangeZ), speedyGonzo)
			end
			--- -Spring.Echo("OutOfTheSwingBack")
			
			
			buildProgress = lupdateBuildProgress()
			if not buildProgress then boolRopeRelease = true end
			
			if buildProgress then
				--- -Spring.Echo("Dont leave me hanging")
				lmoveThatTrooper(changeX, changeZ, 2, buildProgress)
				--- -Spring.Echo("SPIKE_IT_WITH_TRACERS7")
				
				if flopFlip == -1 and changeX ~= 0 then
					--- -Spring.Echo("SPIKE_IT_WITH_TRACERS7A")
					WaitForTurn(rp19, x_axis)
					--- -Spring.Echo("SPIKE_IT_WITH_TRACERS7B")
				end
				if flopFlip == 1 and changeZ ~= 0 then
					--- -Spring.Echo("SPIKE_IT_WITH_TRACERS7C")
					WaitForTurn(rp19, z_axis)
				end
			end
			
			
			------------------------------------------------
			-- Travelling Wave does not apply to weighted RopeSegments
			---- Spring.Echo("SPIKE_IT_WITH_TRACERS8")
			addX, addY, addZ = laddUpChange(lastKnownPosX, lastKnownPosY, lastKnownPosZ)
			travellX = changeX + (addX / 5)
			travellZ = changeZ + (addZ / 5)
			if travellX > 20 or travellX < -20 then
				travellX = (travellX % 20) + 15
			end
			if travellZ > 20 or travellZ < -20 then
				travellZ = (travellZ % 20) + 15
			end
			
			travellX = travellX / 4
			travellZ = travellZ / 4
			
			wavespeed = math.random(0.75, 5)
			
			
			iRandBot = math.random(0, 1)
			
			--- -Spring.Echo("MomentumWave")
			if iRandBot == 1 then
				--- -Spring.Echo("Tracer2")
				for w = countStartDependBuildProgress, 16, 1 do
					
					Turn(rope[w], x_axis, math.rad(changeX), 0.45)
					Turn(rope[w + 1], x_axis, math.rad(travellX * 3), wavespeed)
					Turn(rope[w + 2], x_axis, math.rad(travellX), wavespeed)
					Turn(rope[w + 3], x_axis, math.rad((travellX * -1)), wavespeed)
					Turn(rope[w + 4], x_axis, math.rad((travellX * -3)), wavespeed)
					
					
					Turn(rope[w], z_axis, math.rad(changeZ), 0.45)
					Turn(rope[w + 1], z_axis, math.rad((travellZ * -3)), wavespeed)
					Turn(rope[w + 2], z_axis, math.rad((travellZ * -1)), wavespeed)
					Turn(rope[w + 3], z_axis, math.rad(travellZ), wavespeed)
					Turn(rope[w + 4], z_axis, math.rad((travellZ * 3)), wavespeed)
					Sleep(12)
				end
			else
				--- -Spring.Echo("Tracer 1")
				for w = countStartDependBuildProgress, 16, 1 do
					Turn(rope[w], x_axis, math.rad(changeX), 0.45)
					Turn(rope[w + 1], x_axis, math.rad(travellX * -3), wavespeed)
					Turn(rope[w + 2], x_axis, math.rad(travellX * -1), wavespeed)
					Turn(rope[w + 3], x_axis, math.rad((travellX)), wavespeed)
					Turn(rope[w + 4], x_axis, math.rad((travellX * 3)), wavespeed)
					
					
					Turn(rope[w], z_axis, math.rad(changeZ), 0.45)
					Turn(rope[w + 1], z_axis, math.rad((travellZ * 3)), wavespeed)
					Turn(rope[w + 2], z_axis, math.rad((travellZ)), wavespeed)
					Turn(rope[w + 3], z_axis, math.rad(travellZ * -1), wavespeed)
					Turn(rope[w + 4], z_axis, math.rad((travellZ * -3)), wavespeed)
					
					
					Sleep(12)
				end
			end
			--Cleans up the remains of Wind and MomentumWave
			
			Turn(rope[17], x_axis, math.rad(changeX), 0.45)
			Turn(rope[17], z_axis, math.rad(changeZ), 0.45)
			Turn(rope[18], x_axis, math.rad(changeX), 0.45)
			Turn(rope[18], z_axis, math.rad(changeZ), 0.45)
			Turn(rope[19], x_axis, math.rad(changeX), 0.45)
			Turn(rope[19], z_axis, math.rad(changeZ), 0.45)
			Turn(rope[20], z_axis, math.rad(changeZ), speedyGonzo)
			Turn(rope[20], x_axis, math.rad(changeX), speedyGonzo)
			Sleep(10)
			
			
			--]]
			---------------------------------------------------
			
			--reverse wave - remains unchanged for the rope parts
			
			addX, addY, addZ = laddUpChange(lastKnownPosX, lastKnownPosY, lastKnownPosZ)
			
			changeX = ((changeX * 0.8) + (addX / 22)) * -1
			changeZ = ((changeZ * 0.8) + (addZ / 22)) * -1
			---------------------------------------------------------
			if changeX > 3 then
				changeX = 3 + (0.3 * (changeX % 2))
			elseif changeX < -3 then
				changeX = -3 - (0.3 * (changeX % 2))
			end
			
			if changeZ > 3 then
				changeZ = 3 + (0.3 * (changeZ % 2))
			elseif changeZ < -3 then
				changeZ = -3 + (0.3 * (changeZ % 2))
			end
			-----------------------------------------------------------
			
			speedyGonzo = (math.sqrt(changeX ^ 2 + changeZ ^ 2)) / 22
			if speedyGonzo < 0.05 then
				speedyGonzo = 0.12
			end
			
			--add a second for loop for the not weightfree elements
			-------- Spring.Echo("BackswingMovement")
			for i = 1, buildProgress, 1 do
				
				Turn(rope[i], x_axis, math.rad(changeX), speedyGonzo)
				Turn(rope[i], z_axis, math.rad(changeZ), speedyGonzo)
			end
			--below smaller
			local tempUsX = changeX * 0.8
			local temppUsZ = changeZ * 0.8
			if buildProgress < ropePieces_n then
				for u = buildProgress, ropePieces_n, 1 do
					Turn(rope[u], x_axis, math.rad(tempUsX), speedyGonzo)
					Turn(rope[u], z_axis, math.rad(temppUsZ), speedyGonzo)
				end
			end
			
			buildProgress = updateBuildProgress()
			moveThatTrooper(changeX, changeZ, 2, buildProgress)
			
			
			if flopFlip == 1 and changeX ~= 0 then
				--Sleep(300)
				WaitForTurn(rp19, x_axis)
				
			elseif changeZ ~= 0 then
				
				--Sleep(300)
				WaitForTurn(rp19, z_axis)
			end
			
			changeX = changeX * (-0.7)
			changeZ = changeZ * (-0.7)
			
			
			
			
			lastKnownPosX = unitPosX
			lastKnownPosY = unitPosY
			lastKnownPosZ = unitPosZ
			--------------------------------------------------------
			if buildProgress == 19 then
				boolRopeRelease = true
			end
			--------------------------------------------------------
			-------- Spring.Echo("changeX",changeX)
		until changeX < 0.5 and changeX > -0.5 or boolRopeRelease == true -- or HellFreezesOver == true
		
		lastKnownPosX = unitPosX
		lastKnownPosY = unitPosY
		lastKnownPosZ = unitPosZ
	end
	--- -Spring.Echo("OutOfRopeThread")
	Hide(bgdrop)
	if Spring.ValidUnitID(buildID) == true then
		Spring.SetUnitNoDraw(buildID, false)
	end
	Turn(swingersClub, x_axis, math.rad(0), 150)
	Turn(bgdrop, y_axis, math.rad(0), 150)
	Turn(swingersClub, z_axis, math.rad(0), 150)
	Move(bgdrop, y_axis, 0, 350)
	
	alphaOfOldZ = 0
	alphaOfOldX = 0
	xDistanceOfOld = 0
	zDistanceOfOld = 0
	
	resetRope()
	ropeDrop()
	buildID = nil
end





function createCorpseCBuilding(unitID)
	
	--moveX=unitPosX -birthX
	--moveZ=birthZ-unitPosZ
	Hide(condepot)
	Hide(bgdrop)
	ropeDrop()
	Move(conaircenter, y_axis, 425, 82)
	WaitForMove(conaircenter, y_axis)
	Move(conaircenter, y_axis, 625, 150)
	WaitForMove(conaircenter, y_axis)
	Move(conaircenter, y_axis, 825, 200)
	WaitForMove(conaircenter, y_axis)
end

function moveStateCheck()
	while (true) do
		
		if boolMoving == true then
			Signal(SIG_EXAUST)
			StartThread(exaust)
			onTheFly()
			Sleep(500)
		end
		
		if boolMoving == false and boolShortStop == false then
			Sleep(512)
			if boolShortStop == false then
				boolRopeRelease = true
				boolLongStop = true
			end
		end
		if boolLongStop == true then
			landed()
		end
		
		
		Sleep(500)
	end
end



function script.StartMoving()
	
	--windGet()
	
	
	
	
	boolMoving = true
	boolShortStop = true
end

boolSelfKill = false

function script.StopMoving()
	
	Signal(SIG_TIMER)
	StartThread(timedelayedExaustExtinct)
	boolMoving = false
	boolShortStop = false
end



function script.HitByWeapon(x, z, weaponDefID, damage)
	hp = Spring.GetUnitHealth(unitID)
	if hp and hp - damage < 0 then
		Spring.SetUnitCrashing(unitID, true)
		SetUnitValue(COB.CRASHING, 1)
		Spring.SetUnitNeutral(unitID, true)
		Spring.SetUnitNoSelect(unitID, true)
		return 0
	end
	return damage
end

boolIwantToGoHome = false

function home()
	Spring.SetUnitMoveGoal(unitID, xorg, yorg, zorg)
	x, y, z = Spring.GetUnitPosition(unitID)
	Sleep(200)
	return x, y, z
end
buildHealth=0
function workInProgress()
	if boolIwantToGoHome == true then
		x, y, z = Spring.GetUnitPosition(unitID)
		while (math.abs(x - xorg) < 25 and math.abs(z - zorg) < 25) == false do
			x, y, z = home()
		end
		Spring.DestroyUnit(unitID, false, true)
	end
	
	boolUnitIsSoldier = unitBuiltCheck()
	Spin(conspin, y_axis, math.rad(145), 7)
	
	
	SetSignalMask(SIG_HOVER)
	while (true) do
		Turn(conairfron, x_axis, math.rad(34), 4)
		Turn(conairRear, x_axis, math.rad(-35), 4)
		
		WaitForTurn(conairfron, x_axis)
		WaitForTurn(conairRear, x_axis)
		actualHealth = Spring.GetUnitHealth(unitID)
		
		
		if actualHealth == 1 then
			boolIwantToGoHome = true
			Hide(condepot)
			Spring.SetUnitNoSelect(unitID, true)
			x, y, z = Spring.GetUnitPosition(unitID)
			while (math.abs(x - xorg) < 25 and math.abs(z - zorg) < 25) == false do
				x, y, z = home()
			end
			Spring.DestroyUnit(unitID, false, true)
			
			--makes the Unit go home, to the place it was born- west Virginia
			--mountain mama
		end
		actualHealth = actualHealth - 1
		buildHealth= buildHealth+1
		if actualHealth <= 0 then boolSelfKill = true end
		Spring.SetUnitHealth(unitID, actualHealth)
		
		Sleep(250)
		if boolUnitIsSoldier == true then
			boolUnitIsSoldier = false
			StartThread(ropeThread)
			Sleep(10)
		end
	end
	StopSpin(conspin, y_axis, 1)
end

xorg, yorg, zorg = Spring.GetUnitPosition(unitID)

function script.Create()
	
	
	
	birthX, birthY, birthZ = Spring.GetUnitPosition(unitID)
	--updateDelete
	StartThread(moveStateCheck)
	Hide(rp0)
	Hide(rp1)
	Hide(rp2)
	Hide(rp3)
	Hide(rp4)
	Hide(rp5)
	Hide(rp6)
	Hide(rp7)
	Hide(rp8)
	Hide(rp9)
	Hide(rp10)
	Hide(rp11)
	Hide(rp12)
	Hide(rp13)
	Hide(rp14)
	Hide(rp15)
	Hide(rp16)
	Hide(rp17)
	Hide(rp18)
	Hide(rp19)
	Hide(jetemit3)
	Hide(jetemit2)
	Hide(jetemit1)
	Hide(jetemit4)
	
	Hide(bgdrop)
	StartThread(landed)
	lastLoudness = getLoud(lastLoudness)
	StartThread(PlaySoundByUnitDefID, conairDefID, "sounds/conair/cConAir.wav", lastLoudness, 1000, 1, 0)
end

_, maxhealth = Spring.GetUnitHealth(unitID)

function script.Killed(recentDamage)
	if boolSelfKill == false then
		
		
		
		Explode(jetemit3, SFX.FIRE + SFX.SMOKE)
		Explode(jetemit2, SFX.FIRE + SFX.SMOKE)
		Explode(jetemit1, SFX.FIRE + SFX.SMOKE)
		Explode(jetemit4, SFX.FIRE + SFX.SMOKE)
		Explode(conspin, SFX.FIRE + SFX.SMOKE)
		Explode(nanoemit, SFX.FIRE + SFX.SMOKE)
		Explode(conair, SFX.FALL + SFX.FIRE + SFX.EXPLODE_ON_HIT)
		Explode(conairfron, SFX.FIRE + SFX.SMOKE)
		Explode(conairRear, SFX.FIRE + SFX.SMOKE)
		Hide(condepot)
	end
	

	return 0
end


function doAllTheThings()
	--
	ropeDrop()
	resetRope()
end


-------- BUILDING---------
function script.StopBuilding()
	Signal(SIG_HOVER)
	
	lastKnownPosX = 0
	lastKnownPosY = 0
	lastKnownPosZ = 0
	StartThread(doAllTheThings)
	
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

sign = 1
function getLoud(lastLoudness)
	if lastLoudness >= 1 then
		sign = -1
		
	elseif lastLoudness < 0.3 then
		sign = 1
	end
	return lastLoudness + valToAdd * sign
end

function script.StartBuilding(heading, pitch)
	
	lastLoudness = getLoud(lastLoudness)
	
	StartThread(PlaySoundByUnitDefID, conairDefID, "sounds/conair/cConAir.wav", lastLoudness, 1000, 1, 0)
	
	boolRopeRelease = false
	Signal(SIG_HOVER)
	--Signal(SIG_CHECK)
	StartThread(workInProgress)
	
	
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

Spring.SetUnitNanoPieces(unitID, { nanoemit })