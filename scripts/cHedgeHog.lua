include "suddenDeath.lua"
include "toolKit.lua"

 piecesTable={}
 center = piece"center"
 piecesTable[#piecesTable+1]= center
 hegehog3DS = piece"hegehog.3DS"
 piecesTable[#piecesTable+1]= hegehog3DS
 main = piece"main"
 piecesTable[#piecesTable+1]= main
 turret = piece"turret"
 piecesTable[#piecesTable+1]= turret
 molttur = piece"molttur"
 piecesTable[#piecesTable+1]= molttur
 molt1 = piece"molt1"
 piecesTable[#piecesTable+1]= molt1
 molt2 = piece"molt2"
 piecesTable[#piecesTable+1]= molt2
 molt3 = piece"molt3"
 piecesTable[#piecesTable+1]= molt3
 plank = piece"plank"
 piecesTable[#piecesTable+1]= plank
 moltplank = piece"moltplank"
 piecesTable[#piecesTable+1]= moltplank
 store1 = piece"store1"
 piecesTable[#piecesTable+1]= store1
 store2 = piece"store2"
 piecesTable[#piecesTable+1]= store2
 store3 = piece"store3"
 piecesTable[#piecesTable+1]= store3
 turm1 = piece"turm1"
 piecesTable[#piecesTable+1]= turm1
 darkMatter1 = piece"darkMatter1"
 piecesTable[#piecesTable+1]= darkMatter1
 Hat1 = piece"Hat1"
 piecesTable[#piecesTable+1]= Hat1
 Hat2 = piece"Hat2"
 piecesTable[#piecesTable+1]= Hat2
 Hat3 = piece"Hat3"
 piecesTable[#piecesTable+1]= Hat3
 Hat4 = piece"Hat4"
 piecesTable[#piecesTable+1]= Hat4
 Hat5 = piece"Hat5"
 piecesTable[#piecesTable+1]= Hat5
 Hat6 = piece"Hat6"
 piecesTable[#piecesTable+1]= Hat6
 Hedghehog6 = piece"Hedghehog6"
 piecesTable[#piecesTable+1]= Hedghehog6
 Hedghehog1 = piece"Hedghehog1"
 piecesTable[#piecesTable+1]= Hedghehog1
 Hedghehog2 = piece"Hedghehog2"
 piecesTable[#piecesTable+1]= Hedghehog2
 Hedghehog3 = piece"Hedghehog3"
 piecesTable[#piecesTable+1]= Hedghehog3
 Hedghehog4 = piece"Hedghehog4"
 piecesTable[#piecesTable+1]= Hedghehog4
 Hedghehog5 = piece"Hedghehog5"
 piecesTable[#piecesTable+1]= Hedghehog5
armsbegin=#piecesTable+1
 robpivot1 = piece"robpivot1"
 piecesTable[#piecesTable+1]= robpivot1
 rob1 = piece"rob1"
 piecesTable[#piecesTable+1]= rob1
 robup1 = piece"robup1"
 piecesTable[#piecesTable+1]= robup1
 robpivot2 = piece"robpivot2"
 piecesTable[#piecesTable+1]= robpivot2
 rob2 = piece"rob2"
 piecesTable[#piecesTable+1]= rob2
 robup2 = piece"robup2"
 piecesTable[#piecesTable+1]= robup2
 robpivot3 = piece"robpivot3"
 piecesTable[#piecesTable+1]= robpivot3
 rob3 = piece"rob3"
 piecesTable[#piecesTable+1]= rob3
 robup3 = piece"robup3"
 piecesTable[#piecesTable+1]= robup3
 robpivot4 = piece"robpivot4"
 piecesTable[#piecesTable+1]= robpivot4
 rob4 = piece"rob4"
 piecesTable[#piecesTable+1]= rob4
 robup4 = piece"robup4"
armsend=#piecesTable+1
 piecesTable[#piecesTable+1]= robup4
 Linie04 = piece"Linie04"
 piecesTable[#piecesTable+1]= Linie04
 turm2 = piece"turm2"
 piecesTable[#piecesTable+1]= turm2
 darkMatter2 = piece"darkMatter2"
 piecesTable[#piecesTable+1]= darkMatter2
 turm3 = piece"turm3"
tow3begin=#piecesTable
	 piecesTable[#piecesTable+1]= turm3
	 darkMatter3 = piece"darkMatter3"
	 piecesTable[#piecesTable+1]= darkMatter3
	 Rail = piece"Rail"
	 piecesTable[#piecesTable+1]= Rail
	 Inj1 = piece"Inj1"
	 piecesTable[#piecesTable+1]= Inj1
	 Inj2 = piece"Inj2"
	 piecesTable[#piecesTable+1]= Inj2
	 Inj3 = piece"Inj3"
	 piecesTable[#piecesTable+1]= Inj3
	 Inj4 = piece"Inj4"
	 piecesTable[#piecesTable+1]= Inj4
	 Inj5 = piece"Inj5"
	 piecesTable[#piecesTable+1]= Inj5
	 Inj6 = piece"Inj6"
	 piecesTable[#piecesTable+1]= Inj6
	 Inj7 = piece"Inj7"
	 piecesTable[#piecesTable+1]= Inj7
	 Inj8 = piece"Inj8"
	 piecesTable[#piecesTable+1]= Inj8
	 Inj9 = piece"Inj9"
	 piecesTable[#piecesTable+1]= Inj9
	 Inj10 = piece"Inj10"
	 piecesTable[#piecesTable+1]= Inj10
	 Inj11 = piece"Inj11"
	 piecesTable[#piecesTable+1]= Inj11
	 Inj12 = piece"Inj12"
	 piecesTable[#piecesTable+1]= Inj12
	 rail1 = piece"rail1"
	 piecesTable[#piecesTable+1]= rail1
	 rail2 = piece"rail2"
	 piecesTable[#piecesTable+1]= rail2
	 rail3 = piece"rail3"
	 piecesTable[#piecesTable+1]= rail3
	 rail4 = piece"rail4"
	 piecesTable[#piecesTable+1]= rail4
	 rail5 = piece"rail5"
	 piecesTable[#piecesTable+1]= rail5
	 rail6 = piece"rail6"
	 piecesTable[#piecesTable+1]= rail6
	 rail7 = piece"rail7"
	 piecesTable[#piecesTable+1]= rail7
	 rail8 = piece"rail8"
	 piecesTable[#piecesTable+1]= rail8
	 additonals3DS = piece"additonals.3DS"
	 piecesTable[#piecesTable+1]= additonals3DS
	 Phial1 = piece"Phial1"
	 piecesTable[#piecesTable+1]= Phial1
	 Phial2 = piece"Phial2"
	 piecesTable[#piecesTable+1]= Phial2
	 Phial3 = piece"Phial3"
	 piecesTable[#piecesTable+1]= Phial3
	 Phial4 = piece"Phial4"
	 piecesTable[#piecesTable+1]= Phial4
	 Phial5 = piece"Phial5"
	 piecesTable[#piecesTable+1]= Phial5
tow3end=#piecesTable
 antirecoil = piece"antirecoil"
 piecesTable[#piecesTable+1]= antirecoil
 Kette4 = piece"Kette4"
 piecesTable[#piecesTable+1]= Kette4
 Kette5 = piece"Kette5"
 piecesTable[#piecesTable+1]= Kette5
 Kapper1 = piece"Kapper1"
 piecesTable[#piecesTable+1]= Kapper1
 Kappel1 = piece"Kappel1"
 piecesTable[#piecesTable+1]= Kappel1
 Kapper2 = piece"Kapper2"
 piecesTable[#piecesTable+1]= Kapper2
 Kappel2 = piece"Kappel2"
 piecesTable[#piecesTable+1]= Kappel2
 Kapper3 = piece"Kapper3"
 piecesTable[#piecesTable+1]= Kapper3
 Kappel3 = piece"Kappel3"
 piecesTable[#piecesTable+1]= Kappel3
 Kapper4 = piece"Kapper4"
 piecesTable[#piecesTable+1]= Kapper4
 Kappel4 = piece"Kappel4"
 piecesTable[#piecesTable+1]= Kappel4
 Kapper5 = piece"Kapper5"
 piecesTable[#piecesTable+1]= Kapper5
 Kappel5 = piece"Kappel5"
 piecesTable[#piecesTable+1]= Kappel5
 Kapper6 = piece"Kapper6"
 piecesTable[#piecesTable+1]= Kapper6
 Kappel6 = piece"Kappel6"
 piecesTable[#piecesTable+1]= Kappel6
 steg1 = piece"steg1"
 piecesTable[#piecesTable+1]= steg1
 gondel2 = piece"gondel2"
 piecesTable[#piecesTable+1]= gondel2
 Kette7 = piece"Kette7"
 piecesTable[#piecesTable+1]= Kette7
 Kette11 = piece"Kette11"
 piecesTable[#piecesTable+1]= Kette11
 Glow4 = piece"Glow4"
 piecesTable[#piecesTable+1]= Glow4
 Glow1 = piece"Glow1"
 piecesTable[#piecesTable+1]= Glow1
 Glow2 = piece"Glow2"
 piecesTable[#piecesTable+1]= Glow2
 Glow3 = piece"Glow3"
 piecesTable[#piecesTable+1]= Glow3
 Glow5 = piece"Glow5"
 piecesTable[#piecesTable+1]= Glow5
 Glow6 = piece"Glow6"
 piecesTable[#piecesTable+1]= Glow6
 steg3 = piece"steg3"
 piecesTable[#piecesTable+1]= steg3
 gondel3 = piece"gondel3"
 piecesTable[#piecesTable+1]= gondel3
 Kette6 = piece"Kette6"
 piecesTable[#piecesTable+1]= Kette6
 Kette9 = piece"Kette9"
 piecesTable[#piecesTable+1]= Kette9
 steg2 = piece"steg2"
 piecesTable[#piecesTable+1]= steg2
 gondel1 = piece"gondel1"
 piecesTable[#piecesTable+1]= gondel1
 Kette1 = piece"Kette1"
 piecesTable[#piecesTable+1]= Kette1
 Kugel02 = piece"Kugel02"
 piecesTable[#piecesTable+1]= Kugel02
 Kette2 = piece"Kette2"
 piecesTable[#piecesTable+1]= Kette2
 Glowr1 = piece"Glowr1"
 piecesTable[#piecesTable+1]= Glowr1
 Glowr2 = piece"Glowr2"
 piecesTable[#piecesTable+1]= Glowr2
 Glowr3 = piece"Glowr3"
 piecesTable[#piecesTable+1]= Glowr3
 Glowr4 = piece"Glowr4"
 piecesTable[#piecesTable+1]= Glowr4
 Glowr5 = piece"Glowr5"
 piecesTable[#piecesTable+1]= Glowr5
 Glowr6 = piece"Glowr6"
 piecesTable[#piecesTable+1]= Glowr6
 steg4 = piece"steg4"
 piecesTable[#piecesTable+1]= steg4
 gondel4 = piece"gondel4"
 piecesTable[#piecesTable+1]= gondel4
 Kette3 = piece"Kette3"
 piecesTable[#piecesTable+1]= Kette3
 Kette10 = piece"Kette10"
 piecesTable[#piecesTable+1]= Kette10
 aimpoint = piece"aimpoint"
 piecesTable[#piecesTable+1]= aimpoint
Heat={
	"Hat",
	"Hedghehog",
	"Kappel",
	"Kapper",
	"Glowr",
	"Glow"
}

local HeatPieces={}
for j=1,6, 1 do
HeatPieces[j]={}
for i=1,6, 1 do
tempy=Heat[j]..i
HeatPieces[j][i]=piece(tempy)
end
end

SIG_HEAT=2
SIG_EPICFLAIL=4
function hideTurm3()
	for i=tow3begin,tow3end,1 do
	Hide(piecesTable[i])
	end
end

function showTurm3()
	for i=tow3begin,tow3end,1 do
	Show(piecesTable[i])
	end


end
function flailArms()
SetSignalMask(SIG_EPICFLAIL)
while(true) do		
		i=0
		while(i<2) do
				for i=1,armsend-armsbegin,3 do
				Turn(piecesTable[armsbegin+i],y_axis,math.rad(math.random(110,140)),7)
				Turn(piecesTable[armsbegin+i+1],y_axis,math.rad(math.random(45,66)),7)
				end
			Sleep(500)
			if math.random(0,1)==1 then
				for i=0,armsend-armsbegin,3 do
				Turn(piecesTable[(armsbegin+i)],z_axis,math.rad(math.random(0,360)),3)
				end
				WaitForTurn(piecesTable[armsbegin],z_axis)
			end
			WaitForTurn(piecesTable[armsbegin],x_axis)

				for i=1,armsend-armsbegin,3 do
				Turn(piecesTable[armsbegin+i],y_axis,math.rad(math.random(0,25)),7)
				Turn(piecesTable[armsbegin+i+1],y_axis,math.rad(math.random(0,15)),7)
				end

			Sleep(500)
				for i=1,armsend-armsbegin,3 do
				Turn(piecesTable[armsbegin+i],y_axis,math.rad(math.random(110,140)),7)
				Turn(piecesTable[armsbegin+i+1],y_axis,math.rad(math.random(45,66)),7)
				end
			WaitForTurn(piecesTable[armsbegin],y_axis)
		i=i+1
		end
		
		Move(robpivot1,z_axis,-5,3)
		Move(robpivot2,z_axis,-5,3)
		Move(robpivot3,z_axis,-5,3)
		Move(robpivot4,z_axis,-5,3)
		WaitForMove(robpivot4,z_axis)
			for i=0,armsend-armsbegin,3 do
			Turn(piecesTable[(armsbegin+i)],z_axis,math.rad(math.random(0,360)),0)
			end
		
		Move(robpivot1,z_axis,0,6)
		Move(robpivot2,z_axis,0,6)
		Move(robpivot3,z_axis,0,6)
		Move(robpivot4,z_axis,0,6)
		WaitForMove(robpivot4,x_axis)
		
		end
end
function theHeat()



SetSignalMask(SIG_HEAT)
	for j=1,6, 1 do
	for i=1,6, 1 do
	Hide(HeatPieces[j][i])
	end
	end

	for j=6,1, -1 do
		for i=1,6, 1 do
		Show(HeatPieces[i][j])
		end
	Sleep(1000)
		for i=1,6, 1 do
		Hide(HeatPieces[i][j])
		end

	end
		for i=1,4, 1 do
		Show(HeatPieces[i][1])
		end

	Sleep(6000)
	end


torret1="standby"
torret2="standby"
torret3="standby"
--fireReady standby inactive
boolCanFire=false
ressourceTimer=500

SIG_AIM=16
currentTower=turm1
function torretManagment()
hideTurm3()
StartThread(flailArms)
	while(true) do
	--checkIfaTurretIsInPosition
	if  torret3 ~="fireReady" then 
			if torret1 == "standby" or torret2== "standby" and boolRailsBlocked == false then	
				if torret1 == "standby" then
			
				Move(turm1,x_axis,10,2.5)
				Move(turm1,z_axis,5,1.25)
				WaitForMove(turm1,x_axis)
				WaitForMove(turm1,z_axis)
				Hide(turm1)
				Hide(darkMatter1)
				Move(turm1,z_axis,-60,0)
				torret1="inactive"
					elseif torret2== "standby" then
				
					Move(turm2,x_axis,-10,2.5)
					Move(turm2,z_axis,5,1.25)
					WaitForMove(turm2,x_axis)
					WaitForMove(turm2,z_axis)	
					Hide(turm2)
					Hide(darkMatter2)
					Move(turm2,z_axis,-60,0)
					torret2="inactive"
					end
			boolRailsBlocked=true
			Move(turm3,z_axis,7.5,0)
			showTurm3()
			Move(Hat1,x_axis,-10,3.141)
			Move(Hat1,z_axis,-15,12.141)
			Move(turm3,z_axis,107,3.141)
			WaitForMove(turm3,z_axis)
			
			WaitForMove(Hat1,x_axis)
			WaitForMove(turm3,x_axis)
			
			Move(Hat1,x_axis,0,3.141)
			Move(Hat1,z_axis,0,3.141)
			WaitForMove(Hat1,z_axis)
			torret3="fireReady"
			boolRailsBlocked=false
			boolCanFire=true	
			--If no and a turret exists that is on standby roll it out
			
			end
	end
	ressourceTimer=ressourceTimer-1
	--check if the ressourceTimer < 0
	-- if yes, check if on of the tree turrets is inactive
	if ressourceTimer < 0 and boolCanFire == false then 
	ressourceTimer=5000
	StartThread(buildATurret)
	end

	-- if it is so, build a turret

	Sleep(250)
	end

end
--inactive --standby  --fireReady

boolRailsBlocked=false
function railsCondition()
	while (boolRailsBlocked==true) do
	Sleep(250)
	end
	


end

function DamageATurret()
	if torret1== "standby" then
	torret1="inactive"
	railsCondition()
	Move(turm1,z_axis,7,3)
	WaitForMove(turm1,z_axis)
	Move(turm1,x_axis,-12,3)
	WaitForMove(turm1,x_axis)
	Move(turm1,z_axis,-46,3)
	WaitForMove(turm1,z_axis)
	Hide(turm1)
	Hide(darkMatter1)
	boolRailsBlocked=false
		elseif torret2 == "standby" then 
		torret2="inactive"
		railsCondition()

		Move(turm2,z_axis,7,3)
		WaitForMove(turm2,z_axis)
		Move(turm2,x_axis,12,3)
		WaitForMove(turm2,x_axis)
		Move(turm2,z_axis,-46,3)
		WaitForMove(turm2,z_axis)
		Hide(turm2)
		Hide(darkMatter2)
		boolRailsBlocked=false
			elseif torret3 == "standby" then
			torret3="inactive"
			railsCondition()

			Move(turm3,z_axis,-46,3)
			WaitForMove(turm3,z_axis)
			Hide(turm3)
			Hide(darkMatter3)


			boolRailsBlocked=false
			end

end

function buildATurret()
boolCanFire=false
	if torret1 == "inactive" then
	Show(turm1)
	Move(turm1,z_axis,7,1.2)
	WaitForMove(turm1,z_axis)
	Show(darkMatter1)
	Move(turm1,x_axis,0,1.2)
	Move(turm1,z_axis,0,1.2)
	WaitForMove(turm1,z_axis)
	torret1="standby"	
		elseif torret2 =="inactive" then
		Show(turm2)
		Move(turm2,z_axis,7,1.2)
		WaitForMove(turm1,z_axis)
		Show(darkMatter2)
		Move(turm2,x_axis,0,1.2)
		Move(turm2,z_axis,0,1.2)
		WaitForMove(turm2,z_axis)
		torret2="standby"
			else
			--Spring.Echo("How did you reach this case?")
			end
boolCanFire=true
end

function retractBurnedRod()
Move(moltplank,y_axis,2,0.9)
Move(moltplank,z_axis,-120,6.9)
Move(plank,z_axis,-53,0)
Show(plank)
Move(plank,z_axis,0,0.4)
WaitForMove(moltplank,z_axis)
Hide(moltplank)
Move(moltplank,y_axis,0,0)
Move(moltplank,z_axis,0,0)
end




function fireATurret()

EmitSfx(molttur,1025)
boolCanFire=false
boolRailsBlocked=true
Signal(SIG_HEAT)
StartThread(theHeat)
Move(antirecoil,z_axis,85,256)
--Sfx 
for i=tow3begin,tow3end,1 do
Hide(piecesTable[i])
end
Turn(turm3,y_axis,math.rad(0),0)

if math.random(0,1)==1 then Show(molt1)
	elseif math.random(0,1)==0 then Show(molt2) 
		else Show(molt3) end
		Move(Hat1,z_axis,-26,100)
		Sleep(350)
		x=-9
		if math.random(0,1)==0 then x=9 end
		Move(Hat1,y_axis,x,100)
		Signal(SIG_EPICFLAIL)
		StartThread(flailArms)
			Move(molttur,z_axis,-60,82)
		WaitForMove(molttur,z_axis)
		Move(molttur,z_axis,-80,42)
		WaitForMove(molttur,z_axis)
		Move(molttur,z_axis,-110,22)
		WaitForMove(molttur,z_axis)
Hide(plank)
Show(moltplank)
StartThread(retractBurnedRod)		
		
Hide(molttur)
Hide(molt1)
Hide(molt2)
Hide(molt3)
reset(molttur)
boolRailsBlocked=false
Signal(SIG_EPICFLAIL)
WaitForMove(antirecoil,z_axis)
Move(antirecoil,z_axis,0,9)
end

function reset(piece)
Move(piece,x_axis,0,0)
Move(piece,y_axis,0,0)
Move(piece,z_axis,0,0)
end

function script.HitByWeapon ( x, z, weaponDefID, damage )
	if math.random(0,32) == 16 then
	--you are dead, and you know it
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	Spring.CreateUnit("cawilduniverseappears",x,y,z, 0, teamID)  
	else
	DamageATurret()
	
	end

end

function HeatTestLoop()

	while(true) do
	Signal(SIG_HEAT)
	StartThread(theHeat)
	naptime=math.ceil(math.random(12000,60000))
	Sleep(naptime)
	end
end

function script.Create()
	for i=1,#piecesTable,1 do
	Show(piecesTable[i])
	end

Hide(molt2)
Hide(molt3)
Hide(molt1)
Hide(molttur)
Hide(moltplank)
Spin(darkMatter1,y_axis,math.rad(42),0.42)
Spin(darkMatter2,y_axis,math.rad(42),0.42)
Spin(darkMatter3,y_axis,math.rad(42),0.42)
--Heatshield
	for j=1,6, 1 do
	for i=1,6, 1 do
	Hide(HeatPieces[j][i])
	end
	end
	for j=1,4, 1 do
	Show(HeatPieces[j][1])
	end
	
StartThread(HeatTestLoop)
StartThread(torretManagment)
end

function script.Killed()

	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	Spring.CreateUnit("cawilduniverseappears",x,y,z, 0, teamID)  


return 0
end


	

	
function script.StartMoving()
							
end

function script.StopMoving()

end

			
		
		
-------------------------------------------------------------------------------

function script.AimFromWeapon1() 	
	
	

return turm3 end
	
function script.QueryWeapon1() 
return turm3
end
filename="sounds/chedgehog/hedgehog"
	
function fireAnimation()


		for i=1,4, 1 do
		temp=filename..i..".ogg"
		Spring.PlaySoundFile(temp,1.0)
		Sleep(1200)
		end		


for i=tow3begin,tow3end,1 do
reset(piecesTable[i])
end
end
	
	
	function script.AimWeapon1( heading, pitch )
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
			if boolCanFire==true then
			Turn(turm3,y_axis,heading,0.12)
			WaitForTurn(turm3,y_axis)
			return true
		    end
	return false
	end


	function script.FireWeapon1()
	StartThread(fireATurret)
	fireAnimation()
   end