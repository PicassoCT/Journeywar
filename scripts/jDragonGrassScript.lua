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
 AddictList={}--[unitid]={addTime=relapseTime,team=orgTeam}
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
 DrugRange= 200
 	ux,uy,uz=Spring.GetUnitPosition(unitID)

function swayInWind()
	while true do
		
		Turn(rotator,y_axis,math.rad(math.random(-4.2,4.2)),0.01)
		WaitForTurn(rotator,y_axis)
		reset(rotator, 0.01)
		Sleep(100)
	end
	
end

function putDrugPieceInPlace(nr)

	local footneedle=DrugPieceList[nr]
	Hide(footneedle)
	Move(footneedle,y_axis,-90,0)
	degree=360*(nr/#DrugPieceList)+math.sin(Spring.GetGameFrame()/3000)
	

		px,pz=RotationMatrice(0,DrugRange,math.rad(degree)*nr)
		moveUnitPieceToRelativeWorldPos(unitID,footneedle,px,pz,22)

	WaitForMove(footneedle,y_axis)
	addTime=math.ceil(math.random(6000,12000))
	Sleep(addTime)
	Move(footneedle,y_axis,-90,22.3)
	WaitForMove(footneedle,y_axis)
	Hide(footneedle)
	DrugPieceActiveList[nr]=false
	
end


function ifSomeDayItMayHappenThatAVictimMustBeFound()
	T={}
	T=Spring.GetUnitsInCylinder(ux,uz,DrugRange)
	table.remove(T,unitID)
	if #T > 1 then
		T=filterOutBuilding(T, UnitDefs, false)
		if #T> 1 then
			for i=1,#T do
				if not AddictList[T[i]] then return T[i] end	
			end
		end
	end
end

function DragonGrassGrowth() 
	Sleep(2900)
	health, maxHealth, paralyzeDamage, captureProgress, buildProgress=Spring.GetUnitHealth(unitID)
	while not health or health < maxHealth do
		Sleep(200)
		health, maxHealth, paralyzeDamage, captureProgress, buildProgress=Spring.GetUnitHealth(unitID)
	end
	
	while true do
		for i=1,#DrugPieceActiveList do
			if DrugPieceActiveList[i]==false then
				ifSomeDayItMayHappenThatAVictimMustBeFound()
				StartThread(putDrugPieceInPlace,i)
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
local SYMTOMFREE= 18000
local RELAPSE= 6000
local PAININGFORTHEPOPPEYFIELDS=0


function AddictBehaviour()
	Sleep(900)
	while true do

			for k,v in pairs(AddictList) do
				if k and Spring.GetUnitIsDead(k)==false and k~= unitID then
					if v.addTime > STUNNED then
						Spring.SetUnitNoSelect(k,true)
						stunUnit(k)
						makeUnitLoyalToTeam(k,teamid)

					elseif v.addTime > LOYAL then

						ex,ez= ux + math.random(-1200,1200),uz + math.random(-1200,1200)
						Spring.SetUnitMoveGoal(k,ex,uy,ez)
						Spring.SetUnitNoSelect(k,false)	
						
					elseif v.addTime > SYMTOMFREE then
						makeUnitLoyalToTeam(k,v.team)
						
					elseif v.addTime > RELAPSE then
						makeUnitLoyalToTeam(k,teamid)
						Spring.SetUnitNoSelect(k,true)
						Spring.SetUnitMoveGoal(k,ux,uy,uz)
						checkDistanceAndReinject(k,ux,uy,uz)
					elseif v.addTime < PAININGFORTHEPOPPEYFIELDS then
						hp=Spring.GetUnitHealth(k)
						Spring.SetUnitHealth(k,hp-22)
						checkDistanceAndReinject(k,ux,uy,uz)
					end
					AddictList[k].addTime=v.addTime-300	
				elseif k then
					AddictList[k]=nil	
				end
				
			end
	
		Sleep(300)
	end
end

function checkDistanceAndReinject(k,x,y,z)
	distanced = distanceUnitToUnit(k,unitID) 
	if distanced < DrugRange then
		AddictList[k].addTime= INJECT
		PlayInjectSoundFiles()
	end
end

function makeUnitLoyalToTeam(k,tid)
	Spring.TransferUnit(k,tid,false)
end

function 	stunUnit(k)
	hp=Spring.GetUnitHealth(k)
	
	if hp then Spring.SetUnitHealth(k,{paralyze=hp*1.2 }) end
end


----aimining & fire weapon
function DrugLoop()


	Sleep(1000)
	while true do
		--add people not yet on the list 

			px,py,pz=Spring.GetUnitPosition(unitID)
			teamid=Spring.GetUnitTeam(unitID)
			T=	getAllInCircle(px,pz,DrugRange,unitID)	
			process(T,
					function(id)
					 idTeam= Spring.GetUnitTeam(id) 
					 if idTeam==teamid then return end
						if id ~= unitID and not AddictList[id] then
						AddictList[id]={
									addTime=INJECT,
									team=idTeam}
						return id
						end
					end
					)
					--T now contains newl addicted units
			if #T > 0 then	 PlayInjectSoundFiles() end
				 

				
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
	StartThread(PlaySoundByUnitDefID, unitdef, filename,0.9, 5000, 1)
end


px,_,pz=Spring.GetUnitPosition(unitID)
function script.HitByWeapon( x, z, weaponDefID, damage ) 
T= getAllInCircle( px,pz, RANGE,unitID)
	if T then
		process(T,

				function (id)
					if AddictList[id] then
						AddictList[id].addTime=INJECT
					else
						AddictList[id]={
						addTime=INJECT,
						team=Spring.GetUnitTeam(id)}
					end
				end
			
				)
	end

return damage
end
