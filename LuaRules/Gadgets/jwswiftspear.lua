-- TODO: fix parting Code for 16 pieces -- also distribute maploading over same period --integrate mapparts created



---- file: Land_Lord.lua
-- brief: spawns start unit and sets storage levels
-- author: Andrea Piras
--
-- Copyright (C) 2010,2011.
-- Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
return {
name = "swiftspearPregnant ",
desc = "Cares for those fucked up by the swiftspear",
author = "PicassoCT",
date = "7 b.Creation",
license = "GNU GPL, v2 its goes in all fields",
layer = 0,
enabled = true -- loaded by default?
}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- synced only
if (gadgetHandler:IsSyncedCode()) then
UPDATE_FREQUNECY=100
local pregnanfortime=3*60*30
local unitswhosTimeisComing={}

function thisIsTheEndMyFriend(unitID,teamID)
--Spring.Echo("jwswiftspear_gadget: Just poking into all the holes, to make sure the carrier is alive!")
	if Spring.ValidUnitID(unitID) == true and Spring.GetUnitIsDead(unitID)==false  then
	--Spring.Echo("jwswiftspear_gadget: KILL ME!")
	x,y,z=Spring.GetUnitPosition(unitID)
	Spring.DestroyUnit(unitID,true,false)
	idx= Spring.CreateUnit("jswiftspear",x,y,z, 0, teamID)  
	idx= Spring.CreateUnit("jswiftspear",x,y,z, 0, teamID)  
	end
end

function gadget:GameFrame(f)

	if f%(UPDATE_FREQUNECY) == 0 then
	
		if GG.Prego then 
				if table.getn(GG.Prego)~=0 then
						for i=1, table.getn(GG.Prego),1 do
							if GG.Prego[i] then
								itt=table.getn(unitswhosTimeisComing)
								unitswhosTimeisComing[itt+1]={}
								unitswhosTimeisComing[itt+1][1]=GG.Prego[i][1]
								unitswhosTimeisComing[itt+1][2]=pregnanfortime + math.ceil(math.random(-500,500))
								unitswhosTimeisComing[itt+1][3]=GG.Prego[i][2]		
							 end	
						GG.Prego[i][2]=nil
						end
				end
		else
			GG.Prego = {} 
		end
		
		if unitswhosTimeisComing and table.getn(unitswhosTimeisComing) > 0 then
	--	Spring.Echo("jwswiftspear_gadget: Someones has in good hope!")
			for i=table.getn(unitswhosTimeisComing), 1,-1 do
			unitswhosTimeisComing[i][2]=unitswhosTimeisComing[i][2]-UPDATE_FREQUNECY

				if unitswhosTimeisComing[i][2] < 0 then	
				thisIsTheEndMyFriend(unitswhosTimeisComing[i][1],unitswhosTimeisComing[i][3])
				table.remove(unitswhosTimeisComing,i)
				end
			end
		end
		
		
		
	end
	
	
end

end







