include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 



center=piece"center"
Emitor=piece"Emitor"

EmitorLimbs={}
for i=1,4 do
name="EmLimb"..i
EmitorLimbs[i]=piece(name)
end

Scrap={}
for i=1,10 do
name="Scrap"..i
Scrap[i]=piece(name)
end

LIMB=40
LIMS=25 
OUT=12
FLOAT=14
FLATLIMIT=15

base={}
for i=1,4,1 do
name="base"..i
base[i]=piece(name)
end
P={}
for i=1,LIMB,1 do
name="B"..i
P[i]=piece(name)
--Spring.Echo(i)
end

offset=LIMB

for i=1,LIMS,1 do
name="S"..i
P[offset+i]=piece(name)
--Spring.Echo(offset+i)
end



OutPostPieces={}
for i=1,OUT,1 do
name="OutPiece"..i
cname="OutCent"..i
OutPostPieces[i]={}
OutPostPieces[i].piece=piece(name)
OutPostPieces[i].center=piece(cname)
end


FloatPieces={}
for i=1,FLOAT,1 do
name="FP"..i
FloatPieces[i]=piece(name)
end

function aShortGloballos   (ed ) 
 boolWereCheatsEnabled= Spring.IsCheatingEnabled()
 Spring.SetCheatingEnabled(true)
 Spring.Cheat("globallos")
 Spring.SetCheatingEnabled(false)
 end 
 
function aSuddenTransportToMapEdge   ( ed) 
x,z=math.random(0,1)*Game.mapSizeX,math.random(0,1)*Game.mapSizeZ
y=Spring.GetGroundHeight(x,z)
 Spring.SetUnitPosition(ed,x,y+100,z)
 end 

 T={36,17,33,34,39,9,15,33,12,24,21,27,16,22,40,39,27,31,6,26,1,11,6,34,7,17,6,5,42,10,22,36,26,13,27,23,21,41,13,33,23,33,17,38,12,15,34,39,3,40,23,4,9,28,38,15,3,1,20,3,11,41,38,36,12,23,16,32,22,29,23,2,19,40,40,31,12,32,27,15}
local D=T

 function setUpFirstRandom	()
if not GG.ProceduralFeatureCounter then  GG.ProceduralFeatureCounter= 1 else  GG.ProceduralFeatureCounter= GG.ProceduralFeatureCounter+1 end
name=Game.mapName or "SoooGeneric"
interrator=1
hArry={}
for i=1,#T,1 do
T[i]=(T[i]+ GG.ProceduralFeatureCounter+string.byte(name,math.max(1,string.len(name)%i)))%2
end
end
	itterator=1
  function deMaRaVal(valrange)
	if boolFirst==true then
	boolFirst=false
	setUpFirstRandom()
	itterator=math.max(1,(itterator+1)%#T)
	return math.ceil((D[itterator]/42)*valrange)
	else
	itterator=math.max(1,(itterator+1)%#T)
	return math.ceil((D[itterator]/42)*valrange)
	end
 end
 itterator=math.floor(math.random(deMaRaVal(5),deMaRaVal(#T))) 

 boolFirst=true


	--deterministicMathRandom
 function deMaRa()
	if boolFirst==true then
	boolFirst=false
	setUpFirstRandom()
	itterator=itterator+1
	itterator=math.max(1,(itterator)%#T)
	return T[itterator]==1
	else
	itterator=itterator+1
	itterator=math.max(1,(itterator)%#T)

	return 	(T[itterator]==1)

	end
 end
 
 
function aTransferToTheTop   ( ed) 
 min,max=Spring.GetGroundExtremes()
 if deMaRa() then -- to the top
 local spGetGroundHeight=Spring.GetGroundHeight
 oldh,maxX,maxZ=min,0,0
 mapX,mapZ=Spring.GetMetalMapSize
 for x=1,Game.mapX,32 do
 for z=1,Game.mapZ,32 do
h=spGetGroundHeight(x,z) 
if h > oldh then oldh,maxX,maxZ=h,x,z end
 end
 end
 Spring.SetUnitPosition(ed,maxX,oldh,maxZ)
 else --to the depths
 local spGetGroundHeight=Spring.GetGroundHeight
 oldh,maxX,maxZ=max,0,0
 for x=1,Game.mapX,32 do
 for z=1,Game.mapZ,32 do
h=spGetGroundHeight(x,z) 
if h < oldh then oldh,maxX,maxZ=h,x,z end
 end
 end
 Spring.SetUnitPosition(ed,maxX,oldh,maxZ)
 
 end 
 end 
 
function  aStunOfEveryone  ( ed) 
x,y,z=Spring.GetUnitPosition(unitID)
 T=Spring.GetUnitsInCylinder(x,z,250)
 table.remove(T,unitID)
 if #T> 0 then
   for T=1,#T do
		health=Spring.GetUnitHealth(T[i])
		Spring.SetUnitHealth(T[i], {paralyze =health*15})
	 end
 end
 end 
 
function  aWildHealer  (ed ) 

 hp,maxhealth=Spring.GetUnitHealth(ed)
 Spring.SetUnitHealth(ed,maxhealth)
 end 
 
function  aDuplicator  (ed ) 

hp=Spring.GetUnitHealth(ed)
defed=Spring.GetUnitDefID(ed)
x,y,z= Spring.GetUnitPosition(ed)
ted=Spring.GetUnitTeam(ed)
CreateUnit(unitTypeString,px,py,pz,0,teamID)
d=Spring.CreateUnit(defed,x+15,y,z-15,1,ted)
Spring.SetUnitHealth(d,hp)

 end 
 
 function  aNothing  ( ed) 
 defid=Spring.GetUnitDefID(unitID)
 team=Spring.GetUnitTeam(unitID)
 x,y,z=Spring.GetUnitPosition(unitID)
 
 x,z=Game.mapX/x,Game.mapZ/z --proportional coords
 x,z=math.floor(Game.mapX*(1-x)),math.floor(Game.mapZ*(1-z))
 did=Spring.CreateUnit(defid,x,y,z,math.floor(math.random(1,3)),team)
 hp=Spring.GetUnitHealth(unitID)
 Spring.SetUnitHealth(did,hp)
 ex,ey,ez=Spring.GetUnitPosition(ed)
	 if ex then 
	 Spring.SetUnitPosition(ed,ex+50,ey,ez)
	 end 
 end 
 
function aEnergy(ed)
ted=Spring.GetUnitTeam(ed)
	if ted then
	Spring.AddTeamResource(ted,"energy",2500)
	end
end

function aMetall(ed)
ted=Spring.GetUnitTeam(ed)
	if ted then
	Spring.AddTeamResource(ted,"metal",2500)
	end
end

function aUnitTransfer(ed)
tlist=Spring.GetTeamList()
Spring.TransferUnit(ed,tlist[math.random(1,#tlist)],true)
end

function aAntiGravity()

		x,y,z=Spring.GetUnitPosition(unitID)
		T=Spring.GetUnitsInCylinder(x,z,420)
		table.remove(T,unitID)
			for i=1,#T do
			Spring.MoveCtrl.Enable(T[i],true)
			Spring.MoveCtrl.SetGroundOffset(T[i],25)
			Spring.MoveCtrl.SetGravity(T[i],-0.1)
			Spring.MoveCtrl.SetRotation(T[i],math.random(-0.2,0.2),math.random(-0.2,0.2),math.random(-0.2,0.2))
			end
end

function genMessageString()
conCat=""
comTab={
A=":",
B="|",
C="¦",
D="/",
E="\\",
H="_",
I="°",
J="^",
K=" ",
H="``"
}

		F=" "
		G="\n"
	for i=1,math.ceil(math.random(5,29)) do
		if deMaRa() ==true and i%3 then
		if deMaRa() ==true  then conCat=conCat..F else conCat=conCat..G end
		else
		conCat=conCat..(comTab[math.random(1,#comTab)])
		end
	end
return conCat
end
Tsize=350
function aTerraFormation(ed)
x,y,z=Spring.GetUnitPosition(unitID)
if x then

	for i=x-Tsize,x+Tsize, 8 do
		for j=z-Tsize,z+Tsize, 8 do
			Spring.SetHeightMapFunc(
						function()
						Spring.SetHeightMap(i,j,y)				
						end)
		end
	end
end
end

function aSetUnitSelector(id,time)
Sleep(time)
Spring.SetUnitNoSelect(id,false)
end

Range=800
function aDistributor(ed)
ex,ey,ez=Spring.GetUnitPosition(ed)
T=Spring.GetUnitsInCylinder(ex,ez,Range)
	if T and #T>1 then
	table.remove(T,unitID)
	xMax,zMax=Game.mapX or 150, Game.mapZ or 150
		for i=1,#T do
		Spring.SetUnitMoveGoal(T[i],math.ceil(math.random(1,xMax)),0,math.ceil(math.random(1,zMax)))
		StartThread(aSetUnitSelector,T[i],3145)
		end
	end
end

function aExplanation()
	for i=Game.mapX/16,Game.mapX,Game.mapX/4 do
		for j=Game.mapZ/16,Game.mapZ,Game.mapZ/4 do
			if Spring.GetGroundHeight(i,j)> 10 and math.random(0,2)==1 then
				text=genMessageString()
				Spring.MarkerAddPoint(  i,  0,  j, text, true)
			end
		end
	end
end
startframe=Spring.GetGameFrame()
functionTable={}
function threadLoop()
timer=0
	while true do
		for i=1,#functionTable do
		functionTable[i](timer-startframe)
		end
	timer=timer+300
	Sleep(300)
	end
end

function aRefuel()
ex,ey,ez=Spring.GetUnitPosition(unitID)
T=Spring.GetUnitsInCylinder(ex,ey,250)
for i=1,#T do
Spring.SetUnitFuel(T[i],100)
end

end

function aCure()
ex,ey,ez=Spring.GetUnitPosition(unitID)
T=Spring.GetUnitsInCylinder(ex,ey,250)
	for i=1,#T do
		if T[i]~= unitID then
		_,maxhp=Spring.GetUnitHealth(T[i])
		Spring.SetUnitMaxHealth(T[i],math.ceil(maxhp*1.42))
		end
	end
end

function aGift(ed)
	functionTable["aGift"]= function (timer)
	end
end

function aChainExplosion(ed)
distance =0 
posx,posy,posz=Spring.GetUnitDistance(ed)

while distance <32 do
wed=Spring.GetUnitNearesAlly(ed)
osx,osy,osz=Spring.GetUnitDistance(wed)
a,b,c=posx-osx,posy-osy,posz-osz
distance=math.sqrt(a*a+b*b+c*c)
Spring.DestroyUnit(ed)
posx,posy,posz=osx,osy,osz
ed=wed
end

end
-- Not inspired or entired by the Foorunners
NamePerk={ --Generic SciFi Name   --generic dramatic description    --generic SciFi Stuff happening
[1]={name="The Tower", description= "We raised these stones, to be rememberd", perk=aShortGloballos   },
[2]={name="The Nexus", description= " a Flame in the Night for those Fast as Light", perk=aExplanation   },
[3]={name="The Library", description= "Holding lost Secrets  ", perk=aTransferToTheTop   },
[4]={name="The Halls of Time", description= "Awaiting the dawn", perk= aStunOfEveryone  },
[5]={name="The Shield", description= "Awaiting the dawn", perk= aWildHealer  },
[6]={name="The Forge", description= "Our Downfall, our greed", perk= aDuplicator  },
[7]={name="The Last Light", description= "Fate be written, to other skys in laserlight", perk= aNothing  },
[8]={name="The Core", description= "Energy = Mass* Lightspeed²", perk= aEnergy  },
[9]={name="The GeneracSciFiTemplate", description= "¦/<\\ ¦||/  \\/-/\\_  ||¦", perk= aMetall  },
[10]={name="The Archive", description= "¦/<\\ ¦|__|/  -/\\_  ||¦", perk= aUnitTransfer  },
[11]={name="The Spire", description= "Emperator we raise you these gifts", perk= aGift  },
[12]={name="The Embassy", description= "They came from afar", perk= aSuddenTransportToMapEdge  },
[13]={name="The Garden", description= "Meditions off green", perk= aTerraFormation  },
[14]={name="Oblivion", description= "Plans to dust", perk= aDistributor  },
[15]={name="The Shipyard", description= "Forever under Construction", perk= aAntiGravity  },
[16]={name="The Dominiondepot", description= "Fuel for the Fools", perk= aRefuel  },
[17]={name="The Healinghouses", description= "Mendo Mori", perk= aCure  },
[18]={name="The Arsenal", description= "Memento Mori, deploy Devouri", perk= aChainExplosion  },


}

chosenPerk=math.floor(math.random(1,#NamePerk))

floatcenter=piece"floatcenter"
CenterUP=70
function script.Create()
Move(center,y_axis,CenterUP,0,true)

Spin(floatcenter,y_axis,math.rad(2),0)
Hide(Emitor)
	for i=1,4 do
	Hide(EmitorLimbs[i])
	end
	for i=1,OUT,1 do
	Hide(OutPostPieces[i].piece)
	end
	--base
hideT(base)
boolSuccess=false
for i=1,4 do
if deMaRa()==true then
 Show(base[i])
 boolSuccess=true
 break 
 end
end

if boolSuccess==false then Show(base[4]) end
hideT(Scrap)
hideT(FloatPieces)
hideT(P)
Spring.SetUnitTooltip (unitID,NamePerk[chosenPerk].name.." - ".. (NamePerk[chosenPerk].description))
Spring.SetUnitNeutral(unitID,true )
val=deMaRaVal(360)
Turn(center,y_axis,math.rad(val),0)

buildFeature()
Show(center)
StartThread(threadLoop)
StartThread(selfRepairLoop)
end

function script.Killed(recentDamage,_)
for i=1,9 do
DamageModel()
end
suddenDeathV(recentDamage)
return 1
end

LinPiece={}
LinPiece[1]=center
SymPiece={} 
SymPiece[1]=center

boolFlat=false
boolFloat=false
boolAtAll=deMaRa()
Visible={}
function buildFeature()
	for i=1,#P-2,2 do
	if i> FLATLIMIT then boolFlat=true end
	if i > #P-LIMB then boolFloat=true end
	
		if deMaRa() then --skip
		Hide(P[i])
		Hide(P[i+1])
		Visible[i]	=false
		Visible[i+1]=false
		else
		Visible[i]=true
		Visible[i+1]=true
		pointPair={[1]={x=0,y=0,z=0,name=center},[2]={x=0,y=0,z=0,name=center}}
		boolSymExpand=false
			if deMaRa() and boolAtAll == true then 
			--symetrical expand
					boolSymExpand=true
					pointPair[1],pointPair[2]=getSymPosPair(P[i],P[i+1])
					deg=math.abs(deMaRaVal(150)+15)
					
					Turn(pointPair[1].name,y_axis,math.rad(90),0,true)
					Turn(pointPair[2].name,y_axis,math.rad(-90),0,true)
			else
			--linear expand
					pointPair[1],pointPair[2]=getLinPosPair(P[i],P[i+1])
					Turn(pointPair[1].name,y_axis,math.rad(180),0,true)
			
			end
			
			if boolSymExpand==true and pointPair[1] and pointPair[2] then
			Turn(pointPair[1].name,y_axis,math.rad(180),0) 
			end
			--Spring.Echo("MovingPieceTo")
			Show(pointPair[1].name)
			Show(pointPair[2].name)
			MovePieceToRelativeWorldPos(unitID,pointPair[1].name,pointPair[1].x,pointPair[1].y,pointPair[1].z,0)
			MovePieceToRelativeWorldPos(unitID,pointPair[2].name,pointPair[2].x,pointPair[2].y,pointPair[2].z,0)
		end
	end
--	if math.random(0,2)==1 then StartThread(showEmitor) end
	if deMaRa()==true then showOutPosts() end
	if deMaRa()==true  then showFloaters() end
	andIllBeHardCore()
end
function andIllBeHardCore()
if deMaRa()== false and deMaRa()==true then
StartThread(showEmitor)
	Show(P[35])
	Show(P[36])	
	          
	Show(P[39])
	Show(P[40])	
	
	Show(Emitor)
	showT(EmitorLimbs)
	
	Move(Emitor,y_axis,470,0)
	Move(P[35],y_axis,250,0)
	Move(P[39],y_axis,300,0)
	Move(P[40],y_axis,340,0)
	Move(P[36],y_axis,390,0)
	Move(P[35],x_axis,0,0)
	Move(P[36],x_axis,0,0)	
	Move(P[35],z_axis,0,0)
	Move(P[36],z_axis,0,0)	
	
	Move(P[39],x_axis,0,0)
	Move(P[40],x_axis,0,0)	
	Move(P[39],z_axis,0,0)
	Move(P[40],z_axis,0,0)
	
	Spin(P[35],y_axis,math.rad(42),0)
	Spin(P[36],y_axis,math.rad(-42),0)	
	
	Spin(P[39],x_axis,math.rad(42),0)
	Spin(P[39],y_axis,math.rad(-42),0)
	Spin(P[40],z_axis,math.rad(-42),0)
	Spin(P[40],y_axis,math.rad(42),0)
	else
		Hide(P[35])
		Hide(P[36])	     
		Hide(P[39])
		Hide(P[40])	
	end
end
function showOutPosts() 
start=math.random(10,170)
	for i=1,#OutPostPieces-2, 2 do
		if deMaRa() then
		Show(OutPostPieces[i].piece)
		Show(OutPostPieces[i+1].piece)	
		Move(OutPostPieces[i].piece  ,x_axis,math.max(300,deMaRaVal(420)),0)
		Move(OutPostPieces[i+1].piece,x_axis,math.max(300,deMaRaVal(420)),0)
		Turn(OutPostPieces[i+1].piece,y_axis,math.rad(180),0)
		deg=start+15*i
	
		Turn(OutPostPieces[i].center,y_axis, math.rad(deg),0,true)
		Turn(OutPostPieces[i+1].center,y_axis, math.rad(360-deg),0,true)
		ax,_,az=Spring.GetUnitPiecePosDir(unitID,OutPostPieces[i].piece)
		bx,_,bz=Spring.GetUnitPiecePosDir(unitID,OutPostPieces[i+1].piece)
		MoveUnitPieceToRelativeWorldPos(unitID,OutPostPieces[i].piece,ax,az,0,-CenterUP)
		MoveUnitPieceToRelativeWorldPos(unitID,OutPostPieces[i+1].piece,bx,bz,0,-CenterUP)
		end
	end
end

function showFloaters()
	div=2^math.ceil(math.random(0,5))
	dev=360/FLOAT
	speed=math.random(12,32)
	
	for i=1,FLOAT do
		if deMaRa()then
		Show(FloatPieces[i])
		Turn(FloatPieces[i],y_axis,math.rad(dev*i),0,true)
		Spin(FloatPieces[i],y_axis,math.rad(speed*math.random(-1,1)),0)
		
  		if deMaRa() then --angle the piece
  		slight=math.random(-2,2)
  			if deMaRa() then
  			Turn(FloatPieces[i],x_axis,math.rad(slight),0)
  			else
  			Turn(FloatPieces[i],z_axis,math.rad(slight),0)
  			end
		  end
      end
	end
end

function getLinPosPair(pieceA,pieceB)
nr=math.floor(math.random(1,#LinPiece))

x,y,z=Spring.GetUnitPiecePosDir(unitID,LinPiece[nr])

	scaleX,scaleY,scaleZ,offsetX,offsetY,offsetZ,volumeType,testType,primaryAxis, disabled=Spring.GetUnitPieceCollisionVolumeData(unitID,LinPiece[nr])
	if boolFloat==false then
	LinPiece[#LinPiece+1]=pieceA
	LinPiece[#LinPiece+1]=pieceB
	end

	upVal=scaleY/-2
	--if boolFlat==false then upVal=y end
	--guarantees that smaller pieces up have a chance to float
	--	if boolFloat==true and deMaRa() and deMaRa() then upVal=upVal+math.random(10,120) end
	
	 if  deMaRa() then --x_axis only
	return{x=x-scaleX/2,y=y+upVal/2,z=z,name=pieceA},{x=x+scaleX/2,y=y+upVal/2,z=z,name=pieceB}
	
	 else -- x_axis and up
	 return {x=x-scaleX/2,y=y+upVal,z=z,name=pieceA},{x=x+scaleX/2,y=y+upVal,z=z,name=pieceB}
	 end


end

function getSymPosPair(pieceA,pieceB)
nr=math.random(1,#LinPiece)
dx,dy,dz=Spring.GetUnitPiecePosDir(unitID,LinPiece[nr])
scaleX,scaleY,scaleZ,offsetX,offsetY,offsetZ,volumeType,testType,primaryAxis, disabled=Spring.GetUnitPieceCollisionVolumeData(unitID,LinPiece[nr])
pscaleX,pscaleY,pscaleZ=Spring.GetUnitPieceCollisionVolumeData(unitID,pieceA)
	Show(pieceA)
	Show(pieceB)
	if boolFloat==false then
	SymPiece[#SymPiece+1]=pieceA
	SymPiece[#SymPiece+1]=pieceB
	end

	upVal=scaleY/-2
	-- if boolFlat==true then upVal=scaleY end
	-- if boolFloat==true and math.random(0,10)==5 then upVal=upVal+math.random(10,120) end
	xrandom=math.random(-scaleX/2,scaleX/2)

	
	return{x=dx,y=dy+upVal,z=dz+scaleZ/2+pscaleZ/2,name=pieceA},{x=dx,y=dy+upVal,z=dz-scaleZ/-2-pscaleZ/2,name=pieceB}
	
end

function resetTimer()
boolBlocked=true
Sleep(120000)
boolBlocked=false
end

--perkfunctions
boolBlocked=false
function script.HitByWeapon ( x, z, weaponDefID, damage )
	if boolBlocked== false then
	 ed=Spring.GetUnitNearestEnemy(unitID)
		 if ed then
		DamageModel()
		NamePerk[chosenPerk].perk(ed)
		StartThread(resetTimer)
		end
	return damage
	else

	return 1
	end
end
emitFloater=piece"emitFloater"
function glowingReactor()
accum=0
	while true do
	EmitSfx(P[35],1026)
	accum=accum+0.01	
	Move(emitFloater,y_axis,30+math.cos(accum/10000)+math.sin(accum)*42,17)
	EmitSfx(P[35],1027)
	EmitSfx(P[36],1027)
	Sleep(25)
	end

end

function showEmitor()
--show Emitor
StartThread(glowingReactor)
if maRa()==true then Spin(Emitor,y_axis,math.rad(3),0.1) end
  while true do
  --charge Up
  Turn(EmitorLimbs[1],x_axis,math.rad(0),0.2*(33/20))
  Turn(EmitorLimbs[2],x_axis,math.rad(0),0.2*(33/20))
  Turn(EmitorLimbs[3],z_axis,math.rad(0),0.2*(23/20))
  Turn(EmitorLimbs[4],z_axis,math.rad(0),0.2*(49/20))
  WaitForTurn(EmitorLimbs[4],z_axis)
  
  Turn(EmitorLimbs[3],z_axis,math.rad(15),80)
  Turn(EmitorLimbs[4],z_axis,math.rad(-4),80)
    WaitForTurn(EmitorLimbs[4],z_axis)
  --Emit
  EmitSfx(Emitor,1026)
  EmitSfx(Emitor,1025)
  Turn(EmitorLimbs[1],x_axis,math.rad(-33),22)
  Turn(EmitorLimbs[2],x_axis,math.rad(33),22)
  Turn(EmitorLimbs[3],z_axis,math.rad(23),22)
  Turn(EmitorLimbs[4],z_axis,math.rad(-49),22)
   WaitForTurn(EmitorLimbs[4],z_axis)
   Sleep(9000)
  end
end

scrapCenter= piece"ScrapCenter"

function DamageModel()
	name=""
	for i=1,#P do
		if 	Visible[i]==true then
		 name=P[i] 
			if deMaRa() ==true then break end
		 end
	 
	end
		if name~="" then
		dx,dy,dz=Spring.GetUnitPiecePosDir(unitID,name)
		vx,vy,vz=Spring.GetUnitPieceCollisionVolumeData(unitID,name)
		
		Move(scrapCenter,x_axis,dx,0)
		Move(scrapCenter,z_axis,dz,0,true)
			for i=1,#Scrap do
				MovePieceToTheMax(dx,dy,dz,vx,vy,vz,Scrap[i])
				if maRa()==true then
				Move(scrapCenter,y_axis,vy/2,0,true)
				else
				Move(scrapCenter,y_axis,vy/2*2,0,true)
				end
			Explode(Scrap[i],SFX.FIRE +SFX.FALL)
			end
		Hide(name)
		end
end

function MovePieceToTheMax(dx,dy,dz,vx,vy,vz,Scrap)
x,y,z=Spring.GetUnitPiecePosDir(unitID,Scrap)
ax,ay,az=x-dx,y-dy,z-dz
dirVec={x=ax/math.abs(ax),y=ay/math.abs(ay),z=az/math.abs(az)} --contains all the directions
distx,disty,distz=dirVec.x*math.abs(vx-ax),dirVec.y*math.abs(vy-ay),dirVec.z*math.abs(vz-az)
Move(Scrap,x_axis,dx+distx,0)
Move(Scrap,y_axis,dy+disty,0)
Move(Scrap,z_axis,dz+distz,0,true)

end

DroneTable={}
DroneTable[1] = piece("Drone1")
DroneTable[2] = piece("Drone2")
DroneTable[3] = piece("Drone3")


droneNr=1
function selfRepairLoop()
	hideT(DroneTable)
	hp,maxhp=Spring.GetUnitHealth(unitID)
	Spring.SetUnitHealth(unitID,maxhp-460)

	while true do
	hp,maxhp=Spring.GetUnitHealth(unitID)
		if hp < maxhp-200 and droneNr < 4 then
		StartThread(flyADrone, droneNr)
		droneNr=droneNr+1
		end

	
	Sleep(10000)
	end

end

function flyADrone(nr)
Show(DroneTable[nr])
--rise
Move(DroneTable[nr],y_axis, 290,7.35)
Spin(DroneTable[nr],y_axis,math.rad(3),0.1)
WaitForMove(DroneTable[nr],y_axis)
StopSpin(DroneTable[nr],y_axis)
Turn(DroneTable[nr],y_axis,0,0.1)
Turn(DroneTable[nr],x_axis,math.rad(90),0.1)

	--approach
	counter=math.random(1,#P)
	pname=P[counter]
		while Visible[counter]==false do
		counter=(counter%#P)+1
		pname=P[counter]
		end


	dx,dy,dz=Spring.GetUnitPiecePosition(unitID,pname)
	cspeed=42/(dx+dy+dz)
	Move(DroneTable[nr], x_axis,dx ,dx *cspeed)
	Move(DroneTable[nr], y_axis,dy ,dy *cspeed)
	Move(DroneTable[nr], z_axis,dz ,dz *cspeed)
	WaitForMove(DroneTable[nr], y_axis)

	--weld 
	time=math.ceil(math.random(9000,40000))
	Turn(DroneTable[nr],y_axis,math.rad(math.random(-360,360)),1.5)
		deci=math.random(-2,2)
		deci=deci/math.abs(deci)
		
		while time > 0 do
		dy=dy +deci*math.random(0.1,2)
		Move(DroneTable[nr], y_axis,dy ,0.5)
		
	
		lim=math.ceil(math.random(150,400)/4)
		for i=1,4 do
		Sleep(lim)
		EmitSfx(DroneTable[nr],1028)
		end
		WaitForMove(DroneTable[nr], y_axis)
		hp,maxhp=Spring.GetUnitHealth(unitID)
		Spring.SetUnitHealth(unitID,math.min(hp+1,maxhp))
		
		time=time-lim*4
		end

		
--return
Move(DroneTable[nr],y_axis,160,3.25)
WaitForMove(DroneTable[nr],y_axis)
Move(DroneTable[nr],x_axis, 0,3.15)
Move(DroneTable[nr],z_axis, 0,3.15)
Move(DroneTable[nr],y_axis,0,3.55)
WaitForMove(DroneTable[nr],y_axis)

Hide(DroneTable[nr])
droneNr=droneNr-1
end
