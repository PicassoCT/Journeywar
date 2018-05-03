function gadget:GetInfo()
    return {
        name = "JW_ScaleUpGadget::",
        desc = "Make mobile units grow and shrink",
        author = "zwzsg",
        date = "21st of March 2013",
        license = "Free, wishing for a benevolent dicatorship, cause instinctarded. To value luarulesdom, you got to be able to use it.", --Janus License- under Software Patent Nr. 23432-756F-11-2014 held by the FSF for commercial purposes, under GPL for non-commercial usage
        layer = 0,
        enabled = true
    }
end


if (gadgetHandler:IsSyncedCode()) then

    JBUILDANIM = "NOTYPE"
	 VFS.Include("scripts/lib_UnitScript.lua")
	 VFS.Include("scripts/lib_jw.lua")
    --all units that are buildings
    jBuilding = getJourneyBuildingTypeTable()

    DefTypeTable = {
        [UnitDefNames["jswiftspear"].id] =  0.002,
        [UnitDefNames["jbeherith"].id] = 0.001,
        [UnitDefNames["jsungodcattle"].id] = 0.0012,
        [UnitDefNames["cawilduniverseappears"].id] = 0.05,
        [UnitDefNames["ghohymen"].id] = 0.0005,
        [UnitDefNames["jvaryfoo"].id] = 0.001,
        [UnitDefNames["jspacebornembryo"].id] = 0,
        [UnitDefNames["gseastar"].id] = 0.005
    }

    jBuildAnimDefID = UnitDefNames["jbuildanim"].id
    SyncedDataTable = {} -- Table that contains some data about some units
    scaleTable = {}
    LastSetBuildAnim = {}
    jWorkInProgress = {}
    buildList = {}

    local spValidUnitID = Spring.ValidUnitID


    function gadget:UnitCreated(unitID, unitDefID, unitTeam)
        if DefTypeTable[unitDefID] then --unitDefID== UnitDefNames["tiglil"].id or unitDefID== UnitDefNames["skinfantry"].id or
            boolPulse = false
			pulseScale = 0
            StartScale = 0.06
			totalFrames = 0
            --	if unitDefID== UnitDefNames["tiglil"].id or unitDefID== UnitDefNames["skinfantry"].id then StartScale=0.52 end

            ScaleFactorProFrame = DefTypeTable[unitDefID] 
            ScaleUpLimit = 1

            if unitDefID == UnitDefNames["jspacebornembryo"].id then
                ScaleFactorProFrame = 0
                ScaleUpLimit = 1
                boolPulse = true
				pulseScale=0.25
            end

            if unitDefID == UnitDefNames["cawilduniverseappears"].id then
				ScaleUpLimit = 1.6
				pulseScale= 1.6
				totalFrames= 30 * 30
				boolPulse = true
            end

            if unitDefID == UnitDefNames["ghohymen"].id then
                StartScale = 0.12
                ScaleUpLimit = 2.14159
            end

            if unitDefID == UnitDefNames["jvaryfoo"].id then
                ScaleUpLimit = 1 + (math.random(1, 7) / 10)
            end

            scaleTable[unitID] = {
                scale = StartScale,
                factor = ScaleFactorProFrame,
                utype = unitDefID,
                uid = unitID,
                scaleLimit = ScaleUpLimit,
				
                pulse = boolPulse,
				frame= Spring.GetGameFrame(),
				amplitude = pulseScale, --
				pulseLengthInFrames = totalFrames
            }


            -- Here the chosen units will be all moving unit. Put your own filter obviously!
            -- The key is the unitID
            -- The value must be something else than false and nil

            SyncedDataTable[unitID] = { birth = Spring.GetGameFrame() }
            -- Here I put as value a table with the time of birth, but could be anything
        end
        --if journeybuild animation
        if jBuilding[unitDefID] then

            x, y, z = Spring.GetUnitPosition(unitID)
            GG.UnitsToSpawn:PushCreateUnit("jbuildanim", x, y, z + 4, 0, unitTeam)


            LastSetBuildAnim[#LastSetBuildAnim + 1] = { unitID = unitID, unitDefID = unitDefID, unitTeam = unitTeam, birth = Spring.GetGameFrame() }
        end

        if unitDefID == jBuildAnimDefID then
            buildList[unitID] = LastSetBuildAnim[#LastSetBuildAnim]
            table.remove(LastSetBuildAnim, #LastSetBuildAnim)
        end
    end

    function gadget:UnitDestroyed(unitID, unitDefID)
        -- Never forget to delete data about dead units!
        -- Or else your tables will slowly grow during game with huge amount of useless data!
        if SyncedDataTable[unitID] then
            --Spring.Echo("jw_ScaleUPGadget::", SyncedDataTable[unitID])
            SyncedDataTable[unitID] = nil
            SendToUnsynced("UnsetScale", unitID)
        end
    end

    --All units that do a constant scaling up
    local UnitsScalingUpConst = {
        [UnitDefNames["jswiftspear"].id] = true,
        [UnitDefNames["jbeherith"].id] = true,
        [UnitDefNames["jsungodcattle"].id] = true,
        [UnitDefNames["cawilduniverseappears"].id] = true,
        [UnitDefNames["ghohymen"].id] = true,
        [UnitDefNames["jspacebornembryo"].id] = true,
        [UnitDefNames["jvaryfoo"].id] = true
    }

    local VARYFOODEFID = UnitDefNames["jvaryfoo"].id
    local SUNGODCATTLEDEFID = UnitDefNames["jsungodcattle"].id
    local EMBRYODEFID = UnitDefNames["jspacebornembryo"].id
    local spGetUnitHealth = Spring.GetUnitHealth


    local function handleNewJourneyBuildings()
        if table.getn(buildList) > 0 then
            frame = Spring.GetGameFrame()

            for id, v in pairs(buildList) do
                if id then
                    guid = buildList[id].unitID
                    scale = 1 + 0.5 * math.sin((frame - v.birth) / 50)
                    SendToUnsynced("SetScale", id, scale)
                    scaleTable[id] = { scale = scale, utype = JBUILDANIM, uid = id, scaleLimit = 1 + math.random(10, 30) / 100, pulse = true }
                    Spring.SetUnitAlwaysVisible(id, false)
                    Spring.SetUnitNoSelect(id, true)
                    jWorkInProgress[id] = id

                    SyncedDataTable[id] = {}
                    SyncedDataTable[id] = { birth = buildList[id].unitID + frame }
                end
            end
            buildList = {}
        end
    end

    local function handleBuildAnims()

        ------------ -- BuildAnims	--------------------------------------------------------------------
        if #jWorkInProgress > 0 then
            for k, v in pairs(jWorkInProgress) do
                if v then
                    health, maxHealth, paralyzeDamage, captureProgress, buildProgress = spGetUnitHealth(k)
                    if buildProgress then
                        if buildProgress < 1 then
                            scaleTable[v] = {
                                scale = buildProgress + math.abs(math.sin((frame + 9000) / 100)),
                                utype = JBUILDANIM,
                                uid = v,
                                scaleLimit = 1 + math.random(10, 30) / 100
                            }

                        elseif buildProgress == 1 then
                            scaleTable[v] = nil
                        end
                    end
                end
            end

            for k, v in pairs(jWorkInProgress) do
                if v and Spring.GetUnitIsDead(v) == true then
                    jWorkInProgress[k] = nil
                end
            end
        end
        ----------------------------------------------------------------------------------------------------
    end

    local function setScaleTable()

        --PrepCycle
        for unitID, _ in pairs(scaleTable) do
            -- Here my scale is a sinusoid of time. So they grow and shrink smoothly and periodically
            -- Use your own formula obviously
		if scaleTable[unitID].boolPulse == false then 
            if UnitsScalingUpConst[scaleTable[unitID].utype] then
                temp = scaleTable[unitID].scale + scaleTable[unitID].factor
                scaleTable[unitID].scale = temp
            end
            --if it is a sungodcattle
            if scaleTable[unitID].utype == SUNGODCATTLEDEFID and scaleTable[unitID].scale >= math.random(87, 100) / 100 then scaleTable[unitID] = nil end

            if scaleTable[unitID] and scaleTable[unitID].utype == EMBRYODEFID then
                hp = spGetUnitHealth(unitID)
                if hp then
                    scaleTable[unitID].scale = math.max(0.01, hp / 100)
                else
                    scaleTable[unitID].scale = 0.01
                end
            end
		
		else
				 cosinusfactor=(((Spring.GetGameFrame() - scaleTable[unitID].frame))/scaleTable[unitID].pulseLengthInFrames)%2
				 scaleTable[unitID].scale = scaleTable[unitID].scaleLimit + 	 math.sin(cosinusfactor	 *math.pi) * scaleTable[unitID].amplitude		
		end
			
        end


        for unitID, _ in pairs(scaleTable) do
            -- Here my scale is a sinusoid of time. So they grow and shrink smoothly and periodically
            -- Use your own formula obviously
            -- You should not call it every frame, but only when you wish to change scale
            SendToUnsynced("SetScale", scaleTable[unitID].scale, scaleTable[unitID].uid)
            -- Well, I change it constantly, so call it every frame, but that's for a more visual example
        end

        --apply at least once
        for unitID, _ in pairs(scaleTable) do

            --ending clause
            if scaleTable[unitID] and scaleTable[unitID].scale >= scaleTable[unitID].scaleLimit and scaleTable[unitID].boolPulse == false then
                scaleTable[unitID] = nil
            end
            --end
        end
    end



    function gadget:GameFrame(frame)


        if frame > 0 and frame % 7 == 0 then

            handleNewJourneyBuildings()

            handleBuildAnims()

            setScaleTable()
        end
    end



else -- unsynced


    local UnsyncedScaleTable = {} -- Table that contains the scale of units to be scaled

    local function SetScale(callname, scale, unitID)
        UnsyncedScaleTable[unitID] = scale
        Spring.UnitRendering.SetUnitLuaDraw(unitID, true)
    end

    local function UnsetScale(callname, unitID)
        UnsyncedScaleTable[unitID] = nil
        Spring.UnitRendering.SetUnitLuaDraw(unitID, false)
    end

    function gadget:Initialize()


        -- This associate the messages with the functions
        -- So that when the synced sends a message "f" it calls the function f in unsynced
        gadgetHandler:AddSyncAction("SetScale", SetScale)
        gadgetHandler:AddSyncAction("UnsetScale", UnsetScale)
    end

    function gadget:DrawUnit(unitID)
        if UnsyncedScaleTable[unitID] then
            local scale = UnsyncedScaleTable[unitID]
            gl.Scale(scale, scale, scale)

            gl.UnitRaw(unitID, true)
        end
    end
end