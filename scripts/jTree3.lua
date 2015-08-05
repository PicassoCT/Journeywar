	include "lib_OS.lua"
	include "lib_UnitScript.lua"
	include "lib_Build.lua" 

	center= piece "center"
water=piece"water"


	
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


	function TreeTrample()
	Turn(center,z_axis,math.rad(30),0.3)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(60),1)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(65),2.2)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(89),6)
	Spring.DestroyUnit(unitID,false)
	end

function script.Create()
Move(center,y_axis,-348,0)
deg=math.random(-360,360)
Turn(center,y_axis,math.rad(deg),0)


if math.random(0,1)==1 then
randoVal=math.random(-140,0)
Move(center,y_axis,randoVal,0.25)
	else
	Move(center,y_axis,0,0.25)
	end
deg=math.random(-360,360)
Turn(center,y_axis,math.rad(deg),0.0023)
StartThread(waterWays)
StartThread(delayedReward)
end

function delayedReward()
WaitForMove(center,y_axis)
	while true and boolJustOnceDeny ==true  do
	Spring.AddUnitRessource(unitID,"e",10)
	Sleep(1000)
	end
end


function script.Killed(recentdamage,_)
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
suddenDeathjBuildCorpse(unitID, recentDamage)
return 1
end


boolJustOnceDeny=true
	function script.Activate()
		StartThread(deactivateAndReturnCosts,boolJustOnceDeny,UnitDefs)
		boolJustOnceDeny=false
		return 1
	end

	function script.Deactivate()
		

		return 0
	end

