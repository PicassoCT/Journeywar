-- In-game, type /luarules kpai in the console to toggle the ai debug messages

function gadget:GetInfo()
    return {
        name ="Mentor AI:  Tutorial",
        desc ="Loads and runs a Tutorial",
        author ="Picassora",
        date ="around since last tuesday",
        license ="Licensed under the Recursive License:"..
		"a) Every version drafted, has a completely diffrent license then all its predecessors"..
		"b) Include all previous licenses"..
		"c) Fullfills all conditions of the previous licenses",
        layer = 82,
        enabled = true
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_jw.lua")

    gaiaTeam = Spring.GetGaiaTeamID()
    tutorialMapName ="Ravenholm"
	function getStartScript(playerName, tutorialMapName)
    return "[game]"..
					"{"..
					"[allyteam1]"..
					"{"..
					"numallies=0;"..
					"}"..
					"[team1]"..
					"{"..
					"teamleader=0;"..
					"allyteam=1;"..
					"}"..
					"[ai0]"..
					"{"..
					"shortname=Mentor AI: Tutorial;"..
					"name=AI: Mentor AI: Tutorial;"..
					"team=1;"..
					"host=0;"..
					"}"..
					"[modoptions]"..
					"{"..
					"maxspeed=20;"..
					"}"..
					"[allyteam0]"..
					"{"..
					"numallies=0;"..
					"}"..
					"[team0]"..
					"{"..
					"teamleader=0;"..
					"allyteam=0;"..
					"}"..
					"[player0]"..
					"{"..
					"team=0;"..
					"name="..playerName"..;"..
					"}"..
					"mapname="..tutorialMapName..";"..
					"myplayername="..playerName..";"..
					"ishost=1;"..
					"gametype=Journeywar $VERSION;"..
					"nohelperais=0;"..
					"}"
	end				

    function gadget:Initialize()
		if not Game.mapName == tutorialMapName then
			playerList = Spring.GetPlayerList()
			for playerID, _ in pairs(playerList) do
				name,active,spectator,teamID,allyTeamID,pingTime,cpuUsage,country,rank	= 	Spring.GetPlayerInfo(playerID)	
				teamID, leader,  isDead,  isAiTeam,  side, allyTeam,  customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(teamID)
			
				if not isDead and not isAiTeam and name ~= "" and not spectator and rank < 250 then
					Spring.Reload (	getStartScript(name, tutorialMapName))
					return
				end
			end		
		end	
    end

   function said(actor, line)

   end
	
	persPack= {}
-- Actors:
-- D Senator Daridov		 	- Exiled from his city-family, hates the slow-lifes and all who dwell in it.
-- A Senator Alynn     		- Wants to observe your performance, secretly in a org that supports sentient life. Avoids the city by mission hopping.
	
	currentlyActiveObjective = {["start"]=true }
	objectives={
	["start"] = function(frame, framesSinceLastCall ) 
		if not persPack["start"] then  persPack["start"] = {startframe= frame} end
		boolObjectiveCompleted=false	
		said(Alynn, "Easy, easy. Give the Host-body time to accomodate the mind.".. 
			    "There may  still be residual side-effects, like"..
		            " the delusions of beeing a player in a game of sorts. Take".. 
                            " your time.")
		
		said(Daridov, "Oh, please Senator Alynn, pity for the altitude-sick on Mt".. 
"Aspiration? Get on with it! Administrator, in the top right corner of  the battlefield "..
" visualisationdisplay, you will find the meters for Security-budget and Material-budget.".. 
" If you memorize them as the ressource you pay ingame-bills with, you might get a treat.")

		said(Alynn, "Ever the cruel jerk, Daridov.")
		said(Daridov, "I literaly spend forever, stuck in this travesty of a job,".. 
"teaching slow-lifeforms. Which may aswell know how much i despise them. Im sorry, mum ".. 
"and daddy are arguing, but that still means we love you-")
		said(Alynn,
		"Administrator, we are abstracts, fullcitizens without bodies, assigned to "..
"introduce you to the adminstration interface and duties. Its nice to meet you.")
		said(Daridov,  "Squeeze the chumming up whore button, if you need more ".. 
"redundant information. Anyway, the glorious war is over- it lasted 0.29 percent of the".. 
"planets rotation. Now lets hand out some shinys for useless heroism, and start reorganizing ".. 
"this hellhole-")
		said(Alynn,  "We want to help-")
		said(Daridov, "No, we want to terrorize into obedience, then turn the fear,".. 
			"by sock-puppet liberation into loyalty. ")
		said(Alynn, "Lets start it slow, we need to errect some buildings to house ".. 
  " the population. Select the citadell and build 3 highrises and a camera pole."..
" The construction units need to guard the citadel, who holds all your plans.")
		said(Daridov, 	"All the ressources we dont store, are wasted by the empire."..
				" While we wait lets give you a short history of life -or as I call it -".. 
  				"retardation-physics. It adapts to the circumstances, and drags the circumstances".. 
				"down into the mud to its level.")
	said(Alynn,"Technology might provide the ilusion of control, change and decency. But after it runs out".. 
		   "of the easy gains- all the worlds develop the loop deformation.")
said(Daridov, "Ignore the bitter old bastard. Notice how our building vehicles are used up in the construction process?")
	
				
			boolObjectiveCompleted=true	
		return boolObjectiveCompleted, "energy_economy"
	end,		
	
	["energy_economy"] = function(frame, framesSinceLastCall ) 
		if not persPack["energy_economy"] then  persPack["energy_economy"] = {startframe= frame} end
		
		end
-- ["start"]	

-- [WaitForObjectiveAccomplished]
-- A "Used up vehicles need to be replaced by new ones. Stop depressing him Daridov."
-- D "The deformation produces specializations adapted to the  wheel of overpopulation, war and reconstitution. Its god-given written into the law of gut, to stray from it, is heresy and any ruler to do so, clings to power by fear alone. A normal chieftain is basically just adapting to the loop-circumstances at the top of the food-chain. Good is to overproduce ressources against exponential growing consumption, evil is to prevent the loading of the genetic-lottery-urn with all the tickets you could reproduce. We stop that, we hold the wheel, we are evil, we are the combine-"
-- A "Justification, its necessary if you do monstrous things. Remember the bridge over the ridge of Kol'Thor 4, Daridov?"
-- D "Lets build a Condepot, so we can replenish our Constructor Units. And i fondly do, Alynn!"
-- ["condepot_construction"]
-- [WaitForObjectiveAccomplished]

-- A "You dstroyed theire whole culture!"
-- D "Theire culture consisted of a ritual civil war, since the dawn of time. We build a damn from frozzen bodies to theire temple and torched the whole sorry affair. They now have peace, the quiet life. Im sure, theire children weap at night, because we took the chance to rot alive in some forsaken pit for the culture it brings."
-- A "Notice, how the housed citizens allow us to recive security budget from the Universal Union." 
-- D "Notice the casual avoidance- when challenged with facts. Creative accounting from the comons, the end of all meritocracy - and it works under constant surveilance. We need to secure the streets- build sentrys and a watchtower"
-- ["first_defense"]
-- [WaitForObjectiveAccomplished]

-- A "You may have noticed your funds fluctuating slightly- this is due to the dark-matter-reactor in the citadel, creating and consuming resources at a weak rate in regular intervals."
-- D "The citadel houses shield-generators, which can be used to protect a settlement, against intruders and enviromental hazards. It is - very expensive to use them. Give them a try."
-- ["activate_shield"]
-- [WaitForObjectiveAccomplished]

-- D "We need more heavy to create elements, everything up from carbon. Create three metalldiggester, and send them to mine up in the north of the city. Worthless rubble, but give it some guards - just do it."
-- A "Define Hyprocasy, deriding cultures while scanning there artifacts for a profit in the city. Or would be harvesting ressources for a black hole be closer to the truth?"
-- D "Multiple viewpoints that contradict, might sound insane, but they allow you to see them coming."
-- ["metalldigester"]
-- [WaitForObjectiveAccomplished]

-- D "Trouble steers outside the city.
-- S "Overwatch reporting! We have multiple exobiotic infestations closing in on the city fronteer. Requesting backup!"
-- D "The exobiotic pest, plaguing other centrail-dimensions, has already arrived, well hidden from our view- as just another form of hostile alien wildlife to migrate from the border dimensions."
-- A "Antlions! We need defensetowers, and restrictors deployed as thumpers, to drive them back."
-- D "You heard the hysteric one, get moving."
-- ["antlion_defense"]
-- [WaitForObjectiveAccomplished]

-- A "There is a option, we are legally bound to inform you."
-- D "Yes, you can leave the citadell, and enter the combat area, with your life at stake, by building a commender-dock. I highly recommend it- to become anhero. Seriously, build a unit-factory, this job is not easier by having more holes to breath through."
-- A "A airbase would be nice too."
-- ["unit_factory_air_base"]
-- [WaitForObjectiveAccomplished]

-- A "Now we can telport units in from other worlds at a moments notice. Time to relax and enjoy life."
-- D "All is easier, with some virtual drug-habbits, isn't it. And im the disgusting one."
-- A "This world will be peacefull."
-- D "Yeah, 314 world is the charm. Go out there and cut that infestation out. I wish we could download this degenerate into a commender."

-- ["kill_antlions]
-- [WaitForObjectiveAccomplished]

-- S "Overwatch here. The antlions where driven into a stampede by local insurgents, working from a Research station in the mountains and a town called 'Ravenholm'. Requesting further instructions."
-- D "Well, thats the easy part. Shell the headcrab out of that town. Be warned, there will be Zombies, for a while- we dont got to Ravenholm.
 -- At least our animal rights activists will not protest their usage, high as she is now. 
 -- I know what you think- this empire has seen better times."
   
-- ["shell_ravenholm"]
-- [WaitForObjectiveAccomplished]

-- A "Well, he is certainly right. Administrator, im not helping you too murder the innocent. But i can offer you a subtle way out- there is a 
-- traitor in the town, ralleying the people to make a last stand.
-- I want you to escort this truck with a men named grigori to ravenholm. He has protection gear and information so that the civilians may escape."
 
-- ["escort_pastor_gregori"]
-- [WaitForObjectiveAccomplished]

-- D "A suprisingly large part seems to have escaped. Which is good, because they never mattered in the first place. 
   -- What mattered is finally having caught a traitor, who is in for mandatory memory replacement. Alynn, do you have any final words?"
-- A "Long life the resistance?"
-- D "Not a suprise- we suspected you, ever since the vortigaunt uprising. But to throw ones existence away, for so little a reward, i would almost call it suicide. Send her to the city for trial."
-- D "As for you Adminis-traitor. I think we all learned a lesson here. I want you to find and bring me a men called Dr. Breen."

	
	
	
	}
	
	function missionStateMachine(frame, framesSinceLastCall)
		for objective, active in pairs(currentlyActiveObjective) do
			if active == true  then
				currentlyActiveObjective[objective] = objectives[objective](frame, framesSinceLastCall)
			end
		end
		for objective, active in pairs(currentlyActiveObjective) do
			if active == false then
				table.remove(currentlyActiveObjective, objective)
			end
		end
	end


    counter = 0
    total = 30 * 60 * 5
	lastCallFrame= 0
	
    function gadget:GameFrame(frame)
        if frame > 0 and frame % total == 0 then
				missionStateMachine(frame, frame- lastCallFrame )
				lastCallFrame= frame
        end
    end

    function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
 
    end




    function gadget:Shutdown()
        Spring.Echo("JW:: Mentor AI: Shuting down")
    end
end
