

function gadget:GetInfo()
  return {
    name      = "EventStream",
    desc      = "This gadget streams eventsfunctions until they get deactivated or end themselves",
	--Expected Tableformat:
	--GG.EventStream[id] which contains Tables in the shape of"..
	--{id=id,  action(id,frame, persPack), persPack}"..
	-- 	Action handles the actual action, for example validation a unit still exists.
	--	It always returns a frameNr when it wants to be called Next, and the Persistance Package
	--  If it does not, the Action is considered done and is deleted 
	--adding the id of the action to GG.EventStreamDeactivate deletes the Action

    author    = "This one, no, this one shall not pass. He shall remain outside, for he is evil, mending riddles to problems that need no solving. Answering questions we did not have.",
    date      = "Sep. 2014",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end



if (gadgetHandler:IsSyncedCode()) then

	local function CreateEvent(self,...)
            self[#self+1] = {...}
    end

	 if not GG.EventStream  then GG.EventStream = { CreateEvent = CreateEvent } end
	local StreamUnits={}
	local TimeTable={}
	local TableMin
	
	function gadget:GameFrame(frame)
	
	if #GG.EventStream > 0 then
	local streamLine=GG.EventStream
		for i=1,#streamLine do
			StreamUnits[streamLine[i].id]=streamLine[i]

		if not	TimeTable[frame] then TimeTable[frame] ={}end 
		table.insert(TimeTable[frame],streamLine[i].id)
		end
	GG.EventStream={CreateEvent=CreateEvent}
	end
	if not GG.EventStreamDeactivate then GG.EventStreamDeactivate={} end
	if #GG.EventStreamDeactivate > 0 then
		for k,v in pairs(GG.EventStreamDeactivate) do
			StreamUnits[k]=nil
		end
		GG.EventStreamDeactivate={}
	end
	--handle EventStream	
		if frame == TableMin then
		for i=1,#TimeTable[frame] do
			local id=TimeTable[frame][i]
		
				--execute the function
				nextframe,StreamUnits[id].persPack=StreamUnits[id].action(id,frame, StreamUnits[id].persPack)
				
					if nextframe then
						if not	TimeTable[nextframe] then TimeTable[nextframe] ={}end 
					table.insert(TimeTable[nextframe],v.id)
					TableMin=math.min(TableMin,nextframe)
					else
					StreamUnits[id]=nil
					end					
		end
		end
	
		
	end


end
	