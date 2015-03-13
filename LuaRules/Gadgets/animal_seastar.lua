	VFS.Include("scripts/toolKit.lua")
	
	
	gaiaTeamID=Spring.GetGaiaTeamID()
	
	
	
	function handleSeaStars(frame,seastarcounter)
		if frame > 9000 and frame % 300== 0 and seastarcounter < 10 then
		x,z=getSpot(GetSpot_condDeepSea,32,{minBelow=-25,maxAbove=-120})
		tx,tz=getSpot(GetSpot_condDeepSea,32,{minBelow=0,maxAbove=-24})
			
			if x and z and tx and tz then
			id=Spring.CreateUnit("gseastar",x,0,z,1,gaiaTeamID)
				if id then
				Spring.SetUnitMoveGoal(id,tx,0,tz)
				end
			end
		end
		
	end
	
	
	