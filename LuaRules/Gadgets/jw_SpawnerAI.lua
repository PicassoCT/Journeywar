-- In-game, type /luarules kpai in the console to toggle the ai debug messages
 
function gadget:GetInfo()

	
	
        return {
                name = "Spawner AI",
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
	spawnUnits={bio={"jgeohive", "jbeehive"}
				,tec={"bonker","sentry","coverworldgate","combinedfeature"}
				}
	function spawnSpawners(frame)
		
		volume=math.sin(frame/10000)*15
		
		boolBio= volume < 0
		volume=math.abs(volume)
		
		for i=1, volume do
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
	for _, t in ipairs (Spring.GetTeamList ()) do
	
        local teamID, leader, isDead, isAI, side = Spring.GetTeamInfo (t)
        if isAI and Spring.GetTeamLuaAI (teamID) == "Spawner AI" then
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
					meridianTable[#meridianTable]={start=tab,lend=atab}
				end
			end
		end
	
	end

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