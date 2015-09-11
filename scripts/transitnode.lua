include"suddenDeath.lua"

Wheel1 =piece "Wheel1"
Wheel2 =piece "Wheel2"
Low1 = piece "Low1"
Low2 = piece "Low2"

LED={}
for i=1, 14 do
LED[#LED+1]={}
piecename=""
if i <10 then
piecename="LED0"..i
else
piecename="LED"..i
end
LED[#LED]=piece(piecename)
Hide(LED[i])
end

DecoderArray={}

DecoderArray[ 0 ]={ 0,1,1,1,1,1,1,0}
DecoderArray[ 1 ]={ 0,0,1,1,0,0,0,0}
DecoderArray[ 2 ]={ 0,1,1,0,1,1,0,1}
DecoderArray[ 3 ]={ 0,1,1,1,1,0,0,1}
DecoderArray[ 4 ]={ 0,0,1,1,0,0,1,1}
DecoderArray[ 5 ]={ 0,1,0,1,1,0,1,1}
DecoderArray[ 6 ]={ 0,1,0,1,1,1,1,1}
DecoderArray[ 7 ]={ 0,1,1,1,0,0,0,0}
DecoderArray[ 8 ]={ 0,1,1,1,1,1,1,1}
DecoderArray[ 9 ]={ 0,1,1,1,1,0,1,1}



function binary(num)
    -- returns a table of bits, least significant first.
    local t={} -- will contain the bits
    while num>0 do
        rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end
    return t
end

 teamID=Spring.GetUnitTeam(unitID)
 
function displayNumber()
if GG.TransitHubNumber== nil then 
GG.TransitHubNumber={} 
GG.TransitHubNumber[#GG.TransitHubNumber+1]=unitID
else
GG.TransitHubNumber[#GG.TransitHubNumber+1]=unitID
end

	number=table.getn(GG.TransitHubNumber)
	firstDigit=number%11
	if firstDigit==10 then firstDigit=0 end
	secondDigit=math.floor(number/10)
	
	
	tx=DecoderArray[firstDigit]
	ty=DecoderArray[secondDigit]
	
	for i=1, 7,1 do
	if tx[i]== 0	then Hide(LED[i]) else Show(LED[i]) end
	end
	
	for i=8, 14,1 do
	if ty[i]== 0	then Hide(LED[i]) else Show(LED[i]) end
	end
	
end

function transferPosTablee(TableOne,Position,TableTwo)
TableTwo[#TableTwo+1]={}
TableTwo[#TableTwo]=TableOne[Position]
return TableTwo
end

-- nicht Mengenmässiges addieren
function transfTable2Table(t1,t2)
for i=1,table.getn(t1),1 do
t2[#t2+1]=t1[i]

end
return t2
end

ArrivedA={}
ArrivedB={}



AllReadyTransported={}
local gblRange=350
local buildID=nil	
local gblTime=10000

function update(tableName,ID)
tableName={}
x,y,z=Spring.GetUnitPosition(ID)
tableName=Spring.GetUnitsInCylinder(x,z,gblRange)
	for i=1,#tableName,1 do

		if tableName[i] ~= nil and tableName[i]==ID or  tableName[i]==unitID then
		tableName[i]=nil
		end

	end
return tableName
end

function littleCarsGoingBackAndForth()
while true do
Move(Low1,z_axis,120,45)
Move(Low2,z_axis,-110,45)
WaitForMove(Low2,z_axis)
WaitForMove(Low1,z_axis)
Move(Low1,z_axis,0,0)
Move(Low2,z_axis,0,0)
rand=math.ceil(math.random(10,1000))
Sleep(rand)
end

end

--function adds allNowTransportedUnitsToAllready transported
function senseMan(tableToAdd)
	for i=1,table.getn(tableToAdd),1 do
		if tableToAdd[i]~=nil and AllReadyTransported[tableToAdd[i]] == nil then
		AllReadyTransported[tableToAdd[i]]=gblTime
		end
	end
	tableToAdd={}
end

function addrandomIntervall(value,intervall,limit)
x=math.random(-1*intervall,intervall)
if x < limit and x > -1*limit then x=limit end
return value+x 
end

function changePlace(tableA, spotTable)
x,y,z=Spring.GetUnitPosition(buildID)
	for i=1,table.getn(tableA),1 do
		if tableA[i]~=nil then
		px=addrandomIntervall(x,100,50)
		pz=addrandomIntervall(z,100,50)
		py=y
			Spring.SetUnitPosition(tableA[i],px,py,pz)
		end
	end
 
end

--function removes all units from the table  that are in AllReadyTransported
function diSectTable(TableToSearchThrough)
	for i=1, table.getn(TableToSearchThrough),1 do
		if TableToSearchThrough[i]~= nil then
		--also we clean out all buildings..
			tempUnitDefID=Spring.GetUnitDefID(TableToSearchThrough[i])
			if UnitDefs[tempUnitDefID].isBuilding==true or  UnitDefs[tempUnitDefID].speed < 0.1 then
			TableToSearchThrough[i]=nil
			end		
		
			if TableToSearchThrough[i]~= nil and AllReadyTransported[TableToSearchThrough[i]]~= nil and AllReadyTransported[TableToSearchThrough[i]]> 0 then
			 TableToSearchThrough[i]=nil
			end 
		end	
	end
end

--whileloop update
	--preconditions
	-- if equal part has been built then
	--get both the Arrivers in A and the Arrivers in B
	--Remove those who are on the AllReadyTransported List
	
	--Exchange the Positions
	--Add All the Units to the AllReadyTransported
function decrementTransportTable()
for i=1,table.getn(AllReadyTransported),1 do
	if AllReadyTransported[i] ~= nil then
	AllReadyTransported[i]=AllReadyTransported[i]-200
	if AllReadyTransported[i] < 0 then AllReadyTransported[i]=nil end
	end
end
end



function main()
	local lupdate=update
	local ldiSectTable=diSectTable
	local lchangePlace=changePlace
	local lsenseMan=senseMan

	while true do
	----Spring.Echo(buildID)
	
	
		if buildID~= nil and Spring.ValidUnitID(buildID) == true then
			----Spring.Echo("We have a exit")
			while( Spring.GetUnitIsDead(buildID) == false ) do
			----Spring.Echo("GetInGuys")
			ArrivedA=lupdate(ArrivedA, unitID)
			ArrivedB=lupdate(ArrivedB,buildID)
			----Spring.Echo(table.getn(ArrivedA))
				ldiSectTable(ArrivedA)
				ldiSectTable(ArrivedB)
			lchangePlace(ArrivedA,ArrivedB)
			lchangePlace(ArrivedB,ArrivedA)
				lsenseMan(ArrivedA)
				lsenseMan(ArrivedB)
			Sleep(200)
			decrementTransportTable()
			end
		end
	Sleep(250)
	end
end

function script.StopBuilding()
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function getBuildID()
Sleep(500)
guildID=Spring.GetUnitIsBuilding(unitID)
	if guildID~= nil and Spring.ValidUnitID(guildID)==true and Spring.GetUnitDefID(guildID)	==UnitDefNames["ctransithubb"].id then
	--Spring.Echo("Found a Builded Unit")
	buildID=guildID
	end


end

function script.StartBuilding(heading, pitch)	
SetUnitValue(COB.INBUILDSTANCE, 1)
StartThread(getBuildID)
	
end

Spring.SetUnitNanoPieces(unitID,{ Wheel1})

function sound()
	while(true) do
	Spring.PlaySoundFile("sounds/ctransithub/traffic.wav",0.8)
	Sleep(3500)
	dice=math.random(1,128)
		if dice== 99 then
		Spring.PlaySoundFile("sounds/ctransithub/trafficnodepolice.wav",0.8)
		Sleep(4000)

		end


	end

end

function script.Create()
StartThread(sound)
StartThread(littleCarsGoingBackAndForth)
StartThread(main)
Spin(Wheel1,z_axis,math.rad(-70),0)
Spin(Wheel2,z_axis,math.rad(70),0)
displayNumber()

end
function script.Killed(recentDamage,_)
if Spring.ValidUnitID(buildID)== true then Spring.DestroyUnit(buildID,true,false)end
suddenDeath(unitID,recentDamage)
return 0
end