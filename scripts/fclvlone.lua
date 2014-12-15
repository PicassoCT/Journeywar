include"suddenDeath.lua"

local buildspot = piece "buildspot"
local fccore2  = piece  "fccore2"
local fccore3 = piece "fccore3"
local fccore30= piece "fccore30"
local fccorecage= piece"fccorecage"
local fcgate1 = piece "fcgate1"
local fcgate2 = piece "fcgate2"
local fcgate3 = piece "fcgate3"
local fcgate4 = piece "fcgate4"
local gateitterator=1

Emittors={}
for i=1,14,1 do
Emittors[i]={}
name="emit"..i
Emittors[i]=piece(name)
end

local SIG_HARDCORE=4
local SIG_UPGRADE=8
local function rotateCore()
Signal(SIG_HARDCORE)
SetSignalMask(SIG_HARDCORE)
StartThread(emitLight)
	while (true) do
	Spin (fccorecage, y_axis, math.rad(360),0.5)
	flipFlop=math.random(-360,360)
	Turn(fccore2,y_axis,math.rad(flipFlop),16)
	flipFlop=math.random(-360,360)
	Turn(fccore2,x_axis,math.rad(flipFlop),16)
	flipFlop=math.random(-360,360)
	Turn(fccore2,z_axis,math.rad(flipFlop),16)
	Turn(fccore3,y_axis,math.rad(flipFlop),32)
	flipFlop=math.random(-360,360)
	Turn(fccore3,x_axis,math.rad(flipFlop),32)
	flipFlop=math.random(-360,360)
	Turn(fccore3,z_axis,math.rad(flipFlop),32)
	Turn(fccore30,y_axis,math.rad(flipFlop),64)
	flipFlop=math.random(-360,360)
	Turn(fccore30,x_axis,math.rad(flipFlop),64)
	flipFlop=math.random(-360,360)
	Turn(fccore30,z_axis,math.rad(flipFlop),64)

	Sleep(50)


	WaitForTurn(fccore2,y_axis)                              
	WaitForTurn(fccore2,x_axis)                            
	WaitForTurn(fccore2,z_axis)                              
	WaitForTurn(fccore3,y_axis)                             
	WaitForTurn(fccore3,x_axis)                               
	WaitForTurn(fccore3,z_axis)                               
	WaitForTurn(fccore30,y_axis)                             
	WaitForTurn(fccore30,x_axis)                               
	WaitForTurn(fccore30,z_axis)      
	Sleep(150)                         
					
	end
end

function emitLight()

	while(true)do
	Sleep(25)
	EmitSfx(fccore2,1024)
	end			
end

function script.Create()

--<buildanimationscript>
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)

--</buildanimationscript>

Hide(fcgate1)
Hide(fcgate2)
Hide(fcgate3)
Hide(fcgate4)
Signal(SIG_HARDCORE)
StartThread(rotateCore)
end


function script.QueryBuildInfo() 
	return buildspot	--the unit will be constructed at the position of this piece
end



function script.QueryNanoPiece()
     return buildspot
end



function script.Killed(recentDamage,_)
suddenDeath(unitID,recentDamage)
Sleep(10)
return 0
end

local UPGRADEDEFID=UnitDefNames["upgradefactory"].id

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
		GG.UnitsToSpawn:PushCreateUnit("cfactorylvl1transform",x,y,z,0,teamID)			
		Sleep(1000)
		Spring.DestroyUnit(unitID,false,true)
	end

end
end


function script.Activate()
Signal(SIG_UPGRADE)

StartThread(delayedUpgrade)

	SetUnitValue(COB.YARD_OPEN, 1)
	SetUnitValue(COB.INBUILDSTANCE, 1)
	SetUnitValue(COB.BUGGER_OFF, 1)

	--Spring.Echo("fclvl1_Activate")
	return 1
end

function script.Deactivate()
	Signal(SIG_UPGRADE)

	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	SetUnitValue(COB.BUGGER_OFF, 0)
	return 0
end


--------BUILDING---------
function script.StopBuilding()
	Signal(SIG_UPGRADE)
	Hide(fcgate1)
	Hide(fcgate2)
	Hide(fcgate3)
	Hide(fcgate4)

end

function sFx(gateitterator)
	x=0
		
		while x < 28 do
		
			for i=1,math.min(x,14),1 do	
			EmitSfx(Emittors[i],1024)
		
			end
			Sleep(25)
			x=x+1
		end
		
		if gateitterator==1 then
		 Show(fcgate1)
		
		end
	  if gateitterator==2 then
	  Show(fcgate2)
	
	  end
	  if gateitterator==3 then
	  Show(fcgate3)
	 
	  end
	  if gateitterator==4 then
	  Show(fcgate4)
	
	  end
	  Sleep(4000)
	  boolOnlyOnce=false

end

boolOnlyOnce=false
function script.StartBuilding(heading, pitch)	
	Signal(SIG_UPGRADE)
	gateitterator=gateitterator%4
	gateitterator=gateitterator+1
		if boolOnlyOnce==false then	
		boolOnlyOnce=true
		StartThread(sFx,gateitterator)
		end
		
	
	end
	





