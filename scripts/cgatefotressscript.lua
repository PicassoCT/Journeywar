include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua"
include "lib_Build.lua" 

piecesTable={}
piecesTable[#piecesTable+1]= piece("CatapultRoto1");CatapultRoto1= piece("CatapultRoto1")
piecesTable[#piecesTable+1]= piece("CataHead1");CataHead1= piece("CataHead1")
piecesTable[#piecesTable+1]= piece("CataLow1");CataLow1= piece("CataLow1")
piecesTable[#piecesTable+1]= piece("CataUp1");CataUp1= piece("CataUp1")
piecesTable[#piecesTable+1]= piece("CatapultRoto2");center= piece("CatapultRoto2")
piecesTable[#piecesTable+1]= piece("CataHead2");CataHead2= piece("CataHead2")
piecesTable[#piecesTable+1]= piece("CataLow2");CataLow2= piece("CataLow2")
piecesTable[#piecesTable+1]= piece("CataUp2");CataUp2= piece("CataUp2")
piecesTable[#piecesTable+1]= piece("center");center= piece("center")
piecesTable[#piecesTable+1]= piece("Erker4");Erker4= piece("Erker4")
piecesTable[#piecesTable+1]= piece("InnerLoop0");InnerLoop0= piece("InnerLoop0")
piecesTable[#piecesTable+1]= piece("InnerLoop1");InnerLoop1= piece("InnerLoop1")
piecesTable[#piecesTable+1]= piece("InnerLoop2");InnerLoop2= piece("InnerLoop2")
piecesTable[#piecesTable+1]= piece("InnerLoop3");InnerLoop3= piece("InnerLoop3")
piecesTable[#piecesTable+1]= piece("InnerLoop4");InnerLoop4= piece("InnerLoop4")
piecesTable[#piecesTable+1]= piece("InnerLoop5");InnerLoop5= piece("InnerLoop5")
piecesTable[#piecesTable+1]= piece("InnerLoop6");InnerLoop6= piece("InnerLoop6")
piecesTable[#piecesTable+1]= piece("InnerLoop7");InnerLoop7= piece("InnerLoop7")
piecesTable[#piecesTable+1]= piece("InnerLoop8");InnerLoop8= piece("InnerLoop8")
piecesTable[#piecesTable+1]= piece("InnerLoop9");InnerLoop9= piece("InnerLoop9")
piecesTable[#piecesTable+1]= piece("InnerLoopC");InnerLoopC= piece("InnerLoopC")
piecesTable[#piecesTable+1]= piece("NGon085");NGon085= piece("NGon085")
piecesTable[#piecesTable+1]= piece("NGon086");NGon086= piece("NGon086")
piecesTable[#piecesTable+1]= piece("NGon089");NGon089= piece("NGon089")
piecesTable[#piecesTable+1]= piece("NGon090");NGon090= piece("NGon090")
piecesTable[#piecesTable+1]= piece("NGon088");NGon088= piece("NGon088")
piecesTable[#piecesTable+1]= piece("Gun3");Gun3= piece("Gun3")
piecesTable[#piecesTable+1]= piece("Mag5");Mag5= piece("Mag5")
piecesTable[#piecesTable+1]= piece("Mag6");Mag6= piece("Mag6")
piecesTable[#piecesTable+1]= piece("Erker3");Erker3= piece("Erker3")
piecesTable[#piecesTable+1]= piece("Erker2");Erker2= piece("Erker2")
piecesTable[#piecesTable+1]= piece("NGon087");NGon087= piece("NGon087")
piecesTable[#piecesTable+1]= piece("InnerOrigin");InnerOrigin= piece("InnerOrigin")
piecesTable[#piecesTable+1]= piece("OuterLoo12");OuterLoo12= piece("OuterLoo12")
piecesTable[#piecesTable+1]= piece("OuterLoo24");OuterLoo24= piece("OuterLoo24")
piecesTable[#piecesTable+1]= piece("OuterLoo27");OuterLoo27= piece("OuterLoo27")
piecesTable[#piecesTable+1]= piece("Gun1");Gun1= piece("Gun1")
piecesTable[#piecesTable+1]= piece("Mag1");Mag1= piece("Mag1")
piecesTable[#piecesTable+1]= piece("Mag2");Mag2= piece("Mag2")
piecesTable[#piecesTable+1]= piece("OuterLoo25");OuterLoo25= piece("OuterLoo25")
piecesTable[#piecesTable+1]= piece("OuterLoo29");OuterLoo29= piece("OuterLoo29")
piecesTable[#piecesTable+1]= piece("Gun4");Gun4= piece("Gun4")
piecesTable[#piecesTable+1]= piece("Mag7");Mag7= piece("Mag7")
piecesTable[#piecesTable+1]= piece("Mag8");Mag8= piece("Mag8")
piecesTable[#piecesTable+1]= piece("OuterLoo26");OuterLoo26= piece("OuterLoo26")
piecesTable[#piecesTable+1]= piece("OuterLoo28");OuterLoo28= piece("OuterLoo28")
piecesTable[#piecesTable+1]= piece("Gun2");Gun2= piece("Gun2")
piecesTable[#piecesTable+1]= piece("Mag3");Mag3= piece("Mag3")
piecesTable[#piecesTable+1]= piece("Mag4");Mag4= piece("Mag4")
piecesTable[#piecesTable+1]= piece("OuterLoo30");OuterLoo30= piece("OuterLoo30")
piecesTable[#piecesTable+1]= piece("OuterLoo31");OuterLoo31= piece("OuterLoo31")
piecesTable[#piecesTable+1]= piece("OuterLoo32");OuterLoo32= piece("OuterLoo32")
piecesTable[#piecesTable+1]= piece("OuterLoo35");OuterLoo35= piece("OuterLoo35")
piecesTable[#piecesTable+1]= piece("OuterLoo36");OuterLoo36= piece("OuterLoo36")
piecesTable[#piecesTable+1]= piece("OuterLoo37");OuterLoo37= piece("OuterLoo37")
piecesTable[#piecesTable+1]= piece("OuterLoo38");OuterLoo38= piece("OuterLoo38")
piecesTable[#piecesTable+1]= piece("OuterLoo39");OuterLoo39= piece("OuterLoo39")
piecesTable[#piecesTable+1]= piece("Erker5");Erker5= piece("Erker5")
piecesTable[#piecesTable+1]= piece("Erker6");Erker6= piece("Erker6")
piecesTable[#piecesTable+1]= piece("OuterLoo34");OuterLoo34= piece("OuterLoo34")
piecesTable[#piecesTable+1]= piece("OuterLoo40");OuterLoo40= piece("OuterLoo40")
piecesTable[#piecesTable+1]= piece("OuterLoo41");OuterLoo41= piece("OuterLoo41")
piecesTable[#piecesTable+1]= piece("OuterLoo43");OuterLoo43= piece("OuterLoo43")
piecesTable[#piecesTable+1]= piece("RailGun");RailGun= piece("RailGun")
piecesTable[#piecesTable+1]= piece("Projectile");Projectile= piece("Projectile")
piecesTable[#piecesTable+1]= piece("DronePod4");DronePod4= piece("DronePod4")
piecesTable[#piecesTable+1]= piece("DronePod1");DronePod1= piece("DronePod1")
piecesTable[#piecesTable+1]= piece("OuterLoo33");OuterLoo33= piece("OuterLoo33")
piecesTable[#piecesTable+1]= piece("OuterLoo42");OuterLoo42= piece("OuterLoo42")
piecesTable[#piecesTable+1]= piece("OuterLoo44");OuterLoo44= piece("OuterLoo44")
piecesTable[#piecesTable+1]= piece("OuterLoo47");OuterLoo47= piece("OuterLoo47")
piecesTable[#piecesTable+1]= piece("OuterLoo55");OuterLoo55= piece("OuterLoo55")
piecesTable[#piecesTable+1]= piece("Erker9");Erker9= piece("Erker9")
piecesTable[#piecesTable+1]= piece("Erker010");Erker010= piece("Erker010")
piecesTable[#piecesTable+1]= piece("OuterLoo54");OuterLoo54= piece("OuterLoo54")
piecesTable[#piecesTable+1]= piece("DronePod5");DronePod5= piece("DronePod5")
piecesTable[#piecesTable+1]= piece("Erker011");Erker011= piece("Erker011")
piecesTable[#piecesTable+1]= piece("OuterLoo50");OuterLoo50= piece("OuterLoo50")
piecesTable[#piecesTable+1]= piece("OuterLoo51");OuterLoo51= piece("OuterLoo51")
piecesTable[#piecesTable+1]= piece("DronePod3");DronePod3= piece("DronePod3")
piecesTable[#piecesTable+1]= piece("OuterLoo45");OuterLoo45= piece("OuterLoo45")
piecesTable[#piecesTable+1]= piece("OuterLoo46");OuterLoo46= piece("OuterLoo46")
piecesTable[#piecesTable+1]= piece("OuterLoo53");OuterLoo53= piece("OuterLoo53")
piecesTable[#piecesTable+1]= piece("OuterLoo52");OuterLoo52= piece("OuterLoo52")
piecesTable[#piecesTable+1]= piece("Erker012");Erker012= piece("Erker012")
piecesTable[#piecesTable+1]= piece("Erker8");Erker8= piece("Erker8")
piecesTable[#piecesTable+1]= piece("OuterLoo48");OuterLoo48= piece("OuterLoo48")
piecesTable[#piecesTable+1]= piece("OuterLoo49");OuterLoo49= piece("OuterLoo49")
piecesTable[#piecesTable+1]= piece("Erker7");Erker7= piece("Erker7")
piecesTable[#piecesTable+1]= piece("DronePod2");DronePod2= piece("DronePod2")
piecesTable[#piecesTable+1]= piece("Wall");Wall= piece("Wall")
piecesTable[#piecesTable+1]= piece("GatePoint");GatePoint= piece("GatePoint")
piecesTable[#piecesTable+1]= piece("RingB");RingB= piece("RingB")
piecesTable[#piecesTable+1]= piece("Ring0");Ring0= piece("Ring0")
piecesTable[#piecesTable+1]= piece("Ring1");Ring1= piece("Ring1")
piecesTable[#piecesTable+1]= piece("Ring2");Ring2= piece("Ring2")
piecesTable[#piecesTable+1]= piece("Ring3");Ring3= piece("Ring3")
piecesTable[#piecesTable+1]= piece("GatePortal");GatePortal= piece("GatePortal")
piecesTable[#piecesTable+1]= piece("GateWave");GateWave= piece("GateWave")
piecesTable[#piecesTable+1]= piece("WaveA");WaveA= piece("WaveA")
piecesTable[#piecesTable+1]= piece("Feed11");Feed11= piece("Feed11")
piecesTable[#piecesTable+1]= piece("Feed10");Feed10= piece("Feed10")
piecesTable[#piecesTable+1]= piece("Feed8");Feed8= piece("Feed8")
piecesTable[#piecesTable+1]= piece("Feed7");Feed7= piece("Feed7")
piecesTable[#piecesTable+1]= piece("Feed6");Feed6= piece("Feed6")
piecesTable[#piecesTable+1]= piece("Feed5");Feed5= piece("Feed5")
piecesTable[#piecesTable+1]= piece("Feed4");Feed4= piece("Feed4")
piecesTable[#piecesTable+1]= piece("Feed3");Feed3= piece("Feed3")
piecesTable[#piecesTable+1]= piece("Feed2");Feed2= piece("Feed2")
piecesTable[#piecesTable+1]= piece("Feed1");Feed1= piece("Feed1")
piecesTable[#piecesTable+1]= piece("BigLUpCenter");BigLUpCenter= piece("BigLUpCenter")
piecesTable[#piecesTable+1]= piece("OuterLoo13");OuterLoo13= piece("OuterLoo13")
piecesTable[#piecesTable+1]= piece("OuterLoo14");OuterLoo14= piece("OuterLoo14")
piecesTable[#piecesTable+1]= piece("OuterLoo15");OuterLoo15= piece("OuterLoo15")
piecesTable[#piecesTable+1]= piece("OuterLoo16");OuterLoo16= piece("OuterLoo16")
piecesTable[#piecesTable+1]= piece("OuterLoo17");OuterLoo17= piece("OuterLoo17")
piecesTable[#piecesTable+1]= piece("OuterLoo18");OuterLoo18= piece("OuterLoo18")
piecesTable[#piecesTable+1]= piece("OuterLoo19");OuterLoo19= piece("OuterLoo19")
piecesTable[#piecesTable+1]= piece("OuterLoo20");OuterLoo20= piece("OuterLoo20")
piecesTable[#piecesTable+1]= piece("OuterLoo21");OuterLoo21= piece("OuterLoo21")
piecesTable[#piecesTable+1]= piece("OuterLoo22");OuterLoo22= piece("OuterLoo22")
piecesTable[#piecesTable+1]= piece("OuterLoo23");OuterLoo23= piece("OuterLoo23")
piecesTable[#piecesTable+1]= piece("OuterLoo56");OuterLoo56= piece("OuterLoo56")
piecesTable[#piecesTable+1]= piece("BigLCenter");BigLCenter= piece("BigLCenter")
piecesTable[#piecesTable+1]= piece("OuterLoo10");OuterLoo10= piece("OuterLoo10")
piecesTable[#piecesTable+1]= piece("OuterLoo11");OuterLoo11= piece("OuterLoo11")
piecesTable[#piecesTable+1]= piece("OuterLoop0");OuterLoop0= piece("OuterLoop0")
piecesTable[#piecesTable+1]= piece("OuterLoop1");OuterLoop1= piece("OuterLoop1")
piecesTable[#piecesTable+1]= piece("OuterLoop2");OuterLoop2= piece("OuterLoop2")
piecesTable[#piecesTable+1]= piece("OuterLoop3");OuterLoop3= piece("OuterLoop3")
piecesTable[#piecesTable+1]= piece("OuterLoop4");OuterLoop4= piece("OuterLoop4")
piecesTable[#piecesTable+1]= piece("OuterLoop5");OuterLoop5= piece("OuterLoop5")
piecesTable[#piecesTable+1]= piece("OuterLoop6");OuterLoop6= piece("OuterLoop6")
piecesTable[#piecesTable+1]= piece("OuterLoop7");OuterLoop7= piece("OuterLoop7")
piecesTable[#piecesTable+1]= piece("OuterLoop8");OuterLoop8= piece("OuterLoop8")
piecesTable[#piecesTable+1]= piece("OuterLoop9");OuterLoop9= piece("OuterLoop9")

TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
FeedTable=TablesOfPiecesGroups["Feed"]
OuterLoopTable=TablesOfPiecesGroups["OuterLoop"]
OuterLooTable=TablesOfPiecesGroups["OuterLoo"]
MagaczineTable=TablesOfPiecesGroups["Mag"]

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

function script.Create()
	for i=1,#Mag do
	Sign=i%2
	if Sign==0 then Sign=-1 end
		Spin(Mag[i],x_axis,math.rad(42*Sign),0)
	end
	
hideT(piecesTable)
--generatepiecesTableAndArrayCode(unitID)
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
		Sleep(1)
		foldAnimation()
	end

end
 
 local SignalTable={}
function unfoldAnimation()
Sleep(10)
Spring.Echo("UnfoldAnimation")
n=1
n=	GateDeploy(n,true)	
	StartThread(GateLoop,n,true)

n=	FirstTrainDeploy(n,true)	
	StartThread(TrainLoop,n,true)

n=	InnerCircleDeploy(n,true)	
	StartThread(InnerCircleLoop,n,true)

n=	OuterCircleDeploy(n,true)	
	StartThread(OuterCircleLoop,n,true)

n=	UpperCircleDeploy(n,true)
n=	TowerDeploy(n,true)
n=	OutPostDeploy(n,true)
n=	InnerCityDeploy(n,true)
n=	RailGunUnfold(n,true)
n=	CityBlocksDeploy(n,true)	



end

function foldAnimation()
Sleep(10)
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
	boolDirection= false 
	if boolReverse then boolDirection =boolReverse end
	--if the animation should be aborted, we revert it 
	if SignalTable[SignalNumber]==false then boolDirection=true end
		if boolDirection==true then
		--Preparation
		Move(Ring0,y_axis,-15,0)
		Turn(Ring0,y_axis,math.rad(-90),0)
		Show(Ring0)
		Show(RingB)
		
		else


		 
		end 
	return SignalNumber+1 
 end
 
function GateLoop (SignalNumber,boolReverse) 
while SignalTable[SignalNumber]==true do


end
--HoldPosition
return SignalNumber+1 
 end
 
function FirstTrainDeploy (SignalNumber,boolReverse) 
 	boolDirection= false 
	if boolReverse then boolDirection =boolReverse end
	--if the animation should be aborted, we revert it 
	if SignalTable[SignalNumber]==false then boolDirection=true end

		if boolDirection==true then

		else


		 
		end 
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

function script.QueryNanopiece(")
     return center
end

