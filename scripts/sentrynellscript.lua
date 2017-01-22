
include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

--My BASE the unit does nothing
flare=piece"flare"
local nanoemit = piece "nanoemit"
local sentrynelshield	 = piece "sentrynelshield"
local sentrynelshield2	 = piece "sentrynelshield2"
local 	sentrynell 		 = piece "sentrynell"
local sentrynel0 = piece "sentrynel0"
local sentrynel1 = piece "sentrynel1"
local sentrynel2 = piece "sentrynel2"
local sentrynel3 = piece "sentrynel3"
local sentrynel4 = piece "sentrynel4"
local sentrynel5 = piece "sentrynel5"
local snfoot 		 = piece "snfoot"
local pivot 		 = piece "Pivot"
local pivot01 		 = piece "Pivot01"
local boolStoped

local boolAllReadySpawnedNotYetKilled=false
local boolIsItDeadYet=false
local boolAllreadyUnfold=false
local boolCalcSave=false
local boolActive
local boolSTOP=false
local boolLongSTOP=false
local boolMoveStateStart=true
local boolAllreadyMovin=false
local boolFilterActive=false
boolTimeOut=false
local SIG_UNFOLD=8
local SIG_FOLD=4
local SIG_SPAM=16
local SIG_TRACK=2
local SIG_WALK=32
local sentryID1
local sentryID2
local sentryID3
local sentryID4
local sentryID5
local face=0


local spamfilterSTART=true
local spamfilterSTOP=false


local spotOnTarget=false
local cosinus
local sinus
local oneDegreeRadiant = 0.017453

function degreeSin (x)
	return math.sin(math.rad(x))
end


function degreeCos (x)
	return math.cos(math.rad(x))
end


-- if you want something done write,you gotta write it yourself
function xDivFac (degree,number)
	tempResult=1
	for i=1,number,1 do
		tempResult=tempResult*i
	end
	
	
	
	value=(math.pow(degree,number))/tempResult
	powersOfPi=math.pow(oneDegreeRadiant,number)
	value=value*powersOfPi
	return value
end

function taylorSinus (degree,precision)
	if precision == nil then
		precision= 8
	end
	
	if degree >90 and degree < 180 then
		degree=degree-90
		sinus=taylorCosinus(degree,precision)
		return sinus
	end
	if degree >=180 and degree < 270 then
		degree=degree-180
		sinus=taylorSinus(degree,precision)*-1
		return sinus
	end
	if degree >=270 and degree < 360 then
		degree=degree-270
		sinus=(taylorCosinus(degree,precision)*-1)
		return sinus
		
	end
	
	
	
	
	
	sinus=0
	flipFlop=1
	precision=(precision*2)+1
	for i=1,precision,2 do
		
		if flipFlop>0 then
			sinus = sinus + xDivFac(degree,i)
		end
		if flipFlop <0 then
			sinus= sinus - (xDivFac(degree,i))
		end
		
		flipFlop=flipFlop*-1
	end
	--[[
	if sinus <0 then
		sinus=sinus*-1
	end
	]]
	
	return sinus
end

function taylorCosinus(degree,precision)
	if precision == nil then
		precision= 4
	end
	
	if degree >90 and degree <180 then
		degree=degree-90
		cosinus=(taylorSinus(degree,precision)*-1)
		return cosinus
	end
	if degree >=180 and degree <270 then
		degree=degree-180
		cosinus=taylorCosinus(degree,precision)*-1
		return cosinus
	end
	if degree >=270 and degree <360 then
		degree=degree-270
		cosinus=taylorSinus(degree,precision)
		return cosinus
		
	end
	
	
	
	precision=precision*2
	cosinus=0
	flipFlop=1
	
	for i=0,precision,2 do
		
		if flipFlop > 0 then
			cosinus = cosinus + (xDivFac(degree,i))
		end
		if flipFlop <0 then
			cosinus= cosinus - (xDivFac(degree,i))
		end
		
		flipFlop=flipFlop*-1
	end
	
	if cosinus < 0 then
		cosinus=cosinus*-1
	end
	
	return cosinus
end


function radianToDegree(heading)
	local headThing=heading
	
	local degree=0
	local oneDegree=177.77
	
	if headThing== 0 then
		degree=0
		return degree
	end
	if headThing < 0 then
		
		degree= (headThing/oneDegree)
		
		degree=(degree+360)
		degree=degree-(degree%1)
		return degree
	end
	
	if headThing >0 then
		degree=(headThing/oneDegree)
		degree=degree-(degree%1)
		degree=degree%360
		return degree
		
		
		
	end
	
	
	
end

function vectorBetrag(xv,yv,x2,y2)
	-- determiniere höheren Wert
	xv=xv-x2
	yv=yv-y2
	
	local xv=xv*xv
	local yv=yv*yv
	local xyv=xv+yv
	return math.sqrt(xyv)
	
	
end

function round2(num,idp)
	return tonumber(string.format("%." .. (idp or 0) .. "f",num))
end


function drehMatrix(y,x,zx,zy,heading)
	--many manhours were given here invain, 
	--let this be a reminder to future coder generations, 
	--to not squander there investments to poor understanding of the work gone before
	
	
	degree=(heading/177.77)
	
	if boolCalcSave == false then
		boolCalcSave=true
		--estimates the cosinus for the calculation - calcheavy therefore only done once per unitspawn
		
		--sinus= taylorSinus(degree,6)
		--sinus=round2(sinus,5)
		sinus=degreeSin(degree)
		cosinus= degreeCos(degree)
		--cosinus= taylorCosinus(degree,4) 
		--cosinus=round2(cosinus,5)
		
		
	end
	
	
	
	
	tempX= x*cosinus + y*sinus*-1
	y= x*sinus + y*cosinus
	x=tempX
	
	
	
	
	x=zx+x
	y=zy+y
	
	x=math.floor(x)
	
	y=math.floor(y)
	
	
	
	return x,y
end


function timeOut()
	Sleep(8192)
	boolTimeOut=false
end

MovingEnemysNearby={}
local myTeamID=Spring.GetUnitTeam(unitID)

function getNearestMovingEnemyDistance(ux,uz)
	
	T= getAllInCircle(ux,uz, 3000, unitID)
	ux,uy,uz=Spring.GetUnitPosition(unitID)
	T=process(T,
	function(id)
		if Spring.GetUnitTeam(id) ~= myTeamID then
			return id
		end
	end,
	function(id)
		if id then
			ex,ey,ez=Spring.GetUnitPosition(id)
			--new Unit
			if not MovingEnemysNearby[id] then	
				MovingEnemysNearby[id] = makeVector(ex,ey,ez)
			end
			
			--update Distance
			MovingEnemysNearby[id].distance= vectorBetrag(ex,ez,ux,uz)
			
			--check wether the unit moved
			locEl= MovingEnemysNearby[id]
			if ex ~= locEl.x or ey ~= locEl.y or ez ~= locEl.z then
				MovingEnemysNearby[id].x,MovingEnemysNearby[id].y,MovingEnemysNearby[id].z=ex,ey,ez
				MovingEnemysNearby[id].boolMoved=true
			else
				MovingEnemysNearby[id].boolMoved=false		
			end
			
		end
	end	
	)
	
	for id, set in pairs(MovingEnemysNearby) do
		if Spring.GetUnitIsDead(id)==true then
			MovingEnemysNearby[id]= nil
		end
	end
	
	biggestDistance=9000
	for id, set in pairs(MovingEnemysNearby) do
		if id and set then
			if set.boolMoved== true then
				if set.distance < biggestDistance then
					biggestDistance = set.distance
				end
			end
		end
	end
	
	
	
	
	return biggestDistance
end

xu,yu,zu=Spring.GetUnitPosition(unitID)
function motionTrack()
	MovingEnemysNearby={}
	SetSignalMask(SIG_TRACK)
	
	xu,yu,zu=Spring.GetUnitPosition(unitID)
	while (true) do
		
		
		Sleep(50)
		Distance = getNearestMovingEnemyDistance(xu,zu)
		
		
		if Distance and boolIsItDeadYet==false then
			for beep=0,2,1 do
				sleePer=666
				if Distance >1000 then
					
					Spring.PlaySoundFile("sounds/mt/mtnocontact.wav",0.1)
					-- --Spring.Echo("da")
					--Play Sound Plock
					Sleep(sleePer)
				end
				if Distance <=1000 and Distance>745 then
					
					Spring.PlaySoundFile("sounds/mt/mtfarawaycontact.wav",0.1)
					--Play (DetectedNonHecticBeep)
					----Spring.Echo("do")
					sleePer=303+ ((Distance/2.5)-100)
					Sleep(sleePer)
				end
				if Distance <=745 and Distance >500 then
					Spring.PlaySoundFile("sounds/mt/mtcloser.wav",0.15)
					--Play (DetectedGettingHecticBeep)
					----Spring.Echo("de")
					sleePer=303 +((Distance/2.5)-100)
					Sleep(sleePer)
				end
				if Distance <=500 then
					Spring.PlaySoundFile("sounds/mt/mtclosecomb.wav",0.15)
					--play shrill panicy sound
					----Spring.Echo("di")
					sleePer=303+((Distance/2.5)-100)
					sleePer=math.max(sleePer,303)
					
					Sleep(sleePer)
				end
				
			end
			
			if boolIsItDeadYet==true then
				Spring.PlaySoundFile("sounds/mt/createCorpse2.wav",0.2)
				--play Soundfile beeping heartdead...
				Sleep(LenghtOfSoundfile)
				Signal(SIG_TRACK)
			end
			
		end
	end
end


function faceConvert(degree)
	
	if degree>=315 or degree<45 then
		return 0
	end
	
	if degree>=45 and degree<135 then
		return 1
	end
	
	if degree>=135 and degree<225 then
		
		return 2
	end
	
	if degree>=225 and degree<315 then
		return 3
		
	end
	
end

----getViewingVectory
-- bitshiftFace=math.bit_bits(heading,7)


function sentry_Spawn()
	if boolAllReadySpawnedNotYetKilled==false then
		boolAllReadySpawnedNotYetKilled=true
		
		
		zy,zz,zx=Spring.GetUnitPosition(unitID)
		
		
		
		-- In the GetTOO,and his MOMA cried..
		face=0
		heading= Spring.GetUnitHeading(unitID)
		face=faceConvert(radianToDegree(heading))
		teamID= Spring.GetUnitTeam(unitID)
		
		
		
		
		boolCalcSave=false
		
		if boolTimeOut == false then
			x1,y1=drehMatrix(0,300,zx,zy,heading)
			sentryID1 = Spring.CreateUnit("sentry",y1,zz,x1,face,teamID)
			
			
			x2,y2=drehMatrix(-100,200,zx,zy,heading)
			sentryID2 = Spring.CreateUnit("sentry",y2,zz,x2,face,teamID)
			
			
			x3,y3=drehMatrix(100,200,zx,zy,heading)
			sentryID3 = Spring.CreateUnit("sentry",y3,zz,x3,face,teamID)
			
			
			x4,y4=drehMatrix(-165,125,zx,zy,heading)
			sentryID4 = Spring.CreateUnit("sentry",y4,zz,x4,face,teamID)
			
			
			x5,y5=drehMatrix(165,125,zx,zy,heading)
			sentryID5 = Spring.CreateUnit("sentry",y5,zz,x5,face,teamID)
			
			boolCalcSave=false
			boolTimeOut=true
			StartThread(timeOut)
			--coment me out
			
			
		else
			--Spring.Echo("Sentrynell: Can´t spawn sentrys so soon.")
		end
		
	end
	
end

function sentry_Kill()
	if (Spring.ValidUnitID (sentryID2)) then
		Spring.DestroyUnit (sentryID2,false,true) --leave no wreck
	end
	if (Spring.ValidUnitID (sentryID1)) then
		Spring.DestroyUnit (sentryID1,false,true) --leave no wreck
	end
	if (Spring.ValidUnitID (sentryID3)) then
		Spring.DestroyUnit (sentryID3,false,true) --leave no wreck
	end
	if (Spring.ValidUnitID (sentryID4)) then
		Spring.DestroyUnit (sentryID4,false,true) --leave no wreck
	end
	if (Spring.ValidUnitID (sentryID5)) then
		Spring.DestroyUnit (sentryID5,false,true) --leave no wreck
	end
	boolAllReadySpawnedNotYetKilled=false
	
end


local function walk()
	SetSignalMask(SIG_WALK)
	StopSpin(sentrynel3,y_axis)
	
	
	while(true) do
		--vorn rechts
		Move(sentrynel0,z_axis,2,2.5)
		Turn(sentrynel0,x_axis,math.rad(-7),3)
		--hinten schub
		
		Turn(sentrynell,x_axis,math.rad(4),0.5)
		
		Turn(sentrynel1,x_axis,math.rad(-6),3)
		Turn(sentrynel2,x_axis,math.rad(12),4)
		Move(sentrynel1,z_axis,-1,1.5)
		
		Turn(snfoot,x_axis,math.rad(9),3)
		Move(snfoot,z_axis,0,2)
		
		--Various Waits
		WaitForMove(sentrynel0,z_axis)
		WaitForTurn(sentrynel0,x_axis)
		WaitForTurn(sentrynel1,x_axis)
		WaitForTurn(sentrynel2,x_axis)
		WaitForMove(sentrynel1,z_axis)
		WaitForMove(snfoot,z_axis)
		WaitForTurn(snfoot,x_axis)
		Sleep(15)
		--vorne links
		Move(snfoot,z_axis,2,1.5)
		Turn(snfoot,x_axis,math.rad(-7),2)
		
		Turn(sentrynel0,x_axis,math.rad(9),3)
		Move(sentrynel0,x_axis,0,2)
		
		--hinten zug
		Turn(sentrynell,x_axis,math.rad(-4),0.5)
		Move(sentrynel1,z_axis,1,1.5)
		Turn(sentrynel1,x_axis,math.rad(8),2)
		Turn(sentrynel2,x_axis,math.rad(-28),6)
		
		WaitForMove(sentrynel0,z_axis)
		WaitForTurn(sentrynel0,x_axis)
		WaitForTurn(sentrynel1,x_axis)
		WaitForTurn(sentrynel2,x_axis)
		WaitForMove(sentrynel1,z_axis)
		WaitForMove(snfoot,z_axis)
		WaitForTurn(snfoot,x_axis)
		Sleep(15)
		
	end
end



---------------------------------------------------------------------------------------------------------------------------------------------
local function spamFilter()
	SetSignalMask(SIG_SPAM)
	
	
	while (true) do
		
		if spamfilterSTART==true and spamfilterSTOP==false then
			for it=0,3,1 do
				Sleep(1024)
				if spamfilterSTOP==true then
					spamfilterSTART=false
					break
				end
			end
			
			
			if spamfilterSTART==true then
				--if spamfilterSTART is still ==true then
				Signal(SIG_FOLD)
				
				StartThread (fold)
			end
			
		end
		
		if spamfilterSTOP==true and spamfilterSTART==false then
			for at=0,3,1 do
				Sleep(1024)
				if spamfilterSTART==true then
					spamfilterSTOP=false
					break
				end
			end
			
			if spamfilterSTOP==true then
				--if spamfilterSTOP is still ==true then
				Signal(SIG_FOLD)
				Signal(SIG_UNFOLD)
				Signal(SIG_WALK)
				if boolAllreadyUnfold==false then
					StartThread(unfold)
				end
				if boolActive==true then
					sentry_Spawn()
					
				end
				
			end
			
		end
		
		if spamfilterSTOP==false and spamfilterSTART==false then
			
			--Spring.Echo("No idea what you did,but you broke it. You gonna pay!")
			
		end
		
	end
end




function fold()
	boolAllreadyUnfold=false
	Signal(SIG_UNFOLD)
	SetSignalMask(SIG_FOLD)
	StopSpin(sentrynel3,y_axis)
	Move(sentrynell,y_axis,0,1.4)
	Turn(sentrynel5,x_axis,math.rad(0),5)
	Turn(sentrynel5,y_axis,math.rad(0),5)
	Turn(sentrynel5,z_axis,math.rad(0),5)
	WaitForTurn(sentrynel5,z_axis)
	WaitForTurn(sentrynel5,y_axis)
	WaitForTurn(sentrynel5,x_axis)
	
	Turn(sentrynel4,x_axis,math.rad(0),5)
	Turn(sentrynel4,y_axis,math.rad(0),5)
	Turn(sentrynel4,z_axis,math.rad(0),5)
	
	WaitForTurn(sentrynel4,z_axis)
	WaitForTurn(sentrynel4,y_axis)
	WaitForTurn(sentrynel4,x_axis)
	
	Turn(sentrynel3,x_axis,math.rad(0),5)
	Turn(sentrynel3,y_axis,math.rad(0),5)
	Turn(sentrynel3,z_axis,math.rad(0),5)
	
	WaitForTurn(sentrynel3,z_axis)
	WaitForTurn(sentrynel3,y_axis)
	WaitForTurn(sentrynel3,x_axis)
	
	Turn(sentrynelshield2,z_axis,math.rad(-65),3)
	Turn(sentrynelshield,z_axis,math.rad(65),3)
	WaitForTurn(sentrynelshield2,z_axis)
	WaitForTurn(sentrynelshield,z_axis)
	
	while(true) do
		walk()
		
	end
end

function unfold()
	boolAllreadyUnfold=true
	Signal(SIG_FOLD)
	
	Move(sentrynel0,x_axis,0,2)
	Move(snfoot,x_axis,0,2)
	Move(sentrynel0,y_axis,0,2)
	Move(snfoot,y_axis,0,2)
	Move(sentrynel0,z_axis,0,2)
	Move(snfoot,z_axis,0,2)
	
	Turn(sentrynelshield2,z_axis,math.rad(0),1)
	Turn(sentrynelshield,z_axis,math.rad(0),1)
	WaitForTurn(sentrynelshield2,z_axis)
	WaitForTurn(sentrynelshield,z_axis)
	Move(sentrynell,y_axis,-2,0.4)
	Turn(sentrynel0,x_axis,math.rad(28),7)
	Turn(snfoot,x_axis,math.rad(28),7)
	Turn(sentrynel1,x_axis,math.rad(-20),7)
	Sleep(890)
	
	Turn(sentrynel3,y_axis,math.rad(160),1.25)
	Turn(sentrynel5,x_axis,math.rad(-61),3)
	WaitForTurn(sentrynel3,y_axis)
	
	Turn(sentrynel4,x_axis,math.rad(-13),1)
	Turn(sentrynel3,y_axis,math.rad(270),1.25)
	WaitForTurn(sentrynel3,y_axis)
	
	Turn(sentrynel4,x_axis,math.rad(59),0.5)
	Turn(sentrynel3,y_axis,math.rad(360),1.25)
	Turn(sentrynel5,x_axis,math.rad(-83),1)
	WaitForTurn(sentrynel3,y_axis)
	triforce=1
	SetSignalMask(SIG_UNFOLD)
	while(true) do
		triforce=1+triforce
		
		
		if triforce==2 or triforce==3 then
			--Spring.Echo("Idling")
			--idle
			
			giveMeFive=5*(math.random(-9,9))
			Spin(sentrynel3,y_axis,math.rad(giveMeFive))
			Sleep(19192)
			StopSpin(sentrynel3,y_axis,3)
			
		end
		Sleep(4024)
		--Spring.Echo("NotIDling")
		triforce=triforce%4
	end
	
end


function particlesLoader()
	Spring.PlaySoundFile("sounds/sentry/imChargingMyLazors.wav")
	Sleep(1200)
	for i=1,15, 1 do
		dx=math.rad(math.random(-360,360))
		Turn(nanoemit,x_axis,dx,0)
		dx=math.rad(math.random(-360,360))
		Turn(nanoemit,z_axis,dx,0)
		dx=math.rad(math.random(-360,360))
		Turn(nanoemit,y_axis,dx,0)
		
		
		EmitSfx(flare,1024)
		
		Sleep(60)
	end
	Sleep(900)
	
	chargedUp=true
end

chargedUp=true
function script.AimWeapon1(heading ,pitch)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	Turn(sentrynel4,x_axis,math.rad(64),8)
	Turn(sentrynel3,y_axis,heading,4)
	WaitForTurn(sentrynel3,y_axis)
	WaitForTurn(sentrynel4,x_axis)
	--Spring.Echo("Sentrynell_pitch",math.deg(pitch))
	resultDeg=-64-math.deg(pitch)
	Turn(sentrynel5,x_axis,math.rad(resultDeg),3)
	WaitForTurn(sentrynel5,x_axis)
	return chargedUp
	
end

function script.AimFromWeapon1()
	return nanoemit
end

function script.QueryWeapon1()
	return nanoemit
end

function script.FireWeapon1()
	
	chargedUp=false
	StartThread(particlesLoader)
	for i=1,10,1 do
		EmitSfx(nanoemit,1025)
		Sleep(15)
	end
	
	
	return true
	
	
end





function script.Killed(recentDamage,_)
	boolIsItDeadYet=true
	Sleep(420)
	Signal(SIG_SPAM)
	Signal(SIG_FOLD)
	Signal(SIG_UNFOLD)
	Explode(nanoemit,SFX.FIRE)
	Explode(sentrynelshield2,SFX.FIRE)
	Explode(sentrynelshield,SFX.FIRE)
	createCorpseCUnitSmall(recentDamage)
	
end

function script.StartMoving()
	if boolFilterActive==false then
		boolFilterActive=true
		Signal(SIG_SPAM)
		StartThread(spamFilter)
		
	end
	
	sentry_Kill()
	spamfilterSTOP=false
	spamfilterSTART=true
	
end

function script.StopMoving()
	-- --Spring.Echo ("stopped walking!")
	spamfilterSTART=false
	spamfilterSTOP=true
	
	Turn(sentrynell,x_axis,math.rad(0),3)
	boolSTOP=true
	Signal(SIG_TRACK)
	Signal(SIG_UNDEPLOY)
	Signal(SIG_WALK)
	StartThread(motionTrack)
	
	
end



---------------------------------------------------------------------------------------------------------------------------------------------







function script.StartBuilding(heading,pitch)
	SetUnitValue(COB.INBUILDSTANCE,1)
end

Spring.SetUnitNanoPieces(unitID,{ nanoemit})

function script.StopBuilding()
	SetUnitValue(COB.INBUILDSTANCE,0)
end





function script.Activate()
	boolActive=true
	
	return 1
end

function script.Deactivate()
	boolActive=false
	
	
	return 0
end


function script.Create()
	Turn(flare,y_axis,math.rad(180),0)
	Hide(flare)
	Hide(pivot01)
	Hide(pivot)
	Signal(SIG_SPAM)
end