include "suddenDeath.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 
sky={}
for i=1,23,1 do
strings="sky"..i
sky[i]={}
sky[i]=piece(strings)
end
Elevator1=piece"Elevator"
Elevator2=piece"Elevator2"
center=piece"center"

function randDeg()
return math.random(-360,360)
end

hitPoints=Spring.GetUnitHealth(unitID)
px,py,pz=Spring.GetUnitPosition(unitID)
step=0
teamID=Spring.GetGaiaTeamID()

	function script.HitByWeapon ( x, z, weaponDefID, damage )
	step=step+damage
	
	if damage > 20 then EmitSfx(emitfire,1029) end
	if step > hitPoints/10 then
	step=0

	StartThread(onFire,29000,19000)

		maRa=math.random(-1,1)
		heapID=Spring.CreateUnit("gCiVillian",px+(150*maRa),py,pz+(150*maRa),1, teamID)
		
	end
			return damage
		
	end

emitfire=piece"emitfire"
firemove=piece"firemove"

function onFire(times,endtimes)
dist=math.random(0,150)
Move(firemove,y_axis,dist,0)
x=math.random(-360,360)
Turn(firemove,y_axis,math.rad(x),0)
			 for i=1,times,1 do
				if i < endtimes then
				EmitSfx(emitfire, 1025)
				EmitSfx(emitfire, 1028)			
				EmitSfx(emitfire, 1026)
				EmitSfx(emitfire, 1027)
				else
				EmitSfx(emitfire, 1027)
				end				
			Sleep(200)
			end

end

function ElevatorScript()
Show(Elevator1)
Show(Elevator2)
speed=math.random(9.14,22)
boolElveator1GotJob=false
boolElveator2GotJob=false
	while true do
	if boolElveator1GotJob== false then
	factor=math.ceil(math.random(0,1)*710)
	factor=factor -(factor%25)
	Move(Elevator1,y_axis,factor,speed)
	boolElveator1GotJob=true
	end


	if boolElveator2GotJob== false then
	factor=math.ceil(math.random(0,1)*620)
	factor=factor -(factor%25)
	Move(Elevator2,y_axis,factor,speed)
	boolElveator2GotJob=true
	end


	rand=math.ceil(math.random(5000,22000))
	Sleep(rand)
		if math.random(0,3)==1 then
		 Move(Elevator1,y_axis,0,speed) 
		 boolElveator2GotJob=true
		 end
			if math.random(0,5)==1 then 
			Move(Elevator2,y_axis,0,speed) 
			boolElveator2GotJob=true
			end
	if  (false==Spring.UnitScript.IsInMove (Elevator2, y_axis)) then boolElveator2GotJob=false end
	if  (false==Spring.UnitScript.IsInMove (Elevator1, y_axis)) then boolElveator1GotJob=false end
	end

end

boolAllreadyStarted=false
function script.Create()

NearestEnemy=Spring.GetUnitNearestEnemy(unitID)
if NearestEnemy then
teamid=Spring.GetUnitTeam(NearestEnemy)
if teamid then
	_,_,_,_,side,_,_,_=Spring.GetTeamInfo(teamid)
	if side and string.lower(side) == "journeyman" and math.random(0,1)==1 then
	px,py,pz=Spring.GetUnitPosition(unitID)
	myTeamID=Spring.GetUnitTeam(unitID)
	GG.UnitsToSpawn:PushCreateUnit("ccivilbuildingjourneyd",px,py,pz, 0, myTeamID)  
	Spring.DestroyUnit(unitID,true,true)
	end
end
end


Hide(Elevator1)
Hide(Elevator2)
	for i=1, #sky,1 do
	Hide(sky[i])
	end
Turn(center,y_axis,math.rad(randDeg()),0)

		if math.random(0,1) == 1 then
		one=math.max(math.floor(math.random(1,23)),1)
			if one==8 then StartThread(ElevatorScript) end
			if one==17 then one=16 end
		Show(sky[one])
		else

		one=math.max(math.floor(math.random(1,23)),1)
		if one==17 then one=17+math.floor(math.random(-3,3))end
			if one==8 then
			StartThread(ElevatorScript) 
			boolAllreadyStarted=true
			end
		Show(sky[one])
		one=math.max(math.floor(math.random(1,23)),1)
		if one==17 then one=16 end
			if one==8 and boolAllreadyStarted==false then
			StartThread(ElevatorScript) 
			boolAllreadyStarted=true
			end
		Show(sky[one])
		end

	if math.random(0,32) == 2 then 
		for i=1, #sky,1 do
		Hide(sky[i])
		end
	Show(sky[17])
	end
	if one== 18 then Turn(center,y_axis,math.rad(90),0)end
	
	
	if math.random(0,1)==1  then
		StartThread(delayedSpawn)
	end
end
buibaicity=piece"buibaicity"

function delayedSpawn()
d=math.random(1500,15000)
Sleep(d)
teamID=Spring.GetUnitTeam(unitID)
coordx,_,coordz=Spring.GetUnitPosition(unitID)
GG.UnitsToSpawn:PushCreateUnit("gdecbuilding",coordx,0,coordz,0,teamID)

end

function script.Killed(recentDamage,_)

xrand=math.random(-2,2)
yrand=math.random(-12,12)
zrand=math.random(-3,3)
Turn(buibaicity,x_axis,math.rad(xrand),0.02)
Turn(buibaicity,y_axis,math.rad(yrand),0.2)
Turn(buibaicity,z_axis,math.rad(zrand),0.02)
Move(buibaicity,y_axis,-180,11)
Timer=0
	while(true==Spring.UnitScript.IsInMove (buibaicity, y_axis)) do
	EmitSfx(center,1024)
	Sleep(120)
	Timer=Timer+1
			if Timer== 20 then
			Move(buibaicity,y_axis,-180,22)
			end
		if Timer== 28 then

		Move(buibaicity,y_axis,-180,44)
		end


	end
	teamID=Spring.GetUnitTeam(unitID)
x,y,z=Spring.GetUnitPosition(unitID)
	if math.random(0,2)==1 then
	for i=1, 3,1 do
	Spring.CreateUnit("jresistancewarrior",x+25,y,z-25,0,teamID)
	end
end
if math.random(0,1)==1 then
GG.UnitsToSpawn:PushCreateUnit("gwood",x,0,z,0,teamID)
end
suddenDeath(unitID,recentDamage)
return 0
end




function script.StartMoving()

end

function script.StopMoving()
		
		
end

