include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

local nano = piece "fcgate"
local fcg = piece"fcg"
local fcg2 = piece "fcg2"
local fcg3 = piece "fcg3"
local fcg4 = piece "fcg4"
local spinUp= piece "spinUp"
local nanu= piece "nano"
local fclvl2= piece "fclvl2"
local gateitterator=1
buildspot=piece"buildspot"
Emittors={}
for i=1,14,1 do
Emittors[i]={}
name="emit"..i
Emittors[i]=piece(name)
end

CEmittors={}
for i=1,7,1 do
CEmittors[i]={}
name="cemit"..i
CEmittors[i]=piece(name)
end
nanomit=Emittors[9]

Generators={}
Cables={}
for i=1,6,1 do

name="generator"..i
cname="cable0"..i
Generators[i]=piece(name)
Cables[i]=piece(cname)
end


local SIG_UPGRADE=2

function script.Create()
hideT(Generators)
hideT(Cables)
Spin(spinUp,z_axis,math.rad(242),0.5)
--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)

StartThread(delayedUpgrade)
--</buildanimationscript>


Hide(fcg)
Hide(fcg2)
Hide(fcg3)
Hide(fcg4)
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


			for i=0,360,3  do
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

function script.Killed(recentDamage,_)

Move(nano,y_axis, 78,15)
WaitForMove(nano,y_axis)

Move(nano,y_axis, 255,45)
WaitForMove(nano,y_axis)

Move(nano,y_axis, 1024,180)
WaitForMove(nano,y_axis)
Move(nano,y_axis, 2048,360)
WaitForMove(nano,y_axis)
Hide(nano)
Explode (nano, SFX.SHATTER)
suddenDeath(unitID,recentDamage)
Sleep(10)
return 0
end

function script.QueryBuildInfo()
	return buildspot	--the unit will be constructed at the position of this piece
end


--------BUILDING---------

function script.QueryNanoPiece()

     return nanu
end


UPGRADEDEFID=UnitDefNames["upgradefactory"].id
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
if id and  Spring.ValidUnitID(id)==true then
defID=Spring.GetUnitDefID(id)
	if (defID== UPGRADEDEFID and Spring.ValidUnitID(id)==false)  then
		if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
		x,y,z=Spring.GetUnitPosition(unitID)
		teamID=Spring.GetUnitTeam(unitID)
		GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
		GG.UnitsToSpawn:PushCreateUnit("coffworldassemblyseed",x,y,z,0,teamID)
		Sleep(1000)
		Spring.DestroyUnit(unitID,false,true)
	elseif  GENUPGRADEDEFID==defID and Spring.ValidUnitID(id)==true then

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
			if boolm and boolm==true then Spring.AddTeamResource(teamID,"m",amount) end
			if boole and boole==true then Spring.AddTeamResource(teamID,"e",amount) end
			end
		else
		resetUpgradeCmd(unitID)
		    Move(buildspot,z_axis,0,72)
			Hide(fcg)
			Hide(fcg2)
			Hide(fcg3)
			Hide(fcg4)
		end

end
end
end
end

local UPGRADEDEFID=UnitDefNames["upgradefactory"].id
function resetUpgradeCmd(factoryID)

      local upgrades = {[GENUPGRADEDEFID]=true,[UPGRADEDEFID]=true}
      local facCmds = Spring.GetFactoryCommands(factoryID)
 
      if facCmds then -- nil check
		local cmd = facCmds[1]
         Spring.GiveOrderToUnit(factoryID, CMD.REMOVE, {i,cmd.tag}, {"ctrl"})

      end
   end

function script.Activate ( )
 


	SetUnitValue(COB.YARD_OPEN, 1)

	SetUnitValue(COB.BUGGER_OFF, 1)

	SetUnitValue(COB.INBUILDSTANCE, 1)
	return 1
  end



  function script.Deactivate ( )
   
  SetUnitValue(COB.YARD_OPEN, 0)

  SetUnitValue(COB.BUGGER_OFF, 0)

   SetUnitValue(COB.INBUILDSTANCE, 0)
--Sleep(150)
	return 0
  end

  function script.StopBuilding()
  Move(buildspot,z_axis,0,72)
  Sleep(72)
	Hide(fcg)
	Hide(fcg2)
	Hide(fcg3)
	Hide(fcg4)


end

function sFx(gateitterator)
	x=0

		while x < 28 do

				for i=1,math.min(x,14),1 do
				EmitSfx(Emittors[i],1024)
				end
			Sleep(25)
			x=x+1
				if x%3== 0 then
					for i=1,7,1 do
					EmitSfx(CEmittors[i],1025)

					end
				end
		end

		if gateitterator==1 then
		 Show(fcg)

		end
	  if gateitterator==2 then
	  Show(fcg2)

	  end
	  if gateitterator==3 then
	  Show(fcg3)

	  end
	  if gateitterator==4 then
	  Show(fcg4)

	  end
	  Sleep(4000)
	  boolOnlyOnce=false

end


boolOnlyOnce=false
function script.StartBuilding(heading, pitch)
Move(buildspot,z_axis,145,14.5)

	 gateitterator=gateitterator%4
	gateitterator=gateitterator+1
	if boolOnlyOnce==false then
	boolOnlyOnce=true
	StartThread(sFx,gateitterator)
	end


	end




