include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

NumberOfSwingers=23
TablesOfPiecesGroups={}
Eater={}
swarm={}
Eater[1] = piece("Eater01") --2
Eater[2] = piece("Eater02") --3
Eater[3] = piece("Eater03") --4
Eater[4] = piece("Eater04") --5
Eater[5] = piece("Eater05") --6
Eater[6] = piece("Eater06") --7
Eater[7] = piece("Eater07") --8
Eater[8] = piece("Eater08") --9
Eater[9] = piece("Eater09") --10
Eater[10] = piece("Eater10") --11
Eater[11] = piece("Eater11") --12
Eater[12] = piece("Eater12") --13
Eater[13] = piece("Eater13") --14
Eater[14] = piece("Eater14") --15
Eater[15] = piece("Eater15") --16
Eater[16] = piece("Eater16") --17
Eater[17] = piece("Eater17") --18
Eater[18] = piece("Eater18") --19
Eater[19] = piece("Eater19") --20
Eater[20] = piece("Eater20") --21
Eater[21] = piece("Eater21") --22
Eater[22] = piece("Eater22") --23
Eater[23] = piece("Eater23") --24
Eater[24] = piece("Eater24") --25
Eater[25] = piece("Eater25") --26
Eater[26] = piece("Eater26") --27
Eater[27] = piece("Eater27") --28
swarm[1] = piece("swarm01") --33
swarm[2] = piece("swarm02") --39
swarm[3] = piece("swarm03") --40
swarm[4] = piece("swarm04") --41
swarm[5] = piece("swarm010") --34
swarm[6] = piece("swarm011") --35
swarm[7] = piece("swarm012") --36
swarm[8] = piece("swarm013") --37
swarm[9] = piece("swarm014") --38
swarm[10]= piece("swarm05") --42 
swarm[11] = piece("swarm06") --43
swarm[12] = piece("swarm07") --44
swarm[13] = piece("swarm08") --45
swarm[14]= piece("swarm09") --46

allReadyInAction={}

allT={}
grouped={}
iiiiIIIIIH= string.byte("I") 
swingers, movers, rotaters ={},{},{}
for i=1,23, 1 do
	allReadyInAction[i]= false
	grouped[i]={}
	name= "swingCenter"..string.char(i+64)
	swingers[i]= piece(name)
	allT[#allT+1]=swingers[i]
	grouped[i].swing=swingers[i]
	name= "movCenter"..string.char(i+64)
	movers[i]= piece(name)
	allT[#allT+1]=movers[i]
	grouped[i].move=movers[i]
	name= "rotCenter"..string.char(i+64)
	rotaters[i]= piece(name)
	allT[#allT+1]=rotaters[i]
	grouped[i].rot=rotaters[i]
	grouped.index=i
	
	if  i > 9 then
		grouped[i].swarm=swarm[i-9]	
	end
end




function turnGroupSwing( group,groupindex)
randSpeed=math.random(-0.5,1) +2.1
randDeg=math.random(1,90)*-1
degSpeed=6
returnSpeed=math.random(1,degSpeed/5)
offSet=math.random(1,20)
moveSpeed=offSet*3

boolSwingDirection = (groupindex % 2 ~= 0 )
if groupindex <10 then boolSwingDirection = not boolSwingDirection end

	if boolSwingDirection == true then	
		Move(group.rot,x_axis,offSet*-1, moveSpeed)
		Turn(group.move,z_axis,math.rad(randDeg),degSpeed)
		WTurn(group.swing,y_axis,math.rad(-179), randSpeed)
		Turn(group.move,z_axis,math.rad(0),returnSpeed)
		Move(group.rot,x_axis,0,moveSpeed)
		WTurn(group.swing,y_axis,math.rad(-355),randSpeed)
	else
		Move(group.rot,x_axis,offSet, moveSpeed)
		Turn(group.move,z_axis,math.rad(randDeg*-1),degSpeed)
		WTurn(group.swing,y_axis,math.rad(179), randSpeed)
		Turn(group.move,z_axis,math.rad(0),returnSpeed)
		Move(group.rot,x_axis,0,moveSpeed)
		WTurn(group.swing,y_axis,math.rad(355),randSpeed)
	end

	WTurn(group.swing,y_axis,math.rad(0), randSpeed)
end

function swarmTurn (group,groupindex)
	if allReadyInAction[groupindex]== true then Spring.Echo("Group"..groupindex .." allready in action"); return end
	allReadyInAction[groupindex]=true
	--actual animation code
	Hide(group.swarm)
	resetP(group.swarm)
	Show(group.swarm)
	
	turnGroupSwing(group, groupindex)
	
	allReadyInAction[groupindex]=false 
end

function showWiggleEater(group, groupindex)

	if not group then return end
	hideT(group)
	index=1
	additive= 1

	while(allReadyInAction[groupindex]==true) do
		Hide(group.eaters[index])
		index= math.min(math.max(1,index+additive),3)
		Show(group.eaters[index])
		Sleep(320)	
		if index == 3 then additive=-1 end
		if index == 1 then additive= 1 end
	end
end

function wigglingEater(group, groupindex)
echoNumber=1



	if not allReadyInAction[groupindex] then allReadyInAction[groupindex]= false end
	if allReadyInAction[groupindex]== true  then Spring.Echo("Group"..groupindex .." allready in action"); return end
	allReadyInAction[groupindex]=true
	
	reseT(group.eaters,0)
	StartThread(showWiggleEater,group, groupindex)
	Spin(group.rot,z_axis,math.rad(42),0.1)

	--actual animation code

	turnGroupSwing(group, groupindex)	


	StopSpin(group.rot,z_axis)
	hideT(group.eaters)
	allReadyInAction[groupindex]=false 
	reseT(group.eaters,0)
end

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	
	process(grouped,
	function (element)
		if math.random(1,3)==3 then
			return element
		else
		end
	end,		
	function(element)
		if element.swarm then			
			StartThread(swarmTurn,element,element.index)
		elseif element.eaters then			
			StartThread(wigglingEater,element,element.index)
		end
	end
	)
	
end

function DissolveOnMove()
	while true do
		while boolMoving ==true do
			for i=1,NumberOfSwingers, 1 do
				if i< 10 then					
					StartThread(wigglingEater,grouped[i],i)
				else
					StartThread(swarmTurn,grouped[i],i)--eater swarm
				end
			end
			boolHideTheBody=false
			if maRa()==true then
			hideT(bodys)
			end
				for i=1,23,1 do
					while ( allReadyInAction[i]==true) do
						Sleep(100)
					end
				end
			if boolHideTheBody==true then
			showT(bodys)
			end
			Sleep(100)	
		end
		--wait for drone to arrive
		while boolMoving== false do
			Sleep(200)
		end
		Sleep(100)
	end
end


Body=piece"Body"
Hinterbein=piece"Hinterbein"
VorderBein=piece"VorderBein"
aimspot=piece"aimspot"
center=piece"center"
bodys={Body, Hinterbein, VorderBein}



function script.Create()
reseT(allT)
for i=1,10, 1 do	
	grouped[i].eaters={}

	
	
	grouped[i].eaters={
					[1]=Eater[3*(i-1)+1],
					[2]=Eater[3*(i-1)+2],
					[3]=Eater[3*(i-1)+3]
					   }

					   
end


hideT(allT)
showT(bodys)
	StartThread(DissolveOnMove)
	StartThread(MoveThread)

end

function script.Killed(recentDamage,_)
	
	suddenDeathV(recentDamage)
	return 1
	
end

function crawlTowardsSwarm()

			hideT(Eater)			
			process(swarm, 
			function (piecenr) 
				if maRa()==true then 
					Show(piecenr);
					return piecenr; 
				else 
					Hide(piecenr) 
				end 
			end,
			function(piecenr)
				x,y,z=Spring.GetUnitPosition(unitID);
				ox,oy=iRand(-20,20),iRand(-20,20); 
				y=Spring.GetGroundHeigth(x+ox,z+oz);
				MovePieceToPos(piecenr,x+ox,y,z+oz);
				TurnPieceTowardsPiece(piecenr, center,0);
			end
			)

end

function MoveThread()
	speedbreath=2
	while true do
		
		if boolMoving == true then
			
			tP(Hinterbein,37,0,0,2.7)
			tP(VorderBein,22,0,0,2.7)
			tP(Body,-8,0,0,0.8,true)
			
			tP(Hinterbein,52,0,0, 3.75)
			tP(VorderBein,-77,0,0,24)
			Move(Body,y_axis,1,1)
			tP(Body,14,0,0,5.1,true)
			
			tP(Hinterbein,-23,0,0,35)--75
			tP(VorderBein,16,0,0, 45)--93			
			tP(Body,10,0,0,1.2,true)
			
			Move(Body,y_axis,0,1)			
			tP(Hinterbein,0,0,0,5)
			tP(VorderBein,0,0,0,3)
			tP(Body,0,0,0,1.75,true)
		else
		Sleep(100)
		if boolMoving == false then
			StartThread(crawlTowardsSwarm)			
			tP(VorderBein,-10,0,0,0.13*speedbreath)
			tP(Hinterbein,10,0,0,0.13*speedbreath)
			WMove(Body,y_axis,-1,1*speedbreath)
			tPrad(VorderBein,0,0,0,0.13*speedbreath)
			tPrad(VorderBein,0,0,0,0.13*speedbreath)
			tPrad(Hinterbein,0,0,0,0.13*speedbreath)
			WMove(Body,y_axis,0,1*speedbreath)
			
			process(swarm, 	
			function(piecenr)
				resetP(piecenr,12,true)
			end
			)
		end
		end
		
	end
	
end



----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimspot 
end



function script.QueryWeapon1() 
	return aimspot
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
	
end


function script.FireWeapon1()	
	
	return true
end



function script.StartMoving()
	boolMoving=true
end

function script.StopMoving()
	boolMoving=false
	
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end

function script.QueryBuildInfo() 
	return center 
end
