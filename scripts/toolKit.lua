--This Section contains standalone functions to be executed as independent systems monitoring and handling lua-stuff
--mini OS Threads

--> jobfunc header jobFunction(unitID,x,y,z, Previousoutcome)  --> checkFuncHeader  checkFunction(unitID,x,y,z,outcome)
function getJobDone(unitID, dataT, jobFunction, checkFunction,rest)
local spGetUnitPosition=Spring.GetUnitPosition
x,y,z=spGetUnitPosition(unitID)
outcome=false

	while checkFunction(unitID,dataT,x,y,z,outcome) ==false do
	x,y,z=spGetUnitPosition(unitID)
	outcome=jobFunction(unitID, dataT, x,y,z, outcome)
	Sleep(rest)
	end

end

--> genericOS
function genericOS(unitID, dataT,jobFunctionT, checkFunctionT,rest)
local spGetUnitPosition=Spring.GetUnitPosition
x,y,z=spGetUnitPosition(unitID)
outcomeTable=iniT(#jobFunctionT,false)
boolAtLeastOneNotDone=true
	while boolAtLeastOneNotDone ==true do
	x,y,z=spGetUnitPosition(unitID)
		for i=1,#jobFunctionT do
		outcomeTable[i]=jobFunctionT[i](unitID,x,y,z, outcomeTable[i])
		Sleep(rest)
		end
	boolAtLeastOneNotDone=true
		for i=1,#checkFunctionT do
		boolAtLeastOneNotDone= checkFunction(unitID,x,y,z,outcomeTable[i]) and boolAtLeastOneNotDone
		Sleep(rest)
		end
	
	end
end


function randomRotate(Piecename,axis, speed, rangeStart,rangeEnd)
	while true do
	Turn(Piecename,axis,math.rad(math.random(rangeStart,rangeEnd)),speed)
	WaitForTurn(Piecename,axis)
	Sleep(1000)
	end

end

-->plays the sounds handed over in a table 
function playSoundByUnitTypOS(unitID,loudness,SoundNameTimeTable)
	 unitdef=Spring.GetUnitDefID(unitID)
	
	while true do
	dice=math.random(1,#SoundNameTimeTable)

	PlaySoundByUnitType(unitdef, SoundNameTimeTable[dice].name,loudness, SoundNameTimeTable[dice].time, 1)
	Sleep(1000)
	end
end

--===================================================================================================================
--Game specific functions
--> creates a table from names to check unittypes against
function getaTypeTable(Stringtable,UnitDefNames)
retVal={}
	for i=1,#Stringtable do
	assert(UnitDefNames[Stringtable[i]], "Error: Unitdef of Unittype "..Stringtable[i].. " does not exists")
	retVal[UnitDefNames[Stringtable[i]].id]=true
	end
return retVal
end

--> JW specific function returning the factorys of the game
function getFactoryTypeTable(IWant)
FactoryTypes={}	


if IWant=="c" then
FactoryTypes[UnitDefNames["fclvlone"].id]=true
FactoryTypes[UnitDefNames["fclvl2"].id]=true
FactoryTypes[UnitDefNames["condepot"].id]=true
return FactoryTypes
end

if IWant=="j" then
FactoryTypes[UnitDefNames["jtransportedfactory1"].id]=true
FactoryTypes[UnitDefNames["eggstackfac"].id]=true
FactoryTypes[UnitDefNames["jmovingfac1"].id]=true
return FactoryTypes
end

--I want it all
FactoryTypes[UnitDefNames["jtransportedfactory1"].id]=true
FactoryTypes[UnitDefNames["eggstackfac"].id]=true
FactoryTypes[UnitDefNames["jmovingfac1"].id]=true
FactoryTypes[UnitDefNames["fclvlone"].id]=true
FactoryTypes[UnitDefNames["fclvl2"].id]=true
FactoryTypes[UnitDefNames["condepot"].id]=true
return FactoryTypes

end


--===================================================================================================================
--functions
-->returns the Negated Value
function N(value)
value=-1*value
return value
end

-->returns the distance of a vector
function distance(x,y, z)
return math.sqrt(x*x+y*y+z*z)
end

-->returns the Distance between two units
function GetUnitDistance(idA, idB)
x,y,z =Spring.GetUnitPosition(idA)
xb,yb,zb=Spring.GetUnitPosition(idB)
return GetTwoPointDistance(x,y,z,xb,yb,zb)
end

-->returns Distance between two points
function GetTwoPointDistance(x,y,z,ox,oy,oz)
x=x-ox
y=y-oy
z=z-oz
return  math.sqrt(x*x+y*y+z*z)
end

--> gives a close hunch at the distance and avoids expensive sqrt math
function approxDist(x,y,z)
x=(x*x+y*y+z*z)-1
xs=x*x
return ((((1+ (x/2))+ ((xs)/-8))+((xs*x)/16))+((xs*xs*5)/-128))
end

--> Converts to points, to a degree
function convPointsToDeg(ox,oz,bx,bz)
	if not bx then --orgin cleaned point
	return math.atan2(ox,oz)
		else
		bx=bx-ox
		bz=bz-oz
		return math.atan2(bx,bz)
		end
end

-->Turn a piece towards a random direction
function turnPieceRandDir(piecename,speed, LIMUPX,LIMLOWX,LIMUPY,LIMLOWY,LIMUPZ,LIMLOWZ)
if not limUpX then
Turn(piecename,x_axis,math.rad(math.random(-360,360)),speed)
Turn(piecename,y_axis,math.rad(math.random(-360,360)),speed)
Turn(piecename,z_axis,math.rad(math.random(-360,360)),speed)
else
Turn(piecename,x_axis,math.rad(math.random(LIMLOWX,LIMUPX)),speed)
Turn(piecename,y_axis,math.rad(math.random(LIMLOWY,LIMUPY)),speed)
Turn(piecename,z_axis,math.rad(math.random(LIMLOWZ,LIMUPZ)),speed)
end
end
-->Reset a Piece at speed
function resetPiece(piecename,speed)
Turn(piecename,x_axis,0,speed)
Turn(piecename,y_axis,0,speed)
Turn(piecename,z_axis,0,speed)

Move(piecename,x_axis,0,speed)
Move(piecename,y_axis,0,speed)
Move(piecename,z_axis,0,speed,true)
end

-->Reset a Table of Pieces at speed
function resT(tableName,speed)
	for i=1,#tableName do
	resetPiece(tableName[i],speed)
	end
end

-->Moves a UnitPiece to Position at speed
function MovePieceToPos(piecename, X,Y,Z,speed)

Move(piecename,x_axis,X,speed,true)
Move(piecename,y_axis,Y,speed,true)
Move(piecename,z_axis,Z,speed,true)	

end

-->Turns a Piece towards a direction 
function TurnPieceTowards(piecename,x,y,z,speed)
Move(piecename,x_axis,math.rad(x),speed)
Move(piecename,y_axis,math.rad(y),speed)
Move(piecename,z_axis,math.rad(z),speed,true)	

end

--> Moves a Piece to a WorldPosition
function MovePieceToRelativeWorldPos(id,piecename, relX,relY,relZ,speed)
x,y,z=Spring.GetUnitPosition(id)
x,y,z=relX-x,y-relY,relZ-z
Move(piecename,x_axis,x,speed)
Move(piecename,y_axis,y,speed)
Move(piecename,z_axis,z,speed,true)	

end

-->Returns randomized Values regarding truth 
function maRa()
return math.random(0,1)==1 
end

-->Moves a Piece to a Position on the Ground in UnitSpace
function MoveUnitPieceToGroundPos(unitID,piecename, X,Z,speed,offset)
x,globalHeightUnit,z=Spring.GetUnitPosition(unitID)
Move(piecename,x_axis,X,0)
Move(piecename,z_axis,Z,0,true)	
x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piecename)
	myHeight=Spring.GetGroundHeight(x,z)
	heightdifference=math.abs(globalHeightUnit-myHeight)
	if myHeight < globalHeightUnit then heightdifference=-heightdifference end
Move(piecename,y_axis,heightdifference+offset,speed,true)
end



-->Moves a Piece to a Position on the Ground in Worldspace
function MoveUnitPieceToRelativeWorldPos(unitID,piecename, relX,relZ,speed,offset)
x,globalHeightUnit,z=Spring.GetUnitPosition(unitID)
x,z=relX-x,relZ-z
Move(piecename,x_axis,x,0,true)
Move(piecename,z_axis,z,0,true)	
x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piecename)
	myHeight=Spring.GetGroundHeight(x,z)
	heightdifference=math.abs(globalHeightUnit-myHeight)
	if myHeight < globalHeightUnit then heightdifference=-heightdifference end
Move(piecename,y_axis,heightdifference+offset,speed,true)
end


-->Copys a table
function tableCopy(orig)
	local orig_type=type(orig)
	local copy
		if orig_type=='table' then
		copy={}
		for orig_key,orig_value in next, orig, nil do
		copy[tableCopy(orig_key)]=tableCopy(orig_value)
		end
		setmetatable(copy,tableCopy(getmetatable(orig)))
			else
			copy=orig
			end
	return copy
	end
	
	

-->Prints Out a Table	
function printOUT(tmap,squareSideDimension)
	local map={}
	map=tmap
	step=8
	if squareSideDimension~= nil and squareSideDimension < 129 then step=1 end
		for x=2,#map,step do
		StringToConcat=""
			for z=2,#map,step do
		
				
				if map[x][z] == nil  then 
						StringToConcat=StringToConcat.." X "
				elseif  map[x][z] == 0 then
						StringToConcat=StringToConcat.." 0 "
				elseif map[x][z] == false or map[x][z] == true then
						StringToConcat=StringToConcat.." € "
				else
				val=math.ceil(map[x][z])		
						if val < 10 and val >=0 then
					
						StringToConcat=StringToConcat.." "..val.." "
							elseif val >9 and val < 100 then
							StringToConcat=StringToConcat.." "..val
								elseif val > 99 then
								StringToConcat=StringToConcat..val
								else
								StringToConcat=StringToConcat..val
								end
						end		
					
				
			end	
			Spring.Echo("::"..StringToConcat.."::")
		end

	end	
	
	
function ANHINEG(value)
if value <0 then
value=M(value)
end
return value
end

function PP(value)
value=value+1
return value
end
--Bit Operators -Great Toys for the BigBoys
function SR(value,shift)
reSulTan=math.bit_bits(value,shift)
return reSulTan
end 

function SL(value,shift)
reSulTan=math.bit_bits(value,M(shift))
return reSulTan
end

function  AND(value1,value2)
reSulTan=math.bit_and(value1,value2)
return reSulTan
end

function OR(value1,value2)
reSulTan=math.bit_or(value1,value2)
return reSulTan
end

function XOR(value1,value2)
reSulTan=math.bit_xor(value1,value2)
return reSulTan
end

function INV(value)
reSulTanane=math.bit_inv(value)
return value
end


-->Rotates a point around another Point
function drehMatrix (x, y, zx, zy, degree)
x= x-zx
y=y-zy
x=(math.cos(degree)+ (-1*math.sin(degree)))*x
y=(math.cos(degree)+ (math.sin(degree)))*y

	IntCastX=x%1
	x=x-IntCastX
	IntCastY=y%1
	y=y-IntCastY

x=x+zx
y=y+zy
return x,y
end

-->Checks wether a point is within a triangle
function pointWithinTriangle(x1,y1,x2,y2,x3,y3,xt,yt)

--triAngleDeterminates
x1x2=0.5*(x1*y2-x2*y1)
x2x3=0.5*(x2*y3-x3*y2)
x3x1=0.5*(x3*y1-x1*y3)
--pointAngleDeterminates
x1xt=0.5*(x1*yt+xt*y1)
x2xt=0.5*(x2*yt+xt*y2)
x3xt=0.5*(x3*yt+xt*y3)

det1=x1x2+x1xt+x2xt--x1x2xt
det2=x2xt+x3xt+x2x3--x3x2xt
det1=x3xt+x3x1+x1xt--x1x3xt
detSum=det1+det2+det3
        if detSum<0 then
        --Point is outside of triAngle
        return true
        end

                if detSum >= 0 then
                --Point is inside of triAngle
                return false
                end

end

--> checks wether a value with teshold is within range of a second value
function withinRange(value1,value2, treShold)
if value1*treShold > value2 or value1*(1-treShold) <treShold then
return true
	else
	return false
	end
end

function valComPair(value1,treShold)
if value1 <0 then
value1=M(value1)
end

if value1 < value1*treShold and value1 > value1*(1-treShold) then
return true
	else
	return false
	end
end
--> Checks wether a Point is within a six sided polygon
function sixPointInsideDetAlgo (x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,xPoint,yPoint)
boolInside=true
detSum=0
	for i=0, 6, 1 do
	tempdet=0.5*((x((i+1)%7))* (y((i+2)%7))+(x((i+2)%7))*(y((i+1)%7)))
	detSum=detSum+tempdet
	end

	if detSum>=0 then 
	boolInside=false
	end

return boolInside
end
-->Gets the Height of a Unit
function getUnitHeight(UnitId)
_,y,_=Spring.GetUnitPosition(unitID)
return y
end

-->multiplies a 3x1 Vector with a 3x3 Matrice
function vec3MulMatrice3x3(vec,Matrice)
return {x=Matrice[1][1]*vec.x+Matrice[1][2]*vec.y,Matrice[1][3]*vec.z,
		y=Matrice[2][1]*vec.x+Matrice[2][2]*vec.y,Matrice[2][3]*vec.z,
		z=Matrice[3][1]*vec.x+Matrice[3][2]*vec.y,Matrice[3][3]*vec.z,
		}
end
--RawMatrice
-- {
-- [1]={[1]=,[2]=,[3]=,},
-- [2]={[1]=,[2]=,[3]=,},
-- [3]={[1]=,[2]=,[3]=,}
-- }
function YRotationMatrice(Deg)
return {
		[1]={[1]=math.cos(Deg),		[2]=0,		[3]=math.sin(Deg)*-1,},
		[2]={[1]=0,					[2]=1,		[3]=0},
		[3]={[1]=math.sin(Deg),		[2]=0,		[3]=math.cos(Deg),	}
		}
end

function XRotationMatrice(Deg)
return {
							[1]={[1]=1,				[2]=0,				[3]=0				},
							[2]={[1]=0,				[2]=math.cos(Deg),	[3]=math.sin(Deg)*-1},
							[3]={[1]=0,				[2]=math.sin(Deg),	[3]=math.cos(Deg)	}
							}
end
function ZRotationMatrice(Deg)
return {
							[1]={[1]=math.cos(Deg),	[2]=math.sin(Deg)*-1,	[3]=0,},
							[2]={[1]=math.sin(Deg),	[2]=math.cos(Deg),		[3]=0,},
							[3]={[1]=0,				[2]=0,					[3]=1,}
							}
end

function rotateVecDegX(vec, DegX)
	tempDegRotY=math.asin(vec.x/(math.sqrt(vec.x^2+vec.z^2)))
	
	-- y-axis
	vec=vec3MulMatrice3x3(vec,YRotationMatrice(tempDegRotY*-1))
	
	tempDegRotZ=math.asin(vec.y/math.sqrt(vec.x^2 +vec.z^2))
	--z-axis
	vec=vec3MulMatrice3x3(vec,YRotationMatrice(tempDegRotZ*-1))
	--actual Rotation around the x-axis
	vec=vec3MulMatrice3x3(vec,XRotationMatrice(DegX))
	
	--undo z-axis
	vec=vec3MulMatrice3x3(vec,YRotationMatrice(tempDegRotZ))
	
	-- undo y-axis
	vec=vec3MulMatrice3x3(vec,YRotationMatrice(tempDegRotY))
	return vec	
end
	
	

-->gets the original Mapheight
function getHistoricHeight(UnitId)
tempX,tempY,tempZ=Spring.GetUnitPosition(UnitId)
tempY=Spring.GetGroundOrigHeight(tempX,tempZ)
return tempY
end
--> returns true if point is within range -returns false if it is on the outside
local previousResult
local previousCubic
local rangeOfOld = -1


--> faster way of finding out wether a point is within a circle
function isWithinCircle(circleRange,xCoord,zCoord)
newCubic=0
	if rangeOfOld == circleRange then
	newCubic=previousCubic
	else
	newCubic= 0.7071067811865475*circleRange
	previousCubic=newCubic
	end

negCircleRange=-1*circleRange

	--checking the most comon cases   |Coords Outside the Circlebox
			if xCoord > circleRange or xCoord < negCircleRange then
			return false
			end

					if zCoord >circleRange or zCoord <negCircleRange then
					return false
					end

negNewCubic=-1* newCubic


							--checking everything within the circle box
							if (xCoord < newCubic and xCoord > negNewCubic) and (zCoord < newCubic and zCoord > negNewCubic) then
							return true
							end


-- very few cases make it here.. to the classic, bad old range compare
if math.sqrt(xCoord^2 +zCoord^2) < circleRange then 
return true 
else 
return false
end

end


--conditonal default :executes the most often used option
conditionFullFilled={}
--this Table contains the functions of the condtion.. each either returning a true (executed correct), a false (conditions not fullfilled), or a nil (reached, but not executed correct)

---------------------------------------
--initialising the number of cases
intNrOfCases=2
intCases={}
for i=1,intNrOfCases,1 do
intCases[i]={}
intCases[i][1]=0
intCases[i][2]=false
intCases[i][3]=false
end
-----------------------------------------
-->Turns a piece in the speed necessary to arrive after x Milliseconds
function turn(piecename,axis,degree,timeInMs,boolWait)
timeInMs=timeInMs/1000
Speed=Degree/timeInMs
if degree < 180 or degree < -180 then
Turn(piecename,axis,math.rad(degree),Speed)
if boolWait==true then WaitForTurn(piecename,axis) end
	else
	deg=degree%180
	m=1
	if degree < 0 then m=-1 end
	Turn(piecename,axis,math.rad(179*m),Speed)
	if boolWait==true then WaitForTurn(piecename,axis) end
	Turn(piecename,axis,math.rad(degree),Speed)
	if boolWait==true then WaitForTurn(piecename,axis) end
	end
end
--[[ 
function heuristicDefault()
--reset Booleans -- can get quite a overhead
for i=1,table.getn(intCases),1 do
intCases[i][2]=false
end
-----------------------------------------
--the cases
if condition1()==true then
intCases[1][2]=conditionFullFilled[1] 
intCases[1][1]=intCases[1][1] +1 
end




--heuristic Default 
--Spring.Echo("Heuristic Default Reached")
temp=false
intTemp=-1
selectedCase=nil
for i=1,table.getn(intCases),1 do
	if temp== true or intCases[i][2]== nil then
	temp=true
	end
		if intCases[i][1] >= intTemp then
		intTemp=intCases[i][1]
		selectedCase=i
		end
	
			if intCases[i][2]== nil then
			--Spring.Echo("Condition i was fullfilled, but the Case didnt execute correct")
			end
end

if temp==true then
conditionFullFilled[selectedCase]
end

	

end ]]
-->generates a Pieces List 
function generatepiecesTableAndArrayCode(unitID)
Spring.Echo("--PIECESLIST::BEGIN  |>----------------------------")
Spring.Echo("--PIECES")
Spring.Echo("piecesTable={}")
piecesTable={}
piecesTable=Spring.GetUnitPieceList(unitID)
--Spring.Echo("local piecesTable={}")
	if piecesTable ~= nil then
		for i=1,#piecesTable,1 do
		workingString=""
		workingString=workingString..piecesTable[i]
		drawATempCopy=workingString
		workingString=workingString.." = piece\""
		workingString=workingString..piecesTable[i]
		workingString=workingString.."\""
		Spring.Echo(workingString)
		Spring.Echo("piecesTable[#piecesTable+1]= "..drawATempCopy)

		end


	end

Spring.Echo("PIECESLIST::END   |>-----------------------------")
end

--> Transfers a World Position into Unit Space
function worldPosToLocPos(owpX,owpY,owpZ,wpX,wpY,wpZ)
return wpX-owpX,wpY-owpY ,wpZ-owpZ
end

--> Flashes a Piece for debug purposes
function flashPiece(pname,time,rate)
r=rate
t=time or 1000
if not rate then r=50 end

	for i=0,time,2*r do
	Sleep(r)
	Show(pname)
	Sleep(r)
	Hide(pname)
	end


end
--> Hides a PiecesTable, 
function hideT(tablename,lowLimit,upLimit,delay)
if lowLimit and upLimit then
	for i=upLimit,lowLimit, -1 do
	Hide(tablename[i])
	if delay then Sleep(delay) end
	end

else
	for i=1,table.getn(tablename), 1 do
	Hide(tablename[i])
	end
end
end

-->Shows a Pieces Table
function showT(tablename,lowLimit,upLimit,delay)
	if lowLimit and upLimit then
		for i=lowLimit,upLimit, 1 do
		Show(tablename[i])
		if delay then Sleep(delay) end
		end

	else
		for i=1,table.getn(tablename), 1 do
		Show(tablename[i])
		end
	end
end



--> This function process result of Spring.PathRequest() to say whether target is reachable or not
function IsTargetReachable (moveID, ox,oy,oz,tx,ty,tz,radius)
        local result,lastcoordinate, waypoints
        local path = Spring.RequestPath( moveID,ox,oy,oz,tx,ty,tz, radius)
        if path then
                local waypoint = path:GetPathWayPoints() --get crude waypoint (low chance to hit a 10x10 box). NOTE; if waypoint don't hit the 'dot' is make reachable build queue look like really far away to the GetWorkFor() function.
                local finalCoord = waypoint[#waypoint]
                if finalCoord then --unknown why sometimes NIL
                        local dx, dz = finalCoord[1]-tx, finalCoord[3]-tz
                        local dist = math.sqrt(dx*dx + dz*dz)
                        if dist <= radius+20 then --is within radius?
                                result = true
                                lastcoordinate = finalCoord
                                waypoints = waypoint
                        else
                                result = false
                                lastcoordinate = finalCoord
                                waypoints = waypoint
                        end
                end
        else
                result = true
                lastcoordinate = nil
                waypoints = nil
        end
        return result, lastcoordinate, waypoints
end


--> takes a given position and the dir of a surface and calculates the vector by which the vector is reflectd,
--if fall in angle == escape angle
function mirrorAngle(nX,nY,nZ,dirX,dirY,dirZ)
max=math.max(dirX,math.max(dirY,dirZ))
dirX,dirY,dirZ=dirX/max,dirY/max,dirZ/max
max=math.max(nX,math.max(nY,nZ))
nX,nY,nZ=nX/max,nY/max,nZ/max


a=math.atan2(nY,nZ)--alpha	x_axis
b=math.atan2(nX,nY)--beta	z_axis

ca=math.cos(a)
cma=math.cos(-1*a)
ncma=cma*-1
sa=math.sin(a)
sma=math.sin(-1*a)
nsma=sma*-1

cb=math.cos(b)
cmb=math.cos(-1*b)
ncmb=cmb*-1
sb=math.sin(b)
smb=math.sin(-1*b)
nsmb=smb*-1
-- -c(a)*c(-a)+s(a)*s(-a)																		|-c(a)-s(-a)+ s(a)*c(-a)																	|0				|0
-- c(-b)*[(c(b)*s(a)*c(-a)+c(b)*c(a)*s(-a))]+-s(-b)*[(-s(a)*s(b)*c(-a))+(-s(b)*c(a)*s(-a))]		|c(-b)*[c(b)*s(a)*-s(-a) + c(b)*c(a)*c(-a) ]+-s(-b)*[-s(a)*s(b)*-s(-a)+(-s(b)*c(a)*c(-a)]	|-s(b)*s(-b)	|0
-- s(-b)*[c(b)*s(a)*c(-a)+c(b)*c(a)*s(-a)	]+ c(-b) *[ -s(a)*s(b)*c(-a) + (-s(b)*c(a)*s(-a)]	|s(-b)*[c(b)*s(a)*-s(-a) + c(b)*c(a)*c(-a) ]+c(-b)*[-s(a)*s(b)*-s(-a)+(-s(b)*c(a)*c(-a)]	|-c(b)*c(-b)	|0
			
dirX=dirX*ncma*cma+sa*sma+dirY*ncma*-1*sma+ sa*cma		
dirY=dirX*cmb*((cb*sa*cma+cb*ca*sma))+-1*smb*((-1*sa*sb*cma)+(-1*sb*ca*sma))		+dirY*cmb*(cb*sa*-1*sma + cb*ca*cma )+ (-1*smb*-1*sa*sb*-1*sma+-1*sb*ca*cma)	+dirZ*-1*sb*smb
dirZ=dirX*smb*(cb*sa*cma+cb*ca*sma	)+ cmb *( -1*sa*sb*cma + (-1*sb*ca*sma))	+dirY*smb*(cb*sa*-1*sma + cb*ca*cma +cmb*-1*sa*sb*-1*sma+(-1*sb*ca*cma))	+dirZ* -1*cb*cmb

return dirX,dirY,dirZ
end

-->RotationMatrice for allready Normalized Values
function NDrehMatrix(x,z,rad)

	   sinus=math.sin(rad)
	   cosinus= math.cos(rad)
					
	return x*cosinus + z*sinus*-1, x*sinus  + z*cosinus
end


--forceFunctionTable Example
function hitByExplosionAtCenter(objX,objY,objZ,worldX,worldY,worldZ,objectname,mass,dirX,dirY,dirZ)
objX,objY,objZ=objX-worldX,objY-worldY,objZ-worldZ
distanceToCenter =(objX^2+objY^2+objZ^2)^0.5
blastRadius=350
Force=4000000000000 
factor=blastRadius/(2^distanceToCenter)
	if distanceToCenter > blastRadius then factor=0 end
normalIsDasNicht=math.max(math.abs(objX),math.max(math.abs(objY),math.abs(objZ)))

objX,objY,objZ=objX/normalIsDasNicht,objY/normalIsDasNicht,objZ/normalIsDasNicht
			--density of Air in kg/m^3 -- area
airdrag=0.5*1.1455*((normalIsDasNicht*factor*Force)/mass)^2*15*0.47

	if math.abs(objX) == 1 then
	return objX*factor*Force-airdrag,objY*factor*Force, objZ*factor*Force
		elseif math.abs(objY)==1 then

		return objX*factor*Force,objY*factor*Forceairdrag, objZ*factor*Force
			else

			return objX*factor*Force,objY*factor*Force, objZ*factor*Forceairdrag
			end
end
--> a Pseudo Physix Engien in Lua, very expensive, dont use extensive	--> forceHead(objX,objY,objZ,worldX,worldY,worldZ,objectname,mass)
function PseudoPhysix(piecename,pearthTablePiece, nrOfCollissions, forceFunctionTable)


					speed=math.random(1,4)
					rand=math.random(10,89)
					Turn(piecename,x_axis,math.rad(rand),speed)
					dir=math.random(-90,90)
					speed=math.random(1,3)
					Turn(piecename,y_axis,math.rad(dir),speed)

		
	--SpeedUps
	local spGPos=Spring.GetUnitPiecePosDir
	local spGGH=Spring.GetGroundHeight
	local spGN=Spring.GetGroundNormal
	local mirAng=mirrorAngle		
	local spGUPP=Spring.GetUnitPiecePosition
	local spGUP=Spring.GetUnitPosition
	local ffT=forceFunctionTable			
	posX,posY,posZ,dirX,dirY,dirZ=spGPos(unitID,pearthTablePiece)
	ForceX,ForceY,ForceZ=0,0,0
	oposX,oposY,oposZ=posX,posY,posZ
	

	mass=600
	simStep=75
	gravity=-1*(Game.gravity) -- in Elmo/s^2  --> Erdbeschleunigung 
	
	--tV=-1* 
	terminalVelocity=-1*(math.abs((2*mass*gravity))^0.5	)
	ForceGravity=-1*(mass*Game.gravity) --    kgE/ms^2
	
	GH=spGGH(posX,posZ)		--GroundHeight
	if oposY < GH then oposY=GH end
	
	

	VelocityX,VelocityY,VelocityZ=0,0,0
	factor =(1/1000)*simStep
	
	
	boolRestless=true
	
		while boolRestless==true  do
		
		-- reset
		ForceX,ForceY,ForceZ=0,0,0
		
		-- update
		posX,posY,posZ,dirX,dirY,dirZ=spGPos(unitID,pearthTablePiece)	
		_,_,_,dirX,dirY,dirZ=spGPos(unitID,piecename)	
		
		--normalizing
		normalizer=math.max(math.max(dirX,dirY),dirZ)
		if normalizer == nil or normalizer== 0 then normalizer=0.001 end
		dirX,dirY,dirZ=dirX/normalizer,dirY/normalizer,dirZ/normalizer
		
		-- applying gravity and forces 
		ForceY=ForceGravity
		
		if ffT ~= nil then --> forceHead(objX,objY,objZ,oDirX,oDirY,oDirZ,objectname,dx,dy,dz)
		bx,by,bz=Spring.spGUP(unitID)
		dx,dy,dz=spGUPP(unitID,piecename)
		dmax=math.sqrt(dx^2+dy^2+dz^2)
		dx,dy,dz=dx/dmax,dy/dmax,dz/dmax
		
		for i=1, #ffT, 1 do	
		f2AddX,f2AddY,f2AddZ=ffT[i](posX,posY,posZ,bx,by,bz,piecename,mass,dx,dy,dz)
		ForceX=ForceX+f2AddX
		ForceY=ForceY+f2AddY
		ForceZ=ForceZ+f2AddZ
		end
		
		
		end

		GH=spGGH(posX+VelocityX+(ForceX/mass)*factor,	posZ+VelocityZ+(ForceZ/mass)*factor)
		boolCollide=false
		
		
		--GROUNDcollission
	
		if  (posY  -GH-15) < 0 then
		boolCollide=true
		nrOfCollissions=nrOfCollissions-1
			
			
				total=math.abs(VelocityX)+math.abs(VelocityY)+math.abs(VelocityZ)
				--get Ground Normals
				
				nX,nY,nZ=spGN(posX,posZ)
				max=math.max(nX,math.max(nY,nZ))
				_,tnY,_=nX/max,nY/max,nZ/max
				
				--if still enough enough Force or stored kinetic energy
				if total > 145.5  or nrOfCollissions > 0 or tnY < 0.5 then
				else
					--PhysixEndCase
					boolRestless=false
				end
				
			
				VelocityX,VelocityY,VelocityZ=0,0,0
				

				--could do the whole torque, but this prototype has fullfilled its purpose
			--	up=math.max(math.max((total/mass)%5,4),1)+1
				
				dirX,dirY,dirZ=mirAng(nX,nY,nZ,dirX,dirY,dirZ)
				speed=math.random(0.55,7)
				Turn(piecename,x_axis,dirX,speed)
				speed=math.random(0.55,6)
				Turn(piecename,y_axis,dirY,speed)
				speed=math.random(0.55,5)
				Turn(piecename,z_axis,dirZ,speed)
			
				
				
				--we have the original force * constant inverted - Gravity and Ground channcel each other out
				RepulsionForceTotal=((math.abs(ForceY)+math.abs(ForceZ)+math.abs(ForceX))*-0.65)
				ForceY=ForceY+((dirY*RepulsionForceTotal))					
				
				ForceX=ForceX+((dirX*RepulsionForceTotal))
				ForceZ=ForceZ+((dirZ*RepulsionForceTotal))
				VelocityY=math.max(VelocityY+((ForceY/mass)*factor),terminalVelocity*factor)
				
		else
		
		--FreeFall		
		
		VelocityY=math.max(VelocityY+((ForceY/mass)*factor),terminalVelocity*factor)
		end
		

		
		VelocityX=math.abs(VelocityX+(ForceX/mass)*factor)
		VelocityZ=math.abs(VelocityZ+(ForceZ/mass)*factor)
		
		--Extract the Direction from the Force
		xSig=ForceX/math.max(math.abs(ForceX),0.000001)
		ySig=ForceY/math.max(math.abs(ForceY),0.000001)
		zSig=ForceZ/math.max(math.abs(ForceZ),0.000001)
		
			-- FuturePositions
			fX,fY,fZ=worldPosToLocPos(oposX,oposY,oposZ,posX+math.abs(VelocityX)*xSig, posY + math.abs(VelocityY)*ySig  ,posZ+math.abs(VelocityZ)*zSig)
		
		if  boolCollide== true or boolRestless== false or (fY -GH -12 < 0) then fY= -1*oposY+GH end
			--Debugdatadrop

		--	Spring.Echo("ySig",ySig.."	Physix::ComendBonker::fY",fY.."VelocityY::",VelocityY .."    	ForceY::",ForceY .."    	POSVAL:", posY + VelocityY*ySig)

			Move(pearthTablePiece,x_axis,fX,VelocityX*1000/simStep+0.000000001)
			Move(pearthTablePiece,y_axis,fY,VelocityY*1000/simStep)
			Move(pearthTablePiece,z_axis,fZ,VelocityZ*1000/simStep+0.000000001)
			
		
		
		Sleep(simStep)
		end
	

	
end

function createMass(mass,px,py,pz,vx,vy,vz,fx,fy,fz)
mass={m=mass,pos={x=px,y=py,z=pz},vel={x=vx,y=vy,z=vz},force={x=fx,y=fy,z=fz}}
return mass
end

function debugDisplayPieceChain(Tables)
	for i=1, #Tables, 1 do
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(Tables[i])
	Spring.SpawnCEG("redlight",x,y+10,z,0,1,0,50,0)
	end

end

function iniT(size,val)
T={}
	for i=1,size do
	T[i]=val
	end
return T
end

function vectorMinus(v1,v2)
return{x=v1.x-v2.x,y=v1.y-v2.y,z=v1.z-v2.z}
end

local countConstAnt=0
function vMul(v1,value)
countConstAnt=countConstAnt+1
--if not value or type(value)~='number' and #value == 0  then Spring.Echo("JW::RopePhysix::"..countConstAnt)end 

	if value and  type(value)=='number' then --Skalar
	return {x = v1.x*value,
			y=v1.y*value,
			z=v1.z*value}
		else		--return vector
		Spring.Echo("JW:ToolKit:Vmul"..countConstAnt)
		return {x = v1.x*value.x,y=	v1.y*value.y, z=	v1.z*value.z}
		end
end

function vectorLenght(v1,v2)
v=vectorMinus(v1,v2)
return math.sqrt(v.x*v.x +v.y*v.y +v.z*v.z)
end

function vDiv(v1, val)
if not val.x then
return {x=v1.x/val,y=v1.y/val,z=v1.z/val}
else
return {x=v1.x/val.x,y=v1.y/val.y,z=v1.z/val.y}
end
end

function vAddV(v1,val)
return {x= v1.x+val.x, y= v1.y+val.y,z=v1.z+val.z}
end

function vSubV(v1,v2)
return {x=v1.x-v2.x,y=v1.y-v2.y,z=v1.z-v2.z}
end

function applyForce(force,force2)
return vAddV(force,force2)
end

function normalizeVector(v)
l=math.sqrt(v.x*v.x +v.y*v.y +v.z*v.z)
return {x=v.x/l ,y=v.y/l,z=v.z/l}
end

function solveSpring(s, sucessor, frictionConstant)
  springVector =vectorMinus(s.mass1.pos,sucessor.mass1.pos)      -- Vector Between The Two Masses
         
         r = vectorLenght(springVector)                -- Distance Between The Two Masses
 
        force={x=0,y=0,z=0}                         -- Force Initially Has A Zero Value
         
        if r ~= 0 then                         -- To Avoid A Division By Zero... Check If r Is Zero  
            force = vAddV(vMul(vMul(vDiv(springVector, r),-1),((r - s.length) * s.springConstant)),force)
		end
		    force = vAddV(force, vMul(vSubV(s.mass1.vel, sucessor.mass1.vel),-1*frictionConstant))     -- The Friction Force Is Added To The force
                                    -- With This Addition We Obtain The Net Force Of The Spring
	s.mass1=vAddV(s.mass1,force)			-- Force Is Applied To mass1
	sucessor.mass1=vAddV(sucessor.mass1,vMul(force,-1))	-- The Opposite Of Force Is Applied To mass2	
return s,sucessor	
end

function rEchoTable(T,layer)
l=layer or 0

if type(T)=='table' then
Spring.Echo("============================= RTable ======================================")
for i=1,#T,1 do
rEchoTable(T[i],l+1)
end
Spring.Echo("============================= RTable ======================================")
else
	Concated=""
	for i=1,l, 1 do
	Concated=Concated.."	"
	end
Spring.Echo(Concated..T)
end

end

function echoTable(T,boolAssertTable)
lboolAssertTable=boolAssertTable or false

if T.name then 
Spring.Echo("============================= "..T.name.." ======================================")
else
Spring.Echo("============================= EchoTable =========================================")
end
for k,v in pairs(T) do
typek=type(k)
typev=type(v)
typek=typek~="table" and typek ~="function"
typev=typev~="table" and typev ~="function"
	if typek and typev then
	Spring.Echo("  "..k.."  	--->  	"..v .."   ->  	[ "..(assert(v)).." ]  ")
	end
end

if lboolAssertTable ==true then
	for k,v in pairs(T) do
	assert(v)
	end
end


Spring.Echo("================================================================================")

end


function checkYourself()
return GG.SniperRope[unitID] or false
end

function Limit(val,min,max)
if val < min then return min end
if val > max then return max end
return val 
end

-- This code is a adapted Version of the NeHe-Rope Tutorial. All Respect towards those guys.
-- RopePieceTable by Convention contains (SegmentBegin)----(SegmentEnd)(SegmentBegin)----(SegmentEnd) 
-- RopeConnectionPiece -->Piece,ContainsMass,ColRadius |
-- LoadPiece --> Piece,Contains Mass, ColRadius | 
-- ForceFunction --> forceHead(objX,objY,objZ,worldX,worldY,worldZ,objectname,mass)

										 
function PseudoRopePhysix(RopePieceTable,RopeConnectionT,LoadPieceT, Ropelength, forceFunctionTable,SpringConstant,boolDebug)
	
	--SpeedUps
assert(RopePieceTable 		,"RopePieceTable not provided")			
assert(RopeConnectionT 		,"RopeConnectionT not provided")			
assert(LoadPieceT 			,"LoadPieceT not provided")			
assert(Ropelength 			,"Ropelength not provided")			
assert(forceFunctionTable 	,"forceFunctionTable not provided")			
assert(SpringConstant 		,"SpringConstant not provided")					

	local spGPos=Spring.GetUnitPiecePosDir
	local spGGH=Spring.GetGroundHeight
	local spGN=Spring.GetGroundNormal	
	local spGUPP=Spring.GetUnitPiecePosition
	local spGUP=Spring.GetUnitPosition
	local ffT=forceFunctionTable			
	local    groundHeight  = function(piece) 
					x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,piece)
					return Spring.GetGroundHeight(x,z) end     
					-- Each Particle Has A Weight Of 50 Grams


	--SIMCONSTANTS   -tweak them
local	SpringConstant=SpringConstant or 100000.0 

local    SpringInnerFriction= 0.2
local 	 RopeMass					= 0.1
local 	 groundRepulsionConstant 	= 100                     -- A Constant To Represent How Much The Ground Shall Repel The Masses
local    groundFrictionConstant 	= 0.35                     -- A Constant Of Friction Applied To Masses By The Ground
local    groundAbsorptionConstant	= 3               -- A Constant Of Absorption Friction Applied To Masses By The Ground
local    airFrictionConstant  		= 0.5                        

	--INIT

ForcesTable={}

rcx,rcy,rcz=Spring.GetUnitPiecePosDir(unitID,RopeConnectionT.Piece)
RopeConnection={
		  Pos={x=rcx,y=rcy,z=rcz},
		  vel={x=0,y=0,z=0},
		  mass=1500, --unrealistic, yet you cant reach escape velocity 
		  Radius=RopeConnectionT.ColRadius
		  }
		  
local ObjT={}
	--contains the startpos, as the sensory piece
	for i=1,#RopePieceTable, 1 do
	px,py,pz,pdx,pdy,pdz=Spring.GetUnitPiecePosDir(unitID,RopePieceTable[i])
		
	ObjT[#ObjT+1]={ 
				piecename=RopePieceTable[i],
				posdir={x,y,z,xd,yd,zd=px,py,pz,pdx,pdy,pdz},
				mass1={mass= createMass(RopeMass/2,px,py,pz,0,0,0,0,0,0)},
				vel={x=0,y=0,z=0},
				PrevPiece=(math.max(1,i-1)),
				NextPiece=math.min(i+1,#RopePieceTable),
				length=Ropelength,
				springConstant=SpringConstant
	}
	end
	--The pulled Object
	px,py,pz,pdx,pdy,pdz=Spring.GetUnitPiecePosDir(unitID,LoadPieceT.Piece)
	ObjT[#ObjT+1]={ 
				piecename=LoadPieceT.Piece,
				posdir={x,y,z,xd,yd,zd=px,py,pz,pdx,pdy,pdz},
				mass1={mass= createMass(LoadPieceT.Mass,px,py,pz,0,0,0,0,0,0)},
				vel={x=0,y=0,z=0},
				PrevPiece=(#ObjT),
				length=Ropelength,
				springConstant=SpringConstant
	}
	--/INIT
	
	
	local simStep=75

	
	
	while checkYourself()  do
			--init and reset
			for i=1,#ObjT,1 do
			ObjT[i].mass1.force={x=0,y=0,z=0}
			end

		--applyForces
		
		for j=1,#ffT,1 do 
		if ffT.pieceList then
			for k in ipairs(fft.piecelist) do
				if not ffT[j].geometryfunction or ffT[j].geometryfunction(ObjT[k].posdir.x,ObjT[k].posdir.y,ObjT[k].posdir.z) == true then
				ObjT[k].mass1.force=vAddV(ObjT[k].mass1.force, vMul(ffT[j].acceleration,ObjT[k].mass1.mass))		  
				end
			end
		else
			for i=1,#ObjT, 1 do
			ObjT[i].mass1.force=vAddV(ObjT[i].mass1.force, vMul(ffT[j].acceleration,ObjT[i].mass1.mass))		
			end
		end
		end	
		
		--Lets SpringSimulation
		for i=1,#ObjT, 2 do
		ObjT[i],ObjT[Limit(i+1,1,#ObjT)] =solveSpring(ObjT[i],ObjT[Limit(i+1,1,#ObjT)],SpringInnerFriction)	
		end		
		
		
	  --solve Objforces
	for i=1,#ObjT, 2 do              -- Start A Loop To Apply Forces Which Are Common For All Masses
		local Succesor=Limit(i,1,ObjT)
		
		ObjT[i].mass1.force=vAddV(ObjT[i].mass1.force,vMul(gravitation,ObjT[i].mass1.mass))
	
		--    masses[a]->applyForce(gravitation * masses[a]->m);    -- The Gravitational Force
        -- The air friction
		ObjT[i].mass1.force=vAddV(ObjT[i].mass1.force, vMul(ObjT[i].vel, airFrictionConstant*-1))
		
    --    masses[a]->applyForce(-masses[a]->vel * airFrictionConstant);
 
 
		if 	ObjT[i].mass1.pos.y > groundHeight(ObjT[i].piecename)  then
            -- Forces From The Ground Are Applied If A Mass Collides With The Ground
        
             v1={x=0,y=0,z=0}                 -- A Temporary Vector3D
             v2={x=0,y=0,z=0}                 -- A Temporary Vector3D
			
			v1=ObjT[i].mass1.vel
            v2 = ObjT[Succesor].mass2.vel              -- Get The Velocity
			
			v1.y=0
			v2.y=0
                             -- Omit The Velocity Component In Y-Direction
 
            -- The Velocity In Y-Direction Is Omited Because We Will Apply A Friction Force To Create
            -- A Sliding Effect. Sliding Is Parallel To The Ground. Velocity In Y-Direction Will Be Used
            -- In The Absorption Effect.
 
            -- Ground Friction Force Is Applied   
			ObjT[i].mass1.force=vAddV(ObjT[i].mass1.force,vMul(vMul(v1,-1),groundFrictionConstant))
			ObjT[Succesor].mass1.force=vAddV(ObjT[Succesor].mass1.force,vMul(vMul(v2,-1),groundFrictionConstant))			
         
 
            v1 =ObjT[i].mass1.vel              -- Get The Velocity
            v2 =ObjT[Succesor].mass1.vel              -- Get The Velocity
			
			v1.x,v1.z=0,0
			v2.x,v2.z=0,0
   
            -- Above, We Obtained A Velocity Which Is Vertical To The Ground And It Will Be Used In
            -- The Absorption Force
 
            if (v1.y < 0) then              
            	ObjT[i].mass1.force=vAddV(ObjT[i].mass1.force, vMul(vMul(vMul(v1,-1),groundAbsorptionConstant)))  
			end
			
			if ( v2.y < 0) then
			 	ObjT[Succesor].mass1.force=vAddV(ObjT[Succesor].mass1.force, vMul(vMul(vMul(v2,-1),groundAbsorptionConstant)))
			end
            
			x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,ObjT[i].piecename)
			vx,vy,vz=Spring.GetGroundNormal(x,z)
			else
				-- The Ground Shall Repel A Mass Like A Spring.
				-- By "Vector3D(0, groundRepulsionConstant, 0)" We Create A Vector In The Plane Normal Direction
				-- With A Magnitude Of groundRepulsionConstant.
				-- By (groundHeight - masses[a]->pos.y) We Repel A Mass As Much As It Crashes Into The Ground.
				gh=groundHeight(	ObjT[i].piecename)
				f1=vMul(vMul({x=vx,y=vy,z=vz},groundRepulsionConstant),gh-ObjT[i].mass1.pos.y)
				f2=vMul(vMul({x=vx,y=vy,z=vz},groundRepulsionConstant),gh-ObjT[Succesor].mass1.pos.y)
				
				ObjT[Succesor].mass1.force=vAddV(ObjT[Succesor].mass1.force,f2)		
				ObjT[i].mass1.force=vAddV(ObjT[i].mass1.force,f1)		      -- The Ground Repulsion Force Is Applied
			end
	end	   
		  --simulate 
			for i=1, #ObjT, 1 do
			--vel += (force/mass)* dt
			ObjT[i].mass1.vel= vAddV(ObjT[i].mass1.vel,vMul( vDiv(ObjT[i].mass1.force,ObjT[i].mass1.m),timeInMS))
			ObjT[Succesor].mass1.vel= vAddV(ObjT[Succesor].mass1.vel,vMul( vDiv(ObjT[Succesor].mass1.force,ObjT[Succesor].mass1.m),timeInMS))
			ObjT[i].mass1.pos=vAddV(ObjT[i].mass1.pos, vSub(ObjT[i].mass1.vel,timeInMS))
			ObjT[Succesor].mass1.pos=vAddV(ObjT[Succesor].mass1.pos, vSub(ObjT[Succesor].mass1.vel,timeInMS))
			end
		--TranslatePieces to new Positions
		
		Sleep(simStep)
		if boolDebug then
		debugDisplayPieceChain(RopePieceTable)
		end
	end
	

	

end

--add Operators to unitscript

function eraNonArgMul(A,B)
if A== "0" or B=="0" or A== "" or B=="" then return "" 
else return "("..A.."*"..B..")" end
end

function eraNonArgAdd(A,B)
if A== "0"  or A== "" and B ~= "0" and B ~="" then return B end
if B== "0"  or B== "" and A ~= "0" and A ~="" then return A end
return A.."+"..B

end
--> used to calc shadder matrixes in lua.. fill in, calc, optimize, print out
function matrixLab()
mA={
[1]="cos(z)",	[2]="-sin(z)",	[3]="0",
[4]="sin(z)",	[5]="cos(z)",	[6]="0",
[7]="0",	[8]="0",	[9]="1",	
	}
mB={
[1]="-1",	[2]="0",		[3]="0",
[4]="0",	[5]="cos(x)",	[6]="-sin(x)",
[7]="0",	[8]="sin(x)",	[9]="cos(x)",	
}
mC={
[1]="cos(y)",	[2]="0",	[3]="sin(y)",
[4]="0",		[5]="1",	[6]="0",
[7]="-sin(y)",	[8]="0",	[9]="cos(y)",	
	}


	mD=MatrixBuilder3x3(MatrixBuilder3x3(mA,mB),mC)
	echoTable(mD)


end

function mirrorMatriceXAxis(x,y,z)
return 360-x,y,z*-1																																																																																																																																																																																																																																																																																	

--x=	((-1*math.cos(z))*math.cos(y))+((-1*math.sin(z)*-1*math.sin(x))*-1*math.sin(y)) 	*x + 	((-1*math.sin(z)*math.cos(x)) )		*y+   	((-1*math.cos(z))*math.sin(y))+((-1*math.sin(z)*-1*math.sin(x))*math.cos(y))   *z
--y= 	((-1*math.sin(z))*math.cos(y))+((math.cos(z)*-1*math.sin(x))*-1*math.sin(y))   *x +	     ((math.cos(z)*math.cos(x)) )	*y+   ((-1*math.sin(z))*math.sin(y))+((math.cos(z)*-1*math.sin(x))*math.cos(y))   *z
--z=	((math.cos(x))*-1*math.sin(y)) 								*x + ((math.sin(x)) )   			*y+    	((*math.cos(x))*math.cos(y))  *z
--return x,y,z
end

function MatrixBuilder3x3(A, B)
return {
[1]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[1],B[1]),eraNonArgMul(A[2],B[4])),eraNonArgMul(A[3],B[7])),
[2]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[1],B[2]),eraNonArgMul(A[2],B[5])),eraNonArgMul(A[3],B[8])),
[3]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[1],B[3]),eraNonArgMul(A[2],B[6])),eraNonArgMul(A[3],B[9])),
[4]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[4],B[1]),eraNonArgMul(A[5],B[4])),eraNonArgMul(A[6],B[7])),
[5]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[4],B[2]),eraNonArgMul(A[5],B[5])),eraNonArgMul(A[6],B[8])),
[6]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[4],B[3]),eraNonArgMul(A[5],B[6])),eraNonArgMul(A[6],B[9])),
[7]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[7],B[1]),eraNonArgMul(A[8],B[4])),eraNonArgMul(A[9],B[7])),
[8]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[7],B[2]),eraNonArgMul(A[8],B[5])),eraNonArgMul(A[9],B[8])),
[9]=eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[7],B[3]),eraNonArgMul(A[8],B[6])),eraNonArgMul(A[9],B[9])),
}
end

--> Move all Elements of a Table to Zero
function zeroT(t)
for i=1, #t, 1 do
Move(t[i],y_axis,0,0)
Move(t[i],z_axis,0,0)
Move(t[i],z_axis,0,0)
end
end

--> Turn a Table towards local T
function turnTable(t, axis, deg,speed,boolInstantUpdate)
	if boolInstantUpdate then
		for i=1,#t,1 do
		Turn(t[i],axis,math.rad(deg),0,true)
		end
		return
	end

	if not speed or speed==0 then
		for i=1,#t,1 do
		Turn(t[i],axis,math.rad(deg),0)
		end
	else
		for i=1,#t,1 do
		Turn(t[i],axis,math.rad(deg),speed)
		end
	end
return
end

--> Play a soundfile only by unittype
function PlaySoundByUnitType(unitdef, soundfile,loudness, time, nrOfUnitsParallel)
loud=loudness or 1
if loud==0 then loud= 1 end

if GG.UnitDefSoundLock == nil then  GG.UnitDefSoundLock={} end
if GG.UnitDefSoundLock[unitdef] == nil then  GG.UnitDefSoundLock[unitdef]=0 end

	if  GG.UnitDefSoundLock[unitdef] < nrOfUnitsParallel then
	GG.UnitDefSoundLock[unitdef]=GG.UnitDefSoundLock[unitdef]+1
	Spring.PlaySoundFile(soundfile,loud)
		if time <= 0 then time =2500 end
	Sleep(time)
	GG.UnitDefSoundLock[unitdef]=GG.UnitDefSoundLock[unitdef]-1
	return true
	end
return false
end

--This Takes any LanguageString and 'translates' it meaning it replaces stringparts  with the Sound
--Please take note that this should not completely replace any selfspoken sound - its a addition
--SoundPerson is a Function that allows to convay additional params into the sound-
--e.g. Out of Breath, Angry, tired, sad, by changing loudness and choosen soundsnippet
--its call signature is SoundPerson(translatedSoundSnippet, position in sentence, translatedTable)
function speakItalian(LanguageTable, SoundTable, Text, ScreenPos, StandardLoud, LoudRange, SoundPerson)
--make a text subtitles
gl.Text(Text, ScreenPos.x,ScreenPos.y, ScreenPos.z, 12)

--translate the Text via the language Table
local lplaySoundFile=Spring.PlaySoundFile
local translatedTable={}
local lSoundPerson=SoundPerson or nil

	for i = 1, #Text do
	   c = str:sub(i,i)
	   translatedTable[i]=LanguageTable[c] or " "
	end
	
	if lSoundPerson then
		for it=1,#translatedTable  do
		choosenSound,loudness=lSoundPerson(translatedTable[it],it,translatedTable)
			if SoundTable[choosenSound] then
			lplaySoundFile(SoundTable[choosenSound], loudness)
			end
		end
	else
	lplaySoundFile(SoundTable[choosenSound], StandardLoud+math.random(LoudRange*0.1,LoudRange))
	end
end

function getLowestPointOfSet(Table,axis)
index=1
y=math.huge
if axis=="y_axis" then
	for i=1,#Table do
			if Table[i].y < y then 
			y=Table[i].y
			index=i
			end
		
	end
end
if axis=="z_axis" then
	for i=1,#Table do
			if Table[i].z < y then 
			y=Table[i].z
			index=i
			end
		
	end
end
if axis=="x_axis" then
	for i=1,#Table do
			if Table[i].x < y then 
			y=Table[i].x
			index=i
			end
		
	end
end

			
return Table[index].x,Table[index].y,Table[index].z,index

end

function getHighestPointOfSet(Table,axis)
index=1
y=math.huge*-1
if axis=="y_axis" then
	for i=1,#Table do
			if Table[i].y > y then 
			y=Table[i].y
			index=i
			end
		
	end
end
if axis=="z_axis" then
	for i=1,#Table do
			if Table[i].z > y then 
			y=Table[i].z
			index=i
			end
		
	end
end
if axis=="x_axis" then
	for i=1,#Table do
			if Table[i].x > y then 
			y=Table[i].x
			index=i
			end
		
	end
end

			
return Table[index].x,Table[index].y,Table[index].z,index
end

function piec2Point(piecesTable)
	if #piecesTable > 7 then
	local spGetUnitPiecePos=Spring.GetUnitPiecePosDir
	reTab={}
		for i=1,#piecesTable do
		reTab[i]={}
		reTab[i].x,reTab[i].y,reTab[i].z=spGetUnitPiecePos(unitID,piecesTable[i])
		reTab[i].index=i
		end

	return reTab
		else
		reTab={}
			for i=1,#piecesTable do
			reTab[i]={}
			reTab[i].x,reTab[i].y,reTab[i].z=Spring.GetUnitPiecePosDir(unitID,piecesTable[i])
			reTab[i].index=i
			end

		return reTab
		end
end

--> Turns a Pieces table according to a function provided
function waveATable(Table, axis, func, signum, speed,funcscale,totalscale, boolContra,offset)
boolCounter=boolContra or false
offset=offset or 0
scalar= signum* (totalscale)
nr=#Table
pscale=funcscale/nr
total=0

	for i=1,nr do
	val=scalar*func(offset+i*pscale)
		if boolCounter == true then
		Turn(Table[i],axis,math.rad(total+val),speed)
		total=total+val
		else
		Turn(Table[i],axis,math.rad(val),speed)
		end
	end


end

--> spawn a ceg on the map above ground
function markPosOnMap(x,y,z, colourname)


h=Spring.GetGroundHeight(x,z)
if h > y then y=h end
	for i=1,5 do
	Spring.SpawnCEG(colourname,x,y+10,z,0,1,0,50,0)
	Sleep(200)
	end
end

--> Takes a Table of Locks and locks it if the lock is free 
function TestSetLock(Lock,number)
	if TestLocks(number)==true then 
	Lock[number]=true
	return true
	end 
	return false
end

-->Test a rows of locks 
function TestLocks(Lock, number)
	for i=1,table.getn(Lock) do
		if number ~=i and Lock[i]==true then return false end
	end
return true
end

--> Sets a Lock free
function ReleaseLock(Lock,number)
Lock[number]=false
end

	function filterOutTeam(TableOfUnits,teamid)
	returnTable={}
		for i=1,#TableOfUnits, 1 do
		tid=Spring.GetUnitTeam(TableOfUnits[i])
			if tid ~= teamid then returnTable[#returnTable+1]=TableOfUnits[i] end
		end
	return returnTable
	end
	
	function grabEveryone(unitID,x,z,Range,teamid)
	T={}
	if teamid then
	T=Spring.GetUnitInCylinder(x,z,Range,teamid)
	else
	T=Spring.GetUnitsInCylinder(x,z,Range)
	end
	
	if T and #T>1 then
		table.remove(T,unitID)
		end
	return T
	end 
	
	function filterTableByTable(T,T2,compareFunc)
	reTable={}
		for i=1,#T do
		if compareFunc(T[i],T2)==true then reTable[#reTable+1]=T[i] end
		end
	return reTable
	end
	
	function keyTableToTable(T,T2,Keyfunction)
	KeyTable={}
		for i=1,#T do
		KeyTable[T[i]]=Keyfunction(T[i],T2)
		end
	return reTable
	
	end
	
	function insertKeysIntoTable(T,T2)
		for i=1,#T do
			if not T2[T[i]] then
			T2[T[i]]=T[i]	
			end
		end	
	return T2
	end
	
	--itterates over a Keytable, executing a function 
	function foreach(T,fooNction)
	reTable={}
		if type(fooNction)=="string" then
		fooNction=string.load("function(k,v)\n"..fooNction.. "\n end")
		assert(type(fooNction)=="function", "string not a function in foreach(k,v) @ toolKit.lua")
		end
		
	for k,v in pairs(T) do	
		reTable[k]=fooNction(k,v)
		end
	return reTable
	end
	
	function countKey(T)
	it=0
		for k,v in pairs(T) do
		it=it+1
		end
	return it
	end
	
	--> takes a Table, and executes ArgTable/Function,Functions on it
	function process(Table,...)
	TempArg={}
	TempFunc={}
         for _, f in pairs(arg) do
				if type(f)=="function" then
				T=f(T,TempArg)
				TempArg={}
				else 
				TempArg={}
				end			   
         end
	return T
	end
	
	-->filters Out TransportUnits
    function filterOutTransport		(T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isTransport		 then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end  

 -->filters Out Immobile Units
function filterOutImmobile (T)
returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
	   if false== UnitDefs[def].isImmobile         then 
	  returnTable[#returnTable+1]=T[i]
	  end  
   end  
return returnTable  
 end
--> filters Out Buildings
 function filterOutBuilding       (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isBuilding         then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
 
--> filters Out Builders
    function filterOutBuilder        (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isBuilder          then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end

--> filters Out Mobile Builders
 function filterOutMobileBuilder  (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isMobileBuilder    then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutStaticBuilder  (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isStaticBuilder    then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutFactory        (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isFactory          then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutExtractor      (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isExtractor        then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutGroundUnit     (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isGroundUnit       then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutAirUnit        (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isAirUnit          then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutStrafingAirUnit(T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isStrafingAirUnit  then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutHoveringAirUnit(T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isHoveringAirUnit  then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutFighterAirUnit (T)
   returnTable={}  
 for i=1,#T do    
  def=Spring.GetUnitDefID(T[i])    
   if false== UnitDefs[def].isFighterAirUnit   then 
  returnTable[#returnTable+1]=T[i] end  
 end  
return returnTable  
 end
    function filterOutBomberAirUnit  (T)
   returnTable={}  
	for i=1,#T do    
	def=Spring.GetUnitDefID(T[i])    
	if false== UnitDefs[def].isBomberAirUnit    then 
	returnTable[#returnTable+1]=T[i]
	end  
	end  
return returnTable  
 end

function funcyMeta (T, ...)
         for _, f in pairs(arg) do
                 T=f(T)
         end
 return T
 end
 
 --> Apply a function on a Table
function forTableUseFunction(Table,func,metafunc)
T={}
	for i=1,#Table do
	T[i]=func(Table[i])
	end
	
return metafunc(T)
end

function getLowest(Table)
lowest=0
val=0
	for k,v in pairs(Table) do
		if v < val then 
		val=v
		lowest=k
		end
	end
end

function sumTable(Table)
a=0
	for i=1,#Table do
	a=a+Table[i]
	end
return a
end

function sumTableKV(Table)
a=0
	for k,v in pairs(Table) do
	a=a+v
	end
return a
end

--> Forms a Tree from handed over Table
--	this function needs a global Itterator and but is threadsafe, as in only one per unit
	--	it calls itself, waits for all other threads running parallel to reach the same recursion Depth
	-- 	once hitting the UpperLimit it ends
	function executeLindeMayerSystem( gramarTable,String, oldDeg, Degree , UpperLimit, recursionDepth,recursiveItterator,PredPiece)
			
			-- this keeps all recursive steps on the same level waiting for the last one - who releases the herd
			gainLock(recursiveItterator)
					
			--we made it into the next step and get our piece
			GlobalTotalItterator=GlobalTotalItterator+1
			local hit=GlobalTotalItterator
			
			if not hit or TreePiece[hit] == nil or hit > UpperLimit  then 
			releaseLocalLock(recursiveItterator)
			return 
			end
		
		
			--DebugInfo
			--Spring.Echo("Level "..recursiveItterator.." Thread waiting for Level "..(recursiveItterator-1).. " to go from ".. GlobalInCurrentStep[recursiveItterator-1].." to zero so String:"..String.." can be processed")
				
			while GlobalInCurrentStep[recursiveItterator-1] > 0  do	
			Sleep(50)
			end

	--return clauses
		if not String or String == "" or string.len(String) < 1 or recursiveItterator == recursionDepth  then 
		RecursionEnd[#RecursionEnd+1]=PredPiece
		releaseLocalLock(recursiveItterator)
		return 
		end

	ox,oy,oz=Spring.GetUnitPiecePosition(unitID, PredPiece)

	--Move Piece to Position

	Show(TreePiece[hit])

	Move(TreePiece[hit],x_axis,ox,0)
	Move(TreePiece[hit],y_axis,oy,0)
	Move(TreePiece[hit],z_axis,oz ,0,true)
	--DebugStoreInfo[#DebugStoreInfo+1]={"RecursionStep:"..hit.." ||RecursionDepth: "..recursiveItterator.." ||String"..String.." ||PredPiece: "..PredPiece.."  || Moving Piece:"..TreePiece[hit].."to x:"..ox.." y:"..oy.." z:"..oz}

	--stores non-productive operators
	OperationStorage={}
	--stores Recursions and Operators
	RecursiveStorage={}
	
		  for i = 1, string.len(String) do
		  --extracting the next token form the current string and find out what type it is
		  token = string.sub(String,i,i)
		  typeOf=type(gramarTable.transitions[token])
				
				-- if the typeof is a function and a productive Element 
				if typeOf == 'function' and gramarTable.productiveSymbols[token] then 	
					--execute every operation so far pushed back into the operationStorage on the current piece
						
						for i=#OperationStorage,1, -1 do
						gramarTable.transitions[OperationStorage[i]](oldDeg,Degree,TreePiece[hit],PredPiece,recursiveItterator,recursiveItterator==UpperLimit-1)
						end
						
						WaitForTurn(TreePiece[hit],x_axis)
						WaitForTurn(TreePiece[hit],y_axis)
						WaitForTurn(TreePiece[hit],z_axis)
					--renewOperationStorage
					OperationStorage={}
					
					--This LindeMayerSystem has a go
						StartThread(executeLindeMayerSystem,
												 
												gramarTable,
												gramarTable.transitions[token](oldDeg ,Degree ,TreePiece[hit],PredPiece,recursiveItterator,recursiveItterator==UpperLimit-1),												
												oldDeg,
												Degree,
												UpperLimit,
												recursionDepth,
												recursiveItterator+1,
												EndPiece[math.max(1,math.min(#EndPiece,hit))]
												)
						
						--if we have a non productive function we push it back into the OperationStorage
						elseif typeOf=="function" then --we execute the commands on the current itteration-- which i
						OperationStorage[#OperationStorage+1]=token
						
							--recursionare pushed into the recursionstorage and executed after the current string has beenn pushed
							elseif typeOf== "string" and token == gramarTable.transitions["RECURSIONSTART"] then							
							--Here comes the trouble, we have to postpone the recurssion 
							RecursiveStorage[#RecursiveStorage+1],recursionEnd=extractRecursion(String,i,gramarTable.transitions["RECURSIONSTART"],gramarTable.transitions["RECURSIONEND"])
							i=math.min(recursionEnd+1,string.len(String))
							end
		
		end

		--Recursions are itterated last but not least
		if table.getn(RecursiveStorage) > 0 then
			for i=1,#RecursiveStorage do		
						

				StartThread(executeLindeMayerSystem,
										 
										gramarTable,
										RecursiveStorage[i],										
										oldDeg,
										Degree,
										UpperLimit,
										recursionDepth,
										recursiveItterator+1,
										EndPiece[math.max(1,math.min(#EndPiece,hit))]
										)
		
			end
		end
		--Recursion Lock - the last one steps the Global Itteration a level up
		
		releaseLocalLock(recursiveItterator)
		--Spring.Echo("Thread Level "..recursiveItterator.." signing off")
		return
end