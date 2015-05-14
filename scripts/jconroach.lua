
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 


--unitPieces
local nanopiece = piece "nanopiece"
local conRoach = piece "conRoach"

local boolbuilding=false
local SIG_BUILD=2
local boolMoving=false
legz={}
for i=1, 8, 1 do
legz[i]={}

temp="cdleg"..i
legz[i]=piece(temp)
end

function turnALeg(piecenr)
	if piecenr%2 == 0 then
	Turn(legz[piecenr],y_axis,math.rad(-35),11)
	WaitForTurn(legz[piecenr],y_axis)
	Turn(legz[piecenr],y_axis,math.rad(0),11)
	Turn(legz[piecenr],x_axis,math.rad(-16),32)
	WaitForTurn(legz[piecenr],y_axis)
	Turn(legz[piecenr],x_axis,math.rad(0),52)
		else
		Turn(legz[piecenr],y_axis,math.rad(35),11)
		WaitForTurn(legz[piecenr],y_axis)
		Turn(legz[piecenr],y_axis,math.rad(0),11)
		Turn(legz[piecenr],x_axis,math.rad(16),32)
		WaitForTurn(legz[piecenr],y_axis)
		Turn(legz[piecenr],x_axis,math.rad(0),52)
		end

end

function moveStateCheck()
while(true) do

	while(boolMoving==true) do
	Spring.PlaySoundFile("sounds/jroach/roachwalk.wav",0.5)  
		for i=1, 8, 1 do
		StartThread(turnALeg,i)
		Sleep(125)
		end


	end


Sleep(150)
end


end



function script.StartMoving()
boolMoving=true

end

function script.StopMoving()

 boolMoving=false

end




function script.Create()

StartThread(moveStateCheck)
end

function script.Killed()
Move(conRoach,y_axis,13,0)
xi=math.random(0,1)
if xi== 1 then
xi=12
else
xi= -8

end
--case its a health bomb
hp=Spring.GetUnitHealth(unitID)
	if hp > 0 then
	x,y,z=Spring.GetUnitPosition(unitID)
	teamid=Spring.GetUnitTeam(unitID)
	T=grabEveryone(unitID,x,z,90,teamid)
	hp=math.ceil(math.ceil(hp/2)/#T)
		for i=1,#T do
		EmitSfx(legz [(i%8)+1],1024)
			p=Spring.GetUnitHealth(T[i])
			if p then
			Spring.SetUnitHealth(T[i],p+hp)
			end
		end
	
	
	end

Spin(conRoach,y_axis,math.rad(xi),0.1)
Turn(conRoach,x_axis,math.rad(180),20)
total=math.random(2,7)
for i=1, total, 1 do
Spring.PlaySoundFile("sounds/jroach/roachbuild.wav")  
	for i=1, 8, 1 do
	StartThread(turnALeg,i)
	Sleep(125)
	end  
Sleep(300)
end
Sleep(700)
return 1
end

function building()
SetSignalMask(SIG_BUILD)
			while(boolbuilding==true) do
			Sleep(125)
			actualHealth=Spring.GetUnitHealth (unitID ) 
															if actualHealth <= 1 then
															actualHealth=actualHealth-1
															 Spring.SetUnitNoSelect (unitID, true)
															--makes the Unit go home, to the place it was born- west Virginia
															Spring.SetUnitHealth(unitID,actualHealth)
															end
				actualHealth=actualHealth-1
				Spring.SetUnitHealth(unitID,actualHealth)


				mi=math.random(0,6)
				if mi==2 then
				Spring.PlaySoundFile("sounds/jroach/roachbuild.wav")  
				end


			Sleep(125)
			end

end

function script.StopBuilding()

    boolbuilding=false
	Signal(SIG_BUILD)
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)
	Spring.PlaySoundFile("sounds/jroach/roachbuild2.wav")  
    boolbuilding=true
	Signal(SIG_BUILD)
	StartThread(building)
							
	SetUnitValue(COB.INBUILDSTANCE, 1)
end


function script.QueryNanoPiece()
     return nanopiece
end


--------BUILDING---------









