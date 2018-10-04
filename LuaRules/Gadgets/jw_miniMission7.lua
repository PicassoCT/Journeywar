eStateStart = 1
eStateGoingDown = eStateStart + 1
eStateCrashed = eStateGoingDown + 1

eStateSaveUs = eStateCrashed + 1

eInsurgency = eStateSaveUs + 1

--InsurgencyEnd
eStateSavedCentrail = eInsurgency + 1
eStateSavedJourney = eStateSavedCentrail + 1

eStatsCureQuest = eStateSavedJourney + 1
eStateFoundCure = eStatsCureQuest + 1
eStateCureRetrieved = eStateFoundCure + 1
eStatePlanetsEndTerraformingStart = eStateCureRetrieved + 1
eStateSheSearchStart = eStatePlanetsEndTerraformingStart + 1
eStateFoundHim = eStateSheSearchStart + 1
eStateEvacuationCompleted = eStateFoundHim + 1
eBlackHoleRayPlanetSinger = eStatePlanetsEndTerraformingStart + 1

eStateMissionFailed = math.huge
startTime = 180000

CitadellConqueredFactor= 0.0

exampleDialogue = {
    index = 1,
    [1] = { Time = 300, Sound = "sounds/Missions/missionBriefing.ogg", Text = "Ratatat" }
}

function speakDialogue(frame, dialogueTable)
    if dialogueTable.Time and dialogueTable.Time > frame then return false, dialogueTable; end

    if not dialogueTable[dialogueTable.index] then return true, dialogueTable
        --Done here
    end


    dialogueTable.Time = frame + dialogueTable[dialogueTable.index].Time
    say(dialogueTable[dialogueTable.index].Text, dialogueTable[dialogueTable.index].Time, NameColour, TextColour, OptionString, dialogueTable[dialogueTable.index].id)
    Spring.PlaySoundFile(dialogueTable[dialogueTable.index].Sound, 1.0)

    dialogueTable.index = dialogueTable.index + 1
    return false, dialogueTable
end

function missionStepAndTime(frame, expectedStep, Time)
    if not Time then
        return MissionFunctionTable[7][3] == expectedStep
    end
    if expectedStep and Time then
        return MissionFunctionTable[7][3] == expectedStep and frame - MissionFunctionTable[7][2] > Time
    end
end

function nextStep(targetStep)
    MissionFunctionTable[7][3] = targetStep
end

function missionOngoing(fooNction)
    return fooNction()
end

function endOfTheWorld(startframe, frame)
offset = frame -startframe
colourTable= {
			[1]= {frame=10000,r=0,g=0,b=0,flux={r=50,g=50,b=50}},--red
			[2]= {frame=15000,r=0,g=0,b=0,flux={r=50,g=50,b=50}},--orange
			[3]= {frame=35000, r=0,g=0,b=0,flux={r=50,g=50,b=50}},--dark
			[4]= {frame=64000, r=0,g=0,b=0 , flux={r=50,g=50,b=50}} -- lila
			}
			
lastInstance=colourTable[1]

for i=1,#colourTable do
	local colTab=colourTable[i]
	if offset < colTab.frame then
		--setSunCol mix(colTab,lastInstance, math.max(0.0,math.min(1.0,(frame-lastInstance.frame)/(colTab.frame-lastInstance.frame))
	end
end	
		
end

stillAlive = function(id) return Spring.GetUnitIsDead(id) == false; end
conditionlessOngoing = function() return false; end
gameOver = function() return true; end
function Misson7InFairAndLoveEverythingIsWar(frame)

    if not MissionFunctionTable[7][2] then MissionFunctionTable[7][2] = frame end
    if not MissionFunctionTable[7][3] then MissionFunctionTable[7][3] = eStateStart end
	if not MissionFunctionTable[7].teamID then MissionFunctionTable[7].teamID =   getCombinePlayer() end
	if not MissionFunctionTable[7].mainBuilding then MissionFunctionTable[7].mainBuilding = getTeamUnitOfType(MissionFunctionTable[7].teamID, UnitDefNames["citadell"].id) end

    --send the transport crashing
    if missionStepAndTime(frame, eStateStart, startTime) then
        x, y, z = getOrthoLocation()
        id = Spring.CreateUnit("cconair", x, y, z,  MissionFunctionTable[7].teamID, 1, 0)
        if id then
            Spring.SetUnitCrashing(id, true)
            MissionFunctionTable[7].conair = id
            MissionFunctionTable[7][9] = { x = x, y = y, z = z }

            nextStep(eStateGoingDown)
            return missionOngoing(conditionlessOngoing)
        else
            nextStep(eStateMissionFailed)
            return missionOngoing(gameOver)
        end
    end

    callForHelp = {
        index = 1,
        [1] = { Time = 3000, Sound = "sounds/Missions/missionBriefing.ogg", Text = "I should no call, you im sure - im a traitor by now. Oh, how the mighty have fallen. I was like you once, had a citadell of my own, keeping the lions, tigers and bears at bay. Now, all has crumbled to dust- and - even the love of my life withers away, with the Journeymans ailment upon her. I can arrest it for the time beeing, but i can not cure it- i need your help. Help me, to save her- i beg you." , },
        [2] = { Time = 6000, Sound = "sounds/Missions/missionBriefing.ogg", Text = "He loved my old self, when i was not part of the choire, and will do anything, to prevent the butterflys completition. Help me, to end this, help him to see what is freedom. Release me from this shell and end the suffering. " },
        [3] = { Time = 3000, Sound = "sounds/Missions/missionBriefing.ogg", Text = "Centrail: Communication Containment breached, the Adminstration of this sector is deemed infected and must be disposed. Cauterization in progress.." },
        [4] = { Time = 3000, Sound = "sounds/Missions/missionBriefing.ogg", Text = "Loyalists: We do not reveal ourselves, usually- but we all have lost ones, and preseving those is a worthy endavour. We shall fight the Exobiotics- and the Centrail Confederates in the Citadell.." },
        [5] = { Time = 3000, Sound = "sounds/Missions/missionBriefing.ogg", Text = "Journeys: Who are we, if we do not fight for live to be free of the datadragon, the metall disease, the undead." },
        [6] = { Time = 3000, Sound = "sounds/Missions/missionBriefing.ogg", Text = "Journeys: Who are we, to seperate lovers, to divide and destroy, and call the ashes conquered? Becoming like the abomination, that we shall have no part in that." },
    }

    if missionStepAndTime(frame, eStateGoingDown) then
        if Spring.GetUnitIsDead(MissionFunctionTable[7].conair) == true then
            if not MissionFunctionTable[7].he then
                MissionFunctionTable[7].he  = Spring.CreateUnit("thecouple", MissionFunctionTable[7][9].x, MissionFunctionTable[7][9].y, MissionFunctionTable[7][9].z,  MissionFunctionTable[7].teamID , 1)
                process(callForHelp, function(Table)
											Table.id = MissionFunctionTable[7].he
											return Table; 
										end
										)
            end
            boolDialgoueDone, callForHelp = speakDialogue(callForHelp)
            if boolDialgoueDone == true then
                nextStep(eStateSaveUs)
            end
        end

        return missionOngoing(conditionlessOngoing)
    end
	
    if missionStepAndTime(frame, eStateSaveUs) then
	
	civilWarIsOver = function (frame, citadelID)
	
		if stillAlive(citadelID) == false then return true end
		if stillAlive(MissionFunctionTable[7].he) == false then return true end
	
		infantryType= getInfantryTypeTable()
		teamID = Spring.GetUnitTeam(citadelID)
		x,y,z= Spring.GetUnitPosition(citadelID)
		
		CitadellConqueredFactor= CitadellConqueredFactor + 0.001
		if CitadellConqueredFactor >= 1.0 then return true end
		
		if frame % 10 then spawnCegAtUnit(citadelID, "AR2Projectile", 0, 100 *CitadellConqueredFactor, 0, math.random(-10,10)/10,math.random(0,10)/10,math.random(-10,10)/10) end --sfx
		
		process( getAllInCircle(x,z, 125,citadelID, teamID),
				function(id)
					if infantryType[Spring.GetUnitDefID(id)] and CitadellConqueredFactor > 0 then
						Spring.DestroyUnit(id,true,false)
						CitadellConqueredFactor= math.max(0,CitadellConqueredFactor - 0.002)
					end
				end
				)
				
		return false
	end
		--check Civil War Status
		
		-- EndConditions
        if civilWarIsOver(frame,  MissionFunctionTable[7].mainBuilding) == true then
            return missionOngoing(gameOver)
        end

        --check for the couple reaching the citadell
        if unitReached(MissionFunctionTable[7].he, "citadell", 50) == true or  unitReached(MissionFunctionTable[7].he, "beanstalk", 50) == true  then
			nextStep(eStateSavedCentrail)
        end

        return stillAlive(MissionFunctionTable[7].he) == false
    end
	
	if missionStepAndTime(frame, eStateSavedCentrail) then
		Spring.Echo("She is still sick, but in stasis. I need a piece of those gaudy trees near radiation to cure her.")
		Spring.DestroyUnit(MissionFunctionTable[7].he, true, false)
		x,y,z= Spring.GetUnitPosition(MissionFunctionTable[7].mainBuilding)
		MissionFunctionTable[7].he= Spring.CreateUnit("thecouplehealone", x,y,z,  MissionFunctionTable[7].teamID , 1)
		nextStep(eStatsCureQuest)
	end
	
	if missionStepAndTime(frame, eStatsCureQuest) then
		if stillAlive(MissionFunctionTable[7].he) == false then return true end
	
		if  unitReached(MissionFunctionTable[7].he, "jtree2", 50) then
			nextStep(eStateCureRetrieved)
		
		end
	end  
	
	sentence= "I have the fruit, im analyzing it now, transfering the data. To be them, so strange- like a fever dream. They where mamals once, divided into castes by neuron-patterns. One to uphold sexual contracts, one for war, one paranoid to encapsulate groups. The irony - these trees- they once where a cure to wishfull thinking."
	
	if missionStepAndTime(frame, eStateCureRetrieved) then
		say(sentence, 3000, NameColour, TextColour, OptionString, 15)
		TransferUnit(MissionFunctionTable[7].he, Spring.GetGaiaTeamID())
		MissionFunctionTable[7].frame = Spring.GetGameFrame()
		nextStep(eStatePlanetDeclaredDefunct)
	end
	
	
	if missionStepAndTime(frame, eStatePlanetDeclaredDefunct,MissionFunctionTable[7].frame + 7000) then
		thisIsTheEnd = " Dimension "..string.byte(TODOMapname).." Planet "..PlanetNameGenerator().. " was brought into the exobiotic reference frame three local weeks ago. It presented with a hidden initial infestation, which upon discovery quickly contaminated 0.67 of the total population. After several treatments, and containment breaches, colony survival is unlikely. Two hours ago, a artificial singularity was inserted into the primary solar of the system. Radiation and Novasurges will sterlize the system. Portals and communication will be one way until the system is sterile."	
		MissionFunctionTable[7].frame= Spring.GetGameFrame()		
		say(thisIsTheEnd, 3000, NameColour, TextColour, OptionString, 15)
		x,y,z=Spring.GetUnitPosition(MissionFunctionTable[7].mainBuilding )
		MissionFunctionTable[7].she =Spring.CreateUnit("thecoupleshealone", x,y,z,  MissionFunctionTable[7].teamID , 1)
		nextStep(eStateSheVenturesOutToSafeHime)
	end
	
	if missionStepAndTime(frame, eStateSheVenturesOutToSafeHime)then
		sheSaid = "honey, i had the most strangest dream. You where in it, stealing apples from dragons as old as the redest sun. Honey?"
		say(sheSaid, 3000, NameColour, TextColour, OptionString, 15)
		MissionFunctionTable[7].frame = Spring.GetGameFrame()		
		nextStep(eStateSearchingForHim)
	end
	
	if missionStepAndTime(frame, eStateSearchingForHim) then
		x,y,z= math.random(0,Game.mapSizeX),0, math.random(0,Game.mapSizeZ)
		Spring.SetUnitMoveGoal(MissionFunctionTable[7].he, x, y, z)
	
		if distanceUnitToUnit(MissionFunctionTable[7].she, MissionFunctionTable[7].he) < 50 then
			Spring.TransferUnit(MissionFunctionTable[7].he,Spring.GetUnitTeam(MissionFunctionTable[7].she))
			nextStep(eStateBringThemHome)		
		end
		
		if endOfTheWorld() then
		end
	
	end
	
	
	
	--[[


[23:27:42] <Pica> Chaos ensues.. as the sun is devoured from the inside out..  some citizens turn towards the Journeyman for saving, some flee towards the closed gates...
[23:28:28] <[SPM]spymort> huh?
[23:28:50] <Pica> Farcaster gates- centrial Uits.. civilians.. neutral unit.
[23:29:33] <Pica> Ironically, in the midst of civilsational downfall, a "cure" is found, that stabilizes the Journeyman transformation of the lovers midway.
[23:30:03] <Pica> Shelters are dug, to prevent the blackholes radiation from killing the population.
[23:30:35] <Pica> Meanwhile, the non-rad-resistant part of the journeyman flora decays away
[23:35:57] <Pica> To finalize the burned earth method, the  Journeys this time, grow a magmaoszillator to sing the planet appart.
[23:36:43] <Pica> Ground shatters, magmastream eject  tectonicplateparts into the upper atmosphere..
[23:37:24] <Pica> And in the chaos, the carryier is lost- this time to be searched by the formerly Infected.
[23:37:55] <Pica> Meanwhile dissenting Journeys, have grown a portal to another CentrailWorld, not knowing it is besieged. 
[23:38:30] <Pica> Over the fractal ocsillating magma of the planet, shards drift in hard vacuum.
[23:39:30] <Pica> Only the shelters as a whole can be transported, and are
[23:40:20] <Pica> Finally, even the troops get evacuated- and with the last remains left behind- the Couple is finding one another.
[23:41:10] <Pica> To prevent the portal from beeing devoured, the administrator keeps the citadell staffed.
[23:42:18] <Pica> The formerly carryied, carrys now the formerly Carrying through the portal.  The whole story is written down on a memory block, and ejected as the Systems Gravestone into  the outher orbit.
[23:42:27] <Pica> "Let those who come after us know, what happend here
[23:43:16] <Pica> Journeylive grows around the blackhole, and dies off- a dry dead, dysonsphere of twigs...
[23:43:22] <Pica> The end
    ]]

end
	