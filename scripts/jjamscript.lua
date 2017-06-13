--a wild function appears
include "createCorpse.lua"

flare1 =piece"flare1"
rotator=piece"rotator"
function script.Create()
	Hide(flare1)
	StartThread(emitFog)
	StartThread(emitSound)
	teamID=Spring.GetUnitTeam(unitID)
	x,y,z=Spring.GetUnitPosition(unitID)
	if math.random(0,1)==1 then
		GG.UnitsToSpawn:PushCreateUnit("gtreeplate",x,y,z,0,teamID)
	else
		GG.UnitsToSpawn:PushCreateUnit("gtreeplate2",x,y,z,0,teamID)
	end
end

function createRandTable()
	math.randomseed(math.random(1,75))
	size=128
	half=size/2
	maxs=256
	spiralTable={}
	ux,_,uz=Spring.GetUnitPosition(unitID)
	for i=1,size do
		radius=math.random(1,128)
		
		if i <half then
			radius = (i/half)*maxs+math.random(2,12)
		else
			radius= ((half-(i-half))/half)*maxs+math.random(2,12)
		end
		vx,vz=Rotate(0,radius, i*(360/half))
		spiralTable[#spiralTable+1]={x=ux+vx, z=uz+vz}
		spiralTable[#spiralTable].y=Spring.GetGroundHeight(spiralTable[#spiralTable].x,spiralTable[#spiralTable].z)+15
		dx,dy,dz=Spring.GetGroundNormal(spiralTable[#spiralTable].x,spiralTable[#spiralTable].z)
		spiralTable[#spiralTable].dx=dx
		spiralTable[#spiralTable].dz=dy
		spiralTable[#spiralTable].dy=dy
	end
	return spiralTable
end

function emitFog()
	sT=createRandTable()
	ax,ay,az=Spring.GetUnitPosition(unitID)
	indexSignum=1
	index=#sT/2
	times=0
	sequenze=0
	while(true) do
		if sequenze > 2  and math.random(1,13)%3==0 then
			sequenze=sequenze-1
		--	Spring.SpawnCEG("fog",ax+math.random(-200,200),ay+15,az+math.random(-200,200),math.random(-0.0125,0.0125),1,math.random(-0.0125,0.0125),20,0)
			
				fy =math.max(sT[index].y, ay - math.random(10,35))
			
				Spring.SpawnCEG("fog",sT[index].x,fy,sT[index].z,sT[index].dx,sT[index].dy,sT[index].dz,20,0)
				index=math.max(1,math.min(#sT,index +indexSignum))
				if math.random(1,22)==1 then indexSignum=indexSignum*-1 end

		
		
		end
		sleepLess=math.ceil(math.random(25,250))
		Sleep(sleepLess)
		times=times+sleepLess
		dice=math.ceil(math.random(1,16))
		if times > 7500  then 
		sequenze=math.random(0,8)
		times=0
			Spring.SpawnCEG("bigfog",ax+math.random(-64,64),ay+35,az+math.random(-64,64),math.random(-0.0125,0.0125),1,math.random(-0.0125,0.0125),20,0)
			Spring.SpawnCEG("dropfog",ax+math.random(-12,12),ay+175,az+math.random(-12,12),math.random(-0.525,0.525),math.random(0.125,0.525),math.random(-0.525,0.525),20,0)
		end
		
			-- if dice%2==0 then
			
			-- end
		
	end
	
	
end

function emitSound()
	while(true) do
		dice=math.random(1,2)
		if dice==1 then
			Spring.PlaySoundFile("sounds/jjam/jjam1.wav") 
			
		else
			Spring.PlaySoundFile("sounds/jjam/jjam2.wav") 
			
		end
		
		
		
		rest=math.ceil(math.random(10024,90000))
		Sleep(rest)
	end
end


function script.Killed()
	
end