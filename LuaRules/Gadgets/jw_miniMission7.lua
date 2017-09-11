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

stillAlive = function(id) return Spring.GetUnitIsDead(id) == false; end
conditionlessOngoing = function() return false; end
gameOver = function() return true; end
function Misson7InFairAndLoveEverythingIsWar(frame)

    if not MissionFunctionTable[7][2] then MissionFunctionTable[7][2] = frame end
    if not MissionFunctionTable[7][3] then MissionFunctionTable[7][3] = eStateStart end

    --send the transport crashing
    if missionStepAndTime(frame, eStateStart, startTime) then
        teamID = getCombinePlayer()
        x, y, z = getOrthoLocation()
        id = Spring.CreateUnit("cconair", x, y, z, teamID, 1, 0)
        if id then
            Spring.SetUnitCrashing(id, true)
            MissionFunctionTable[7][10] = teamID
            MissionFunctionTable[7][12] = id
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
        if Spring.GetUnitIsDead(MissionFunctionTable[7][12]) == true then
            if not MissionFunctionTable[7][11] then
                MissionFunctionTable[7][11] = Spring.CreateUnit("thecouple", MissionFunctionTable[7][9].x, MissionFunctionTable[7][9].y, MissionFunctionTable[7][9].z, MissionFunctionTable[7][10], 1)
                process(callForHelp, function(Table) Table.id = MissionFunctionTable[7][11]; return Table; end)
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
		infantryType= getInfantryTypeTable()
		teamID = Spring.GetUnitTeam(citadelID)
		x,y,z= Spring.GetUnitPosition(citadelID)
		
		CitadellConqueredFactor= CitadellConqueredFactor + 0.001
		if CitadellConqueredFactor >= 1.0 then return true end
		
		if frame % 10 then spawnCEGatUnit(citadelID, "AR2Projectile", 0, 100 *CitadellConqueredFactor, 0, math.random(-10,10)/10,math.random(0,10)/10,math.random(-10,10)/10) end --sfx
		
		process( getAllInCircle(x,z, 125,citadelID, teamID),
				function(id)
					if infantryType[Spring.GetUnitDefID(id)] and CitadellConqueredFactor > 0 then
						Spring.DestroyUnit(id,true,false)
						CitadellConqueredFactor= math.max(0,CitadellConqueredFactor - 0.002)
					end
				end
				)
		
		if stillAlive(MissionFunctionTable[7][11]) == false then return true end
		
		return false
	end
		--check Civil War Status
		
		
		-- EndConditions
        if civilWarIsOver(frame) == true then

            return missionOngoing(gameOver)
        end

        --check for the couple reaching the citadell
        if unitReached(MissionFunctionTable[7][11], "citadell", 50) == true then
			nextStep(eStateSavedCentrail)
        end
        if unitReached(MissionFunctionTable[7][11], "beanstalk", 50) == true then
			nextStep(eStateSavedCentrail)

        end


        return stillAlive(MissionFunctionTable[7][11]) == false
    end
	
	if missionStepAndTime(frame, eStateSavedCentrail) then
		--[23:15:04] <Pica> The Carryr, sets out to search for a cure, by finding a example of the "forbidden" fruit.
	
	end
	
    --[[

[22:25:46] <Pica>  and the centrial player gets news, that a citadell too <direction> has fallen
[22:26:14] <Pica> One final decal "She is infected. Please!"
[22:26:25] <Pica> inb4 sc2 copycat
[22:27:42] <Pica> Enter the story as game-mechanic- the centrail player can now command the Carrying guy. But he is weak. He needs many movecommands to make some steps. And he is loosing health, with every step.
[22:27:52] <Pica> Resting, regains a part of that health- slowly.
[22:28:07] <Pica> The Journeyman, has the target to capture them - and bring them too the beanstalk.
[22:36:55] ** Code_Man hat den the channel verlassen (Connection timed out).
[22:47:36] <Pica> Journeyman  Victory is Mision Win Journeyman
[23:00:42] <Pica> the couple makes it to the first ring of base defense 
[23:01:18] <Pica> And the Centrail Forces have a shism..
[23:01:44] <Pica> The Inner Circle, around the citadell turns against the loyal outer circle-
[23:02:38] <Pica> The Outercircle must hurry, to regularly bring infantry towards the citadell.. to prevent the besieged administrator (The Player) in the building from beeing killed
[23:12:35] <Pica> To halt the transformation for a time- the couple must reach a research station, holding a neutrino free cage. Only this can prevent the bio-nanotech of the journey entangling and completing the transformation.
[23:13:01] <Nightwatch> <DeinFreund> wat
[23:13:24] <Pica> If the Journeys arrive on a planet- strange things start to happen.
[23:13:36] <Pica> Fruits fall from the sky, and if you eat them- you will change
[23:14:05] <Pica> the biotech will make you one of them- part of the cyclic collective.
[23:14:16] <Pica> Like a Choir of Jazzsolists

[23:15:05] <Pica> He relates the planets inhabitants story. "They where quite advanced mamals, almost made it to the fusion."
[23:15:05] <Pica> "They where divided into several mental subcastes, they concluded at the onset of the surplus where mental illnesses."
[23:15:05] <Pica> "They had one they used to uphold there sex for food trade contracts for life."
[23:15:05] <Pica> "They had one that allowed them to overcome the plagues that ravaged there civilisation- creating paranoid groups and spreading resistant populations."
[23:15:05] <Pica> "They had a murderous caste of bloodlust"
--When all ressources where used up, there by the surplus held back nature returned, and spiraled them into a devolution, they returned into ever tighter loops
--nature had all the time in the world to develop counter-measures against civilisation-
--there world become a hostile wasteland of evolutionary developed counter measures
--and became animals again- a much less energy intensive state to follow your 
--its the comon end of species across the 
-- Having the journeys come to this locked in dead world is a mercy.


[23:15:44] <Pica> The Centrial Loyalists are defeated, by the Adminstration loyalists.
[23:15:52] <Pica> And thus the final act begins.
[23:16:45] <Pica> Presuming the Centrail troops infected, and the system to be a lost cause, the Centrail ups the game, and injects a blackhole into one of the two suns of the twin star system.
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
	