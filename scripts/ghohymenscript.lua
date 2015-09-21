  include "suddenDeath.lua"
	include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

	--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


	local AniT={}  

	for j=1,3,1 do
	AniT[j]={}  
	piecename= ""..j.."Hymbody"
	AniT[j]["Body"]=piece(piecename)
	piecename=""..j.."Hymhed"
	AniT[j]["Head"]=piece(piecename)
		for i=1,5, 1 do
		AniT[j][i]={}  
		tempiece=""..j.."Uleg"..i
		AniT[j][i][1]=piece(tempiece)
		tempiece=""..j.."leg"..i
		AniT[j][i][2]=piece(tempiece)
		end
	end

	local piecesTable= {} 
	 center = piece"center"
	 
	 piecesTable[#piecesTable+1]= pcenter
	 p1Body = piece"1Hymbody"
	 
	 piecesTable[#piecesTable+1]= p1Body
	 p1Uleg5 = piece"1Uleg5"
	 
	 piecesTable[#piecesTable+1]= p1Uleg5
	 p1leg5 = piece"1leg5"
	 
	 piecesTable[#piecesTable+1]= p1leg5
	 p1Hymhed = piece"1Hymhed"
	 
	 piecesTable[#piecesTable+1]= p1Hymhed
	 p1Uleg1 = piece"1Uleg1"
	 
	 piecesTable[#piecesTable+1]= p1Uleg1
	 p1leg1 = piece"1leg1"
	 
	 piecesTable[#piecesTable+1]= p1leg1
	 p1Uleg3 = piece"1Uleg3"
	 
	 piecesTable[#piecesTable+1]= p1Uleg3
	 p1leg3 = piece"1leg3"
	 
	 piecesTable[#piecesTable+1]= p1leg3
	 p1Uleg4 = piece"1Uleg4"
	 
	 piecesTable[#piecesTable+1]= p1Uleg4
	 p1leg4 = piece"1leg4"
	 
	 piecesTable[#piecesTable+1]= p1leg4
	 p1Uleg2 = piece"1Uleg2"
	 
	 piecesTable[#piecesTable+1]= p1Uleg2
	 p1leg2 = piece"1leg2"
	 
	 piecesTable[#piecesTable+1]= p1leg2
	 p2Body = piece"2Hymbody"
	 
	 piecesTable[#piecesTable+1]= p2Body
	 p2Hymhed = piece"2Hymhed"
	 
	 piecesTable[#piecesTable+1]= p2Hymhed
	 p2Uleg3 = piece"2Uleg3"
	 
	 piecesTable[#piecesTable+1]= p2Uleg3
	 p2leg3 = piece"2leg3"
	 
	 piecesTable[#piecesTable+1]= p2leg3
	 p2Uleg1 = piece"2Uleg1"
	 
	 piecesTable[#piecesTable+1]= p2Uleg1
	 p2leg1 = piece"2leg1"
	 
	 piecesTable[#piecesTable+1]= p2leg1
	 p2Uleg5 = piece"2Uleg5"
	 
	 piecesTable[#piecesTable+1]= p2Uleg5
	 p2leg5 = piece"2leg5"
	 
	 piecesTable[#piecesTable+1]= p2leg5
	 p2Uleg2 = piece"2Uleg2"
	 
	 piecesTable[#piecesTable+1]= p2Uleg2
	 p2leg2 = piece"2leg2"
	 
	 piecesTable[#piecesTable+1]= p2leg2
	 p2Uleg4 = piece"2Uleg4"
	 
	 piecesTable[#piecesTable+1]= p2Uleg4
	 p2leg4 = piece"2leg4"
	 
	 piecesTable[#piecesTable+1]= p2leg4
	 p3Body = piece"3Hymbody"
	 
	 piecesTable[#piecesTable+1]= p3Body
	 p3Uleg1 = piece"3Uleg1"
	 
	 piecesTable[#piecesTable+1]= p3Uleg1
	 p3leg1 = piece"3leg1"
	 
	 piecesTable[#piecesTable+1]= p3leg1
	 p3Hymhed = piece"3Hymhed"
	 
	 piecesTable[#piecesTable+1]= p3Hymhed
	 p3Uleg3 = piece"3Uleg3"
	 
	 piecesTable[#piecesTable+1]= p3Uleg3
	 p3leg3 = piece"3leg3"
	 
	 piecesTable[#piecesTable+1]= p3leg3
	 p3Uleg2 = piece"3Uleg2"
	 
	 piecesTable[#piecesTable+1]= p3Uleg2
	 p3leg2 = piece"3leg2"
	 
	 piecesTable[#piecesTable+1]= p3leg2
	 p3Uleg5 = piece"3Uleg5"
	 
	 piecesTable[#piecesTable+1]= p3Uleg5
	 p3leg5 = piece"3leg5"
	 
	 piecesTable[#piecesTable+1]= p3leg5
	 p3Uleg4 = piece"3Uleg4"
	 piecesTable[#piecesTable+1]= p3Uleg4
	 p3leg4 = piece"3leg4"
	 piecesTable[#piecesTable+1]= p3leg4

	 local AgeStage=1
	 
	local SIG_DELAY=1
	local SIG_STATE=2
	 
	SignalTable={}
	SignalTable["STATE"]=true
	SignalTable["SIG_DELAY"]=true
	 
	--StateChangeAnimations
		function Eat(argTable)
		SignalTable["STATE"]=false
		Sleep(500)
		SignalTable["STATE"]=true
			
			while 	SignalTable["STATE"] == true do 
			--change Position
			if AgeStage~=1 then
				if math.random(0,5)==2 then
				x,y,z=Spring.GetUnitPosition(unitID)
					if x then
					x,z=x+math.random(-12,12),z+math.random(-12,12)
					Spring.SetUnitMoveGoal(unitID,x,y,z)
					end
				else
				--Nom Nom Nom
					eatingGrass()
				end
			elseif argTable then
			px,py,pz=Spring.GetUnitPosition(argTable[1])
			x,y,z=Spring.GetUnitPosition(unitID)
			x,y,z=x-px,y-py,z-pz
			x=x*x+z*z+y*y
				if math.sqrt(x) < 35 then
				--MilkTime
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(-42), 9)
					Turn(AniT[AgeStage]["Body"],x_axis,math.rad(13), 9)
					for i=1,5, 1 do
						if i%2== 1 then
						Turn(AniT[AgeStage][i][1],x_axis,math.rad(-48), 155)
							if i== 3 then
							Turn(AniT[AgeStage][i][1],z_axis,math.rad(-14), 14)
							elseif i==5 then
							Turn(AniT[AgeStage][i][1],z_axis,math.rad(math.random(-14,14)), 14)
							else
							Turn(AniT[AgeStage][i][1],z_axis,math.rad(14), 12)
							end
						else
						Turn(AniT[AgeStage][i][1],x_axis,math.rad(0), 59)
						end
					end
						for i=1,22, 1 do
						Turn(AniT[AgeStage]["Head"],x_axis,math.rad(-30), 15)
						WaitForTurn(AniT[AgeStage]["Head"],x_axis)
						Turn(AniT[AgeStage]["Head"],x_axis,math.rad(-45), 15)
						WaitForTurn(AniT[AgeStage]["Head"],x_axis)		
						end
				end
			end
			Sleep(150) 
			end 
		end

		function Meat(argTable)
			SignalTable["STATE"]=false
		Sleep(500)
		SignalTable["STATE"]=true
			
			while 	SignalTable["STATE"] == true do 
		
			
			
			Sleep(150) 
			end 
		end
		
		function DrinkWater(argTable)
		SignalTable["STATE"]=false
		Sleep(500)
		SignalTable["STATE"]=true
			
			while 	SignalTable["STATE"] == true do 
			Turn(AniT[AgeStage]["Head"],x_axis,math.rad(91), 9)
			WaitForTurn(AniT[AgeStage]["Head"],x_axis)
			gulp=math.random(2,22)
				for i=1,gulp do
				Turn(AniT[AgeStage]["Head"],x_axis,math.rad(90+math.random(2,4)), 9)
				WaitForTurn(AniT[AgeStage]["Head"],x_axis)
				Sleep(300)
				Turn(AniT[AgeStage]["Head"],x_axis,math.rad(90-math.random(2,4)), 9)
				WaitForTurn(AniT[AgeStage]["Head"],x_axis)
				end
			Sleep(150) 
				if math.random(0,1)== 1 then alarmed() end
			
			end
		end 
		
		function MoveCloser(argTable)
		SetSignalMask(SIG_STATE) 
					-- [1]=other )
			while true do 
			Sleep(150) 
			end 
		end

		function HideInHerd(argTable)
		SetSignalMask(SIG_STATE) 
					-- [1]=other )	
			while true do 
			Turn(AniT[AgeStage]["Head"],x_axis,math.rad(57),107)
			WaitForTurn(AniT[AgeStage]["Head"],x_axis)
				if argTable and argTable[1]then
				x,y,z=Spring.GetUnitPosition(argTable[1])
				mx,my,mz=Spring.GetUnitPosition(unitID)
				x,y,z=x-mx,y-my,z-mz
				dist=math.sqrt(x*x+y*y+z*z)
				x,z=x/dist,z/dist
				head=Spring.GetHeadingFromVector(x,z)
				Turn(center,y_axis,head,15)
				boolWasAllreadyMoving=(boolMoving==true)
				boolMoving=true
				WaitForTurn(center,y_axis)
				if boolWasAllreadyMoving ~= true then boolMoving=false end
				Sleep(150) 
				end 
			Sleep(50)
			end
		end

		function Rest(argTable)
		SignalTable["STATE"]=false
		Sleep(500)
		SignalTable["STATE"]=true
			
			while 	SignalTable["STATE"] == true do 
		
			SleepAnimation()
				if math.random(0,1)== 1 then alarmed() end
			Sleep(150)
			end 
		end
		
			function RecoveringLonely(argTable)
			SignalTable["STATE"]=false
			Sleep(500)
			SignalTable["STATE"]=true
			
			while 	SignalTable["STATE"] == true do 
		
			SickAnimation()
			Sleep(150) 
			end 
		end

		function FuckingInTheBushes(argTable)
		SignalTable["STATE"]=false
		Sleep(500)
		SignalTable["STATE"]=true
			
			while 	SignalTable["STATE"] == true do 
		
			Sleep(150) 
			end 
		end

		function RunningForLive(argTable)
		SetSignalMask(SIG_STATE) 
		SetUnitValue(COB.MAX_SPEED,340787)--sets the speed to 5,2 *65533
			while true do 
			Sleep(150) 
			end 
		end

		function NurseYoung(argTable)
		SetSignalMask(SIG_STATE) 
					-- [1]=other )	
			while true do 
			Sleep(150) 
			end 
		end
		
		function eatingGrass()
		for j=1,math.ceil(math.random(5,11)), 1 do
					for i=1,3, 1 do
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(81),42)
					Turn(AniT[AgeStage]["Head"],y_axis,math.rad(8*math.random(-1,1)),42)
					WaitForTurn(AniT[AgeStage]["Head"],x_axis)
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(73),142)
					Turn(AniT[AgeStage]["Head"],y_axis,math.rad(0),142)
					WaitForTurn(AniT[AgeStage]["Head"],x_axis)
					end
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(23),142)
					WaitForTurn(AniT[AgeStage]["Head"],x_axis)
				--Chewy
					for i=1,9,1 do
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(20),22)
					WaitForTurn(AniT[AgeStage]["Head"],x_axis)
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(23),12)
					WaitForTurn(AniT[AgeStage]["Head"],x_axis)
					end
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(7),32)
					WaitForTurn(AniT[AgeStage]["Head"],x_axis)
					Sleep(500)
						
		end
		
		end
		
		function alarmed()
		Turn(AniT[AgeStage]["Head"],x_axis,math.rad(-22), 39)
		WaitForTurn(AniT[AgeStage]["Head"],x_axis)
		leftRight=-1 
			if math.random(0,1)==1 then leftRight=leftRight^2 
			leftRight=leftRight*(math.max(12,math.random(10,27)))
			Turn(AniT[AgeStage]["Head"],y_axis,math.rad(leftRight), 12)
			WaitForTurn(AniT[AgeStage]["Head"],y_axis)
			end
		waitTime=math.ceil(math.random(250,2500))
		Sleep(waitTime)
			Turn(AniT[AgeStage]["Head"],y_axis,math.rad(0), 12)
			Turn(AniT[AgeStage]["Head"],x_axis,math.rad(0), 12)
		end

		function SickAnimation()
			Move(AniT[AgeStage]["Body"],y_axis, -8, 12)

						for i=1,5, 1 do
							if i%2== 1 then
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(155), 155)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(-76), 76)
							else
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(-59), 59)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(146), 146)				
							end
						end		
		Turn(AniT[AgeStage]["Body"],z_axis,math.rad(82),8)
		for k=1,22, 1 do
			for i=1,5, 1 do
							if i%2== 1 then
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(155), 155)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(-76), 76)
							else
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(-59), 59)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(146), 146)				
							end
			end
		Sleep(900)
				for i=1,5, 1 do
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(0), 15)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(0), 16)
				end
		Sleep(1900)
		end
		end
				
		function reProduce()
		time=math.ceil(math.random(120000,900000))
		Sleep(time)
		x,y,z=Spring.GetUnitPosition(unitID)
		teamID=Spring.GetUnitTeam(unitID)
		GG.UnitsToSpawn:PushCreateUnit("ghohymen",x,y,z,0,teamID)

		end		
				
		function SleepAnimation()
				Move(AniT[AgeStage]["Body"],y_axis, -8, 12)

						for i=1,5, 1 do
							if i%2== 1 then
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(155), 155)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(-76), 76)
							else
							Turn(AniT[AgeStage][i][1],x_axis,math.rad(-59), 59)
							Turn(AniT[AgeStage][i][2],x_axis,math.rad(146), 146)				
							end
						end
					for i=1,128,1 do
					Move(AniT[AgeStage]["Body"],y_axis, -8.25, 0.25)
					WaitForMove(AniT[AgeStage]["Body"],y_axis)					
					Move(AniT[AgeStage]["Body"],y_axis, -8, 0.25)
					WaitForMove(AniT[AgeStage]["Body"],y_axis)					
					end
					Turn(AniT[AgeStage]["Head"],z_axis,math.rad(32), 61)
					Turn(AniT[AgeStage]["Head"],y_axis,math.rad(7), 2)				
					Turn(AniT[AgeStage]["Head"],x_axis,math.rad(8), 26)				
					Sleep(150) 
		end				
	 
	 
	function script.Create()
	Spring.Echo("JW::GHohymen::EnteringCreate")
	Age(AgeStage)
	StartThread(TheyGrowUpSoFast)
	Spring.Echo("JW::GHohymen::EnteringDebugLoop")
	StartThread(debugLoop)
	Spring.Echo("JW::GHohymen::StartingWalkThread")
	StartThread(walk)
	StartThread(reProduce)
	end
			
	function script.Killed(recentDamage,_)

	suddenDeathjMedCorpse(recentDamage)
	return 1
	end

	function Age(number)
	if AniT[number]["Body"] then
		for i=1, # piecesTable, 1 do
		Hide(piecesTable[i])
		end
		
		Show(AniT[number]["Body"])
		Show(AniT[number]["Head"])
		for i=1,5, 1 do	
			if i %2 ~=0 then
			Show(AniT[number][i][1])
			Show(AniT[number][i][2])
			end
		end
	end
	end
	
	
	function TheyGrowUpSoFast()
	while AgeStage ~= 4 do
	time=math.ceil(math.random(60000,190000))
	Sleep(time)
	Age(AgeStage)
	AgeStage=math.min(3,AgeStage+1)
	end
	end

	
	StateFunctionTable={
		 ["Eat"] =	   				Eat,     
		 ["Meat"] =   			  	Meat,    			
		 ["DrinkWater"] =   		DrinkWater,    					  
		 ["MoveCloser"] =   		MoveCloser,    		
		 ["HideInHerd"] =   		HideInHerd,    		
		 ["Rest"] =   				Rest,    			
		 ["RecoveringLonely"] =    	RecoveringLonely,     	     	
		 ["FuckingInTheBushes"] =   FuckingInTheBushes,  
		 ["RunningForLive"] =   	RunningForLive,    	
		 ["NurseYoung"] =   		NurseYoung,    		 	
						}
	
	function debugLoop()
	enemyID=Spring.GetUnitNearestEnemy(unitID)
	argTable={}
	
	if enemyID then
	argTable={[1]=enemyID}
	else
	argTable={[1]=unitID}
	end
	
	while true do
			for k,v in ipairs(StateFunctionTable) do	
			Spring.Echo("JW::DebugLoop::"..k)
			functionswitch(k, argTable)
			Sleep(15000)
			end
		Sleep(500)
		end
	end
	
	
	function functionswitch(name, argTable)
	Spring.Echo("JW::GHohymen::Functionswitch "..name)

	LegsDown()
	if StateFunctionTable[name] then
	StartThread(StateFunctionTable[name], argTable)	
	else
	Spring.Echo("Hohymen has no state equivalent to "..name)
	end
	return	
	end

	boolRun=false
	boolMoveOrderd=false
	boolMoving=false

	function walk()
	local lincAndMod=incAndMod
	local it=0
			Spring.Echo("JW:Ghohymen:Walk")
		while true do 

		--Walks only if told too
		SetUnitValue(COB.MAX_SPEED,163832)--sets the speed to 5,2 *65533
			while boolMoving==true do --or boolMoveOrderd==true do
			it=lincAndMod(it)
			WalkAnimationCycle()
				while boolRun==true do
				Spring.Echo("JW:Ghohymen:Run")
				SetUnitValue(COB.MAX_SPEED,327665)
				it=lincAndMod(it)
				RunAnimationCycle(20,it,150)
				Sleep(300)
				end

			Sleep(300)
			end
		Sleep(50)
		if boolMoving== false then LegsDown() end
		end
	end

	function incAndMod(it)
	return (it+1)%2
	end

	function delayedMove()
	SetSignalMask(SIG_DELAY)
	Sleep(50)
	boolMoving=true
	end

	function script.StartMoving()
	if boolMoving==false then StartThread(delayedMove) end
	end

	function script.StopMoving()
	Signal(SIG_DELAY)
	boolMoving=false		
	end

	function RunAnimationCycle(speed, it,time)
	time=math.ceil(time/2)
	
	Turn(AniT[AgeStage]["Body"],x_axis,math.rad(5), speed)
	Turn(AniT[AgeStage]["Head"],x_axis,math.rad(11), speed)
	Sleep(time)
		itterator=math.max(1,(itterator+1)%8)	
		for i=1,5, 1 do
		runTable[math.max(1,itterator+i%3)](AniT[AgeStage][i][1],AniT[AgeStage][i][2],68)
		end
	Turn(AniT[AgeStage]["Body"],x_axis,math.rad(-3), speed)
	Turn(AniT[AgeStage]["Head"],x_axis,math.rad(8), speed)
	Sleep(time)
	
	end
	
	
	
	function ThrustForwardUpLeg(pnup,pndown,speed)
	val=math.random(-72,-60)
	Turn(pnup,x_axis,math.rad(val),speed)
	Turn(pndown,x_axis,math.rad(120),speed)
	end
	
	function ForwardUpLeg(pnup,pndown,speed)
	val=math.random(-42,-36)
	Turn(pnup,x_axis,math.rad(val),speed)
	Turn(pndown,x_axis,math.rad(6),speed)
	end
	
	function DownMidLeg(pnup,pndown,speed)
	Turn(pnup,x_axis,math.rad(0),speed)
	Turn(pndown,x_axis,math.rad(0),speed)
	end
	
	
	function BackDownUpLeg(pnup,pndown,speed)
	Turn(pnup,x_axis,math.rad(26),speed)
	Turn(pndown,x_axis,math.rad(33),speed)
	end
	
	function ThrustBackUpLeg(pnup,pndown,speed)
		Turn(pnup,x_axis,math.rad(26),speed)
		Turn(pndown,x_axis,math.rad(70),speed)
	end
	
	walkTable=
	{
	[1]=ForwardUpLeg,
	[2]=DownMidLeg,
	[3]=BackDownUpLeg
	}
	
	runTable=
	{
	[1]=ThrustForwardUpLeg,
	[2]=DownMidLeg,
	[3]=ThrustBackUpLeg
	}

	
	itterator=1
	function WalkAnimationCycle()
	itterator=math.max(1,(itterator+1)%8)
	
		for i=1,5, 1 do
			if i%2 ~=0 then
			walkTable[math.max(1,(itterator+i%3)%4)](AniT[AgeStage][i][1],AniT[AgeStage][i][2],7)
			end
		end

	end


	function LegsDown()
	Move(AniT[AgeStage]["Body"],z_axis,0,52)
	Move(AniT[AgeStage]["Body"],y_axis,0,52)
	Move(AniT[AgeStage]["Body"],x_axis,0,52)
	
	Turn(AniT[AgeStage]["Head"],z_axis,math.rad(0), 16)
	Turn(AniT[AgeStage]["Head"],y_axis,math.rad(0), 16)				

		for i=1,5, 1 do	
		Turn(AniT[AgeStage][i][1],y_axis,math.rad(0),42)
		Turn(AniT[AgeStage][i][1],z_axis,math.rad(0),42)
		Turn(AniT[AgeStage][i][1],x_axis,math.rad(0),42)
		
		Turn(AniT[AgeStage][i][2],y_axis,math.rad(0),42)
		Turn(AniT[AgeStage][i][2],z_axis,math.rad(0),42)
		Turn(AniT[AgeStage][i][2],x_axis,math.rad(0),42)	
		end

	end
