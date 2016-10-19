include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
rotator=piece"rotor"
DrugPieceActiveList={}
DrugPieceList={}

local RANGE= 50
local AddictList={}--[unitid]={time=relapseTime,team=orgTeam}
for i=1, 9 do
	name="DrugPiece"..i
	DrugPieceList[i]=piece(name)
	DrugPieceActiveList[i]=false
end




function script.Create()
	for i=1, 9 do
		Hide(DrugPieceList[i])
	end
	StartThread(swayInWind)	
	StartThread(DrugLoop)
	StartThread(AddictBehaviour)
	StartThread(DragonGrassGrowth)
	
end
local DrugRange= 200
local 	x,y,z=Spring.GetUnitPosition(unitID)

function swayInWind()
	while true do
		
		Turn(rotator,y_axis,math.rad(math.random(-4.2,4.2)),0.01)
		WaitForTurn(rotator,y_axis)
		resetP(rotator, 0.01)
		Sleep(100)
	end
	
end

function putDrugPieceInPlace(nr,id)
	local footneedle=DrugPieceList[nr]
	Hide(footneedle)
	Move(footneedle,y_axis,-90,0)
	Turn(footneedle,y_axis,math.rad(math.random(-360,360)),0)
	Turn(footneedle,x_axis,math.rad(math.random(-5,5)),0)
	Turn(footneedle,z_axis,math.rad(math.random(-5,5)),0)
	
	Show(footneedle)
	
	--find out if a enemy is nearby -- that is not yet in the books
	
	
	if id and GetUnitDistance(unitID,id) < DrugRange then
		px,py,pz=Spring.GetUnitPosition(id)
		MoveUnitPieceToRelativeWorldPos(unitID,footneedle,px,pz,22)
	else --just find a place in the midst of nowhere
		px,py,pz=x,y,z
		diceOne,diceTwo= 1,1
		if math.random(0,1)==1 then diceOne= -1 end
		if math.random(0,1)==1 then diceTwo= -1 end
		MoveUnitPieceToRelativeWorldPos(unitID,footneedle,px+math.random(35,DrugRange-RANGE)*diceOne,pz+math.random(35,DrugRange-RANGE)*diceTwo,22)
	end
	
	WaitForMove(footneedle,y_axis)
	time=math.ceil(math.random(6000,12000))
	Sleep(time)
	Move(footneedle,y_axis,-90,22.3)
	WaitForMove(footneedle,y_axis)
	Hide(footneedle)
	DrugPieceActiveList[nr]=false
	
end


function ifSomeDayItMayHappenThatAVictimMustBeFound()
	T={}
	T=Spring.GetUnitsInCylinder(x,z,DrugRange)
	table.remove(T,unitID)
	if #T > 1 then
		T=filterOutBuilding(T, UnitDefs)
		if #T> 1 then
			for i=1,#T do
				if not AddictList[T[i]] then return T[i] end	
			end
		end
	end
end

function DragonGrassGrowth() 
	Spring.Echo("JW:DragonGrass1")
	Sleep(2900)
	health, maxHealth, paralyzeDamage, captureProgress, buildProgress=Spring.GetUnitHealth(unitID)
	while not health or health < maxHealth do
		Sleep(200)
		Spring.Echo("JW:DragonGrass2")
		health, maxHealth, paralyzeDamage, captureProgress, buildProgress=Spring.GetUnitHealth(unitID)
	end
	
	while true do
		for i=1,#DrugPieceActiveList do
			if DrugPieceActiveList[i]==false then
				id=ifSomeDayItMayHappenThatAVictimMustBeFound()
				StartThread(putDrugPieceInPlace,i,id)
				DrugPieceActiveList[i]=true
			end
		end
		Sleep(1000)
	end
end

function script.Killed(recentDamage,_)
	for k,v in pairs(AddictList) do
		if k then Spring.DestroyUnit(k,true,false) end
	end
	createCorpseJBuilding(unitID, recentDamage)
	return 1
end

local teamid=Spring.GetUnitTeam(unitID)
local gaiaTeam=Spring.GetGaiaTeamID()

local INJECT=42000
local STUNNED= 32000
local LOYAL= 25000
local SYMTOMFREE= 17000
local RELAPSE= 6000
local PAININGFORTHEPOPPEYFIELDS=0
local x,y,z=Spring.GetUnitPosition(unitID)

function AddictBehaviour()
	Sleep(900)
	while true do
		if #AddictList > 1 then
			for k,v in pairs(AddictList) do
				if k and Spring.GetUnitIsDead(k)==false then
					if v.time > STUNNED then
						Spring.SetUnitNoSelect(k,true)
						stunUnit(k)
					elseif v.time > LOYAL then
						Spring.SetUnitNoSelect(k,false)
						makeUnitLoyalToTeam(k,teamid)
					elseif v.time > SYMTOMFREE then
						makeUnitLoyalToTeam(k,v.team)
					elseif v.time > RELAPSE then
						makeUnitLoyalToTeam(k,teamid)
						Spring.SetUnitNoSelect(k,true)
						Spring.SetUnitMoveGoal(k,x,y,z)
						checkDistanceAndReinject(k,x,y,z)
					elseif v.time < PAININGFORTHEPOPPEYFIELDS then
						hp=Spring.GetUnitHealth(k)
						Spring.SetUnitHealth(k,hp-42)
						checkDistanceAndReinject(k,x,y,z)
					end
					
				elseif k then
					AddictList[k]=nil	
				end
				
			end
			
			for k,v in pairs(AddictList) do
				if k and v then
					AddictList[k].time=v.time-300
				end
			end
		end
		Sleep(300)
	end
end

function checkDistanceAndReinject(k,x,y,z)
	ux,uy,uz=Spring.GetUnitPosition(k)
	if not ux then return end
	ux,uy,uz=ux-x,uy-y,uz-z
	
	if math.sqrt(ux*ux,uy*uy,uz*uz) < RANGE then
		AddictList[k].time= INJECT
		PlayInjectSoundFiles()
	end
end

function makeUnitLoyalToTeam(k,tid)
	Spring.TransferUnit(k,tid,false)
end

function 	stunUnit(k)
	hp=Spring.GetUnitHealth(k)
	
	if hp then Spring.SetUnitHealth(k,{paralyze=hp*8 }) end
end


----aimining & fire weapon
function DrugLoop()
	var=0
	--var=var+1
	Spring.Echo("JW:DragonGrass:DrugLoop"..var)
	Sleep(1000)
	while true do
		--add people not yet on the list 
		for i=1,#DrugPieceList do
			px,py,pz=Spring.GetUnitPiecePosDir(unitID,DrugPieceList[i])
			
			--var=var+1
			--Spring.Echo("JW:DragonGrass:DrugLoop"..var)
			T=Spring.GetUnitsInCylinder(px,pz,RANGE)
			if #T > 0 then
				T=filterOutTeam(T,teamid)
				if #T > 0 then	
					T=filterOutBuilding(T or {}, UnitDefs)
					
					--var=var+1
					--Spring.Echo("JW:DragonGrass:DrugLoop"..var)
					if #T > 0 then
						boolNewOneOnTheHouse=false
						for i=1,#T do
							if T[i]~=unitID and not AddictList[T[i]] then
								
								--var=var+1
								--Spring.Echo("JW:DragonGrass:DrugLoop"..var)
								AddictList[T[i]]={}
								AddictList[T[i]]={time=INJECT,team=Spring.GetUnitTeam(T[i])}
								boolNewOneOnTheHouse=true
							end	
						end
						if boolNewOneOnTheHouse==true then PlayInjectSoundFiles() end
					end
				end
			end
		end
		
		Sleep(200)
	end
end



function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end

unitdef=Spring.GetUnitDefID(unitID)
function PlayInjectSoundFiles()
	filename="sounds/jDragonGrass/drugAddicted.wav"
	if maRa()==true then
		filename="sounds/jDragonGrass/jdragongrass"..(math.random(1,5))..".ogg"
	end
	PlaySoundByUnitType(unitdef, filename,0.9, 5000, 1)
end