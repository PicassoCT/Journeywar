include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

--Define the wheel pieces

--Define the pieces of the weapon
amturret=piece "amturret"
SIG_FLARE=1
leftAm={}
for i=1,14,1 do
leftAm[i]={}
temp= "amemit1"..i
leftAm[i]=piece (temp)
end

rightAm={}
for i=0,13,1 do
rightAm[i+1]={}
temp= "amemit2"..i
rightAm[i+1]=piece (temp)
end


teamID=Spring.GetUnitTeam(unitID)

function script.Create()

end


function goTooKillThemAllPicaMon(piecename)

selectRange=32
piecePosX,piecePosY,piecePosZ,_,_,_=Spring.GetUnitPiecePosDir(unitID,  piecename) 

----Spring.Echo("PiecePosX:",piecePosX.."      | PiecePosZ:",piecePosZ)
--get Piece Position
proChoice={}
proChoice=Spring.GetUnitsInCylinder(piecePosX, piecePosZ,selectRange )--no idea why 2.9 but satan told me so
table.remove(proChoice,unitID)

	if proChoice ~= nil then
							
											

											--Kill the Unit
			for i=1,table.getn(proChoice),1 do		
													if proChoice[i] ~= unitID then
													StartThread(unitVannishSFX,proChoice[i],math.ceil(math.random(1200,12500)))
												    end
			end

	end
end
					

maxspeed=math.ceil(UnitDefNames["campro"].speed *65533)
				
boolReadyFire=true
function flareThread()
Spring.PlaySoundFile("sounds/campro/antimatter.wav")
Sleep(1000)
boolReadyFire=false
for i=1,14,1 do
	if i< 3 then
	EmitSfx(leftAm[i],1024)
	EmitSfx(rightAm[i],1024)

		else
		--EmitSfx(leftAm[i-1],1024)
		--EmitSfx(rightAm[i-1],1024)
		EmitSfx(leftAm[i],1024)
		EmitSfx(rightAm[i],1024)
		Sleep(50)
		--EmitSfx(leftAm[i],1024)
		--EmitSfx(rightAm[i],1024)
		end
	Sleep(120)
	end
	goTooKillThemAllPicaMon(leftAm[12])
	goTooKillThemAllPicaMon(rightAm[12])
	
Sleep(1900)
boolReadyFire=true
boolMove=true
assert(maxspeed)
SetUnitValue(COB.MAX_SPEED,maxspeed)
end



----aimining & fire weapon
function script.AimFromWeapon1() 
	return amturret 
end
function script.QueryWeapon1() 
	return amturret 
end

function getPieceMap(id)

dpiecesTable=Spring.GetUnitPieceMap(id)
ux,uy,uz=Spring.GetUnitPosition(id)
tpiecesTable={}
i=1
for k,v in pairs(dpiecesTable) do
x,y,z=Spring.GetUnitPiecePosDir(id,v)
tpiecesTable[i]={}
tpiecesTable[i].pid=v
tpiecesTable[i].x=x or ux
tpiecesTable[i].y=y or uy
tpiecesTable[i].z=z or uz
i=i+1
end
return tpiecesTable
end

killed={}
function unitVannishSFX(id,time)
if killed[id] then return end
killed[id]=true

Spring.SetUnitNoSelect(id,true)
boolIsBuilding=UnitDefs[Spring.GetUnitDefID(id)].id
ux,uy,uz=Spring.GetUnitPosition(id)
if boolIsBuilding and boolIsBuilding==false then
Spring.SetUnitMoveGoal(unitID,ux+math.random(-100,100),uy,uz+math.random(-100,100))
end

local spCEG=Spring.SpawnCEG
	heighest=math.huge*-1
	it=0
	counter=0
	tpiecesTable=getPieceMap(id)
	while time > 0 do
	if counter %6 then
	tpiecesTable=getPieceMap(id)
	end
	while time > 0  do
		
		for i=1,#tpiecesTable do
		if boolIsBuilding and boolIsBuilding==true then
		spawnCegAtPiece(id,tpiecesTable[i].pid,"antimatter",0)
		else
		spawnCegAtPiece(id,tpiecesTable[i].pid,"bgantimatter",0)
		end
			if tpiecesTable[i].y > heighest then
			it=i 
			heighest=tpiecesTable[i].y 
			end
		end
	if it ~= 0 then	table.remove(tpiecesTable,it)	end
	Sleep(150)
	
	time=time-150
	
	end
	counter=counter+1
	Spring.SetUnitAlwaysVisible(id,false)
	end
	 Spring.DestroyUnit(id,true,true) 
	 killed[id]=nil
end

	function script.AimWeapon1( heading, pitch )
	if boolMove==false then return false end
	
	Turn(amturret,y_axis,heading,2.1)
	WaitForTurn(amturret,y_axis)
		if boolReadyFire== true then
		return true
			else
			return false
			end

	end
	
boolMove=true
function script.FireWeapon1()	
boolMove=false
SetUnitValue(COB.MAX_SPEED,1)
StartThread(flareThread)
	return true
end

function script.Killed(recentDamage, maxHealth)
	EmitSfx(amturret,1025)
	Explode(amturret,SFX.FIRE +SFX.FALL)
	x,_,z=Spring.GetUnitPosition(unitID)
	defID=UnitDefNames["campro"].id

	process(filterTableByTable( grabEveryone(unitID,x,z,90,teamID),
								defID,
								function(id, defID)
								def=Spring.GetUnitDefID(id) 
								return def==defID 
								end)
								,
								function(id)Spring.DestroyUnit(id) end )
	 
	Sleep(450)
	EmitSfx(amturret,1025)
end
--Building



function script.StartMoving()
if boolMove==true then
Turn(amturret, y_axis, math.rad(0), 4)											
end	
																							
end

function script.StopMoving()

end

