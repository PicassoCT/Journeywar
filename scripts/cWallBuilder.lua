include "suddenDeath.lua"
include "lib_UnitScript.lua"
--Define the wheel pieces
buildpieces={}

for i=0,17,1 do
	buildpieces[i]={}
	local temp = "cWBshow"..i
	buildpieces[i]=piece (temp)
end


function chargeUp(boolIsCharged)
	
	----Spring.Echo("Nonsense all of this is futile!")
end


Light1= piece "Light1"
Light2= piece "Light2"
Light3= piece "Light3"
Light4= piece "Light4"
local cWBLightON= piece "cWBLighton"
local cWBLightOF= piece "cWBLightOf"

local cWBfeeder = piece "cWBfeeder"
local cWBfeeder2 = piece "cWBfeeder2"
local cWBgrab = piece "cWBgrab"
local cWBgrab2 = piece "cWBgrab2"
local cWBnanosf0 = piece "cWBnanosf0"
local cWBnanosfx = piece "cWBnanosfx"
local cWBcenter=piece "cWBcenter"
local centemit=piece "centemit"


rotator={}
for i=0,8,1 do
	rotator[i]={}
	local cWBrotato= "cWBrotato"..i
	rotator[i]=piece (cWBrotato)
end




JollyWalker={}

for i=1,6,1 do
	JollyWalker[i]={}
	local walkThisWay = "cWBwalker"..i
	JollyWalker[i]= piece(walkThisWay)
end
--Define the pieces of the weapon
--turret + two turret emiter
local podturret0=piece"podturret0" --citurret
local citurrete0=piece"citurrete0"
local citurretem=piece"citurretem"
--turret + two turret emiter --
local podturret3=piece"podturret3" --citurret1
local citurrete5=piece"citurrete5"
local citurrete6=piece"citurrete6"
--turret + two turret emiter--
local podturret1=piece"podturret1" --podturret1
local citurrete1=piece"citurrete1"
local citurrete2=piece"citurrete2"
--turret + two turret emiter		--citurret3
local podturret2=piece"podturret2"
local citurrete3=piece"citurrete3"
local citurrete4=piece"citurrete4"

local frontsensor=piece"frontSensor"
local rearsensor=piece"rearSensor"
local boolIsActive=true
local boolWalking=false
--superportal+magnetic sucker
--local cifireclo2=piece"cifireclo2"

--define other pieces

local SIG_WALK = 1	--signal for the walk animation thread
local SIG_IDLE=4

function script.Activate()
	----Spring.Echo("Activate")
	boolIsActive=true
	
	return 1
end

function script.Deactivate()
	boolIsActive=false
	--	--Spring.Echo("Deactivate")
	
	return 0
end

local function Lights()
	while(true) do
		
		
		while(boolIsActive==true) do
			Show(cWBLightOF)
			Hide(cWBLightON)
			Sleep(1200)
			Hide(cWBLightOF)
			Show(cWBLightON)
			Sleep(1200)
		end
		Show(cWBLightOF)
		Hide(cWBLightON)
		Sleep(100)
	end
end

function emitLight()
	while(true) do
		maRandom=math.random(55,155)
		Sleep(maRandom)
		EmitSfx(centemit,1028)
	end
end

function script.Create()
	StartThread(constTerraFormin)
	StartThread(emitLight)
	Hide( citurrete0) 
	Hide( citurretem) 
	
	Hide( citurrete5) 
	Hide( citurrete6) 
	
	Hide( citurrete1) 
	Hide( citurrete2) 
	
	
	Hide( citurrete3) 
	Hide( citurrete4) 
	----Spring.Echo("Im talking therfore i am")
	for i=0,8,1 do
		randspin=math.random(7,16)
		Spin((rotator[i]),y_axis,randspin,0.2)
	end
	for i=0,17,1 do
		Hide(buildpieces[i])
	end
	
	Hide(cWBLightON)
	Spin(cWBnanosfx,y_axis,0.6,0.1)
	Spin(cWBnanosf0,y_axis,-1,0.5)
	StartThread(walkTheDog)
	StartThread(Lights)
end

function script.StopBuilding()
	Turn(cWBcenter,y_axis,math.rad(0),4)
	
	SetUnitValue(COB.INBUILDSTANCE, 0)
end


function script.StartBuilding(heading, pitch)
	Turn(cWBcenter,y_axis,heading+math.rad(180),0.9)
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

function script.QueryNanoPiece()
	x=math.random(1,8)
	return rotator[x]
end




--http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units
function walkTheDog()
	while(true)do 
		Sleep(70)
		while boolWalking==true do
			legMoveSpeed=22
			Move(JollyWalker[3],z_axis,0,26)
			Move(JollyWalker[4],z_axis,0,26)
			Move(JollyWalker[1],z_axis,40,22)
			Move(JollyWalker[2],z_axis,40,22)
			Move(cWBfeeder,z_axis,0,3)
			Move(cWBfeeder2,z_axis,-13,3)
			
			Turn(cWBgrab,y_axis,math.rad(-40),7)
			Turn(cWBgrab2,y_axis,math.rad(0),8)
			WaitForTurn(cWBgrab2,y_axis)
			Move(cWBgrab2,z_axis,0,22)
			Move(cWBgrab,z_axis,14,16)
			sleep=legMoveSpeed*25
			Sleep(sleep)
			WaitForMove(cWBfeeder2,z_axis)
			Move(JollyWalker[6],z_axis,0,23)
			Move(JollyWalker[5],z_axis,0,22)
			Move(JollyWalker[3],z_axis,17,8)
			Move(JollyWalker[4],z_axis,17,8)
			WaitForMove(JollyWalker[3],z_axis)
			WaitForMove(JollyWalker[4],z_axis)
			WaitForMove(JollyWalker[5],z_axis)
			Move(JollyWalker[6],z_axis,9,4)
			Move(JollyWalker[5],z_axis,9,4)
			Move(cWBfeeder,z_axis,-13,5)
			Move(cWBfeeder2,z_axis,0,5)
			Turn(cWBgrab2,y_axis,math.rad(-40),9)
			Turn(cWBgrab,y_axis,math.rad(0),9)
			WaitForTurn(cWBgrab,y_axis)
			Move(cWBgrab,z_axis,0,22)
			Move(cWBgrab2,z_axis,14,8)
			WaitForMove(cWBfeeder2,z_axis)
			Sleep(60)
			
		end
	end
	
end

function script.Killed(recentDamage, maxHealth)
	--legs_down()
	
	Signal(SIG_WALK)
	Signal(SIG_AIM) 
	Signal(SIG_IDLE)
	Signal(SIG_AIM2)
	Explode(podturret0, SFX.FALL+SFX.FIRE)
	Explode(podturret1, SFX.FALL+SFX.FIRE)
	Explode(podturret2, SFX.FALL+SFX.FIRE)
	Explode(podturret3, SFX.FALL+SFX.FIRE)
	Explode(podturret3, SFX.FALL+SFX.FIRE)
	for i=1,63,1 do
		
		Explode(i,SFX.FALL+SFX.SHATTER)
	end
	
	suddenDeathV(recentDamage)
	
	return 1
end

function legs_down()
	for i=1,6,1 do
		Move(JollyWalker[i],z_axis,0,22)
	end
	
	
	
end


function script.StartMoving()
	Move(centemit,z_axis,34,0)
	boolWalking=true
	----Spring.Echo("walk")
	--Signal(SIG_WALK)
	--Signal(SIG_IDLE)
	--legs_down()
	--StartThread(walk)
end

function script.StopMoving()
	Move(centemit,z_axis,0,0)
	--	--Spring.Echo("stop")
	boolWalking=false
	legs_down()
	
	
	
end

function preparhalfSphereTable(size)
	center=math.ceil(size/2)
	T={}
	for o=1,size,1 do
		T[o]={}
		for i=1,size,1 do
			--default
			T[o][i]=0
			distCenter=math.sqrt((center-i)^2+(center-o)^2)	
			if distCenter < center-1 then
				T[o][i]=1
			end
		end
	end
	
	return T	
end

function degreeSin (x)
	return math.sin(math.rad(x))
end


function degreeCos (x)
	return math.cos(math.rad(x))
end


function drehMatrix(y,x,zx,zy,degree)
	--many manhours were given here invain, 
	--let this be a reminder to future coder generations, 
	--to not squander there investments to poor understanding of the work gone before
	x=x-zx
	y=y-zy	
	
	sinus 	= degreeSin(degree)
	cosinus = degreeCos(degree)
	
	tempX= x*cosinus + y*sinus*-1
	y= x*sinus + y*cosinus
	x=tempX
	x=zx+x
	y=zy+y
	
	return math.floor(x),math.floor(y)
end

function directionColourTable(TC, y,fh,rh,size)
	--Prepare the Values
	NT={}
	NT=TC
	dif=math.abs(fh-rh)
	midval=(fh-rh)/2
	boolGoingDown= fh-rh < 0
	steigung=math.tan(y)
	step=dif/size*-1
	--Prepare the Values
	
	--Make a GradientTable
	for i=1,#TC,1 do
		for j=1,#TC,1 do
			if TC[i][j]==1 then
				if boolGoingDown==true or boolWalking==false then
					TC[i][j]=0
				else
					TC[i][j]=math.ceil(dif-(i*step))
				end
			end
		end
	end
	
	--Turn the Tables - DJ like a mad man
	for i=1,#TC,1 do
		for j=1,#TC,1 do
			if TC[i][j]==1 then
				ki,kj=drehMatrix(i,j,size/2,size/2, math.deg(y))
				if not NT[ki] then NT[ki]={}end
				NT[ki][kj]=TC[i][j]
			end
		end
	end
	return NT
end

function constTerraFormin()
	T={}
	size=128/8
	local T	=preparhalfSphereTable(size)
	local spGetUnitPosition=Spring.GetUnitPosition
	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	local spGetGroundHeight=Spring.GetGroundHeight
	local spGetUnitRotation=Spring.GetUnitRotation
	
	if not GG.DynDefMap then GG.DynDefMap={} end
	if not GG.DynRefMap then GG.DynRefMap={} end
	
	teamID=Spring.GetUnitTeam(unitID)
	averageTable={}
	while true do
	
		if boolIsActive == true then 		
			if consumeAvailableRessource("e", 50, teamID) == true then
				
				if boolWalking == true then
				
				--get the average current Height front and rear
				TC={}	
				for i=1,size do
					for j=1,size do
					TC[i][j]= 0
						if distance({x=size/2-i,y=size/2-j},{x=size/2,y=size/2})< size/2 then
						TC[i][j]= 1
						end
					end
				end				
				x,y,z=spGetUnitPosition(unitID)
				fx,fy,fz = spGetUnitPiecePosDir(unitID,frontSensor)				
				rx,ry,rz = spGetUnitPiecePosDir(unitID,rearSensor)				
				targetheigth=spGetGroundHeight(fx,fz)
				_,dir,_=spGetUnitRotation(unitID)
				
				
				if dir < 0 then dir= 3.14159+dir end
				
				TC=directionColourTable(TC, dir ,y, fy,ry,size)

				echoT(TC)
				GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="relative", filterType="borderblur"}
				GG.DynRefMap[#GG.DynRefMap+1]=	TC
				GG.boolForceLandLordUpdate=true
				Spring.Echo("Forcing Landlord Update- echoin Transfomration Table")
				else
				x,y,z=spGetUnitPosition(unitID)
					
					GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="add", filterType="borderblur"}
					GG.DynRefMap[#GG.DynRefMap+1]=	preparhalfSphereTable(size,16)
					GG.boolForceLandLordUpdate=true
				
					while boolWalking == true do
					Sleep(1000)
					end
				
				
				end
				
			end	
		end	
		Sleep(5000)

	end
end




--The copypastated towers of the citadell


function script.AimFromWeapon1() 
	return podturret0 
end

function script.QueryWeapon1() 
	rand=math.random(0,1)
	if rand==0 then
		return citurrete0
	end
	
	if rand==1 then
		return citurretem
	end
	
end

function script.AimWeapon1( heading ,pitch)	
	
	Turn(podturret0,y_axis, heading, 3)
	Turn(podturret0,x_axis, -pitch, 3)
	WaitForTurn(podturret0,y_axis)
	WaitForTurn(podturret0,x_axis)
	return true
end

function script.FireWeapon2()	
	return true
end
--------------------------------------------------------------------------
--turret + two turret emiter


function script.AimFromWeapon2() 
	return podturret3 
end




function script.QueryWeapon2() 
	rand=math.random(0,1)
	if rand==0 then
		return citurrete5
	end
	
	if rand==1 then
		return citurrete6
	end
	
end

function script.AimWeapon2( heading ,pitch)	
	
	Turn(podturret3,y_axis, heading, 3)
	Turn(podturret3,x_axis, -pitch, 3)
	WaitForTurn(podturret3,y_axis)
	WaitForTurn(podturret3,x_axis)
	return true
end

function script.FireWeapon2()	
	return true
end

--------------------------------------------------------------------------
--turret + two turret emiter


function script.AimFromWeapon3() 
	return podturret1 
end






function script.QueryWeapon3() 
	rand=math.random(0,1)
	if rand==0 then
		return citurrete1
	end
	
	if rand==1 then
		return citurrete2
	end
	
end

function script.AimWeapon3( heading ,pitch)	
	
	Turn(podturret1,y_axis, heading, 3)
	Turn(podturret1,x_axis, -pitch, 3)
	WaitForTurn(podturret1,y_axis)
	WaitForTurn(podturret1,x_axis)
	return true
end

function script.FireWeapon3()	
	return true
end

-------------------------------------------------------------------------
--turret + two turret emiter


function script.AimFromWeapon4() 
	return citurret3 
end




function script.QueryWeapon4() 
	rand=math.random(0,1)
	if rand==0 then
		return citurrete3
	end
	
	if rand==1 then
		return citurrete4
	end
	
end

function script.AimWeapon4( heading ,pitch)	
	
	Turn(podturret2,y_axis, heading, 3)
	Turn(podturret2,x_axis, -pitch, 3)
	WaitForTurn(podturret2,y_axis)
	WaitForTurn(podturret2,x_axis)
	return true
end

function script.FireWeapon4()	
	return true
end
----------------------------------------------

lg1=piece"lg1"
lg2=piece"lg2"

function script.AimFromWeapon4() 
	return lg1 
end




function script.QueryWeapon4() 
	return lg1
end

function script.AimWeapon4( heading ,pitch)	
	
	return false
end

function script.FireWeapon4()	
	return true
end

function script.AimFromWeapon5() 
	return lg2 
end




function script.QueryWeapon5() 
	return lg2
end

function script.AimWeapon5( heading ,pitch)	
	
	return false
end

function script.FireWeapon5()	
	return true
end