include "suddenDeath.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage
Black=piece"Black"
emit1=piece"emit1"
emit2=piece"emit2"

	Singularity=piece"Singularity"
	jDarkGate=piece"jDarkGate"
	rotPoint=piece"rotpoint"
	center=piece"center"
dGT={}

SIG_SFX=2
SIG_ROTATE=4
SIG_SING=8
SIG_INIT=16

for i=1,5,1 do
name="DarkGate"..i
dGT[i]=piece(name)
end



function aquireDegree(ax,az,ox,oz)
Spring.Echo("JWDarkGateScript::ax"..ax)
Spring.Echo("JWDarkGateScript::az"..az)
Spring.Echo("JWDarkGateScript::ox"..ox)
Spring.Echo("JWDarkGateScript::oz"..oz)
	val=math.atan2(ax-ox,az-oz)
	if val < 0 then val =val+ 2*3.14159 end

	return math.deg(val)
	end


function script.Create()

Hide(emit1)
Hide(emit2)
Hide(Black)
for i=1,5,1 do
Hide(dGT[i])
end
StartThread(init)
end

boolInitCompleted=false
function init()
SetSignalMask(SIG_INIT)
Move(Singularity,z_axis,130,0)
Turn(jDarkGate,x_axis,math.rad(91),0)
Move(jDarkGate,y_axis,-88,0)
Move(jDarkGate,y_axis,-44,2.7)
WaitForMove(jDarkGate,y_axis)
Turn(jDarkGate,x_axis,math.rad(0),0.12)
Move(jDarkGate,y_axis,0,3)
WaitForMove(jDarkGate,y_axis)
WaitForTurn(jDarkGate,x_axis)

dist=130
speed=2.2

while (dist > 0) do
Move(Singularity,z_axis,dist,speed)
dist=dist-10
speed=speed*speed
WaitForMove(Singularity,z_axis)
end
for i=1,5,1 do
Show(dGT[i])
end

StartThread(rotateSingularity)
StartThread(rotateAll)
StartThread(sFX)
StartThread(goodTimesbadTimes)
boolInitCompleted=true

end

function GetDistanceToHole(vicID,x,y,z)
vx,vy,vz=Spring.GetUnitPosition(vicID)
if vx then
return math.sqrt((vx-x)^2+(vz-z)^2)
end
end

function getEaten(victimID,distance, unitID,x,z)
	local spSetPosition= Spring.SetUnitPosition--Todo SetUnitPosition
	local spValidUnitID=Spring.ValidUnitID
	factor=1/distance
	tx,ty,tz=x,0,z
	while gx ~= cx and gz ~= cz and spValidUnitID(id)==true do
	tx=(gx*factor+cx*(1-factor))
	ty=(gy*factor+cy*(1-factor))
	tz=(gz*factor+cz*(1-factor))
    spSetPosition(id,tx,ty,tz)
	factor=factor+0.01
	Sleep(15)
	end
	Spring.DestroyUnit(victimID,true,true)
end
		
globalRange=1

function aWildBlackHoleAppears()
Spring.PlaySoundFile("sounds/jdarkgate/implosion.ogg",1.0) 
if boolInitCompleted==true then
	Turn(jDarkGate,x_axis,math.rad(0),0)
	Turn(jDarkGate,y_axis,math.rad(0),0)
	Turn(jDarkGate,z_axis,math.rad(0),0)
	--Move(Singularity,z_axis,-130,25)
	Move(Singularity,y_axis,60,25)
	WaitForMove(Singularity,y_axis)

	Signal(SIG_ROTATE)
	Signal(SIG_SFX)
	Signal(SIG_SING)
	Signal(SIG_INIT)

	Show(Black)
	Hide(jDarkGate)
		for i=1,5,1 do
		Hide(dGT[i])
		end

	range=150
	maxrange=700
	blackHoleTimer=45000
	naptime=1
	--UnitDistance
	UnitTable={}
	x,y,z=Spring.GetUnitPosition(unitID)
	accu=13500

	SuckerTable={}

		while (blackHoleTimer > 0) do

		range=math.min(range+1,maxrange)
		globalRange=range
		if blackHoleTimer %4== 0 then
		Table={}
		Table=Spring.GetUnitsInCylinder(x,z,range)
		table.remove(Table,unitID)
		--check for new Affected Units
			
			if Table then
				for k=1 ,#Table, 1 do
					if Table[k]~=unitID then
						if SuckerTable[Table[k]] then 
						else
						SuckerTable[Table[k]]=GetDistanceToHole(Table[k],x,y,z)				
							if SuckerTable[Table[k]] and SuckerTable[Table[k]] < range then
							StartThread(dragtowards,SuckerTable[Table[k]], Table[k], unitID,x,z, SuckerTable[Table[k]]/range)
							if math.random(0,1)==0 then Spring.PlaySoundFile("sounds/jdarkgate/suckInAtIt.ogg",1.0) else Spring.PlaySoundFile("sounds/jdarkgate/jdarkgatevortex3.ogg",1.0) end
							
								else
								SuckerTable[Table[k]]=nil
								end
						end
					end
				end
			end
		end
		--move closer to core, rotate via move controll or swallow

		EmitSfx(Singularity,1027)
		Sleep(naptime)
		accu=accu+naptime
		
				if accu > 13500 then
					if math.random(0,1) == 1 then	Spring.PlaySoundFile("sounds/jdarkgate/jdarkgatevortex.ogg",1.0) else 
						if math.random(0,1)==1 then Spring.PlaySoundFile("sounds/jdarkgate/jdarkgatevortex2.ogg",1.0) 
						else Spring.PlaySoundFile("sounds/jdarkgate/jdarkgatevortex4.ogg",1.0)
						end
					end
				accu =0 	
				end
		blackHoleTimer=blackHoleTimer-naptime
		end
		
		
	Move(Singularity,y_axis,-160,52)
	WaitForMove(Singularity,y_axis)
	return 1
	end
return 1
end


	
	function relPos(x,z,xo,zo)
	return x-xo,z-zo
	end
	
	function retPos(x,z,xo,zo)
	return x+xo,z+zo
	end

	function dragtowards( distance,victimid, unitID,gateX,gateZ, fac)
	
	local spSetUnitPosition=Spring.SetUnitPosition
	local spGetUnitPosition=Spring.GetUnitPosition

	--local spSetRotationOffset=Spring.MoveCtrl.SetRotationOffset
	local factor = fac
	olPoX,_,olPoZ=spGetUnitPosition(victimid)
	
	time=15
	modulus=0

			while factor > 0.33 and factor < 1 and Spring.ValidUnitID (victimid) do

			modulus=(modulus+1)%11
					if modulus% 10 ==0 then
					factor = GetDistanceToHole(victimid,gateX,0,gateZ)/globalRange 		
					end
					Sleep(time)

					olPoX,whY,olPoZ		= spGetUnitPosition(victimid)
					newPosX,newPosZ		= relPos(olPoX,olPoZ,gateX,gateZ)
					olPoX,olPoZ			= newPosX, newPosZ					
					newPosX,newPosZ=newPosX*(1-(1-factor)/10),newPosZ*(1-(1-factor)/10)
					midX,midZ=newPosX*factor+olPoX*(1-factor), newPosZ*factor+olPoZ*(1-factor)
					
					midX,midZ= retPos(midX,midZ,gateX,gateZ)							
					spSetUnitPosition(victimid,midX,whY,midZ)		
						
		end
		
		
				if factor >= 1 then return end
		local ldrehM=drehMatrix
		local lretPos=retPos
		local lrelPos=relPos
		local spMovCtrlSetPos=Spring.MoveCtrl.SetPosition
		local lGetDistanceToHole=GetDistanceToHole
		local spGetUnitRotation=Spring.GetUnitRotation
		local spSetUnitRotation=Spring.MoveCtrl.SetRotation
				
				r,p,y=spGetUnitRotation(victimid)
				Spring.MoveCtrl.Enable(victimid,true)
				Spring.SetUnitNeutral(victimid,true)
				Spring.SetUnitBlocking (victimid,false,false)
				
				x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,Singularity)			
				olPoX,whY,olPoZ		= spGetUnitPosition(victimid)
				degree= math.atan2(olPoX-x,z-olPoZ-z)
				
				
				while factor > 0.1 do
				
					factor = lGetDistanceToHole(victimid,gateX,0,gateZ)/globalRange 
					--Spring.Echo("JWDarkGateScript::DegreeRotation"..degree)
					olPoX,_,olPoZ		= spGetUnitPosition(victimid)
					newPosX,newPosZ		= lrelPos(olPoX,olPoZ,x,z)
							
					whY=math.min(whY+0.1,y)
					midX,midZ=0.99*newPosX*factor+newPosX*(1-factor), 0.99*newPosZ*factor+newPosZ*(1-factor)
					--assertFour(midX,midZ,gateX,gateZ,2)
				
					
					tx,tz=ldrehM(midX,midZ,degree+0.025)
					degree=(degree+(1-factor))% 6.28318
					tx,tz= retPos(tx,tz,x,z)
					spMovCtrlSetPos(victimid,tx,whY,tz)
					r,p,y=r-0.001,p+0.002,y
					spSetUnitRotation(victimid,r,p,y)
					Sleep(5)
					end
				Spring.DestroyUnit(victimid,true,true)
				
	end


function drehMatrix(y,x,rad)
--assertFour(y,x,zx,zy,4)


	   sinus=math.sin(rad)
	   cosinus= math.cos(rad)

							tempX=  x*cosinus + y*sinus*-1
							y=  x*sinus  + y*cosinus
							

return tempX,y
end


function GetHeightMap(size,TableOfPoints)
Table={}
hs=size/2
refDistantOne=0.1
		for i=1,size,1 do
		Table[i]={}
		for j=1,size,1 do
			value=0
			addval=0
			centerDist=math.sqrt((j-hs)^2+(i-hs)^2)

			if  centerDist < hs-1 then
			nr=getClosestPoint(TableOfPoints,i,j)
			if nr==1 then
				if centerDist >refDistantOne then refDistantOne=centerDist end

			value= math.ceil(TableOfPoints[nr].val)+math.random(0,3)+ (math.ceil(TableOfPoints[nr].val)*-1)*((centerDist+0.1)/refDistantOne)
			else

			value=math.ceil(TableOfPoints[nr].val)+math.random(0,3)
			end
			end

			if value ~= 0 then
			addval=(hs-centerDist)*2.75
			end

			Table[i][j]=value-addval
		end

		end
return Table
end

function getClosestPoint(Table,i,j)
maxdist, index =100000, 1

	for k=1,table.getn(Table),1 do
	if k==1 then
	dist=math.max(1,math.sqrt((i-Table[k].x)^2 + (j-Table[k].z)^2)+Table[k].sizebonmal)
	maxdist=dist
	index=k
	end
	dist=math.sqrt((i-Table[k].x)^2 + (j-Table[k].z)^2)+Table[k].sizebonmal
	--Spring.Echo("Point ("..i.."/"..j..") has Distance "..dist.." at Table "..k)

		if dist < maxdist then
		maxdist=dist
		index=k
		end
	end
return index
end

function script.Killed(recentDamage,_)
Signal(SIG_SFX)
Signal(SIG_ROTATE)
Signal(SIG_SING)

Hide(jDarkGate)
for i=1,#dGT,1 do
Hide(dGT[i])
end

teamID=Spring.GetUnitTeam(unitID)
Spring.SetTeamResource(teamID,"m",0)
Spring.SetTeamResource(teamID,"e",0)

	--GG.DynDefMap and it contains {x,z, Size, Table}
	--Here be Singularity

	x,y,z=Spring.GetUnitPosition(unitID)
	size=40
	nrOfPoints=22
	TableOfPoints={}
	hight=Spring.GetGroundHeight(x,z)
	depthmax=-20+ hight*-1
	for k=1,nrOfPoints, 1 do
		if k==1 then
		h=Spring.GetGroundHeight(x,z)
		TableOfPoints[1]={x=size/2,z=size/2, val=-1*h+15,sizebonmal=math.random(-5,5)}
		else
		dx,dz=drehMatrix(0,size/2+math.random(size/-3,size/-4),size/2,size/2, k*15+ math.random(-4,4))
		TableOfPoints[k]={x=dx,z=dz, val=math.random(math.ceil(depthmax*0.75),math.ceil(depthmax*0.05)),sizebonmal=math.random(-3,3)}
		end
	end

if GG.DynDefMap == nil then GG.DynDefMap={} end
if GG.DynRefMap == nil then GG.DynRefMap={} end
GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="sub", filterType="none"}
GG.DynRefMap[#GG.DynRefMap+1]=	GetHeightMap(size,TableOfPoints)
val= aWildBlackHoleAppears()
x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,Singularity)
GG.UnitsToSpawn:PushCreateUnit("gdecsingscar",x,0,z,0,teamID)
Spring.DestroyUnit(unitID,true,true)
return 0
end

function goodTimesbadTimes()
--<DEBUG>
--StartThread(testDegree)
--</DEBUG>
local spAdd= Spring.AddTeamResource
local spSub= Spring.UseTeamResource
local teamID=Spring.GetUnitTeam(unitID)
	while true do
	val=math.random(100,420)
	negVal=val+ math.random(200,600)

		for i=1,60, 1 do
			if math.random(0,1)==1 then
			if val > 0 then
			amount=math.ceil(val/(60+1-i))
			spAdd(teamID,"metal",amount)
			spAdd(teamID,"energy",amount)
			val=val-amount
			end
			else
			if negVal >0 then
			amount=math.ceil(negVal/(60+1-i))
			spSub(teamID,"metal",amount)
			spSub(teamID,"energy",amount)
			negVal=negVal-amount
			end
			end
		Sleep(1000)
		end
	end
end



function sFX()
SetSignalMask(SIG_SFX)
	while true do
	Sleep(3000)
	EmitSfx(emit2,1025)
	Sleep(3000)
	EmitSfx(emit2,1026)
	end
end

function rotateAll()
SetSignalMask(SIG_ROTATE)
Spin(dGT[5],z_axis,math.rad(-222),0.03)
	while true do
		for i=1,4,1 do
		dice=math.random(100,200)
		Spin(dGT[i],z_axis,math.rad(dice),0.03)
		end
	rest=math.ceil(math.random(12000,32000))
	Sleep(rest)
		for i=1,4,1 do
		StopSpin(dGT[i],z_axis,0.03)
		end
	Sleep(3000)
	end

end

function rotateSingularity()
SetSignalMask(SIG_SING)
	while true do
	dice=math.random(0,360)
		if math.random(0,1)== 1 then
		Turn(Singularity,y_axis,math.rad(dice),125)
		WaitForTurn(Singularity,y_axis)
			elseif math.random(0,1) then
			Turn(Singularity,x_axis,math.rad(dice),90)
			WaitForTurn(Singularity,x_axis)
				else
				Turn(Singularity,x_axis,math.rad(dice),90)
				WaitForTurn(Singularity,x_axis)
				end
	end
end

