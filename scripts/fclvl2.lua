include "suddenDeath.lua"

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

local SIG_UPGRADE=2

function script.Create()
Spin(spinUp,z_axis,math.rad(242),0.5)
--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)

--</buildanimationscript>


Hide(fcg)
Hide(fcg2)
Hide(fcg3)
Hide(fcg4)
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
suddenDeath(unitIDrecentDamage)
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

function delayedUpgrade()
SetSignalMask(SIG_UPGRADE)
Sleep(5000)
id=Spring.GetUnitIsBuilding(unitID)
if id then
defID=Spring.GetUnitDefID(id)
	if (defID== UPGRADEDEFID and Spring.ValidUnitID(id)==false)  then	
		if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
		x,y,z=Spring.GetUnitPosition(unitID)
		teamID=Spring.GetUnitTeam(unitID)
		GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
		GG.UnitsToSpawn:PushCreateUnit("coffworldassemblyseed",x,y,z,0,teamID)			
		Sleep(1000)
		Spring.DestroyUnit(unitID,false,true)
	end

end
end

local UPGRADEDEFID=UnitDefNames["upgradefactory"].id


function script.Activate ( )
Signal(SIG_UPGRADE)

StartThread(delayedUpgrade)

	SetUnitValue(COB.YARD_OPEN, 1)

	SetUnitValue(COB.BUGGER_OFF, 1)

	SetUnitValue(COB.INBUILDSTANCE, 1)
	return 1
  end


  
  function script.Deactivate ( )
  Signal(SIG_UPGRADE)
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
	



