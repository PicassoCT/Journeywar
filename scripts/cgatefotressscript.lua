include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua"
include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

function script.Create()
generatepiecesTableAndArrayCode(unitID)
StartThread(AnimTest)
end

function script.Killed(recentDamage,_)
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

	return boolOneShot

end

function AnimTest()
	while true do 
		unfoldAnimation()
		Sleep(100)
		foldAnimation()
	end

end
 
 local SignalTable={}
function unfoldAnimation()
Sleep(1000)
Spring.Echo("UnfoldAnimation")
n=1
n=GateDeploy(n,true)	
	StartThread(GateLoop,n,true)
n=FirstTrainDeploy(n,true)	
StartThread(TrainLoop,n,true)
n=InnerCircleDeploy(n,true)	
StartThread(InnerCircleLoop,n,true)
n=OuterCircleDeploy(n,true)	
StartThread(OuterCircleLoop,n,true)
n=	UpperCircleDeploy(n,true)
n=	TowerDeploy(n,true)
n=	OutPostDeploy(n,true)
n=	InnerCityDeploy(n,true)
n=	RailGunUnfold(n,true)
n=	CityBlocksDeploy	



end

function foldAnimation()
Sleep(1000)
Spring.Echo("Fold Animation")
--	CityBlocksDeploy	
--	RailGunUnfold
--	InnerCityDeploy
--	OutPostDeploy
--	TowerDeploy
--	UpperCircleDeploy

--OuterCircleLoop
	--OuterCircleDeploy
--InnerCircleLoop
	--InnerCircleDeploy
--GateLoop
	--GateDeploy
--TrainLoop
	--FirstTrainDeploy
	


end

boolOnTheMove=false 
boolOneShot=true 
teamid=Spring.GetUnitTeam(unitID)

function script.FireWeapon1()	
boolOneShot=false
makeCascadingTables("GG.FiringGateFotressTable["..teamid.."]["..unitID.."]",true)
StartThread(watchForImpact)
	return true
end

function GateDeploy (SignalNumber,boolReverse) 
 
return SignalNumber+1 
 end
function GateLoop (SignalNumber,boolReverse) 
 
return SignalNumber+1 
 end
function FirstTrainDeploy (SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
	function TrainLoop (SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function InnerCircleDeploy (SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
	function InnerCircleLoop (SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function OuterCircleDeploy (SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
	function OuterCircleLoop (SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function 	UpperCircleDeploy(SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function 	TowerDeploy(SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function 	OutPostDeploy(SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function 	InnerCityDeploy(SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function 	RailGunUnfold(SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end
function 	CityBlocksDeploy	(SignalNumber,boolReverse) 
 
 return SignalNumber+1 
 end

function watchForImpact()
	while GG.FiringGateFotressTable[teamid][unitID]==true do
	Sleep(250)
	end
boolOnTheMove=true
foldAnimation()	
Spring.DstroyUnit(unitID,true,false)
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

