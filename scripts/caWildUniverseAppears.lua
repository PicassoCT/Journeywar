include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 


boolWaitForGLGo=false --is the trigger for the SuperSizeGadget once it brought the unitUpToScale
boolGotoK=false
--pieces
RotTable={}
Rot11 = piece"1Rot1"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot11
Rot12 = piece"1Rot2"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot12
Rot13 = piece"1Rot3"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot13

Rot51 = piece"5Rot1"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot51
Rot52 = piece"5Rot2"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot52
Rot53 = piece"5Rot3"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot53
Rot54 = piece"5Rot4"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot54
Rot21 = piece"2Rot1"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot21
Rot32 = piece"3Rot2"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot32
Rot33 = piece"3Rot3"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot33
Rot34 = piece"3Rot4"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot34
Rot43 = piece"4Rot3"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot43
Rot42 = piece"4Rot2"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot42
Rot44 = piece"4Rot4"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot44
Rot14 = piece"1Rot4"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot14
Rot22 = piece"2Rot2"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot22
Rot23 = piece"2Rot3"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot23
Rot24 = piece"2Rot4"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot24
Rot31 = piece"3Rot1"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot31
Rot41 = piece"4Rot1"
RotTable[#RotTable+1]={}
RotTable[#RotTable]= Rot41
-------------------------------


SunTable={}
for i=1,5, 1 do
	name="Sun0"..i
	SunTable[i]=piece(name)
end

RedSunTable={}
for i=1,5, 1 do
	name="RedSun0"..i
	RedSunTable[i]=piece(name)
end

PlanetTable={}
for i=1,21, 1 do
	name="Planet0"..i
	PlanetTable[i]=piece(name)
end

piecesTable={}
center = piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
bigbang3DS = piece"bigbang.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= bigbang3DS
Sun01 = piece"Sun01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Sun01
Planet013 = piece"Planet013"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet013

Planet014 = piece"Planet014"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet014

Planet04 = piece"Planet04"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet04
Planet09 = piece"Planet09"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet09
RedSun01 = piece"RedSun01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= RedSun01
Sun02 = piece"Sun02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Sun02

Planet01 = piece"Planet01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet01



Planet011 = piece"Planet011"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet011

Planet015 = piece"Planet015"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet015

Planet016 = piece"Planet016"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet016
RedSun02 = piece"RedSun02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= RedSun02
Sun03 = piece"Sun03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Sun03

Planet010 = piece"Planet010"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet010

Planet05 = piece"Planet05"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet05


Planet07 = piece"Planet07"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet07
Planet021 = piece"Planet01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet021
RedSun03 = piece"RedSun03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= RedSun03
Sun04 = piece"Sun04"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Sun04

Planet019 = piece"Planet019"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet019

flipSphere = piece"flipSphere"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= flipSphere

Planet020 = piece"Planet020"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet020

Planet02 = piece"Planet02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet02

Planet017 = piece"Planet017"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet017
RedSun04 = piece"RedSun04"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= RedSun04
Sun05 = piece"Sun05"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Sun05

Planet018 = piece"Planet018"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet018

Planet012 = piece"Planet012"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet012
Planet06 = piece"Planet06"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet06


Planet03 = piece"Planet03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet03

Planet08 = piece"Planet08"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Planet08
RedSun05 = piece"RedSun05"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= RedSun05
fullSphere = piece"fullSphere"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= fullSphere
halfSphere = piece"halfSphere"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= halfSphere
EmitRotator = piece"EmitRotator"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= EmitRotator
Emitor = piece"Emitor"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Emitor

vicTims={}
circleRange=110

local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
local spSpawnCEG=Spring.SpawnCEG

cx,cy,cz=Spring.GetUnitBasePosition(unitID)

GrowthStartTime=Spring.GetGameFrame()
EndTimes=12000

function emitCegAtPiece(cegname, piece)
	CurrentFrame=GrowthStartTime-(Spring.GetGameFrame())
	Time=math.ceil((CurrentFrame/30)*1000)
	Factor=0.043633194444444444444444444444444*Time
	px,py,pz=spGetUnitPiecePosDir(unitID,piece)
	vx,vy,vz=Factor*(px-cx),Factor*(py-cy),Factor*(pz-cz)
	spSpawnCEG(cegname,vx+cx,vy+cy,vz+cz,0,1,0,50,0)
end

function planetarium(timeInS)
	Hide(Emitor)
	
	for i=1,5, 1 do
		val=math.random(-21,21)
		if math.random(0,1)==1 then Spin(SunTable[i],y_axis,math.rad(val),0) else Spin(SunTable[i],y_axis,math.rad(val*-1),0) end
		if math.random(0,1)==1 then Spin(SunTable[i],x_axis,math.rad(val/10),0) else Spin(SunTable[i],z_axis,math.rad(val*-1/10),0) end
	end
	
	
	for i=1,5, 1 do
		Hide(RedSunTable[i])
		val=math.random(-21,21)
		if math.random(0,1)==1 then Spin(RedSunTable[i],y_axis,math.rad(val),0) else Spin(RedSunTable[i],y_axis,math.rad(val*-1),0) end
		if math.random(0,1)==1 then Spin(RedSunTable[i],x_axis,math.rad(val/10),0) else Spin(RedSunTable[i],z_axis,math.rad(val*-1/10),0) end
	end
	
	for i=1,21, 1 do
		val=math.random(-21,21)
		if math.random(0,1)==1 then Spin(PlanetTable[i],y_axis,math.rad(val),0) else Spin(PlanetTable[i],y_axis,math.rad(val*-1),0) end
	end
	
	for i=1,#RotTable, 1 do
		val=math.random(-21,21)
		if math.random(0,1)==1 then Spin(RotTable[i],y_axis,math.rad(val),0) else Spin(RotTable[i],y_axis,math.rad(val*-1),0) end
		if math.random(0,4)==2 then Spin(RotTable[i],x_axis,math.rad(val/10),0) end
	end
	
	for i=1,5, 1 do
		val=math.random(-21,21)
		if math.random(0,1)==1 then Spin(SunTable[i],y_axis,math.rad(val),0) else Spin(SunTable[i],y_axis,math.rad(val*-1),0) end
		if math.random(0,1)==1 then Spin(SunTable[i],x_axis,math.rad(val/10),0) else Spin(SunTable[i],z_axis,math.rad(val*-1/10),0) end
	end
	
	for i=1,5, 1 do
		valx=betweenVals(12,17)
		valz=betweenVals(12,17)
		valy=math.random(15,17)
		
		Move(SunTable[i],y_axis,-10,0)
		
		biggest=math.max(math.max(math.abs(valx),math.abs(valy)),math.abs(valz))
		speed=biggest/timeInS
		Move(SunTable[i],x_axis,valx,speed,true)
		Move(SunTable[i],z_axis,valz,speed,true)
		Move(SunTable[i],y_axis,valy,speed,true)
		
	end
	
	for i=1,5, 1 do
		WaitForMove(SunTable[i],x_axis)
		WaitForMove(SunTable[i],y_axis)
		WaitForMove(SunTable[i],z_axis)
	end
	
	for i=1,5, 1 do
		Move(SunTable[i],x_axis,0,0.0001)
		Move(SunTable[i],z_axis,0,0.0001)
		Move(SunTable[i],y_axis,0,0.0001)
	end
	
	
end

function betweenVals(Smaller,Bigger)
	if math.random(0,1)==1 then return math.random(Smaller,Bigger) else return math.random(math.min(Smaller*-1,Bigger*-1),Bigger*-1) end
end

killThemAllTable={}
killThemAllCounter=1

function catchThem()
	Sleep(2000)
	_,limit,_=Spring.GetUnitPiecePosDir(unitID,Emitor)
	x,y,z=Spring.GetUnitPosition(unitID)
	killThemAllTable=Spring.GetUnitsInCylinder(x,z,125)
	if killThemAllTable then
		table.remove(killThemAllTable,unitID)
		if killThemAllTable then
			for i=1,#killThemAllTable,1 do
				StartThread(risingPosition,killThemAllTable[i],limit)
			end
			killThemAllCounter=table.getn(killThemAllTable)
		end
	else
		killThemAllCounter=0
	end
	--Features Evaporating
			allFeatures = getAllFeatureNearUnit(unitID,150)
			if allFeatures then
				process(allFeatures,
				function(id)
					
					fx,fy,fz=Spring.GetFeaturePosition(id)
					fy= math.max(5,fy)
					Spring.SpawnCEG("blackspheredissolvefx",fx,fy+10,fz,0,1,0,0)	
				Spring.DestroyFeature(id,true,true) end
				)
			end
	
end

function spawn (totalTime)
	
	
	
	Hide(halfSphere)
	Hide(flipSphere)
	Show(fullSphere)
	StartThread(catchThem)
	-- will be sucked in and then dissolved
	Spin(halfSphere,y_axis,math.rad(42),0.6)
	val=math.random(-4.2,4.2)
	if math.random(0,1) then
		Spin(halfSphere,z_axis,math.rad(val),0)
	else
		Spin(halfSphere,x_axis,math.rad(val),0)
	end
	Sleep(totalTime/6)
	Show(flipSphere)
	Hide(fullSphere)
	Sleep(totalTime/2)
	Hide(flipSphere)
	Show(halfSphere)
	Sleep(totalTime*4)
	hideT(piecesTable)
	hideT(RedSunTable)
	hideT(SunTable)
	hideT(PlanetTable)
	Spring.DestroyUnit(unitID,false,true)
	
end

function risingPosition(anyID,limit)
	if anyID== unitID then return end
	validID= Spring.ValidUnitID(anyID)
	if not  validID or validID == false then return end
	if not Spring.GetUnitIsDead(anyID) then return end

	local spSpawnCEG=Spring.SpawnCEG
	local spGetUnitPos=Spring.GetUnitPosition
	local spSetRotationOffset=Spring.MoveCtrl.SetRotationOffset
	local spSetPosition= Spring.MoveCtrl.SetPosition
	
	Spring.MoveCtrl.Enable(anyID,true)
	Spring.SetUnitNeutral(anyID,true)
	Spring.SetUnitNoSelect(anyID,true)
	--slowly Move It Up
	--Make it spin around
	local ax=0
	local ay=0
	local az=0
	ax,ay,az=spGetUnitPos(anyID)
	while( ay < limit) do
		val=math.random(2,6)	
		ax,ay,az=spGetUnitPos(anyID)
		spSetPosition(anyID,ax,ay+val,az)
		spSetRotationOffset(anyID,0,0.01,0)
		spSpawnCEG("blackspheredissolvefx",ax,ay+val,az,0,1,0,50,0)--blackbublesBody, white rising particles
		Sleep(70)
	end
	Spring.DestroyUnit(anyID,false,true)
	for i=1,12, 1 do
		spSpawnCEG("blackspheredissolvefx",ax,ay+(i*2),az,0,1,0,50,0)--blackbublesBody, white rising particles
		Sleep(i*10)
	end
	killThemAllCounter=killThemAllCounter-1
	--
end


function emitSFX(totaltime)
	--BigBang
	EmitSfx(Emitor,1027)
	Sleep(totaltime/4)
	for i=1,4, 1 do
		EmitSfx(Emitor,1024)
	end
	StartThread(sunSet,totaltime/2)
	Sleep(totaltime/4)
	for i=1,7,1 do
		val=math.random(0,360)
		Turn(Emitor,y_axis,math.rad(val),0,true)
		EmitSfx(Emitor,1025)	
	end	
	Sleep(totaltime/4)
	
	for i=1, #SunTable, 1 do
		Hide(SunTable[i])
	end
	for i=1, #SunTable, 1 do
		Show(RedSunTable[i])
	end
	Sleep(totaltime/4)
	
	
	
end

function sunSet(time)
	local x=time
	while x > 0 do
		for i=1, #SunTable, 1 do
			EmitSfx(SunTable[i],1026)
			EmitSfx(RedSunTable[i],1026)
		end
		x=x-5
		Sleep(5)
	end
	
	
end


function script.Create()
	StartThread(spawn,12000)
	x,y,z=Spring.GetUnitPosition(unitID)
	Spring.MoveCtrl.Enable(unitID,true)
	Spring.MoveCtrl.SetPosition(unitID,x,y+25,z)
	Spring.SetUnitAlwaysVisible(unitID,true)
	Spring.SetUnitNoSelect(unitID,true)
	Spring.SetUnitBlocking(unitID,false)
	
	
	
	teamID=Spring.GetUnitTeam(unitID)
	-- Show halfSphere - Dig Hole for halfSphere
	
	--<TERRAFORM>
	--<DIGHOLE>										
	size=30
	if GG.DynDefMap == nil then GG.DynDefMap={} end
	if GG.DynRefMap == nil then GG.DynRefMap={} end
	GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="borderblur"}
	GG.DynRefMap[#GG.DynRefMap+1]=	prepareHalfSphereTable(size,-8)
	GG.boolForceLandLordUpdate=true
	
	--tempTable=prepareHalfSphereTable(size)
	--printOUT(tempTable)
	GG.UnitsToSpawn:PushCreateUnit("gdecbigbangscar",x,0,z,0,teamID)
	--</DIGHOLE>
	
	--</TERRAFORM>
	StartThread(emitSFX,12000)

	StartThread(planetarium,6)
	StartThread(sunEmitSFx,12000)
	
	
	
	
end

function sunEmitSFx()
	while true do
		Sleep(50)
		for i=1,#SunTable, 1 do
			emitCegAtPiece("sunfx",SunTable[i])
		end
	end
	
end

function particleTestThread(totalTime)
	local spSpawnCEG=Spring.SpawnCEG
	ax,ay,az=Spring.GetUnitPosition(unitID)
	ay=ay+200
	totalTime=math.ceil(totalTime/5)
	
	
	
	Sleep(totalTime)
	EmitSfx(Emitor,1024)
	Sleep(totalTime)
	EmitSfx(Emitor,1025)
	
	Sleep(totalTime)
	
	--DoDO test this
	
	Sleep(totalTime)
	EmitSfx(Emitor,1027)
	Sleep(totalTime)
	
	
end
function script.Killed()
	
	return 0
end