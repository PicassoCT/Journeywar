--statue spawn gadget

function gadget:GetInfo()
	return {
		name = "Victory Statue Spawner",
		desc = "Make wrecks sink into the ground like in all those dumb commercial R.T.S. (modified for The Cursed)",
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

	-- Configuration:





	function gadget:TeamDied(TeamID)
		x,y,z=Spring.GetTeamStartPosition(TeamID)
		
			if x~= nil then
			_,leader,boolIsDead,boolIsAITeam,side,_,_,_=	Spring.GetTeamInfo(TeamID)
			gteamID=Spring.GetGaiaTeamID()
				if string.lower(side) =="centrail" then

		
				distancex=math.ceil(math.random(100,150))+x
				distancez=math.ceil(math.random(100,150))+z
				Spring.CreateUnit("cvictory",distancex,y,distancez,0,gteamID)
				
					else
					gteamID=Spring.GetGaiaTeamID()
					distancex=math.ceil(math.random(100,150))+x
					distancez=math.ceil(math.random(100,150))+z
					
					Spring.CreateUnit("jvictory",distancex,y,distancez,0,gteamID)

					
					distancex=math.ceil(math.random(100,150))+x
					distancez=math.ceil(math.random(100,150))+z
					Spring.CreateUnit("grecforrest",distancex,y,distancez,0,gteamID)

					end
			end
	end	
end



