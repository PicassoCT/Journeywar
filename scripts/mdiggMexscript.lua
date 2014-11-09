
--<CopyPasteTemplate for TerraFormingUnit>


--global Infomartion
 boolUnitIsDigginDown=true
 perCentAgeDepleted=0.0

--<CopyPasteTemplate for TerraFormingUnit>
function stillAlive()
while(true) do
x,y,z=Spring.GetUnitPosition(unitID)
y=Spring.GetGroundHeight(x,z)
	if  y < 0 then
	Spring.DestroyUnit(unitID,false,false)
	end
rest=math.random(1900,5900)
Sleep(rest)
end

end

local spinAroundSpot= piece "spinAroundSpot"
local mdmeltingp = piece "mdmeltingp"
local mdwheelcenter= piece "mdwheelcenter"
local mdwheell= piece"mdwheell"
local mdwheelr= piece "mdwheelr"
local mdiggroup= piece "mdiggroup"
local mdmeltingp= piece "mdmeltingp"
local sparkemit1= piece"sparkemit1"
local spinroundPoint=piece"spinroundpoint"
local mdigg=piece"mdigg"
local mdprojecti= piece "mdprojecti"
local SIG_WIP=2
local SIG_GIC=4
local SIG_MOVE=8
local smokepiece= piece "chineySmokeEmit"

dustEmit={}
for i=1,8,1 do
dustEmit[i]={}
dusty= "dustemit"..i
dustEmit[i]=piece (dusty)
end


local heat1emit  = piece"heat1emit"
local heat2emit  = piece"heat2emit"
local heat3emit  = piece"heat3emit"
local heat4emit  = piece"heat4emit"
local heat5emit  = piece"heat5emit"
local heat6emit  = piece"heat6emit"
local boolAllreadyDead=false
local boolAllreadyStarted=false
local boolMurdered=true
local mexID = -666
boolUnDeployed=false
local boolSafetyFirst=false
--Created
function dirtEmit()

for i=1,8,1 do
EmitSfx(dustEmit[i], 1024)
end
end

function sparkEmit()
EmitSfx(sparkemit1, 1025)

end



function script.Killed(recentDamage, maxHealth)
if recentDamage>=1 then
	boolAllreadyDead=true
	Signal(SIG_WIP)
	Signal(SIG_GIC)
	Spin(mdwheelcenter,x_axis,math.rad(40),4)
	Turn(spinroundPoint,y_axis,math.rad(-80),1)
	
	WaitForTurn(spinroundPoint,y_axis)
	Turn(spinroundPoint,y_axis,math.rad(-120),1)
	
	WaitForTurn(spinroundPoint,y_axis)
	Turn(mdwheelcenter,z_axis,math.rad(7),4)
	Turn(spinroundPoint,y_axis,math.rad(-180),1)
	
	WaitForTurn(spinroundPoint,y_axis)
	
	Turn(spinroundPoint,y_axis,math.rad(-287),1)
	Sleep(800)

	WaitForTurn(spinroundPoint,y_axis)
	Explode( heat1emit , SFX.FIRE +SFX.FALL)  
	Sleep(140)
	Explode( heat2emit , SFX.FIRE +SFX.FALL)  
	Explode( heat3emit , SFX.FIRE +SFX.FALL)   
	Sleep(180)
	Explode( heat4emit , SFX.FIRE +SFX.FALL)  
	Explode( heat5emit , SFX.FIRE +SFX.FALL)   
	Explode( heat6emit , SFX.FIRE +SFX.FALL)   
	Sleep(190)
	Explode(mdwheelcenter, SFX.FIRE +SFX.FALL)
	Explode(mdigg, SFX.SHATTER )
	Explode( heat1emit , SFX.FIRE +SFX.FALL)  
	Explode( heat2emit , SFX.FIRE +SFX.FALL)  
	Explode( heat3emit , SFX.FIRE +SFX.FALL)   
	Explode( heat4emit , SFX.FIRE +SFX.FALL)  
	Explode( heat5emit , SFX.FIRE +SFX.FALL)   
	Explode( heat6emit , SFX.FIRE +SFX.FALL)   
	unitX,unitY,unitZ =Spring.GetUnitPosition(unitID)


Spring.SpawnCEG("fireSparks",unitX,unitY,unitZ,0,1,0,50,0)
	Sleep(800)
	Hide(mdwheelcenter)
		
  end
  if recentDamage<=0 then

  
  
  end
  

end


function makeSoundIfCamisClose()
x,y,z=Spring.GetUnitPosition(unitID)
local spPlaySoundFile=Spring.PlaySoundFile
	it=0.02
	while true do
		val=math.max((0.45+it)%0.75,0.75)
		spPlaySoundFile("sounds/mdigg/Digging.ogg",val)  
		Sleep(60000)
	end


end


function workInProgress()
Move(mdigg,x_axis,-32,9)
Signal(SIG_WIP)
SetSignalMask(SIG_WIP)
while(true)do
Spin(mdwheelcenter,x_axis,math.rad(-40),9)
Spin(mdwheell,y_axis,math.rad(-40),9)
Spin(mdwheelr,y_axis,math.rad(40),9)
Turn(mdmeltingp,y_axis,math.rad(-55),3)
WaitForTurn(mdmeltingp,y_axis)
WaitForTurn(mdmeltingp,y_axis)
EmitSfx(smokepiece, 1025)

EmitSfx(smokepiece, 258)
Sleep(120)
--DustEmits?
Turn(mdmeltingp,y_axis,math.rad(-120),3)
WaitForTurn(mdmeltingp,y_axis)
sparkEmit()
EmitSfx(smokepiece, 258)
dirtEmit()
Sleep(120)
Turn(mdmeltingp,y_axis,math.rad(-180),3)
WaitForTurn(mdmeltingp,y_axis)
sparkEmit()
EmitSfx(smokepiece, 258)
Sleep(120)
Turn(mdmeltingp,y_axis,math.rad(-230),3)
WaitForTurn(mdmeltingp,y_axis)
sparkEmit()
EmitSfx(smokepiece, 258)
dirtEmit()
Sleep(120)
Turn(mdmeltingp,y_axis,math.rad(-300),3)
WaitForTurn(mdmeltingp,y_axis)
sparkEmit()
EmitSfx(smokepiece, 258)

Sleep(120)
Turn(mdmeltingp,y_axis,math.rad(-360),3)
WaitForTurn(mdmeltingp,y_axis)
sparkEmit()
EmitSfx(smokepiece, 258)
--WaitForMove(mdprojecti,y_axis)
Hide(mdprojecti)
Move(mdprojecti,y_axis,0,0)
Show(mdprojecti)
Move(mdprojecti,y_axis,1700,240)
dirtEmit()
Sleep(120)
end
end

local boolreVert=false
function waitingGame()
	while(true) do
		if boolreVert==true and (Spring.ValidUnitID (unitID)) then
		Sleep(500)
				if boolreVert==true and (Spring.ValidUnitID (unitID)) then
			   local x,y,z=Spring.GetUnitPosition (unitID)
			   local teamID = Spring.GetUnitTeam (unitID)
				mexID= Spring.CreateUnit("mdigg", x, y, z, 0, teamID) 
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(mexID,health)	
				Spring.DestroyUnit (unitID,false,true)
				end
		end
		  
		  
	  

	Sleep(1000)
	end
end
local function mining()
Signal(SIG_WIP)
StartThread(workInProgress)
SetSignalMask(SIG_GIC)
boolAllreadyStarted=true
boolAllActivated=false
Move(spinAroundSpot,x_axis,-27,1)


		while(true)do
			if boolAllActivated==false then
			boolAllActivated=true
			Spin(spinAroundSpot,y_axis,math.rad(20),1)
			end
		Sleep(16192)
	


		end


end

--Killed


function script.Activate ( )
boolreVert=false

--boolUnDeployed=false
--boolSafetyFirst=true
	return 1
  end

function script.Deactivate ( )
boolreVert=true
--if boolSafetyFirst==true then
--boolUnDeployed=true
--end
--Place Unmorpher here
	return 0
  end




function script.Create()
Hide(mdprojecti)
StartThread(mining)
StartThread(makeSoundIfCamisClose)
StartThread(waitingGame)
StartThread(stillAlive)

end

