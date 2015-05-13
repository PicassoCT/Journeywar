include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 
piecesTable={}
Eggship = piece"Eggship"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Eggship
FooSphere1 = piece"FooSphere1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= FooSphere1
FooSphere2 = piece"FooSphere2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= FooSphere2
Main = piece"Main"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Main
W1 = piece"W1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W1
W10 = piece"W10"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W10
W2 = piece"W2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W2
W3 = piece"W3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W3
W4 = piece"W4"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W4
W5 = piece"W5"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W5
W6 = piece"W6"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W6
W7 = piece"W7"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W7
W8 = piece"W8"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W8
W9 = piece"W9"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= W9
Drop = piece"Drop"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Drop

WT={}

	for i=1,10,1 do
	Piecename="W"..i
	WT[i]={}
	WT[i]=piece(Piecename)

	end

	

Drop=piece"Drop"


Water1=WT[1]
Water2=WT[2]
local boolBirth=false

local teamid=Spring.GetUnitTeam(unitID)

function water()
Hide(FooSphere1)
Hide(FooSphere2)
Hide(Eggship)
Hide(Drop)
Show(Water1)
	while true do
		if boolBirth==false then
		Move(Water2,y_axis,0,0.02)
		WaitForMove(Water2,y_axis)
				if math.random(0,1) ==1 then Hide(WT[2]) elseif  math.random(0,1) ==1 then Show(WT[2]) end
			
		Turn(Water1,y_axis,math.rad(math.random(-42,42)),0.02)
		Turn(Water2,y_axis,math.rad(math.random(-42,42)),0.02)
		
			Turn(Water1,x_axis,math.rad(math.random(-2,2)),0.0009)
			Turn(Water2,x_axis,math.rad(math.random(-2,2)),0.0009)
			Turn(Water1,z_axis,math.rad(math.random(-2,2)),0.0009)
			Turn(Water2,z_axis,math.rad(math.random(-2,2)),0.0009)
		
		Move(Water1,y_axis,-0.6077307,0.05)
		Move(Water2,y_axis,0.6077307,0.05)
		WaitForTurn(Water2,y_axis)
		WaitForTurn(Water1,y_axis)
		else
		Sleep(100)
		end
	Sleep(100)
	end
end



function birthAnimation()
Show(WT[2])
Move(Drop,y_axis,0,0)
Show(Drop)
	for i=-1,-39, -3 do
	Move(Drop,y_axis,i,i*-1)
	WaitForMove(Drop,y_axis)
	end
Hide(Drop)

	for i=2,10 do
	Turn(WT[i],y_axis,math.rad(math.random(0,360)),0.42)
	Hide(WT[i-1])
	Show(WT[i])
	Sleep(600)
	end
Sleep(3000)
px,py,pz=Spring.GetUnitPiecePosDir(unitID,WT[9])
id=Spring.CreateUnit("jvaryfoo",px,py+15,pz, 0, teamid)  
if not GG.jAbyss_Moma then GG.jAbyss_Moma={} end
GG.jAbyss_Moma[id]=unitID

Hide(WT[10])
Sleep(40000)
	for i=3,10 do
	Hide(WT[i])
	end

Show(WT[1])
Show(WT[2])
end

function script.Create()

hideT(WT)
StartThread(water)
StartThread(Wait)
end

function hasEnemyComEnder()
eneID=Spring.GetUnitNearestEnemy(unitID)
	if eneID then
	eneteam=Spring.GetUnitTeam(eneID)
	if eneteam and GG.ComEnders and GG.ComEnders[eneteam] then return true end
	end
return false
end


function Wait()
Spring.PlaySoundFile("sounds/jAbyss/Warning.ogg",0.9)
while hasEnemyComEnder()==false do
Sleep(1000)
end
StartThread(OSLOOP)
emitsfx=piece"emitsfx"
Hide(Eggship)
Move(Eggship,y_axis,9000,0,true)
Coord=8000
Speed=1000
Move(Eggship,y_axis,1,450)
Show(Eggship)
	while Coord > 0 do
	Coord=math.max(Coord-1000,0)
	Speed=math.max(Speed/1.25,100)
	Move(Eggship,y_axis,Coord,Speed)
		while true==Spring.UnitScript.IsInMove (Eggship, y_axis) do
		EmitSfx(emitsfx,1024)
		Sleep(100)
		end
	end
Hide(Eggship)
Explode(Eggship,SFX.FALL)
Show(FooSphere1)
Spin(FooSphere1,y_axis,math.rad(math.random(-42,42)),0.1)
Spin(FooSphere1,x_axis,math.rad(math.random(-42,42)),0.1)
Spin(FooSphere2,y_axis,math.rad(math.random(-42,42)),0.1)
Spin(FooSphere2,z_axis,math.rad(math.random(-42,42)),0.1)

	while true do
	boolBirth=true
	birthAnimation()
	
	boolBirth=false
	rest=math.ceil(math.random(12000,120000))
	while rest > 0 do
	Sleep(1000)
	rest=rest-1000
		if math.random(0,1)==1 then 
		Hide(FooSphere1) 
		Show(FooSphere2) 
		else 
		Hide(FooSphere2) 
		Show(FooSphere1) 
		end
	end
	Sleep(rest)


	end

end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

local teamid=Spring.GetUnitTeam(unitID)

-- function TasksToFullFill()
-- bring a consenting friend/enemy
-- proove there hostility (unprovoked attack)
-- prove there relentlessness (do not attack at all for 2 minutes)
-- proove causality violations (Hedgehog)

-- proove there cruelty 
-- corruption of even the inocent
-- proove your own awareness of all (50% chane of  consequences(this will not be a victory, but a tie)
-- return true
-- end


function script.StartMoving()

	
end

function script.StopMoving()
		
		
end

teamid=Spring.GetUnitTeam(unitID)
--collects info on the experience gathered by the varyfoos, and adds them too the pool, leading to more hp and more varyfoo pieces

fooDefID=UnitDefNames["jvaryfoo"].id
POOLBASE=6
function OSLOOP()
if not GG.VaryFooPieceMax and not GG.VaryFooPieceMax[teamid] then GG.VaryFooPieceMax[teamid]=POOLBASE end
xpPool=POOLBASE

local spIsValidUnit=Spring.GetUnitIsDead
local spGetUnitExp=Spring.GetUnitExperience
local spGetUnitByDefs=Spring.GetTeamUnitsByDefs
	while true do

	anyNewFoos=spGetUnitByDefs(teamid,fooDefID)

		if anyNewFoos then
			for i=1,#anyNewFoos do
				if not VaryFoos[anyNewFoos[i]] then
				xp=Spring.GetUnitExperience(anyNewFoos[i])
					if xp then
					VaryFoos[anyNewFoos[i]]=xp
					end
				end
			end
		end
		
	xpPool=POOLBASE
	for id,exp in pairs(VaryFoos) do
		if spIsValidUnit(id) ==true then 
		xp=spGetUnitExp(id)
			if xp-exp > 0 then
			xpPool=xpPool+ (xp-exp)
			VaryFoos[id]=xp
			end
		end
	end

	GG.VaryFooPieceMax[teamid] =xpPool
	Sleep(400)
	end
end