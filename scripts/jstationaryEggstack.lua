eggnok={}
for i=1,36,1 do
eggnok[i]={}
temp="eggnog"..i
eggnok[i]=piece (temp)
end

local boolAllreadyDead=false
local boolAllreadyStarted=false
local boolMurdered=true
local mexID = -666
SIG_RESET=1
boolUnDeployed=false
local boolSafetyFirst=false
boolMightBeAReset=false
local boolreVert=false
--Created
center=piece"center"
eggs=piece"eggs"
deCidere=1
Eggtable={}
spinegg1=piece"spinegg1"
table.insert(Eggtable,spinegg1)
spinegg2=piece"spinegg2"
table.insert(Eggtable,spinegg2)
spinegg3=piece"spinegg3"
table.insert(Eggtable,spinegg3)
spinegg4=piece"spinegg4"
table.insert(Eggtable,spinegg4)

fruitwat={}
for i=1, 4, 1 do
fruitwat[i]={}
feetFeti="fruchtwas"..i
fruitwat[i]=piece (feetFeti)
end

feetFetish={}
for i=1, 6, 1 do
feetFetish[i]={}
feetFeti="feet0"..i
feetFetish[i]=piece (feetFeti)
end


function script.Killed(recentDamage, maxHealth)
return 1
  

end

function dropEgg(nr,depth,axis,out)
Spin(eggnok[nr],y_axis,math.rad(22),0.5)
Spin(eggnok[nr],x_axis,math.rad(52),0.015)
Move(eggnok[nr],axis,out,3.5)
Move(eggnok[nr],y_axis,depth,3.5)

WaitForMove(eggnok[nr],y_axis)
Hide(eggnok[nr])



end

dropEggTable={}
for i=1,18,1 do
dropEggTable[i]={}
tempPiece="eggdec"..i
dropEggTable[i]=piece (tempPiece)

end


function toDropAEgg(sideNr)
randoMatic=math.random(1,22)
if randoMatic==2 then
	if sideNr==4 then
	eggToDrop=math.random(10,18)
	StartThread(dropEgg,eggToDrop,-55-eggToDrop,x_axis,29)
	elseif sideNr ==2 then
	eggToDrop=math.random(19,27)
	StartThread(dropEgg,eggToDrop,-55-eggToDrop,z_axis,-29)

	elseif sideNr ==3 then
	eggToDrop=math.random(28,36)
	StartThread(dropEgg,eggToDrop,-55-eggToDrop,x_axis,29)

	else --sideNr==1 
	eggToDrop=math.random(1,9)
	StartThread(dropEgg,eggToDrop,-55-eggToDrop,z_axis,29)
	end
end
--4 10-16  --x 28.5 y-55

end


tempID=nil
function workInProgress()
Signal(SIG_WIP)
SetSignalMask(SIG_WIP)
buildID=nil
buildIDofOld=nil
counter=0
	while(true)do
	buildID=Spring.GetUnitIsBuilding(unitID)
		if buildID and buildID~= tempID then
		tempID=buildID
		counter=counter+1
			if counter >35 then 	Spring.DestroyUnit(unitID,true,false) end
		end
	
		if buildID ~=nil then
		buildIDofOld=buildID
		Spring.SetUnitNoDraw(buildID,true)
		
				
		
			elseif buildID == nil and buildIDofOld ~= nil and Spring.ValidUnitID(buildIDofOld)==true then
			
			Move(Eggtable[deCidere],y_axis,-30,15)
			Spring.SetUnitNoDraw(buildIDofOld,false)
			WaitForMove(Eggtable[deCidere],y_axis)
			Hide(Eggtable[deCidere])
			Move(Eggtable[deCidere],y_axis,0,0)
			buildIDofOld=nil
			deCidere=math.random(1,4)
			end

	Sleep(120)
	end
end
boolBuilding=false




--Killed
function script.QueryBuildInfo() 
tempDeci=math.max((deCidere+2)%5,1)

  StartThread(toDropAEgg,tempDeci)
  Show(Eggtable[deCidere])
  return (Eggtable[deCidere])
  
end


Spring.SetUnitNanoPieces(unitID,{ eggs})

function bobbingEggs()
	for i=1,table.getn(Eggtable),1 do
	Move(Eggtable[i],y_axis,-16,0)
	end
for i=1,table.getn(Eggtable),1 do
	Spin(Eggtable[i],y_axis,math.rad(42),0.7)
	end
	
while(true) do
		for i=1,table.getn(Eggtable),1 do
		Move(Eggtable[i],y_axis,10,0.7)
		end
	Sleep(50)
	WaitForMove(Eggtable[4],y_axis)
		for i=1,table.getn(Eggtable),1 do
		Move(Eggtable[i],y_axis,-16,0.7)
		end
	Sleep(50)
	WaitForMove(Eggtable[4],y_axis)
	
end

end


function script.Activate ( )



	SetUnitValue(COB.YARD_OPEN, 1)
	SetUnitValue(COB.INBUILDSTANCE, 1)
	SetUnitValue(COB.BUGGER_OFF, 1)

	return 1
  end

  
function script.Deactivate ( )





	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	SetUnitValue(COB.BUGGER_OFF, 0)
	return 0
  end




function script.StartBuilding()	

end

function script.StopBuilding()


end

function script.Create()
Spin(eggs,y_axis,math.rad(42),0)
for i=1, 4, 1 do
Spin(fruitwat[i],y_axis,math.rad(-42),3)
end
Spin(spinegg1,y_axis,math.rad(42),0.5)
Spin(spinegg2,y_axis,math.rad(42),0.5)
Spin(spinegg3,y_axis,math.rad(42),0.5)
Spin(spinegg4,y_axis,math.rad(42),0.5)

Hide(spinegg1)
Hide(spinegg2)
Hide(spinegg3)
Hide(spinegg4)
Move(center,y_axis,-30,8.7)


StartThread(workInProgress)
StartThread(bobbingEggs)
end

