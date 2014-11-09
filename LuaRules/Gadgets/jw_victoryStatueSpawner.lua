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
			teamID,leader,boolIsDead,boolIsAITeam,side,_,_,_=	Spring.GetTeamInfo(TeamID)

					--Spring.Echo(side)
					assert(side)
				if side =="centrail" or side =="Centrail" then

				teamID=Spring.GetGaiaTeamID()
				distancex=math.ceil(math.random(100,150))+x
				distancez=math.ceil(math.random(100,150))+z
				Spring.CreateUnit("cvictory",distancex,y,distancez,0,teamID)
				
					else
					teamID=Spring.GetGaiaTeamID()
					distancex=math.ceil(math.random(100,150))+x
					distancez=math.ceil(math.random(100,150))+z
					
					Spring.CreateUnit("jvictory",distancex,y,distancez,0,teamID)
					end
			end
	end	
end



