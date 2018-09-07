function gadget:GetInfo()
    return {
        name = "gui_splinePathGadget",
        desc = "",
        author = "PicassoCT",
        date = "o 0.0.0 - +01.01.1001",
        version = "v0.1",
        license = "GPL v3.0 or later",
        layer = -1,
        enabled = true ,
    }
end


if gadgetHandler:IsSyncedCode() then
    -------------------------------------
    ---------------- SYNCED---------------
   
   VFS.Include("scripts/lib_UnitScript.lua")
	CurrentSpline = {}
	boolSplineActive=false
	planeID = nil
	GROUND_OFFSET= 50
	
	function spawnVPlane(playerID, x, z)
		if UnitDefNames["vsplineplane"] then
		planeDefID = UnitDefNames["vsplineplane"].id
		ground= Spring.GetGroundHeight(x,z)
		_,_,_,teamID= Spring.GetPlayerInfo(playerID)
		planeID = Spring.CreateUnit(planeDefID,x, ground + GROUND_OFFSET,z, math.random(0,3), teamID)
		end
	
	end
	
	function gadget:RecvLuaMsg(msg, playerID)	 
		start,ends= string.find(msg,"SPLINESTART|")
		if ends then
			CurrentSpline = {}
			numberString = string.sub("SPLINESTART|",ends+1,#msg)
			t= stringSplit(numberString,"|")	
			startx,startz = tonumber(t[1]),tonumber(t[2])	
			boolSplineActive= true	
			spawnVPlane(playerID,startx,startz)
		end
	 end
	

	function gadget:GameFrame(f)
		if boolSplineActive == true and f % 5 == 0  then
			if planeID then
			x,y,z= Spring.GetUnitPosition(planeID)
			end
		end
	end
	
	
else --UNSYNCED
	
	
	
   
end