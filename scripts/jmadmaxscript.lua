	include "suddenDeath.lua"
	include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

	
	AllReadyUsed={}
	center=piece"center"
	--Lego
	--all the yet unused LegoPieces
	LegoPieces={}
	ConPieces={}
	DoubleLegoPieces={}
	LegoID=1
	DoubleMax=16
	LegoMax=22
	
	--Connection pieces for linear Connections only
	for i=1,LegoMax,1 do
		
		LegoPieceName="Lego"..i.."s2"
		LegoPieces[i]=piece(LegoPieceName)
		
		--add the linear connections
		ConPieces[LegoPieces[i]]={}
		ConPieces[LegoPieces[i]].Symetric={}
		ConPieces[LegoPieces[i]].Linear={}
		
			for j=1,4,1 do
			name="lcon"..i..j
			ConPieces[LegoPieces[i]].Linear[j]={}
			ConPieces[LegoPieces[i]].Linear[j]=piece(name)
			end
		--add the symetric connections
			
			for j=1,2,1 do
			name="scon"..i..j
			ConPieces[LegoPieces[i]].Symetric[j]=piece(name)
			end
			
	--	--Spring.Echo("JW:VaryFoo:SymetricConections"..table.getn(ConPieces[LegoPieces[i]].Symetric))
			
		Move(LegoPieces[i],x_axis,0,0)
		Move(LegoPieces[i],z_axis,0,0)
		Move(LegoPieces[i],y_axis,0,0)
		
		if i < DoubleMax and i %2 ==0 then
		DoubleLegoPieces[#DoubleLegoPieces+1]={k=LegoPieces[i-1],v=LegoPieces[i]}
	
											
		end
	end
	
	--Wheel
	WheelPieces={}
	DoubleWheelPieces={}
	WheelCon={}
	WheelMax=12
	LinWheelMax=4 --Wheels that can be used for linear expansion
	ExclusiveSymmetricWheel={}
	WheelTable={}
		for i=1,WheelMax,1 do
		
		LegoPieceName1="Wheel"..i.."1"   --Uper  Wheel
		LegoPieceName2="Wheel"..i.."2"   --Lower Wheel
		LegoPieceName3="WheelPoM"..i
		WheelPieces[i]={}
		WheelPieces[i][1]=	piece(LegoPieceName1)
		WheelPieces[i][2]=	piece(LegoPieceName2)
		WheelPieces[i][3]=	piece(LegoPieceName3)
		Hide(WheelPieces[i][1])
		Hide(WheelPieces[i][2])
	
		
		--add the linear connections
		
			if i < WheelMax and i %2 ==0 then
			DoubleWheelPieces[#DoubleWheelPieces+1]={k=WheelPieces[i-1],v=WheelPieces[i]			}
			end
		
	
		end

	--CockPit
	CockPitPieces={}
	DoubleCockPitPieces={}
	CockPitCon={}
	CockPitMax=8
	
		for i=1,CockPitMax,1 do
		
		LegoPieceName="CockPit"..i
		CockPitPieces[i]=piece(LegoPieceName)
		Hide(CockPitPieces[i])
		LegoPieceName="CockPitCon"..i
		CockPitCon[i]=piece(LegoPieceName)
		--add the linear connections
		
		if i < CockPitMax and i %2 ==0 then
		DoubleCockPitPieces[#DoubleCockPitPieces+1]={k=CockPitPieces[i-1],v=CockPitPieces[i]			}											
		end
		

		end

	--DECO
	DecoPieces={}
	DoubleDecoPieces={}
	
	DecoMax=16
	DecoDouble=4
	for i=1,DecoMax,1 do
		
		LegoPieceName="Deco"..i
		DecoPieces[i]=piece(LegoPieceName)
		--add the linear connectionsk
		
		if i < DecoMax and i %2 ==0 then
		DoubleDecoPieces[#DoubleDecoPieces+1]={k=DecoPieces[i-1],v=DecoPieces[i]			}							
		end
	Hide(DecoPieces[i])

	end

	function script.Killed(recentDamage,_)

	suddenDeathjBigCorpse(recentDamage)
	return 1
	end

	local SymPairWheels={}
	local LinWheels={}
	
	function processAddedWheels()
	temp={}
		for i=1,#WheelTable,1 do
		temp[WheelTable[i]]={}
		temp[WheelTable[i]]=WheelTable[i]
		end
	
		for i=1,#WheelTable,1 do
		--check wether the Wheel is in DoubleWheelPieces and its counterpart is in 
			if getValByKeyObj(DoubleWheelPieces,WheelTable[i]) and temp[getValByKeyObj(DoubleWheelPieces,WheelTable[i])] and not AllReadyUsed[temp[getValByKeyObj(DoubleWheelPieces,WheelTable[i])]] then
			SymPairWheels={[1]=WheelTable[i],
						 [2]= temp[getValByKeyObj(DoubleWheelPieces,WheelTable[i])],}
			else
			LinWheels[#LinWheels+1]=WheelTable[i]
			end
		end
		
	
	end
	
	function getValByKeyObj(Table,key)
	local T= Table
		for i=1,#T do
			if T.k== key then return T.v end
		end
	end

	
	function walk()

	
		while true do
			while boolWalk==true do
			Turn(center,x_axis,math.rad(offSetX+math.random(3,7)),0.9)
			WaitForTurn(center,x_axis)
			Turn(center,x_axis,math.rad(offSetX-math.random(3,7)),0.9)
			WaitForTurn(center,x_axis)
			end
			
		Sleep(500)
		end
	end
	

	local SIG_DELAYSTOP=4
	
	function script.StartMoving()
	boolWalk=true
	Signal(SIG_DELAYSTOP)

	end

	function delayedStop()
	SetSignalMask(SIG_DELAYSTOP)
	Sleep(500)
	boolWalk=false

	end
	
	function script.StopMoving()
			Signal(SIG_DELAYSTOP)
			StartThread(delayedStop)
			
	end

local 	boolWalk= false
local	boolAttack=false
------------------------------------------------------------------------------------UNITCODE	
function script.Create()
--center,Arm_Max,Leg_Max, Body_Double_Max,Head_Max, Deco_Max, DecoD,Body_Max, symDegFilterFunction, linDegFilterFunction)
StartThread(buildVehicle,center,AMax,LMax, DMax,HMax, DecoM, DecoD,BMax, symDegFilterFunction, linDegFilterFunction)
end
	
	----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center 
end

function script.AimWeapon1( CockPiting ,pitch)	

	return true

end

function script.FireWeapon1()	
	return true
end

	