--Apocalypso
evTeam=Spring.GetGaiaTeamID()

function spawnResistance(nrOfCellPairs)
		sizeX=Game.mapSizeX
		sizeZ=Game.mapSizeZ
		div=4
		
		
		while div < 64 do
			dec=math.ceil(math.random(2,div))
			x,z=dec*(sizeX/div),dec*(sizeZ/div)
			ox,oz=sizeX- (dec*(sizeX/div)),sizeZ-(dec*(sizeZ/div))
			
			if math.random(0,1)==1 then --mirrortime
				x=sizeX-x
				ox=-ox+SizeX
			end
			div=div*2
			Spring.CreateUnit("gresistance",x,0,z,1, evTeam)
			Spring.CreateUnit("gresistance",ox,0,oz,1, evTeam)
			Spring.CreateUnit("jmadmax",ox,0,oz,1, evTeam)
		end
	end
	
	
	function Misson6ResistanceIsFutile(frame)
	
		if true then return true end -- TODO Complete
		
		--SetUp
		if MissionFunctionTable[6][2]== nil then MissionFunctionTable[6][2]=frame end
		if MissionFunctionTable[6][3]== nil then 
			MissionFunctionTable[6][3]= {}
			MissionFunctionTable[6][3]= 0
		end
		
		
		mT=frame - MissionFunctionTable[6][2]
		if MissionFunctionTable[6][3] == 0 and mT > 9200 then
			--Welcome speach
			welcomeSpeech= "Good Morning, citizen of Dimension C137, Sector 5, Planet C. Its been roughly 100 000 years since you, during the 3rd toaster Coupe de Etat, dropped out of the universal portal net, so we dropped by for some society reconstruction and -connecting. That was three weeks ago. Since then it has been nothing but relentless attacks on us and recovering Centrail Installations. Its was all very amusing, especially the self-flaggelation for \" loosing the the machine god in the sky \" but the novellty wears off fast. If it were not for some fancy virus, nesting near the location of your portal adress."
			
			MissionFunctionTable[6][3] =MissionFunctionTable[6][3] +1
			return false
		end
			
			--Thread speach
		if MissionFunctionTable[6][3] == 1	then
			ThreadSpeech= "Citizen of Dimension C137, Sector 5, Planet C, this is your final warning. If you do not cease hostilitys, we will be forced to eradicate you. There will be no reminders of your existance, no memorials, no museums, no archeological evidence, just a finite moment of pain and then nothingness for the whole planet."..
			"To proof that your resistance and its end, are not the first to happen, a 2000 ton memorial dimaond has been teleported into orbit, fashioned from the citizens of the resisting worlds Belize, Arr 'Nathar and Kloruuk. Youre sad remains shall become another layer  shall be added to this if you dont alter your ways."
			
			x,z= Game.mapSizeX/2,Game.mapSizeZ/2
			
			id= Spring.CreateUnit("gdiamonddeath",x, 0, z, 1, evTeam)
			
		end
			
			
		if 	MissionFunctionTable[6][3] == 2 then		
			-- Thread wasted (They are all so stupid and im there chieftain)
			genocideMission = "There it sits, and they just ignore it. A fine speech, a fine stone wasted on a planet of animals. Great advice, by my council of abstracts here, real solid, thank you guys and girls. Okay, Administrator, they are this stupid and im there chieftain- so lets clean this up. Destroy it all. Wipe them out. Get the rock back into orbit. Build something nice, quiet. A park, or some appartments."
			
			
			
		end
			
			
			
			-- Diamond of Death
			
			
			
			-- Genocide - erradicate all native Villages and research stations
			-- Cleanup
			
			-- Errect Luxerybuildings 
			
			-- Another glorious day for the empire
		

		return false
	end
	