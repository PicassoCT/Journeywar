

function gadget:GetInfo()
  return {
    name      = "EventStream",
    desc      = "This gadget streams eventsfunctions until they get deactivated or remove themselves",

    author    = "This one, no, this one shall not pass. He shall remain outside, for he is evil, mending riddles to problems that need no solving. Answering questions we did not have.",
    date      = "Sep. 2014",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end
--A Explanation:
--[[
Eventstreams are a attempt to optimize the number of necessary lua calls. Without the resorting to cumbersome  if frame % magicnumber comparisons.
The Idea is simply- in every interesting case, there is  a event  that started it. And it knows best how to handle itself, 
what data to store, and when to remove itself from the world.

So for every event there is only a basic package needed - a function, a persistance table, and the frame in which it wants to be called..
	--Expected Tableformat:
	--GG.EventStream[nr] which contains Tables in the shape of"..
	--{id=id, Action = function(id,frame, persPack), persPack}"..
	-- 	Action handles the actual action, for example validation a unit still exists.
	--	It always returns a frameNr when it wants to be called Next, and the Persistance Package
	--  If it does not, the Action is considered done and is deleted after calling Final if that is defined -> Final(id, frame, PersPackage)
	--adding the id of the action to GG.EventStreamDeactivate deletes the Action

Once the function does not return a frame - the gadget recognizes the event as complete and delete the event. EventStreams are selfcontained and responsible for what they alter in the game world.

Pros: Dezentralized and therefore Distributed Event management
Cons: Not ideal for Situations where many Units have to interact with one another- in that case you need to write a manager function which 
]]
GG.EventStreamID=0

if (gadgetHandler:IsSyncedCode()) then

	local function CreateEvent(self,...)
		GG.EventStreamID=GG.EventStreamID+1
self[GG.EventStreamID-1] = {id=GG.EventStreamID-1,action=arg.action,persPack=arg.persPack}
			return GG.EventStreamID-1
    end	
	
	local function InjectCommand(self,...)
            self[#self+1] = {...}
    end

	 if not GG.EventStream  then GG.EventStream = { CreateEvent = CreateEvent } end
	local Events={}
	local TimeTable={}
	local TableMin
	local boolInstantUpdate=false
	
	function gadget:GameFrame(frame)
	
	if #GG.EventStream > 0 then
	local streamLine=GG.EventStream
		for i=1,#streamLine do
			Events[streamLine[i].id]=streamLine[i]

		if not	TimeTable[frame] then TimeTable[frame] ={}end 
		table.insert(TimeTable[frame],streamLine[i].id)
		end
	GG.EventStream={CreateEvent=CreateEvent}
	end
	--the exotic word rain, in the ass a pain - i think i got, i think i got: I can talk fluent java-expert gibberish ...PersistancePackageInjection... 
	--expects a Table containing the Data  to inject, a  boolean InstantUpdate and ID 
	--
	 if not GG.PersitanceInject  then GG.PersitanceInject = { InjectCommand = InjectCommand } end
	 if #GG.PersitanceInject then
	 local PI=GG.PersitanceInject
	 frame=Spring.GetGameFrame()
	 
	 	for i=1,#PI do
			if PI[i].InstantUpdate==true then
			boolInstantUpdate=true
			TimeTable[frame]=TableInsertUnique(TimeTable[frame],PI[i].ID)
			end
			table.insert(Events[PI[i].ID], PI[i].Data)
		end
		GG.PersitanceInject ={}
	 end
	
	if not GG.EventStreamDeactivate then GG.EventStreamDeactivate={} end
	if #GG.EventStreamDeactivate > 0 then
		for k,v in pairs(GG.EventStreamDeactivate) do
			Events[k]=nil
		end
		GG.EventStreamDeactivate={}
	end
	--handle EventStream	
		if frame == TableMin or InstantUpdate==true then
		for i=1,#TimeTable[frame] do
			local id=TimeTable[frame][i]
		
				--execute the function
				nextframe,Events[id].persPack=Events[id].action(id,frame, Events[id].persPack)
				
					if nextframe then
						if not	TimeTable[nextframe] then TimeTable[nextframe] ={}end 
					table.insert(TimeTable[nextframe],v.id)
					TableMin=math.min(TableMin,nextframe)
					else
					if Events[id].Final then 
					--Call Finalize Function
					Events[id].Final(id, frame, Events[id].persPack) 
					--Delete the 
					Events[id]=nil
					end					
		end
		end
	
		
	end


end
end
	