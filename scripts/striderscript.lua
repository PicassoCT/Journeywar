include "toolKit.lua"

--modified stridercode
--Define the pieces of the weapon
	strider= piece"strider"
	flare1= piece"flare01"
	flare2= piece"flare02"
	striderlegA= piece"striderleg"--2
	striderlegB= piece"striderle1"
	striderlegC= piece"striderle0"
	
	striderlegA2=piece"striderle4"--3
	striderlegB2=piece"striderle2"
	striderlegC2= piece"striderle3"
	
	striderlegA3=piece"striderle7"--1
	striderlegB3=piece"striderle5"
	striderlegC3= piece"striderle6"
	deathpivot= piece"deathpivot"
	
	Sens1=piece"Sens1"
	Sens2=piece"Sens2"
	Sens3=piece"Sens3"
	
	relPos1=piece"relPos1"
	relPos2=piece"relPos2"
	relPos3=piece"relPos3"
	
	center1=piece"center1"
	center2=piece"center2"
	center3=piece"center3"
--define other pieces

	pOrg1 = piece"pOrg1"
	pOrg2 = piece"pOrg2"
	pOrg3 = piece"pOrg3"

	LegOrg1 = piece"LegOrg1"
	LegOrg2 = piece"LegOrg2"
	LegOrg3 = piece"LegOrg3"



local StriTable={
[1]={UpLeg =	striderlegA3,--1
	 Leg   =	striderlegB3,
	 LowLeg=	striderlegC3,
	 UpOrg= pOrg1
	},
[2]={UpLeg =	striderlegA, --2
	 Leg   =	striderlegB,
	 LowLeg=	striderlegC,
	  UpOrg= pOrg2
	},
[3]={UpLeg =	striderlegA2,--3
	 Leg   =	striderlegB2,	
	 LowLeg=	striderlegC2,
	 UpOrg= pOrg3
	}
	}

	
	

LegTable={}
LegTable[#LegTable+1]=piece"striderleg"--2
LegTable[#LegTable+1]=piece"striderle1"
LegTable[#LegTable+1]=piece"striderle0"

LegTable[#LegTable+1]=piece"striderle4"--3
LegTable[#LegTable+1]=piece"striderle2"
LegTable[#LegTable+1]=piece"striderle3"

LegTable[#LegTable+1]=piece"striderle7"--1
LegTable[#LegTable+1]=piece"striderle5"
LegTable[#LegTable+1]=piece"striderle6"

	--You who venture here in hope of awesome source, turn back now,
	--nothing but Goons in drag await you here
	function script.Create()

	Hide(pOrg1)
	Hide(pOrg2)
	Hide(pOrg3)
	Hide(LegOrg1)
	Hide(LegOrg2)
	Hide(LegOrg3)

		for i=1, #LegTable, 1 do
		Turn(LegTable[i],x_axis,math.rad(0),0)
		Turn(LegTable[i],z_axis,math.rad(0),0)
		Turn(LegTable[i],y_axis,math.rad(0),0)
		end
	Hide(flare1) 
	Hide(flare2) 
	Hide(deathpivot) 
	StartThread(relativeTurnFeet)
	StartThread(walkStarter)
	StartThread(resetOrgHeading)
	end

	function lenghtOfVectorSum(vx,vy,vz,tx,ty,tz)
	vx,vy,vz=vx+tx,vy+ty,vz+tz
	return math.sqrt(vx*vx+vy*vy+vz*vz)
	end

	function InInterVal(Low,Val,Max)
	return not( Val< Low or Val > Max)
	end

	MAXDIST=92 --magic number out of upspring
	LOWLEGLENGTH=36
	UPLEGLENGTH=55
	UPLEGSQR=3025
	LEGLENGTH=43
	LEGSQR=6241
	
	counter=0
	function test(piecename, functionname)
	counter=counter+1
	ux,uy,uz=Spring.GetUnitPiecePosDir(unitID,piecename)
	Spring.Echo("JW_STRIDER::PieceCoordTest:"..functionname.."->"..counter.."  ->  "..piecename)
	end


	function stepItUp (x,y,z)
	T=Spring.GetUnitsInCylinder(x,z,7)
	table.remove(T,unitID)
		if T then
			if table.getn(T) > 0 then
				--was zum Geier hab ich hier gecodet
			scaleX, scaleY, scaleZ,offsetX, offsetY, offsetZ,volumeType, testType, primaryAxis, bdisabled=	Spring.GetUnitCollisionVolumeData(unitID)
				if scaleY/2+offsetY < MAXDIST then 
				return y+scaleY/2+offsetY			
				end
			end
		end
	return y
	end

	local P={}
	--this function filters the handed over turnvalues, so they may not leave the rangelimit
	function AnitParkinSons(pie,xt,yt,zt,xp,yp,zp)
		if P[pie]== nil then 
		--       deltaAverage,        previous Turnvalues, previous Position, previous deltaV
		P[pie]={deaX=0,deaY=0,deaZ=0, preX=0,preY=0,preZ=0,oxp=xp,oyp=yp,ozp=zp, dvx=xt, dvy=yt, dvz=zt, nr=0} 
		return xt,yt,zt
		end
	local P= P[Pie]
	--1/2 currentDelta, 1/4 previous Delta, 1/4 Delta of Oldentimes
	cdx,cdy,cdz=P.oxp-xp,P.oyp-yp,P.ozp-zp
	totalTurnX=P.preX+ (0.5*cdx + 0.25*P.dvx+0.25*P.deaX)
	totalTurnY=P.preY+ (0.5*cdy + 0.25*P.dvy+0.25*P.deaY)
	totalTurnZ=P.preZ+ (0.5*cdz + 0.25*P.dvz+0.25*P.deaZ)

	--Update the Table --no more calculations beyond this point
	P.dvx,P.dvy,P.dvz =xp-P.oxp, yp-P.oyp, zp-P.ozp
	P.oxp,P.oyp,P.ozp = xp,yp,zp
	P.deaX= (P.nr/P.nr+1)*P.deaX+ preX*(1/P.nr+1)
	P.deaY= (P.nr/P.nr+1)*P.deaY+ preY*(1/P.nr+1)
	P.deaZ= (P.nr/P.nr+1)*P.deaZ+ preZ*(1/P.nr+1)
	P.preX,P.preY,P.preZ= totalTurnX, totalTurnY, totalTurnZ

	P.nr=P.nr+1

	return totalTurnX, totalTurnY, totalTurnZ
	end

local	boolDEBUG=true
	--this function turns the legs handed over, to point at the x,y,z coordinates
	                       --unitPos   --targetPoint  --UpLeg
				
	function resolveKinematics(x,y,z,  tPx,tPy,tPz, lorgx,lorgy,lorgz, number,targPoint)
 -- StartThread(markPosOnMap,tPx,tPy,tPz,"greenlight")
 -- StartThread( markPosOnMap,lorgx,lorgy,lorgz,"redlight")
	--zero-Vector from the legsocket, to the groundtargPoint

	zvx,zvy,zvz=(tPx-lorgx),tPy-lorgy,(tPz-lorgz)
	BASEDISTANCE=math.sqrt(zvx*zvx + zvy*zvy + zvz*zvz)

	BASEDISTSQR=BASEDISTANCE*BASEDISTANCE
	
	
	ycomp=math.abs(zvy)-LOWLEGLENGTH
	BASELOWLEGDIST=math.sqrt(zvx*zvx+ycomp*ycomp+zvz*zvz)
	
	
	--CinematicExceedsTreshold
		if  (BASEDISTANCE > 122)  then

		--Spring.Echo("StriderScript::LongLegIsTooLong")
		--you are in deep deep trouble --> abort animation there early and get feet inwards asap
		return false
		else
		--Spring.Echo("StriderScript::ResolvoingKinematiks")
		--Turn it y-directionwise
		

		yaw=math.atan2(zvz, zvx)	
		Turn(StriTable[number].UpLeg,y_axis,math.rad(180)-(math.rad(currentHeading)+math.rad(-90)+yaw),5,true)
		
		--first lets get the rad for the upper leg
		 beta=math.acos((LEGSQR-UPLEGSQR-BASEDISTSQR)/(-2*UPLEGLENGTH*BASEDISTANCE))
		 alpha=math.atan2(zvx,zvy)+beta
		 Turn(StriTable[number].UpLeg,x_axis,3.14159 +alpha,0,true)
		 
		-- gama=-3.14159+(1.570796326-beta)+(1.570796326-math.acos((BASELOWLEGDIST*BASELOWLEGDIST+LEGLENGTH*LEGLENGTH-UPLEGLENGTH*UPLEGLENGTH)/(2*LEGLENGTH*BASELOWLEGDIST)))
		 optgama=-beta -(math.acos((BASELOWLEGDIST*BASELOWLEGDIST+LEGLENGTH*LEGLENGTH-UPLEGLENGTH*UPLEGLENGTH)/(2*LEGLENGTH*BASELOWLEGDIST)))
		-- Spring.Echo("JW_STRIDER.."..gama.."  ->"..optgama)
	
		 Turn(StriTable[number].Leg,x_axis,optgama,0,true)
		 
		 Turn(StriTable[number].LowLeg,x_axis,-1*(3.14159 +alpha)-optgama,0,true)
		
		--Turn Leg
		return true
		end
	end
	
	--this function turns the legs handed over, to point at the x,y,z coordinates
	function keepFeetRelative(targPoint,center,sensor, Signal,upLeg, Leg, lowLeg, movX,movY,movZ,number)
	
	SetSignalMask(Signal)
	feetSignals[number]=true

	--Send the piece to the local position it starts from
	Move(targPoint,x_axis,movX,0)
	Move(targPoint,y_axis,movY,0)
	Move(targPoint,z_axis,movZ,0)

	--localisation for speedups
	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	local lresolveKinematics=resolveKinematics
	local spGetUnitVelocity=Spring.GetUnitVelocity
	local spGetUnitPosition=Spring.GetUnitPosition
	local spGetGroundHeight=Spring.GetGroundHeight
	local CinematicsResolveSuccesfull=true
	local lstepitup=stepItUp


	--get the StartPosition of the unit
	local 	sx,sy,sz=spGetUnitPosition(unitID)

	Sleep(10)
		while CinematicsResolveSuccesfull==true do

		
			--grab the currentVelocity of the Unit
			vx,vy,vz,vl=spGetUnitVelocity(unitID)
			vx,vy,vz=(vx)*vl,(vy)*vl,(vz)*vl
			
			--get the current Position of the Unit
			rx,ry,rz=spGetUnitPosition(unitID)
			--get the current Position of the targPoint where the leg should go
			px,py,pz,_,_,_=spGetUnitPiecePosDir(unitID,targPoint)
			
			--computate the relative grounddistance to Unitbase
			gd=(spGetGroundHeight(px,py)-ry)*-1

			--how far the Unit has moved away from the StartPosition
			tx,ty,tz=(rx-sx),(ry-sy),(rz-sz)
			         			
			--current Heading difference in deg
			deg=(orgHeading-currentHeading)	
				
			-- we turn the MoveVector by 
			tx,tz=NDrehMatrix(tx,tz,math.rad(currentHeading+deg)) --rad
			
			
			--Velocity comes as elmos per frame	
			--here we calculate wether a hitsphere is beneath the foot
			gd=lstepitup(tx,gd,tz)
			
			--finall
			Move(targPoint,z_axis,tz*-1,vz*30)
			--Move(targPoint,y_axis,gd,vy*30)
			Move(targPoint,x_axis,tx*-1,vx*30)		 
			-- res=(orgHeading- currentHeading)*-1
		
			--lebgbase pos
			ulbx,ulby,ulbz	=spGetUnitPiecePosDir(unitID,StriTable[number].UpOrg)
			tx,ty,tz		=spGetUnitPiecePosDir(unitID,targPoint)
			--to succesfully resolve cinematics we need the units position, the base pieces position and the upLegsPosition												
			CinematicsResolveSuccesfull=lresolveKinematics(rx,ry,rz, tx,ty,tz, ulbx,ulby,ulbz,number, targPoint)
			Sleep(10)
			end
			Spring.Echo("JW_STRIDER:KinematikLimitReached")
	

	end


	local SIG_WALK = 1	--signal for the walk animation thread
	local SIG_AIM = 2  --signal for the weapon aiming thread
	 SIG_F1 = 4 
	 SIG_F2 = 8
	 SIG_F3 = 16
	local SIG_ORG = 32

	function headToDeg(head)
	if head < 0 then return 360+(head/182.4) end
	return head/182.4
	end


	feetSignals={[1]=false,[2]=false,[3]=false}

	--Function to keep the feet turn-wise relative to the ground
	orgHeading=headToDeg(Spring.GetUnitHeading(unitID))
	currentHeading=headToDeg(Spring.GetUnitHeading(unitID))
     diffdance=0

	function relativeTurnFeet()
	 local lfeet={[1]={center=center1},[2]={center=center2},[3]={center=center3}}
	 local Pos={[1]=relPos1,[2]=relPos2,[3]=relPos3}
	 
	 local LikeWarmApplePi=math.pi/2
	 local spGetUnitHeading=Spring.GetUnitHeading
	 local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	 local spGetGroundHeight=Spring.GetGroundHeight
	 local count=0
	 local min=9000	 
	 local lheadToDeg=headToDeg
	 local gravity=Game.gravity/2


			while true do

				for i=1,3, 1 do
				if  feetSignals[i]==true then
					
					currentHeading=lheadToDeg(spGetUnitHeading(unitID))				
					diffdance=0

					if currentHeading < orgHeading + 180 and currentHeading > orgHeading  then
					diffdance=(currentHeading-orgHeading)*-1
					else
						if currentHeading < orgHeading then
						diffdance=(orgHeading-currentHeading)
							else
							diffdance= ((orgHeading+360)-currentHeading)
							end
					end
					 --Spring.Echo("StriderScript::Org->"..orgHeading.. "  Cur->"..currentHeading.."  Dif->"..diffdance) 
					Turn(lfeet[i].center,y_axis, math.rad(diffdance),0,true)
				end
				end
				Sleep(10)
				
				--the Stridercenter has to be kept relative to the ground
				count=((count+10)%100)
				if count%100==0 then
				x,baseheight,z,_,_,_=spGetUnitPiecePosDir(unitID,deathpivot)
				min=spGetGroundHeight(x,z)
					
					for i=1,#lfeet,1 do
					x,y,z,_,_,_=spGetUnitPiecePosDir(unitID,Pos[i])
					h=spGetGroundHeight(x,z)
					if h and h < min then min = h end
					end
				
				diffy=((baseheight-min)*-1) -34
				Move(strider,y_axis,diffy,gravity)
				end
			end
			
			
		end

	function walkStarter()
		while true do
			if boolWalkStart==true then
			boolWalkStart=false
			Signal(SIG_WALK)
			StartThread(walk)	
			end
		Sleep(50)
		end
	end

	

	---WALKING---
	function deactiveAnim(number,signal)
	Signal(signal)
	feetSignals[number]=false
	--swing and bring foot forward
	Turn(StriTable[number].UpOrg,y_axis,0,15)
	Turn(StriTable[number].UpOrg,z_axis,0,15)
	Turn(StriTable[number].UpOrg,x_axis,-33,15)
	Turn(StriTable[number].Leg,y_axis,0,15)
	Turn(StriTable[number].Leg,z_axis,0,15)
	Turn(StriTable[number].Leg,x_axis,33,15)
	end
	 function walk()
		local ldeaAnim=deactiveAnim
		SetSignalMask(SIG_WALK)
		
		--	test(StriTable[number].Leg,"371,walk")
		--Monotonous DeebugWalk
		while true do		
		StartThread(keepFeetRelative,relPos1,center1,Sens1, SIG_F1,striderlegA3, striderlegB3, striderlegC3,0,0,-10	,1)
		Sleep(1700)
--		StartThread(keepFeetRelative,relPos3,center3,Sens3, SIG_F3,striderlegA2, striderlegB2, striderlegC2,-26,0,60		,3)
		--StartThread(keepFeetRelative,relPos2,center2,Sens2, SIG_F2,striderlegA, striderlegB, striderlegC,26,0,60		,2)
		Sleep(1300)	
		ldeaAnim(1,SIG_F1)
		--StartThread(keepFeetRelative,relPos1,center1,Sens1, SIG_F1,striderlegA3, striderlegB3, striderlegC3,0,0,-10	,1)
		Sleep(2300)	
		ldeaAnim(2,SIG_F2)
		ldeaAnim(3,SIG_F3)
		end
		
			while (true) do

			 --left leg front
			feetSignals[3]=true
			Sleep(20)
			StartThread(keepFeetRelative,relPos3,center3,Sens3, SIG_F3,striderlegA2, striderlegB2, striderlegC2,-15,0,0)
				Sleep(1000)	

				feetSignals[2]=false
				resPos(relPos2,center2,3)	
				Signal(SIG_F2)	
			feetSignals[1]=true
			Sleep(20)
			StartThread(keepFeetRelative,relPos1,center1,Sens1, SIG_F1,striderlegA3, striderlegB3, striderlegC3,-15,0,0)
				Sleep(1000)	
				feetSignals[3]=false
				resPos(relPos3,center3,3)
				Signal(SIG_F3)
			feetSignals[2]=true
			Sleep(20)
			StartThread(keepFeetRelative,relPos2,center2,Sens2, SIG_F2,striderlegA, striderlegB, striderlegC,-15,0,15)
				Sleep(1000)
				feetSignals[1]=false		
				resPos(relPos1,center1,3)		
				Signal(SIG_F1)
			end
	end

	function resPos(piece,center,speed)
	Turn(center,x_axis,0,speed or 0)
	Turn(center,y_axis,0,speed or 0)
	Turn(center,z_axis,0,speed or 0)
	Move(piece,x_axis,0,speed or 0,true)
	Move(piece,y_axis,0,speed or 0,true)
	Move(piece,z_axis,0,speed or 0,true)
	end

	local function legs_down ( WaitForIt)
			resPos(relPos1,center1,5)		
			resPos(relPos2,center2,5)		
			resPos(relPos3,center3,5)		
	Turn(striderlegA2,x_axis,math.rad(0),2)
	Turn(striderlegA2,y_axis,math.rad(0),2)
	Turn(striderlegA2,z_axis,math.rad(0),2)
	Turn(striderlegB2,x_axis,math.rad(0),2)
	Turn(striderlegB2,y_axis,math.rad(0),2)
	Turn(striderlegB2,z_axis,math.rad(0),2)
	Turn(striderlegC2,x_axis,math.rad(0),2)
	Turn(striderlegC2,y_axis,math.rad(0),2)
	Turn(striderlegC2,z_axis,math.rad(0),2)
	Turn(striderlegA ,x_axis,math.rad(0),2)
	Turn(striderlegA ,y_axis,math.rad(0),2)
	Turn(striderlegA ,z_axis,math.rad(0),2)
	Turn(striderlegB ,x_axis,math.rad(0),2)
	Turn(striderlegB ,y_axis,math.rad(0),2)
	Turn(striderlegB ,z_axis,math.rad(0),2)
	Turn(striderlegC ,x_axis,math.rad(0),2)
	Turn(striderlegC ,y_axis,math.rad(0),2)
	Turn(striderlegC ,z_axis,math.rad(0),2)
	Turn(striderlegA3,x_axis,math.rad(0),2)
	Turn(striderlegA3,y_axis,math.rad(0),2)
	Turn(striderlegA3,z_axis,math.rad(0),2)
	Turn(striderlegB3,x_axis,math.rad(0),2)
	Turn(striderlegB3,y_axis,math.rad(0),2)
	Turn(striderlegB3,z_axis,math.rad(0),2)
	Turn(striderlegC3,x_axis,math.rad(0),2)
	Turn(striderlegC3,y_axis,math.rad(0),2)
	Turn(striderlegC3,z_axis,math.rad(0),2)
		if WaitForIt == true then
		Sleep(150)
		WaitForTurn(striderlegA2,x_axis)
		WaitForTurn(striderlegA2,y_axis)
		WaitForTurn(striderlegA2,z_axis)
		WaitForTurn(striderlegB2,x_axis)
		WaitForTurn(striderlegB2,y_axis)
		WaitForTurn(striderlegB2,z_axis)
		WaitForTurn(striderlegC2,x_axis)
		WaitForTurn(striderlegC2,y_axis)
		WaitForTurn(striderlegC2,z_axis)
		WaitForTurn(striderlegA ,x_axis)
		WaitForTurn(striderlegA ,y_axis)
		WaitForTurn(striderlegA ,z_axis)
		WaitForTurn(striderlegB ,x_axis)
		WaitForTurn(striderlegB ,y_axis)
		WaitForTurn(striderlegB ,z_axis)
		WaitForTurn(striderlegC ,x_axis)
		WaitForTurn(striderlegC ,y_axis)
		WaitForTurn(striderlegC ,z_axis)
		WaitForTurn(striderlegA3,x_axis)
		WaitForTurn(striderlegA3,y_axis)
		WaitForTurn(striderlegA3,z_axis)
		WaitForTurn(striderlegB3,x_axis) 
		WaitForTurn(striderlegB3,y_axis) 
		WaitForTurn(striderlegB3,z_axis) 
		WaitForTurn(striderlegC3,x_axis)
		WaitForTurn(striderlegC3,y_axis) 
		WaitForTurn(striderlegC3,z_axis)
		end
	end

	function resetOrgHeading()
	Sleep(500)
	orgHeading=headToDeg(Spring.GetUnitHeading(unitID))

	while true do
		torqheading=orgHeading
			--if the strider turns this way or that way, we update only once in a while 
			while (math.abs(torqheading-headToDeg(Spring.GetUnitHeading(unitID)))> 5 ) do 
			orgHeading=headToDeg(Spring.GetUnitHeading(unitID))
			torqheading= orgHeading
			Sleep(2000)		
			end

			--he is on its way turning slightly
			while (math.abs(torqheading-headToDeg(Spring.GetUnitHeading(unitID)))<= 5 ) do 
			orgHeading=headToDeg(Spring.GetUnitHeading(unitID))
			torqheading= orgHeading
			Sleep(1200)		
			end
		Sleep(1500)	
		orgHeading=headToDeg(Spring.GetUnitHeading(unitID))
		
		end

	end	


	function script.StartMoving()
		Spring.Echo ("starting to walk!")
		Signal(SIG_ORG)
		boolWalkStart=true
	end

	function script.StopMoving()
			Spring.Echo ("stopped walking!")
			Signal(SIG_WALK)
			Signal(SIG_F1)
			Signal(SIG_F2)
			Signal(SIG_F3)
			legs_down (false)
	end

	----aimining & fire weapon
	function script.AimFromWeapon1() 
		return flare1 
	end

	function script.QueryWeapon1() 
		return flare1
	end

	function script.AimWeapon1( heading ,pitch)	
		--aiming animation: instantly turn the gun towards the enemy
		Signal(SIG_AIM)
		SetSignalMask(SIG_AIM)

		Turn(flare1, y_axis, heading)
		Turn(flare1, x_axis, -pitch)
		
		return true
	end

	function script.FireWeapon1()	
		return true
	end

	----aimining & fire weapon 2
	function WarpCanonStance()
		Move(strider,y_axis,-13,30)
		Turn(striderlegA,z_axis,math.rad(35),1)
		Turn(striderlegB,z_axis,math.rad(-35),3)
		Turn(striderlegA2,z_axis,math.rad(-36),1)
		Turn(striderlegB2,z_axis,math.rad(48),2)
		Turn(striderlegA3,x_axis,math.rad(33),1)
		Turn(striderlegB3,x_axis,math.rad(-39),3)
		WaitForTurn(striderlegA,z_axis)     
		WaitForTurn(striderlegB,z_axis)     
		WaitForTurn(striderlegA2,z_axis)     
		WaitForTurn(striderlegB2,z_axis)    
		WaitForTurn(striderlegA3,x_axis)    
		WaitForTurn(striderlegB3,x_axis)    
		WaitForMove(strider,y_axis)
		
		end

	function script.AimFromWeapon2() 
		return strider 
	end

	function script.QueryWeapon2() 
		return flare2
	end

	function script.AimWeapon2( heading ,pitch)	
		--Signal(SIG_AIM)
		--SetSignalMask(SIG_AIM)
		
		--aiming animation: instantly turn the gun towards the enemy
		 Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 1)

		Turn(flare2, y_axis, heading, 25)
		WaitForTurn(flare2,y_axis)


		
		return true
	end

	function script.FireWeapon2()	
		WarpCanonStance()
		Sleep(450)
		Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 0)
		return true
	end

	function script.Killed()
	Turn(deathpivot,x_axis,math.rad(8),2)

	Turn(deathpivot,y_axis,math.rad(15),2)

	Turn(deathpivot,x_axis,math.rad(-9),3)
	WaitForTurn(deathpivot,x_axis)
	Turn(deathpivot,x_axis,math.rad(-25),2)
	WaitForTurn(deathpivot,x_axis)
	Turn(deathpivot,x_axis,math.rad(-83),1)

	Turn(striderlegA3,x_axis,math.rad(-12),2)
	Sleep(50)
	Turn(striderlegB3,x_axis,math.rad(13),2)
	WaitForTurn(deathpivot,x_axis)
	WaitForTurn(striderlegB3,x_axis)
	WaitForTurn(striderlegA3,x_axis)
	WaitForTurn(deathpivot,y_axis)
	WaitForTurn(deathpivot,x_axis)
	--

	Turn(striderlegA,z_axis,math.rad(-10),5)
	Turn(striderlegB,y_axis,math.rad(8),2)
	Turn(striderlegB,z_axis,math.rad(28),2)
	Turn(striderlegA2,x_axis,math.rad(8),2)
	Turn(striderlegA2,z_axis,math.rad(-11),2)
	Turn(striderlegB2,z_axis,math.rad(28),3)
	Turn(striderlegB2,y_axis,math.rad(-26),4)
	WaitForTurn(striderlegA,z_axis)
	WaitForTurn(striderlegB,y_axis)
	WaitForTurn(striderlegA2,y_axis)
	WaitForTurn(striderlegA2,x_axis)
	WaitForTurn(striderlegB,z_axis)


	WaitForTurn(striderlegB2,y_axis)

	WaitForTurn(striderlegB2,z_axis)


	Sleep(2047)

	Explode ( striderlegA, SFX.FALL +SFX.NO_HEATCLOUD)
	Explode ( striderlegB, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegC, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegA2, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegB2, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegC2, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegA3, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegB3, SFX.FALL+SFX.NO_HEATCLOUD)
	Explode ( striderlegC3, SFX.FALL+SFX.NO_HEATCLOUD)
		
	Explode (strider, SFX.FALL+SFX.FIRE)
		----Spring.Echo ("He is dead, Jim!")
	end
