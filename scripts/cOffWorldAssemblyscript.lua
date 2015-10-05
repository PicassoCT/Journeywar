include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 
piecesTable={}
piecesTable=makePieceTable(unitID)

TablesOfPiecesGroups={}
WindowTable={}
function script.HitByWeapon ( x, z, weaponDefID, damage ) 

center=piece"center"

function script.Create()
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	WindowTable=TablesOfPiecesGroups["Window0"]
	StartThread(randomBlink)
	StartThread(buildOS)
end

function unfold	(buildProgress)			  
speed= 50 *buildProgress/15
	if boolDirection==true then --unfold

		return CurrentStat,Instate, boolLoop 
	 else 
	 
	  return CurrentStat,Instate, boolLoop 
end	 
 
 
function eggDeploy(buildProgress)			 
 return CurrentStat,Instate, boolLoop 
end 
function pumpUp		(buildProgress)		  
 return CurrentStat,Instate, boolLoop 
 end
function implantInsertion(buildProgress)	  
 return CurrentStat,Instate, boolLoop 
 end
function SewUp			(buildProgress)	 
 return CurrentStat,Instate, boolLoop 
 end
function PumpedDown			(buildProgress)  
 return CurrentStat,Instate, boolLoop 
 end
function Release		(buildProgress)	  
 return CurrentStat,Instate, boolLoop 
 end

function Loopunfold(buildProgress)				 
 end
function LoopeggDeploy			 (buildProgress)
 end
function LooppumpUp				 (buildProgress)
 end
function LoopimplantInsertion	 (buildProgress)
 end
function LoopSewUp				 (buildProgress)
 end
function LoopPumpedDown			 (buildProgress)
 end
function LoopRelease			 (buildProgress)
 end

StableLoopTable={
[1]=  Loopunfold				 ,
[2]=  LoopeggDeploy			 ,
[3]=  LooppumpUp				 ,
[4]=  LoopimplantInsertion	 ,
[5]=  LoopSewUp				 ,
[6]=  LoopPumpedDown			 ,
[7]=  LoopRelease			 ,


}

UnfoldAnimationTable={
[1]=  unfold				  ,
[2]=  eggDeploy			 ,
[3]=  pumpUp				  ,
[4]=  implantInsertion	  ,
[5]=  SewUp				 ,
[6]=  PumpedDown			  ,
[7]=  Release			   
}


boolBuilding=false
progress=0



function BuildingAnimation(buildID,boolDirection)
Spring.SetUnitAlwaysVisible(buildID,false)
CurrentStat=1
Instate=1
	while boolBuilding==true do
	roGress=math.ceil(100*progress)
	
	CurrentStat,Instate, boolLoop=UnfoldAnimationTable[CurrentStat](roGress,boolDirection,Instate)
		if boolLoop then 
			StableLoopTable[CurrentStat](roGress)
		
	
Spring.SetUnitAlwaysVisible(buildID,true)



 end 
 function buildOS()
--TestLoop
	while true do 
	progress=0
	StartThrad(BuildingAnimation, buildID,true)
	
		for i=1,100 do
		progress=i/100
		Sleep(2000)
		
	Sleep(5000)
		StartThrad(BuildingAnimation, buildID,false)
	

	while true do
	buildID=Spring.GetUnitIsBuilding(unitID)
		if buildID  then 
		boolBuilding=true
		progress=0
		StartThrad(BuildingAnimation, buildID,false)
		
		--building something
			while  Spring.ValidUnitID(buildID)==true and progress < 1 do
				hp,progress=Spring.GetUnitHealth(buildID)
				
			Sleep(100)
			
		boolBuilding=false
		
	Sleep(500)
		
	



 end 
 function randomBlink()
hideT(WindowTable)
for i=1,#WindowTable do
	if i%2==0 then Show(WindowTable[i]) 

itterate=0.1

	while true do
	itterate=itterate+0.1
	changeVal=math.ceil(math.random(1,42))
	ignoreVal=math.ceil(math.random(1,6))
	
	time=math.ceil(300+math.sin(itterate)*100)
	Sleep(time)
		for i=1,#WindowTable-1,1 do
		if i% ignoreVal==0 and i% ignoreVal ~= 0 then
			Show(WindowTable[i]) 
			Hide(WindowTable[i]+1) 
		elseif i% ignoreVal ~= 0 
			Hide(WindowTable[i]) 
			ShowWindowTable[i]+1) 
		
			if maRa()==true then
				SleepValue=math.ceil(math.random(1,10))
				Sleep(SleepVal) 
			
		
	




 end 
 function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1



----aimining & fire weapon

 end 
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


Spring.SetUnitNanoPieces(unitID,{ center})

end
