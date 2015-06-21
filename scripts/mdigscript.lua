include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

local spinAroundSpot= piece "spinAroundSpot"

treeSpot=piece"treeSpot"
local mdwheelcenter= piece "mdwheelcenter"
local mdwheell= piece"mdwheell"
local mdwheelr= piece "mdwheelr"
local mdiggroup= piece "mdiggroup"
local mdmeltingp= piece "mdmeltingp"
local sparkemit1= piece"sparkemit1"
local spinroundPoint=piece"spinroundpoint"
local mdigg=piece"mdigg"
local SIG_WIP=2
local SIG_GIC=4
local SIG_MOVE=8
local SIG_MINE=16
local smokepiece= piece "chineySmokeEmit"
local mdprojecti= piece "mdprojecti"

local heat1emit  = piece"heat1emit"
local heat2emit  = piece"heat2emit"
local heat3emit  = piece"heat3emit"
local heat4emit  = piece"heat4emit"
local heat5emit  = piece"heat5emit"
local heat6emit  = piece"heat6emit"

dustEmit={}
for i=1,8,1 do
dustEmit[i]={}
dusty	= "dustemit"..i
dustEmit[i]=piece (dusty)
end

local boolAllreadyDead=false
local boolMurdered=false
local boolAllreadyDeployed=false
mexID = -666
local boolCheckActive=false
local boolMoving=false
boolDeploy=false
boolShortStop=false
boolLongStop=false
boolOneThreadOnly=false

--Created

function script.Activate()
		--[[if boolCheckActive==false then
		StartThread(check)
		boolCheckActive=true
		end]]
		
boolDeploy=true
	return 1
  end

function script.Deactivate()
--[[	if boolCheckActive==false then
		StartThread(check)
		boolCheckActive=true
		end]]
boolDeploy=false

	return 0
  end


function delayedCheck()
SetSignalMask(SIG_MINE)
----Spring.Echo("Delayed Check Active")
boolShortStop=true
Sleep(512)
	if boolShortStop==true then
	boolLongStop=true
	else		
		boolLongStop=false
		end
		
		if boolLongStop==true and boolDeploy==true and boolOneThreadOnly==false then
		boolOneThreadOnly=true
					Hide(mdigg)
					Hide(mdwheelcenter)
					Hide(mdwheell)       
					Hide(mdwheelr)       
					Hide(mdiggroup)      
					Hide(mdmeltingp)     
					Hide(mdprojecti)

		makeMex()
		end
		
end
   local teamID = Spring.GetUnitTeam (unitID)
--gets the Units Position, creates the Mex
function makeMex()
		   local x,y,z=Spring.GetUnitPosition (unitID)
		
		   mexID= Spring.CreateUnit("mdiggMex", x, y, z, 0, teamID)      --replace with your mex name
	if (Spring.ValidUnitID (mexID)) == true then
		   health=Spring.GetUnitHealth(unitID)
		   Spring.SetUnitHealth(mexID,health)
		   Spring.DestroyUnit (unitID,false,true) 
    else
    --Spring.Echo("You tried so tard, and yet you phailed, but in the end, it doesent really better!")
	end
end

function dirtEmit()
for i=1,8,1 do
EmitSfx(dustEmit[i], 1024)
Sleep(15)
EmitSfx(dustEmit[9-i], 1024)
end

end

function sparkEmit()
EemitX,EemitY,EemitZ=Spring.GetUnitPiecePosition(unitID,sparkemit1)
EmitSfx(sparkemit1, 1025)

end




function workInProgress()
Signal(SIG_WIP)
SetSignalMask(SIG_WIP)
	while(true)do
	Spin(mdwheelcenter,x_axis,math.rad(-40),9)
	Spin(mdwheell,y_axis,math.rad(-40),9)
	Spin(mdwheelr,y_axis,math.rad(40),9)
	Turn(mdmeltingp,y_axis,math.rad(-55),3)
	WaitForTurn(mdmeltingp,y_axis)
	unitX,unitY,unitZ =Spring.GetUnitPosition(unitID)
	CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,smokepiece )
	Spring.SpawnCEG("fireSparks",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
	EmitSfx(smokepiece, 258)
	StartThread(dirtEmit)
	Sleep(120)
	EmitSfx(smokepiece, 258)
	--DustEmits?
	Turn(mdmeltingp,y_axis,math.rad(-120),3)
	WaitForTurn(mdmeltingp,y_axis)
	EmitSfx(smokepiece, 258)
	sparkEmit()
	StartThread(dirtEmit)
	Sleep(120)
	EmitSfx(smokepiece, 258)
	Turn(mdmeltingp,y_axis,math.rad(-180),3)
	WaitForTurn(mdmeltingp,y_axis)
	EmitSfx(smokepiece, 258)
	sparkEmit()
	StartThread(dirtEmit)
	Sleep(120)
	EmitSfx(smokepiece, 258)
	Turn(mdmeltingp,y_axis,math.rad(-230),3)
	WaitForTurn(mdmeltingp,y_axis)
	EmitSfx(smokepiece, 258)
	sparkEmit()
	StartThread(dirtEmit)
	Sleep(120)
	EmitSfx(smokepiece, 258)
	Turn(mdmeltingp,y_axis,math.rad(-300),3)
	WaitForTurn(mdmeltingp,y_axis)
	EmitSfx(smokepiece, 258)
	sparkEmit()
	StartThread(dirtEmit)
	Sleep(120)
	EmitSfx(smokepiece, 258)
	Turn(mdmeltingp,y_axis,math.rad(-360),3)
	WaitForTurn(mdmeltingp,y_axis)
	EmitSfx(smokepiece, 258)
	sparkEmit()
	StartThread(dirtEmit)
	Sleep(120)
	end
end

function killMex()
   if (Spring.ValidUnitID (mexID)) then
      Spring.DestroyUnit (mexID,false,true) --leave no wreck
	  boolOneThreadOnly=false
		Show(mdigg)
		Show(mdwheelcenter)
		Show(mdwheell)       
		Show(mdwheelr)       
		Show(mdiggroup)      
		Show(mdmeltingp)   

	  
	  
   end
end



function Killed()
	
			Signal(SIG_WIP)
			
			Spin(mdwheelcenter,x_axis,math.rad(40),4)
			Turn(spinroundPoint,y_axis,math.rad(-80),1)
			
			WaitForTurn(spinroundPoint,y_axis)
			Turn(spinroundPoint,y_axis,math.rad(-120),1)
			
			WaitForTurn(spinroundPoint,y_axis)
			Turn(mdwheelcenter,z_axis,math.rad(7),4)
			Turn(spinroundPoint,y_axis,math.rad(-180),1)
			
			WaitForTurn(spinroundPoint,y_axis)
			
			Turn(spinroundPoint,y_axis,math.rad(-287),1)
			Sleep(800)

			WaitForTurn(spinroundPoint,y_axis)
			Explode( heat1emit , SFX.FIRE +SFX.FALL)  
			Sleep(140)
			Explode( heat2emit , SFX.FIRE +SFX.FALL)  
			Explode( heat3emit , SFX.FIRE +SFX.FALL)   
			Sleep(180)
			Explode( heat4emit , SFX.FIRE +SFX.FALL)  
			Explode( heat5emit , SFX.FIRE +SFX.FALL)   
			Explode( heat6emit , SFX.FIRE +SFX.FALL)   
			Sleep(190)
			Explode(mdwheelcenter, SFX.FIRE +SFX.FALL)
			Explode(mdigg, SFX.SHATTER )
			Explode( heat1emit , SFX.FIRE +SFX.FALL)  
			Explode( heat2emit , SFX.FIRE +SFX.FALL)  
			Explode( heat3emit , SFX.FIRE +SFX.FALL)   
			Explode( heat4emit , SFX.FIRE +SFX.FALL)  
			Explode( heat5emit , SFX.FIRE +SFX.FALL)   
			Explode( heat6emit , SFX.FIRE +SFX.FALL)   
			Sleep(800)
			Hide(mdwheelcenter)
	
				
					
						
						
						
						
					
  

end

function script.StartMoving()
boolMoving=true
Signal(SIG_MINE)
		killMex()
		
	
		----Spring.Echo("StartThread(workInProgress)")
		StartThread(workInProgress)
			
		
		boolShortStop=false
		
		
		
		
end

function script.StopMoving()
boolMoving=false
StartThread(delayedCheck)
----Spring.Echo("Stoped Moving")
boolShortStop=true
Signal(SIG_WIP)
StopSpin(mdwheelcenter,x_axis)
StopSpin(mdwheell,y_axis)
StopSpin(mdwheelr,y_axis)
----Spring.Echo("StartThread(delayedCheck)")



	
end

--Killed

function script.Create()
StartThread(treeTrample)

	Hide(mdprojecti)
----Spring.Echo("I speak, therefore I exist.")
end


------------------------------------------------------------------------------------------
	TrampledTrees={}

	function treeTrample()
	local	treeTypeTable=getTypeTable(UnitDefNames,{
												"jtree",
												"jtree2",
												"jtree3",
												"jtree41",
												"jtree42",
												"jtree43",
												"jtree44",
												"jtree45",
												"jtree46",
												"jtree47"
												})
		while true do
		
			while boolMoving==true do
			x,_,z=Spring.GetUnitPiecePosDir(unitID,treeSpot)
			T=grabEveryone(unitID,x,z,50,teamID)
				if T then
				T=filterUnitTableforDefIDTable(T,treeTypeTable)
					if T then
					TableMergeTable(TrampledTrees,T)
					end
				end
			Sleep(150)
			end
		Sleep(300)	
		end

	end


	  
  



--[[Grass

Spring.AddGrass

 ( number x, number y, number z ) -> nil

Spring.RemoveGrass

 ( number x, number y, number z ) -> nil

Heightmap

Note that x & z coords are in worldspace (Game.mapSizeX/Z), still the heightmap resolution is Game.squareSize.

Spring.LevelHeightMap

 ( number x1, number z1 [, number x2, number z2], number height ) -> nil

Spring.AdjustHeightMap (heightmap[x][z] += height;)

 ( number x1, number z1 [, number x2, number z2], number height ) -> nil

Spring.RevertHeightMap

 ( number x1, number z1 [, number x2, number z2], number origFactor ) -> nil



Spring.SetHeightMapFunc

 ( lua_function [, arg1 ,[ arg2 [, ... ] ] ) -> nil | number absTotalHeightMapAmountChanged

Example code:

Spring.SetHeightMapFunc(function()
	for z=0,Game.mapSizeZ, Game.squareSize do
		for x=0,Game.mapSizeX, Game.squareSize do
			Spring.SetHeightMap( x, z, 200 + 20 * math.cos((x + z) / 90) )
		end
	end
end)

Spring.AddHeightMap can only be called in SetHeightMapFunc()

 ( number x, number z, number height ) -> nil | number newHeight

Spring.SetHeightMap can only be called in SetHeightMapFunc()

 ( number x, number z, number height [,number terraform = 1] ) -> nil | number absHeightDiff

the terraform argument is a scaling factor: so if 0 nothing will be changed (the terraform starts) and if it is 1 the terraform will be finished.

]]--

