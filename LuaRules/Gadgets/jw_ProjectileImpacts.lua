function gadget:GetInfo()
    return {
        name = "Projectiles",
        desc = "This gadget handles projectileimpacts",
        author = "",
        date = "Sep. 2008",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_OS.lua")
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_Build.lua")
    VFS.Include("scripts/lib_jw.lua")

    local UnitDamageFuncT = {}
    local StunnedUnitsTable = {}
	tangledTable = {}
    --1 unitid
    --2 counter
    --3 orgBuildSpeed
    --local stunTime=9
    --local selectRange=300
    --local totalTime=9000
    JPLANKTONER_AA_STUNTIME = 15000
    GHOSTLIFETIME = 450
    jEthiefStealingQuota = 5
    local HARDCODED_RETREATDISTANCE = 420
		tangledDisconnectDistance = 1024
	 --targetTypes	
	 FEATURE = 102
	 GROUND = 103
	 UNIT = 117
	 PROJECTILE = 112

	--Centrail Weapons
		cRestrictorThumperID = WeaponDefNames["crestrictorthumper"].id
		crabShelWDefID = WeaponDefNames["crabshell"].id
		cArtDarkMaterWDefID = WeaponDefNames["cartdarkmat"].id
		bunkerPlasmaDefID = WeaponDefNames["cbonkerfire"].id
		gVolcanoWeaponID = WeaponDefNames["lavabomb"].id
		cFlareGun = WeaponDefNames["flaregun"].id
		cmtwgrenade = WeaponDefNames["cmtwgrenade"].id
		lazarusDeviceDefID = WeaponDefNames["lazarusrocket"].id
		slicergunDefID = WeaponDefNames["slicergun"].id
		cCssFlameT = WeaponDefNames["cflamethrower"].id
		cUniverseGun = WeaponDefNames["cuniversegun"].id
		nukeLvl2WeaponDefID = WeaponDefNames["cnukegrenadelvl2"].id
		nukeLvl3WeaponDefID = WeaponDefNames["cnukegrenadelvl3"].id
		striderWeaponDefID = WeaponDefNames["warpcannon"].id
		highExLineGunDefID = WeaponDefNames["cexplochaingun"].id
		crazorgrenadeDefID = WeaponDefNames["crazorgrenade"].id
		celetrochainWeaponDefID = WeaponDefNames["celetrochain"].id
		ChainLightningDefID = WeaponDefNames["cchainlightning"].id
		chcprojectileDefID = WeaponDefNames["hcprojectile"].id
		cAllyGatorMarkerDefID = WeaponDefNames["callygatormarker"].id
		CEaterRocketDefID = WeaponDefNames["ceater"].id
		cHarvestRocketDefID = WeaponDefNames["charvest"].id
		cAntiMatterDefID = WeaponDefNames["cantimatter"].id
		csubOrbDefID = WeaponDefNames["csuborbitalstrike"].id
		catapultDefID = WeaponDefNames["ccatapult"].id
		cgaterailgunDefID = WeaponDefNames["cgaterailgun"].id
		cEfenceWeapondDefID = WeaponDefNames["cwefence1"].id
		tangleGunDefID = WeaponDefNames["ctanglegun"].id
	
	--Journeyweapon
		greenSeerWeaponDefID = WeaponDefNames["greenseer"].id
		jHiveHoundID = WeaponDefNames["jhivehoundrocket"].id
		jSwiftSpearID = WeaponDefNames["swiftprojectile"].id
		jSwiftMarkWeaponDefID = WeaponDefNames["jswiftrapemark"].id
		jghostDancerWeaponDefID = WeaponDefNames["jgdjump"].id
		jhunterDartDefID = WeaponDefNames["jdartgun"].id
		jvaryfoospearDefID = WeaponDefNames["varyfoospear"].id
		weaponDefIDjmotherofmercy = WeaponDefNames["jmomtractor"].id
		tiglilWeaponDefID = WeaponDefNames["tiglilclosecombat"].id
		jvaryjumpDefID = WeaponDefNames["jvaryjump"].id
		jgluegunDefID = WeaponDefNames["jgluegun"].id
		glueMineWeaponDefID = WeaponDefNames["gluemineweapon"].id
		poisonRaceDartDef = WeaponDefNames["jpoisondartw"].id
		jacidantsDefID = WeaponDefNames["jacidants"].id
		jeliahbeamDefID = WeaponDefNames["jeliahbeam"].id
		jethiefweaponDefID = WeaponDefNames["jethiefweapon"].id
		jethiefretweaponDefID = WeaponDefNames["jethiefretweapon"].id
		jplanktoneraaDefID = WeaponDefNames["jplanktoneraa"].id

    ChainLightningTable = {}
    local FireWeapons = {
        [gVolcanoWeaponID] = true,
        [bunkerPlasmaDefID] = true,
        [cCssFlameT] = true,
        [cFlareGun] = true
    }
    RazorGrenadeTable = {}
	

    Script.SetWatchWeapon(jacidantsDefID, true)
    Script.SetWatchWeapon(cEfenceWeapondDefID, true)
    Script.SetWatchWeapon(cgaterailgunDefID, true)
    Script.SetWatchWeapon(jeliahbeamDefID, true)
    Script.SetWatchWeapon(chcprojectileDefID, true)
    Script.SetWatchWeapon(cAntiMatterDefID, true)
    Script.SetWatchWeapon(catapultDefID, true)
    Script.SetWatchWeapon(cHarvestRocketDefID, true)
    Script.SetWatchWeapon(CEaterRocketDefID, true)
    Script.SetWatchWeapon(lazarusDeviceDefID, true)
    Script.SetWatchWeapon(ChainLightningDefID, true)
    Script.SetWatchWeapon(celetrochainWeaponDefID, true)
    Script.SetWatchWeapon(crazorgrenadeDefID, true)
    Script.SetWatchWeapon(jvaryjumpDefID, true)
    Script.SetWatchWeapon(striderWeaponDefID, true)
    Script.SetWatchWeapon(jethiefweaponDefID, true)
    Script.SetWatchWeapon(jethiefretweaponDefID, true)
    Script.SetWatchWeapon(tiglilWeaponDefID, true)
    Script.SetWatchWeapon(slicergunDefID, true)
    Script.SetWatchWeapon(weaponDefIDjmotherofmercy, true)
    Script.SetWatchWeapon(cFlareGun, true)
    Script.SetWatchWeapon(cUniverseGun, true)
    Script.SetWatchWeapon(cRestrictorThumperID, true)
    Script.SetWatchWeapon(cmtwgrenade, true)
    Script.SetWatchWeapon(jhunterDartDefID, true)
    Script.SetWatchWeapon(jHiveHoundID, true)
    Script.SetWatchWeapon(jSwiftSpearID, true)
    Script.SetWatchWeapon(jSwiftMarkWeaponDefID, true)
    Script.SetWatchWeapon(jghostDancerWeaponDefID, true)
    Script.SetWatchWeapon(crabShelWDefID, true)
    Script.SetWatchWeapon(cArtDarkMaterWDefID, true)
    Script.SetWatchWeapon(bunkerPlasmaDefID, true)
    Script.SetWatchWeapon(cCssFlameT, true)
    Script.SetWatchWeapon(gVolcanoWeaponID, true)
    Script.SetWatchWeapon(nukeLvl3WeaponDefID, true)
    Script.SetWatchWeapon(highExLineGunDefID, true)
    Script.SetWatchWeapon(jvaryfoospearDefID, true)
    Script.SetWatchWeapon(jgluegunDefID, true)
    Script.SetWatchWeapon(cAllyGatorMarkerDefID, true)
    Script.SetWatchWeapon(poisonRaceDartDef, true)
    Script.SetWatchWeapon(tangleGunDefID, true)
    Script.SetWatchWeapon(csubOrbDefID, true)
	
    --units To be exempted from instantly lethal force
    local lethalBuffExecption = getExemptFromLethalEffectsUnitTypeTable(UnitDefNames)
    local gaiaTeamID = Spring.GetGaiaTeamID()
    local skySraperDefID = UnitDefNames["buibaicity1"].id
    local cssDefID = UnitDefNames["css"].id
    local gvolcanoDefID = UnitDefNames["gvolcano"].id
	
--===========Explosion Functions ====================================================

airTypeTable= getAirUnitTypeTable()
abstractTypeTable= getAbstractTypes()
camproDefID = UnitDefNames["campro"].id

    function unitVannishAntimatterSFX(id)
			defID= Spring.GetUnitDefID(id)
			--if unit is abstract early out
			if abstractTypeTable[defID] or airTypeTable[defID] then return end
			-- if its a building damage it then early out
			if  defID == camproDefID then return end
	
			if UnitDefs[defID].isBuilding == true  then
				Spring.AddUnitDamage(id, 25)
				return
			end

			
        Spring.SetUnitNoSelect(id, true)
        tpiecesTable = getPiecePositionMap(id)

        for i = 1, table.getn(tpiecesTable) do
            spawnCegAtPiece(id, tpiecesTable[i].pid, "antimatter", 10)
            spawnCegAtPiece(id, tpiecesTable[i].pid, "bgantimatter", 10)
        end
        GG.UnitsToKill:PushKillUnit(id, true, true)

        size = 8
        if GG.DynDefMap == nil then GG.DynDefMap = {} end
        if GG.DynRefMap == nil then GG.DynRefMap = {} end
        GG.DynDefMap[#GG.DynDefMap + 1] = {creater ="campro", x = x / size, z = z / size, Size = size, blendType = "melt", filterType = "borderblur" }
        GG.DynRefMap[#GG.DynRefMap + 1] = prepareHalfSphereTable(size, -1)
    end

    function impulseAfterDelay(id, x, y, z)
        if Spring.GetUnitIsDead(id) == false then
            Spring.AddUnitImpulse(id, x, y, z)
        end
    end

    function ShockWaveRippleOutwards(x, z, force, speed, range)
        -- get all units in range
        if not GG.ShockWaves then GG.ShockWaves = {} end
        local OtherWaves = GG.ShockWaves
        assert(range)
        T = getAllInCircle(x, z, range)

        for i = 1, #T do
            ex, ey, ez = Spring.GetUnitPosition(T[i])

            dist = distance(x, z, ex, ez)
            const = force / dist

            if not OtherWaves[math.ceil(dist / speed)] then OtherWaves[math.ceil(dist / speed)] = {} end
            myT = { id = T[i], impulse = { x = 0, y = const, z = 0 } }
            table.insert(OtherWaves[math.ceil(dist / speed)], myT)
        end
        GG.ShockWaves = OtherWaves
    end

    slowlyAccidBurnsAway = function(evtID, frame, persPack, startFrame)

        --only apply if Unit is still alive
        if Spring.GetUnitIsDead(persPack.victimID) == true then
            return nil, persPack
        end

        if persPack.ImuneUnits then
            defID = Spring.GetUnitDefID(persPack.victimID)
            if persPack.ImuneUnits[defID] then
                return nil, persPack
            end
        end

        hp, maxHP = Spring.GetUnitHealth(persPack.victimID)
        if not hp then
            return nil, nil
        end

        if persPack.counter > persPack.counterMax then
            return nil, nil
        end


        toSetHp = hp - 10
        Spring.SetUnitHealth(persPack.victimID, toSetHp)

        return frame + 50, persPack
    end

    local explosionFunc = {
        [poisonRaceDartDef] = function(weaponDefID, px, py, pz, AttackerID)
            --Poison a Unit to 1 Health and recovers it

            poison = function(evtID, frame, persPack, startFrame)
                --Spring.Echo("EventStream Poisoned by active for"..persPack.victimID)
                --only apply if Unit is still alive
                if Spring.GetUnitIsDead(persPack.victimID) == true then
                    return nil, persPack
                end

                --filter out imune Units
                if persPack.ImuneUnits then
                    defID = Spring.GetUnitDefID(persPack.victimID)
                    if persPack.ImuneUnits[defID] then
                        return nil, persPack
                    end
                end
                healthOffSet = 0
                hp, maxHP = Spring.GetUnitHealth(persPack.victimID)
                if not hp then
                    return nil, nil
                end
                if persPack.lastSetHp and hp ~= persPack.lastSetHp then
                    healthOffSet = hp - persPack.lastSetHp
                end

                if persPack.boolNotFirstCall == nil then
                    persPack.boolNotFirstCall = true
                    persPack.factor = 1.01
                    persPack.orgHp = hp
                    persPack.lastSetHp = 1
                    Spring.SetUnitHealth(persPack.victimID, 1)
                else

                    toSetHp = persPack.orgHp * clamp(persPack.factor - 1, 0.01, 1)
                    persPack.lastSetHp = toSetHp + healthOffSet
                    Spring.SetUnitHealth(persPack.victimID, persPack.lastSetHp)
                end


                persPack.factor = persPack.factor * persPack.factor

                --Exit Clause
                if Spring.GetUnitHealth(persPack.victimID) >= persPack.orgHp then
                    return nil, persPack
                end

                return frame + 50, persPack
            end

            T = getAllInCircle(px, pz, 150)
            if T then
                process(T,
                    function(id)
                        if id ~= AttackerID then
                            persPack = { victimID = id, ImuneUnits = lethalBuffExecption }
                            GG.EventStream:CreateEvent(poison,
                                persPack,
                                Spring.GetGameFrame() + 1)
                        end
                    end)
            end
        end,
        [catapultDefID] = function(weaponDefID, px, py, pz, AttackerID)
            Spring.SpawnCEG("ccatapultexpl", px, py + 5, pz, 0, 1, 0, 10)
        end,
        [cArtDarkMaterWDefID] = function(weaponDefID, px, py, pz, AttackerID)
            if not GG.AddFire then GG.AddFire = {} end
        end,
        [lazarusDeviceDefID] = function(weaponDefID, px, py, pz, AttackerID)
            teamid = Spring.GetUnitTeam(AttackerID)
            oldComender = GG.ComEnders[teamID]
            GG.ComEnders[teamID] = Spring.CreateUnit(UnitDefNames["ccomender"].id, px, py, pz, 1, teamid)
            GG.LazarusDeviceActive[GG.ComEnders[teamID]] = GG.LazarusDeviceActive[oldComender] - 1
        end,
        [celetrochainWeaponDefID] = function(weaponDefID, px, py, pz, AttackerID)
            teamid = Spring.GetUnitTeam(AttackerID)
            T = Spring.GetUnitsInCylinder(px, pz, 350)
            ChainLightningTable[AttackerID] = 30

            for i = 1, 5 do
                Spring.SpawnCEG("cchainlightning", px, py + 25, pz, math.random(-1, 1), math.random(0.1, 1), math.random(-1, 1), 40)
            end

            if T then

                for i = 1, #T do
                    if Spring.ValidUnitID(T[i]) == true then
                        gx, gy, gz = Spring.GetUnitPosition(T[i])
                        v = makeVector(px - gx, py - gy, pz - gz)
                        v = normVector(v)
                        v = mulVector(v, -1)

                        local ChaingProjParams = {
                            pos = { px, py + 20, pz },
                            ["end"] = { gx, gy, gz },
                            speed = { v.x, v.y, v.z },
                            owner = AttackerID,
                            team = teamid,
                            spread = { math.random(-5, 5), math.random(-5, 5), math.random(-5, 5) },
                            ttl = 420,
                            error = { 0, 0, 0 },
                            maxRange = 600,
                            gravity = Game.gravity,
                            startAlpha = 1,
                            endAlpha = 1,
                            model = "emptyObjectIsEmpty.s3o",
                            cegTag = "cchainlightning"
                        }

                        projectileID = Spring.SpawnProjectile(ChainLightningDefID, ChaingProjParams)
                    end
                end
            else
                for i = 1, 3, 1 do

                    local ChaingProjParams = {
                        pos = { px, py + 20, pz },
                        ["end"] = { math.random(-150, 150), math.random(0, 150), math.random(-150, 150) },
                        speed = { v.x, v.y, v.z },
                        owner = AttackerID,
                        team = teamid,
                        spread = { math.random(-50, 50), math.random(-50, 50), math.random(-50, 50) },
                        ttl = 420,
                        tracking = true,
                        error = { 0, 0, 0 },
                        maxRange = 600,
                        gravity = Game.gravity,
                        startAlpha = 1,
                        endAlpha = 1,
                        model = "emptyObjectIsEmpty.s3o",
                        cegTag = "cchainlightning"
                    }

                    projectileID = Spring.SpawnProjectile(ChainLightningDefID, ChaingProjParams)
                end
            end
        end,
        [jgluegunDefID] = function(weaponDefID, px, py, pz, AttackerID)
            attackerTeam = Spring.GetUnitTeam(AttackerID)
            id = Spring.CreateUnit("ggluemine", px, py, pz, 1, attackerTeam)
            Spring.SetUnitBlocking(id, false)
        end,
        [crazorgrenadeDefID] = function(weaponDefID, px, py, pz, AttackerID)

            if not RazorGrenadeTable[AttackerID] then RazorGrenadeTable[AttackerID] = {} end

            RazorGrenadeTable[AttackerID] = validateUnitTable(RazorGrenadeTable[AttackerID])


            teamID = Spring.GetUnitTeam(AttackerID)
            ad = math.huge
            if #RazorGrenadeTable[AttackerID] > 5 then
                it = math.floor(math.random(1, 5))
                Spring.DestroyUnit(RazorGrenadeTable[AttackerID][it], true, true)
                RazorGrenadeTable[AttackerID][it] = Spring.CreateUnit("crazordrone", px, py, pz, 1, teamID)
                ad = RazorGrenadeTable[AttackerID][it]
            else
                RazorGrenadeTable[AttackerID][#RazorGrenadeTable[AttackerID] + 1] = Spring.CreateUnit("crazordrone", px, py, pz, 1, teamID)
                ad = RazorGrenadeTable[AttackerID][#RazorGrenadeTable[AttackerID]]
            end
            if ad and Spring.ValidUnitID(ad) == true then

                ed = Spring.GetUnitNearestEnemy(ad)
                if ed then
                    x, y, z = Spring.GetUnitPosition(ed)
                    Spring.SetUnitMoveGoal(ad, x, y, z)
                end
            end
        end,
        [jvaryjumpDefID] = function(weaponDefID, px, py, pz, AttackerID)
            if AttackerID then
                Spring.SetUnitPosition(AttackerID, px, py + 35, pz)
                env = Spring.UnitScriptEnv(AttackerID)
                if env then
                    Spring.UnitScript.CallAsUnit(AttackerID, env.setInTransit, false)
                end
            end
        end,
        [jvaryjumpDefID] = function(weaponDefID, px, py, pz, AttackerID)
            --gluteus maximus- ha that sounds funny
            if not GG.ProjectileOrigin then GG.ProjectileOrigin = {} end
            --wait a second thats my ass
            GG.ProjectileOrigin[AttackerID] = { boolHitGround = true }
            Spring.SetUnitPosition(AttackerID, px, py, pz)
        end,
        [striderWeaponDefID] = function(weaponDefID, px, py, pz, AttackerID)
            teamid = Spring.GetUnitTeam(AttackerID)
            ShockWaveRippleOutwards(px, pz, 150, 180, 90)
            Spring.SpawnCEG("factory_explosion", px, py + 10, pz, 0, 1, 0, 50)
        end,
        [jhunterDartDefID] = function(weaponDefID, px, py, pz, AttackerID)
            if not AttackerID or type(AttackerID) ~= "number" then return end
            udefID = Spring.GetUnitDefID(AttackerID)
            unitChoice = "jhunterdart"
            if udefID == UnitDefNames["chunter"].id then
                unitChoice = "chunterdart"
            end

            dartID = ""
				teamid=  gaiaTeamID
            if Spring.GetUnitIsDead(AttackerID) == false then
                teamid = Spring.GetUnitTeam(AttackerID) 
				end
                dartID = Spring.CreateUnit(unitChoice, px, py, pz, 1, teamid)
						if dartID then
							hx, hy, hz = Spring.GetUnitDirection(AttackerID)
							Spring.SetUnitDirection(dartID, hx, hy, hz)
							AttachUnitToPieceNearImpact(dartID, AttackerID, px, py, pz, 10)
						else
						    T = getAllInCircle(px, pz, 64)
							 T = removeUnitsOfTypeInT(T, UnitDefNames[unitChoice].id)
								process(T,
									function(id)
										Spring.AddUnitDamage(id, jHunterDartDamage)
									end)
							Spring.SpawnCEG("antimatter", px, py + 15, pz, 0, 1, 0, 50, 0)
						end
         
			
        end,
        [cmtwgrenade] = function(weaponDefID, px, py, pz, AttackerID)
            if Spring.ValidUnitID(AttackerID) == true then
                if Spring.GetUnitIsDead(AttackerID) == false then
                    teamid = Spring.GetUnitTeam(AttackerID)
                    Spring.CreateUnit("cmtwgrenade", px, py, pz, 1, teamid)
                else
                    Spring.CreateUnit("cmtwgrenade", px, py, pz, 1, gaiaTeamID)
                end
            end
        end,
        [cUniverseGun] = function(weaponDefID, px, py, pz, AttackerID)
            tid = Spring.CreateUnit("cawilduniverseappears", px, py, pz, 1, gaiaTeamID)
            Spring.SetUnitAlwaysVisible(tid, true)
        end,
        [weaponDefIDjmotherofmercy] = function(weaponDefID, px, py, pz, AttackerID)
            env = Spring.UnitScript.GetScriptEnv(AttackerID)
            if env then
                Spring.UnitScript.CallAsUnit(AttackerID, env.ripARock, px, py, pz)
            end
        end,
        [jSwiftSpearID] = function(weaponDefID, px, py, pz, AttackerID)
		
            if Spring.ValidUnitID(AttackerID) == true and Spring.GetUnitIsDead(AttackerID) == false then
				--spawn retreating string CEG
			
				Spring.SetUnitPosition(AttackerID, px, py, pz) 
			end
        end,
        [jacidantsDefID] = function(weaponDefID, px, py, pz, AttackerID)
            Spring.SpawnCEG("jantseverywhere", px, py + 10, pz, 0, 1, 0, 60)

            size = 16
            if GG.DynDefMap == nil then GG.DynDefMap = {} end
            if GG.DynRefMap == nil then GG.DynRefMap = {} end
            GG.DynDefMap[#GG.DynDefMap + 1] = { creator = "jacidants", x = px, z = pz, Size = size, blendType = "melt", filterType = "borderblur" }
            GG.DynRefMap[#GG.DynRefMap + 1] = prepareCupTable(size, -0.125, size / 3, 0.5)



            T = getAllInCircle(px, pz, 150)
            if T then
                process(T,
                    function(id)
                        if id ~= AttackerID then
                            persPack = { victimID = id, ImuneUnits = lethalBuffExecption, counter = 0, counterMax = 25 }
                            GG.EventStream:CreateEvent(slowlyAccidBurnsAway,
                                persPack,
                                Spring.GetGameFrame() + 1)
                        end
                    end)
            end

            return true
        end,
        [jHiveHoundID] = function(weaponDefID, px, py, pz, AttackerID)
            if Spring.ValidUnitID(AttackerID) == true then Spring.SetUnitPosition(AttackerID, px, py, pz) end
        end,
        [jghostDancerWeaponDefID] = function(weaponDefID, px, py, pz, AttackerID)
            if Spring.ValidUnitID(AttackerID) == true then Spring.SetUnitPosition(AttackerID, px, py, pz) end
        end,
        [crabShelWDefID] = function(weaponDefID, px, py, pz, AttackerID)
            ShockWaveRippleOutwards(px, pz, 150, 180, 90)
            Spring.CreateUnit("hc", px, py, pz, 1, gaiaTeamID)
        end,
        [nukeLvl2WeaponDefID] = function(weaponDefID, px, py, pz, AttackerID)
            Spring.CreateUnit("nukedecalfactory", px, py, pz, 0, gaiaTeamID)
            grenadeID = Spring.CreateUnit("ccomendernuke", px, py, pz, 0, gaiaTeamID)
            Spring.SetUnitNoSelect(grenadeID, true)
        end,
        [nukeLvl3WeaponDefID] = function(weaponDefID, px, py, pz, AttackerID)
            Spring.CreateUnit("nukedecalfactory", px, py, pz, 0, gaiaTeamID)
            grenadeID = Spring.CreateUnit("ccomendernukelvl3", px, py, pz, 0, gaiaTeamID)
            Spring.SetUnitNoSelect(grenadeID, true)
        end,
        [cgaterailgunDefID] = function(weaponDefID, px, py, pz, AttackerID)

            ateam = Spring.GetUnitTeam(AttackerID)
            id = Spring.CreateUnit("cgatefort", px, py, pz, 0, ateam)
            if not GG.FiringGateFotressTable then GG.FiringGateFotressTable = {} end
            if not GG.FiringGateFotressTable[ateam] then GG.FiringGateFotressTable[ateam] = {} end
            if not GG.FiringGateFotressTable[ateam][AttackerID] then GG.FiringGateFotressTable[ateam][AttackerID] = false end
            GG.FiringGateFotressTable[ateam][AttackerID] = false


            transferUnitStatusToUnit(AttackerID, id)
        end
    }

    function gadget:Explosion(weaponDefID, px, py, pz, AttackerID)

        if explosionFunc[weaponDefID] then explosionFunc[weaponDefID](weaponDefID, px, py, pz, AttackerID) end
        return true
    end
	
--===========UnitDamaged Functions ====================================================

    ghostShadowEffectedUnits = {}
    GG.exploAmmoBlowTable = {}
    local timeTillBlowUp = 3500
    local jShadowDefID = UnitDefNames["jshadow"].id

    HarvestRocketLoadTable = {}
    JeliahBeamAccu = {}
    JELIAHBEAMDAMAGEMULTIPLIERMAX = 24
    UnitDamageFuncT[jeliahbeamDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        if not JeliahBeamAccu[attackerID] or JeliahBeamAccu[attackerID].targetID ~= unitID then
            newTarget = { targetID = unitID, accu = 1.0 }
            JeliahBeamAccu[attackerID] = newTarget
        end

        JeliahBeamAccu[attackerID].accu = math.min((JeliahBeamAccu[attackerID].accu * 1.02), JELIAHBEAMDAMAGEMULTIPLIERMAX)
        Spring.AddUnitDamage(unitID, math.ceil(JeliahBeamAccu[attackerID].accu))
    end

    UnitDamageFuncT[cAntiMatterDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        if not lethalBuffExecption[unitDefID]  then
            unitVannishAntimatterSFX(unitID)
        end
    end

    UnitDamageFuncT[jHiveHoundID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		if attackerID ~= unitID and attackerTeam ~= unitTeam then
			env = Spring.UnitScript.GetScriptEnv(attackerID)
        if env then
            Spring.UnitScript.CallAsUnit(attackerID, env.takeABite, unitID)
        end	
      end	
	end
    UnitDamageFuncT[catapultDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

        health = Spring.GetUnitHealth(unitID)
        Spring.SetUnitHealth(unitID, { paralyze = health * 1.5 })
        Spring.SetUnitArmored(unitID, 3)
        Spring.AddUnitImpulse(unitID, math.random(-10, 10) , 0, math.random(-10, 10) )
    end

    UnitDamageFuncT[cHarvestRocketDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

        if HarvestRocketLoadTable[unitID] and HarvestRocketLoadTable[unitID][attackerID] then

            Spring.SetUnitResourcing(unitID, "umm", HarvestRocketLoadTable[unitID][attackerID].metal)
            Spring.SetUnitResourcing(unitID, "ume", HarvestRocketLoadTable[unitID][attackerID].energy)
            HarvestRocketLoadTable[unitID][attackerID] = nil
        end
        return 0
    end
	
    UnitDamageFuncT[tangleGunDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		if 	not tangledTable[attackerID] then tangledTable[attackerID]  = {} end 
		
	if 	distanceUnitToUnit(attackerID,tangledTable[attackerID].first) > tangledDisconnectDistance or
			table.getn(tangledTable[attackerID].others) > 5
		then 
			tangledTable[attackerID] = {first = unitID, others={}}
			
			cegEventStream = function (persPack)
			
				spawnCEGatUnit(unitID, "tangledceg", 0, 10, 0) 
				persPack.counter = persPack.counter + 1
				return Spring.GetUnitIsDead(unitID) and persPack.counter < persPack, persPack
			end
			
			createStreamEvent(unitID, cegEventStream, 15, {counter = 0})
		else		
			if not tangledTable[attackerID].others[unitID] then		
			tangledTable[attackerID].others[unitID] = true
			
			tangledEventStream = function(persPack)
				if persPack.counter > 25 or Spring.GetUnitIsDead(persPack.unitID)== true then 
					return false 
				end  
				if Spring.GetUnitIsDead(persPack.first) == true then Spring.DestroyUnit(persPack.unitID,true, true) end
				
				persPack.counter = persPack.counter + 1 

				transferUnitStatusToUnit(persPack.first, persPack.unitID)

				return true, persPack
			end
			
			createStreamEvent(unitID, tangledEventStream, 25, {
			first =tangledTable[attackerID].first, 
			counter = 0})
			end			

    end
	return 0
    end


    UnitDamageFuncT[cEfenceWeapondDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        spawnCEGatUnit(unitID, "cefencesplash", 0, 10, 0)
        spawnCEGatUnit(attackerID, "cefencesplash", 0, 10, 0)

        return damage
    end

    UnitDamageFuncT[cAllyGatorMarkerDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

        env = Spring.UnitScript.GetScriptEnv(attackerID)
        if env then

            Spring.UnitScript.CallAsUnit(attackerID, env.tagYourIt, unitID)
        end

        return 0
    end

    UnitDamageFuncT[CEaterRocketDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		
		if not attackerID or doesUnitExistAlive(attackerID) == false then
		    attackerID = Spring.GetUnitLastAttacker(unitID)
		end
		
		
		if not attackerID or doesUnitExistAlive(attackerID) == false then
		    return
		end
        metalRes, energyRes = UnitDefs[unitDefID].metalCost, UnitDefs[unitDefID].energyCost

        gx, gy, gz = Spring.GetUnitPosition(unitID)
        tx, ty, tz = Spring.GetUnitPosition(attackerID)
        ateamid = Spring.GetUnitTeam(attackerID)
        vx, vy, vz = Spring.GetUnitCollisionVolumeData(unitID)
        max = math.max(vx, math.max(vy, vz))

        v = makeVector(tx - gx, ty - gy, tz - gz)
        v = normVector(v)


        local HarvestRocketParams = {
            pos = { gx, gy + max, gz },
            ["end"] = { tx, ty + 10, tz },
            speed = { v.x, v.y + 2, v.z },
            owner = unitID,
            team = ateamid,
            spread = { math.random(-5, 5), math.random(-5, 5), math.random(-5, 5) },
            ttl = 420,
            error = { 0, 0, 0 },
            maxRange = 1200,
            gravity = Game.gravity,
            startAlpha = 1,
            endAlpha = 1,
            model = "cHarvestProj.s3o",
        }

        projectileID = Spring.SpawnProjectile(cHarvestRocketDefID, HarvestRocketParams)

        if projectileID then
            if not HarvestRocketLoadTable[attackerID] then HarvestRocketLoadTable[attackerID] = {} end
            HarvestRocketLoadTable[attackerID][unitID] = { metal = metalRes, energy = energyRes, vicID = projectileID }
        end
    end

    UnitDamageFuncT[greenSeerWeaponDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

        hitPoints, maxHP = Spring.GetUnitHealth(unitID)
        if hitPoints - damage <= 0 and maxHP > 450 then
            x, y, z = Spring.GetUnitPosition(unitID)
            Spring.DestroyUnit(unitID)
            Spring.CreateUnit("jtree1", x, y, z, 1, attackerTeam)
        end
    end

    UnitDamageFuncT[jvaryfoospearDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        --You Sir, have a living spear attached to your gluteus maximus
        --gluteus maximus- ha that sounds funny
        if not GG.ProjectileOrigin then GG.ProjectileOrigin = {} end
        --wait a second thats my ass
        GG.ProjectileOrigin[attackerID] = { boolHitGround = false, id = unitID, lastAttackedPiece = Spring.GetUnitLastAttackedPiece(unitID) }
        --AaaahaaAaaaaAaaaahahaAAAAaaaaaaah
    end
 
	UnitDamageFuncT[jSwiftMarkWeaponDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		env = Spring.UnitScript.GetScriptEnv(attackerID)
		if env then
		  Spring.UnitScript.CallAsUnit(attackerID, env.IfSomedayItMightHappenThatAVictimMustBeFound, unitID)
		end	
    end

    --perma speed reduction - glued to ground with lots of sucction, lacking any possible seduction
    UnitDamageFuncT[glueMineWeaponDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        if not GG.GluedForLife[unitID] then GG.GluedForLife[unitID] = 1000 end
        spawnCEGatUnit(unitID, "gluebuff", 0, 30, 0)
        GG.GluedForLife[unitID] = GG.GluedForLife[unitID] * 0.9
    end
    UnitDamageFuncT[jgluegunDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        if not GG.GluedForLife[unitID] then GG.GluedForLife[unitID] = 1000 end

        GG.GluedForLife[unitID] = GG.GluedForLife[unitID] * 0.9
    end

    UnitDamageFuncT[highExLineGunDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		addChainExplosion(unitID, damage, highExLineGunDefID, cegName, 5, 150,750 )
    end
	
	function addChainExplosion(unitID, damage, weaponDefID, cegName, NumberOfExplosions, delayMin, delayMax )
		if not GG.exploAmmoBlowTable[unitID] then 
			GG.exploAmmoBlowTable[unitID] = {number=0,id= unitID} 
		end
							Spring.Echo("jw_projectileimpacts::LineGun ChainExplosion:KickOff")
		GG.exploAmmoBlowTable[unitID].number = GG.exploAmmoBlowTable[unitID].number + NumberOfExplosions
		
		persPack = {startFrame = Spring.GetGameFrame()}
		for i=1,NumberOfExplosions do
			persPack[#persPack + 1] = math.random(delayMin, delayMax)
		end
		persPack.ListOfPieces=  getPieceTable(unitID)

		--Start Chain Explosion EventStream
            eventFunction = function(id, frame, persPack)
                nextFrame = frame + 1
                if persPack then
                    if persPack.unitID then
                        --check
				            boolDead = Spring.GetUnitIsDead(persPack.unitID)

                        if boolDead and boolDead == true then
                           return
                        end

                        if not persPack.startFrame then
                            persPack.startFrame = frame
                        end
								
								 if not  persPack[1] then 
									return 
								 end
									
                        if persPack.startFrame then
                            nextFrame = persPack.startFrame + persPack[1]
									 table.remove(persPack,1)
                        end
							val= math.random(1,#persPack.ListOfPieces)
							shakeUnitPieceRelative(persPack.unitID, persPack.ListOfPieces[val],math.random(-25,25),50 )
							spawnCegAtPiece(persPack.unitID,  persPack.ListOfPieces[val] ,"internalexplosion")
							Spring.AddUnitDamage(persPack.unitID, 15)
							Spring.PlaySoundFile("sounds/cPaxCentrail/LineGunExplosion.ogg",1.0)
							Spring.Echo("jw_projectileimpacts::LineGun ChainExplosion")
                    end
                end
                return nextFrame, persPack
            end

            GG.EventStream:CreateEvent(eventFunction, persPack, Spring.GetGameFrame() + 1)
	end
	
    --poisonedDart
    UnitDamageFuncT[tiglilWeaponDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

        if not GG.Poisoned then GG.Poisoned = {} end
        pval = 120000
        GG.Poisoned[unitID] = pval --time till poison wears off
    end

    --set the Unit
    UnitDamageFuncT[jplanktoneraaDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        --stun this unit
        hp = Spring.GetUnitHealth(unitID)
        if hp then
            Spring.SetUnitHealth(unitID, { paralyze = hp * JPLANKTONER_AA_STUNTIME })

            --moveControll
            Spring.MoveCtrl.Enable(unitID)

            eventFunction = function(id, frame, persPack)
                nextFrame = frame + 1
                if persPack then
                    if persPack.unitID then
                        --check
                        boolDead = Spring.GetUnitIsDead(persPack.unitID)

                        if boolDead and boolDead == true then
                            Spring.MoveCtrl.Disable(persPack.unitID)
                        end

                        if not persPack.startFrame then
                            persPack.startFrame = frame
                        end

                        if persPack.startFrame then
                            nextFrame = persPack.startFrame + JPLANKTONER_AA_STUNTIME
                        end

                        if frame >= nextFrame then
                            Spring.MoveCtrl.Disable(persPack.unitID)
                            return
                        end
                    end
                end
                return nextFrame, persPack
            end
            persPack = { unitID = unitID, totalTime = JPLANKTONER_AA_STUNTIME }
            GG.EventStream:CreateEvent(eventFunction, persPack, Spring.GetGameFrame() + 1)
        end
        return damage
    end

    --headcrab function - sets the headcrab where its victim was
    UnitDamageFuncT[chcprojectileDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        px, py, pz = Spring.GetUnitPosition(unitID)
        if px and attackerID and Spring.ValidUnitID(attackID) == true then
            Spring.SetUnitPosition(attackerID, px + 5, py, pz)
            Spring.SetUnitNoDraw(attackerID, true)
        end
        return damage
    end

    UnitDamageFuncT[slicergunDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        Spring.Echo("jw_projectileimpacts:: FieldScoooper HIt found")
        --only if the unit is hitsphere wise big enough
        hp, maxhp = Spring.GetUnitHealth(unitID)
        if hp / maxhp < 0.5 and maxhp > 300 then
				pieceID = getUnitBiggestPiece(unitID)
				side = getUnitSide(unitID)
				slicerColum = -1 
				if side == "centrail" then
					slicerColum = Spring.CreateUnit("cmeatcolumn", x, y, z, 1, unitTeam)
				else					
					slicerColum = Spring.CreateUnit("jmeatcolumn", x, y, z, 1, unitTeam)
				end
				Spring.UnitAttach(unitID, slicerColum, pieceID)          
				Spring.SetUnitNoSelect(slicerColum, true)
				if not GG.SlicerTable then GG.SlicerTable = {} end
				GG.SlicerTable[slicerColum] = unitID
			else
				rootPiece= Spring.GetUnitLastAttackedPiece(unitID)
				px, py ,pz = Spring.GetUnitPosition(unitID)
				ax, ay, az = Spring.GetUnitPosition(attackerID)
				if attackerID then
				
				func = function (persPack)
						unitRipAPieceOut(persPack.unitID, persPack.rootPiece, persPack.shootvec, 150, false)
					return true, persPack
				end
				persPack = { unitID = unitID, rootPiece = rootPiece, shootvec= {x = ax -px, y =ay-py, z= az-pz}}
				createStreamEvent(unitID, func, 3, persPack)
				
				
				end
			end
        end

    UnitDamageFuncT[jethiefweaponDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        --only if the unit is hitsphere wise big enough
        if unitID and attackerTeam then
            energy = Spring.GetTeamResources(attackerTeam, "energy")
            if energy and energy > jEthiefStealingQuota then
                Spring.UseUnitResource(unitID, "e", jEthiefStealingQuota)


                gx, gy, gz = Spring.GetUnitPosition(unitID)
                tx, ty, tz = Spring.GetUnitPosition(attackerID)
                ateamid = Spring.GetUnitTeam(attackerID)
                vx, vy, vz = Spring.GetUnitCollisionVolumeData(unitID)
                max = math.max(vx, math.max(vy, vz))

                v = makeVector(tx - gx, ty - gy, tz - gz)
                v = normVector(v)


                local HarvestRocketParams = {
                    pos = { gx, gy + max, gz },
                    ["end"] = { tx, ty + 10, tz },
                    speed = { v.x, v.y + 2, v.z },
                    owner = unitID,
                    team = ateamid,
                    target = attackerID,
                    spread = { math.random(-5, 5), math.random(-5, 5), math.random(-5, 5) },
                    ttl = 420,
                    error = { 0, 0, 0 },
                    maxRange = 1200,
                    gravity = Game.gravity,
                    startAlpha = 1,
                    endAlpha = 1,
                    model = "jGlowProj.s3o",
                    cegTag = "jglowstrip",
                }
                projectileID = Spring.SpawnProjectile(jethiefretweaponDefID, HarvestRocketParams)
                if projectileID then
                    Spring.SetProjectileTarget(attackerID, "u")
                end
            end
        end
    end

    UnitDamageFuncT[jethiefretweaponDefID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        --only if the unit is hitsphere wise big enough
        if unitID and attackerTeam then
            energy = Spring.GetTeamResources(attackerTeam, "energy")
            if energy and energy > jEthiefStealingQuota then
                Spring.AddUnitResource(unitID, "e", jEthiefStealingQuota)
            end
        end
    end

    --restrictor

    UnitDamageFuncT[cRestrictorThumperID] = function(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        if weaponDefID == cRestrictorThumperID and Spring.ValidUnitID(attackerID) == true then

            if UnitDefs[unitDefID].isBuilding == true then
                health = Spring.GetUnitHealth(unitID)
                Spring.SetUnitHealth(unitID, { paralyze = health * 15 })
            elseif UnitDefNames["jbugcreeper"].id == unitDefID or UnitDefNames["jcrabcreeper"].id == unitDefID or UnitDefNames["jhoneypot"].id == unitDefID then
                --Send To Distance
                ax, ay, az = Spring.GetUnitPosition(attackerID)
                ux, uy, uz = Spring.GetUnitPosition(unitID)
                ux, uz = ax - ux, az - uz
                max = math.max(math.abs(ux), math.abs(uz))
                ux, uz = ux / max, uz / max
                ux, uz = ((ux + uz) / ux) * HARDCODED_RETREATDISTANCE, ((ux + uz) / uz) * HARDCODED_RETREATDISTANCE
                Spring.SetUnitMoveGoal(unitID, ux + ax, uy, uz + az)
            end
        end
    end



	BuildingTypeTable = getAllBuildingTypes()
    function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)

        --chain Lightning
        if weaponDefID == ChainLightningDefID and attackerID then
            if not ChainLightningTable[attackerID] then ChainLightningTable[attackerID] = 30 end


            ChainLightningTable[attackerID] = ChainLightningTable[attackerID] - 1
            x, y, z = Spring.GetUnitPosition(unitID)
            ed, ad = Spring.GetUnitNearestEnemy(unitID), Spring.GetUnitNearestAlly(unitID)

            distEnemy, ex, ey, ez = distanceUnitToPoint(ed, x, y, z)
            distAlly, ax, ay, az = distanceUnitToPoint(ad, x, y, z)

            targetID = 0
            if distEnemy > distAlly then
                targetID = ad
                gx, gy, gz = ax, ay, az
            else
                targetID = ed
                gx, gy, gz = ex, ey, ez
            end

            vx, vy, vz = Spring.GetUnitCollisionVolumeData(unitID)
            max = math.max(vx, math.max(vy, vz))


            teamid = Spring.GetUnitTeam(attackerID)
            local ChaingProjParams = {
                pos = { x, y + max + 10, z },
                speed = { 0, math.random(1, 3), 0 },
                ["end"] = { gx, gy, gz },
                owner = attackerID,
                team = teamid,
                spread = { math.random(-5, 5), math.random(-5, 5), math.random(-5, 5) },
                ttl = 420,
                maxRange = 600,
                gravity = Game.gravity,
                startAlpha = 1,
                tracking = true,
                endAlpha = 1,
                model = "emptyObjectIsEmpty.s3o",
                cegTag = "cchainlightning"
            }

            projectileID = Spring.SpawnProjectile(ChainLightningDefID, ChaingProjParams)

        elseif ChainLightningTable[attackerID] and ChainLightningTable[attackerID] <= 0 then
            ChainLightningTable[attackerID] = nil
        end

        if UnitDamageFuncT[weaponDefID] then
            resultDamage = UnitDamageFuncT[weaponDefID](unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
            if resultDamage then return resultDamage end
        end

        --cBonkerPlasmaWeapon + FireWeapons
        if FireWeapons[weaponDefID] and unitDefID ~= cssDefID then
            setUnitOnFire(unitID, math.random(190, 1500))
        end

        --skySraper is damagedCase
        if skySraperDefID == unitDefID then
            env = Spring.UnitScript.GetScriptEnv(unitID)
            if env then
                Spring.UnitScript.CallAsUnit(unitID, env.nothingEverHappend, attackerTeam)
            end
        end
        --jShadow is hit
        if unitDefID == jShadowDefID and not lethalBuffExecption[attackerDefID] and attackerTeam ~= unitTeam and type(attackerID) == "number" then

            boolUnitIsDead = Spring.GetUnitIsDead(attackerID)
            boolUnitIsBuilding = (BuildingTypeTable[attackerDefID]  ~= nil)
            if boolUnitIsDead == false and boolUnitIsBuilding == false then

                offx, offz = math.random(-25, 25), math.random(-25, 25)
                px, py, pz = Spring.GetUnitPosition(attackerID)
                Spring.SetUnitMoveGoal(attackerID, px + offx, py, pz + offz)

                rotateUnitAroundUnit(unitID, attackerID, 180)

                setSpeedEnv(attackerID, 0.05)

                action = function(evtID, frame, persPack)
                    if frame >= persPack.startFrame then
                        if Spring.GetUnitIsDead(persPack.unitID) == false then
                            setSpeedEnv(persPack.unitID, 1)
                        end
                        return nil, persPack
                    else
                        return persPack.startFrame, persPack
                    end
                end

                persPack = { unitID = attackerID, startFrame = Spring.GetGameFrame() + GHOSTLIFETIME }

                GG.EventStream:CreateEvent(action,
                    persPack,
                    Spring.GetGameFrame() + 1)
            end
        end
    end

--===========Projectile Persistence Functions ====================================================
	
	watchedProjectilesTable={
	[cAntiMatterDefID] = function (projectileID)
			proOwnerID = Spring.GetProjectileOwnerID (projectileID)
			x,y,z = Spring.GetProjectilePosition(projectileID)
			if x then
			
				T= getAllInCircle(x,z, 25)
				process(T,
				function(id)
				defID = Spring.GetUnitDefID(id)
					if not lethalBuffExecption[defID] and defID ~= camproDefID then
						unitVannishAntimatterSFX(id)
					end				
				end
				)				
				return projectileID
			else
				return nil
			end
		end	
	}
	
	deathWatchProjectileList={}
	watchedOnDeathProjectiles={
	[csubOrbDefID] =  function (proID)
				tx, ty, tz = Spring.GetProjectilePosition(proID)
				ownerID = Spring.GetProjectileOwnerID (proID)
				
				if Spring.GetUnitIsDead(ownerID)==true then return end
				
				     teamid = Spring.GetUnitTeam(ownerID)
                ox, oy, oz = Spring.GetUnitPosition(ownerID)

                vx, vz = ox - tx, oz - tz
                head = math.atan2(vx, vz)
                norm = math.sqrt(vx * vx  + vz * vz)

                oz = vx / norm
					  ox = -1 * (vz / norm) 
				
				for i=1, 3 do 

                id = Spring.CreateUnit("csuborbexplo", tx + ox* i* 80 *-1^i , ty, tz +oz* i* 80*-1^i, 0, teamid)
                Spring.SetUnitRotation(id, 0, head, 0)
                Spring.SetUnitAlwaysVisible(id, true)
				end
			end
	
	}
	
	constantWatchedProjectiles = {}
	constantWatchedProjectilesCounter=0
	
	function constantWatchProjectile(frame)
	if constantWatchedProjectilesCounter == 0 then return end
	
		for proID, data in pairs(constantWatchedProjectiles) do 
		projectileID = watchedProjectilesTable[data.weaponDefID](proID, data.proOwnerID)
			if not projectileID then 
				constantWatchedProjectiles[proID] = nil
				constantWatchedProjectilesCounter= dec(constantWatchedProjectilesCounter)
			end
		end
	end
	
	function gadget:ProjectileCreated(proID, proOwnerID, projWeaponDefID)

		if not projWeaponDefID then
			projWeaponDefID = Spring.GetProjectileDefID(proID)
		end
		
		if jvaryjumpDefID == projWeaponDefID then
			if GG.AddCodeByType and GG.AddCodeByType[projWeaponDefID] then 
				GG.AddCodeByType[projWeaponDefID](proID, proOwnerID)
			end
		end
		
		if watchedOnDeathProjectiles[projWeaponDefID] then
					echo("Suboribtal Projectile fired")
			deathWatchProjectileList[proID]= projWeaponDefID
		end
		
		if watchedProjectilesTable[projWeaponDefID] then
			constantWatchedProjectiles[proID] = {proOwnerID = proOwnerID, weaponDefID= projWeaponDefID}
			constantWatchedProjectilesCounter = inc(constantWatchedProjectilesCounter)
		end
	end
		
	function gadget:ProjectileDestroyed(proID, proOwnerID)

		if constantWatchedProjectiles[proID] then
			constantWatchedProjectiles[proID]  = nil
			constantWatchedProjectilesCounter= dec(constantWatchedProjectilesCounter)
		end

		if deathWatchProjectileList[proID] then
				echo("Suboribtal Projectile consumed")
				projWeaponDefID = Spring.GetProjectileDefID(proID)
				watchedOnDeathProjectiles[projWeaponDefID](proID)
				deathWatchProjectileList[proID] = nil
		end
		
		
	end

    local everyNthFrame = 30
    local poisonDamage = 15
    function gadget:GameFrame(frame)

        if frame % 5 == 0 and GG.ShockWaves then
            local ShockW = GG.ShockWaves
            for i = 1, #ShockW do
                if i - 5 < 0 and ShockW[i] then
                    for k, v in pairs(ShockW[i]) do
                        impulseAfterDelay(v.id, v.impulse.x, v.impulse.y, v.impulse.z)
                    end
                    ShockW[i] = nil
                else
                    ShockW[i - 5] = ShockW[i]
                end

                GG.ShockWaves = ShockW
            end
        end
		if frame % 3 == 0 then
			constantWatchProjectile(frame)
		end
		
        if frame % everyNthFrame == 0 then
            --handling the Poison Darted
			poisonDarted(frame)
                -- handling explosive Ammo
            end
      
    end
	
	
	function poisonDarted(frame)
		if GG.Poisoned then
			for k, v in pairs(GG.Poisoned) do
				GG.Poisoned[k] = GG.Poisoned[k] - everyNthFrame
				uh = Spring.GetUnitHealth(k)
				if uh then
					Spring.SetUnitHealth(k, uh - poisonDamage)
				end
			end
	
			for k, v in pairs(GG.Poisoned) do
				if v < 0 then
					table.remove(GG.Poisoned, k)
				end
			end
		end		
	end
	
    local TableOfAllreadySearchedComender = {}
    function GetWeaponDirection(attackerID)
        if TableOfAllreadySearchedComender[attackerID] then
            return Spring.GetUnitPieceDirection(attackerID, TableOfAllreadySearchedComender[attackerID])
        else
            PieceMap = Spring.GetUnitPieceList(attackerID)
            TableOfAllreadySearchedComender[attackerID] = PieceMap["sniper"]
            return getWeaponDirection(attackerID)
        end
    end

    function blowItUp(unitID)
        stillAlive = Spring.ValidUnitID(unitID)
        if stillAlive and stillAlive == true then
            --explosion
			pieceMap = Spring.GetUnitPieceMap(unitID)
			piece = randDict(pieceMap)
            if ux then
                _, _, _, x, y, z = Spring.GetUnitPiecePosDir(unitID, piece)
                Spring.SpawnCEG("chiexploammo", x + math.random(-5, 5), y + 10, z + math.random(-5, 5), 0, 1, 0, 50)
                Spring.PlaySoundFile("sounds/cweapons/HiEx.ogg", 1)
                --directionalShove
                v = {}
                r = {}
                v.x, v.y, v.z = x - ux, y - uy, z - uz
                v = normVector(v)
                v = vMul(v, 900) --power

                -- crossproduct = (vectordamage x v ) -> Transfer to local coordsystem hitpiece origin vector
                r.x, r.y, r.z = 0, math.rad(math.random(-5, 5)), 0
                Spring.SetUnitRotation(unitID, r.x, r.y, r.z)
                Spring.AddUnitImpulse(unitID, v.x, v.y, v.z)

                T = getAllInCircle(ux, uz, 120, unitID)
				T = randFairT(T, 1, 3)
				
                --SplashDamage
                process(T,
                    function(id) 
					Spring.AddUnitDamage(id, 75) 
					end)
					
                Spring.AddUnitDamage(unitID, 10)
 
            else
                return false
            end
            return true
        end
    end
	
	function getTargetTable(proID)
			local targetTable = {}
			local targetTypeInt, target = Spring.GetProjectileTarget(proID)
			if targetTypeInt == string.byte('g') then --target is position on ground
				targetTable = { targetType = targetTypeInt, targetX = target[1], targetY = target[2], targetZ = target[3], }
			else --target is unit,feature or projectile
				targetTable = { targetType = targetTypeInt, targetID = target, }
			end
			return targetTable
		end
		
	function getProjectileTargetXYZ(proID)
        targetTypeInt, target = Spring.GetProjectileTarget(proID)

        if targetTypeInt == GROUND then
				echo("ProjectileTarget:",target[1], target[2], target[3])
            return target[1], target[2], target[3]
        end
        if targetTypeInt == UNIT then
				ux,uy,uz = Spring.GetUnitPosition(target)
            return ux,uy,uz
        end
        if targetTypeInt == FEATURE then
				fx,fy,fz = Spring.GetFeaturePosition(target)
            return fx, fy, fz
        end
        if targetTypeInt == PROJECTILE then
			px,py,pz = Spring.GetProjectilePosition(target)
            return px,py,pz
        end
    end

end