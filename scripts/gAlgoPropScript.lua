include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 

include "createCorpse.lua"
--<pieces>


bloks={}
center=""
cg=""
pod={}
function initPieces()
	pod[1]={}
	pod[1]=piece"Pod1"
	pod[2]={}
	pod[2]=piece"Pod2"
	pod[3]={}
	pod[3]=piece"Pod3"
	pod[4]={}
	pod[4]=piece"Pod4"
	pod[5]={}
	pod[5]=piece"Pod5"
	center=piece"center"
	cg=piece"CG"
	for i=1,6,1 do
	poleDance[i]={}
	temp="Pole"..i
	poleDance[i]=piece(temp)
	end
	for i=1,70,1 do
	bloks[i]={}
	temp="blok"..i
	bloks[i]=piece(temp)
	end
end
poleDance={}

freeSpots={}


dist=16
disto=28
cgPosX,cgPosY,cgPosZ=0,0,0

function byNr(i)

if math.random(0,1)==1 then return 0,dist,0 end
if i==1 then return disto,0,0 end
if i==2 then return 0,0,disto end
if i==3 then return -1*disto,0,0 end
if i==4 then return 0,0,-1*disto end
if i==5 then return 0,dist,0 end

end


	for i=1,5,1 do
	x,y,z=byNr(i)
	
	freeSpots[i]={}
	freeSpots[i][1]={}
	freeSpots[i][1]=cgPosX+x
	freeSpots[i][2]={}
	freeSpots[i][2]=cgPosY+y
	freeSpots[i][3]={}
	freeSpots[i][3]=cgPosZ+z
	end


function moveCGAndAdPods(x,y,z,nrSpot,nrBlok)
cgPosX,cgPosY,cgPosZ=x,y,z
Move(cg,x_axis,x,0)
Move(cg,y_axis,y,0)
Move(cg,z_axis,z,0)
WaitForMove(cg,y_axis)
Move(bloks[nrBlok],x_axis,x,0)
Move(bloks[nrBlok],y_axis,y,0)
Move(bloks[nrBlok],z_axis,z,0)
WaitForMove(bloks[nrBlok],y_axis)
d=math.floor(math.random(0,3))*90
Turn(bloks[nrBlok],y_axis,math.rad(d),0)
--bx,by,bz=Spring.GetUnitBasePosition(unitID)

	for i=1,5,1 do
	
	
		x,y,z=byNr(i)
		if doesSpotAllreadyExist(cgPosX+x,cgPosY+y,cgPosZ+z)==false then
		d=table.getn(freeSpots)+1
		freeSpots[d]={}
		freeSpots[d][1]={}
		freeSpots[d][1]=cgPosX+x
		freeSpots[d][2]={}
		freeSpots[d][2]=cgPosY+y
		freeSpots[d][3]={}
		freeSpots[d][3]=cgPosZ+z
		end
	end
nrOfSpots=nrOfSpots+5

table.remove(bloks,nrBlok)
table.remove(freeSpots,nrSpot)
nrOfSpots=nrOfSpots-1

end

function doesSpotAllreadyExist(x,y,z)
for i=1,#freeSpots do
if freeSpots[i][1]==x and freeSpots[i][2]==y and freeSpots[i][3]==z then return true end
end
return false
end
nrOfSpots=5

function addABrick()
d=math.floor(math.random(1,table.getn(bloks)))
getAPod=math.floor(math.random(1,nrOfSpots))
	if freeSpots[getAPod] and freeSpots[getAPod][1] and freeSpots[getAPod][2] and freeSpots[getAPod][3] then
	moveCGAndAdPods(freeSpots[getAPod][1],freeSpots[getAPod][2],freeSpots[getAPod][3],getAPod,d)
	end
end
function buildthis()

	for i=1,table.getn(bloks),1 do
	addABrick()
	end

end

function script.Create()
initPieces()
Hide(cg)

	if math.random(0,1)==1 then
		for i=1,6,1 do
		d=math.random(-15,15)
		if i==3 and math.random(0,1)==1 then d=90 end
		Show(poleDance[i])
		Turn(poleDance[i],y_axis,math.rad(d),0)
		end
				d=math.random(-360,360)
		Turn(poleDance[1],y_axis,math.rad(d),0)
		else
			for i=1,6,1 do
			Hide(poleDance[i])
			end
		end
for i=1,5,1 do
Hide(pod[i])
end

Move(cg,x_axis,0,0)
Move(cg,y_axis,0,0)
Move(cg,z_axis,0,0)

for i=1,table.getn(bloks),1 do
Move(bloks[i],x_axis,0,0)
Move(bloks[i],y_axis,0,0)
Move(bloks[i],z_axis,0,0)
end

StartThread(buildthis)



end

function script.Killed(recentDamage,_)

xrand=math.random(-2,2)
yrand=math.random(-12,12)
zrand=math.random(-3,3)
Turn(center,x_axis,math.rad(xrand),0.02)
Turn(center,y_axis,math.rad(yrand),0.2)
Turn(center,z_axis,math.rad(zrand),0.02)
Move(center,y_axis,-180,11)
Timer=0
	while(true==Spring.UnitScript.IsInMove (center, y_axis)) do
	EmitSfx(center,1024)
	Sleep(120)
	Timer=Timer+1
			if Timer== 20 then
			Move(center,y_axis,-180,22)
			end
		if Timer== 28 then

		Move(center,y_axis,-180,44)
		end


	end
	teamID=Spring.GetUnitTeam(unitID)
x,y,z=Spring.GetUnitPosition(unitID)
	if math.random(0,2)==1 then
		for i=1, 3,1 do
		Spring.CreateUnit("jresistancewarrior",x+25,y,z-25,0,teamID)
		end
	end
createCorpseCBuilding(unitID,recentDamage)
return 0
end

	



