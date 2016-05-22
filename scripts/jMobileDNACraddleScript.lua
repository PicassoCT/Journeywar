include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

include "lib_Build.lua" 


local piecesTable={}
center = piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
fclvl23DS = piece"fclvl2.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= fclvl23DS
Kreis02 = piece"Kreis02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis02
LegCenter1 = piece"LegCenter1"

legstart=#piecesTable+1
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LegCenter1
UpMain01 = piece"UpMain01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpMain01
UpJoin02 = piece"UpJoin02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin02
LoJoin02 = piece"LoJoin02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin02
UpJoin01 = piece"UpJoin01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin01
LoJoin01 = piece"LoJoin01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin01
LegCenter2 = piece"LegCenter2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LegCenter2
UpMain02 = piece"UpMain02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpMain02
UpJoin03 = piece"UpJoin03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin03
LoJoin03 = piece"LoJoin03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin03
UpJoin04 = piece"UpJoin04"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin04
LoJoin04 = piece"LoJoin04"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin04
LegCenter3 = piece"LegCenter3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LegCenter3
UpMain03 = piece"UpMain03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpMain03
UpJoin05 = piece"UpJoin05"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin05
LoJoin05 = piece"LoJoin05"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin05
UpJoin06 = piece"UpJoin06"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin06
LoJoin06 = piece"LoJoin06"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin06
LegCenter4 = piece"LegCenter4"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LegCenter4
UpMain04 = piece"UpMain04"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpMain04
UpJoin07 = piece"UpJoin07"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin07
LoJoin07 = piece"LoJoin07"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin07
UpJoin08 = piece"UpJoin08"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin08
LoJoin08 = piece"LoJoin08"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin08
LegCenter5 = piece"LegCenter5"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LegCenter5
UpMain05 = piece"UpMain05"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpMain05
UpJoin09 = piece"UpJoin09"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin09
LoJoin09 = piece"LoJoin09"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin09
UpJoin010 = piece"UpJoin010"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin010
LoJoin010 = piece"LoJoin010"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin010
LegCenter6 = piece"LegCenter6"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LegCenter6
UpMain06 = piece"UpMain06"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpMain06
UpJoin011 = piece"UpJoin011"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin011
LoJoin011 = piece"LoJoin011"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin011
UpJoin012 = piece"UpJoin012"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= UpJoin012
LoJoin012 = piece"LoJoin012"
legend=#piecesTable+1
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= LoJoin012
geneCircle = piece"geneCircle"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= geneCircle

piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= gene16
crystal = piece"crystal"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= crystal
Kreis08 = piece"Kreis08"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis08
Kreis09 = piece"Kreis09"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis09
Kreis10 = piece"Kreis10"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis10

SIG_MOVE=2
SIG_RESET=4

geneTable={}
for i=1,16 do
	name="gene"..i
	geneTable[#geneTable+1] =piece(name)
end

birthplace=piece"birthplace"
boolreVert=false
function resetedByBuilding()
	SetSignalMask(SIG_RESET)
	----Spring.Echo("reseter Triggered")
	Sleep(3000)
	boolreVert=true
end


function UpdateUnitPosition(ParentID, UnitID, attach)
	local px, py, pz, _, _, _ = Spring.GetUnitPiecePosDir(ParentID, attach)
	local rx, ry, rz = Spring.GetUnitPieceRotation(ParentID, attach)
	Spring.MoveCtrl.SetPhysics(UnitID, px, py, pz+4, 0, 0, 0, rx, ry, rz)
end

function GetUnitPieceRotation(unitID, piece)
	local rx, ry, rz = Spring.UnitScript.CallAsUnit(unitID, spGetPieceRotation, piece)
	local Heading = Spring.GetUnitHeading(unitID) --COB format
	local dy = rad(Heading / 182)
	return rx, dy + ry, rz
end


function moveFactory ()
	local spGetUnitPosition=Spring.GetUnitPosition
	local spMovCtrlSetPos=Spring.MoveCtrl.SetPosition
	local spValidUnitID=Spring.ValidUnitID
	local LGetUnitPieceRotation=GetUnitPieceRotation
	local LUpdateUnitPosition=UpdateUnitPosition
	
	while boolMovedOnce==false do
		Sleep(5)
	end
	
	
	while (true) do
		if (not spValidUnitID (factoryID)) then newFactory () end
		local x,y,z = spGetUnitPosition (unitID)	 
		spMovCtrlSetPos(factoryID,x,y+10,z+2)
		Sleep (5)
	end
end

factoryID=nil
----aimining & fire weapon
function newFactory ()
	if GG.JFactorys == nil then GG.JFactorys={} end
	local x,y,z = Spring.GetUnitPosition(unitID)
	teamID = Spring.GetUnitTeam (unitID)
	factoryID = Spring.CreateUnit ("jtransportedfactory2", x,y+40,z+20, 0, teamID) 
	GG.JFactorys[factoryID]={}
	GG.JFactorys[factoryID][1]= unitID 
	GG.JFactorys[factoryID][2]= false
	Spring.SetUnitNoSelect(unitID,true)
	Spring.MoveCtrl.Enable(factoryID,true) 
	Spring.SetUnitNeutral(factoryID,true)
	Spring.SetUnitBlocking (factoryID,false,false)
	
end

legTable={}
for i=1, 6, 1 do
	legTable[i]={}
	piecename="UpMain0"..i
	legTable[i]=piece(piecename)
	
end

upJoinTable={}
for i=1,12,1 do
	upJoinTable[i]={}
	piecename="UpJoin0"..i
	upJoinTable[i]=piece(piecename)
	
end

waterEmit1=piece"waterEmit1"
waterEmit2=piece"waterEmit2"

comonValue=0
comonSpeed=0.04


function waitingGame()
	while (GG.JFactorys == nil or GG.JFactorys[unitID] == nil or GG.JFactorys[unitID][2] == nil) do
		Sleep(400)
	end
	
	while(true) do
		
		while GG.JFactorys[unitID][2]==true do
			buildAnimation()
			Sleep(200)
		end
		retractBuildAnimation()
		
		
		
		
		
		Sleep(1000)
	end
end

function buildAnimation()
	Move(geneCircle,y_axis,0,3)
	Spin(geneCircle,y_axis,math.rad(42),0.01)
	for i=1,#geneTable,1 do
		Show(geneTable[i])
	end
end

function retractBuildAnimation()
	Move(geneCircle,y_axis,-41,10)
	WaitForMove(geneCircle,y_axis)
	for i=1,#geneTable,1 do
		Hide(geneTable[i])
	end
	
end

function waterGames()
	for i=1,#geneTable do
		Hide(geneTable[i])
	end
	
	while true do
		EmitSfx(waterEmit1,1027)
		EmitSfx(waterEmit2,1027)
		
		veryRandOm=math.ceil(math.random(75,250))
		Sleep(veryRandOm)
	end
end


function script.Activate ( )
	
	
	
	boolreVert=false
	
	
	return 1
end


function script.Deactivate ( )
	
	boolreVert=true
	
	
	
	
	return 0
end





function liftFeet(nr)
	signed=1
	if nr== 3 or nr ==6 or nr==1 then
		signed=-1
	end
	Turn(legTable[nr],z_axis,math.rad(19*signed),1.7)
	Turn(legTable[nr],z_axis,math.rad(9*signed),1.7)
	Turn(upJoinTable[nr*2],x_axis,math.rad(39),6)
	Turn(upJoinTable[nr*2-1],x_axis,math.rad(39),6)
end

function TurnF(nr,deg,boolWait)
	Turn(legTable[nr],y_axis,math.rad(deg),2)
	Turn(upJoinTable[nr*2],y_axis,math.rad(-deg*2),4)
	Turn(upJoinTable[nr*2-1],y_axis,math.rad(-deg*2),4)
	if boolWait== nil or boolWait==true then
		WaitForTurn(legTable[nr],y_axis)
	end
	
end



function lowerFeet(nr,boolWait)
	Turn(legTable[nr],z_axis,math.rad(0),1.7)
	Turn(legTable[nr],z_axis,math.rad(0),1.7)
	Turn(upJoinTable[nr*2],x_axis,math.rad(0),4)
	Turn(upJoinTable[nr*2-1],x_axis,math.rad(0),4)
	
	Turn(upJoinTable[nr*2],y_axis,math.rad(0),4)
	Turn(upJoinTable[nr*2-1],y_axis,math.rad(0),4)
	
	if boolWait== nil or boolWait==true then
		WaitForTurn(legTable[nr],x_axis)
		WaitForTurn(legTable[nr],x_axis)
	end
	
	EmitSfx(waterEmit1,1027)
	EmitSfx(waterEmit2,1027)	
end



function moveIt()
	SetSignalMask(SIG_MOVE)
	comonSpeed=0.2
	local LTurnF= TurnF
	local LlowerFeet=lowerFeet
	local LliftFeet=liftFeet
	
	while(true) do		
		LlowerFeet(1,false)
		
		LliftFeet(3)
		LliftFeet(5)
		LlowerFeet(2,true)
		Turn(center,y_axis,math.rad(2),0.1)
		
		comonValue=comonValue-5
		
		LTurnF(3,40,false)
		LTurnF(5,-30,true)
		LlowerFeet(3,false)
		LlowerFeet(5,false)
		LTurnF(1,0,false)
		LTurnF(2,0,false)
		LliftFeet(4)
		LliftFeet(6)
		WaitForTurn(center,y_axis)
		Turn(center,y_axis,math.rad(-2),0.1)
		
		comonValue=comonValue+5
		comonSpeed=0.2
		LTurnF(4,-56,false)
		LTurnF(6,57,true)
		
		LlowerFeet(4,false)
		LlowerFeet(6,false)
		LTurnF(3,0,false)
		LTurnF(5,0,false)
		LliftFeet(1)
		LliftFeet(2)
		LTurnF(1,56,false)
		LTurnF(2,-50,true)
		LTurnF(4,0,false)
		LTurnF(6,0,false)
		WaitForTurn(center,y_axis)		
	end
end

boolMovedOnce=false
function script.StartMoving()
	boolMovedOnce=true
	Signal(SIG_MOVE)
	StartThread(moveIt)								
	
end

function legs_down()
	for i=1,table.getn(legTable),1 do		
		Turn(legTable[i],x_axis,math.rad(0),3.141)
		Turn(legTable[i],y_axis,math.rad(0),3.141)
		Turn(legTable[i],z_axis,math.rad(0),3.141)
		Turn(upJoinTable[i*2],x_axis,math.rad(0),4)
		Turn(upJoinTable[i*2-1],x_axis,math.rad(0),4)		
	end
	
end

function script.StopMoving()
	Turn(center,y_axis,math.rad(0),0.2)
	Signal(SIG_MOVE)
	legs_down()
end

function script.Killed(recentDamage, maxHealth)
	
	Spring.DestroyUnit(factoryID,true,false)
	GG.JFactorys[factoryID]=nil
	suddenDeathjBuildCorpse(unitID,recentDamage)
	return 0
	----Spring.Echo ("He is dead, Jim!")
end
--Buildi

function script.Create()
	StartThread(moveFactory)
	Spring.SetUnitNoSelect(unitID,true)
	x,y,z=Spring.GetUnitPosition(unitID)
	Spring.SetUnitMoveGoal(unitID,x-20,y,z)
	
	Spin(crystal,y_axis,math.rad(42),6)
	Spin(geneCircle,y_axis,math.rad(-42),6)
	x=0
	
	Turn(LegCenter1,y_axis,math.rad(0),0)
	Turn(LegCenter2,y_axis,math.rad(60),0)
	Turn(LegCenter3,y_axis,math.rad(120),0)
	Turn(LegCenter4,y_axis,math.rad(180),0)
	Turn(LegCenter5,y_axis,math.rad(240),0)
	Turn(LegCenter6,y_axis,math.rad(300),0)
	
	StartThread(waitingGame)
	StartThread(waterGames)
end