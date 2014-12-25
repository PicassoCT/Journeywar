--statue spawn gadget

function gadget:GetInfo()
	return {
		name = "Eliah ReSpawner/ Death Catcher",
		desc = "Respawns the eliah, catches dieing units",
		author = "zwzsg",
		date = "3rd of May 2010",
		license = "Free",
		layer = 0,
		version = 1,
		enabled = true
	}
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then
VFS.Include("scripts/toolKit.lua")

	-- Configuration:

numberOfButterflys=4
timeInMsTillRespawn=2500
circleRange=500
GoneForGood={}
--1 Counter
--2 FatherID
--3 - 3+numberOfButterflys
intIntervall=1000
--/Configuration

jTree3RespawnTable={}

--respawns the Eliah
function lineInItIn(valIum)
	--check the butterflies for beeing still alive
					-- if at least one is still in existance then
					      --respawn then eliah
				--nil the entry
			--none of the butterflys is- nil entry	

survivor=nil
for i=3,3+numberOfButterflys,1 do
	if Spring.GetUnitIsDead(GoneForGood[valIum][i])==false then 
	survivor=GoneForGood[valIum][i] 
	break 
	--break
	--i mean it - we have a break, yeah, you read the code, you earned it, grab a soda or a beer, wee meet here again in 3 min
	end
end
	if survivor ~= nil then
	x,y,z=Spring.GetUnitPosition(survivor)
	likeHisFathersFather=Spring.GetUnitTeam(survivor)
	Spring.CreateUnit("jeliah",x,y,z,0,likeHisFathersFather)
		for i=3,3+numberOfButterflys,1 do
			if Spring.GetUnitIsDead(GoneForGood[valIum][i])==false then 
			Spring.DestroyUnit(GoneForGood[valIum][i],false,true)
			end
		end
	end
	
GoneForGood[valIum]=nil
--Lets get this out of here before it starts to rot
end

function reSpawnTree(ix)
	--check the butterflies for beeing still alive
					-- if at least one is still in existance then
					      --respawn then eliah
				--nil the entry
			--none of the butterflys is- nil entry	

	likeHisFathersFather=jTree3RespawnTable[ix][5]
	Spring.CreateUnit("jtree3",jTree3RespawnTable[ix][1],jTree3RespawnTable[ix][2],jTree3RespawnTable[ix][3],0,likeHisFathersFather)
		
	
	
jTree3RespawnTable[ix]=nil
--Lets get this out of here before it starts to rot
end

     function gadget:GameFrame (f)
           if f % intIntervall == 0 then
			--itterate over the whole GoneForGood table
			--decrease the time 
				for i=1,#GoneForGood,1 do
					if GoneForGood[i] ~= nil then
						GoneForGood[i][1]=GoneForGood[i][1]-intIntervall
						--to avoid n² we do this onloop
							if GoneForGood[i][1] < 0 then
								lineInItIn(i)

							end
					end
			    end
				
				for i=1,#jTree3RespawnTable,1 do
					if jTree3RespawnTable[i] ~= nil then
						jTree3RespawnTable[i][6]=jTree3RespawnTable[i][6]-intIntervall
						--to avoid n² we do this onloop
							if jTree3RespawnTable[i][6] < 0 then
								reSpawnTree(i)
								jTree3RespawnTable[i]=nil
							end
					end
			    end
				
				
				
			-- if time < 0 then
			
			
			
		   end
           
     end
eliahDefID=UnitDefNames["jeliah"].id
jtree3DefID=UnitDefNames["jtree3"].id
conAirDefID=UnitDefNames["conair"].id

function inRandomRange(x,z,Range)
xR=math.random(1,Range)
zR=math.random(1,Range)
signed=math.random(-1,1)
x=math.abs(math.ceil(x+(signed*xR)))
signed=(math.random(-1,1))
z=math.abs(math.ceil(z+(signed*zR)))
return x,z
end

blooddecals={"blooddecalfactory","blooddecalfactory1","blooddecalfactory2","blooddecalfactory3"}
local spGetUnitPosition=Spring.GetUnitPosition
local c_infantryTypeTable=getTypeTable(UnitDefNames,{"css","bg","gcivillian","advisor","zombie","bg2","jhivehoundmoma"})
local j_infantryTypeTable=getTypeTable(UnitDefNames,{"tiglil","skinfantry","jcrabcreeper","jconroach","vort","jvaryfoo"})

	function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
		if c_infantryTypeTable[unitDefID] then
		x,y,z=spGetUnitPosition(unitID)
		name="blooddecal".."factory"
			if x then
			Spring.CreateUnit(blooddecals[math.random(1,#blooddecals)],x,y,z,0,teamID)
			end
		end
		
		if j_infantryTypeTable[unitDefID] then
			x,y,z=spGetUnitPosition(unitID)
			if x then
			if math.random(0,1)==1 then
			Spring.CreateUnit("blueblooddecalfactory",x,y,z,0,teamID)
			else
			Spring.CreateUnit("blueblooddecalfactory2",x,y,z,0,teamID)
			end
			end
		end
	
		if unitDefID== conAirDefID and attackerID and teamID ~= attackerTeamID then
			x,y,z=Spring.GetUnitPosition(unitID)
			vx,vy,vz,vl=Spring.GetUnitVelocity(unitID)
			
			id=Spring.CreateUnit("cconaircontainer",x,y,z,0,teamID)
			Spring.SetUnitVelocity(id,vx,vy,vz)
			Spring.SetUnitNeutral(id,true)
			Spring.SetUnitNoSelect(id,true)

		end
	
		if unitDefID== eliahDefID then
		--Spring.Echo("Eliah died")
			--get the Position where he died
			x,y,z=Spring.GetUnitPosition(unitID)
				GoneForGood[#GoneForGood+1]={}
				GoneForGood[#GoneForGood][1]={}
				GoneForGood[#GoneForGood][1]=timeInMsTillRespawn
				GoneForGood[#GoneForGood][2]={}
				GoneForGood[#GoneForGood][2]=unitID
				
					for i=3,3+numberOfButterflys,1 do
					GoneForGood[#GoneForGood][i]={}
						--spawn numberOfButterflys many butterflies
						--store the info in a GoneForGood[]={} --Table
					tx,tz=inRandomRange(x,z,circleRange)
					GoneForGood[#GoneForGood][i]=Spring.CreateUnit("jbutterfly",tx,y,tz,0,teamID)
			
			
					end
			--spawnWithinCircle
		end
		if unitDefID== jtree3DefID then
		x,y,z=Spring.GetUnitPosition(unitID)
		jTree3RespawnTable[#jTree3RespawnTable+1]={}
		jTree3RespawnTable[#jTree3RespawnTable][1]={}
		jTree3RespawnTable[#jTree3RespawnTable][1]=x
		jTree3RespawnTable[#jTree3RespawnTable][2]={}
		jTree3RespawnTable[#jTree3RespawnTable][2]=y
		jTree3RespawnTable[#jTree3RespawnTable][3]={}
		jTree3RespawnTable[#jTree3RespawnTable][3]=z
		jTree3RespawnTable[#jTree3RespawnTable][4]={}
		jTree3RespawnTable[#jTree3RespawnTable][4]=unitID
		jTree3RespawnTable[#jTree3RespawnTable][5]={}
		jTree3RespawnTable[#jTree3RespawnTable][5]=teamID
		jTree3RespawnTable[#jTree3RespawnTable][6]={}
		jTree3RespawnTable[#jTree3RespawnTable][6]=math.ceil((math.random(3500,120000)))
		
		end
	
		
	
	end
	
	
end



