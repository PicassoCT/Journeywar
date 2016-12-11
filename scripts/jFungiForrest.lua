include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

local UnitsToSpare={}
UnitsToSpare[UnitDefNames["jtree47"].id]=true
UnitsToSpare[UnitDefNames["jtree46"].id]=true
UnitsToSpare[UnitDefNames["jtree45"].id]=true
UnitsToSpare[UnitDefNames["jtree44"].id]=true
UnitsToSpare[UnitDefNames["jtree43"].id]=true
UnitsToSpare[UnitDefNames["jtree42"].id]=true
UnitsToSpare[UnitDefNames["jtree41"].id]=true
UnitsToSpare[UnitDefNames["jspore"].id]=true
UnitsToSpare[UnitDefNames["jfungiforrest"].id]=true

fungi1=piece"fungi1"
fungi2=piece"fungi2"
fungi3=piece"fungi3"
fungi4=piece"fungi4"
emitPoint=piece"emitPoint"
center=piece"center"


function breathingDeath()
	local lEmitSfx=EmitSfx
	while(true) do
		Move(fungi1,y_axis,5,0.3)
		Move(fungi2,y_axis,5,0.4)
		Move(fungi3,y_axis,5,0.5)
		
		
		WaitForMove(fungi1,y_axis)
		for i=1,10, 1 do
			lEmitSfx(emitPoint,1024)
			Sleep(50)
		end
		
		Move(fungi1,y_axis,0,0.55)
		Move(fungi2,y_axis,0,0.4)
		Move(fungi3,y_axis,0,0.3)
		for i=1,14, 1 do
			lEmitSfx(emitPoint,1024)
			Sleep(75)
		end
		
		WaitForMove(fungi3,y_axis)
		
		
		
	end
	
	
end

fungiImuneTypeTable=getFungiImuneUnitTyeTable()
local spGetUnitDefID=Spring.GetUnitDefID

function grabTooKill()
	
	x,y,z=Spring.GetUnitPosition(unitID)
	proChoice={}
	proChoice=Spring.GetUnitsInCylinder(x,z,500)
	proChoice=process(proChoice,
	function(id)
		if not fungiImuneTypeTable[Spring.GetUnitDefID(id)]then
			return id
		end
	end
	)
	--proChoice if 
	fixxedNumber=table.getn(proChoice)
	--removing the fat from the table
	for i=1, fixxedNumber,1 do
		if proChoice[i]== unitID then 
			table.remove(proChoice,i)
			if i ~= 1 then i=i-1 end
			fixxedNumber=fixxedNumber-1
		end
	end
	newTable={}	
	for i=1,#proChoice do
		defID=spGetUnitDefID(proChoice[i])
		if not UnitsToSpare[defID] then
			newTable[#newTable+1]=proChoice[i]
		end
	end
	return newTable
end

rotators={}
swings={}
for i=1,11,1 do
	
	rotators[i]={}
	swings[i]={}
	tempr="rot"..i
	temps="swing"..i
	
	rotators[i]=piece(tempr)
	swings[i]=piece(temps)
	
end

globalHeightUnit=0
dowNer=-75

function delayedAppearance(piece)
	times=math.ceil(math.random(60000, 300000))
	Sleep(times)
	Move(piece,x_axis,500,0)
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piece)
	myHeight=Spring.GetGroundHeight(x,z)
	heightdifference=math.abs(globalHeightUnit-myHeight)
	if myHeight < globalHeightUnit then heightdifference=-heightdifference end
	
	
	Show(piece)
	
	SpeedRand=math.random(0.3,1)
	Move(piece,y_axis,heightdifference, SpeedRand)
	WaitForMove(piece,y_axis)
	boolNotGrown=false
end


function init()
	x,y,z=Spring.GetUnitPosition(unitID)
	globalHeightUnit=Spring.GetGroundHeight(x,z)
	Move(fungi1,y_axis,-34,0)
	Move(fungi2,y_axis,-34,0)
	Move(fungi3,y_axis,-34,0)
	Move(fungi4,y_axis,-34,0)
	Sleep(10)
	Show(fungi1)
	Show(fungi2)
	Show(fungi3)
	Show(fungi4)
	
	
	RandRot=math.random(-360,360)
	Turn(center,y_axis,math.rad(RandRot),0)
	for i=1,11,1 do
		Hide(swings[i])
		Move(swings[i],y_axis,dowNer,0)
		RandRot=i*(360/11)
		Turn(rotators[i],y_axis,math.rad(RandRot),0)
		StartThread(delayedAppearance, swings[i])
	end
	
	Move(fungi1,y_axis,0,0.9)
	Move(fungi2,y_axis,0,0.7)
	Move(fungi3,y_axis,0,0.6)
	Move(fungi4,y_axis,0,0.5)
	
	WaitForMove(fungi4,y_axis)
	delayTillComplete(unitID)
	StartThread(breathingDeath)
	StartThread(circleOfLife)
end

boolNotGrown=true

function circleOfLife()
	
	
	tables={}
	while boolNotGrown==true do
		Sleep(500)
	end
	
	while true do
		Sleep(450)
		tables=grabTooKill()
		if tables~= nil and table.getn(tables) > 0 then
			for i=1,table.getn(tables),1 do
				if GG.Spore== nil then GG.Spore={} end
				
				if math.random(1,6)==2 then
					valLua=tables[i]
					GG.Spore[#GG.Spore+1] ={}
					GG.Spore[#GG.Spore] =valLua
				end
			end
		end
		
		
	end
end

function script.Create()
	x,y,z=Spring.GetUnitPosition(unitID)
	holsDerGaia=Spring.GetGaiaTeamID()
	Spring.CreateUnit("jfungiforrestdecalfactory",x,y,z,0,holsDerGaia)
	Hide(fungi1)
	Hide(fungi2)
	Hide(fungi3)
	Hide(fungi4)
	for i=1,11,1 do
		Hide(swings[i])
	end
	
	
	StartThread(init)
end

function script.Killed()
	
	return 0
end