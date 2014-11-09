	include "suddenDeath.lua"
	include "toolKit.lua"

	  turret = piece "sstowgab"
	  turret2= piece "sstower"
	  flare = piece "sscflare"
	--define other pieces
	  sstowf = piece "sstowf"
	  sstowf2 = piece "sstowf2"
	  csniper = piece "csniper"
	  cwheel1 = piece "sswheel"
	  cwheel2 = piece "sswheel2"
	  cwheel3 = piece "sswheel3"
	  cwheel3 = piece "sswheel4"
	  ssharpoon = piece "ssharpoon"
	  overfloor=3
	piecelenght=15.4
	nrOfPieces=12
	baseDistanceToFirstPiece=50
	  totalDistanceToEndPiece=((piecelenght-1)*nrOfPieces) --+baseDistanceToFirstPiece - 20
	  boolFreeHanging= false
	  ropeSpeed=0
	  SIG_UNFOLD=8
	  SIG_FOLD=4
	  SIG_AIM=2
	  SIG_SPAM=16
	  SIG_SCOPE=32
	  SIG_LAS=64
	  SIG_ROPE=128
	  SIG_TURNER=256

	local boolStillAiming=false
	  boolFireLock=false
	  spamfilterSTART=true
	  spamfilterSTOP=false
	local tempIdle=1
	local boolFilterActive=false
	local spotOnTarget=false
	local boolHaveAbreak=false
	local boolTargetInScope=false
	local boolEmit=true
	local harpoonupmyass= piece"harpoonupmyass"
	local bloodemt= piece"bloodemt"
	local emitblood= piece"emitblood"
	local pm1= piece"pm1"
	local pm2= piece"pm2"
	local maxSpeed=math.ceil( 2.5 *65533)

	local AttachUnit = Spring.UnitScript.AttachUnit
	local DropUnit = Spring.UnitScript.DropUnit
	local loaded=false
	local ropestarts={}
	local sensors={}
	local rope={}
	for i=1,12,1 do
	ropestarts[i]={}
	rope[i]={}
	sensors[i]={}
	doop="rs"..i
	temp="sensor"..i
	aNewRope="rope0"..i
	sensors[i]=piece(temp)
	ropestarts[i]=piece(doop)
	rope[i]=piece(aNewRope)
	end
	local pi=3.14159

	function controllTurn(passengerID)
	SetSignalMask(SIG_TURNER)
	local spGetUnitDirection=Spring.GetUnitDirection
	local spSetUnitDirection=Spring.SetUnitDirection

		while(true) do
			if(spamfilterSTART==true and stillInRange()==false) then
			dix,diy,diz=spGetUnitDirection(unitID)
			pix,piy,piz=spGetUnitDirection(passengerID)
			rix=(3*pix+1*dix)/4
			riz=(3*piz+1*diz)/4
			rest=math.random(500,1000)
			Sleep(rest)
			spSetUnitDirection( passengerID, rix, piy, riz )
			else
			Sleep(500)
			end
		end

	end

	function setSpeed(tempDefID)

	local tspeed=math.floor(2.0*65533)
		if isInfantry(tempDefID)==true then 
		SetUnitValue(COB.MAX_SPEED,tspeed)
		return
		 end

	local medSpeed=math.floor(1.4*65533)
	if tempDefID==UnitDefNames["gjmedbiogwaste"].id or tempDefID == UnitDefNames["gcvehiccorpsemini"].id then 
	SetUnitValue(COB.MAX_SPEED,medSpeed)
		return
		 end

	local slowSpeed=math.floor(0.5*65533)
	if tempDefID == UnitDefNames["gjbigbiowaste"].id or tempDefID == UnitDefNames["gcvehiccorpse"].id then
	SetUnitValue(COB.MAX_SPEED,slowSpeed)
		return
		 end
		 
	SetUnitValue(COB.MAX_SPEED,maxSpeed)

	end

	function reSetSpeed()
			SetUnitValue(COB.MAX_SPEED,maxSpeed)

	end

	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	function acquireVehicleDegree()
	 ax,ay,az,_,_,_=spGetUnitPiecePosDir(unitID,pm1)
	 bx,by,bz,_,_,_=spGetUnitPiecePosDir(unitID,pm2)
	--deg=math.atan2(by-ay,math.sqrt(((bz-az)^2)+((ay-by)^2)))*(180/pi)

	-- dx,dy,dz=Spring.GetUnitDirection(unitID)
	opposite=ay-by

	   local ax=ax-bx
	   local az = az - bz
	   
	   local len = math.sqrt( ax*ax +az * az)
			
			
	deg=math.floor(math.atan2(opposite, len)*(180/pi))
	--Spring.Echo("acquireVehicleDegree",deg)

	return deg
	end

	function isInfantry(passengerDefID)

		if passengerDefID== UnitDefNames["bg"].id or passengerDefID== UnitDefNames["tiglil"].id or passengerDefID== UnitDefNames["skinfantry"].id or passengerDefID== UnitDefNames["vort"].id then
		return true
			else
			return false
			end
	end

	function draggingOn()
	local spPlaySoundFile=Spring.PlaySoundFile
		while(true) do
		wdice=math.random(0,2)
			if wdice==1 then
			spPlaySoundFile("sounds/csniper/drag3sec.wav",0.8)  
			Sleep(3000)
			spPlaySoundFile("sounds/csniper/drag6sec.wav",0.8)  
			Sleep(6000)
				elseif wdice== 0 then
				spPlaySoundFile("sounds/csniper/drag3sec.wav",0.8)  
				spPlaySoundFile("sounds/csniper/drag6sec.wav",0.8)  
				Sleep(4600)
					else
					randsleep=math.random(4000,9000)
					Sleep(randsleep)
					end
		end
	end

	local spEmitSfx=EmitSfx
	function dustEmit(boolIsABioUnit)
		if boolIsABioUnit==true then
		Spring.PlaySoundFile("sounds/csniper/harpimpflesh.wav")  
		Sleep(150)
			for i=1, 22, 1 do
			spEmitSfx(emitblood,1025)
			nap=i*4+10
			Sleep(nap)
			end
		else
		Spring.PlaySoundFile("sounds/csniper/harpimpmetallr.wav")  
		end
local lEmitSfx=EmitSfx
local spCreateUnit=Spring.CreateUnit
		while(true) do
			if boolIsABioUnit==true then
			dice=math.random(0,1)
				if dice==1 then 
				throw=math.random(4,12)
					for i=1,throw,1 do
					lEmitSfx(emitblood,1025) 
					lEmitSfx(emitblood,1025) 
					Sleep(98)
					Sleep(throw)
					end
							else 
							throw=math.random(4,12)
								for i=1,throw,1 do
								lEmitSfx(emitblood,1025) 
								lEmitSfx(emitblood,1025) 
								Sleep(98)
								Sleep(throw)
								end
							x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID, emitblood)
							teamID=Spring.GetGaiaTeamID()
							spCreateUnit("blooddecalfactory",x,y,z,0,teamID)
							end

			else
				throw=math.random(4,12)
				for i=1,throw,1 do
				lEmitSfx(emitblood,1026) 
				Sleep(throw)
				Sleep(throw)
				lEmitSfx(emitblood,1026) 
				Sleep(98)
				end

			end
		nap=math.random(30,200)
		Sleep(nap)
		end
	end

	function setIntervallStraight(intStart,intEnd,degree)

	temp=0
	if intStart== 1 then
	nPrevDegTable[12]= acquireVehicleDegree() + degree
	temp=nPrevDegTable[12]
		else
		nPrevDegTable[13-intStart]=-1* nPrevDegTable[14-intStart]+degree
		temp=nPrevDegTable[13-intStart]
		end
			if intStart == intEnd then 
			Turn(rope[13-intStart],x_axis,math.rad(degree),ropeSpeed)		
			return false
			end
				
				
			Turn(rope[13-intStart],x_axis,math.rad(nPrevDegTable[13-intStart]),ropeSpeed)
		
			
			--set the remains of the rope straight -- checking if there is a rest
			if  intStart+1 >= intEnd or intStart+1==13 then 
			return false
			else
			
				for i=intStart+1,intEnd,1 do	
				--assert(	nPrevDegTable[13-i])
				----Spring.Echo(	nPrevDegTable[13-i])
				----Spring.Echo(i .." and thirteen minus ",13-i)
		
				nPrevDegTable[13-i]=temp
				Turn(rope[13-i],x_axis,math.rad(0),ropeSpeed)
				nPrevDegTable[13-i]=temp
				end
			end
		--now wee need the summed up previous degrees 
			
		return true
	end


	function Neg(val)
	if val<=0 then return val end
	return val*-1
	end

	function acquireRopeDegree(i)

	if i ==1 then			
							ax,ay,az,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[12])
							ay=(Spring.GetGroundHeight(ax,az))+overfloor
							bx,by,bz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[12])
							
						--local 	cy=Spring.GetGroundHeight(bx,bz)
							local opposite=by-ay 
					
							 ax=bx-ax
							 az =  bz-az
							local len = math.sqrt( ax*ax +az * az)
							--Spring.Echo("Length which should always be 13",len)
							djego=math.floor(math.atan2(opposite, len)*(180/pi))
				
							if opposite < 0 then return unNeg(djego) else return Neg(djego) end
	-------------------------------------------------------------------------------------------------------------------------------------
									else
									ax,ay,az,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[13-i])--
									ay=(Spring.GetGroundHeight(ax,az))+overfloor
									--Spring.Echo("Sensor: ", 13-i .."  	has Position X:", ax, " Position Z:", az)
									--local 	ay=heightTable[13-i] --Spring.GetGroundHeight(ax,az)
									bx,by,bz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[13-i])
									
									--Spring.Echo("RopePivotr: ", 13-i .."  	has Position X:", bx, " Position Z:", bz)
									local opposite=by-ay +overfloor
									if opposite >-1 and opposite  < 1 then return 0 end
									local hax=ax-bx
									local haz = az - bz

									local len = math.sqrt( hax*hax +haz * haz+ opposite*opposite)
										   --Spring.Echo("Length which should always be 13",len)
									len=15.4
							
									adeg=math.floor(math.atan2(opposite, len)*(180/pi))
													
									if opposite <= 0 then return unNeg(adeg) else return Neg(adeg) end
										
									end
	end

	--delMe
	function sensorBlink()
	-- for i=1,7,1 do
	-- for i=1,table.getn(sensors),1 do
	-- EmitSfx(sensors[13-i],1027)
	-- EmitSfx(sensors[13-i],1027)
	-- Sleep(60)
	-- end
	-- end
	end
	--/delMe
	function echoNPreveDegTable()
	for i=1,table.getn(nPrevDegTable),1 do
	--Spring.Echo("Piece Nr:",13-i.. " has ",nPrevDegTable[13-i])

	end
	end



	function setIntervallSmooth(intStart,intEnd)
				if intStart== intEnd then return false end
				--set the SensorPhalanx at a right angle over the crowd		
				avd=acquireVehicleDegree()
				Turn(sensors[12],x_axis,math.rad(avd),ropeSpeed)	
				Turn(ropestarts[12],x_axis,math.rad(avd),ropeSpeed)	
				--sensorBlink()
				--updateHeights()
						
						for i=intStart,intEnd,1 do	

						
						resultDeg=0
						tarDegree=(acquireRopeDegree(i))
							--StandardCase
							if i~=1 then
					
					
							resultDeg=math.floor(-1*nPrevDegTable[13+1-i] + (tarDegree)) --bachelors rope by now
							nPrevDegTable[13-i]=resultDeg
							-- --Spring.Echo("Element: ",13-i.." has forerunner Degree: ", nPrevDegTable[13-i+1] .."and rope-degree is ", tarDegree.." resulting in ",resultDeg )
							
								else --start intervall clause 
						
								resultDeg=math.floor(avd + tarDegree)
								--Spring.Echo("FirstPiece",resultDeg)
								resultDeg=avd-15
								nPrevDegTable[12]=resultDeg
								end
								
								
						
						--Result Stage
						

						Turn(rope[13-i],x_axis,math.rad(resultDeg),ropeSpeed)
			
							
				
					
						end
				--	echoNPreveDegTable()
	return true 
	end

	function findMaxInIntervall(intStart,intEnd,tableToCheck)
		if intStart == intEnd then
		return nil
		end

	maximum=-9000000
	nr=nil
			for i=intStart,intEnd,1 do
				if tableToCheck[13-i] > maximum then
				
				maximum=tableToCheck[13-i]
				nr=13-i
				end
			end
					if nr~=nil then
					return maximum, nr
					end

	end

	function unNeg(val)
	if val >= 0 then return val end
	return val*-1
	end

	function clamp(val)
		if val <= 1 then 
		return 1 
		end
			if val >= 12 then 
			return 12 
			
			else 
			return val 
			end
	end
	--deprecated
	function sumDegree(startv,endv)
	if startv==endv then return nPrevDegTable[13-starv] end

	degSum=0


		--Spring.Echo(startv)
		--Spring.Echo(endv)



		for i=startv,endv,1 do
		
			if nPrevDegTable[13-i]~= nil then
			degSum=degSum+nPrevDegTable[13-i]
			end
			
		end
		--Spring.Echo("DegSum",degSum)
	return degSum
	end

	--function: determinates the degree a piece needs to have
	function detDegree(preInterVallStart,interVallStart,interVallEnd)
	if preInterVallStart== interVallStart or interVallStart== interVallEnd then return -1*nPrevDegTable[13-interVallStart] end
		if interVallStart~=1 then
		local	distance=((interVallEnd-interVallStart))*15.4
			sx,sy,sz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[13-interVallStart])
			--sy=Spring.GetGroundHeight(sx,sz)
			ex,ey,ez,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[13-interVallEnd])
			groundheight=Spring.GetGroundHeight(ex,ez)
		local	opposite=sy-groundheight
			--Sum of All Previous Degrees -negated, so that whatever we turn is relative zero.

			-- nPrevDegTable[13-interVallStart]=reSlut
			reSlut= -1*	nPrevDegTable[13-interVallStart+1] + (math.atan2(opposite,distance)*(180/pi))
		
			return reSlut
		else
			
		local	distance=((interVallEnd-interVallStart))*15.4
			--Spring.Echo("distance",distance)
			sx,sy,sz,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[12])
			sy=Spring.GetGroundHeight(sx,sz)
			ex,ey,ez,_,_,_=Spring.GetUnitPiecePosDir(unitID,sensors[13-interVallEnd])
			groundheight=Spring.GetGroundHeight(ex,ez)
		local	opposite=sy-groundheight
			--Sum of All Previous Degrees -negated, so that whatever we turn is relative zero.
			reSlut= acquireVehicleDegree() + (math.atan2(opposite,distance)*(180/pi))
			-- nPrevDegTable[13-interVallStart]=reSlut
			return reSlut
		end
	end

	tempVar=1
	function updateHeights()

	for i=1, table.getn(heightTable),1 do
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,ropestarts[13-i])
	heightTable[13-i]={}
	heightTable[13-i]=Spring.GetGroundHeight(x,z)
	 end

	 x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,bloodemt)
	if heightTable[1] <= y-10 then boolFreeHanging=true else boolFreeHanging =false end

	-- --lets smooth it out
	-- for i=2, table.getn(heightTable)-1,1 do
	-- heightTable[13-i]=math.floor((4*heightTable[13-i]+heightTable[13-(i+1)] +heightTable[13-i+1])/6)
	-- end

	end


	 heightTable={}
	 nPrevDegTable={}



	function relativeRestingRope()
	Sleep(50)
	end

	--function estimate
	function stillInRange()
	--210, value of the pieces lenght (13 mal anzahl der pieces 12 +50 zur base vom sniper)
	--if no collisions detected,then
	px,py,pz,_,_,_=Spring.GetUnitPiecePosDir(unitID,bloodemt)
	x,y,z=Spring.GetUnitBasePosition(unitID)
	distance=math.sqrt((px-x)^2 +(pz-z)^2)
	return false end

	-- if distance > totalDistanceToEndPiece then 
	-- return false
		-- else
		-- return true
		-- end

	-- end
	function tableInit()
	for i=1,12,1 do
	heightTable[i]={}
	heightTable[i]=0
	nPrevDegTable[i]={}
	nPrevDegTable[i]=0
	end

	end
	--updates the ropephysicks, start a particle emit Thread dependent upon the type
	
	    -- local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
        -- local px2, py2, pz2 = Spring.GetUnitBasePosition(passengerID)
        -- local dx, dy , dz = px2 - px1, py2 - py1, pz2 - pz1
        -- local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID))/32768*math.pi
        -- local dist = (dx^2 + dz^2)^0.5
       
        -- Turn(load_shoulder, y_axis, heading)
        -- Move(load_shoulder, y_axis, dy)
        -- Move(load_arm, z_axis, dist)
	function checkSnipers()
	local snipersTotal=  GG.GlobalSniperRopeSimTable.Ids
	local boolAltered=false
		for i=1,#snipersTotal, 1 do
			if snipersTotal[i] then
				if Spring.GetUnitIsDead(snipersTotal[i]) ==true then
				table.remove(snipersTotal,snipersTotal[i])
				i=math.max(1,i-1)	
				boolAltered=true
				end
			end
		end
	GG.GlobalSniperRopeSimTable.number=#snipersTotal
	GG.GlobalSniperRopeSimTable.Ids=snipersTotal
	return boolAltered
	end
	
	function ourOnlyRope(passengerID)
	--tableInit()
	--Spring.Echo("Script did it!")
	SetSignalMask(SIG_ROPE)
	local 	passengerDefID=Spring.GetUnitDefID(passengerID)
	
	
		boolBioUnit=false
			if isInfantry(passengerDefID)==true or  passengerDefID == UnitDefNames["gjbigbiowaste"].id or passengerDefID == UnitDefNames["gjmedbiogwaste"].id then
			boolBioUnit=true
			end
		Turn(bloodemt,y_axis,math.rad(-90),0.03)
		StartThread(dustEmit,boolBioUnit)
		StartThread(draggingOn)
			if not GG.SniperRope then GG.SniperRope={} end
		GG.SniperRope[unitID]=true
		
		--To limit the usage of ropePhysix a alternative  is needed aka pulling the object near the sniper and thats it..
			if not GG.GlobalSniperRopeSimTable then GG.GlobalSniperRopeSimTable={number = 0, Ids={}} end
		
			if GG.GlobalSniperRopeSimTable.number < 5 or checkSnipers()==true then
		
		GG.GlobalSniperRopeSimTable.number=GG.GlobalSniperRopeSimTable.number+1
		table.insert(GG.GlobalSniperRopeSimTable.Ids,unitID)
		-- This code is a adapted Version of the NeHe-Rope Tutorial. All Respect towards those guys.
-- RopePieceTable by Convention contains (SegmentBegin)----(SegmentEnd)(SegmentBegin)----(SegmentEnd) 
-- RopeConnectionPiece -->Piece,ContainsMass,ColRadius |
-- LoadPiece --> Piece,Contains Mass, ColRadius | 
-- ForceFunction --> forceHead(objX,objY,objZ,worldX,worldY,worldZ,objectname,mass)

										 
--function PseudoRopePhysix(RopePieceTable,RopeConnectionT,LoadPieceT, Ropelength, forceFunctionTable,SpringConstant)
		forceFunctionTable={
							[1]={	acceleration		=	{x=0,y=-9.81,z=0}, 
									geometryfunction	=	function(x,y,z) return true end
								}
							}
		Ropelength=20
		LoadPieceT={Piece=bloodemt, Mass=9000, ColRadius=42}
		RopeConnectionT={Piece=csniper, Mass=9000, ColRadius=42}
		RopePieceTable={}
		
			for i=1,12,1 do
			RopePieceTable[#RopePieceTable+1]=rope[i]
			RopePieceTable[#RopePieceTable+1]=sensors[i]		
			end
		StartThread(PseudoRopePhysix,RopePieceTable,RopeConnectionT,LoadPieceT, Ropelength,forceFunctionTable ,100000.0)

	
		else -- not RopeSimAlternative
		
		end
		
			while(loaded==true) do
			Sleep(50)
			end
			
		GG.SniperRope[unitID]=false
		Turn(bloodemt,y_axis,math.rad(0),0)

	end


	
	local transportedID=nil
	function script.TransportPickup(passengerID)
	--Spring.Echo("TransportPickup")
	local UnitedDefIDs=Spring.GetUnitDefID(passengerID)
		if loaded == false and (UnitedDefIDs == UnitDefNames["gjbigbiowaste"].id or UnitedDefIDs == UnitDefNames["gjmedbiogwaste"].id or  UnitedDefIDs == UnitDefNames["gcvehiccorpse"].id or  UnitedDefIDs == UnitDefNames["gcvehiccorpsemini"].id or isInfantry(UnitedDefIDs)==true) then
																											   
			SetUnitValue(COB.BUSY, 1)
			
			
			
			local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
			local px2, py2, pz2 = Spring.GetUnitBasePosition(passengerID)
			local dx, dy , dz = px2 - px1, py2 - py1, pz2 - pz1
			local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID))/32768*math.pi
			local dist = (dx^2 + dy^2)^0.5
		


			if dist > 200 then return end
			Turn(csniper,y_axis,heading-(32768/2),12) -- () --  (heading - 8192)*-1 | (-heading+(32768/2))
			WaitForTurn(csniper,y_axis)
			expandRope()
			transportedID=passengerID
			AttachUnit(bloodemt, passengerID)
			loaded=true
	
			StartThread(ourOnlyRope,passengerID)
		



			Turn(csniper, y_axis, math.rad(0),19)
		
			SetUnitValue(COB.BUSY, 0)
		else		
		retractRope()
		end
		
	end


	function script.TransportDrop(passengerID, x, y, z)
	Signal(SIG_ROPE)
	--Spring.Echo("TransportDrop")

		if loaded == false then return end
		--if unit not loaded
		
		SetUnitValue(COB.BUSY, 1)

		
		DropUnit(transportedID)
		transportedID=nil
		loaded=false
		retractRope()


		SetUnitValue(COB.BUSY, 0)
	end

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local function spamFilter()
		SetSignalMask(SIG_SPAM)


			while (true) do
						   
							if spamfilterSTART==true and spamfilterSTOP==false then  
											for it=0,3,1
											do
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
											for it=0,3,1
											do
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
											StartThread(unfold)                    
											end
										   
							end

							if spamfilterSTOP==false and spamfilterSTART==false then  
								   
						----Spring.Echo("No idea what you did, but you broke it. You gonna pay!")
								   
							end

			end
	end




	function fold()
	boolFireLock=true
	Signal(SIG_UNFOLD)
	SetSignalMask(SIG_FOLD)
	----Spring.Echo("ThreadUnFold")

			Turn(turret,x_axis,math.rad(0),2.2)
			Turn(turret,y_axis,math.rad(0),2.2)
			Turn(turret,z_axis,math.rad(0),2.2)
			WaitForTurn(turret,x_axis)
			Turn(turret, x_axis,math.rad(0),1.85)
			Turn(turret2, x_axis,math.rad(0),1.85)
			Turn(sstowf2,y_axis,math.rad(180),4)
			WaitForTurn(sstowf2,y_axis)
			WaitForTurn(turret2, x_axis)
			Move(sstowf,y_axis, -65,6)
			WaitForMove(sstowf,y_axis)
			Sleep(50)
			Hide(sstowf)
			Hide(sstowf)
			Turn(turret,y_axis,math.rad(0),2.2)
		   
					while(true) do
					Turn(turret,y_axis,math.rad(0),2.2)
					Sleep(1024)
					end
	end

	function unfold()

	Signal(SIG_FOLD)
	----Spring.Echo("ThreadFold")
	SetSignalMask(SIG_UNFOLD)
			Show(sstowf)
			Show(sstowf)
			turner=math.random(-2,2)
			Turn(turret,x_axis,math.rad(turner),1)
			WaitForTurn(turret,x_axis)
			Move(sstowf,y_axis, 0,5)
			WaitForMove(sstowf,y_axis)
			boolFireLock=false
					while(true) do
			tempIdle=tempIdle+1
					Sleep(1024)
									if tempIdle%7==0 and boolTargetInScope == false then
									diceThrow=math.random(-360,360)
									Turn(sstowf2,y_axis,math.rad(diceThrow),4)
									Sleep(512)
									end
					end


	end


	function TargetInScope()
	SetSignalMask(SIG_SCOPE)
	Sleep(20000)
	boolTargetInScope=false

	end


	function constLazzorsEmit()
	SetSignalMask(SIG_LAS)
	Sleep(1500)
	local lEmitSfx=EmitSfx
	while(boolEmit==true) do

			Turn(flare,x_axis,math.rad(0),0)
			Turn(flare,y_axis,math.rad(0),0)
			Turn(flare,z_axis,math.rad(0),0)
			lEmitSfx(flare, 2049)

			--EmitSfx by force
			Sleep(65)
		   


	end


	end




	function script.StartMoving()
	if boolFilterActive==false then
	Signal(SIG_SPAM)
	StartThread(spamFilter)
	boolFilterActive=true
	end

	spamfilterSTOP=false
	spamfilterSTART=true

	end

	function script.StopMoving()
	--    ----Spring.Echo ("stopped walking!")
	spamfilterSTART=false          
	spamfilterSTOP=true            
	end


	local function spamFilter()
		SetSignalMask(SIG_SPAM)


		while (true) do
				
				if spamfilterSTART==true and spamfilterSTOP==false then  
						for it=0,3,1 
						do
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
						for it=0,3,1 
						do
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
						StartThread(unfold)			
						end
						
				end

				if spamfilterSTOP==false and spamfilterSTART==false then  
					
				----Spring.Echo("No idea what you did, but you broke it. You gonna pay!")
					
				end

		end
	end


	function fold()
	boolFireLock=true
	Signal(SIG_UNFOLD)
	SetSignalMask(SIG_FOLD)
	----Spring.Echo("ThreadUnFold")

		Turn(turret,x_axis,math.rad(0),2.2)
		Turn(turret,y_axis,math.rad(0),2.2)
		Turn(turret,z_axis,math.rad(0),2.2)
		WaitForTurn(turret,x_axis)
		Turn(turret, x_axis,math.rad(0),1.85)
		Turn(turret2, x_axis,math.rad(0),1.85)
		Turn(sstowf2,y_axis,math.rad(180),4)
		WaitForTurn(sstowf2,y_axis)
		WaitForTurn(turret2, x_axis)
		Move(sstowf,y_axis, -65,6)
		WaitForMove(sstowf,y_axis)
		Sleep(50)
		Hide(sstowf)
		Hide(sstowf)
		Turn(turret,y_axis,math.rad(0),2.2)
		
			while(true) do
			Turn(turret,y_axis,math.rad(0),2.2)
			Sleep(1024)
			end
	end

	function unfold()

	Signal(SIG_FOLD)
	----Spring.Echo("ThreadFold")
	SetSignalMask(SIG_UNFOLD)
		Show(sstowf)
		Show(sstowf)
		turner=math.random(-2,2)
		Turn(turret,x_axis,math.rad(turner),1)
		WaitForTurn(turret,x_axis)
		Move(sstowf,y_axis, 0,5)
		WaitForMove(sstowf,y_axis)
		boolFireLock=false
			while(true) do
			tempIdle=tempIdle+1
			Sleep(1024)
					if tempIdle%7==0 and boolTargetInScope == false then
					diceThrow=math.random(-360,360)
					Turn(sstowf2,y_axis,math.rad(diceThrow),4)
					Sleep(512)
					end
			end


	end

	function script.AimWeapon1(heading ,pitch)	
		Signal(SIG_AIM)
		SetSignalMask(SIG_AIM)
		Signal(SIG_LAS)
					if boolFireLock==true then
					return false
					end
		
		if boolFireLock==false then
		boolStillAiming=true	
		boolEmit=true	
		StartThread(constLazzorsEmit)
		--aiming animation: instantly turn the gun towards the enemy
		Turn(sstowf, y_axis, heading,0.95)
		Turn(turret2, x_axis, -pitch,0.65)
		WaitForTurn(sstowf,y_axis)
		WaitForTurn(turret2,x_axis)

		return true
		end
		
		
		
	end

	function script.AimFromWeapon1() 
		boolEmit=true	
		return turret2  
	end

	function script.QueryWeapon1() 
		return flare
	end

	function script.FireWeapon1()
	Signal(SIG_SCOPE)
	boolTargetInScope=true	
	Spring.PlaySoundFile("sounds/csniper/csniper.wav")  
		boolStillAiming=false
		boolEmit=false	
		return true
		
		
	end

	function TargetInScope()
	SetSignalMask(SIG_SCOPE)
	Sleep(20000)
	boolTargetInScope=false

	end


	function constLazzorsEmit()
	SetSignalMask(SIG_LAS)
	Sleep(1500)

	while(boolEmit==true) do

		Turn(flare,x_axis,math.rad(0),0)
		Turn(flare,y_axis,math.rad(0),0)
		Turn(flare,z_axis,math.rad(0),0)
		EmitSfx(flare, 2049)

		--EmitSfx by force
		Sleep(65)
		


	end


	end



	--function retracts rope from any lenght
	function retractRope()
	Spring.PlaySoundFile("sounds/csniper/harpoonretract.wav")  
	Sleep(666)
	Move(harpoonupmyass,z_axis,166,420)
	Sleep(50)
		for i=1, 12,1 do
		Turn(rope[(13-i)],x_axis,math.rad(0),600)
		Turn(rope[(13-i)],z_axis,math.rad(0),600)
		Turn(rope[(13-i)],y_axis,math.rad(0),600)
		Hide(rope[(13-i)])
		Sleep(10)
		end
	Show(ssharpoon)
	end
	--function expands the Rope to maximalLength
	function expandRope()
	bool=math.random(0,1)
		if bool== 1 then
		Spring.PlaySoundFile("sounds/csniper/harpoonexp1.wav")  
		else
		Spring.PlaySoundFile("sounds/csniper/harpoonexp2.wav")  
		end

	Hide(ssharpoon)
	tMinus=166
	harpoonSpeed=42
	Move(harpoonupmyass,z_axis,tMinus,ropeSpeed)
		for i=1, 12,1 do
		tMinus=tMinus-14
		Move(harpoonupmyass,z_axis,tMinus,420)
		Show(rope[i])
		WaitForMove(harpoonupmyass,z_axis)
		end
	end

	function script.Create()
	Hide(flare)
	Signal(SIG_SPAM)
		for i=1, 12,1 do
		Hide(rope[i])
		end
	--StartThread(testOsterOn)


	end

	function script.Killed(recentDamage,_)
		Signal(SIG_SPAM)
		Signal(SIG_FOLD)
		Signal(SIG_UNFOLD)
		 
		 flipFlop=math.random(0,1)
		 
		 if flipFlop==1 then
		Turn(sstowf2,x_axis,math.rad(35),2)
		WaitForTurn(sstowf2,x_axis)
		Turn(sstowf2,x_axis,math.rad(78),6)
		WaitForTurn(sstowf2,x_axis)
		Turn(sstowf2,x_axis,math.rad(92),9)
		WaitForTurn(sstowf2,x_axis)
		Sleep(250)
		Explode (cwheel1, SFX.FIRE)
		Explode (cwheel2, SFX.FIRE)
		Explode (cwheel3, SFX.FIRE)
		Explode (cwheel3, SFX.FIRE)
		Explode (turret2, SFX.SMOKE)
		Explode (csniper, SFX.FIRE + SFX.SMOKE)
		end
		 
		 if flipFlop==0 then
		 Turn(csniper,z_axis,math.rad(35),2)
			WaitForTurn(csniper,z_axis)
			Turn(csniper,z_axis,math.rad(78),6)
			WaitForTurn(csniper,z_axis)
			Turn(csniper,z_axis,math.rad(93),9)
			WaitForTurn(csniper,z_axis)
			 Turn(csniper,z_axis,math.rad(85),6)
			WaitForTurn(csniper,z_axis)

			Turn(csniper,z_axis,math.rad(93),9)
			WaitForTurn(csniper,z_axis)
			Sleep(250)		
			Explode (cwheel1, SFX.FIRE)
			Explode (cwheel2, SFX.FIRE)
			Explode (cwheel3, SFX.FIRE)
			Explode (cwheel3, SFX.FIRE)
			Explode (turret2, SFX.SMOKE)
			Explode (csniper, SFX.FIRE  + SFX.SMOKE)
		 
		 
		 end

	 suddenDeathVM(recentDamage) 
 
 return 0
	end

	function script.StartMoving()
	if boolFilterActive==false then
	Signal(SIG_SPAM)
	StartThread(spamFilter)	
	boolFilterActive=true
	end

	spamfilterSTOP=false
	spamfilterSTART=true

	end

	function script.StopMoving()
	--    ----Spring.Echo ("stopped walking!")
	spamfilterSTART=false		
	spamfilterSTOP=true		
	end

	------------------------------------------------------------
	function script.AimWeapon2(heading,pitch)	
		Turn(flare,y_axis,heading,0)
		Turn(flare,x_axis,-pitch,0)
		return true
		

	end

	function script.AimFromWeapon2() 
		return turret2
	end

	function script.QueryWeapon2() 
		return flare 
	end

	function script.FireWeapon2()	
		return true
	end

			