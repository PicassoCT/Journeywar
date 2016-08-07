include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

center=piece"center"
RotaryClub=piece"RotaryClub"
TotalPieces=14

CrystallLength 	= math.ceil(math.random(10,14))
MaxHeight		=(-500/TotalPieces)*CrystallLength
PieceHeight		=math.abs(MaxHeight/CrystallLength)-5
DirVariance		=math.random(4,33)

CrystallPieces={}
for i=1,TotalPieces do
name="c"..i
CrystallPieces[i]=piece(name)
	if i > CrystallLength then
	Hide(CrystallPieces[i])
	end
end



damageCounter=0
damageRadius=55
damageTreshold=1800
GrowthRate=0.5
PieceAtRisk=1
currentMove=0
GrowPieces={}
DamageDirectionTable={}
SIG_FALL=2
boolCollapsInProgress=false
BasePiece=CrystallPieces[CrystallLength]


function terraformingFunction(x,z)

--Replace with a Terraforming GadgetCall of your choice
	size= math.ceil(math.random(3,5))*4
	jw_AddTerrainDeformation(x,z, size , preparhalfSphereTable, 4, "melt","borderblur")

end


function takeVictimsToAnotherDimension(x,z,DamageRadius)

T=getAllInCircle(x,z,DamageRadius,unitID)

	if T and #T > 0 then
		for i=1,#T,1 do
			Spring.DestroyUnit(T[i],false,true)
		end
	end
end


function fall(TableOfDamageDirections)
Signal(SIG_FALL)
boolCollapsInProgress=true
local TakingTheFall=CrystallPieces[PieceAtRisk]
	for i=1,5 do
	Sleep(300)
	Turn(TakingTheFall,x_axis,math.rad(math.random(-1,1)),0.3)
	Turn(TakingTheFall,z_axis,math.rad(math.random(-1,1)),0.3)
	end

--Find out Directions
deg,maxdamage=0,0
	for i=1,#TableOfDamageDirections do
	if TableOfDamageDirections[i].damage > maxdamage then maxdamage=TableOfDamageDirections[i].damage;deg=math.atan2(TableOfDamageDirections[i].x,TableOfDamageDirections[i].z)end
	end

	if boolFixedDirection==true then
	deg=0
	end
--Turn Piece Towards)
Turn(TakingTheFall,y_axis, deg, 17)
Explode(CrystallPieces[PieceAtRisk], SFX.SHATTER)
Sleep(600)
Explode(CrystallPieces[PieceAtRisk], SFX.SHATTER)
speed=2
	for i=1,math.max(1,PieceAtRisk-1) do 
	Move(CrystallPieces[i],y_axis,math.random(2,10),4)
	end
	
	for i=1,7 do
		if boolFixedDirection==false then
		Turn(TakingTheFall,x_axis, math.rad(90), speed)
		else
		Turn(TakingTheFall,x_axis, math.rad(90 -DirVariance), speed)
		end
	Sleep(3000)
	speed=speed^2 
	end
Move(CrystallPieces[math.max(PieceAtRisk+1,CrystallLength)],y_axis,currentMove-34.54,27)
	
Sleep(600)
--Shatter the Crystall
	
	
DropPieceToGround(unitID,TakingTheFall,9.81, true,true)	

WaitForMove(CrystallPieces[math.max(PieceAtRisk+1,CrystallLength)],y_axis)
--
	for i=1,PieceAtRisk do 
	Explode(CrystallPieces[i],SFX.SHATTER) 
	--EmitSFX(CrystallPieces[i],1024) 
	end
	Move(TakingTheFall,y_axis,MaxHeight,25)

	for i=1,PieceAtRisk do 
	x,y,z=Spring.GetUnitPiecePosDir(unitID,CrystallPieces[i])
	takeVictimsToAnotherDimension(x,z,damageRadius)
	terraformingFunction(x,z)
	end

StartThread(grow)

end

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
damageCounter=damageCounter+damage
DamageDirectionTable[#DamageDirectionTable+1]={x=x,z=z, damage=damage}
	if boolCollapsInProgress==false and  damageCounter > damageTreshold then
	deg=math.atan2(x,z)
	damageCounter=0
	local TableCopy=DamageDirectionTable
	StartThread(fall,TableCopy)
	DamageDirectionTable={}
	end
return 0
end

boolFixedDirection=false
FixedDirection=0

function grow()
boolFixedDirection=maRa()
SetSignalMask(SIG_FALL)

hideT(CrystallPieces)
resetT(CrystallPieces)

boolCollapsInProgress=false

	if boolFixedDirection==true then
	FixedDirection=math.random(0,360)
	Turn(RotaryClub,y_axis,math.rad(FixedDirection),0)
	Turn(RotaryClub,x_axis,math.rad(math.random(-1*DirVariance,DirVariance)),0)
	end
Move(BasePiece,y_axis,MaxHeight,0)
WaitForMove(BasePiece,y_axis)

	showT(CrystallPieces)
	for i=math.min(#CrystallPieces,CrystallLength+1),#CrystallPieces do
	Hide(CrystallPieces[i])
	end
	for i=1,CrystallLength do
	Move(BasePiece,y_axis,MaxHeight + (PieceHeight*i),GrowthRate)
	WaitForMove(BasePiece,y_axis)
	currentMove=MaxHeight + (PieceHeight*i)
	PieceAtRisk=i+1
	damageCounter=0
	DamageDirectionTable={}
	end
end

function script.Create()
resetT(CrystallPieces)

StartThread(grow)
end

function script.Killed(recentDamage,_)
x,y,z=Spring.GetUnitPosition(unitID)
defID=Spring.GetUnitDefID(unitID)
teamid=Spring.GetUnitTeam(unitID)
Spring.CreateUnit(defID,x,y,z,0,teamid)

	jw_AddTerrainDeformation(x,z, 22, preparhalfSphereTable, 2, "melt","borderblur")
return 1
end


function script.Activate()

return 1
end

function script.Deactivate()

return 0
end
