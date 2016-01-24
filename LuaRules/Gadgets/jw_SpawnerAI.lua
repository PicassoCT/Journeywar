-- In-game, type /luarules kpai in the console to toggle the ai debug messages
 
function gadget:GetInfo()

	
	
        return {
                name = "spawner",
                desc = "Spawns Units",
                author = "Your Moma",
                date = "around since last tuesday",
                license = "GPOCNL - Gajop Pissed Off Cause Nonsense License ",
                layer = 82,
              enabled = true
        }
end



if (gadgetHandler:IsSyncedCode()) then
	gaiaTeam=Spring.GetGaiaTeamID()
	teamTable={}
	meridianTable={}
	spawnUnits={ bio={"jgeohive", "jbeehive"}
				,tec={"bonker","sentry","coverworldgate","combinedfeature"}
				}
	function spawnSpawners(frame)
		
		volume=math.sin(frame/10000)*15
		
		boolBio= volume < 0
		volume=math.abs(volume)
		
		for _=1, volume do
			meridian=meridianTable[math.random(1,#meridianTable)]
			percent=math.random(0,1)
			px=math.abs(percent*(meridian.start.x)- (1-percent)*(meridian.lend.x))
			pz=math.abs(percent*(meridian.start.z)- (1-percent)*(meridian.lend.z))
			
				if boolBio==true then	
					Spring.CreateUnit(spawnUnits.bio[math.random(1,#spawnUnits.bio)],px,0,pz,0,gaiaTeam)
				else                                                                      
					Spring.CreateUnit(spawnUnits.tec[math.random(1,#spawnUnits.tec)],px,0,pz,0,gaiaTeam)	
				end		
		end
	end
	
	
	spawnerAI={}
	function gadget:Initialize()
		boolAtLeastOneSPawner=false
		Spring.Echo("(Initializing SpawnerAI")
	for _, t in ipairs (Spring.GetTeamList ()) do
	
        local teamID, leader, isDead, isAI, side = Spring.GetTeamInfo (t)
		Spring.Echo("SpawnerAI::TeamInfo::".. teamID, leader, isDead, isAI, side)
		
        if isAI and Spring.GetTeamLuaAI (teamID) == "spawner" then
            spawnerAI[teamID] = true
        
			boolAtLeastOneSPawner=true
        else
		px,py,pz= Spring.GetTeamStartPosition(t)
		if px then
			teamTable[t]={x=px,z=pz}
		end
		end
    end
    if boolAtLeastOneSPawner == false then
        gadgetHandler:RemoveGadget ()
    end
		for team, tab in ipairs (teamTable) do
			for ateam, atab in ipairs (teamTable) do
			
				if team ~=ateam then
				medianPoint={x=0,z=0}
				medianPoint.x,medianPoint.z=(tab.x+atab.x)/2,(tab.z+atab.z)/2
					meridianTable[#meridianTable+1]=medianPoint
				end
				
				
			end
		end
		tempTable={}
		for i=1,#meridianTable do
		for j=1,#meridianTable do
			if i~=j then
			tempTable={tab=meridianTable[i],atab=meridianTable[j]}		
			end
		end
		end
		meridianTable=tempTable
	
	end


	
	incRate=0
	total=9000-incRate
	function gadget:GameFrame(frame)
	if frame > 0 and frame % total == 0 then
		spawnSpawners(frame)
		incRate=math.abs(math.sin(frame/1000)*1024)
		total=9000-incRate
	end
	end


end