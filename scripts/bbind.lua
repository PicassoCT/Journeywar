include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

local rotator = piece "rotator"
local lightning= piece "bbindyaga0"
local crane = piece "bbindcrane"
flare= piece "flare02"

local raft1 =piece"raft1"
local drum =piece"drum"
local cut1 =piece"cut1"
local cut2 =piece"cut2"
local cut5 =piece"cut5"
local cut4 =piece"cut4"
local cut3 =piece"cut3"
local raft2 =piece"raft2"
local Holder1 =piece"Holder1"
local Holder2 =piece"Holder2"
local attaemit=piece "attaemit"
local attachpoint=piece "attachpoint"
local drumemit= piece "drumemit"
local hax1=piece"hax1"
local hax2=piece"hax2"
local hax3=piece"hax3"
local hax4=piece"hax4"
local fireemit1= piece "fireemit1"
local fireemit2= piece "fireemit2"

local ralleypoint = piece "ralleypoint"
local center= piece "center"
local cut1e1=piece"cut1e1"
local cut2e1=piece"cut2e1"
local cut3e1=piece"cut3e1"
local cut4e1=piece"cut4e1"
local cut5e1=piece"cut5e1"
local cut5e2=piece"cut5e2"

local SIG_FIRE =1 
local SIG_CRANE =2
local SIG_SOUND =4
local SIG_POS=8
local SIG_ANIM=16
local SIG_HAUL=32
sparkEmitters={}
for i=1,4,1 do
	sparkEmitters[i]={}
	piecename= "sparkemit"..i
	sparkEmitters[i]=piece(piecename)
end
--Pipes everywhere

TurnMatrice={
	[1]={x=1,y=0,z=0},
	[2]={x=0,y=-1,z=0},
	[3]={x=0,y=0,z=1},
	[4]={x=-1,y=0,z=0},
	[5]={x=0,y=0,z=-1},
	[6]={x=0,y=-1,z=0}
}
TotalOfPipes=107
NumberOfPipes=42
CurrentPipe=2
Pipes={}
for i=1,TotalOfPipes, 1 do
	name="Pipe0"..i
	Pipes[i]=piece(name)
end

NumberOfBlocks=20
StillFreeMatrice={}
function freeMatrice()
	
	for x=1,20, 1 do
		StillFreeMatrice[x]={}
		for z=1,20, 1 do
			StillFreeMatrice[x][z]={}
			for y=1,40, 1 do
				StillFreeMatrice[x][z][y]={}
				StillFreeMatrice[x][z][y]=true
			end
		end
	end
	StillFreeMatrice[1][1][1]=false
end

CoordX=1
CoordY=1
CoordZ=1
boolNoWayOut=false
TurnTotal={x=0,y=0,z=0}


function simpleTransform()
	totalX,totalZ,totalY=0,0,0
	for i=1,40,1 do
		dx,dy,dz=math.ceil(math.random(-3,3)),math.ceil(math.random(-3,3)),math.ceil(math.random(-3,3))
		dx,dy,dz=90*dx,90*dy,90*dz	
		totalX=totalX+dx
		totalY=totalY+dy
		totalZ=totalZ+dz
		Turn(Pipes[i],x_axis,math.rad(dx),0)
		Turn(Pipes[i],y_axis,math.rad(dy),0)
		Turn(Pipes[i],z_axis,math.rad(dz),0)
	end
	-- Turn(Pipes[33],x_axis,math.rad(-1*totalX),0)
	-- Turn(Pipes[33],y_axis,math.rad(-1*totalY),0)
	-- Turn(Pipes[33],z_axis,math.rad(-1*totalZ-90),0)
	
	totalX,totalZ,totalY=0,0,0
	for i=42,84,1 do
		dx,dy,dz=math.ceil(math.random(-3,3)),math.ceil(math.random(-3,3)),math.ceil(math.random(-3,3))
		dx,dy,dz=90*dx,90*dy,90*dz		
		totalX=totalX+dx
		totalY=totalY+dy
		totalZ=totalZ+dz			
		Turn(Pipes[i],x_axis,math.rad(dx),0)
		Turn(Pipes[i],y_axis,math.rad(dy),0)
		Turn(Pipes[i],z_axis,math.rad(dz),0)
	end
	-- Turn(Pipes[73],x_axis,math.rad(-1*totalX),0)
	-- Turn(Pipes[73],y_axis,math.rad(-1*totalY),0)
	-- Turn(Pipes[73],z_axis,math.rad(-1*totalZ-90),0)
	
	Turn(Pipes[85],y_axis,math.rad(90),0)
	totalX,totalZ,totalY=0,0,0
	for i=86,105,1 do
		dx,dy,dz=math.ceil(math.random(-3,3)),math.ceil(math.random(-3,3)),math.ceil(math.random(-3,3))
		dx,dy,dz=90*dx,90*dy,90*dz		
		totalX=totalX+dx
		totalY=totalY+dy
		totalZ=totalZ+dz			
		Turn(Pipes[i],x_axis,math.rad(dx),0)
		Turn(Pipes[i],y_axis,math.rad(dy),0)
		Turn(Pipes[i],z_axis,math.rad(dz),0)
	end
	-- Turn(Pipes[101],x_axis,math.rad(-1*totalX),0)
	-- Turn(Pipes[101],y_axis,math.rad(-1*totalY),0)
	-- Turn(Pipes[101],z_axis,math.rad(-1*totalZ-90),0)
end


CoordX=1
CoordY=1
CoordZ=1
boolNoWayOut=false
TurnTotal={x=0,y=0,z=0}	


function exploreMatrice(start,Max)
	freeMatrice()
	
	Spring.Echo("JW_BBIND:exploreMatrice")
	
	for i=start,Max-10, 1 do
		
		x,y,z=exploreNode()
		Spring.Echo("JW_BBIND:exploredNode"..x.." "..y.." "..z)
		if x ~= nil then 
			break
		else
			--Turn CurrentPipe
			dx=90*x
			dy=90*y
			dz=90*z
			Turn(Pipes[i],x_axis,math.rad(dx),0)
			Turn(Pipes[i],y_axis,math.rad(dy),0)
			Turn(Pipes[i],z_axis,math.rad(dz),0)
			--update Turntotal
			
			TurnTotal.x=TurnTotal.x+dx
			TurnTotal.y=TurnTotal.y+dy
			TurnTotal.z=TurnTotal.z+dz
			
			--inc Pipe
			
			--update Block
			CoordX=CoordX+x
			CoordZ=CoordZ+z
			CoordY=CoordY+y
		end
		
	end
	
	CurrentPipe=Max-9
	tx=-1*TurnTotal.x -90
	ty=-1*TurnTotal.y
	tz=-1*TurnTotal.z
	
	Turn(Pipes[CurrentPipe],x_axis,math.rad(tx),0)
	Turn(Pipes[CurrentPipe],y_axis,math.rad(ty),0)
	Turn(Pipes[CurrentPipe],z_axis,math.rad(tz),0)
end

function exploreNode()
	TableOfOptions={}
	
	for i=1,#TurnMatrice,1 do
		tx=CoordX+TurnMatrice[i].x
		tz=CoordZ+TurnMatrice[i].z
		ty=CoordY+TurnMatrice[i].y
		if StillFreeMatrice[tx] and StillFreeMatrice[tx][tz] and StillFreeMatrice[tx][tz][ty] and StillFreeMatrice[tx][tz][ty]==true then
			table.insert(TableOfOptions,i)
		end
	end
	t=table.getn(TableOfOptions)
	Spring.Echo("JW_BBIND:TableOfOptions:"..t)	
	
	if not t or t == 0 then
		return nil 
	else
		i=math.floor(math.random(1,t))
		tx=CoordX+TurnMatrice[i].x
		tz=CoordZ+TurnMatrice[i].z
		ty=CoordY+TurnMatrice[i].y
		StillFreeMatrice[tx][tz][ty]=false
		
		return 	TurnMatrice[i].x,TurnMatrice[i].y,TurnMatrice[i].z
	end 
end 





function moveDrumEmit()
	while(true) do
		rando=math.random(200,400)
		Sleep(rando)
		dest=math.random(-44,0)
		Move(drumemit,x_axis,dest,0)
	end
	
end

fireemitters={}
for i=1,3,1 do
	fireemitters[i]={}
	piecename= "smallfireemit"..i
	fireemitters[i]=piece(piecename)
end

local i=1


function script.Killed(recentDamage,_)
	Explode (rotator, SFX.SHATTER)
	Explode (crane, SFX.FIRE)
	createCorpseCBuilding(unitID,recentDamage)
	return 1
end

Spring.SetUnitNanoPieces(unitID,{flare})



function idle()
	counter=1
	howHigh=math.random(20,100)
	
	while(true) do
		Sleep(65)
		counter=counter+1
		EmitSfx(fireemit1,1028) --vortflames
		EmitSfx(fireemit1,1026) --glowsmoke
		EmitSfx(fireemit1,1024) --blacksmoke
		EmitSfx(fireemit2,1028) --vortflames
		EmitSfx(fireemit2,1026) --
		EmitSfx(fireemit2,1024) --
		
		
		for i=1,3,1 do
			EmitSfx(fireemit1,1028)
			
			
			
			EmitSfx(fireemitters[i],1028) --glowsmoke
			
		end
		
		if counter==howHigh then
			howHigh=math.random(20,100)
			counter=0
			naptime=70*howHigh
			dice=math.random(0,1)
			if dice==1 then
				StartThread(constFlame,math.ceil(naptime/25))
			end	
			Sleep(naptime)
			if math.random(0,1)==1 then
				EmitSfx(fireemit2,1032)
			end
			for ni=1,15,1 do
				EmitSfx(fireemit2,1025)
				EmitSfx(fireemit2,1025)
				Sleep(50)
			end
			
			dice=math.random(0,1)
			if math.random(0,1)==1 then
				EmitSfx(fireemit2,1032)
			end
			if dice==1 then
				StartThread(constFlame,18)
			end
			Sleep(450)
		end
		
		
	end
end

function emitsparks()
	for xi=1,4,1 do
		EmitSfx(sparkEmitters[xi],1027)
	end
end

function constfire()
	SetSignalMask(SIG_FIRE)
	while (true) do
		Sleep(50)
		EmitSfx(fireemit1,1028) --vortflames
		
		EmitSfx(fireemit2,1028) --vortflames
		
		
	end
end
function citizencrane()
	SetSignalMask(SIG_CRANE)
	while(true) do
		Turn(crane, y_axis,math.rad(75), 0.5)
		WaitForTurn(crane,y_axis)
		Turn(crane, y_axis, math.rad(-75), 0.5)
		WaitForTurn(crane,y_axis)
		Turn(crane, y_axis,math.rad(60), 0.5)
		WaitForTurn(crane,y_axis)
		Sleep(200)	
	end
end

recycleAble= getRecycleableUnitTypeTable()

function unitTest(handedOverId)
	if handedOverId== nil then return false end
	if Spring.ValidUnitID(handedOverId)== false then return false end
	if handedOverId== unitID then return false end
	local passengerDefID=Spring.GetUnitDefID(handedOverId)
	if passengerDefID== nil then return false end
	if passengerDefID== UnitDefNames["tiglil"].id or passengerDefID== UnitDefNames["skinfantry"].id or passengerDefID== UnitDefNames["vort"].id then return true end
	if recycleAble[passengerDefID] then 
		return true 
	end
	return false 
end

Infantry=getInfantryTypeTable()


eatItAlive={
	[ UnitDefNames["gjbigbiowaste"].id]=true,
	[UnitDefNames["gjmedbiogwaste"].id]=true,
	[UnitDefNames["gcivillian"].id]=true,
	[UnitDefNames["gseastar"].id]=true,
	[UnitDefNames["ghohymen"].id]=true	
}

function isBio(ids)
	passengerDefID=Spring.GetUnitDefID(ids)
	if Infantry[passengerDefID] or eatItAlive[passengerDefID] or Rewards[passengerDefID] then
		return true
	end
	
	return false
end

function getScrap()
	x,y,z=Spring.GetUnitPosition(unitID)
	while true do
		Sleep(512)
		fTable=Spring.GetFeaturesInCylinder(x,z,255)
		if fTable and #fTable >0 then
			for i=1,#fTable do
				RemainingMetal,maxMetal,RemainingEnergy,maxEnergy,reclaimLeft= Spring.GetFeatureResources(fTable[i])
				Spring.AddTeamResource(teamID,"metal",maxMetal*0.005)
				Spring.AddTeamResource(teamID,"energy",maxEnergy*0.005)
				Spring.SetFeatureReclaim(fTable[i],reclaimLeft-0.05)
			end
		end
	end
	
end


function haulers()
	SetSignalMask(SIG_HAUL)
	while(true) do
		Move(raft2,z_axis,7,5)
		Move(raft1,z_axis,0,5)
		WaitForMove(raft1,z_axis)
		WaitForMove(raft2,z_axis)
		Move(raft1,z_axis,7,5)
		Move(raft2,z_axis,0,5)
		WaitForMove(raft2,z_axis)
		WaitForMove(raft1,z_axis)
	end
end
function sound()
	SetSignalMask(SIG_SOUND)
	StartThread(factorysound)
	Spring.PlaySoundFile("sounds/cbbind/bbindbuzzsawbeg.wav",0.3)
	Sleep(3000)
	while(true)do
		
		Spring.PlaySoundFile("sounds/cbbind/bbindbuzzsawmid.wav",0.3)	
		Spring.PlaySoundFile("sounds/cbbind/drum.wav",0.3)	
		
		Sleep(2800)
	end
	
	
end

function maschineLoop()
	StartThread(sound)
	StartThread(citizencrane)
	Spin(drum,x_axis,math.rad(-42),0.02)
	Spin(cut1,x_axis,math.rad(242),0.02)
	Spin(cut2,x_axis,math.rad(243),0.02)
	Spin(cut5,x_axis,math.rad(443),0.02)
	Spin(cut4,y_axis,math.rad(443),0.02)
	Spin(cut3,y_axis,math.rad(643),0.02)
	Turn(Holder2,y_axis,math.rad(93),2.7)
	Turn(Holder1,y_axis,math.rad(-95),2.7)
	WaitForTurn(Holder2,y_axis)
	Turn(Holder1,y_axis,math.rad(-90),1.7)
	Turn(Holder2,y_axis,math.rad(90),0.7)
	while(true) do
		Speed=math.ceil(math.random(2.8,4.9))
		x_dice=math.random(-5,5)
		WaitForMove(Holder2,z_axis)
		WaitForMove(Holder1,z_axis)
		Move(Holder2,z_axis,0,Speed)
		Move(Holder1,z_axis,0,Speed*2)
		WaitForMove(Holder2,z_axis)
		WaitForMove(Holder1,z_axis)
		Turn(Holder1,x_axis,math.rad(x_dice),0.2)
		Hold1Move2=math.random(-36,27)
		Speed=math.ceil(math.random(2.8,4.9))
		
		Turn(Holder2,x_axis,math.rad(x_dice),0.2)
		x_dice=math.random(-5,5)
		if Hold1Move2 < -6 then
			Turn(Holder2,x_axis,math.rad(-5),0.2)
		end
		Move(Holder2,z_axis,Hold1Move2,Speed)
		Hold1Move1=math.random(-31,97)
		Move(Holder1,z_axis,Hold1Move1,2*Speed)	
		
	end
	
end

function factorysound()
	SetSignalMask(SIG_SOUND)
	while(true)do
		Spring.PlaySoundFile("sounds/cbbind/factory17_5sec.wav")	
		Sleep(17500)
	end
end

function maschineShutDown()
	Signal(SIG_CRANE)
	
	Spring.PlaySoundFile("sounds/cbbind/bbindbuzzsawend.wav")	
	StopSpin(drum,x_axis,0.02)
	StopSpin(cut1,x_axis,0.02)
	StopSpin(cut2,x_axis,0.02)
	StopSpin(cut5,x_axis,0.02)
	StopSpin(cut4,y_axis,0.02)
	StopSpin(cut3,y_axis,0.02)
	Turn(Holder1,y_axis,math.rad(0),0.5)
	Turn(Holder1,x_axis,math.rad(0),0.5)
	Move(Holder1,y_axis,0,0.5)
	Move(Holder1,x_axis,0,0.5)
	Move(Holder1,z_axis,0,0.5)
	Turn(Holder2,y_axis,math.rad(0),0.5)
	Turn(Holder2,x_axis,math.rad(0),0.5)
	Move(Holder2,y_axis,0,0.5)
	Move(Holder2,x_axis,0,0.5)
	Move(Holder2,z_axis,0,0.5)
	Hide(rotator)
	StopSpin (rotator, y_axis, 5)
	Sleep(3000)
end

function emitStuff(piecename, Time, boolIsBio)
	Time=math.ceil(Time/50)
	if boolIsBio==true then
		for i=1,math.ceil(Time/50), 1 do
			EmitSfx(piecename,1029)
			Sleep(50)
		end
		
	else 
		
		for i=1,math.ceil(Time/50), 1 do
			EmitSfx(piecename,1030) 
			Sleep(50)
		end
	end
end

function bladeCatcher(boolIsBio)
	local distanceToBlades=150
	x,y,z=Spring.GetUnitPiecePosDir(unitID,attachpoint)
	x1,y1,z1=Spring.GetUnitPiecePosDir(unitID,Holder1)
	x2,y2,z2=Spring.GetUnitPiecePosDir(unitID,Holder2)
	dist1=math.sqrt((x-x1)^2+(z-z1)^2)
	dist2=math.sqrt((x-x1)^2+(z-z1)^2)
	--Spring.Echo("Bladecather,here",dist1.." and the other one ",dist2 )
	if dist1 <=distanceToBlades then
		emitStuff(cut4e1,1000, boolIsBio)
	end
	if dist2 <=distanceToBlades then 
		emitStuff(cut3e1,1000, boolIsBio)
		
	end
end

function unitPositioner(id)
	SetSignalMask(SIG_POS)
	Spring.MoveCtrl.Enable(id)
	Spring.MoveCtrl.SetNoBlocking(id, true)
	Spring.SetUnitBlocking(id, false, false,false)
	heading=Spring.GetUnitHeading(unitID)
	heading=heading +math.floor(65533/4)
	Spring.MoveCtrl.SetHeading(id,heading)
	
	
	local spSetPostion=Spring.MoveCtrl.SetPosition
	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	
	while(Spring.ValidUnitID(id)==true)do
		ux,uy,uz,_,_,_=spGetUnitPiecePosDir(unitID,attachpoint)
		spSetPostion(id,ux,uy,uz)
		Sleep(5)
	end
end

local MstoredReward=0
local EstoredReward=0
Rewards = getRewardTable()

function rewarder(id, boolIsBio)
	ereward=0
	mreward=0
	local deafID=Spring.GetUnitDefID(id)
	if deafID~=nil and Rewards[deafID] then
		ereward=Rewards[deafID].ereward
		mreward=Rewards[deafID].mreward
		
		
		MstoredReward=MstoredReward+math.floor(mreward/2)
		EstoredReward=EstoredReward+math.floor(ereward/2)
		teamID=Spring.GetUnitTeam(unitID)
		Spring.AddTeamResource(teamID,"metal", math.ceil(mreward/2))
		Spring.AddTeamResource(teamID,"energy", math.ceil(ereward/2))
	end
	
	
end


local allUnitsEverConcerned={}
local arrived={}
function dissSolveUnit(boolIsBio,id)
	Spring.PlaySoundFile("sounds/cbbind/grind.wav")
	
	Move(attachpoint,y_axis,-72,4.72)
	
	
	while (true==Spring.UnitScript.IsInMove (attachpoint, y_axis)) do
		
		
		
		
		
		if boolIsBio==true then
			EmitSfx(attaemit,1029)
			EmitSfx(hax1,1029)
			EmitSfx(hax2,1029)
			EmitSfx(hax3,1029)
			EmitSfx(hax4,1029)
			Sleep(10)
			EmitSfx(hax1,1029)
			EmitSfx(hax2,1029)
			EmitSfx(hax3,1029)
			EmitSfx(hax4,1029)
		else
			EmitSfx(attaemit,1031)
			EmitSfx(hax1,1031)
			EmitSfx(hax2,1031)
			EmitSfx(hax3,1031)
			EmitSfx(hax4,1031)
			EmitSfx(attaemit,1031)
			Sleep(10)
			EmitSfx(hax1,1031)
			EmitSfx(hax2,1031)
			EmitSfx(hax3,1031)
			EmitSfx(hax4,1031)
			EmitSfx(attaemit,1031)
			EmitSfx(attaemit,1030)
		end
		WaitForMove(attachpoint,y_axis)
		Sleep(50)
	end
	
	
	for i=1, 15, 1 do
		if boolIsBio==true then
			EmitSfx(attaemit,1029)
		else
			EmitSfx(attaemit,1030)
		end
		Sleep(50)		
	end
	
	Signal(SIG_POS)
	rewarder(id,boolIsBio)
	StopSpin(hax1,z_axis,0.1)
	StopSpin(hax4,z_axis,0.1)
	StopSpin(hax2,z_axis,0.1)
	StopSpin(hax3,z_axis,0.1)
	table.remove(arrived,id)
	Spring.DestroyUnit(id,false,true)
end

function buildanimOverhead()
	SetSignalMask(SIG_ANIM)
	Show(rotator)
	Spin (rotator, y_axis, math.rad(45),5)
	
	modulator=1
	while (i==1) do
		modulator=buildanim(modulator)		
	end
	
end
function cleanArrived()
	targ=table.getn(arrived)
	for i=1,targ,1 do
		if arrived[i]== nil or Spring.ValidUnitID(arrived[i])== false then
			table.remove(arrived,i)
			targ=targ-1
			i=i-1
		end
	end
end

function earlyWhileEmit(boolIsBio)
	
	if boolIsBio==true then
		EmitSfx(attaemit,1029)
		EmitSfx(drumemit,1029)
		EmitSfx(cut2e1,1029)
		EmitSfx(cut1e1,1029)
		rand=math.random(10,15)
		Sleep(rand)
		EmitSfx(attaemit,1029)
		EmitSfx(drumemit,1029)
		EmitSfx(cut2e1,1029)
		EmitSfx(cut1e1,1029)
		rand=math.random(10,15)
		Sleep(rand)
	else
		EmitSfx(attaemit,1030)
		EmitSfx(drumemit,1030)
		EmitSfx(cut2e1,1030)
		EmitSfx(cut1e1,1030)
		rand=math.random(10,15)
		Sleep(rand)
		EmitSfx(attaemit,1030)
		EmitSfx(drumemit,1030)
		EmitSfx(cut2e1,1030)
		EmitSfx(cut1e1,1030)
		rand=math.random(10,15)
		Sleep(rand)
	end
	
end

function lateWhileEmit(boolIsBio)
	if boolIsBio==true then
		EmitSfx(attaemit,1029)
		EmitSfx(attaemit,1029)
		
		EmitSfx(cut5e1,1029)
		EmitSfx(cut5e1,1029)
		Sleep(15)
		EmitSfx(attaemit,1029)
		EmitSfx(attaemit,1029)
		EmitSfx(cut5e2,1029)
		EmitSfx(cut5e2,1029)
	else
		EmitSfx(attaemit,1030)
		EmitSfx(cut5e1,1030)
		EmitSfx(cut5e2,1030)
		Sleep(15)
		EmitSfx(attaemit,1030)
		EmitSfx(cut5e1,1030)
		EmitSfx(cut5e2,1030)
	end
end

function theProcess(id)
	Signal(SIG_HAUL)
	Signal(SIG_ANIM)
	StartThread(buildanimOverhead)
	
	Spin(hax1,z_axis,math.rad(690),0.01)
	Spin(hax4,z_axis,math.rad(390),0.05)
	Spin(hax2,z_axis,math.rad(-690),0.01)
	Spin(hax3,z_axis,math.rad(-390),0.05)
	boolChecked=true
	Move(attachpoint,x_axis,0,0)
	Move(attachpoint,z_axis,0,0)
	Move(attachpoint,y_axis,0,0)
	boolIsBio=isBio(id)
	StartThread(unitPositioner,id)
	StartThread(haulers)
	StartThread(maschineLoop)
	Move(attachpoint,z_axis,27,3.5)
	WaitForMove(attachpoint,z_axis)
	Move(attachpoint,z_axis,66,3.5)
	dax=1
	while (true==Spring.UnitScript.IsInMove (attachpoint, z_axis) ) do
		if dax %500 ==0 then boolChecked=Spring.ValidUnitID(id) end
		if dax % 1100 == 0 and boolIsBio==true then
			a=math.random(0,1)
			if a==1 then 
			Spring.PlaySoundFile("sounds/cbbind/bbindflesh.wav") end
			if a== 0 then Spring.PlaySoundFile("sounds/cbbind/bbindflesh2.wav")
			end
		elseif dax % 2500 == 0 and boolIsBio==false then
			Spring.PlaySoundFile("sounds/cbbind/bbindmetal.wav")
		end
		
		earlyWhileEmit(boolIsBio)
		
		dax=dax+50
		Sleep(50)
		
	end
	
	Move(attachpoint,z_axis,118,3.5)
	while (true==Spring.UnitScript.IsInMove (attachpoint, z_axis)) do
		bladeCatcher(boolIsBio)
		--catch the blades
		Sleep(50)
	end
	Move(attachpoint,z_axis,172,3.5)
	
	dax=0
	while (true==Spring.UnitScript.IsInMove (attachpoint, z_axis)) do
		if dax %500 ==0 then boolChecked=Spring.ValidUnitID(id)end
		if dax % 1100 == 0 and boolIsBio==true then
			a=math.random(0,1)
			if a==1 then 
			Spring.PlaySoundFile("sounds/cbbind/bbindflesh.wav") end
			if a== 0 then Spring.PlaySoundFile("sounds/cbbind/bbindflesh2.wav")
			end
		elseif dax % 2500 == 0 and boolIsBio==false then
			Spring.PlaySoundFile("sounds/cbbind/bbindmetal.wav")
		end
		
		lateWhileEmit(boolIsBio)
		
		
		dax=dax+50
		Sleep(50)
		
	end
	Move(attachpoint,z_axis,182,3.5)
	WaitForMove(attachpoint,z_axis)
	dissSolveUnit(boolIsBio,id)
	maschineShutDown()
	Signal(SIG_HAUL)
	Signal(SIG_ANIM)
	Signal(SIG_SOUND)
	Hide(lightning)
end


function unitIsNotPartOfArrived(id)
	if id== nil then return true end
	if arrived[id] then return false
	else
		return true
	end
end

function likeCattle()
	while(true) do
		Sleep(2500)
		--Spring.Echo("Units in Arrived",table.getn(arrived))
		if arrived~=nil and table.getn(arrived)~=0 then
			for i=1,table.getn(arrived),1 do
				if arrived[i]~=nil and unitTest(arrived[i]) == true then
					table.remove(unitTable,arrived[i])
					table.remove(allUnitsEverConcerned,arrived[i])
					theProcess(arrived[i])
				end
			end
			cleanArrived()
		end
	end
end

function distance(x,x2)
	return math.sqrt((x-x2)^2)
end
function moveCadaversToRalleyPoint()
	local tx,ty,tz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ralleypoint)
	
	while(true)do
		if allUnitsEverConcerned~=nil and table.getn(allUnitsEverConcerned)~=0 then
			for i=1,table.getn(allUnitsEverConcerned),1 do
				if 		allUnitsEverConcerned[i]~=nil and unitTest(allUnitsEverConcerned[i])==true and unitIsNotPartOfArrived(allUnitsEverConcerned[i])==true then
					Spring.MoveCtrl.Enable(allUnitsEverConcerned[i])
					x,y,z=Spring.GetUnitPosition(allUnitsEverConcerned[i])
					if (distance(x,tx) > 12 and distance(x,tx) < 250) and distance(z,tz) > 250 then
						--move it in on the 
						newX=math.ceil((7*x+tx)/8)
						newZ=z
						Spring.MoveCtrl.SetPosition(allUnitsEverConcerned[i],newX,y,newZ)
					elseif distance(z,tz) <= 250 and distance(z,tz) > 12 then
						newZ=math.floor((7*z+tz)/8)
						newX=x
						Spring.MoveCtrl.SetPosition(allUnitsEverConcerned[i],newX,y,newZ)
					else				
						newX=math.ceil((7*x+tx)/8)
						newZ=math.floor((7*z+tz)/8)
						Spring.MoveCtrl.SetPosition(allUnitsEverConcerned[i],newX,y,newZ)
						--Spring.Echo(math.sqrt(( x-tx)^2 +(z-tz)^2))
						if math.sqrt(( x-tx)^2 +(z-tz)^2) <=12 then
							arrived[(table.getn(arrived)+1)]={}
							arrived[(table.getn(arrived)+1)]=allUnitsEverConcerned[i]
							allUnitsEverConcerned[i]=nil
						end
					end
				else
					table.remove(allUnitsEverConcerned,i)
					
				end
			end
		end
		Sleep(500)
	end
end

unitTable={}
function bringThemIn()
	local x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,center)
	
	while(true) do
		unitTable={}
		unitTable= Spring.GetUnitsInCylinder(x,z,420)
		table.remove(unitTable,unitID)
		if unitTable~=nil and table.getn(unitTable)~=0 then
			--check Units in Circle- if scrap, StartThreads moving them Towards the loadpoint
			for i=1,table.getn(unitTable),1 do
				--Spring.Echo(unitTable[i])
				if unitTable[i] ~= nil and unitTest(unitTable[i]) ==true and unitIsNotPartOfArrived(unitTable[i])== true then
				else
					table.remove(unitTable,unitTable[i])
					
				end
			end
			--add it to the longterm 
			if unitTable~=nil and table.getn(unitTable)~=0 then
				for i=1,table.getn(unitTable),1 do
					if unitTable[i] ~= nil then
						if allUnitsEverConcerned[(unitTable[i])] or arrived[(unitTable[i])] then
						else
							allUnitsEverConcerned[#allUnitsEverConcerned+1]={}
							allUnitsEverConcerned[#allUnitsEverConcerned]=unitTable[i]
						end
					end
				end
			end
			
			
		end
		--if a unit moves into the load point
		
		--process it
		
		Sleep(3000)
	end
	
end

function constFlame(upperLimit)
	for ro=1,upperLimit, 1 do
		EmitSfx(fireemit2,1025)
		--	EmitSfx(fireemit2,1029)
		Sleep(25)
		EmitSfx(fireemit1,1025)
		--	EmitSfx(fireemit1,1029)
	end
	if math.random(0,1)==1 then
		EmitSfx(fireemit1,1032)
		EmitSfx(fireemit2,1032)
	end
end

function buildanim(modulator)
	
	modulator=modulator+1
	
	if modulator==3 then
		modulator=1
		dice=math.random(1,3)
		upperLimit=math.random(12,35)
		if dice== 1 then
			for ro=1,upperLimit, 1 do
				EmitSfx(fireemit1,1025)
				--	EmitSfx(fireemit1,1029)
				Sleep(25)
			end
		elseif dice==2 then
			for ro=1,upperLimit, 1 do
				EmitSfx(fireemit2,1025)
				--		EmitSfx(fireemit2,1029)
				Sleep(25)
			end
			
		else
			for ro=1,upperLimit, 1 do
				EmitSfx(fireemit2,1025)
				--	EmitSfx(fireemit2,1029)
				Sleep(25)
				EmitSfx(fireemit1,1025)
				--	EmitSfx(fireemit1,1029)
			end
			
		end
	end	
	Spring.UnitScript.Show(lightning)
	Sleep (250)
	Spring.UnitScript.Show(lightning)
	Sleep (150)
	Spring.UnitScript.Hide(lightning)
	
	
	
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Show(lightning)
	emitsparks()
	
	Sleep (150)
	Spring.UnitScript.Hide(lightning)
	Sleep (600)
	Spring.UnitScript.Show(lightning)
	emitsparks()
	Sleep (70)
	Spring.UnitScript.Hide(lightning)
	Sleep (100)
	
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	emitsparks()
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Hide(lightning)
	Sleep (600)
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	emitsparks()
	Spring.UnitScript.Hide(lightning)
	Sleep (100)
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Hide(lightning)
	Sleep (100)
	
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Hide(lightning)
	Sleep (50)
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Hide(lightning)
	Sleep (600)
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	Spring.UnitScript.Hide(lightning)
	Sleep (100)
	Spring.UnitScript.Show(lightning)
	Sleep (50)
	emitsparks()
	Sleep(120)
	Spring.UnitScript.Hide(lightning)
	
	
	sleeptime=math.random(200,400)
	Sleep(sleeptime)
	
	
	return modulator
end

function script.StartBuilding(heading, pitch)	
	StartThread(factorysound)
	StartThread(constfire)
	StartThread(citizencrane)
	Show(rotator)
	i=1
	SetUnitValue(COB.INBUILDSTANCE, 1)
	Spin (rotator, y_axis, math.rad(45),5)
	
	modulator=1
	while (i==1) do
		modulator=buildanim(modulator)		
	end
	
	
end



function script.StopBuilding()
	i=0
	Signal(SIG_FIRE)
	Signal(SIG_SOUND)
	Signal(SIG_CRANE)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	StopSpin (rotator, y_axis, 5)
	Hide(rotator)
	Hide(lightning)
	
end
function script.Create()
	simpleTransform()
	--exploreMatrice(1,42)
	--exploreMatrice(43,84)
	StartThread(moveDrumEmit)
	--<buildanimationscript>
	_,_,_,x,y,z=Spring.GetUnitPosition(unitID,true)
	teamID=Spring.GetUnitTeam(unitID)
	
	if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
	GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
	--</buildanimationscript>
	StartThread(bringThemIn)
	StartThread(moveCadaversToRalleyPoint)
	StartThread(likeCattle)
	--StartThread(getScrap)
	Spring.UnitScript.Hide(flare)
	Spring.UnitScript.Hide(lightning)
	StartThread(idle)
	Hide(rotator)
	
end
--------BUILDING---------