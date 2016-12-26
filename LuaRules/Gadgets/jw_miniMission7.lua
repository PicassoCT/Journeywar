
	function missionStepAndTime(expectedStep, Time)
		if not Time then
			return MissionFunctionTable[7][3] == expectedStep 
		end
		if expectedStep and Time then
			return MissionFunctionTable[7][3]== expectedStep and frame-MissionFunctionTable[7][2] > Time 
		end
	end
	
	function nextStep()
		MissionFunctionTable[7][3] =MissionFunctionTable[7][3] + 1
	end
	
	function Misson7InFairAndLoveEverythingIsWar(frame)

		if MissionFunctionTable[7][2]== nil then MissionFunctionTable[7][2]=frame end
		if MissionFunctionTable[7][3]== nil then 
			MissionFunctionTable[7][3]= {}
			MissionFunctionTable[7][3]= 1
		end
		
		
		if missionStepAndTime(1) then 
			
			nextStep()
			return false
		end
		
		--[[
		22:24:04] <Pica> the man and the woman collapse- lying on the ground as if dead
[22:24:32] <Pica> Every side, rushes for the transport, because they want to get the container left behind by every crashing transport
[22:25:13] <Pica> decals appear in the Sand "Help Us" - where the couple Vannished.
[22:25:23] <Pica> "I was in Administration too"
[22:25:46] <Pica>  and the centrial player gets news, that a citadell too <direction> has fallen
[22:26:14] <Pica> One final decal "She is infected. Please!"
[22:26:25] <Pica> inb4 sc2 copycat
[22:27:42] <Pica> Enter the story as game-mechanic- the centrail player can now command the Carrying guy. But he is weak. He needs many movecommands to make some steps. And he is loosing health, with every step.
[22:27:52] <Pica> Resting, regains a part of that health- slowly.
[22:28:07] <Pica> The Journeyman, has the target to capture them - and bring them too the beanstalk.
[22:36:55] ** Code_Man hat den the channel verlassen (Connection timed out).
[22:47:09] <Pica> The kitch kills the cool kids first - always - what a hippster way to go.
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
[23:15:04] <Pica> The Carryr, sets out to search for a cure, by finding a example of the "forbidden" fruit.
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
		if MissionFunctionTable[7][3] > 12 then
			
			CentrailSpeech=
			"Gone are the barbarians- now true civilization can start."
			T=prepSpeach(CentrailSpeech, Name,charPerLine, Alpha, DefaultSleepByline)
			say(T,25000, NameColour, TextColour,OptionString,UnitID)
			spPlaySound("sounds/Missions/missionBriefing.ogg",1)
			return true
		end
		
		return false
	end
	