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
local pregnanfortime=33000

function growItBack(unitID)
	for it=0.1,0.9,0.1 do
							
								local f=(0.01+it)%1
								
								Sleep(500)
							end

	end

local unitsWhoAreStillGrowing={}
local unitswhosTimeisComing={}

function thisIsTheEndMyFriend(unitID,teamID)
--Spring.Echo("jwswiftspear_gadget: Just poking into all the holes, to make sure the carrier is alive!")
	if Spring.ValidUnitID(unitID) == true and Spring.GetUnitIsDead(unitID)==false  then
	--Spring.Echo("jwswiftspear_gadget: KILL ME!")
	x,y,z=Spring.GetUnitPosition(unitID)
	Spring.DestroyUnit(unitID,true,false)
	idx= Spring.CreateUnit("jswiftspear",x,y,z, 0, teamID)  
	--Spring.Echo("TODO_ CALL GLIDE SHRINK")
								-- gl.PushMatrix()
								-- gl.Unit(idx)
								-- gl.Scale(0.1,0.1,0.1)
								-- gl.PopMatrix()		
		--[[ 	unitsWhoAreStillGrowing[#unitsWhoAreStillGrowing+1]={}								
			unitsWhoAreStillGrowing[#unitsWhoAreStillGrowing][1]=idx								
			unitsWhoAreStillGrowing[#unitsWhoAreStillGrowing][2]=0.1 ]]								
				

	end
end

function gadget:GameFrame(f)

	if f%(UPDATE_FREQUNECY) == 0 then

	
		if GG.Prego ~= nil then 
				if table.getn(GG.Prego)~=0 then
						for i=1, table.getn(GG.Prego),1 do
							if GG.Prego[i] ~= nil then
							dice=math.random(0,99)
							--there is a chance of 1 in 100 that you dont get pregnant
								if dice~= 99 and GG.Prego[i][2] ~= nil then 
								itt=table.getn(unitswhosTimeisComing)
								unitswhosTimeisComing[itt+1]={}
								itt=itt+1
								unitswhosTimeisComing[itt][1]={}
								unitswhosTimeisComing[itt][1]=GG.Prego[i][1]
								unitswhosTimeisComing[itt][2]={}
								unitswhosTimeisComing[itt][2]=pregnanfortime+ math.ceil(math.random(-2000,40000))
								unitswhosTimeisComing[itt][3]={}
								unitswhosTimeisComing[itt][3]=GG.Prego[i][2]
								end
							 end	
						GG.Prego[i][2]=nil
						end
				end
		else
		GG.Prego={} 
		end
		if unitswhosTimeisComing~=nil and table.getn(unitswhosTimeisComing)~= 0 then
		--Spring.Echo("jwswiftspear_gadget: Someones has in good hope!")
			for i=1,table.getn(unitswhosTimeisComing),1 do
			unitswhosTimeisComing[i][2]=unitswhosTimeisComing[i][2]-UPDATE_FREQUNECY
				if unitswhosTimeisComing[i][2] < 0 then
				--Spring.Echo("jwswiftspear_gadget: Cograts it is a swiftspear")
				thisIsTheEndMyFriend(unitswhosTimeisComing[i][1],unitswhosTimeisComing[i][3])
				table.remove(unitswhosTimeisComing,i)
				end
			end
		end
		
			--[[ if unitsWhoAreStillGrowing~=nil and table.getn(unitsWhoAreStillGrowing)~= 0 then
				for i=1,table.getn(unitsWhoAreStillGrowing),1 do
					if unitsWhoAreStillGrowing[i][2]+0.1 < 1 then
						--Spring.Echo("TODO_ CALL GLIDE slowGrowth")
										-- gl.PushMatrix()
										-- gl.Unit(idx)
										-- gl.Scale(unitsWhoAreStillGrowing[i][2]+0.1,	unitsWhoAreStillGrowing[i][2]+0.1,unitsWhoAreStillGrowing[i][2]+0.1)
										-- gl.PopMatrix()		
					unitsWhoAreStillGrowing[i][2]=(unitsWhoAreStillGrowing[i][2]+0.1)%1
					else
					table.remove(unitsWhoAreStillGrowing,i)
					end
					
				end
			end ]]
		
	end
	
	
end

end







