include"createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

include "lib_Build.lua" 


buildspot = piece "buildspot"
winke=piece"winke"
larm=piece"larm"
rarm=piece"rarm"
center=piece"center"

rred=piece"rred"
rgreen=piece"rgreen"
lgreen=piece"lgreen"
lred=piece"lred"
spine7=piece"spine7"
spine6=piece"spine6"
spine5=piece"spine5"
spine4=piece"spine4"
spine3=piece"spine3"
spine1=piece"spine2"
spine2=piece"spine1"
cityblock1=piece"cityblock1"
cityblock2=piece"cityblock2"
house=piece"house"
roof=piece"roof"
plaza=piece"Plaza"
base=piece"base"
emit1=piece"emit1"
emit2=piece"emit2"


local SIG_UNFOLD=4
local SIG_FOLD=8
local SIG_WELD=16

Generators={}
Cables={}
for i=1,7,1 do
	
	name="generator"..i
	cname="cable0"..i
	Generators[i]=piece(name)
	Cables[i]=piece(cname)
end

function toInfinityAndBeyond()
	Hide(rred)
	Hide(lred)
	Show(lgreen)
	Show(rgreen)
	for i=1,5,1 do
		Turn(rarm,z_axis,math.rad(-35),9)
		Turn(larm,z_axis,math.rad(35),9)
		WaitForTurn(larm,z_axis)
		Sleep(250)
		Turn(rarm,z_axis,math.rad(35),9)
		Turn(larm,z_axis,math.rad(-35),9)
		WaitForTurn(rarm,z_axis)
		Sleep(350)
		
	end
	Turn(rarm,z_axis,math.rad(0),0.14)
	Turn(larm,z_axis,math.rad(0),0.16)
	Show(rred)
	Show(lred)
	Hide(lgreen)
	Hide(rgreen)
end


function setUpGenerator(nr)
	
	
	ux,uy,uz=Spring.GetUnitPosition(unitID)
	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	local spGetGroundHeight=Spring.GetGroundHeight
	while true do
		dir=math.random(-1,1)
		dir=math.abs(dir)/dir
		x,y,z=spGetUnitPiecePosDir(unitID,Generators[nr])
		gh=spGetGroundHeight(x,z)
		totalDeg=0
		itVal=math.random(5,25)
		
		
		
		for j=0,360,itVal do
			
			Turn(Cables[nr],y_axis,math.rad(j*dir),0,true)
			Turn(Cables[nr],x_axis,math.rad(0),0,true)
			x,y,z=spGetUnitPiecePosDir(unitID,Generators[nr])
			gh=spGetGroundHeight(x,z)
			
			
			for i=0,360,3 do
				totalDeg=i*dir
				Turn(Cables[nr],x_axis,math.rad(totalDeg),0,true)
				x,y,z=spGetUnitPiecePosDir(unitID,Generators[nr])
				gh=spGetGroundHeight(x,z)
				
				
				if y-gh > 0 and y-gh <5 then
					enddeg=totalDeg-(5*dir)
					Turn(Cables[nr],x_axis,math.rad(enddeg),0,true)
					Turn(Generators[nr],x_axis,math.rad(-1*enddeg),0,true)
					Show(Generators[nr])
					Show(Cables[nr])
					return
				end
				
			end
			
			
		end
		Sleep(10)
		
	end
	
end

function script.Create()
	hideT(Cables)
	hideT(Generators)
	x=math.ceil(math.random(0,3))
	Turn(center,y_axis,math.rad(x*90),0)
	Hide(lgreen)
	Hide(rgreen)
	Show(base)
	Show(house)
	Show(cityblock2)
	Show(cityblock1)
	Show(roof)
	Show(plaza)

	StartThread(delayedUpgrade)
	Hide(base)
	if(math.random(0,1))==1 then Hide(cityblock1) end
	if(math.random(0,1))==1 then Hide(cityblock2) end
	if(math.random(0,1))==1 then 
		Hide(house)
		Hide(roof)
		Hide(spine1)
		Hide(spine2)
	else
		Hide(plaza)
	end
	
	StartThread(fold)
	--<buildanimationscript>
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
	
	--</buildanimationscript>
	
end


function script.QueryBuildInfo() 
	return buildspot	--the unit will be constructed at the position of this piece
end

function arcWeld()
	SetSignalMask(SIG_WELD)
	while(true) do
		rand=math.ceil(math.random(100,2400))
		Sleep(rand)
		for i=1,14,1 do
			triOP=math.random(1,3)
			if triOP==1 then 
				EmitSfx(emit1,1024) 
			elseif triOP==2 then 
				EmitSfx(emit2,1024)
			else
				EmitSfx(emit2,1024)
				EmitSfx(emit1,1024)
			end
			
			rand=math.ceil(math.random(100,150))
			Sleep(rand)		
		end
		
	end
end

Spring.SetUnitNanoPieces(unitID,{buildspot})



function script.Killed(recentDamage,_)
	createCorpseCBuilding(unitID,recentDamage)
	Sleep(10)
	return 1
end


function showBase()
	Sleep(1000)
	Show(base)
	
end

function hideBase()
	Sleep(24000)
	Hide(base)
	
end


function unfold()
	Signal(SIG_FOLD)
	SetSignalMask(SIG_UNFOLD)
	Move(spine7,y_axis,215,7)
	StartThread(showBase)
	
	Sleep(9000)
	Turn(spine1,y_axis,math.rad(34),0.1)
	Sleep(5000)
	Turn(spine2,y_axis,math.rad(40),0.1)
	Sleep(5000)
	Turn(spine3,y_axis,math.rad(123),0.2)
	Turn(spine4,y_axis,math.rad(65),0.1)
	Sleep(5000)
	Turn(spine5,y_axis,math.rad(83),1)
	Sleep(5000)
	Turn(spine6,y_axis,math.rad(88),1)
	
	
end


GENUPGRADEDEFID=UnitDefNames["genupgrade"].id
upgrade=0
amount=1000
buildup=0.1
myDefID=Spring.GetUnitDefID(unitID)
teamID=Spring.GetUnitTeam(unitID)
orgBuildSpeed=	UnitDefs[myDefID].buildSpeed
buildSpeedMax=orgBuildSpeed + buildup*#Generators
myBuildSpeed=orgBuildSpeed

function delayedUpgrade()
	while true do
		Sleep(1000)
		id=Spring.GetUnitIsBuilding(unitID)
		
		
		if id and Spring.ValidUnitID(id)==true then
			
			defID=Spring.GetUnitDefID(id)
			if GENUPGRADEDEFID==defID and Spring.ValidUnitID(id)==true then
				
				if upgrade < #Generators then
					boolm=Spring.UseUnitResource(unitID,"m",amount)
					boole=Spring.UseUnitResource(unitID,"e",amount)
					
					if boolm and boole and boolm==true and boole==true then
						StartThread(setUpGenerator,upgrade+1)
						val=math.min(myBuildSpeed+buildup,buildSpeedMax)
						Spring.SetUnitBuildSpeed(unitID,val)
						upgrade=upgrade+1
						myBuildSpeed=myBuildSpeed+buildup
						resetUpgradeCmd(unitID)	
					else --Rückerstattung
						if boolm and boolm==true then Spring.AddUnitResource(teamID,"m",amount) end
						if boole and boole==true then Spring.AddUnitResource(teamID,"e",amount) end
					end
				else
					resetUpgradeCmd(unitID)
					fold()
				end
			end
			
			
			
			
			
		end
	end
end

function resetUpgradeCmd(factoryID)
	if GENUPGRADEDEFID and UPGRADEDEFID then
		local upgrades = {[GENUPGRADEDEFID]=true,[UPGRADEDEFID]=true}
		local facCmds = Spring.GetFactoryCommands(factoryID)
		
		if facCmds then -- nil check
			local cmd = facCmds[1]
			Spring.GiveOrderToUnit(factoryID, CMD.REMOVE, {i,cmd.tag}, {"ctrl"})
			
		end
	end
end


function fold()
	Signal(SIG_UNFOLD)
	SetSignalMask(SIG_FOLD)
	Move(spine7,y_axis,0,7)
	StartThread(hideBase)
	Sleep(500)
	StartThread(toInfinityAndBeyond)
	Sleep(4500)
	Turn(spine6,y_axis,math.rad(0),0.5)
	Turn(spine5,y_axis,math.rad(0),0.5)
	Turn(spine4,y_axis,math.rad(0),0.5)
	Turn(spine3,y_axis,math.rad(0),0.5)
	Turn(spine2,y_axis,math.rad(0),0.5)
	Turn(spine1,y_axis,math.rad(0),0.5)
	
	Sleep(4000)
	WaitForMove(spine7,y_axis)
	Signal(SIG_WELD)
end

function script.Activate()
	
	SetUnitValue(COB.YARD_OPEN, 1)
	SetUnitValue(COB.INBUILDSTANCE, 1)
	SetUnitValue(COB.BUGGER_OFF, 1)
	--Spring.Echo("Activate")
	return 1
end

function script.Deactivate()
	Signal(SIG_BUILDSTUFF)
	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	SetUnitValue(COB.BUGGER_OFF, 0)
	
	return 0
end


--------BUILDING---------
function script.StopBuilding()
	
	StartThread(fold)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	
end

function script.StartBuilding(heading, pitch)	
	Signal(SIG_WELD)
	StartThread(arcWeld)
	StartThread(unfold)
	SetUnitValue(COB.INBUILDSTANCE, 1)
end


function script.QueryLandingPadCount(x)
	return 1
end

function script.QueryLandingPad(buildspot)
	return buildspot
end