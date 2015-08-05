include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"

piecesTable={}
center = piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
jHarbour3DS = piece"jHarbour.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= jHarbour3DS
Cell1 = piece"Cell1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell1
Cell10 = piece"Cell10"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell10
Cell11 = piece"Cell11"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell11
Cell12 = piece"Cell12"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell12
Cell13 = piece"Cell13"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell13
Cell14 = piece"Cell14"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell14
Cell15 = piece"Cell15"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell15
Cell16 = piece"Cell16"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell16
Cell2 = piece"Cell2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell2
Cell3 = piece"Cell3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell3
Cell4 = piece"Cell4"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell4
Cell5 = piece"Cell5"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell5
Cell6 = piece"Cell6"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell6
Cell7 = piece"Cell7"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell7
Cell8 = piece"Cell8"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell8
Cell9 = piece"Cell9"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Cell9
CellRing1 = piece"CellRing1"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CellRing1
CellRing2 = piece"CellRing2"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CellRing2
CellRing3 = piece"CellRing3"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CellRing3
CellRing4 = piece"CellRing4"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CellRing4
CellRing5 = piece"CellRing5"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CellRing5

CellRing0 = piece"CellRing0"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= CellRing0

Kreis01 = piece"Kreis01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis01
Kreis02 = piece"Kreis02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis02
Kreis03 = piece"Kreis03"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kreis03
Kugel01 = piece"Kugel01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kugel01
Kugel02 = piece"Kugel02"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Kugel02

CellRings={}
for i=1,5, 1 do
name="CellRing"..i
CellRings[i]=piece(name)
end

function script.Create()
--generatepiecesTableAndArrayCode(unitID)
StartThread(addWaterLvl)
StartThread(float)
StartThread(CellWiggling)
StartThread(CenterCellRingTurn)
StartThread(waterDrop)
end

function waterDrop()
	while true do
	Show(Kugel02)
	Move(Kugel02,y_axis,-100,31)
	WaitForMove(Kugel02,y_axis)
	Hide(Kugel02)
	Move(Kugel02,y_axis,0,0)
	Sleep(1900)
	end
end

function float()
Spin(Kreis03,y_axis,math.rad(22),0)
Spin(Kreis01,y_axis,math.rad(22),0)
Spin(Kreis02,y_axis,math.rad(-22),0)
Spin(Kugel01,y_axis,math.rad(-22),0)
	while true do
	Move(center,y_axis,-10,2.3)
	Move(Kreis03,y_axis,15,2.3)
	Move(Kreis02,y_axis,12.5,2.3)
	Move(Kreis01,y_axis,10,2.3)
	WaitForMove(Kreis03,y_axis)
	Move(center,y_axis,0,2.3)
	Move(Kreis03,y_axis,-5,2.3)
	Move(Kreis02,y_axis,-2.5,2.3)
	Move(Kreis01,y_axis,0,2.3)
	WaitForMove(Kreis03,y_axis)
	Sleep(30)
	end

end




function CenterCellRingTurn()

	while true do
	Turn(CellRing0,y_axis,math.rad(0),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-47),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-94),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-141),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-188),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-235),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-281),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-327),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-281),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-235),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-188),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-141),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-94),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(-47),0)
	Sleep(120)
	Turn(CellRing0,y_axis,math.rad(0),0)
	Sleep(120)

	end

end


function CellWiggling()
	while true do
	for i=1,#CellRings do
	Turn(CellRings[i],y_axis,math.rad(math.random(-5,5)),0.1)
	end
	dice=math.random(190,500)
	Sleep(math.ceil(dice))
end

end


local g_AddOnRate=0.015


function addWaterLvl()
Sleep(200)
	while(true) do
		if GG.addWaterLevel ~= nil then

		GG.addWaterLevel=GG.addWaterLevel+g_AddOnRate
		--Spring.Echo(GG.addWaterLevel)
		Sleep(1000)
		--Spring.Echo("WaterUp",g_WaterOffSet)
		else
		Sleep(1000)
		end
	end
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end


function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
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

