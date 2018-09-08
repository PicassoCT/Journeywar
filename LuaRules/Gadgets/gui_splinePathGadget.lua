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
		camState={ 	name= "fps",				
				px = 0,
				py = 0,
				pz = 0,
				
				dx = 0,				
				dy = 0,
				dz = 0,
				
				ry  = 0,
				rx  = 0,
				rz  = 0,
				mode= 0,
				oldHeight = 0,
			}
		camTime = 9000
		Spring.SetCameraState( camState,  camTime)
		Spring.SelectUnitMap({unitID= planeID}) -- Here is to hoping that the observed unit is the currently selected one
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
			  if x then
			    CurrentSpline[#CurrentSpline+1]={x,y,z}
			  end
		  end
		oldBoolSplineActive= boolSplineActive
		boolSplineActive = checkIfStillInFirstPerson(planeID)
		if oldBoolSplineActive == true and boolSplineActive== false then
		  SendSplineToWidget(CurrentSpline)		
		end
		end
		
		
	end
	
	function SendSplineToWidget(CurrentSpline)
	 -- TODO Computate bicubic spline
		-- TODO SendToUnsynced	
		
		
	end
	
	function checkIfStillInFirstPerson(planeID)
	  stillActive= true
	  boolUnitIsDead= Spring.GetUnitIsDead(planeID)
	  if not boolUnitIsDead or boolUnitIsDead == true then stillActive = false end
	 
	  camState, _ = Spring.GetCameraState( camState,  camTime)
          if camState.name ~= "fps" then stillActive = false end
		
	  	
	  return stillActive	
	end
	
else --UNSYNCED
	
	
	
   
end
