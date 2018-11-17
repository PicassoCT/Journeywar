function gadget:GetInfo()
	return {
		name = "UnitScriptPerformance",
		desc = "Spawns each Unit several times and measures performance costs",
		author = "Picasso",
		date = "12.02.1983",
		version = "the one we lost and found before garry came around",
		license = "(F.O.C.K.U.) Favours  for sexual favours to Original Creator  license ",
		layer = 666,
		handler = true,
		enabled = false
	}
end

if gadgetHandler:IsSyncedCode() then
	boolStartPerfMeasurement= false
	-------------------------------------
	-- Includes
	VFS.Include('scripts/lib_UnitScript.lua')
	VFS.Include('scripts/lib_jw.lua')
	
	---------------- SYNCED---------------
	-- Every Tests consists of a preparation function, called once and returning the handed over persistancepackage
	-- It also consists of a testFunction, which returns the testCompletness and the persistancepackage
	
	-- CONFIG --
	UnitTest = {}
	teamList = {}
	
	UnitNames = {"cit","ccontrain","css","cspc","csniper","campro","cadvisor","cgamagardener","crestrictor",
				"coperatrans","art","sentrynell","cwallbuilder","cheadlauncher",
				"chunterchopper","conair","csuborbital","cgunship","callygator",
				"paxcentrail","cgatefort","cnanorecon","chunter",	"cstrider","ccrabsynth", "chunter",
				"sentry","cbonker","crailgun","chopper",
				"jhivewulfmoma","jbeefeater","hc","zombie", "jantart","jatlantai","jhoneypot",
				"jglowworms","jbeherith","jeliah","jtiglil","jskinfantry",
				"jshroudshrike","jswiftspear", "jtigeggnogg","jskineggnogg","jghostdancer",
				"vort", "jantart",	"jviralfac", "jhoneypot","jfiredancer",
				"jhunter", "jvaryfoo",
				"jfireflower", "jdragongrass", "jbeehive", "jswamp", "jpoisonhive",	
				"ggluemine","jtree1", "jgalatea","jmotherofmercy","jsempresequoia","jrecycler","jresistancewarrior","jmadmax"
	}
		
	
	
	 function gadget:RecvLuaMsg(msg, playerID)
	 
		start,ends= string.find(msg,"DBG:PERFORMANCE:Start")
		if ends then
			boolStartTest = true
		end
	 end
	
	function performanceMeasurmentStart()
	end
	
	function performanceMeasurmentEnd()
	end
	
	function testUnitsPerformance(teamID,unitType, number, frame, CreatedT)
		local teamID = teamID
					-- take measurment
		performanceMeasurmentStart()
			
			-- take measurment
		if frame == START_FRAME then
			CreatedT={}
		--create Number
			for i=1, number do	
							x,z= et2DSquareFormationPosition(i, 42,32)
							CreatedT[#CreatedT+1] = Spring.CreateUnit(unitType, x,0 ,z, 1, teamID)

			end
			performanceMeasurmentEnd("Creation")
			return CreatedT, frame  + 1
		end

		--give orders to attack
		if frame == ATTACK_FRAME then
			for i=1, number do
				ox,oz= et2DSquareFormationPosition(i, 50,32)
				Spring.SetUnitMoveGoal(CreatedT[i],x+ ox ,0, z + oz)
				Command(id, "attack", { x =x +ox, y = 0, z = z+oz }, { "shift" })
				
			end
				performanceMeasurmentEnd("Attack")
				return CreatedT
		end
			
		--give orders to attack
		if frame == DESTRUCTION_FRAME then
			for i=1, number do
					Spring.DestroyUnit(CreatedT[i],true,true)
			end
				performanceMeasurmentEnd("Destruction")
				return CreatedT
		 end		
		
		
	end

	
	function gadget:GameFrame(n)	
		
	end
	


end