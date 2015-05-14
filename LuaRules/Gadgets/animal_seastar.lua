	 VFS.Include("scripts/lib_OS.lua"      )
 VFS.Include("scripts/lib_TableOp.lua"      )
  VFS.Include("scripts/lib_Build.lua" 	)

	
	
	gaiaTeamID=Spring.GetGaiaTeamID()
	
	
	
	function handleSeaStars(frame,seastarcounter)
		if frame > 9000 and frame % 300== 0 and seastarcounter < 10 then
		x,z=getSpot(GetSpot_condDeepSea,32,{minBelow=-25,maxAbove=-120})
		tx,tz=getSpot(GetSpot_condDeepSea,32,{minBelow=0,maxAbove=-24})
			
			if x and z and tx and tz then
			id=Spring.CreateUnit("gseastar",x,-50,z,1,gaiaTeamID)
				if id then
				Spring.SetUnitMoveGoal(id,tx,0,tz)
				end
			end
		end
		
	end
	
	
	