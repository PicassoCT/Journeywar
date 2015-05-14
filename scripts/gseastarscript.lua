include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
fooNction=piece
piecesTable=generateKeyPiecesTable(unitID,fooNction)

function LiftFunction(KneeT,Speed)

ratio=3.14159/#KneeT

	for i=1,#KneeT, 1 do
	Turn(KneeT[i],x_axis,math.rad(math.cos(i*ratio)*45), Speed)
	end
end

function deathTimer()
Sleep(20000)
local spGetUnitPosition=Spring.GetUnitPosition
x,y,z=spGetUnitPosition(unitID)
Sleep(1000)
ox,oy,oz=spGetUnitPosition(unitID)
	while x-ox ~= 0 or x-ox ~= 0 or x-ox ~= 0 do
	ox,oy,oz=x,y,z
	x,y,z=spGetUnitPosition(unitID)
	Sleep(1000)
	end
Spring.DestroyUnit(unitID,true,false)
	end

function wiggleFeet()
while true do
	speed=math.random(5,15)/100
	for k=1,5 do
			frame=Spring.GetGameFrame()
			frame=frame/30
			piEight=3.1415/math.floor(math.random(4,12))
			dice=math.random(-25,25)
		for i=1,6 do	
			sperd= math.random(0,5)/100
			if sperd == 0 then sperd= 0.1 end
			val=math.sin(frame+piEight*i)*dice
			Turn(Knees[k][i],y_axis,math.rad(val),sperd)		
		end
	end
WaitForTurn(Knees[#Knees][6],y_axis)
Sleep(10)
end


end

local spGetGroundHeight=Spring.GetGroundHeight
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir

function HowHighIsTheTireMama(i,piecename)
x,y,z,_,_,_=spGetUnitPiecePosDir(unitID,piecename)
h=spGetGroundHeight(x,z)
return     y,h
end


function LowerFunction(KneeT,Speed,SensorNode, FirstAxis)
--The funcy Part keeping the Worm close to the Ground
-----------------
AdaptTable={}
for i=1,#KneeT do
AdaptTable[#AdaptTable+1]={}
AdaptTable[#AdaptTable][1]=  	KneeT[i]
AdaptTable[#AdaptTable][2]=  	KneeT[i]
AdaptTable[#AdaptTable][3]=  	0
end
	

local lHowHighIsTheTireMama=HowHighIsTheTireMama
local lAdaptTable=AdaptTable


	while true do
		for i=1,#KneeT-1,1 do
		--Meassuring
		y,h=lHowHighIsTheTireMama(i,lAdaptTable[i+1][2])
		y=y-5
		
		
		if i%2==0 then
		
			if h-y > 5 then --and AdaptTable[i][3] > 25 then 
			Turn(lAdaptTable[i][1],x_axis,math.rad(lAdaptTable[i][3]-1),0.15)
			lAdaptTable[i][3]=lAdaptTable[i][3]-1
				else
				Turn(lAdaptTable[i][1],x_axis,math.rad(lAdaptTable[i][3]+1),0.15)
				lAdaptTable[i][3]=lAdaptTable[i][3]+1
				end
		
		else	
		
		
			if h-y < 3 then --and AdaptTable[i][3] > 25 then 
			Turn(lAdaptTable[i][1],x_axis,math.rad(lAdaptTable[i][3]-1),0.005)
			lAdaptTable[i][3]=lAdaptTable[i][3]-1
				else
				Turn(lAdaptTable[i][1],x_axis,math.rad(lAdaptTable[i][3]+1),0.05)
				lAdaptTable[i][3]=lAdaptTable[i][3]+1
				end
		end
		
		end
	Sleep(1050)
	end


-----------------
end
Knees={}
function script.Create()

inPieces=Spring.GetUnitPieceMap(unitID)


firstAxis={}
for nr=1,5 do 
firstAxis[#firstAxis+1]=piecesTable["ConTurn"..nr];nr=nr+1
Turn(firstAxis[#firstAxis],y_axis,math.rad(90+(360/5)*nr),0)
end
nr=1

	for k=1,5 do
	Knees[k]={}
	
		for i=1,6 do
		Knees[k][i]=piecesTable["Feet"..(nr)]
		nr=nr+1
		end
	end

sensorT={}
sensorT[#sensorT+1]=piecesTable["Feet1"] 
sensorT[#sensorT+1]=piecesTable["Feet7"] 
sensorT[#sensorT+1]=piecesTable["Feet13"]
sensorT[#sensorT+1]=piecesTable["Feet19"]
sensorT[#sensorT+1]=piecesTable["Feet25"]
LiftF=LiftFunction
LowerF=LowerFunction
configTable={id=unitID, centerNode=center, nr=5, feetTable={firstAxis=firstAxis,Knees=Knees}, sensorTable=sensorT ,ElementWeight=5,FeetLiftForce=3,LiftFunction=LiftF,LowerFunction=LowerF, Height=32}
StartThread(adaptiveAnimation,configTable,inPieces)
StartThread(wiggleFeet)
StartThread(deathTimer)
end

function script.Killed(recentDamage,_)


return 1
end




function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end

function script.QueryBuildInfo() 
  return center 
end

function script.QueryNanoPiece()
     return center
end

