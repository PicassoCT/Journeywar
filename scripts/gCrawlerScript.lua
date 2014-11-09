include "jVitalFunctions.lua"
include "suddenDeath.lua"
include "toolKit.lua"


EverythingIsBetterWithWheels={}

Wheel1 = piece"Wheel1"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel1
Wheel10 = piece"Wheel10"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel10
Wheel11 = piece"Wheel11"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel11
Wheel12 = piece"Wheel12"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel12
Wheel13 = piece"Wheel13"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel13
Wheel14 = piece"Wheel14"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel14
Wheel15 = piece"Wheel15"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel15
Wheel16 = piece"Wheel16"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel16
Wheel17 = piece"Wheel17"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel17
Wheel18 = piece"Wheel18"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel18
Wheel2 = piece"Wheel2"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel2
Wheel3 = piece"Wheel3"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel3
Wheel4 = piece"Wheel4"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel4
Wheel5 = piece"Wheel5"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel5
Wheel6 = piece"Wheel6"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel6
Wheel7 = piece"Wheel7"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel7
Wheel8 = piece"Wheel8"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel8
Wheel9 = piece"Wheel9"
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels+1]={}
EverythingIsBetterWithWheels[#EverythingIsBetterWithWheels]= Wheel9


SIG_DELAY=2

piecesTable={}
center = piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
Crawler = piece"Crawler"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Crawler
Cranbase1 = piece"Cranbase1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cranbase1
CraneArm1 = piece"CraneArm1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CraneArm1

Cranbase2 = piece"Cranbase2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cranbase2
CraneArm2 = piece"CraneArm2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CraneArm2

Cranbase3 = piece"Cranbase3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cranbase3
CraneArm3 = piece"CraneArm3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CraneArm3

Ropes={}
Rope1 = piece"Rope1"
Ropes[#Ropes+1]={}
Ropes[#Ropes]= Rope1
Rope2 = piece"Rope2"
Ropes[#Ropes+1]={}
Ropes[#Ropes]= Rope2
Rope3 = piece"Rope3"
Ropes[#Ropes+1]={}
Ropes[#Ropes]= Rope3
Rope4 = piece"Rope4"
Ropes[#Ropes+1]={}
Ropes[#Ropes]= Rope4
Rope5 = piece"Rope5"
Ropes[#Ropes+1]={}
Ropes[#Ropes]= Rope5
Rope6 = piece"lettherebelight.3DS"
Ropes[#Ropes+1]={}
Ropes[#Ropes]= Rope6


Gate = piece"Gate"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Gate
crawlerlightpoint = piece"crawlerlightpoint"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= crawlerlightpoint
center2 = piece"lettherebelight.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center2
lettherebelight3DS = piece"lettherebelight.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= lettherebelight3DS
Kreis02 = piece"Kreis02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis02
Objekt06 = piece"Objekt06"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Objekt06
Objekt09 = piece"Objekt09"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Objekt09

AdaptTable={}

for i=1,6,1 do
AdaptTable[i]={}
AdaptTable[i][1]={}
AdaptTable[i][2]={}
AdaptTable[i][3]={}

Tires="Tires"..i
PointOfMeasurement="pm"..i
AdaptTable[i][1]=piece(Tires)
AdaptTable[i][2]=piece(PointOfMeasurement)
AdaptTable[i][3]=0
end
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
local spGetGroundHeight=Spring.GetGroundHeight

function HowHighIsTheTireMama(i)
x,y,z,_,_,_=spGetUnitPiecePosDir(unitID,AdaptTable[i][2])
h=spGetGroundHeight(x,z)
return     y,h
end

tm1=piece"tm1"
tm2=piece"tm2"

function acquireVehicleDegree()
	 ax,ay,az,_,_,_=spGetUnitPiecePosDir(unitID,tm1)
	 bx,by,bz,_,_,_=spGetUnitPiecePosDir(unitID,tm2)
	--deg=math.atan2(by-ay,math.sqrt(((bz-az)^2)+((ay-by)^2)))*(180/pi)

	-- dx,dy,dz=Spring.GetUnitDirection(unitID)
	opposite=ay-by

	   local ax=ax-bx
	   local az = az - bz
	   
	   local len = math.sqrt( ax*ax +az * az)
			
			
	deg=math.floor(math.atan2(opposite, len)*(180/3.14159))
	--Spring.Echo("acquireVehicleDegree",deg)

	return deg
	end

	function RopePhysixLoop()  --Programmed by Cubex - Warning: This function pseudo-code was mentally programmed in my bathroom and then implemented in lua, can contain shit traces
		--Speed Ups
		local spGetUnitPosition = Spring.GetUnitPosition
		local spGetUnitPiecePosition = Spring.GetUnitPiecePosition
		local spGetUnitVectors = Spring.GetUnitVectors
		local spGetPieceRotation= Spring.UnitScript.GetPieceRotation
		local spIsInTurn=Spring.UnitScript.IsInTurn
		local pi = math.pi
		local abs = math.abs

		--Functions
		local function GetUnitPiecePos(unit,piece) --function by jK
			local x,y,z = spGetUnitPosition(unit)
			local front,up,right = spGetUnitVectors(unit)
			local px,py,pz = spGetUnitPiecePosition(unit,piece)
			return x + (pz*front[1] + py*up[1] + px*right[1]),
				y + (pz*front[2] + py*up[2] + px*right[2]),
				z + (pz*front[3] + py*up[3] + px*right[3])
		end

		--Parameters
		--local Randomness = 0.50       --Adding some random to trees, never conviced me, use at your wish
		local Scale = 0.9   --0.6           --Scales the current applied force, bigger means more shakey
		local Speed = 0.12              --How much time takes a tree to turn to spetified angle, improves smoothness (too high might cause too radical moves, too low can cause lack of time to react)
		local RotationLimit = pi / 10  --6  --The maximum angle which a tree can rotate
		local MoveThreshold = pi / 22 --If the movement is less than this, don't move, used to avoid "shake effect" in trees
		local RefreshInterval = 66     --How much ms to wait for each iteration
		local TreePosition = {}         --Each tree position (last x axis, last z axis) used to calculate the diference betwen each loop and checks how much the tree was moved until last check
	   
		--Initialization
		----Spring.Echo("RING RING RING!!! BANANA PHONE!!!") --For knowing if unit script runs or it crashed :/
		for i = 1, #Ropes do
			local Piece = Ropes[i]
			--Show(Piece) --Used for looking all trees
			local px, _, pz = GetUnitPiecePos(unitID, Piece) --Actual Position
			TreePosition[i] = {px, pz} --update the last position with the actual
		end
	   
		--Code
		while true do
			for i = 1, #Ropes do
					
						local Piece = Ropes[i]
						local px, _, pz = GetUnitPiecePos(unitID, Piece)            --Actual Position
						local lx, lz = unpack(TreePosition[i])                      --get the last position
						TreePosition[i] = {px, pz}                                  --update the last position with the actual

						--calculate the piece base traveled distance until the last update
						px = (px-lx) -- * (random() + Randomness)
						pz = (pz-lz) -- * (random() + Randomness)
						px = px * Scale
						pz = pz * Scale
					   
						if abs(px) > RotationLimit then
							if px < 0 then px = -RotationLimit
							else px = RotationLimit
							end
						elseif abs(px) < MoveThreshold then
							px = 0
						end
					   
						if abs(pz) > RotationLimit then
							if pz < 0 then pz = -RotationLimit
							else pz = RotationLimit
							end
						elseif abs(pz) < MoveThreshold then
							pz = 0
						end
					   --in addition	
					   local spx=Speed
					   if math.deg(px) < 4 and math.deg(px) > -4 then 
					   spx=negInvert((math.deg(px))/22)
					   end
					   
					   local spz=Speed
					   if math.deg(pz) < 4 and math.deg(pz) > -4 then 
						   spz=negInvert((math.deg(pz))/22)
					   end
					   
					   if spx <0.05 then spx=0.05 end
					   if spz <0.05 then spz=0.05 end
					   
			
						if i==6 then 
						spx=0.01 
						spz=0.01
						end

						Turn(Piece, x_axis, px, spx)
						Turn(Piece, z_axis, pz, spz)
						
							if true==spIsInTurn(Piece, x_axis) or true==spIsInTurn(Piece, x_axis) then
							else
							x,y,z=spGetPieceRotation( Piece )
							if math.deg(abs(x)) < 3 then Turn(Piece, x_axis, 0, spx) else Turn(Piece, x_axis, (x*-0.75), spx) end
							if math.deg(abs(z)) < 3 then Turn(Piece, z_axis, 0, spx) else Turn(Piece, z_axis, (z*-0.75), spz) end
							end
							   --/in addition
					
					
					
						
					
			end	
		Sleep(RefreshInterval)
		end
	   
	end -- Cubex's Ecosystem ends here, bye indentation :( I will miss you
	
	
function adapt()

while true do



	for i=1,3,1 do
	--Meassuring
	y,h=HowHighIsTheTireMama(i)
	
	
	
	
		if h-y > 5 then --and AdaptTable[i][3] > 25 then 
		Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]-1),0.035)
		AdaptTable[i][3]=AdaptTable[i][3]-1
			else
			Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]+1),0.05)
			AdaptTable[i][3]=AdaptTable[i][3]+1
			end

	end
	
	for i=4,6,1 do
	--Meassuring
	y,h=HowHighIsTheTireMama(i)
	
	
	
	
		if h-y < 3 then --and AdaptTable[i][3] > 25 then 
		Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]-1),0.035)
		AdaptTable[i][3]=AdaptTable[i][3]-1
			else
			Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]+1),0.05)
			AdaptTable[i][3]=AdaptTable[i][3]+1
			end

	end
	-- for i=4,6,1 do
		-- h=HowHighIsTheTireMama(i)
			-- if h > 10 and AdaptTable[i][3] <  -25 then 
			-- Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]-1),0.15)
			-- AdaptTable[i][3]=AdaptTable[i][3]-1
				-- else
				-- Turn(AdaptTable[i][1],z_axis,math.rad(AdaptTable[i][3]+2),0.15)
				-- AdaptTable[i][3]=AdaptTable[i][3]+2
				-- end
	-- end
Sleep(550)
end
end


function script.Create()
Spring.SetUnitAlwaysVisible(unitID,true)
StartThread(constTurn)
StartThread(spinCenter2)
StartThread(adapt)
StartThread(RopePhysixLoop)
StartThread(mission)
StartThread(sfx)
Hide(gtree)
for i=1,table.getn(AdaptTable), 1 do
Hide(AdaptTable[i][2])
end

end




function script.Killed(h,k)

for i=1,table.getn(piecesTable),1 do
 unitx,unity,unitz=Spring.GetUnitPiecePos(unitID,piecesTable[i])
Spring.SpawnCEG("330RLexplode",unitx,unity,unitz,0,1,0,50,0)
end

suddenDeathVM(recentDamage)
return 0
end

--Spring.PlaySoundFile("sounds/cRes/cthoff.wav")
boolConstMove=false
smokeEmit=piece"smokeEmit"
lightemit=piece"lightemit"
function sfx()
Hide(lightemit)
Move(lightemit,y_axis,-45,0)
while true do
for i=1,#AdaptTable,1 do
if math.random(0,1)==1 then EmitSfx(AdaptTable[i][2],1024) end
if math.random(0,1)==1 then EmitSfx(smokeEmit,1026) else EmitSfx(smokeEmit,1027) end
end
EmitSfx(lightemit,1028)

Sleep(100)
end

end

function constTurn()
orgHeading=Spring.GetUnitHeading(unitID)
orgHeading=math.abs(orgHeading/180)
	while true do
	
	currentHeading=Spring.GetUnitHeading(unitID)/180
	res=orgHeading-math.abs(currentHeading+180)
	Turn(lettherebelight3DS,y_axis,math.rad(res),0.3141)	--4 deg per sec
	Sleep(10)
	end

end

function spinCenter2()

	
	while true do
	Height=math.random(-35,35)
	Move(lettherebelight3DS,y_axis,Height,0.1)
	

	if math.random(0,1)==1 then
	diceDeg=math.random(-360,360)
	Turn(Cranbase2,y_axis,math.rad(diceDeg),0.6)
	end
	if math.random(0,1)==1 then
	diceDeg=math.random(-360,360)
	Turn(Cranbase3,y_axis,math.rad(diceDeg),0.6)
	end
	
	Sleep(25000)
	StopSpin(lettherebelight3DS,y_axis,0.001)
	end
end
function spinArray(Array,axis,radius,speed)
for i=1,table.getn(Array),1 do
Spin(Array[i],axis,math.rad(radius),speed)
end
end
	
function stopSpinArray(Array,axis,radius,speed)
for i=1,table.getn(Array),1 do
StopSpin(Array[i],axis,math.rad(radius),speed)
end
end	
	
function turnArray(Array,axis,radius,speed,waitForIt)
for i=1,table.getn(Array),1 do
Turn(Array[i],axis,math.rad(radius),speed)
end
	if waitForIt==true then
	WaitForTurn(Array[table.getn(Array)],axis)
	end
end

function mission()
	while true do
	Sleep(22000)
	spawnATree()
	end

end

gtree=piece"gtree"
function spawnATree()
Move(gtree,y_axis,0,0)
Move(gtree,z_axis,0,0)
Move(gtree,x_axis,0,0)
Turn(gtree,y_axis,math.rad(0),0)
Move(Gate,y_axis,80,3.5)
Move(gtree,z_axis,35,0)
Show(gtree)
Move(gtree,z_axis,0,3)
WaitForMove(gtree,z_axis)
Spring.PlaySoundFile("sounds/cOperaT/opendoor.wav")
WaitForMove(Gate,y_axis)
Move(gtree,y_axis,-70,15)
Move(gtree,z_axis,-25,3)
Turn(gtree,y_axis,math.rad(180),0.5)
WaitForMove(gtree,z_axis)
WaitForMove(gtree,y_axis)

x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,gtree)
teamID=Spring.GetUnitTeam(unitID)
GG.UnitsToSpawn:PushCreateUnit("gglasstree",x,1,z,0,teamID)
Hide(gtree)
Move(Gate,y_axis,0,5.5)
end
	
function delayedMove()
SetSignalMask(SIG_DELAY)
Sleep(250)
StartThread(spinArray,EverythingIsBetterWithWheels,x_axis, 12,0)

end

function delayedStop()
SetSignalMask(SIG_DELAY)
Sleep(1500)
StartThread(stopSpinArray,EverythingIsBetterWithWheels,x_axis,0)
end
	
function script.StartMoving()
Signal(SIG_DELAY)
StartThread(delayedMove)
end

function script.StopMoving()
Signal(SIG_DELAY)
StartThread(delayedStop)
end

			
			
		
		
