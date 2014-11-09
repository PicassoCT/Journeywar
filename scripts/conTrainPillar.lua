local unitTeam = Spring.GetUnitTeam (unitID)

pillar1 = {}

cPilar1 = 		piece"cPilar1" 
table.insert(pillar1,cPilar1   )
cRstealthC1= 	piece"cRstealthC1" 
table.insert(pillar1, cRstealthC1  )
cPillarCro1= 	piece"cPillarCro1" 
table.insert(pillar1,cPillarCro1   )
cPilarMech1=	piece"cPilarMech1" 
table.insert(pillar1, cPilarMech1  )
cRailWay11 = 	piece"cRailWay11" 
table.insert(pillar1, cRailWay11  )
cRailFold11 = 	piece"cRailFold11" 
table.insert(pillar1,cRailFold11   )
cRailR11 = 		piece"cRailR11" 
table.insert(pillar1, cRailR11  )
cRailL11 = 		piece"cRailL11" 
table.insert(pillar1,cRailL11   )
cRailWay12 = 	piece"cRailWay12"
 table.insert(pillar1, cRailWay12  )
cRailFold12 =	 piece"cRailFold12" 
table.insert(pillar1, cRailFold12  )
cRailR12 = 		piece"cRailR12" 
table.insert(pillar1, cRailR12  )
cRailL12 = 		piece"cRailL12"
table.insert(pillar1,cRailL12   )



function foldPillar()
--	case one or six, wait till pillar is folded, then move it Under
for i=1,12,1 do
Hide(pillar1[i])
end
for i=1,12,1 do
Show(pillar1[i])
end
speedO=3

														
														
														
											

Turn(pillar1[7],z_axis,math.rad(50),speedO)
Turn(pillar1[11],z_axis,math.rad(50),speedO)
WaitForTurn(pillar1[11],z_axis)
WaitForTurn(pillar1[6],z_axis)

--fold railways
Turn(pillar1[5],y_axis,math.rad(65),speedO)
Turn(pillar1[9],y_axis,math.rad(-69),speedO)--
Turn(pillar1[6],z_axis,math.rad(85),speedO)
Turn(pillar1[10],z_axis,math.rad(87),speedO)--

WaitForTurn(pillar1[6],z_axis)
WaitForTurn(pillar1[10],z_axis)
--raise Railways

Turn(pillar1[5],x_axis,math.rad(90),speedO)
Turn(pillar1[9],x_axis,math.rad(-90),speedO)
WaitForMove(pillar1[5],x_axis)
WaitForMove(pillar1[9],x_axis)

--retract pillar
Move(pillar1[3],y_axis,-50,speedO*2)
WaitForMove(pillar1[3],y_axis)
Hide(pillar1[5])
Hide(pillar1[9])
Hide(pillar1[6])
Hide(pillar1[10])

--cap Pillar
Turn(pillar1[2],z_axis,math.rad(150),speedO)
WaitForTurn(pillar1[2],z_axis)
Turn(pillar1[2],z_axis,math.rad(86),speedO)
WaitForTurn(pillar1[2],z_axis)
Turn(pillar1[2],z_axis,math.rad(0),speedO)
WaitForTurn(pillar1[2],z_axis)



														
Move(pillar1[1],y_axis,-37,speedO)
WaitForMove(pillar1[1],y_axis)		

Sleep(1000)
Spring.DestroyUnit (unitID,false,true)																
end




function script.Create()
Spring.SetUnitNeutral(unitID, true ) 
Turn(pillar1[2],z_axis,math.rad(-200),0)
Turn(cRstealthC1,z_axis,math.rad(200))
StartThread(foldPillar)
end

function script.Killed()
rando=math.random(0,45)
Turn(pillar1[1],y_axis,math.rad(rando),17)
Turn(pillar1[1],z_axis,math.rad(20),17)
WaitForTurn(pillar1[1],z_axis)
Turn(pillar1[1],z_axis,math.rad(60),27)
WaitForTurn(pillar1[1],z_axis)
Turn(pillar1[1],z_axis,math.rad(80),47)
WaitForTurn(pillar1[1],z_axis)
for i=1,12,1 do
EXPLODE(pillar1[i],SFX.FALL+SFX.FIRE)
end

end


