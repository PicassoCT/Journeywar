
function widget:GetInfo()
	return {
		name = "_Tutorial_",
		desc = "Save the Noobs",
		author = "A Noob to far",
		version = "v1.1",
		date = "Jul 18, 2009",
		license = "GNU GPL, v2 or later",
		layer = 3,
		enabled = (Spring.GetConfigInt("jwfirststartup",1)	< 3) -- loaded by default?
	}
end

--Text




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


tutorialSpeachInOrder={}
silentPlaceHolder=""

TutorialInfoTable= {
	--Centrail
	
	----BuildUnits
	[UnitDefNames["contruck"].id] = {text =  "\a|Construction Truck\n Errects buildings if guarding a\n construction-site \nusing its own HP."},
	[UnitDefNames["contrain"].id] = {text = "\a|Construction Train\n Realizes buildings and heals units nearby \nusing its own HP "},
	[UnitDefNames["conair"].id] = {text = "\a|Airborne Construction Synth\n Realizes buildings and drops infantry\nusing its own HP"},
	[UnitDefNames["mdigg"].id] = {text = "\a|Metalldiggester\nStripmines Material from metalspots.\nActivate to deploy."},
	
	--fclvl1
	
	[UnitDefNames["mtw"].id] = {text =  "\a|Manned Transport Wagon\nBuilds and deploys Infantry or Flamethrower Synths"},
	[UnitDefNames["advisor"].id] = {text = "\a|Advisor\nExtracts Information from captured Units"},
	[UnitDefNames["campro"].id] = {text = "\a|Antimatter Projector\nFires energy expensive, slow -deadly Anti-Matter projectiles"},
	[UnitDefNames["restrictor"].id] = {text = "\a|Restrictor Tank\nScout Tank with stationary Building Stunability"},
	[UnitDefNames["csniper"].id] = {text = "\a|Sniper\n Longrange Hunter - Can drag Trophys to Industry."},
	[UnitDefNames["css"].id] = {text = "\a|Combine Synth Soldiers\n Can torch flameable material"},
	[UnitDefNames["bg"].id] = {text = "\a|Overwatch Infantry\nCan deploy tactical shields to reduce damage."},
	[UnitDefNames["cgamagardener"].id] = {text = "\a|Gammagardener\n Sterilizes Exobiotics Fauna in area with radiation."},
	[UnitDefNames["coffworldassemblyseed"].id] = {text = "\a|Offworld Assembly Seed\n Create a new Offworld Assembly of forbidden units."},
	
	--fclvl2
	[UnitDefNames["coperatrans"].id] = {text = "\a|Opera Transport \n"..
												 " Transports Units or the spoils of war.\n"..
												 " Provides Income for nearby entertaiment(battles).\n"..
												 " Is costly while attacked. "},
	[UnitDefNames["art"].id] = {text = "\a|Artillery\nShells the enemy with either headcrabs or darkmatter projectiles "},
	[UnitDefNames["sentrynell"].id] = {text = "\a|Sentrynell\nExtreme Long Range Anti-Air. Deploys sentrys in view direction\n while standing still."},
	[UnitDefNames["cwallbuilder"].id] = {text = "\a|Wallbuilder\n Errects Defense structures. Flatens Terrain and powers electric fences."},
	[UnitDefNames["cheadlauncher"].id] = {text = "\a|Headlauncher\n Provokes enemy into direct attacks.\nInvurnerable for up to three units in close combat."},
	
	--cairbase
	
	[UnitDefNames["chunterchopper"].id] = {text = "\a|Hunterchopper\n Multi role Airunit."},
	[UnitDefNames["csuborbital"].id] = {text = "\a|Suborbital Bombardment\n Launches to Orbit.\n Bomards Ground "},
	[UnitDefNames["cgunship"].id] = {text = "\a|Gunship Synth\n Heavy Air-Ground Assault Unit."},
	[UnitDefNames["callygator"].id] = {text = "\a|Allygator\n Snatches small ground Units with a portal.\n Devoured units become material income."},
	[UnitDefNames["ccomender"].id] = {text = "\a|Comender\n You in a armoured Suit. Death equals Game Over."},
	
	----Buildings
	
	[UnitDefNames["citadell"].id] = {text = "\a|Citadell \n Plans your base.\n Needs a Construction Depot\n to realize them"},
	[UnitDefNames["condepot"].id] = {text =  "\a|Construction Depot\n Creates Construction Units\n Should guard/support a citadel"},
	[UnitDefNames["triggerzone"].id] = {text = "\a|Triggerzone\nTriggers the Actionzone it guards"},
	[UnitDefNames["actionzone"].id] = {text = "\a|Actionzone\nStores commands - transfers comamnds on trigger to any guarding Reservoirezone"},
	[UnitDefNames["reservoirzone"].id] = {text = "\a|Reservoirezone\nTransfers commands to guarding Units"},
	[UnitDefNames["scumslum"].id] = {text = "\a|Scumslum\nIncreases Security budget"},
	[UnitDefNames["campole"].id] = {text = "\a|Propaganda pole\nConverts Materials to Security"},
	[UnitDefNames["bbind"].id] = {text = "\a|Industry\nRecycles Battlefield Remains"},
	[UnitDefNames["cwaterextractor"].id] = {text = "\a|Waterextractor\n Pumps water Off world increasing Security"},
	[UnitDefNames["mestorage"].id] = {text = "\a|Ressourcedepot\n Stores Material and Security"},
	[UnitDefNames["builux"].id] = {text = "\a|Luxery Appartment\n Fullcitizens provide a constant Materialincome"},
	[UnitDefNames["ctransithub"].id] = {text = "\a|Transitnode\n Fast transfers Units between two Transitnodes"},
	[UnitDefNames["fclvl1"].id] = {text = "\a|Worldgate\n Orders small units Offworld"},
	[UnitDefNames["fclvl2"].id] = {text = "\a|Coregate\n Orders advanced and experimental Units at the core world"},
	[UnitDefNames["cairbase"].id] = {text = "\a|Airbase\n Builds & maintains Airforce"},
	[UnitDefNames["cdistrictnone"].id] = {text = "\a|Slum\n Self replicating Investment return upon enemy destroying it"},
	[UnitDefNames["smconverter"].id] = {text = "\a|Arcology\n Converts Security to Material\n Returns funds upon burning down in public."},
	[UnitDefNames["buibaicity1"].id] = {text = "\a|Skyscraper\n Returns Insurance paid by the second last attacker"},
	[UnitDefNames["crailgun"].id] = {text = "\a|Railgun\n Long range base defence"},
	[UnitDefNames["sentry"].id] = {text = "\a|Sentry\n Rapid fire short range anti-infantry defence"},
	[UnitDefNames["bonker"].id] = {text = "\a|Bunker\n Heavy Anti-Air fortification with medium range"},
	[UnitDefNames["chopper"].id] = {text = "\a|Hoppermines\n Personal Mines"},
	[UnitDefNames["coverworldgate"].id] = {text = "\a|Overworldgate\n Autospawns expensive A.I. controlled troops"},
	[UnitDefNames["comendbonker"].id] = {text = "\a|Comenderdock\n Spawns the Comender Hero Unit"},
	[UnitDefNames["paxcentrail"].id] = {text = "\a|PaxCentrail\n Fullcitizen Prisoner Chaingang fighting for their familys survival"},
	[UnitDefNames["choblock"].id] = {text = "\a|Hostage Blocks\n Fullcitizen Dissenter familys taken hostage"},
	
	--Journeyman
	----Unit
	
	----BuildUnits
	
	[UnitDefNames["jconroach"].id] = {text = "\a|Roach\n Constructs buildings by sacrificing itself."},
	[UnitDefNames["jconcaterpillar"].id] = {text = "\a|Roach\n Constructs buildings by sacrificing itself."},
	[UnitDefNames["hc"].id] = {text = "\a|Headcrab\n Turn Infantry into zombies"},
	[UnitDefNames["zombie"].id] = {text = "\a|Zombie\n Trying to eat the living"},
	[UnitDefNames["skinfantry"].id]	 = {text = "\a|SkInfantry\n Able to Ambush.\n Reproduce with Experience by laying Eggs"},
	[UnitDefNames["jskineggnogg"].id] = {text = "\a|SkInfantry Egg\n Grows into Skinfantry"},
	[UnitDefNames["tiglil"].id] = {text =  "\a|Tigerlily \n Close Combatcreature with poisoned Nailbladeclaws"},
	[UnitDefNames["jtigeggnogg"].id] = {text =  "\a|Tigerlily Egg\n Grows into a Tigerlily"},
	[UnitDefNames["jmovingfac1"].id] = {text = "\a|Firstborn DNA-Weaver \n Gives birth to basic Units"},
	[UnitDefNames["jbeherith"].id] = {text = "\a|Beherith \nAmphibious Island able to transport units and \ngo into a Amokstampede"},
	[UnitDefNames["jeliah"].id] = {text = "\a|Eliah \n Born again Laserbutterfly"},
	[UnitDefNames["jghostdancer"].id] = {text = "\a|Ghostdancer \n Scout and harassing unit.\n Backtracks on damage"},
	[UnitDefNames["jhivewulfmoma"].id] = {text = "\a|Hivehounds \n Ground swarm unit"},
	[UnitDefNames["vort"].id] = {text = "\a|Vortigaunt \n Teleporting Alien warrior"},
	[UnitDefNames["jantart"].id] = {text = "\a|Firt Anthill \n Artillery firing ant-weddings"},
	[UnitDefNames["jhunter"].id] = {text = "\a|Huntersynth \n Strike and Retreat unit."},
	[UnitDefNames["jglowworms"].id] = {text = "\a|Glowflys \n Can spawn a swamp, that respawns them."},
	[UnitDefNames["jshroudshrike"].id] = {text = "\a|Shroudshrike \n Transfers Experience from the enemy to units nearby"},
	[UnitDefNames["jswiftspear"].id] = {text = "\a|Swiftspear \n Abducts enemy units, rapes them, creating little swiftspears"},
	[UnitDefNames["jhoneypot"].id] = {text = "\a|Honeypot \n Explosive suicide unit"},
	[UnitDefNames["jatlantai"].id] = {text = "\a|Atlantai \n Energy stealing Airunit"},
	[UnitDefNames["jmotherofmercy"].id] = {text = "\a|Mother of Mercy \n Rips Asteroids from the ground, and drops them on opponents."},
	[UnitDefNames["jsempresequoia"].id] = {text = "\a|Sempre Sequoia \n Fires lasers at enemys.\n Regenerates once rooted."},
	[UnitDefNames["jrecycler"].id] = {text = "\a|Vicious Cycler \n Recycles the living and the dead from afar."},
	[UnitDefNames["jsunshipwater"].id] = {text = "\a|Sunship \n Collects Water, then ignites into a microsun, burning all in its path."},
	[UnitDefNames["jplanktoner"].id] = {text = "\a|Plank Toner \n Anti-Air Algea"},
	[UnitDefNames["jtyrion"].id] = {text = "\a|Corrupted Unit \n Use Ability to toggle loyalty"},
	[UnitDefNames["jinfector"].id] = {text = "\a|Infector \n Infiltrates nearby Factorys\ncreating coruppted units"},
	[UnitDefNames["jresistancecell"].id] = {text = "\a|Resistance Cell \n Invurnerable if nearby slum"},
	----Buildings
	
	[UnitDefNames["beanstalk"].id] = {text = "\a|Beanstalk \n Creates other buildings. Needs a Eggstack to grow them out."},
	[UnitDefNames["jnativevil"].id] = {text = "\a|Native Village \n Converts damage done by the enemy to light and matter"},
	[UnitDefNames["jdrilltree"].id] = {text = "\a|Drilltree \n Digs deep to provide matter\n Creates constant high background radiation"},
	[UnitDefNames["jtransportedeggstack"].id] = {text = "\a|Eggstack \n Gives birth to construction exobiotics"},
	[UnitDefNames["jtree1"].id] = {text = "\a|Tree \n Collects light"},
	[UnitDefNames["jtree5"].id] = {text = "\a|Skyhooktree \n Collects light, locally inverts Gravity "},
	[UnitDefNames["jtree2"].id] = {text = "\a|Dreamtree \n Collects light - thrives with radiation\nTransforms nearby units"},
	[UnitDefNames["jtree3"].id] = {text = "\a|Watertree \n Collects light - regrows with delay after fire"},
	[UnitDefNames["jtreel"].id] = {text = "\a|Accidtree \n Collects light, stores matter - corrodes all other live nearby"},
	[UnitDefNames["jgeohive"].id] = {text = "\a|Creepernest \n Spawns AI controlled Creepers"},
	[UnitDefNames["jbonsai"].id] = {text = "\a|Mountainrange \n Defense able to raise Waterlevels"},
	[UnitDefNames["jwatergate"].id] = {text = "\a|Watergate \n Raises the global waterlevel"},
	[UnitDefNames["jfireflower"].id] = {text = "\a|Fireflowers \n Sets itself ablaze if a enemy is nearby"},
	[UnitDefNames["jdragongrass"].id] = {text = "\a|Dragongrass \n Injects a addicting drug into enemies"},
	[UnitDefNames["jharbour"].id] = {text = "\a|Harbour \n Gives birh to water units"},
	[UnitDefNames["jbeehive"].id] = {text = "\a|Beehive \n Defence using giant hornets"},
	[UnitDefNames["jfungiforrest"].id] = {text = "\a|Fungiforrest \n Fungiplague infect and kill timedelayed all of Unittype they come in contact with"},
	[UnitDefNames["jviralfac"].id] = {text = "\a|Viralfactory \n Breeds spores that create Units from a distance"},
	[UnitDefNames["jvaryfoo"].id] = {text = "\a|Varyfoos \n One Feeding, many Breeding, \n ever needing, all debleeding"},
	[UnitDefNames["jabyss"].id] = {text = "\a|Varyfoo Abyss \n Spawns worldconsuming xenobiotics"},
	[UnitDefNames["jjamforrest"].id] = {text = "\a|Fog Djungle \n Obstructing enemy detector units"},
	--waterunits
	[UnitDefNames["jfishswarm"].id] = {text = "\a|Fishswarm \n Attack Land and waterunits"},
	[UnitDefNames["jgalatea"].id] = {text = "\a|Firegalatea \n Shoots gluemines at nearby landenemies."}
	
}

function preProcesTutorialInfoTable()
	for k,v in pairs(TutorialInfoTable) do
		if not TutorialInfoTable[k].active then TutorialInfoTable[k].active = true end
		if not TutorialInfoTable[k].Time then TutorialInfoTable[k].Time = 100 end
		if not TutorialInfoTable[k].speach then TutorialInfoTable[k].speach = silentPlaceHolder end
	end
end

function widget:GameStart()
	preProcesTutorialInfoTable()
	val=Spring.GetConfigInt("jwfirststartup",1)	
	Spring.SetConfigInt("jwfirststartup",val+1 )
	
	if Spring.GetSpectatingState() or Spring.IsReplay() or val > 2 then
		widgetHandler:RemoveWidget()
	end
	
	
	
	--if EnviromentVariable is allready set
	--
	mouseX,mouseY=Spring.GetMouseState()
	types,tables=spTraceScreenRay(mouseX,mouseY)
	if types == "ground" then
		Spring.MarkerAddPoint( tables[1], tables[2], tables[3], "Tutorialmarks can deleted using the /clearmapmarks \n Consolecomand", true)
	end
end

function widget:Initialize()	
	if Spring.GetGameFrame() > 0 then
		preProcesTutorialInfoTable()
		Spring.Echo("Reinitailizing tutorial")
		Spring.SetConfigInt("jwfirststartup", 1 )
	end
end


function widget:Shutdown()
	Spring.Echo("Deactivated Tutorial - you can reactivate via the Widget-Manager (Press F11)")
	Spring.SetConfigInt("jwfirststartup",3 )
	--set Tutorial once activated Variable
	
end

boolTutorial=true



function widget:GameFrame(t)
	if t% 5 == 0 then
		selectedUnits =Spring.GetSelectedUnits()

		for num, id in pairs(selectedUnits) do
		defID =Spring.GetUnitDefID(id)
		if defID then
			if TutorialInfoTable[defID] and TutorialInfoTable[defID].active and TutorialInfoTable[defID].active == true then		
				PlaySoundAndMarkUnit(defID, id)
				TutorialInfoTable[defID].active = false
			end
			end	
		end
	end
end


function PlaySoundAndMarkUnit(defID, exampleUnit)
	
	x,y,z=spGetUnitPos(exampleUnit)
	if x then
		Spring.MarkerAddPoint( x, y, z, TutorialInfoTable[defID].text, true)
		if TutorialInfoTable[defID].speach then
			Spring.PlaySoundFile(TutorialInfoTable[defID].speach,1)
		end
	end
end

