
     
    function gadget:GetInfo()
    return {
    name = "Trample Tree Gadget ",
    desc = "Sampling and Trampling the Trees",
    author = "PicassoCT",
    date = "Oh, you wish, you had it with this file - but she got class and style",
    license = "GNU GPL, v2 its goes in all fields",
    layer = 0,
    enabled = false-- loaded by default?
    }
    end
     
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     
    -- synced only
	VFS.Include("scripts/lib_OS.lua" , nil, VFSMODE     )
	VFS.Include("scripts/lib_UnitScript.lua" , nil, VFSMODE     )
	VFS.Include("scripts/lib_Build.lua" , nil, VFSMODE	)
	VFS.Include("scripts/lib_jw.lua" , nil, VFSMODE	)
	

	
	trampleDefTable=getTypeTable(UnitDefNames,{"mdigg","jbeherith"})
	
	local UnitsToCheck={}
		
  if (gadgetHandler:IsSyncedCode()) then
			function gadget:UnitCreated(unitid,unitdefid,father)
				if trampleDefTable[unitdefid] then
				Spring.Echo("Trample Tree Gadget unit registrated")
				UnitsToCheck[#UnitsToCheck+1]=unitid
				end
			end
			
			local spValidUnitID=Spring.GetUnitIsDead
			
            function gadget:GameFrame(f)
				if f % 43 == 0 then
					TrampeledTrees={}
					
							for i=#UnitsToCheck,1, -1 do
								check=spValidUnitID(UnitsToCheck[i])
								if check and check ==false then
								
								env = Spring.UnitScript.GetScriptEnv(UnitsToCheck[i])
								
									if env then
									TrampeledTrees=TaddT(TrampeledTrees, env.TrampledTrees)
									Spring.Echo("TrampledTrees added")
									env.TrampeledTrees={}
									end
								
								else
								table.remove(UnitsToCheck,i)
								end
							end
							
							for i=1,#TrampledTrees do
							env=		 Spring.UnitScript.GetScriptEnv(TrampledTrees[i])
							Spring.Echo("Tree Trampled Preparation")
								if env and env.TreeTrample and spValidUnitID(TrampledTrees[i])== true then
									Spring.UnitScript.CallAsUnit(TrampledTrees[i], env.TreeTrample, 	true )
								else
								Spring.Echo("No Tree Trampled Function")								
								end
							end
				end
			end

end
	