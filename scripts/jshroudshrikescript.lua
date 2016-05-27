include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 
 include "lib_jw.lua" 

--include "spring_lua_dsl.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 
rootspin1=piece("rootspin1")
rootspin2=piece("rootspin2")

SpinT={}
for i=1,23 do
name="Spin"..i
SpinT[#SpinT+1]=piece(name)
end


GMAN=piece("GMAN")
standing=piece("standing")
face=piece("face"        )
Root={}
for i=1,3 do
name="Root"..i
Root[#Root+1]=piece(name)
end
hideT(SpinT)
hideT(Root)
Hide(GMAN)
Hide(standing)
Hide(face)


local INFLUENCERADIUS=120
local NUMBEROFPIECES=56
piecesTable={}
center = piece("center")
piecesTable[#piecesTable+1]= center
emitcenter = piece("emitcenter")

piecesTable[#piecesTable+1]= emitcenter
emitor = piece("emitor")

piecesTable[#piecesTable+1]= emitor

dice = piece("dice")

piecesTable[#piecesTable+1]= dice

function restartRoots()
resetT(Root)
for i=1,#Root do

Spin(Root[i],y_axis,math.rad(math.random(10,64)),0.5)
Show(Root[i])
end

for i=1,#SpinT do
Turn(SpinT[i],z_axis,math.rad(-90),0,true)
Turn(SpinT[i],z_axis,math.rad(0),0.3)
Show(SpinT[i])
Spin(SpinT[i],y_axis,math.rad(math.random(22)*-12),0.5)

end
end

function dissapearRoots()
for i=1,#Root do
Move(Root[i],y_axis,-30,0)
end
WaitForMove(Root[#Root],y_axis)
hideT(Root)
for i=1,#SpinT do
Turn(SpinT[i],z_axis,math.rad(-90),3)
Turn(SpinT[i],z_axis,math.rad(0),3)
StopSpin(SpinT[i],y_axis,0.5)

end
WaitForTurn(SpinT[#SpinT],z_axis)
hideT(SpinT)
end

x,y,z=0,0,0
UnitPieceTable={}
function updateUnitsPosition()
		for pieceN,id in pairs(UnitPieceTable) do
		x,y,z=Spring.GetUnitPiecePosDir(unitID,pieceN)
		if Spring.ValidUnitID(id) and Spring.GetUnitIsDead(id)==false then
		Spring.MoveCtrl.SetPosition(id,x,y,z)	
		end
	end
end

--CONST
count=0
it=2
LowerLimit=1
up=1
immunity=0


function resConst()
count=0
it=2
LowerLimit=1
up=1
immunity=0
end


function script.Create()
--StartThread(expandingSphere)
--StartThread(treeLoop)
--StartThread(JustOnce)
StartThread(upYourGame)
end

function JustOnce()
teamid=Spring.GetUnitTeam(unitID)
Sleep(100)
if not GG.jShroudShrikeRegister then GG.jShroudShrikeRegister={} end
if not GG.jShroudShrikeRegister[teamid] then GG.jShroudShrikeRegister[teamid]=unitID end

	if Spring.ValidUnitID(GG.jShroudShrikeRegister[teamid]) and Spring.GetUnitIsDead(GG.jShroudShrikeRegister[teamid])==false and GG.jShroudShrikeRegister[teamid]~=unitID then
	Spring.Echo("Only one ShroudShrike allowed per team!")
	Spring.DestroyUnit(unitID,true,true)
	end

end

function BuildTreeOfPain(numberOfPieces,tableOfUnits)
hideT(TreePiece)
hideT(Endpiece)
	pNr=0
dice=math.random(1,3)
Spring.Echo("JW:SHROUDSRIKE:: VAL before rand"..dice)
	if dice == 1 then
	Spring.Echo("JW:SHROUDSRIKE:: VAL after rand was 1"..dice)
				resetT(Endpiece,0)
				resetT(TreePiece,0)
				Sleep(100)
			
				for k,v in pairs(tableOfUnits) do
				pNr=pNr+1
				buildAtree(k)
					if pNr-5 > numberOfPieces then return end
				end
				
				elseif dice==2 then
				resetT(Endpiece,0)
				resetT(TreePiece,0)
				Sleep(100)
			
				for k,v in pairs(tableOfUnits) do
				pNr=pNr+1
				buildBtree(k)
					if pNr-5 > numberOfPieces then return end
				end
				
				else
				resetT(Endpiece,0)
				resetT(TreePiece,0)
				Sleep(100)
			
					for k,v in pairs(tableOfUnits) do
					pNr=pNr+1
					buildCtree(k)
						if pNr-5 > numberOfPieces then return end
					end
				end
	end



function script.Killed(recentDamage,_)

suddenDeathjBuildCorpse(unitID, recentDamage)
return 1
end




boolMoving=false
function script.StartMoving()
boolMoving=true
end

function script.StopMoving()
boolMoving=false		
		
end

Emitor=piece("emitor")
emitcenter=piece("emitcenter")

function sfxThread(radiUs, time)
it=math.random(1,6)
x,y,z=Spring.GetUnitPosition(unitID)

	for i=1, 360, i+it do
	offx,offz=RotationMatrice(1,radiUs,it)
	offx,offz=x+offx,z+offz
	h=Spring.GetGroundHeight(offx,offz)
	spSpawnCEG("flames",offx,h+15,offz,0,1,0,50,0)
	it=math.random(1,6)
	end


end
boolActive=true

function expandingSphere()
	while boolActive==true do
	Sleep(400)
	end
	Signal(SIG_TREE)
Show(standing)
Show(face)
Spring.SetUnitAlwaysVisible(unitID,false)
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitNeutral(unitID,true)


local spGetUnitsInCylinder=Spring.GetUnitsInCylinder
local x,y,z=Spring.GetUnitPosition(unitID)
UnitsOfOld={}
UnitsByTeam={}
Table={}
SpRa=INFLUENCERADIUS

Table=Spring.GetUnitsInCylinder(x,z,SpRa)
al=Spring.GetUnitNearestAlly(unitID)
if al then table.insert(Table,al) end
el=Spring.GetUnitNearestEnemy(unitID)
if el then table.insert(Table,el) end
table.remove(Table,unitID)
local SoleSurvivor=Table[math.floor(1,#Table)]
local SoleSurvivorDefID=Spring.GetUnitDefID(SoleSurvivor)
local SoleSurvivorTeam=Spring.GetUnitTeam(SoleSurvivor)


--pick Sole Survivor
	while true do
	Sleep(100)
	Spring.SetUnitPosition(unitID,x,y,z)
	T=GetUnitsInRange(x,y)
	
	--CheckIfNewUnitsHaveEntered	
	newUnits={}
	for i=1,#T do
		if not UnitsOfOld[T[i]] then 
		hp=Spring.GetUnitHealth(T[i])
		UnitsOfOld[T[i]]=hp
		UnitsByTeam[T[i]]=Spring.GetUnitTeam(T[i])
		newUnits[#newUnits+1]=T[i]
		Spring.SetUnitNoSelect(T[i],true)
		end
	end
	
	for k,v in pairs(UnitsOfOld) do
		if Spring.GetUnitIsDead(k)==true then
		table.remove(UnitsOfOld,k)
		table.remove(UnitsByTeam,k)
		else
		x,y,z=Spring.GetUnitPosition(UnitsByTeam[k])
		Spring.SetUnitMoveGoal(k,x+math.random(-radiUs,y,z))
		end
	end
	StartThread(BuildTreeOfPain,#UnitsOfOld, UnitsOfOld)
	
	if #newUnits > 0 then

	totalhp= forTableUseFunction(newUnits,
			 function (id) return Spring.GetUnitHealth(id) end, 
			 function(ResultTable) res=0 for i=1,#ResultTable do res=res+ResultTable[i] end return res end)
		
	SpRa=SpRa+(totalhp/1000)
	end
	
	damagedUnits={}
	for k,v in pairs(UnitsOfOld) do
	hp,maxhp=Spring.GetUnitHealth(k)
		if hp ~= v then 
		Spring.SetUnitHealth(k, math.ceil(v*0.92)) 
		else 
		Spring.SetUnitHealth(k, v-10) 
		end
		
		if hp < 30 and maRa() then
		dice=math.random(0,2)
		if dice==0 then buildAtree(k) elseif dice==1 then buildBtree(k) else buildCtree(k) end
	
	
		end
	end
	--For all Units In Range who are in battle, do a check for damage, 
		--if they are damaged, increase damage
	--if not battledamaged, do default damage

	--heal and hop the sole survivor
		if Spring.GetUnitIsDead(SoleSurvivor)==false then
		hp,max=Spring.GetUnitHealth(SoleSurvivor)
		Spring.SetUnitHealth(SoleSurvivor,max)
			else
			SoleSurvivor=Spring.CreateUnit(SoleSurvivorDefID,x+math.random(-SpRa,SpRa),y,z+math.random(-SpRa,SpRa),1)
			end
			
	--units who leave the sphere, have a little time delayed accident -or get a return command (and a setUnitNoSelect(true))
	

			for k,v in pairs(UnitsOfOld) do
			px,py,pz=Spring.GetUnitPosition(k)
			px,py,pz=px-x,py-y,pz-z
			dist=math.sqrt(px*px+py*py+pz*pz)
				if dist > SpRa then
				Spring.SetUnitMoveGoal(v,x+math.random(-spRa,spRa),y,z+math.random(-spRa,spRa))
				Spring.SetUnitNoSelect(v,true) 
					else
					Spring.SetUnitNoSelect(v,false) 
					end
			
			end
			
	allTeams=Spring.GetTeamList()
	TeamTable={}
	for i=1,#allTeams do
	TeamTable[allTeams[i]]=0
	end
	
	--filter by team
	for k,v in pairs(UnitsOfOld) do
	TeamTable[v]=TeamTable[v]+1
	end
	--balance out teams in the sphere
	average= sumTableKV(TeamTable)/#allTeams
	
	needyTeams={}
	targetTeam="nada"
	for i=1,#allTeams do
	if 	targetTeam ~="nada"and TeamTable[allTeams[i]] > average then
	--transfer Units
		while TeamTable[allTeams[i]] > average do
		Sleep(100)
		--Spring.TransferUnit(	
		--Transfer those Units 
		TeamTable[allTeams[i]]=TeamTable[allTeams[i]]-1
		end
	else
	targetTeam=allTeams[i]
	end
	
	end
	
	if #UnitsOfOld == 0 then 
	GoIntoStatueMode()
	end
	
	StartThread(sfxThread,SpRa,300)
	Sleep(300)
	
	end
end

function GoIntoStatueMode()
teamid=Spring.GetUnitTeam(unitID)
 GG.jShroudShrikeRegister[teamid]=nil
hideT(SpinT)
hideT(Root)
Hide(GMAN)
Hide(standing)
Hide(face)
	while true do
	id=Spring.GetUnitLastAttacker(unitID)
		if id and Spring.ValidUnitID(id)==true and Spring.GetUnitIsDead(id)==false then
			Spring.DestroyUnit(id,true,true)
		end
	Sleep(50)
	end
end
function GetUnitsInRange(x,z,SpRa)
	T=spGetUnitsInCylinder(x,z,SpRa)
	table.remove(T,unitID)
	if T and #T > 0 then return T end
end


State="NOGAME"

function PokerTimeStateMachine()


Package={}


	while true do 

	State,Package=StateTable[State](State,Package)

	Sleep(250)
	end

end

team=Spring.GetUnitTeam(unitID)
												
StateTable={
--------------------------------------------------------------------------------------------------
			["NOGAME"]= function (state,Package)
			
			Spring.SetUnitAlwaysVisible(unitID,true)
			Package.hp=Spring.GetUnitHealth(unitID)
			exp=Spring.GetUnitExperience(unitID) +0.1
												if boolActive==true then 
												boolHandEnoughM=Spring.UseTeamResource(team, "metal", GAMBLE_SUM*exp )
												boolHandEnoughE=Spring.UseTeamResource(team, "energy", GAMBLE_SUM*exp)
												
													if boolHandEnoughE and boolHandEnoughM and
													boolHandEnoughE ==true and boolHandEnoughM ==true then
									
													--Check wether we have the funds for a little gamble
													boolActive=false
											
													-- use Investment * UnitExp
													removeFromWorld(unnitID)
												
													TableOfUnitDefs=getPokerTypeTable(UnitDefNames)
													ChoosenDefID=TableOfUnitDefs[math.floor(1,table.getn(TableOfUnitDefs))]
													
													--GetAUnitDefID, spawn it and put it in the Package
													Package.id=Spring.CreateUnit(ChoosenDefID,x,y,z,0,team)
													Spring.Echo("Hold")
													return "HOLD", Package 
													end
												else --refund
												if boolHandEnoughM == true then Spring.AddTeamResource(team, "metal", GAMBLE_SUM*exp) end
												if boolHandEnoughE== true then Spring.AddTeamResource(team, "energy", GAMBLE_SUM*exp) end
												end
												return "NOGAME",Package
												end,

--------------------------------------------------------------------------------------------------												
			["HOLD"]= function (state,Package)
			
			
				if boolActive==true then
				boolActive=false
				--Return Investment/2
					Spring.Echo("Fold")
				return "FOLD", Package
				end
			
			--Check wether the packageID Unit still exists and how many HitPoints it lost
			unitStatus=Spring.GetUnitIsDead(Package.id)
			--Get Unit Last Attacker or PackageAttacker
				if not Package.AttackerID then  Package.AttackerID = Spring.GetUnitLastAttacker(unitID) or Spring.GetUnitLastTarget(unitID) end 
			boolHeIsDeadJim =Spring.GetUnitIsDead(Package.AttackerID)
			enemyHP,enemyMaxHP=Spring.GetUnitHealth(Package.AttackerID)
			
				if unitStatus and unitStatus == false then
					--if the enem is no more and im still very much alive - you win
					if boolHeIsDeadJim == true then
					Spring.Echo("WIN")
					return "WIN",Package
					end
					
					
					
					return "HOLD", Package
				else 
				--Reduce by Hitpoints of subunit 
				Package.hp=Package.hp - enemyMaxHP
				Spring.SetUnitHealth(unitID,Package.hp)
				
					Spring.Echo("Lose")
					return "LOSE", Package
				end
					
				
			return "HOLD",Package
			end,

--------------------------------------------------------------------------------------------------
			["FOLD"]= function (state,Package)
			Spring.AddTeamResource(team, "metal",  math.ceil(0.5*GAMBLE_SUM*exp ))
			Spring.AddTeamResource(team, "energy", math.ceil(0.5*GAMBLE_SUM*exp ))	
			return "NOGAME", Package
			end,
			
--------------------------------------------------------------------------------------------------
		
			["WIN"]= function  (state,Package)
			Spring.AddTeamResource(team, "metal",  math.ceil(2*GAMBLE_SUM*exp ))
			Spring.AddTeamResource(team, "energy", math.ceil(2*GAMBLE_SUM*exp ))	
			x,y,z=Spring.GetUnitPosition(Package.id)
			returnToWorld(unnitID,x,y,z)
			ed=Spring.GetUnitNearestEnemy(Package.id)
			Spring.DestroyUnit(Package.id,true, true)
			exp=Spring.GetUnitExperience(unitID) +0.1
			recursiveDoDamage(ed, math.ceil(math.random(2,9),exp*900), function(damage) return damage *0.75 end,function (id, prev) Spring.GetUnitNearestAlly(id) return id end,{})
			
			end,
			
--------------------------------------------------------------------------------------------------

			["LOSE"]= function (state,Package) 
			recursiveDoDamage(Package.id, math.ceil(math.random(2,9),exp*900), function(damage) return damage *0.75 end,function (id, prev) Spring.GetUnitNearestAlly(id) return id end,{})
			Spring.DestroyUnit(Package.id,true,true)
				
			return "NOGAME", Package
			end
			}

function upYourGame()
	StartThread(PokerTimeStateMachine)


end

boolActive=false
function script.Activate()
boolActive=true
return 1
end

function script.Deactivate()
boolActive=false
return 0
end


SFXLENGHT=50

function MoveEmitorToPos(x,y,z)
Move(Emitor,x_axis,x,0)
Move(Emitor,y_axis,y,0)
Move(Emitor,z_axis,z,0,true)
end

function emitFork(x,y,z)
	
	MoveEmitorToPos(x,y,z)
	val=math.floor(math.random(0,3))*90
	Turn(Emitor,y_axis,math.rad(val),0)
	Turn(Emitor,x_axis,math.rad(45),0,true)
		if math.random(0,1)==1 then
		EmitSfx(Emitor,1024)
		else
		EmitSfx(Emitor,1025)
		end
	dice=math.random(0,11)
	
	if dice == 2 then
		posToCont[#posToCont+1]={x=x,y=y+SFXLENGHT,z=z}
	elseif dice==3 then
	posToCont[#posToCont+1]={x=x+SFXLENGHT/2,y=y+SFXLENGHT,z=z}
	elseif dice==4 then
	posToCont[#posToCont+1]={x=x-SFXLENGHT/2,y=y+SFXLENGHT,z=z}
	elseif dice==8 then
	posToCont[#posToCont+1]={x=x,y=y+SFXLENGHT,z=z+SFXLENGHT/2}
	elseif dice==7 then
	posToCont[#posToCont+1]={x=x,y=y+SFXLENGHT,z=z-SFXLENGHT/2}
	elseif dice==5 then
	posToCont[#posToCont+1]={x=x-SFXLENGHT/2,y=y+SFXLENGHT,z=z+SFXLENGHT/2}
	elseif dice==6 then
		posToCont[#posToCont+1]={x=x-SFXLENGHT/2,y=y+SFXLENGHT,z=z-SFXLENGHT/2}
	end

end

posToCont={}

SIG_TREE=4

function treeLoop()
SetSignalMask(SIG_TREE)
--Localisations
--test
boolOnce=true
		while true do
		Sleep(100)
		if boolOnce==true then
		restartRoots()
		boolOnce=false
		end
			Hide(standing)
			Hide(face)
			while boolMoving==false do
			Move(Root[1],x_axis,math.rad(math.random(-26,26),0.3))
			Move(Root[2],x_axis,math.rad(math.random(-26,26),0.3))
			Spin(rootspin1,y_axis,math.rad(math.random(-42,42)),0.3)
			Spin(rootspin2,y_axis,math.rad(math.random(-42,42)),0.3)
				for i=1,#SpinT do
					if maRa()==true then
					Move(SpinT[i],y_axis,math.rad(math.random(0,55)*2),4.5)
					end
				end

			
			
			
			Show(GMAN)
			
			Sleep(5000)		
			end
				if boolOnce==false then
				dissapearRoots()
				boolOnce=true
				end
				Hide(GMAN)
				Show(dice)

		StartVal=128
		HalfWay=32
		local CopyVal=StartVal
		local speed=256
		
				while boolMoving==true do
				Sleep(100)
				Turn(dice,x_axis,math.rad(math.ceil(math.random(-3,3))*90),9)
				Turn(dice,y_axis,math.rad(math.ceil(math.random(-3,3))*90),9)
				Turn(dice,z_axis,math.rad(math.ceil(math.random(-3,3))*90),9)
				Move(dice,y_axis,CopyVal*0.75, speed)
				WaitForMove(dice,y_axis)
				Move(dice,y_axis,CopyVal*0.85, speed*0.75)
				WaitForMove(dice,y_axis)
				Move(dice,y_axis,CopyVal, speed*0.5)
				WaitForMove(dice,y_axis)
				WaitForTurn(dice,x_axis)
				WaitForTurn(dice,y_axis)
				WaitForTurn(dice,z_axis)
				
				Turn(dice,x_axis,math.rad(0),9)
				Turn(dice,y_axis,math.rad(0),9)
				Turn(dice,z_axis,math.rad(0),9)
				Move(dice,y_axis,CopyVal*0.85, speed*0.5)
				WaitForMove(dice,y_axis)
				Move(dice,y_axis,CopyVal*0.75, speed*0.75)
				WaitForMove(dice,y_axis)
				Move(dice,y_axis,0, speed)
				WaitForMove(dice,y_axis)
				CopyVal=math.random(CopyVal/1.25,CopyVal)
						if CopyVal <= HalfWay then CopyVal=StartVal end
				Sleep(100)
				end
			Sleep(1000)
			Spring.Echo("dice")
			Hide(dice)
			Spring.Echo("GMAN")
			Hide(GMAN)
			Spring.Echo("SpinT")
			showT(SpinT)
			Spring.Echo("Root")
			showT(Root)
		end

end
