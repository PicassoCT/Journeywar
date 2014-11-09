center=piece"center"
beans= piece"beans"
beanstalk=piece"beanstalk"
introgroup =piece"introgroup"
bean1 =piece"bean1"
seed =piece"seed"
rootGroup=piece"rootGroup"
seedRotator=piece"seedRotator"
bshelix=piece"bshelix"
unRooted=piece"unRooted"
bsfetas=piece"bsfetas"
growGroup=piece"growGroup"
local SIG_ENTER=1
local SIG_PUMP=2
local SIG_DIRT=4
local SIG_PIPE=8
local SIG_LEAVE=16
teamID=Spring.GetUnitTeam(unitID)
local currentpiece=piece"somemit1"
buildemitcenter= piece"buildemitcenter"
emitIt={}
for i=1,6,1 do
emitIt[i]={}
stone= "somemit"..i
emitIt[i]=piece (stone)
end

spindl= piece"spindl"
spindl2=piece"spindl2"
spindl3=piece"spindl3"
pipePieces={}
for i=1,59,1 do
pipePieces[i]={}
stone= "bspip01p"..i
pipePieces[i]=piece (stone)
end

pumps={}
for i=1,5,1 do
pumps[i]={}
stone= "pump"..i
pumps[i]=piece (stone)
end

greenSleaves={}
for i=1,14,1 do
greenSleaves[i]={}
stone= "growLea"..i
greenSleaves[i]=piece (stone)
end

bean1=piece"bean1"
bean2=piece"bean2"
bean3=piece"bean3"
rootgrow=piece"rootgrow"
rootRotate=piece"rootRotate"




wurzelballen={}

for i=1,4,1 do
wurzelballen[i]={}
stone= "Wurzelbal"..i
wurzelballen[i]=piece (stone)
end




dirt={}
for i=1,6,1 do
dirt[i]={}
stone= "Dirt"..i
dirt[i]=piece (stone)
end
fireFx1=piece"fireFx1"
fireFx2=piece"fireFx2"
fireFx3=piece"fireFx3"
spiralCenter= piece"spiralCenter"

testTable={}

function greatEntry()

tableOfPieces={}
tableOfPieces=Spring.GetUnitPieceList(unitID)

for i=1,table.getn(tableOfPieces),1 do
name=tableOfPieces[i]
x=piece(name)
testTable[i]={}
testTable[i]=x

end

for i=1,table.getn(testTable),1 do
Hide(testTable[i])
end
Show(beanstalk)
Show(unRooted)
Move(center,y_axis, 180,12)
	for i=1,6,1 do
		
		
			
	Move(dirt[i],y_axis,-180,12)
			
	end

while(Spring.UnitScript.IsInMove (center, y_axis)) do
Sleep(50)
		for i=1,6,1 do
		rondo=math.random(190,420)
		
				for i=1,6,1 do
				EmitSfx(dirt[i],1028)
				EmitSfx(dirt[i],1028)
				end
		
		Sleep(rondo)
		end
end
end


function script.Create()
Hide(unRooted)
Hide(spindl)
Hide(spindl2)
Hide(spindl3)
Hide(fireFx1)
Hide(fireFx2)
Hide(fireFx3)


StartThread(greatEntry)
StartThread(waitingGame)
StartThread(unfoldLeaves)

end

function script.Killed()

end
local boolreVert=false


function unfoldLeaves()


SetSignalMask(SIG_LEAVE)
xo,yo,zo=Spring.GetUnitPosition(unitID)
Sleep(1000)

	while(true) do
	x,y,z=Spring.GetUnitPosition(unitID)
	divX,divY,divZ=xo-x,yo-y,zo-z
	xo,yo,zo=x,y,z
	
			for i=1,table.getn(greenSleaves),1 do
			Move(greenSleaves[i],y_axis,0,0)
			Spin(greenSleaves[i],y_axis,math.rad(22),2)
			Show(greenSleaves[i])
			Move(greenSleaves[i],y_axis,1200,22)
				Move(greenSleaves[i],x_axis,divX*5,12)
				Move(greenSleaves[i],z_axis,divZ*5,12)
			end
			
			WaitForMove(greenSleaves[14],y_axis)
		Sleep(1000)
	end
end



function waitingGame()
	while(true) do
		if boolreVert==true and (Spring.ValidUnitID (unitID)) then
		Move(center,y_axis, 0,12)
		WaitForMove(center,y_axis)
				if boolreVert==true and (Spring.ValidUnitID (unitID)) then
			   local x,y,z=Spring.GetUnitPosition (unitID)
			   local teamID = Spring.GetUnitTeam (unitID)
				mexID= Spring.CreateUnit("dbeanstalk", x, y, z, 0, teamID) 
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(mexID,health)	
				Spring.DestroyUnit (unitID,false,true)
				end
		end
		  
		  
	  

	Sleep(1000)
	end
end

function script.Activate ( )
boolreVert=false

--boolUnDeployed=false
--boolSafetyFirst=true
	return 1
  end

function script.Deactivate ( )
boolreVert=true
--if boolSafetyFirst==true then
--boolUnDeployed=true
--end
--Place Unmorpher here
	return 0
  end


