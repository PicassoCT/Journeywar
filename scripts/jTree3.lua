include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 
include "createCorpse.lua"

center= piece "center"
water=piece"water"
branches={}
branchesDeg={}
for i=1,8 do
	name="branch"..i
	branches[i]=piece(name)
end

function sway(swayDeg)
	SetSignalMask(SIG_SWAY)
	while(math.abs(swayDeg) > 0.5) do
		offSet=math.random(-0.0003,0.0003)
		for i=1, 8 do
			Turn(branches[i] ,y_axis,math.rad(branchesDeg[i]+swayDeg),0.0023+offSet)
		end
		
		for i=1, 8 do if math.random(0,1)==1 then WaitForTurn(branches[i] ,y_axis) end end
		
		swayDeg=swayDeg/-2	
		
	end
	
end
maxStrength=5

function script.HitByWeapon(x, z, weaponDefID, damage)
	if GG.LandScapeT then
		cx,cy,cz=Spring.GetUnitPosition(unitID)
		GG.LandScapeT.setAreaEffect(cx,cz,EXITNGUISH_RADIUS,extinguishFire )
	end
end

function Windy()
	Sleep(8000)
	while true do
		dirX, dirY, dirZ, strength, normDirX, normDirY, normDirZ=Spring.GetWind()
		if strength and strength > maxStrength then maxStrength=math.max(strength,20.0) end
		
		if strength/maxStrength > 0.25 then
			Signal(SIG_SWAY)
			StartThread(sway,(strength/20.0)*7)
		end
		Sleep(8000)
	end
	
end

--function: Is called by a Gamagardener, replaces the Object with the activated Version - Obj selfdestructor
distDance=306.52-305.47
function waterWays()
	sinSpeed=0
	while true do
		
		Move(water,y_axis,distDance,(math.abs(math.sin(sinSpeed))+0.01)*5)
		WaitForMove(water,y_axis)
		Move(water,y_axis,0,(math.abs(math.sin(sinSpeed))+0.01)*5)
		WaitForMove(water,y_axis)
		diceDag=math.random(0,5)
		if diceDag==1 then
			Turn(water,y_axis,math.rad(180),0)
		elseif diceDag==2 then
			Turn(water,y_axis,math.rad(242),0)
		elseif diceDag==3 then
			Turn(water,y_axis,math.rad(122),0)
		elseif diceDag==4 then
			Turn(water,y_axis,math.rad(62),0)
		elseif diceDag==5 then
			Turn(water,y_axis,math.rad(302),0)
		end
		sinSpeed=(sinSpeed+0.005)%1
	end
	
end

function actualTrample()
Sleep(500)
Spring.DestroyUnit(unitID,true,false)

end


function TreeTrample()

	StartThread(actualTrample)
end
_,maxhp=Spring.GetUnitHealth(unitID)

function HitByWeapon ( x, z, weaponDefID, damage )
	
	if damage > 30 then
		Signal(SIG_SWAY)
		StartThread(sway,(damage/maxhp)*10)
	end
	return damage
end

function script.Create()
	StartThread(delayedActivation)
	for i=1,8 do
		Hide(branches[i])
	end
	boolBranch1Done=false	
	boolBranch2Done=false	
	for i=1,4 do
		branchesDeg[i],branchesDeg[i+4]=0,0
		if boolBranch1Done==false then
			randDeg=math.random(0,360)
			branchesDeg[i]=randDeg
			Turn(branches[i],y_axis,math.rad(randDeg),0)
			Show(branches[i])
			if math.random(0,2)==1 then boolBranch1Done=true end
		end
		if boolBranch2Done==false then
			randDeg=math.random(0,360)
			branchesDeg[i+4]=randDeg
			Turn(branches[i+4],y_axis,math.rad(randDeg),0)
			Show(branches[i+4])
			if math.random(0,2)==1 then boolBranch2Done=true end
		end
	end
	
	
	Move(center,y_axis,-348,0)
	deg=math.random(-360,360)
	Turn(center,y_axis,math.rad(deg),0)
	
	
	if math.random(0,1)==1 then
		randoVal=math.random(-140,0)
		Move(center,y_axis,randoVal,4.25)
	else
		Move(center,y_axis,0,4.25)
	end
	deg=math.random(-360,360)
	Turn(center,y_axis,math.rad(deg),0.0023)
	StartThread(waterWays)
	StartThread(delayedReward)
	StartThread(Windy)
	StartThread(deactivateAndReturnCosts,unitID,UnitDefs,0.65)
end

function delayedReward()
	WaitForMove(center,y_axis)
	while true and boolJustOnceDeny ==true do
		Spring.AddUnitRessource(unitID,"e",10)
		Sleep(1000)
	end
end

function extinguishFire(landscapeCell)
	landscapeCell.boolBurning=false
	landscapeCell.Food= 0
	return landscapeCell
end

EXITNGUISH_RADIUS= 240
function script.Killed(recentdamage,_)
	if GG.LandScapeT then
		cx,cy,cz=Spring.GetUnitPosition(unitID)
		GG.LandScapeT.setAreaEffect(cx,cz,EXITNGUISH_RADIUS,extinguishFire )
	end
	
	Spring.PlaySoundFile("sounds/jEtree/tree.wav")
	Sleep(2000)
	
	
	Turn(center,z_axis,math.rad(30),0.3)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(60),1)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(65),2.2)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(89),6)
	
	WaitForTurn(center,x_axis)
	
	--emit various particles+sound
	
	Sleep(4500)
	Move(center,y_axis,-32,3.141)--circle
	WaitForMove(center,y_axis)
	createCorpseJBuilding(unitID, recentDamage)
	return 1
end


boolDenialActive=false

function delayedActivation()
	health, maxHealth, paralyzeDamage, captureProgress, bp=Spring.GetUnitHealth(unitID)
	
	while bp and bp < 1 do
		health, maxHealth, paralyzeDamage, captureProgress, bp=Spring.GetUnitHealth(unitID)
		Sleep(200)
	end
	Sleep(1000)
	boolDenialActive=true
end



function script.Activate()
	if boolDenialActive == true then
		setDenial(unitID)
		return 1
	end
end

function script.Deactivate()
	
	
	return 0
end