include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 
include "lib_type.lua" 
include "classRopeSimulation.lua"



turret = piece "sstowgab"
turret2= piece "sstower"
flare = piece "sscflare"
--define other pieces
sstowf = piece "sstowf"
sstowf2 = piece "sstowf2"
csniper = piece "csniper"
cwheel1 = piece "sswheel"
cwheel2 = piece "sswheel2"
cwheel3 = piece "sswheel3"
cwheel3 = piece "sswheel4"
ssharpoon = piece "ssharpoon"
overfloor = 3
piecelenght = 15.4
nrOfPieces = 12
baseDistanceToFirstPiece = 50
totalDistanceToEndPiece =  ((piecelenght-1)*nrOfPieces) --+baseDistanceToFirstPiece - 20
boolFreeHanging = false
ropeSpeed = 0
SIG_AIM = 2^1
SIG_FOLD = 2^2
SIG_UNFOLD = 2^3
SIG_SPAM = 2^4
SIG_SCOPE = 2^5
SIG_ROPE =  2^7
SIG_MOVEIN = 2^8
SIG_MOVEOUT = 2^9


local boolStillAiming = false
boolFireLock = false
spamfilterSTART=true
spamfilterSTOP = false
local tempIdle=1
local boolFilterActive = false
local spotOnTarget = false
local boolHaveAbreak = false
local boolTargetInScope = false
local boolEmit=true
local harpoonupmyass= piece"harpoonupmyass"
local bloodemt= piece"bloodemt"
local emitblood= piece"emitblood"
local pm1= piece"pm1"
local pm2= piece"pm2"
local maxSpeed=math.ceil( 2.5 * 65533)

local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
local boolUnitLoaded = false
local ropestarts={}
local sensors={}
rope={}
for i=1,12,1 do

	doop="rs"..i
	temp="sensor"..i
	aNewRope="rope0"..i
	sensors[i]=piece(temp)
	ropestarts[i]=piece(doop)
	rope[i]=piece(aNewRope)
end
local pi=math.pi



local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
function acquireVehicleDegree()
	ax,ay,az,_,_,_=spGetUnitPiecePosDir(unitID,pm1)
	bx,by,bz,_,_,_=spGetUnitPiecePosDir(unitID,pm2)

	opposite=ay-by
	
	local ax=ax-bx
	local az = az - bz
	
	local len = math.sqrt( ax*ax +az * az)
	
	deg=math.floor(math.atan2(opposite, len)*(180/pi))

	return deg
end

Infantry=getInfantryTypeTable()

function isInfantry(passengerDefID)
	if Infantry[passengerDefID] then return true else return false end
end

function draggingSound()
	local spPlaySoundFile=Spring.PlaySoundFile
	while(true) do
		wdice=math.random(0,2)
		if wdice==1 then
			spPlaySoundFile("sounds/csniper/drag3sec.wav",0.8) 
			Sleep(3000)
			spPlaySoundFile("sounds/csniper/drag6sec.wav",0.8) 
			Sleep(6000)
		elseif wdice== 0 then
			spPlaySoundFile("sounds/csniper/drag3sec.wav",0.8) 
			spPlaySoundFile("sounds/csniper/drag6sec.wav",0.8) 
			Sleep(4600)
		else
			randsleep=math.random(4000,9000)
			Sleep(randsleep)
		end
	end
end

local spEmitSfx=EmitSfx
function dustEmit(boolIsABioUnit)
	local lEmitSfx=EmitSfx
	if boolIsABioUnit==true then
		Spring.PlaySoundFile("sounds/csniper/harpimpflesh.wav") 
		Sleep(150)
		for i=1, 22, 1 do
			lEmitSfx(emitblood,1025)
			nap=i*4+10
			Sleep(nap)
		end
	else
		Spring.PlaySoundFile("sounds/csniper/harpimpmetallr.wav") 
	end
	local lEmitSfx=EmitSfx
	local spCreateUnit=Spring.CreateUnit
	while(true) do
	
	if boolMoving==true then
			if boolIsABioUnit==true then
				dice=math.random(0,1)
				if dice==1 then 
					throw=math.random(4,12)
					for i=1,throw,1 do
						lEmitSfx(emitblood,1025) 
						lEmitSfx(emitblood,1025) 
						Sleep(98)
						Sleep(throw)
					end
				else 
					throw=math.random(4,12)
					for i=1,throw,1 do
						lEmitSfx(emitblood,1025) 
						lEmitSfx(emitblood,1025) 
						Sleep(98)
						Sleep(throw)
					end
					x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID, emitblood)
					teamID=Spring.GetGaiaTeamID()
					spCreateUnit("blooddecalfactory",x,y,z,0,teamID)
				end
				
			else
				throw=math.random(4,12)
				for i=1,throw,1 do
					lEmitSfx(emitblood,1026) 
					Sleep(throw)
					Sleep(throw)
					lEmitSfx(emitblood,1026) 
					Sleep(98)
				end
				
			end
	end
		nap=math.random(30,200)
		Sleep(nap)
	end
end


function Neg(val)
	if val<=0 then return val end
	return val*-1
end

function acquireRopeDegree(i)
	
	if i ==1 then			
		ax,ay,az,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[12])
		ay=(Spring.GetGroundHeight(ax,az))+overfloor
		bx,by,bz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[12])
		
		--local 	cy=Spring.GetGroundHeight(bx,bz)
		local opposite=by-ay 
		
		ax=bx-ax
		az = bz-az
		local len = math.sqrt( ax*ax +az * az)
		--Spring.Echo("Length which should always be 13",len)
		djego=math.floor(math.atan2(opposite, len)*(180/pi))
		
		if opposite < 0 then return unNeg(djego) else return Neg(djego) end
		-------------------------------------------------------------------------------------------------------------------------------------
	else
		ax,ay,az,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[13-i])--
		ay=(Spring.GetGroundHeight(ax,az))+overfloor
		--Spring.Echo("Sensor: ", 13-i .." 	has Position X:", ax, " Position Z:", az)
		--local 	ay=heightTable[13-i] --Spring.GetGroundHeight(ax,az)
		bx,by,bz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[13-i])
		
		--Spring.Echo("RopePivotr: ", 13-i .." 	has Position X:", bx, " Position Z:", bz)
		local opposite=by-ay +overfloor
		if opposite >-1 and opposite < 1 then return 0 end
		local hax=ax-bx
		local haz = az - bz
		
		local len = math.sqrt( hax*hax +haz * haz+ opposite*opposite)
		--Spring.Echo("Length which should always be 13",len)
		len=15.4
		
		adeg=math.floor(math.atan2(opposite, len)*(180/pi))
		
		if opposite <= 0 then return unNeg(adeg) else return Neg(adeg) end
		
	end
end

--delMe
function sensorBlink()
	-- for i=1,7,1 do
	-- for i=1,table.getn(sensors),1 do
	-- EmitSfx(sensors[13-i],1027)
	-- EmitSfx(sensors[13-i],1027)
	-- Sleep(60)
	-- end
	-- end
end
--/delMe
function echoNPreveDegTable()
	for i=1,table.getn(nPrevDegTable),1 do
		--Spring.Echo("Piece Nr:",13-i.. " has ",nPrevDegTable[13-i])
	end
end

function unNeg(val)
	if val >= 0 then return val end
	return val*-1
end

function clamp(val)
	if val <= 1 then 
		return 1 
	end
	if val >= 12 then 
		return 12 
		
	else 
		return val 
	end
end
--deprecated
function sumDegree(startv,endv)
	if startv==endv then return nPrevDegTable[13-starv] end
	
	degSum=0

	for i=startv,endv,1 do
		
		if nPrevDegTable[13-i]~= nil then
			degSum=degSum+nPrevDegTable[13-i]
		end
		
	end
	--Spring.Echo("DegSum",degSum)
	return degSum
end

--function: determinates the degree a piece needs to have
function detDegree(preInterVallStart,interVallStart,interVallEnd)
	if preInterVallStart== interVallStart or interVallStart== interVallEnd then return -1*nPrevDegTable[13-interVallStart] end
	if interVallStart~=1 then
		local	dist=((interVallEnd-interVallStart))*15.4
		sx,sy,sz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[13-interVallStart])
		--sy=Spring.GetGroundHeight(sx,sz)
		ex,ey,ez,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[13-interVallEnd])
		groundheight=Spring.GetGroundHeight(ex,ez)
		local	opposite=sy-groundheight
		--Sum of All Previous Degrees -negated, so that whatever we turn is relative zero.
		
		-- nPrevDegTable[13-interVallStart]=reSlut
		reSlut= -1*	nPrevDegTable[13-interVallStart+1] + (math.atan2(opposite,dist)*(180/pi))
		
		return reSlut
	else
		
		local	dist=((interVallEnd-interVallStart))*15.4
		--Spring.Echo("distance",distance)
		sx,sy,sz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[12])
		sy=Spring.GetGroundHeight(sx,sz)
		ex,ey,ez,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[13-interVallEnd])
		groundheight=Spring.GetGroundHeight(ex,ez)
		local	opposite=sy-groundheight
		--Sum of All Previous Degrees -negated, so that whatever we turn is relative zero.
		reSlut= acquireVehicleDegree() + (math.atan2(opposite,dist)*(180/pi))
		-- nPrevDegTable[13-interVallStart]=reSlut
		return reSlut
	end
end

tempVar=1



heightTable={}
nPrevDegTable={}

--Keep the ropebase physicaly Resting
rotationOffset =0
RopeRestPiece=rope[12]
function ropeRelativeResting()
	heading =  (Spring.GetUnitHeading(unitID))/ 32768*math.pi
	while true do	
	
		if boolMoving == false then
			heading =  (Spring.GetUnitHeading(unitID))/ 32768*math.pi
			Turn(RopeRestPiece,y_axis, -heading + rotationOffset, 15)
		else	
			Turn(csniper,y_axis,0 ,2) -- () -- (heading - 8192)*-1 | (-heading+(32768/2))
			rotationOffset =  (Spring.GetUnitHeading(unitID))/ 32768*math.pi		
			Turn(RopeRestPiece,y_axis, 0, 1.5)
		end
		Sleep(10)
	end

end




--limits ropephysix instances
function checkSnipers()
	local snipersTotal= GG.GlobalSniperRopeSimTable.Ids
	local boolAltered = false
	for i=1,#snipersTotal, 1 do
		if snipersTotal[i] then
			if Spring.GetUnitIsDead(snipersTotal[i]) ==true then
				table.remove(snipersTotal,snipersTotal[i])
				i=math.max(1,i-1)	
				boolAltered=true
			end
		end
	end
	GG.GlobalSniperRopeSimTable.number=#snipersTotal
	GG.GlobalSniperRopeSimTable.Ids=snipersTotal
	return boolAltered
end


boolIHaveSimActive = false
function ourOnlyRope (passengerID)
	SetSignalMask(SIG_ROPE)
	local 	passengerDefID=Spring.GetUnitDefID(passengerID)
	
	
	boolBioUnit = false
	if isInfantry(passengerDefID)==true or passengerDefID == UnitDefNames["gjbigbiowaste"].id or 	passengerDefID == UnitDefNames["gjmedbiogwaste"].id then
		boolBioUnit=true
	end
	Turn(bloodemt,y_axis,math.rad(-90),0.03)
	StartThread(dustEmit,boolBioUnit)
	StartThread(draggingSound)



	
	while(boolUnitLoaded==true) do
		Sleep(50)
	end
	
	Turn(bloodemt,y_axis,math.rad(0),0)
	
end

local fourPieces= {}
	  fourPoints= {}
for i=1,4 do
	fourPieces[i]= piece("fp"..i)
	fourPoints[i]= {}
end


transportableDefIds= getRecycleableUnitTypeTable()
infantryTypeTable= getInfantryTypeTable()
local transportedID=nil
function script.TransportPickup(passengerID)
	--Spring.Echo("TransportPickup")
	local UnitedDefIDs=Spring.GetUnitDefID(passengerID)
	if boolUnitLoaded == false and (transportableDefIds[UnitedDefIDs] or infantryTypeTable[UnitedDefIDs]) then
		SetUnitValue(COB.BUSY, 1)	
		
		local px1, py1, pz1 = Spring.GetUnitPosition(unitID)
		local px2, py2, pz2 = Spring.GetUnitPosition(passengerID)
		local dx, dy , dz = px2 - px1, py2 - py1, pz2 - pz1
		norm= math.sqrt(dx^2 +dy^2 +dz^2)
		sheading = (65533 - Spring.GetHeadingFromVector(dx/norm, dz/norm)) - (Spring.GetUnitHeading(unitID))/(32768*math.pi)
		WTurn(csniper,y_axis,sheading ,12) -- () -- (heading - 8192)*-1 | (-heading+(32768/2))

		expandRope()
		transportedID=passengerID
		AttachUnit(bloodemt, passengerID)
		retractRopePercent(60,15)
		boolUnitLoaded=true
		
		StartThread(ropeRelativeResting)
		StartThread(ourOnlyRope,passengerID)
		
	
		SetUnitValue(COB.BUSY, 0)
	end		
end		

function script.TransportDrop(passengerID, x, y, z)
	Signal(SIG_ROPE)
	
	retractRope() 
	if boolUnitLoaded == false then return end
	--if unit not boolUnitLoaded
	SetUnitValue(COB.BUSY, 1)
	
	DropUnit(transportedID)
	transportedID=nil
	boolUnitLoaded = false
	
	SetUnitValue(COB.BUSY, 0)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function spamFilter()
	SetSignalMask(SIG_SPAM)
	
	while (true) do
		
		if spamfilterSTART==true and spamfilterSTOP== false then 
			for it=0,3,1 do
				Sleep(1024)
				if spamfilterSTOP==true then
					spamfilterSTART = false
					break 
				end
			end
			if spamfilterSTART==true then
				--if spamfilterSTART is still ==true then
				Signal(SIG_FOLD)
				
				StartThread (fold) 
			end
			
		end
		
		if spamfilterSTOP==true and spamfilterSTART== false then 
			for it=0,3,1
			do
				Sleep(1024)
				if spamfilterSTART==true then
					spamfilterSTOP = false
					break 
				end
			end
			if spamfilterSTOP==true then
				--if spamfilterSTOP is still ==true then
				Signal(SIG_FOLD)
				Signal(SIG_UNFOLD)
				StartThread(unfold) 
			end
			
		end
		
		if spamfilterSTOP== false and spamfilterSTART== false then 
			
			----Spring.Echo("No idea what you did, but you broke it. You gonna pay!")
			
		end
		
	end
end

function fold()
	boolFireLock=true
	Signal(SIG_UNFOLD)
	SetSignalMask(SIG_FOLD)
	----Spring.Echo("ThreadUnFold")
	
	Turn(turret,x_axis,math.rad(0),2.2*3)
	Turn(turret,y_axis,math.rad(0),2.2*3)
	Turn(turret,z_axis,math.rad(0),2.2*3)
	WaitForTurn(turret,x_axis)
	Turn(turret, x_axis,math.rad(0),1.85*3)
	Turn(turret2, x_axis,math.rad(0),1.85*3)
	Turn(sstowf2,y_axis,math.rad(180),4*3)
	WaitForTurn(sstowf2,y_axis)
	WaitForTurn(turret2, x_axis)
	Move(sstowf,y_axis, -65,165.0)
	WaitForMove(sstowf,y_axis)
	Sleep(50)
	Hide(sstowf)
	Hide(sstowf)
	Turn(turret,y_axis,math.rad(0),2.2*3)
	
	while(true) do

		Sleep(1024)
	end
end

function unfold()
	
	Signal(SIG_FOLD)
	----Spring.Echo("ThreadFold")
	SetSignalMask(SIG_UNFOLD)
	Show(sstowf)
	Show(sstowf)
	turner=math.random(-2,2)
	Turn(turret,x_axis,math.rad(turner),1)
	WaitForTurn(turret,x_axis)
	Move(sstowf,y_axis, 0,5)
	WaitForMove(sstowf,y_axis)
	boolFireLock = false
	
	
	
end

function TargetInScope()
	SetSignalMask(SIG_SCOPE)
	Sleep(20000)
	boolTargetInScope = false
	
end


boolMoving= false
adaptionfactor=0.0

function moveDetector()
ox,oy,oz= Spring.GetUnitPosition(unitID)
	while true do
		lx,ly,lz= Spring.GetUnitPosition(unitID)
		if distance(ox,oy,oz,lx,ly,lz)> 10 then
			boolMoving = true
		else
			boolMoving=false
		end
		Sleep(350)
		ox,oy,oz=lx,ly,lz
	end
end

function script.StartMoving()
	if boolFilterActive== false then
		Signal(SIG_SPAM)
		StartThread(spamFilter)
		boolFilterActive=true
	end
	Turn(csniper, y_axis, math.rad(0),9)
	spamfilterSTOP = false
	spamfilterSTART=true
end

function script.StopMoving()
	-- ----Spring.Echo ("stopped walking!")
	spamfilterSTART = false 
	spamfilterSTOP=true 

end

local function spamFilter()
	SetSignalMask(SIG_SPAM)
	
	while (true) do
		
		if spamfilterSTART==true and spamfilterSTOP== false then 
			for it=0,3,1 
			do
				Sleep(1024)
				if spamfilterSTOP==true then
					spamfilterSTART = false
					break 					
				end
			end
			if spamfilterSTART==true then
				--if spamfilterSTART is still ==true then
				Signal(SIG_FOLD)
				
				StartThread (fold)				
			end
			
		end
		
		if spamfilterSTOP==true and spamfilterSTART== false then 
			for it=0,3,1 
			do
				Sleep(1024)
				if spamfilterSTART==true then
					spamfilterSTOP = false
					break 					
				end
			end
			if spamfilterSTOP==true then
				--if spamfilterSTOP is still ==true then
				Signal(SIG_FOLD)
				Signal(SIG_UNFOLD)
				StartThread(unfold)			
			end
			
		end
		
		if spamfilterSTOP== false and spamfilterSTART== false then 
			
			----Spring.Echo("No idea what you did, but you broke it. You gonna pay!")
			
		end
		
	end
end

function fold()
	boolFireLock=true
	Signal(SIG_UNFOLD)
	SetSignalMask(SIG_FOLD)
	----Spring.Echo("ThreadUnFold")
	
	Turn(turret,x_axis,math.rad(0),2.2)
	Turn(turret,y_axis,math.rad(0),2.2)
	Turn(turret,z_axis,math.rad(0),2.2)
	WaitForTurn(turret,x_axis)
	Turn(turret, x_axis,math.rad(0),1.85)
	Turn(turret2, x_axis,math.rad(0),1.85)
	Turn(sstowf2,y_axis,math.rad(180),4)
	WaitForTurn(sstowf2,y_axis)
	WaitForTurn(turret2, x_axis)
	Move(sstowf,y_axis, -65,6)
	WaitForMove(sstowf,y_axis)
	Sleep(50)
	Hide(sstowf)
	Hide(sstowf)
	Turn(turret,y_axis,math.rad(0),2.2)
	
	while(true) do
		Turn(turret,y_axis,math.rad(0),2.2)
		Sleep(1024)
	end
end

function unfold()
	
	Signal(SIG_FOLD)
	----Spring.Echo("ThreadFold")
	SetSignalMask(SIG_UNFOLD)
	Show(sstowf)
	Show(sstowf)
	turner=math.random(-2,2)
	Turn(turret,x_axis,math.rad(turner),1)
	WaitForTurn(turret,x_axis)
	Move(sstowf,y_axis, 1,5)
	WaitForMove(sstowf,y_axis)
	boolFireLock = false
	Turn(sstowf2,y_axis,math.rad(0),4)
	while(true) do
		Sleep(512)

	end
	
	
end

function delayedReactivation()
Sleep(5000)
boolEmit=true	
end


function constLazzorsEmit()
	Sleep(1500)
	local lEmitSfx = EmitSfx

	while(true) do
		
		if boolEmit == true then

			lEmitSfx(flare,1028)
		end
		--EmitSfx by force
		Sleep(65)
		
	end	
end

function retractRopePercent(opercent, speed)
	percent = math.ceil((opercent/100)*12)
	Move(harpoonupmyass,z_axis,(percent-1)*14,speed)
	RopeRestPiece=rope[math.max(1,percent-2)]
	for i=1, percent-2,1 do
		tMinus= tMinus+14
		Turn(rope[(13-i)],x_axis,math.rad(0),600)
		Turn(rope[(13-i)],z_axis,math.rad(0),600)
		Turn(rope[(13-i)],y_axis,math.rad(0),600)
		Show(rope[(13-i)])
		Sleep(10)
	end
	
	for i=percent-2, 12,1 do
		Hide(rope[(i)])
	end
end
function expandRopePercent(percent, speed)
	percent = math.ceil((percent/100)*12)
	tMinus=166

	for i=1, percent,1 do
		tMinus=tMinus-14
		Move(harpoonupmyass,z_axis,tMinus,speed)
		Show(rope[i])
		WaitForMove(harpoonupmyass,z_axis)
	end
end

--function retracts rope from any lenght
function retractRope()

	Spring.PlaySoundFile("sounds/csniper/harpoonretract.wav") 
	Sleep(666)
	Move(harpoonupmyass,z_axis,166,420)
	Sleep(50)

	for i=1, 12,1 do
		Turn(rope[(13-i)],x_axis,math.rad(0),600)
		Turn(rope[(13-i)],z_axis,math.rad(0),600)
		Turn(rope[(13-i)],y_axis,math.rad(0),600)
		Hide(rope[(13-i)])
		Sleep(10)
	end
	Show(ssharpoon)
end
--function expands the Rope to maximalLength
function expandRope()
	bool=math.random(0,1)
	if bool== 1 then
		Spring.PlaySoundFile("sounds/csniper/harpoonexp1.wav") 
	else
		Spring.PlaySoundFile("sounds/csniper/harpoonexp2.wav") 
	end
	
	Hide(ssharpoon)
	tMinus=166
	harpoonSpeed=42
	Move(harpoonupmyass,z_axis,tMinus,ropeSpeed)
	for i=1, #rope,1 do
		tMinus=tMinus-14
		Move(harpoonupmyass,z_axis,tMinus,420)
		Show(rope[i])
		WaitForMove(harpoonupmyass,z_axis)
	end
end

function script.Create()
	Turn(csniper,y_axis,0 ,12)

	Hide(flare)
	Signal(SIG_SPAM)
	for i=1, #rope do
		Hide(rope[i])
	end
	StartThread(constLazzorsEmit)
	StartThread(moveDetector)
end

function script.Killed(recentDamage,_)
	if boolIHaveSimActive== true then
		GG.SniperRopeSim = dec(GG.SniperRopeSim)
	end
	Signal(SIG_SPAM)
	Signal(SIG_FOLD)
	Signal(SIG_UNFOLD)
	
	flipFlop=math.random(0,1)
	
	if flipFlop==1 then
		Turn(sstowf2,x_axis,math.rad(35),2)
		WaitForTurn(sstowf2,x_axis)
		Turn(sstowf2,x_axis,math.rad(78),6)
		WaitForTurn(sstowf2,x_axis)
		Turn(sstowf2,x_axis,math.rad(92),9)
		WaitForTurn(sstowf2,x_axis)
		Sleep(250)
		Explode (cwheel1, SFX.FIRE)
		Explode (cwheel2, SFX.FIRE)
		Explode (cwheel3, SFX.FIRE)
		Explode (cwheel3, SFX.FIRE)
		Explode (turret2, SFX.SMOKE)
		Explode (csniper, SFX.FIRE + SFX.SMOKE)
	end
	
	if flipFlop==0 then
		Turn(csniper,z_axis,math.rad(35),2)
		WaitForTurn(csniper,z_axis)
		Turn(csniper,z_axis,math.rad(78),6)
		WaitForTurn(csniper,z_axis)
		Turn(csniper,z_axis,math.rad(93),9)
		WaitForTurn(csniper,z_axis)
		Turn(csniper,z_axis,math.rad(85),6)
		WaitForTurn(csniper,z_axis)
		
		Turn(csniper,z_axis,math.rad(93),9)
		WaitForTurn(csniper,z_axis)
		Sleep(250)		
		Explode (cwheel1, SFX.FIRE)
		Explode (cwheel2, SFX.FIRE)
		Explode (cwheel3, SFX.FIRE)
		Explode (cwheel3, SFX.FIRE)
		Explode (turret2, SFX.SMOKE)
		Explode (csniper, SFX.FIRE + SFX.SMOKE)
		
		
	end
	
	createCorpseCUnitSmall(recentDamage) 
	
	return 0
end

function script.StartMoving()
	if boolFilterActive== false then
		Signal(SIG_SPAM)
		StartThread(spamFilter)	
		boolFilterActive=true
	end
	boolEmit=false	
	spamfilterSTOP = false
	spamfilterSTART=true
	
end

function script.StopMoving()
	-- ----Spring.Echo ("stopped walking!")
	spamfilterSTART = false		
	spamfilterSTOP=true		
end

function script.AimWeapon1(heading ,pitch)	
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	if boolFireLock==true then
		return false
	end
	
	if boolFireLock== false then
		boolStillAiming=true	
		
		--aiming animation: instantly turn the gun towards the enemy
		Turn(sstowf2, y_axis, heading,0.95)
		Turn(turret2, x_axis, -pitch,0.65)
		WaitForTurn(sstowf2,y_axis)
		WaitForTurn(turret2,x_axis)
		
		return true
	end	
end

function script.AimFromWeapon1() 

	return turret2 
end

function script.QueryWeapon1() 
	return turret2
end

function script.FireWeapon1()
	Signal(SIG_SCOPE)
	boolTargetInScope=true	
	Spring.PlaySoundFile("sounds/csniper/csniper.wav") 
	boolStillAiming = false
	boolEmit = false	
	Turn(turret2, x_axis, math.rad(-5),35)
	StartThread(delayedReactivation)
	return true
end

