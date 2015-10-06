 include "suddenDeath.lua"
 include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
cosFunc= function (val) return math.cos(val) end 
waveATable(Knees, x_axis, cosFunc, -1, 0.32, math.random(0.77,1.4),4.5, true)
end
center=piece"center"
fooNction=piece
piecesTable=makeKeyPiecesTable(unitID,fooNction)

function LiftFunction(KneeT,Speed)
sinFunc= function (val) return math.sin(val) end 
cosFunc= function (val) return math.cos(val) end 
waveATable(Knees, x_axis, cosFunc, -1, 0.32, math.random(0.77,1.4),4.5, true)



waveATable(Knees, x_axis, sinFunc, 1, 0.022, 3.141, 6.5, true, -1.1)
WaitForTurn(Knees[#Knees][5],x_axis)
Sleep(350)
waveATable(Knees, x_axis, sinFunc, 1, 0.032, 6.2, 6.5, true,-3)

WaitForTurn(Knees[#Knees][5],x_axis)
Sleep(350)

end

function deathTimer()

headingofold=Spring.GetUnitHeading(unitID)
Sleep(20000)


local spGetUnitPosition=Spring.GetUnitPosition

newHeading=Spring.GetUnitHeading(unitID)
x,y,z=spGetUnitPosition(unitID)
Sleep(1000)
ox,oy,oz=spGetUnitPosition(unitID)
	while x-ox ~= 0 or x-ox ~= 0 or x-ox ~= 0 or headingofold ~= newHeading do
	ox,oy,oz=x,y,z
	headingofold=newHeading
	x,y,z=spGetUnitPosition(unitID)
	Sleep(1000)
	newHeading=Spring.GetUnitHeading(unitID)
	end
--Spring.DestroyUnit(unitID,true,false)
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
				sperd= math.random(1,5)/100				
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


function LowerFunction(KneeT,Speed,SensorNode, FirstAxis,degOffSet)
--The funcy Part keeping the Worm close to the Ground

Threads={}



rotTotal=0
	for i=1,#KneeT, 1 do
	
		val=0

			_,result,_=Spring.UnitScript.GetPieceRotation(KneeT[i])
			PieceOfMine=KneeT[math.max((i%#KneeT)+1,1)] or KneeT[math.max(i%#KneeT,1)]
				x,y,z=Spring.GetUnitPiecePosDir(unitID,PieceOfMine)
				h=Spring.GetGroundHeight(x,z)			
				
					if y < h  then 
						val=-3					
					else
						val=3
					end
			result=result+ math.rad(val)
			rotTotal=rotTotal+result
			
			Turn(KneeT[i],x_axis,result,Speed)


	
	end

	
WaitForTurn(KneeT[1],x_axis)
WaitForTurn(KneeT[#KneeT],x_axis)


-----------------
end

Knees={}
function script.Create()

inPieces=Spring.GetUnitPieceMap(unitID)
reseT(inPieces)

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

Spring.SetUnitNanoPieces(unitID,{ center})

