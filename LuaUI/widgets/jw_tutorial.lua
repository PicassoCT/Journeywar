
function widget:GetInfo()
	return {
		name      = "Tutorial",
		desc      = "Save the Noobs",
		author    = "A Noob to far",
		version   = "v1.1",
		date      = "Jul 18, 2009",
		license   = "GNU GPL, v2 or later",
		layer     = 3,
		enabled   = Spring.GetConfigInt("jwfirststartup",1)	>1  --  loaded by default?
	}
end

--Text

Text1= "If i ran a zoo, i would gladly take the best your dimension has to offer."..
	"But i dont, and you dare! A freakin insult to the CCA, every moment your breath whatever gases you vegetate on"..
	"Every half-sane creature would crawl, stumble and fall away from this, but you wont, like a moth loving fire."..
	"you delude yourself, you are the exception, the choosen animal in shitted trousers to overcome all of cruel natures limits"..
	"Boy have i got news for you. You wont - not with implants, not through introspection, and you are painting over realitys pain this very moment."..
	"You are patriotic- not just unable to question authority as base-instinct fears your offsprings future in a infight"..
	"You are faithfull- not just gluing your mental cardhouse with yesterdays propabilitys"..
	"You are progressive and running away with technology from the inability to discipline yourself"..
	"This Force has a zero-Shit-policy. You mess up once, we kill you! And messing up you will"..
	"Your body is assymetric, your hive queen inbreeds only with the weakest males!"..
	"Generic Insult Generator Exception! OH SHIT!" .."(FiringSquadSound)"..
	"No need tobe shocked, recruits! In the City they line up for every post from the roast"..
	"So lets roll. You got your citadell.. Get a construction depot up. Move it! I´ll explain things as we move.."


---------------------------------------------------------------------------
-- Speedups
---------------------------------------------------------------------------


local spGetMouseState = Spring.GetMouseState
local spGetActiveCommand = Spring.GetActiveCommand
local spGetDefaultCommand = Spring.GetDefaultCommand
local spGetModKeyState = Spring.GetModKeyState
local spGetSpecState = Spring.GetSpectatingState
local spGetMyTeamID = Spring.GetMyTeamID
local spGetVisibleUnits = Spring.GetVisibleUnits
local spGetUnitPos = Spring.GetUnitPosition
local spTraceScreenRay = Spring.TraceScreenRay
local spGetSelUnits = Spring.GetSelectedUnitsSorted
local spSelUnitArray = Spring.SelectUnitArray
local spGetUnitDefID = Spring.GetUnitDefID

local Tutorial={}
---------------------------------------------------------------------------
-- Code
---------------------------------------------------------------------------
local teamID=spGetMyTeamID()
local spPlaySoundFile=Spring.PlaySoundFile

tbg			= "Take the best offworlds. Chop limbs, strap implants, make them walk, talk, patroll and die for there adminis-traitor. This is your infant-try"
tcss		= "These once were journeyman. We cloned them, implanted citizenbrains and now fight Fire with Fire."
tmtw		= "Call a infantry-raid. Cheap, fast, drop on the spot. Get your money back, if not deadly."
tcitadell	= "Here resides your administration, and its high plans. Use construction units to keep them real."
tcontruck	= "Can they fix it? Yes, they can, yes, they will! They may bitch, hitch and howl, but they shall."
tcondepot 	= "Builds construction units, which in turn create your outpost. Chicken and Egg in one basket."
tmdigg 		= "Mother Earth dances for the Strip miner, ploughing the bitches ridges for holehidden valuables."
trestrictor = "Send them reeling in shock, for what crawls beneath the surface, cant stand this beat."
tsentrynell = "Guards the city, sight aint pretty, sentrys assure, no foe close his lure."
twallbuilder= "Draw a line, giving every enemy who sniffs 32 vortigaunts of electricity, a headache."
theadlauncher= "Off with there overhead, revive them, and in constant agony, shoot there kinshead back at thee."


TutorialInfoTable=
{
--Centrail

----Units

[UnitDefNames["bg"].id]={ active=false, delay=350,		text="\a|Black Guard\n Elite Overwatch Infantry."},
[UnitDefNames["mtw"].id]={active=false,  delay=350, text= "\a|Manned Transport Synth\nBuilds and deploys Infantry"},
[UnitDefNames["contruck"].id]={active=false,   delay=2350,text= "\a|Construction Truck\n Builds blueprints and repairs"},
[UnitDefNames["condepot"].id]={active=false,  delay=350,text= "\a|Construction Depot\nCreates Construction Units"},
[UnitDefNames["mdigg"].id]={active=false, delay=350, text="\a|Metalldiggester\nStripmines Material on Metallspots"},
[UnitDefNames["restrictor"].id]={active=false,  delay=350, text="\a|Restrictor Tank\nScout Tank with stationary Stunability"},
[UnitDefNames["css"].id]={active=false,  delay=350, text="\a|Combine Synth Soldiers\nFlamethrower Synth"},
[UnitDefNames["citadell"].id]={active=false,  delay=350,text="\a|Citadell\n Provides Construction blueprints"},
[UnitDefNames["csniper"].id]={active=false, delay=350,text="\a|Sniper\n Longrange Hunter - Can drag Trophys."},
[UnitDefNames["contrain"].id]={active=false, delay=350,text="\a|Construction Train\nBuilds blueprints "},
[UnitDefNames["ccomender"].id]={active=false, delay=350,text="\a|Comender\n You in a armed & armoured Suit. Memento Mori."},
----Buildings

[UnitDefNames["triggerzone"].id]={active=false,  delay=350,text="\a|Triggerzone\nTriggers the Actionzone it guards"},
[UnitDefNames["actionzone"].id]={active=false,  delay=350,text="\a|Actionzone\nStores commands for a guarding Reservoirezone"},
[UnitDefNames["reservoirzone"].id]={active=false, delay=350,text="\a|Reservoirezone\nTransfers commands to guarding Units"},
[UnitDefNames["scumslum"].id]={active=false,  delay=350,text="\a|Scumslum\nProduces Security budget"},
[UnitDefNames["campole"].id]={active=false, delay=350,text="\a|Propaganda pole\nConverts Materials to Security"},
[UnitDefNames["bbind"].id]={active=false, delay=350,text="\a|Industry\nRecycles Battlefield Remains"},
[UnitDefNames["cwaterextractor"].id]={active=false, delay=350,text="\a|Waterextractor\n Pumps water Off world increasing Security "},
[UnitDefNames["mestorage"].id]={active=false, delay=350,text="\a|Ressourcedepot\n Stores Material and Security assets"},
[UnitDefNames["builux"].id]={active=false, delay=350,text="\a|Luxery Appartment\n Attracts Fullcitizens increasing Material"},
[UnitDefNames["ctransithub"].id]={active=false, delay=350,text="\a|Transitnode\n Fast transfers Units between Citys"},
[UnitDefNames["fclvlone"].id]={active=false, delay=350,text="\a|Worldgate\n Orders Units Offworld"},
[UnitDefNames["fclvl2"].id]={active=false, delay=350,text="\a|Worldgate\n Orders Advanced Units Offworld"},
[UnitDefNames["cairbase"].id]={active=false, delay=350,text="\a|Airbase\n Builds& Maintains Airforce"},
[UnitDefNames["cdistrictnone"].id]={active=false, delay=350,text="\a|Slum\n  Investment return upon enemy destroying it"},
[UnitDefNames["buibaicity2"].id]={active=false, delay=350,text="\a|Arcology\n Returns funds upon burning down in public"},
[UnitDefNames["buibaicity1"].id]={active=false, delay=350,text="\a|Skyscraper\n Returns Insurance paid by the second last attacker"},
[UnitDefNames["crailgun"].id]={active=false, delay=350,text="\a|Railgun\n Long range base defence"},
[UnitDefNames["sentry"].id]={active=false, delay=350,text="\a|Sentry\n Short range defence"},
[UnitDefNames["bonker"].id]={active=false, delay=350,text="\a|Bunker\n Heavy Medium Range fortification"},
[UnitDefNames["chopper"].id]={active=false, delay=350,text="\a|Hoppermines\n Jumpy Mines"},
[UnitDefNames["coverworldgate"].id]={active=false, delay=350,text="\a|Overworldgate\n Autospawns expensive troops\n who attack the closest enemy"},
[UnitDefNames["comendbonker"].id]={active=false, delay=350,text="\a|Comenderdock\n Spawns the Comender"},
[UnitDefNames["paxcentrail"].id]={active=false, delay=350,text="\a|PaxCentrail\n Prisoner Chaingang fighting for their familys"},
[UnitDefNames["choblock"].id]={active=false, delay=350,text="\a|Hostage Blocks\n Familys forcing prisoners to fight"},

--Journeyman
----Unit
[UnitDefNames["hc"].id]				 ={active=false, delay=350,		 text="\a|Headcrab\n Turn Infantry into zombies"},
[UnitDefNames["zombie"].id]			 ={active=false, delay=350,		 text="\a|Zombie\n Follows the Food"},
[UnitDefNames["skinfantry"].id]	 	 ={active=false, delay=350,		 text="\a|Skinsuited Infantry\n Able to Ambush.\n Lays Eggs for Exp"},
[UnitDefNames["jskineggnogg"].id]	 ={active=false, delay=350,		 text="\a|Skinfantry Egg\n Grows into Skinfantry"},
[UnitDefNames["tiglil"].id]			 ={active=false,  delay=350, 	 text= "\a|Tigerlily \n Close Combatress with poisoned Blades"},
[UnitDefNames["jtigeggnogg"].id]	 ={active=false,  delay=350, 	 text= "\a|Tigerlily Egg\n Grows into a Tigerlily"},
[UnitDefNames["jmovingfac1"     ].id]={active=false , delay=350 	,text="\a|Firstborn DNA-Weaver \n Gives birth to basic Units"},
[UnitDefNames["jbeherith"		].id]={active=false , delay=350 	,text="\a|Beherith \n Amphibious Island stomping the small"},
[UnitDefNames["jeliah"			].id]={active=false  ,delay=350 	,text="\a|Eliah \n Born again Butterfly"},
[UnitDefNames["jtyrion"			].id]={active=false  ,delay=350 	,text="\a|Corrupted Unit \n Use Ability to change loyalty"},
[UnitDefNames["jinfector"		].id]={active=false  ,delay=350 	,text="\a|Infector \n Infiltrates nearby Factorys"},
[UnitDefNames["jresistancecell"	].id]={active=false  ,delay=350 	,text="\a|Resistance Cell \n Invulnerable if nearby slum"},
----Buildings
[UnitDefNames["jnativevil"      ].id]={active=false , delay=350 	,text="\a|Native Village \n Converts damage done by the enemy to light and matter"},
[UnitDefNames["jdrilltree"      ].id]={active=false , delay=350 	,text="\a|Drilltree \n Digs deep to provide matter"},
[UnitDefNames["eggstackfac"     ].id]={active=false , delay=350 	,text="\a|Eggstack \n Gives birth to construction units"},
[UnitDefNames["jtree"           ].id]={active=false , delay=350 	,text="\a|Tree \n Collects light"},
[UnitDefNames["jtree2"          ].id]={active=false , delay=350 	,text="\a|Wastelandtree \n Collects radiowaves"},
[UnitDefNames["jtree3"          ].id]={active=false , delay=350 	,text="\a|Watertree \n Collects light -regrows after destruction"},
[UnitDefNames["jtreel"          ].id]={active=false , delay=350 	,text="\a|Accidtree \n Stores Matter"},
[UnitDefNames["jtree2dummy"     ].id]={active=false , delay=350 	,text="\a|Tree \n Eats expensive ammunition & time."},
[UnitDefNames["jtreedummy"      ].id]={active=false , delay=350 	,text="\a|Tree \n Eats expensive ammunition & time."},
[UnitDefNames["jgeohive"        ].id]={active=false , delay=350 	,text="\a|Creepernest \n Spawns auto harassing Creepers"},
[UnitDefNames["jwatergate"      ].id]={active=false , delay=350 	,text="\a|Watergate \n Raises the maps waterlevel"},
[UnitDefNames["jfireflower"     ].id]={active=false , delay=350 	,text="\a|Fireflowers \n In case of fire drop dead were you stand "},
[UnitDefNames["jdragongrass"    ].id]={active=false , delay=350 	,text="\a|Dragongrass \n Trap gets Unit addicted"},
[UnitDefNames["jharbour"        ].id]={active=false , delay=350 	,text="\a|Harbour \n Raises the water level\n Produces Waterunits"},
[UnitDefNames["jbeehive"        ].id]={active=false , delay=350 	,text="\a|Beehive \n Defence using giant hornets"},
[UnitDefNames["jfungiforrest"   ].id]={active=false , delay=350 	,text="\a|Fungiforrest \n Deadly Fungi infect by Unittype"},
[UnitDefNames["jviralfac"       ].id]={active=false , delay=350 	,text="\a|Viralfactory \n Spawns Units from afar"},
[UnitDefNames["jvaryfoo"			].id]={active=false , delay=350 ,text="\a|Varyfoos \n One Feeding, many Breeding, \n ever needing, all debleeding"},
[UnitDefNames["jabyss"			].id]={active=false , delay=350 	,text="\a|Abyss \n The End of this world"},
[UnitDefNames["jjamforrest"			].id]={active=false  ,delay=350 	,text="\a|Dense Djungle \n Blocking Radar"}

}

boolAllreadyDeacitvatedOnce=false


function widget:Initialize()	
	if Spring.GetSpectatingState() or Spring.IsReplay() then
	widgetHandler:RemoveWidget()
	end
	val=Spring.GetConfigInt("jwfirststartup",1)	
	Spring.SetConfigInt("jwfirststartup",val+1 )
		

	--if EnviromentVariable is allready set
		--
	mouseX,mouseY=Spring.GetMouseState()
	types,tables=spTraceScreenRay(mouseX,mouseY)
	if types == "ground" then
	Spring.MarkerAddPoint(  tables[1], tables[2], tables[3], "Tutorialmarks can deleted using the /clearmapmarks \n Consolecomand", true)
	end
end


function widget:Shutdown()
	Spring.Echo("Deactivated Tutorial - you can reactivate via the Widget-Manager (Press F11)")
    --set Tutorial once activated Variable
	
end

boolTutorial=true


function widget:GameFrame(t)

if boolTutorial==true and t%100== 0 then
	
	
	for k,v in pairs(TutorialInfoTable) do

	if v.active == true then
	v.delay=v.delay-100
		if v.delay < 0 then
		PlaySoundAndMarkUnit(v.uDId,v.unitid)
		end
	end
	end
	
	for k,v in pairs(TutorialInfoTable) do	
		if v.active == true and v.delay < 0 then
		TutorialInfoTable[k]=nil
		end
	end
	
end
end

function PlaySoundAndMarkUnit(defID, exampleUnit)

x,y,z=spGetUnitPos(exampleUnit)
	if x then
	Spring.MarkerAddPoint(  x,  y,  z, TutorialInfoTable[defID].text, true)
	if TutorialInfoTable[defID].sound then
	Spring.PlaySoundFile(TutorialInfoTable[defID].sound,1)
	end
	end
TutorialInfoTable[defID]=nil
end

--The idea is simple - for one of every kind, at first gamestart, add a description on the map..
function widget:UnitCreated(unitID, unitDefID, unitTeamID, builderID)


	if  boolTutorial==true and TutorialInfoTable[unitDefID] then
	TutorialInfoTable[unitDefID].active=true
	TutorialInfoTable[unitDefID].unitid=unitID
	TutorialInfoTable[unitDefID].uDId=unitDefID
	
	end

end
