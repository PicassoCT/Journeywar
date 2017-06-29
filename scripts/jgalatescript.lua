include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 


--4 Legs a 2 pieces + 1 centrall Piece + Cannon



fireGalate=piece"FireGalatea"
SailGalatea=piece"SailGalatea"
Tails={}
Tails=makeTableOfPieceNames("tail",16)
for i=1,#Tails do
	Tails[i]=piece(Tails[i])
end
Pumps=makeTableOfPieceNames("coTail0",4)
for i=1,#Pumps do
	Pumps[i]=piece(Pumps[i])
end

Legs=makeTableOfPieceNames("Leg",4)
for i=1,#Legs do
	Legs[i]=piece(Legs[i])
end

LegLs=makeTableOfPieceNames("LegL",4)
for i=1,#LegLs do
	LegLs[i]=piece(LegLs[i])
end


pieces=makeKeyPiecesTable(unitID,piece)
pieces["wholeBodyCenter"]=piece("wholeBodyCenter")
pieces["fireGalate"]=fireGalate
pieces.pumps=Pumps
pieces.leg=Legs
pieces.legl=LegLs
pieces.tails=Tails

PivotPoints={}
for i=1,9 do 
	PivotPoints[#PivotPoints+1]=pieces["Medusa"..i]
end


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	return damage
end

center=piece"center"
LocalBoolInWater=false




--sets the speed to 5,2 *65533
function ImSailing()
	maxspeed=math.ceil(COB.MAX_SPEED *65533)
	Heading=Spring.GetUnitHeading(unitID)
	while true do
		Heading=Spring.GetUnitHeading(unitID)
		Heading=(Heading/32768)*3.14159
		windHead=TurnTowardsWind(SailGalatea,0.5,Heading)
		diff= Heading-windHead
		ratio= 1-(diff/(32188))
		
		setSpeedEnv(unitID,ratio)	

	
		
		Sleep(250)
	end
end



function swimSimplySwimming()
	
	ox,oy,oz=Spring.GetUnitPiecePosDir(unitID,center)
	
	offset=5
	
	while true do
		wx,wy,wz=Spring.GetUnitPosition(unitID)
		LocalBoolInWater=false
		
		while wy < 0 do
			LocalBoolInWater=true
			wx,wy,wz=Spring.GetUnitPosition(unitID)
			offset=offset*-1
			KeepPieceAfloat(unitID,pieces["wholeBodyCenter"],9.15, -15, 5)
			
			Sleep(300)
		end
		
		Move(pieces["wholeBodyCenter"],2,0,1.15)
		Sleep(400)
	end
end


nlswimAnimation = function (PivotPoints,pieces) 
	
	local spGetUnitPiecePosDir		=	Spring.GetUnitPiecePosDir
	local spGetUnitPiecePosition	=	Spring.GetUnitPiecePosition
	
	--lets keep the unit under water
	
	spinT(pieces.tails,2,-42,42)
	spinT(pieces.pumps,2,-42,42)
	
	mul =math.sin(Spring.GetGameFrame()/3000) 
	for i=2,#PivotPoints do
		Turn(PivotPoints[i],1,math.rad(90),0.2)
		--Turn(PivotPoints[i],2,math.rad(27*mul),1.2)
		KeepPieceAfloat(unitID,PivotPoints[i],3.15,-5,5)
	end
	showT(pieces.pumps)
	showT(pieces.tails)
	--Pump Animation
	for i=1, #pieces.pumps do
		if math.abs(mul) < 0.3 then
			Move(pieces.pumps[i],2,5,0.4)
		else
			Move(pieces.pumps[i],2,0,0.9)	
		end
	end
	mul=mul*4
	mappedMul=math.max(1,math.min(math.abs(mul)/0.25,4))
	for i=1, #pieces.tails do
		if i% mappedMul ==0 then
			Show(pieces.tails[i])
		else
			Hide(pieces.tails[i])
		end
	end
	Sleep(300) 
end

nlstopSwimAnimation= function (PivotPoints,pieces) 
	frame=Spring.GetGameFrame()
	
	for i=2,#PivotPoints do
		mul =math.sin((i*300+frame)/3000) 
		Turn(PivotPoints[i],1,math.rad(0),0.2)
		val=math.random(20,65)* (-1^math.random(1,i))
		Move(PivotPoints[i],1, val,3)
		val=math.random(-20,20)
		Move(PivotPoints[i],3, val,3)
		Turn(PivotPoints[i],2,math.rad(mul*360),0.2)
		if i < 5 then
			KeepPieceAfloat(unitID,PivotPoints[i],6.15,-3,3)
		else
			KeepPieceAfloat(unitID,PivotPoints[i],6.15,-3,3)
		end
	end
	stopSpinT(pieces.tails,2,0.3)
end

function nloutOfWaterAnimation (PivotPoints,pieces)
	recResetT(pieces,4.3)
	resetT(PivotPoints,14.5)

	hideT(PivotPoints)
	Show(PivotPoints[1])
	hideT(pieces.tails)
	hideT(pieces.pumps)
	showT(pieces.leg)
	showT(pieces.legl)
	WaitForMove(PivotPoints[1],2)
	WaitForMove(PivotPoints[2],2)	
end
nlbackIntoWaterAnimation= function (PivotPoints,pieces)	
	
	Show(PivotPoints[1])
	hideT(pieces.leg)
	hideT(pieces.legl)
	showT(PivotPoints)
	reset(FireGalatea,6)
	StartThread(KeepPieceAfloat,unitID,pieces["wholeBodyCenter"],31.15,-15,15)
	for i=2,#PivotPoints do
		StartThread(KeepPieceAfloat,unitID,PivotPoints[i],31.15,-15,15)
		Spin(PivotPoints[i],2,math.rad(math.random(-22,22)),0.01)
		Turn(PivotPoints[i],1,math.rad(90),0.02)	
	end
	WaitForMoves(PivotPoints)
end

unitDefID=Spring.GetUnitDefID(unitID)
HLegOffset=120
nlwalkAnimation= function (PivotPoints,pieces)
	hideT(pieces.pumps)
	hideT(pieces.tails)
	--reset
	
	
	hang(fireGalate,makeVector(0,1,0),0.8)
	WaitForTurn(pieces["Leg3"],2)
	WaitForTurn(pieces["Leg2"],2)
	WaitForTurn(pieces["Leg1"],2)
	WaitForTurn(pieces["Leg4"],2)
	Spin(pieces["fireGalate"],z_axis,math.rad(4.2),0.5)
	--Forward
	Turn(pieces["Leg1"],2,math.rad(269),0.8 )	
	Turn(pieces["Leg2"],2,math.rad(269+180),0.8 )	
	Turn(pieces["Leg3"],2,math.rad(0),0.8 )	
	Turn(pieces["Leg4"],2,math.rad(0),0.8 )	
	
	--Backward
	StartThread(PlaySoundByUnitDefID,unitDefID,"sounds/jgalatea/jGalateaFootstep.ogg",0.5, 1000, 1,0)
	--UpAndDown
	Move(PivotPoints[1],2,0,3.5)
	Turn(pieces["Leg1"],3,math.rad(-11),0.2 )
	Turn(pieces["LegL1"],3,math.rad(44),1 )
	Turn(pieces["Leg2"],3,math.rad(-11),0.2 )
	Turn(pieces["LegL2"],3,math.rad(44),1 )
	Turn(pieces["Leg3"],3,math.rad(11),0.2 )
	Turn(pieces["LegL3"],3,math.rad(-44),1 )
	Turn(pieces["Leg4"],3,math.rad(11),0.2 )
	Turn(pieces["LegL4"],3,math.rad(-44),1 )
	
	WaitForTurn(pieces["Leg1"],2)
	WaitForMove(PivotPoints[1],2)
	Spin(pieces["fireGalate"],z_axis,math.rad(-4.2),0.5)
	--Forward
	
	--Backward
		hang(fireGalate,makeVector(0,1,0), 0.8)
	Turn(pieces["Leg1"],2,math.rad(0),0.8 )	
	Turn(pieces["Leg2"],2,math.rad(0),0.8 )
	Turn(pieces["Leg3"],2,math.rad(269+360),0.8 )	
	Turn(pieces["Leg4"],2,math.rad(269+180),0.8 )	
	--UpAndDown		
	Move(PivotPoints[1],2,-10,3.5)
	Turn(pieces["Leg1"],3,math.rad( 22),0.4 )
	Turn(pieces["LegL1"],3,math.rad( -55),0.6 )
	Turn(pieces["Leg2"],3,math.rad( 22),0.4 )
	Turn(pieces["LegL2"],3,math.rad( -55),0.6 )
	Turn(pieces["Leg3"],3,math.rad(-22),0.4 )
	Turn(pieces["LegL3"],3,math.rad(55),0.6 )
	Turn(pieces["Leg4"],3,math.rad(-22),0.4 )
	Turn(pieces["LegL4"],3,math.rad(55),0.6 )

	WaitForMove(PivotPoints[1],2)
	WaitForTurn(pieces["Leg1"],2)
end


nlstopWalkAnimation= function (PivotPoints,pieces,lfactor) 
factor= lfactor or 1
	hang(fireGalate,makeVector(0,1,0),0.8*factor)
	WaitForTurn(pieces["Leg3"],2*factor)
	WaitForTurn(pieces["Leg2"],2*factor)
	WaitForTurn(pieces["Leg1"],2*factor)
	WaitForTurn(pieces["Leg4"],2*factor)
	Spin(pieces["fireGalate"],z_axis,math.rad(4.2),0.5)
	
	resetT(PivotPoints,0.6)
	--resetT(pieces.legl,0.6)
	--resetT(pieces.leg,0.6)
	Move(PivotPoints[1],2,0,3.5)
	Turn(pieces["Leg1"],3,math.rad(-11),0.2*factor )
	Turn(pieces["LegL1"],3,math.rad(44),1 *factor)
	Turn(pieces["Leg2"],3,math.rad(-11),0.2*factor )
	Turn(pieces["LegL2"],3,math.rad(44),1 *factor)
	Turn(pieces["Leg3"],3,math.rad(11),0.2 *factor)
	Turn(pieces["LegL3"],3,math.rad(-44),1 *factor)
	Turn(pieces["Leg4"],3,math.rad(11),0.2 *factor)
	Turn(pieces["LegL4"],3,math.rad(-44),1 *factor)
	
	WaitForMove(PivotPoints[1],2*factor)
	Spin(pieces["fireGalate"],z_axis,math.rad(-4.2),0.5*factor)
	Move(PivotPoints[1],2,-10,3.5*factor)
	Turn(pieces["Leg1"],3,math.rad( 22),0.4 *factor)
	Turn(pieces["LegL1"],3,math.rad( -50),0.8	*factor )
	Turn(pieces["Leg2"],3,math.rad( 22),0.4 	*factor)
	Turn(pieces["LegL2"],3,math.rad( -50),0.8 	*factor)
	Turn(pieces["Leg3"],3,math.rad(-22),0.4		*factor)
	Turn(pieces["LegL3"],3,math.rad(50),0.8 	*factor)
	Turn(pieces["Leg4"],3,math.rad(-22),0.4 	*factor)
	Turn(pieces["LegL4"],3,math.rad(50),0.8 	*factor)
	WaitForMove(PivotPoints[1],2)
	if math.random(1,7)==3 then
		
		--> Turns a Pieces table according to a function provided
		waveATable(Legs, y_axis,function(x) return x end ,randSign(),0.5)	
		WaitForTurns(Legs)
		waveATable(Legs, y_axis,function(x) return x end ,randSign(),0.5)	
		WaitForTurns(Legs)
		resetT(Legs, 0.5)
		WaitForTurns(Legs)
	else
		val=math.random(-15,15)
		Turn(pieces["Leg1"],2,math.rad(val),0.4*factor)
		val=math.random(-15,15)
		Turn(pieces["LegL1"],2,math.rad(val),0.8*factor)
		val=math.random(-15,15)
		Turn(pieces["Leg3"],2,math.rad(val),0.4*factor)
		val=math.random(-15,15)
		Turn(pieces["LegL3"],2,math.rad(val),0.8*factor)
		val=math.random(-15,15)		
		Turn(pieces["Leg2"],2,math.rad(val),0.4*factor)
		val=math.random(-15,15)		
		Turn(pieces["LegL2"],2,math.rad(val),0.8*factor)
		val=math.random(-15,15)
		Turn(pieces["Leg4"],2,math.rad(val),0.4*factor)
		val=math.random(-15,15)
		Turn(pieces["LegL4"],2,math.rad(val),0.8*factor)
		WaitForTurn(pieces["Leg3"],2)
		WaitForTurn(pieces["Leg2"],2)
		WaitForTurn(pieces["Leg1"],2)
		WaitForTurn(pieces["Leg4"],2)
	end
	
	WaitForMove(PivotPoints[1],2)
end

stundamage=14
stunRange=160
feedingDamage=55
function InWaterFeedingFrenzy()
	
	stunFunc= function (id) 
		Spring.SetUnitHealth(id, {paralyze=700})
		return id
	end
	
	Cache={}	
	while true do
		x,y,z=Spring.GetUnitPosition(unitID)
		
		while y < 0 do
			T=getAllInCircle(x,z, stunRange,unitID)
			T,Cache= removeUnitsOfTypeInT(T, {[UnitDefNames["jgalatea"].id]=true},Cache)
			T= process(T,
			function(element)
				ex,ey,ez=Spring.GetUnitPosition(element)
				if ey <= 0 then return element end
			end
			)
			if T and #T > 0 then
				
				for i=1, #T do 
					theLuckOne=affirmUnitsExisting(T[i])
						if theLuckOne then
						hp=Spring.GetUnitHealth(theLuckOne)
						myHP,maxHP=Spring.GetUnitHealth(unitID)
						if hp then 
							hp=math.max(-10,hp-feedingDamage)
							Spring.SetUnitHealth(theLuckOne,hp, 0, hp*stundamage)
							myHp=math.min(myHP+feedingDamage/2,maxHP)
							Spring.SetUnitHealth(unitID,myHp)
						end
					end
				end
				
				if math.random(1,5)==3 then
					
					Spring.SpawnCEG("jgalateatend",x,-5,z,0,1,0,0)
					StartThread(PlaySoundByUnitDefID,unitDefID,"sounds/jgalatea/jgalateafeeding.ogg",0.5, 4000, 1,0)
				end
			end
			Sleep(500)
			x,y,z=Spring.GetUnitPosition(unitID)
			
		end
		Sleep(1000)
	end
end

tail1=piece("tail1")
tail2=piece("tail2")
tail3=piece("tail3")
tail4=piece("tail4")

function script.Create()
	PieceGroups=	makePiecesTablesByNameGroups(false,true)
	resetT(PieceGroups,0)
	hideT(Tails)
	hideT(Pumps)
	StartThread(ImSailing)
	StartThread(swimSimplySwimming)
	StartThread(InWaterFeedingFrenzy)
	StartThread( AmphibMoveThread
	,unitID
	,PivotPoints
	,pieces
	,200
	,10
	,nlswimAnimation
	,nlstopSwimAnimation
	,nloutOfWaterAnimation
	,nlbackIntoWaterAnimation
	,nlwalkAnimation
	,nlstopWalkAnimation)

end

teamID = Spring.GetUnitTeam(unitID)
function script.Killed(recentDamage,_)
	--stop movement of unit
	x,y,z=Spring.GetUnitPosition(unitID)
	WMove(PivotPoints[1],2,-80,40.5)
	for i=1, 5 do
		Spring.CreateUnit("blueblooddecalfactory",x+math.random(-20,20),y,z+math.random(-20,20),0,teamID)
	end
	Sleep(3000)
	
	return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return fireGalate 
end



function script.QueryWeapon1() 
	return fireGalate
end

SIG_AIM=2
SIG_RESET=4
function script.AimWeapon1( heading ,pitch)	
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	
	--aiming animation: instantly turn the gun towards the enemy
	Turn(fireGalate,y_axis,heading,3)
	Turn(fireGalate,x_axis,-pitch,3)
	WaitForTurn(fireGalate,y_axis)
	Signal(SIG_RESET)
	WaitForTurn(fireGalate,x_axis)
	return LocalBoolInWater ==false
	
end
function resetGal()
	SetSignalMask(SIG_RESET)
	Sleep(3000) 
	
		hang(fireGalate,makeVector(0,1,0),0.8)
	
end

function script.FireWeapon1()	
	StartThread(PlaySoundByUnitDefID,unitDefID,"sounds/jgalatea/jGalateaGlueGun.ogg",0.5, 1000, 1,0)
	
	StartThread(resetGal)
	return true
end



function script.StartMoving()
	
end

function script.StopMoving()
	
	
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end