
     
    function gadget:GetInfo()
    return {
    name = "xmas-gadget",
    desc = "Gadget",
    author = "PicassoCT",
    date = "Santa is going to town on you all",
    license = "GNU GPL, v2 its goes in all fields",
    layer = 0,
    enabled = true  -- loaded by default?
    }
    end
     
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     
    -- synced only
  if (gadgetHandler:IsSyncedCode()) then

      boolActive=( os.date('*t').month==12) and (os.date('*t').day==24)
	UPDATE_FREQUNECY=30*12*60
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
  santaID=-math.huge
  teamList=Spring.GetTeamList()
  placesToBe={}
  for i=1,#teamList do
  x,y,z=Spring.GetTeamStartPosition(teamList[i])
    placesToBe[i]={x=x,y=y,z=z}  
  end
  
  gaiaID=Spring.GetGaiaTeamID()
  r=math.random(1,#placesToBe)
				function gadget:GameFrame(f)
                      if boolActive==true and f> 0 and f%UPDATE_FREQUNECY == 0 then
								  if Spring.ValidUnitID(santaID)==false or Spring.GetUnitIsDead(santaID) == true then
									Spring.Echo("Hohoho, merry X-Mas everyone.")
										r=math.random(1,#placesToBe)
									  santaID=Spring.CreateUnit("gsanta",placesToBe[r].x,placesToBe[r].y,placesToBe[r].z,0,gaiaID)
									  r=r%(#placesToBe)+1
									  Spring.SetUnitMoveGoal(santaID,
														  placesToBe[r].x+math.random(-128,128),
														  placesToBe[r].y+math.random(-128,128),
														  placesToBe[r].z+math.random(-128,128)
														  )
								  end
                      end
            end
			
			
			
     
end
