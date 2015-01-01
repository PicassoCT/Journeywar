--[[
     
    function gadget:GetInfo()
    return {
    name = "xmas-gadget",
    desc = "Gadget",
    author = "PicassoCT",
    date = "Oh, you wish, you had it with this file - but she got class",
    license = "GNU GPL, v2 its goes in all fields",
    layer = 0,
    enabled = false  -- loaded by default?
    }
    end
     
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     
    -- synced only
  if (gadgetHandler:IsSyncedCode()) then

     local boolActive=( os.date('*t').month==12)
UPDATE_FREQUNECY=15000
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
  santaID=""
  teamList=Spring.GetTeamList()
  placesToBe={}
  for i=1,#teamList do
  x,y,z=Spring.GetTeamStartPosition(teamList[i])
    placesToBe[i]={x=x,y=y,z=z}  
  end
  
  gaiaID=Spring.GetGaiaTeamID()
  r=math.random(1,#placesToBe)
				function gadget:GameFrame(f)
                      if boolActive==true and f%UPDATE_FREQUNECY == 0 then
					  if Spring.ValidUnitID(santaID)==false then
					  r=math.random(1,#placesToBe)
					  santaID=Spring.CreateUnit("gsanta",placesToBe[r].x,placesToBe[r].y,placesToBe[r].z,0,gaiaID)
					  r=r%(#placesToBe)+1
					  Spring.SetUnitMoveGoal(santaID,placesToBe[r].x,placesToBe[r].y,placesToBe[r].z)
					  end
                      end
            end
			
			
			
     
end
	
	]]